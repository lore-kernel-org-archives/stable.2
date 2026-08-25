Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803B625
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701677; cv=fail; b=LNyoRiaqOe2rLar58bQkNhU/6VcD9Q4nNQjP5qzuYTtTGbCwCHdGf+HZiLBzlgobr2ifRqjYNLwpL1qIX4FjvjtKmsn7JFMB4ZI6Olo3jUKfANQmSx/vtTiwYplE4aCu6HgPLmAegzT228JNN57/xvSR821JFe7u53HWIEFbpAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701677; c=relaxed/simple;
	bh=tW/3PE7O2FfDZtColMrrpWnkBJfWezOy72wCINrugJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtQE3tN2mp+ymjNo6h3lcivk/KAYa1oOu1hG2WOodB8Zbymbc2dPZWuFLZZg8utQhgB+i2+L+rpL6SXK+R/PZCmsCzZRgGRPxJS+M7oXgJCrw0MzR9nFYFdSDdSp0DPelPFskyUCa3ISydSfLduPbsQxT+eiHkc+9KrIzmJ6pCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISFfY1O2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISFfY1O2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787701676; x=1819237676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tW/3PE7O2FfDZtColMrrpWnkBJfWezOy72wCINrugJk=;
  b=ISFfY1O2FzbS18aB2fFNurn5XhV048GLGMTxUIdznWehfTZzbzJ4Zpl9
   fxz/e8GyRj5Rv95zCt1rsvkRsz3QIkYGg7bRFaEKMyCeK9C3w36o7Pl7+
   q0DdeKw2Xcj7KnOPltZNDTUlH+bp0NAq5+flpU+V88lfeby0QlZlwqnp4
   stMsvc3qt2/fojYknTRc0pQ2RVUYWxTYv3pMw1NxEFiZa2E6SBz/obEwe
   7iScIgW5z5trEi35m0G+Nx6Dhd1pu5ImY5hczMSzHhTwtRillZTdusRL1
   +4CFWrMk3ZIdBOCEdFbnFqMugntcyjs5/9hVzcIvm6G3DPJg37M+8NLZ8
   w==;
