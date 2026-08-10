Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575563CB;
	Mon, 10 Aug 2026 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786333973; cv=fail; b=hy6PFTuuZq+1lQ0zRuBe9jbQN+Efg5BJ0eltmMQqc47RVnYY72+zWzy48CrhL2b04S7VfzLLQRWxyyuO+vSzRSQZxMjZSg8apFtz9rVBAEOPuX4lrw9lf67dQenX3J75QD6o8Cj/2Tbx4yoUTp6XKCYUWFsxTn757/F3/tIaXr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786333973; c=relaxed/simple;
	bh=o9kzp+h5bcLTd2qD3xrMockEjuyjsrOwzcjOnnoyZzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvIVrhn3lR8DC8yFGMnsl4DnIwqFJYemRUflv9j259446idIRGMafZvJMzLHcx2B2s509meb+OI5FUHG0g0A2HNMQiPZ1kHa5NFomsoPNvDJsI3AFktWARSZX0odiACN1n3iBajmDUM7Q5fpL8StYbM1njL3yuMwcI6EttDSvzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yzmwpjbj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yzmwpjbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786333972; x=1817869972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o9kzp+h5bcLTd2qD3xrMockEjuyjsrOwzcjOnnoyZzw=;
  b=YzmwpjbjQugsfYXH5lXIQv7cJijXPsDw9IGn+1jYwZpZBW+hNOAafqte
   XdTNAMx/O7JXbNTCyQxs1UuRaI+txr0zpLqfIpaAJZ4sHsY5bCS/9DEcJ
   8hz/y6R3MesaEdTFN09/SCoL0NxfL1B3PtFEXueItl6EePZsB+PjLD5Zc
   cnkxjKolhtUTsbCPVzDtrjntKwYs7Z5e8yQivgRV45qcIXpStKvvFXBvA
   4326ItqkfQ8Da9f6Yq8wLNIxw6iXnp08/uvJNo+ueiiCZCP5cMPiHSfl1
   hE8p2KjheGiQ4sHHov2bdtuE7Ag00t5PYjF/I85kgDU+/iHJzEpZKKaOT
   Q==;
