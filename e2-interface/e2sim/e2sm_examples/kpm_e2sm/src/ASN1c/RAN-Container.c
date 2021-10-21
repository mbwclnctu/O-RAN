/*
 * Generated by asn1c-0.9.29 (http://lionet.info/asn1c)
 * From ASN.1 module "E2SM-KPM-IEs"
 * 	found in "/home/rshacham/e2sm-kpm-v01.02.asn"
 * 	`asn1c -fcompound-names`
 */

#include "RAN-Container.h"

static asn_oer_constraints_t asn_OER_type_reportContainer_constr_3 CC_NOTUSED = {
	{ 0, 0 },
	-1};
static asn_per_constraints_t asn_PER_type_reportContainer_constr_3 CC_NOTUSED = {
	{ APC_CONSTRAINED | APC_EXTENSIBLE,  2,  2,  0,  2 }	/* (0..2,...) */,
	{ APC_UNCONSTRAINED,	-1, -1,  0,  0 },
	0, 0	/* No PER value map */
};
static asn_TYPE_member_t asn_MBR_reportContainer_3[] = {
	{ ATF_NOFLAGS, 0, offsetof(struct RAN_Container__reportContainer, choice.oDU_UE),
		(ASN_TAG_CLASS_CONTEXT | (0 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_DU_Usage_Report_Per_UE,
		0,
		{ 0, 0, 0 },
		0, 0, /* No default value */
		"oDU-UE"
		},
	{ ATF_NOFLAGS, 0, offsetof(struct RAN_Container__reportContainer, choice.oCU_CP_UE),
		(ASN_TAG_CLASS_CONTEXT | (1 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_CU_CP_Usage_Report_Per_UE,
		0,
		{ 0, 0, 0 },
		0, 0, /* No default value */
		"oCU-CP-UE"
		},
	{ ATF_NOFLAGS, 0, offsetof(struct RAN_Container__reportContainer, choice.oCU_UP_UE),
		(ASN_TAG_CLASS_CONTEXT | (2 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_CU_UP_Usage_Report_Per_UE,
		0,
		{ 0, 0, 0 },
		0, 0, /* No default value */
		"oCU-UP-UE"
		},
};
static const asn_TYPE_tag2member_t asn_MAP_reportContainer_tag2el_3[] = {
    { (ASN_TAG_CLASS_CONTEXT | (0 << 2)), 0, 0, 0 }, /* oDU-UE */
    { (ASN_TAG_CLASS_CONTEXT | (1 << 2)), 1, 0, 0 }, /* oCU-CP-UE */
    { (ASN_TAG_CLASS_CONTEXT | (2 << 2)), 2, 0, 0 } /* oCU-UP-UE */
};
static asn_CHOICE_specifics_t asn_SPC_reportContainer_specs_3 = {
	sizeof(struct RAN_Container__reportContainer),
	offsetof(struct RAN_Container__reportContainer, _asn_ctx),
	offsetof(struct RAN_Container__reportContainer, present),
	sizeof(((struct RAN_Container__reportContainer *)0)->present),
	asn_MAP_reportContainer_tag2el_3,
	3,	/* Count of tags in the map */
	0, 0,
	3	/* Extensions start */
};
static /* Use -fall-defs-global to expose */
asn_TYPE_descriptor_t asn_DEF_reportContainer_3 = {
	"reportContainer",
	"reportContainer",
	&asn_OP_CHOICE,
	0,	/* No effective tags (pointer) */
	0,	/* No effective tags (count) */
	0,	/* No tags (pointer) */
	0,	/* No tags (count) */
	{ &asn_OER_type_reportContainer_constr_3, &asn_PER_type_reportContainer_constr_3, CHOICE_constraint },
	asn_MBR_reportContainer_3,
	3,	/* Elements count */
	&asn_SPC_reportContainer_specs_3	/* Additional specs */
};

asn_TYPE_member_t asn_MBR_RAN_Container_1[] = {
	{ ATF_NOFLAGS, 0, offsetof(struct RAN_Container, timestamp),
		(ASN_TAG_CLASS_CONTEXT | (0 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_Timestamp,
		0,
		{ 0, 0, 0 },
		0, 0, /* No default value */
		"timestamp"
		},
	{ ATF_NOFLAGS, 0, offsetof(struct RAN_Container, reportContainer),
		(ASN_TAG_CLASS_CONTEXT | (1 << 2)),
		+1,	/* EXPLICIT tag at current level */
		&asn_DEF_reportContainer_3,
		0,
		{ 0, 0, 0 },
		0, 0, /* No default value */
		"reportContainer"
		},
};
static const ber_tlv_tag_t asn_DEF_RAN_Container_tags_1[] = {
	(ASN_TAG_CLASS_UNIVERSAL | (16 << 2))
};
static const asn_TYPE_tag2member_t asn_MAP_RAN_Container_tag2el_1[] = {
    { (ASN_TAG_CLASS_CONTEXT | (0 << 2)), 0, 0, 0 }, /* timestamp */
    { (ASN_TAG_CLASS_CONTEXT | (1 << 2)), 1, 0, 0 } /* reportContainer */
};
asn_SEQUENCE_specifics_t asn_SPC_RAN_Container_specs_1 = {
	sizeof(struct RAN_Container),
	offsetof(struct RAN_Container, _asn_ctx),
	asn_MAP_RAN_Container_tag2el_1,
	2,	/* Count of tags in the map */
	0, 0, 0,	/* Optional elements (not needed) */
	2,	/* First extension addition */
};
asn_TYPE_descriptor_t asn_DEF_RAN_Container = {
	"RAN-Container",
	"RAN-Container",
	&asn_OP_SEQUENCE,
	asn_DEF_RAN_Container_tags_1,
	sizeof(asn_DEF_RAN_Container_tags_1)
		/sizeof(asn_DEF_RAN_Container_tags_1[0]), /* 1 */
	asn_DEF_RAN_Container_tags_1,	/* Same as above */
	sizeof(asn_DEF_RAN_Container_tags_1)
		/sizeof(asn_DEF_RAN_Container_tags_1[0]), /* 1 */
	{ 0, 0, SEQUENCE_constraint },
	asn_MBR_RAN_Container_1,
	2,	/* Elements count */
	&asn_SPC_RAN_Container_specs_1	/* Additional specs */
};