X-CSE-ConnectionGUID: NfoMHYd8Q3eEbnTQGWeQtA==
X-CSE-MsgGUID: pVETXRwHRfuVW02wdio6/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="98852269"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="98852269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:47:54 -0700
X-CSE-ConnectionGUID: EWA/0G7XTRa+mj8ZEjJ4WQ==
X-CSE-MsgGUID: 9D83cp+ARZyikyGPhO0BXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="297328463"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:47:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 16:47:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 16:47:54 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 16:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBJ6B9RHsOEVHl7YbFRkoSHpOUY9JwrsaMrq1L4rcDKcCFyo5EQDQMfV0c8qEQ7PgO/i3GUk493+Zfs706WqwJGGmtzOH/QdobKMoZi2jnUPC6ET34avPuzjV3WsMHOtRvecyfbFxPN63gNhahSPVQQWufRbDEtRjVjNICHeLcydSqeoRY4jqNpB2rS08DEpMQc+CTwyiLvF3J8xTBIU04JueAjh9TD7Mmh2belK/JHTDz59Rs/fSEenQ/CYvV1RRLXsQrw+wJaxDlIISZiJRii5wzSWlJYwkbVPUoh0HybHnBSDBBvgIZmK4pjgXkINmkTOX2N4UlKb3I7Yh7cskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW/3PE7O2FfDZtColMrrpWnkBJfWezOy72wCINrugJk=;
 b=qBnltRf+o301m17OYe5uKBMOZ6bzAVRaMcv0g46s2PhcXVTOJGyak5zeilBTPBEpojWEjhh6CkT+whoHIT3x4mOXAGHhy7AGALiuZWTPpk2VyH5iy6FtqK06T20pJL9iCCUgNeuXiowR3BVC9x6Vn0MWYkX829YLRoKz7qSyu8e5LcflTtF/LfIkW+VYmS/iCq9U3Cb5rnuFhP6oC2TvFSs27umsrLN+D6VvOIrxCualkwHtcVjBRsNSk2HVC8aCrvTdAE3yPM2TV0x9vgtHI5HIAZXvNCv+j+oAU3vx/rZU7kTEfRiYg+lKq85Toz7Q1QhCVwUX/3H/jXQeteWxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by LV1PR11MB8817.namprd11.prod.outlook.com (2603:10b6:408:2b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Tue, 25 Aug
 2026 23:47:45 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 23:47:44 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Topic: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Index: AQHdNEOsiSEBcNzQHky6KoIO5zqwNraub0OAgAD4pLCAAAalEA==
Date: Tue, 25 Aug 2026 23:47:44 +0000
Message-ID: <PH8PR11MB80401D0A2E76B99C8B135232F4AF2@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <2026082037-mutual-coroner-efeb@gregkh>
 <20260825034113.642528-1-jia.yao@intel.com>
 <2026082537-porridge-banish-b3bc@gregkh>
 <PH8PR11MB80406B2B95B6FEC3ABCD4702F4AF2@PH8PR11MB8040.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB80406B2B95B6FEC3ABCD4702F4AF2@PH8PR11MB8040.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|LV1PR11MB8817:EE_
x-ms-office365-filtering-correlation-id: 4cb37041-39dc-479d-b0df-08df030342ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|42112799006|23010399003|1800799024|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: oNyrDgsXxMyz39aR8BNXT6tHEO5yBxrE5PG4rYf/bA1VPgVLaqAiWZ5AvcuJAaGTjj06yoGnbnWl3dKO7PDVYuQIJMC4k1mIcmlTL1ixE4XcOYbrBVBLBBr3Hd2aNxxHBHARVR6RTzrEQzJ+cKXI/UASwSuWku0tOnq6Z1d4EImHvALAnIYnt6GiBYlWd7u/FRcQfWBDQDCadrhxY3JO7r4giBKFZAmV0zjE1r+fW7NJt5TOosw1D+1GWaa51O7r7YUNCNdDtDsURIr2bPWnHMspjRLYTYOwk7KXo8CmD8n7LfEJHRR+uJEcq5075PshBSOb9DkRFtBnDR+oJ2pZGhBM+EEGc/nStSPEijpppicfTZox8HZYe5EnCJJ05gR40kMkfReTmQa3BUk0YPfkuu8bbfjBzoR/CoRmDdKUgrfUyI5zu7YNDtQWMANfp5GTFFmyBGdge6Io+uJTgZwhQVf5snyFyCLJGJo4KgI/GWU+bW8EvuH4W5gCKdOICjomtDFYWNrB2ZLYQdHJ+EroMAKsFg48dFiweenku+9rl3cIjjxq7PXBSwpruqcOx4F5Cm3QN4gOHH6rgV6jfbqJFCIOdTVmhMwR4nupZcU3Yj3qRf+wXdaqLuxU+9t3PhY+Dutjj9cdsyCD0nwvZXRNQElPbRntX8lGrCGNia4cqePmTeLfJ6hXS6U58gZL1Y6+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(42112799006)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oZWz8Z52Hi5KhWd3imyvG3IIhc0OUbO1MlThgj4feFhaD9rDg5JTbb89Ez?=
 =?iso-8859-1?Q?+dEh/Ay/Y/nLa5s3kyuafQWFPKHtyJ4T4Q5SUtHVIMxgcm1aVQSHBp2TR2?=
 =?iso-8859-1?Q?krY5qRcqNq/4FIsy0BWXiMrZ4c6UvpovKk/sDNMSOanWU2MDZyLVDfqBMW?=
 =?iso-8859-1?Q?JI34t3t0lE9l+tOnlww37vxP97Y/A6HW3MwfFHENFGXsT1vDN5vl6PBkxM?=
 =?iso-8859-1?Q?yl7aN/s9zP0Or/waRRAGh1MM0qlao3PSMjLrk1zcnWLVXVkYBBeXcPjuHy?=
 =?iso-8859-1?Q?dqHGDrj5pRWAlVQFYxtqLQTP6sWmO7FvyY8x1hJrpNlX3Zcjl7Bg9b6Phh?=
 =?iso-8859-1?Q?afMuvxHtjW6DNctfv+o29C4RTJT0S4nxwjhPLwx9EFfoKTLC8GrWwSbEj0?=
 =?iso-8859-1?Q?foLU4KKQ6pkd1XkPpsOpuNZhTB5Ycpw5wSMI/PlsH4D+1BYPGauVatOWsx?=
 =?iso-8859-1?Q?TA3jZtTX/DEBTHgCoHB5ko1zqfm3qBVDz467kCXL9xF5/IBTMpjAy4LIGC?=
 =?iso-8859-1?Q?ONDIWIvsPcQ79AX8xd2IvzIIoUTsJJ8BvB6z8BMM02pFL9CJiQHPmHOTVi?=
 =?iso-8859-1?Q?oqOTzbz+eqnIHGLKvdpNpHCwZa4diOz71mIUS+6siHWNZG55Y73NdbGSJf?=
 =?iso-8859-1?Q?4znonEbIg/NCbLmGSs9hhLgMvwL7hqrFRI+oFi+7gJiq2Agpe+gGjbbnQQ?=
 =?iso-8859-1?Q?BiKTGkTCNzRiTd+WtK764C+jfoUu23qTDVy+NWpmHdnGB8qUi6KjYJIRrp?=
 =?iso-8859-1?Q?e+nAk/4HNcdjpgBKk1MT9++wdmgkS7Qu2zgA7+bEVHT3I9/57Nwu/vz3eP?=
 =?iso-8859-1?Q?YG22fGWYs5nwqJMZZzgIsMAhUbQzcYwIhu8HN2XMLs1YRMkIBF8n36h9Y1?=
 =?iso-8859-1?Q?eIJdDX66YcpOMGp8Ekbb0anmh63kXMRxotJhAJYJqXlGSAM1oCOzCXLDPO?=
 =?iso-8859-1?Q?7h9V9Plg32DssvN1BbB/QQKzZ8apTWAwrXTzrsvMccVrQlWkTmG07bUF1k?=
 =?iso-8859-1?Q?n5Pgj0xKMhDnJQ7cJKOoIE8lEm5oWgEFypNvHwXNBoSYLoBBQsFFVn6xKg?=
 =?iso-8859-1?Q?LzXektfiJFe/no9sJ+3fCjOC/0tPgpGO+EMVDtBjegD5UaIdDlahBAVgKO?=
 =?iso-8859-1?Q?gVrk5Vui1Eo3hn8KTHEbcCNnViEAPeSjXdpNs0YQI5CdezkfL2WpjH6m3d?=
 =?iso-8859-1?Q?6pGmC7WTfRS6DO4hQHwdhCbWR36444DIcTa7q2xrbvUB3L2/xB34Clg//X?=
 =?iso-8859-1?Q?34pWb17MF0nAT4gS83zlg2z8qDhsbC1/FFLXeMUzi1uqCUbnlujKDU1weo?=
 =?iso-8859-1?Q?WVssKLfn755bK8MdOnDgmfWJ68KFSrV3x45tDU2AeBf6a5c6AUycvhfW1g?=
 =?iso-8859-1?Q?vuTDRVuQcngb9hUmgbquKBbAQ0T4yS2CA4MyexFJxdi6Nf1OLP1XoDyfzf?=
 =?iso-8859-1?Q?eR9qj/jx61z4uKhQKS9eGm0eDzJDbFZLwTmeOXSjRNs/su0SuEYNrEd2+I?=
 =?iso-8859-1?Q?0p1+aYKivZhhKrONQAr7NVgD9C1vwOk56toIgbXwM2C1M+O8koKtrvgj+d?=
 =?iso-8859-1?Q?Jid/zT2LDIy7ktC06cgiEf68vuHZFOt+lGB++K5o1tU5kQCFMy7DN9qxUC?=
 =?iso-8859-1?Q?TZ8Wp0JU4L5EQWG/vekN8G4vmRMr/A4ICPRx+QxuMYRdfkEVhpZsnMCs5M?=
 =?iso-8859-1?Q?D2pdFrD9QM1EMvRROpBlVJ18dhmYN9JY1sT6MN6jpxF5v4sxqYsoRYCvGd?=
 =?iso-8859-1?Q?ADXo0Oso1WfiHb9FHoo+4bpR8XSotJNjfSb6UrH5ajrjRV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kdgzel564f8NeccL0FUFNN8kDrm46ksjKgu/KzoMD04crnQ2+R1EuJwA7NxpUAHFPStpJgYP4oeCZA5UYJD7oj1I/feALY/7aPwJJS7UiiztLfsjDHNcERM2mfmqr8xKPDERMYnODTkf5/+5txPm073kZ62OHMIZ4j9mco2oHR6+WOTBWfK2XNF7IP+z6QoQuXgmnUl5D2hdBNSueYSnbB5Jm5UtOrcbJMPNza2wFJUbacISOzrlKLNehhJ8GhDA1GCSSLpp7sJxXYz9eVlS/XtNMYUb8BncQt+KGIhkY5V6MM1aMg+InKD6e8+X1tmW9aW+Fmwli8JceoPlu1FdeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb37041-39dc-479d-b0df-08df030342ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 23:47:44.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thZ6pdbBwnZn/pCURwybLLeWO9J0dHXSl5UU/jUQ5c6zELpGbLv1gJp594NUSpbXoJixf0eyx34va6LjnIoulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8817
X-OriginatorOrg: intel.com

I take back my earlier comment. After taking a closer look, I realized that=
 Xe2 LNL can also hit the issue this patch is meant to address. Therefore, =
this patch is still required.
> -----Original Message-----
> From: Yao, Jia
> Sent: Tuesday, August 25, 2026 4:27 PM
> To: 'Greg KH' <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org; Mun, Gwan-gyeong <Gwan-
> gyeong.Mun@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
> Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> Subject: RE: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
> separate BO
>=20
> I checked include/drm/intel/xe_pciids.h in Linux 6.12. The highest Xe
> generation defined there is Xe2, the patch is for Xe3, so the patch is no=
t
> needed.
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, August 25, 2026 1:30 AM
> > To: Yao, Jia <jia.yao@intel.com>
> > Cc: stable@vger.kernel.org; Mun, Gwan-gyeong <gwan-
> > gyeong.mun@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
> Thomas
> > Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > Subject: Re: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in
> > a separate BO
> >
> > On Tue, Aug 25, 2026 at 03:41:11AM +0000, Jia Yao wrote:
> > > Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> > > CPU memset operations on it, which eliminates the CPU as a potential
> > > cacheline-polluting agent and helps maintain consistency between GAM
> > > writes and GuC reads.
> > >
> > > We also need to ensure the base_dpa for the queue is contiguous on
> > > hw where this is used instead of a GGTT address. Another good reason
> > > to split this out to a separate BO.
> > >
> > > Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> > > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.12+
> > > Signed-off-by: Jia Yao <jia.yao@intel.com>
> > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Link:
> > > https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
> > > (cherry picked from commit
> > 6af05de0dc19bbf3aaeec2020fe48b37c834b811)
> >
> > Same problem with this series, invalid git commit ids :(