X-CSE-ConnectionGUID: gvZQbtSGSXKOcdb72y60Pg==
X-CSE-MsgGUID: STKCXp/GRvmgWDMpl0wglA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97992458"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97992458"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 20:52:51 -0700
X-CSE-ConnectionGUID: ZN5RLDvOQjybkx2bPS5X2g==
X-CSE-MsgGUID: LSTJKOPFRu6XFUkaKfeaNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="263543158"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 20:52:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 20:52:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 20:52:50 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 20:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJSGxpo94ng56MwTfwrU10tcPmOIS/6Dx8y9HH8U0jZ+F9rpJCjQj0FYnWspdVNutxPHzcejvEK1+eB/l0RqC8y53yRsE0mRbpI9dw76F6Xw6mp5YuPn9yGLh2MTqlmYpxkv9KbgoMVAC14Rlm4jj59L0ywPboB3K9dHoJziajxx+hAbqh4bwRBMYkCN8YA3Ra/qAEZ3OG/RVBZW0Gvkns0MYghEggxIG7ft967RyUvzxNg78Rno6XB3PFBTZR3lMDVaQxVybSbaXLEQh7wxQhH+PvPnFU5RsY+J0IEHgHGv7TLOWLFSosoNpR7+vopoYuwUAB88TVxL1JPiN+vilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9kzp+h5bcLTd2qD3xrMockEjuyjsrOwzcjOnnoyZzw=;
 b=II4YCia+QIu9F04estZwv4hnln0MMdA3gB3LnceXN+wWTK+1N71ayj8YRjEYrgLMNO92jumcY1Zko52QPQ76p0KkVAx9JBESN7q2mgGaLVHGy02gbEtip5cufwPx/gM0NMz28R9LbWmfR9hlq3SfJ8ffwsdMp21vB7x6WD+CQ2benTxuhJAtuSzpaj6fCYrbsk9V1emJX0XVAndV2Hvfewl3AO5Z/JW/rN4pXaFMz7NxGVJUU3n/DKx2/OFGhjoTz+7fJyXmoLb9YftGLCisQPdNuR4Ga+teZ19+Y9O4bytDTNsq7zMNL3zYsKPboZ9hzgHDwXXnV1dSF8xesR7M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7971.namprd11.prod.outlook.com (2603:10b6:8:122::12)
 by SAWPR11MB9710.namprd11.prod.outlook.com (2603:10b6:806:4c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:52:45 +0000
Received: from DS0PR11MB7971.namprd11.prod.outlook.com
 ([fe80::40aa:a291:4c25:6e0a]) by DS0PR11MB7971.namprd11.prod.outlook.com
 ([fe80::40aa:a291:4c25:6e0a%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 03:52:44 +0000
From: "Yeh, Serin" <serin.yeh@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "Su, Jimmy"
	<jimmy.su@intel.com>, "Sapre, Sarang" <sarang.sapre@intel.com>,
	"bod@kernel.org" <bod@kernel.org>, "kieran.bingham@ideasonboard.com"
	<kieran.bingham@ideasonboard.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: RE: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
Thread-Topic: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
Thread-Index: AQHdJWrD+QCOeyslVkaB0olyl9YlT7aQz5sAgAXaZGA=
Date: Mon, 10 Aug 2026 03:52:44 +0000
Message-ID: <DS0PR11MB7971C15FFBC42298848AF142F6DE2@DS0PR11MB7971.namprd11.prod.outlook.com>
References: <20260806061804.1359700-1-serin.yeh@intel.com>
 <anRf9Jy6BcygUk8d@kekkonen.localdomain>
In-Reply-To: <anRf9Jy6BcygUk8d@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7971:EE_|SAWPR11MB9710:EE_
x-ms-office365-filtering-correlation-id: 25c4e7af-5aea-4869-ded1-08def692d5d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|38070700021|6133799003|3023799007;
x-microsoft-antispam-message-info: T/SE1G1FshlzBXmGArjcDiupi47cdlUJdvQSplFPzotFOLVAGv9nvqyrhhwJyVVOUCaMbiHbINsuhTKkU1pAXaxTx8eElMmw2XTvXLEMOuE25Db4uEnPRrhWmT3FIdPJS0MpQwrEm9jXfCxz7uS5/lfmfuZvRcgXcuqHEJV3SeH3LAV77QP6TrIrtcGzK71C+OM5KaSfwAEU5DVMZlkcnq9pJIY/0Yr1O2U6rSivy/f2bk2WW1uP/uzs/piXpAffHB4CNTxAtPkTRIuIT9Z6lnqPuasKMlVqR3lL/pW0VE+mMKSOEqQHLWwNIRwTyj7p8f9+FPBSEN3VKPCxcQSQM/LgltaSCWg/pq0/FM1OHj5yVqd8eQ8uPaneOUZ5RVTLnrToVo754bnOkTOkgUAbpM2BzQDvkQQ24RMNxiOyV/vyEjJ/3Q1XUctZ6zhCeEYKv+2GyN5KKfZ/+m7o340kOZfUlatAtbDBAHq55U9KwkidnB+N7ctqHWZBawvnBZJxyTEemBGiwVLnj0Kffynn4V+C4Fim8GLVuC6SYt1qdn1O6ysa79mFPLE/4qmbITZyMqsv1Ian9xTYDj/Cr/9jIhrLk7iCjoawzVEnObjHcprxeTcETLim3tIpf1nctvpEUljh7Jv3tmvMjzy4JpWNVMZ4Qn9qyCdWHIyTL+GLAzIwQs7g0kaTKd+sHdddGNoBI7B1VuGosMvRPIeSi+UIxPsadkKOVg8rSKYK9XlddOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7971.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(38070700021)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ykiuCqp275DH6CHumRJA26QUcVTYZzeGFDtaT8/yBCKN5US1F/GqbMKjEX8h?=
 =?us-ascii?Q?ZqUGoAnKMruFNzue9lWqcv1+WXs8Sa2B2FDPHklASbCoie4Vwib0nTVpd5kg?=
 =?us-ascii?Q?PHmN3aRebufW5Jftlf60AgBDTCKS7mzQoUgtPIH05SZCkOfa4WFglGS+Bvo4?=
 =?us-ascii?Q?CfzkGWtgzyGAxkHBLa64pQ0MbyUHgTcYBPyHIjUb//kFQ89y9ZhaGmMx39Gg?=
 =?us-ascii?Q?dh2NzQX4dLMGfq7Ok0apavor5r17cSmuC4iJRMEd5CmZXsN03f9yMM8hoVFd?=
 =?us-ascii?Q?1Ez17eT9EPgsZDkHqSaGz+oiZYKUH0XriLOGWht4dXF2rOb4+RGA0VJgwBV/?=
 =?us-ascii?Q?Nsvmz9p9VTFlP9Wr3E29LPTlzxUe1aA62U3t+qFKC+dZuKLbEbaONRt86hnT?=
 =?us-ascii?Q?2suern21rnmYg6miENpI0jvf++G4qv1R0gYrVQpFredv2A9RqpUK9e326nj8?=
 =?us-ascii?Q?apuwx2qdaXXUdPFxkNLWswAIVbq3AbM7xHZ62uJfBiGII1Uo+XVz8YnADlCG?=
 =?us-ascii?Q?lzZLvjRqxQ5lVotTZgKC8ejsAhzmWZAavcE+ZQBqz2EhIsYgg+WF9ZMnrer9?=
 =?us-ascii?Q?9rRnZlEz2y6zlHAs9nqbjJjmfVMYYSiuGtvZe2WBS/DQl/Q+4kxH6RzIm49o?=
 =?us-ascii?Q?/ogkG0DGvn0L3osTjSfOqFMpFMIwNoiCPFtxGjwB+xhHSFg3JCerivGZlu9k?=
 =?us-ascii?Q?Dw9fMjalL0BlFVHxes2Itg0SzvPCokmPtN/1/acaSbwk9T5r0vJt7sTw8zWL?=
 =?us-ascii?Q?xHjh8zp4JmCKRPDx58iY7ElF9hNiI5cniyrj+/mn2P+YZVPgLk4kmWI+Is0h?=
 =?us-ascii?Q?Z7di3H+WzZ0neVzmZgRESGNSnPtLnCTsxQIZ0RjlQs38vBgNfYJgRAaABtF8?=
 =?us-ascii?Q?Mbwh8VmxmqtVenCmFVNGyU+yUU28roZ97rqtHDia0guVMiXssLRPNc1wH4GI?=
 =?us-ascii?Q?q+t5tQaYeBRP2cMy60rfd4ZBM4+f2NR36Wb9DIcxzSz0/J9vYxupRF22mqTG?=
 =?us-ascii?Q?yAzZHt3NZTNJp7zEdWuDxamA5slxidUVlHbHQ+fZzkxUCULsG4THOJ5pPyxW?=
 =?us-ascii?Q?hUXuSK6t1aVvceInzOX4NzoOKuiPtHMlcyPMmqYdsmWd7vOBrMd9cYsHzb0C?=
 =?us-ascii?Q?GkVYmpym4tGDdiuho2Uu6sRmN95/qjQCE7sg41oqnnBVvbdUOH84mk8488e2?=
 =?us-ascii?Q?XrP6BXU9a5vsaD9grNEqZHNMwaJwB1qhEWnrkEOtBPS+CQS+23vkaoBoX/b1?=
 =?us-ascii?Q?IXqhRoi4N6QRwhbNEhwYG/CCe89HaxA6VUHemPqAm+UW9L1n49jMlU6N9p/4?=
 =?us-ascii?Q?2BLZaePf2IFNsO/xUhxUXMH1ascYaYOEqBWc1k95tskfQHbzkSJVZSfesrrZ?=
 =?us-ascii?Q?B117yf5VW+KXCIWs97NDsc+WdAcNAhi26gm5GeIfZY3dE19PzEqVtcAhnhM6?=
 =?us-ascii?Q?YNNJVmkKBJXVQ12QGFfzsHuaMXIaCcDqXKbxBxd39A3QhsoxZoJVBeihnMAg?=
 =?us-ascii?Q?1sP4e31kYcIrO1Y6yacty432+Q/6eBIFUUKk24DBddhUIOdcbnODa4z/SUdF?=
 =?us-ascii?Q?Gek2KYI90rs/B3+nrs86moPJhqL6+ic1xO7G1sde3hbl2cwsvacYz0/rXQgc?=
 =?us-ascii?Q?EgX1fQ4S4Kkj2wXoI0j1KU75L5b6Lq7hoSV7sCX+jsHyFrxlxCGtjqOVCjMy?=
 =?us-ascii?Q?f5cJFRUQcV/RQCHJCJEKkpK3AqIzPvgFSvSkRomc+qqevTE3yWQPwAif4pWy?=
 =?us-ascii?Q?nQtAvMAMqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bSLBcAMKxDavqZsmFS0D7bjGybXffnLA0/zGl0Fux+slKFCy5UmEadO3pujBVyUOBrnnPqsAxOAFc2JfY0CJGTxl2bQHovrP81UTikUmcviRHGkRlAB6zaN9DXCcwMaE769VtULaNItcfar3atgePSZYr9TKylk+KPul9nQjITRSBsZLvdJFTWipI76PCZQ1CF2QYBNHFBhVmoxmg0/DEr4t3r7DoWUvo+3Evl4UADke4DZtJ/SC64zFmOHFQWUxilX9KhIU6Hmg+tJyfRlWsZqjPa0B7h6ZvlHpNzkGqJTZFDOhU+MuN+mC5lZxYzu23tOTSN3gME5bnr1qiU0G/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7971.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c4e7af-5aea-4869-ded1-08def692d5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 03:52:44.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hZ00XtoBOm/lynNYTWJnCnxgTgAphEcnUd9AerLc9/92NMZ+PiQALwi6YQ+UVZeLs686W2IcX1EZhjis6N98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9710
X-OriginatorOrg: intel.com

Hi Sakari,

Thanks for the feedback.

-----Original Message-----
From: Sakari Ailus <sakari.ailus@linux.intel.com>=20
Sent: Thursday, August 6, 2026 6:21 PM
To: Yeh, Serin <serin.yeh@intel.com>
Cc: linux-media@vger.kernel.org; Su, Jimmy <jimmy.su@intel.com>; Sapre, Sar=
ang <sarang.sapre@intel.com>; bod@kernel.org; kieran.bingham@ideasonboard.c=
om; stable@vger.kernel.org; Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass me=
chanism

Hi Serin,

>>On Thu, Aug 06, 2026 at 02:18:04PM +0800, Serin Yeh wrote:
>> On Intel platforms the sensor is enumerated via ACPI, and an INT3472=20
>> "discrete" companion device (the power-logic-control driver under
>> drivers/platform/x86/intel/int3472) registers the sensor's=20
>> reset/powerdown GPIOs and the regulator supply. These resources are=20
>> therefore discoverable and usable through the standard gpiod/regulator=20
>> lookups at probe time.
>>=20
>> However, the driver guarded both the GPIO/regulator acquisition in
>> ov8856_get_hwcfg() and the whole power-on/off sequence with
>> is_acpi_node() and skipped them on ACPI. As a result the sensor was=20
>> never powered or reset by the driver, and probe failed when reading=20
>> the chip ID in ov8856_identify_module().
>>=20
>> Remove the is_acpi_node() checks so the GPIO/regulator resources are=20
>> acquired and the full power sequence runs regardless of the firmware=20
>> interface. The driver now behaves consistently across DT and ACPI=20
>> platforms and initialises the hardware correctly.
>>=20
>> Tested on Intel platforms with kernel 6.17 and 7.0.

> Only testing on current kernel matters so this is rather redundant. If th=
ere are no other changes needed, I'll drop this and Fixes:/Cc: tags while a=
pplying.

No other changes needed on my side. Please go ahead and drop the Fixes:/Cc:=
 stable tags as you prefer.

Thanks.

>>=20
>> Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock=20
>> helper")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Serin Yeh <serin.yeh@intel.com>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>



