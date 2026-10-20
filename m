Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499365;
	b=HOm+DVQ1KqehKF1bbDpbFm41D2u1C9B+Oy+2aoSBrw5acprRqGAkmCQ9N2tciEI//Cjq
	 g/hKI8DCszX6Eqr9iScmOcSoOdi283kI4KiSLz5aFl3VfD65p9kzLe3frWWpfBBwpCXD1
	 VjtXzL54eN0agQVfZrLvKK7MzvuxObVGI1oXV+9vlBlowFsoyNKVLQ3BrTN/W9x2eKTch
	 kk6W9t6iUtwY62fG5YSl9F6IcUIml8J20L1zLBhKaakUSxJ7MMZZFNBRuIFeSomc4X5Ix
	 KNCbX4wjBmH8+H9TqTh1e7pKboIDQYORYYg1YLe+3K4Q0gg1FuvNM5ZK2/BgCCaesmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499365;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=a3sr6/WgcYqhy8ly8gWeG0l8vVR3wHbng6hi+qyEF3o=;
	b=L2xLkyRMqpcFytOVF+zx1/pMsAoD7MwU7S9hTaXZaqL8B/3CSO0vqL61EJcjoADcF3ja
	 cUN+k4PrxT0ENNPFQRfG7JlBLna6Q+8dATfHm+H/yDtw5UG1SRpbjRIyLKSAUcjcA3MIh
	 TL2ui9L7H45CsKzO+/cZYmdI4gG2hODKjcEEgtLi3kEFuNjOtmHmj1qoTb1Noatfyp+OY
	 06uVtmpOXGPMVjVcOg7Ej3hPme6RLYUQscvmcDQxTJal3/m3zv4RoSMQPykG/Rky5lesb
	 TvAEkY4dlkSlWUB3LF/ajX313dHAfdyxVfDRgG9QVzhPXqmcv3zXOuC8QP6HyD9scDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKNSlqvi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD23606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD23606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKNSlqvi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792499363; x=1824035363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a3sr6/WgcYqhy8ly8gWeG0l8vVR3wHbng6hi+qyEF3o=;
  b=PKNSlqviafA4Me9OeRjsWflVWN8zoZ2D71cqbAPy8LpcHocrGTjcOYnF
   bJ3/xNe/oxaZxm88pDbNGDNpPj7fZ48kfM5V+TS66Px4NyBdEWVsXNI8s
   OZwoVjSn+SWvsQKu9Im8oYsP9bDCo2goW/u/kyFEOPSdRDb2X/im/WeYC
   eeQ+1jYzR6wOe4qPKWGwMmJXLhir3Ui1mjxD4VF5aE1DGNpbjpADLhnoA
   vGj7l6lKoV4uID2+u4TbYerQHiSWFKzFVTjP3i9JmrRHsl2wIDLW+Axwo
   BvGNs1dkSrLyaojZGjzyn5fyZ7Nm5aKtiBv0i0NM/uDUDYQOWjAmhkzPk
   g==;
X-CSE-ConnectionGUID: gimhDJkeR5GcK+sQ41Upfw==
X-CSE-MsgGUID: +7Lny6sQQ3CtZ1IFrk49ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1088412"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1088412"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 05:29:23 -0700
X-CSE-ConnectionGUID: oet16fEtQgWWAZgH4YFPXg==
X-CSE-MsgGUID: Ko1jp4c1RVyC5I8tYwDe0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3145660"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 05:29:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 05:29:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 05:29:22 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 05:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiePzhhLXqBsEe+qZsC1lRmSrg05pnV/QNNkPWWOeAVKw3i7zn+YcmzERNdOxoajZV26qaPK73CqvVJJQKey8k4VbvHTyqKnRjdMEq9T02ESEpoMD0kRFJ61cb/Anu66sadkm1zUxXMp5tkh/zFZNNoI5CO+GcfJMwDgZbzaM8d2SJlhjDTf6CGtgezcQyScUuUjt0ZloYB5dwAm5eMrZ2WNac9t+BkfwG9iwfVdBgIGukVwcHOH7BRhAY8S5yEIA/ZeifjgGy+6jigL1Afd9n5xfyYi9WSv4Z9VctrfZN6cQR5bDzJ9d8rIDEKQeWm5q+qDi+ZkClxm723lb6CC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3sr6/WgcYqhy8ly8gWeG0l8vVR3wHbng6hi+qyEF3o=;
 b=Md/4pY8mq0kb83vElUMIvYjwdbyzjw0GFGixzbwcre3vMeXq3iVTFQeVkwgdtQOgnjR44V/GuyEtpWmBiTkWXKuyywegfCzsg42CX6RGdJbdzrCkJ7MaX8hg5DmACOlDfoXlMXzPfS5Ouh+xF85srz+rVmTE0B+ZEdsc+C4nKxCnRL+Eua1NbN9GpiMEvYT1gFva6FNrxR2KoPyeZv2mXuP8nwgMCBgQTFhsNUiKJmYVW6N+1TtttsTeDlNqtX5hjeu0t4k/umHalXOlJPXJBiRfzTvIZ7wTzvtnRrG3MhfoaaxOCfKymXfA257LqseWiNVL/TktOjdCTSyWM95/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by IA1PR11MB9471.namprd11.prod.outlook.com
 (2603:10b6:208:5b3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:29:20 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 12:29:20 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 4/8] drm/i915/psr: Fix SFF and CFF CTL register bit
 definitions
Thread-Topic: [PATCH 4/8] drm/i915/psr: Fix SFF and CFF CTL register bit
 definitions
Thread-Index: AQHdT/ghbJfvOK/m5UG3kgSaVaIEsLcGfTig
Date: Tue, 20 Oct 2026 12:29:20 +0000
Message-ID: <DS4PPF69154114FD13F37CBEB127EA4609CEF672@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20260929094434.77129-1-jouni.hogander@intel.com>
 <20260929094434.77129-5-jouni.hogander@intel.com>
In-Reply-To: <20260929094434.77129-5-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|IA1PR11MB9471:EE_
x-ms-office365-filtering-correlation-id: a29af660-8146-401f-3089-08df2ea5c43f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|56012099006|4143699003|11063799006|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: L1uOM7oPDMnm/+7aXteDZMj/own/cXkgvdYf9aqg1FYSGggFjrlmX15lMVElp9Ma3PWglrUazAcNTZfJ8iPXxajrHD5yy7RgkV7zE7Cp9/Mcx++771mGhNzwf2+8O276dp0qkXV7luiER1jddeHJ72Bj0whkm3Z6OwdbIT2NWgSmwSjmCizgFyGlyAGc1w6v4S90528WpZShoHFsfxjnIu92mWTXv2vS9KkxRfHrS5fdm3NVkhHESFKCx/9iwm5WWB/eqYOfscv75icjY0Zn9V8MQcRgieDor6WrcF3xFs/5WV2r2cN/58tC2d/1tX4VvmgYRJHEdNQym2TwSoitK/+7j/fPP3iEDoOi+ZD8ofs+YyZWp9DtOivPeTfMUTli4QHHUTXEZkFvDcORGl/i5Pea51iROVsxXgwCws6RT6soCMpFQ7fFKQphC3TSSK5wn6RKu0e5kp5qORvdVG/gLakWQNo5zkU+JMVZdR28Xm64Jrw9qYe9FYYYX2f0wpS6xe9U/H26Fy1lWM9t3aflrTBsk98+Xoh3oCtvVUMp9NbVEaK+Ru4kq/MbzY/lOwchVSiWYDHXOTxTklFuTApv242NszlTC989uxv0Y6zSJQn96NV58HAgJrNar6hBy98bHAngMbIWmBP5zu/iBzHnqGVCyR0mEhettsUO0hBf8DA6+sonxYAxA2cGsJ1Tw0K2Napm473Qgw3RHiyJgOJIBD4HWzyygeoSwyOtx/aukO8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXE0VENVNFNRdHBORUxtNkNmbE55cHMvMG4xT2NSVWNrTWRRRVdLc3NDR3pY?=
 =?utf-8?B?T29yV3Z1WVRCQlN4Lys2cnR2ME1OOE9BdGxJYVEwYjJ0cCs0ZlU2eXVrR1Zs?=
 =?utf-8?B?TkVOZHhzelF4d3VMTGNoM3N1b0Uyd2NCVE9UMmtwZDJQL3VrdXdQY2w2QkMv?=
 =?utf-8?B?elFrdmhuYVpPWVJyWFo3eXZUMEVtRjdKYmxydEhtMm1PUGVwTzhOakhrOE11?=
 =?utf-8?B?NThzdVZBdzJUYjJNQmM0dHJsVlhSdEZXN0FDOGtLd1FqUEowOUtqZk9mQXBJ?=
 =?utf-8?B?MU9iSjIrb3ZteTcyMGNhM3hoeEN1RFBsV0g5OGZCNmVUemFLdW93T203ejBu?=
 =?utf-8?B?Zk9oYitVUXoySUgyeWI0djBmQkRSbnAxNTVPWitXUkpXd1RYbG5SZ0h2bi9Y?=
 =?utf-8?B?RWZGK21EUzdrUzhDaVQ2Zmtwa2pPZDFuVk95WVFkLzZWUDZUMW9xMDBJbHBE?=
 =?utf-8?B?VDNJbWM5dDZkSXRWSnJpbmlodDJ0ZjI2elJOc0cxVGEzczdHa0dMcU5EaDFH?=
 =?utf-8?B?U3N1MWVRNEh0WjU4OW1LcUJoZ2RSM3VPTWp0ZWRXM3lCTXRiakF6cUZCM1I1?=
 =?utf-8?B?UVIzM1F1b0M2eU1OYjZlY3lSNlNnV2ZBazdleVkxTU11cUdjRzJoWmd6RnhL?=
 =?utf-8?B?OFJjT1kwaEV1b2pVSUVncGI4Kzh2WEQzVGJOYU5UMkZBUnd3R3NVN3ExV3Iv?=
 =?utf-8?B?bWNxYXZOYm1YQXY2TE41Sit6ekZSOGRzUDN3ZmxjZk9jK2lQSUZpMzMybFNH?=
 =?utf-8?B?UkF6LzF0eHA3MzdBcnVkWmdJbnhReUpLQTlrQndCdlA5K0RUTHhHcWUyVFZu?=
 =?utf-8?B?cGxuWXJGYjZza0paUUZaS2R3eSttUkRSSHpCVUxuZjEySXU0bnRPRU56S0xB?=
 =?utf-8?B?L2tac3NqblV2UkZhN2ljL3V3ODFsNXFVVTFsWmEzV2xJendQdis1Z1ZFb2FI?=
 =?utf-8?B?VytHbUloSXQ5c3BNN0Y5RlV6RG4xS0llYzVKcmhwa1ZQMWlqRFRFb1hIdkhl?=
 =?utf-8?B?Z29oSW05VTZ0L2JZVlRQeXFhZ3Fia3hwQkh1T1YvVWhrZTRUZFp5dWxweUho?=
 =?utf-8?B?U3FWaDUzSm9sbldSUjk0THlaYmdVR2ZJcGpIbEtkdlVtblByRzBMOFFCcXRD?=
 =?utf-8?B?VzhEdVhmdWpobU10amF6ZTFIcm5RQ3lZUmRkd1M2TzNkcUE2a2hZRDU2Q3Fu?=
 =?utf-8?B?dlNqclFUZlEzTVRsdlk0WkhlVERvbnBadVFRRVdERS9YZ1ErTVZ6d0hPTEdJ?=
 =?utf-8?B?Z1R5K0VqVzRXMU1yS3F0a1NEMUtzdTlSS1RjSExRRjl0cEZoL1liaW1zMFVv?=
 =?utf-8?B?bDZhNGVKZjdtZ1cxZmxBV3VKa3lJcjlWb096dzR6aTdOUFZsQjAxSklqMExM?=
 =?utf-8?B?Z0tocXZCeVUvZjJkaWQ0TXJ5cEo5eFR4UkNZUVgxWXZDZjd6bERNY2xBWnNp?=
 =?utf-8?B?eVVlVWUyaW1lUUFwUUJqREhhYjF2MTRnMUpNOFJEZlFmcGZvR3RoMExLYWFB?=
 =?utf-8?B?NDJoSTFieTgxaVl3bHM1N1ZrQ1Q0NU5FVjl4M2RoZWp0eFJTcWxOYXRNRmFF?=
 =?utf-8?B?U3Z2WVlEL2dQZkQyQ1pKZHoyNXdOZW9PRFRYS3pZOFEyMkYvTHhFQk90eXZl?=
 =?utf-8?B?N3MzSzAvdW1ZM1ZXQWR3VlVkdC93QVpUdXp1T3JDTWtLT2RNK3dlcWJOeVZy?=
 =?utf-8?B?a1hyK2k0RlQyZDRJdXF3Y2RPM01VRVFLdmFMSmg2OW4yZkFDSVlkWFgyZ0c4?=
 =?utf-8?B?dXBhQ20zRm12cWpDTmpGTDZEelBqbkFzYkVZd0ovaFZud2V1cnRnTllseHZK?=
 =?utf-8?B?b1NuRTRDWFkyUGxNSk5FQ3BXVFY3ZXVZWU9MQVRwUHNOTlJGZUdTb2E4Ukgw?=
 =?utf-8?B?aXNJUzI2Q3NGbTcyc09FMUZuTm95Uy93V3hFZVdtSG04cDB2VFprN2d3d09H?=
 =?utf-8?B?NDZXeVJPc1Y4SytveEpxWWN2c0VndzU4VFBZdWZRMktpRnRkSWExTHpDc3pj?=
 =?utf-8?B?cnptK3oyaGNDSGM3eVU5ZHNNNS84ZE9WMlpBK2lLdTNRTU9KQW0rUW4yK1Iw?=
 =?utf-8?B?NnNKY0dENmZjazFqVU1NSGJrbWtPRzhrellFNi9zQ3hkNUpaQ245cHZsRXNC?=
 =?utf-8?B?SHd6YWdBWGZQUHkraWs0bTh0TytEcTdieXg2OG50M1JpL05qZENWVThPOGY5?=
 =?utf-8?B?NTRtOCttV1graThTVks4TWFvYzJZNUF0Zmx5ZDJpTTVUN29OK2N0Y2pxaUxt?=
 =?utf-8?B?VnFiNElaWlVVR1R5ckE5bCt6cC9kMzBwa3h3MGowTnIyTFJ2cVdhcnZVcTJC?=
 =?utf-8?B?WUlTZmVrZHhRMnVNK0J6SGl2cFBEdFNhNnEvUU5jSTkwR09uK1Zqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qLgLdAf0AsLKYQsV6crEDAIrdn4AYEFdY2sIDTse57PbU1Q1JjBs2P1xEJLKb14Mq/rop0KkognDVisO8TK7m+iH8fIfyITh3nCu6PnUN587u6mlGauxZjYNvxsI7iKaRPOPd+UYtGVqP4wMtLY0UbnQzivw2paeiRAtL+s3K71NlH2XOCs4ywWN8O29Uqv9l5My4nNVVvEFMD7LEHfdBE5TIQC4OaAqabntP0UfWmUY4o/rDpucaDJXt5WE1oe5EHm+PwaK6LfHnPsBDmA4ldccKGbB6vs2z+zHFrpSbpuyuKpvfh4SkaOcCwMxzlWSWGlOq8MhWBjaDbhZLfLYEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29af660-8146-401f-3089-08df2ea5c43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 12:29:20.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akl8494w36esc61ojxrZNGNWXg8riuB6cYyoiX4nq3L6c64Mma7a16IRH0e+hYq5aiv0TU6NVBco7YqjlCEOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9471
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC1nZnggPGludGVsLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEpvdW5pIEjDtmdh
bmRlcg0KPiBTZW50OiBUdWVzZGF5LCAyOSBTZXB0ZW1iZXIgMjAyNiAxMi40NQ0KPiBUbzogaW50
ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBIb2dhbmRlciwgSm91bmkgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT47IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDQvOF0gZHJtL2k5MTUvcHNy
OiBGaXggU0ZGIGFuZCBDRkYgQ1RMIHJlZ2lzdGVyIGJpdCBkZWZpbml0aW9ucw0KPiANCj4gU2lu
Z2xlIGZ1bGwgZnJhbWUgYml0IGluIFNGRl9DVEwgYW5kIGNvbnRpbnVvdXMgZnVsbCBmcmFtZSBi
aXQgaW4gQ0ZGX0NUTA0KPiBhcmUgYml0IDAuIEZpeCB0aGUgZGVmaW5pdGlvbnMgYWNjb3JkaW5n
bHkuDQo+IA0KPiBGaXhlczogM2I1YmY4NTNlMzA5ICgiZHJtL2k5MTUvcHNyOiBBZGQgcmVnaXN0
ZXIgZGVmaW5pdGlvbnMgZm9yIFNGRl9DVEwgYW5kIENGRl9DVEwgcmVnaXN0ZXJzIikNCj4gQ2M6
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjE1Kw0KPiBTaWduZWQtb2ZmLWJ5OiBKb3Vu
aSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE1p
a2EgS2Fob2xhIDxtaWthLmthaG9sYUBpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzcl9yZWdzLmggfCA0ICsrLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVncy5oIGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVncy5oDQo+IGluZGV4IGJiNTc3ZTdl
M2JiZGEuLmE1N2JjMTExMjkwZDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfcHNyX3JlZ3MuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX3Bzcl9yZWdzLmgNCj4gQEAgLTI1NCwxMiArMjU0LDEyIEBADQo+ICAjZGVm
aW5lIF9MTkxfU0ZGX0NUTF9BCQkJCTB4NjA5MTgNCj4gICNkZWZpbmUgX0xOTF9TRkZfQ1RMX0IJ
CQkJMHg2MTkxOA0KPiAgI2RlZmluZSBMTkxfU0ZGX0NUTCh0cmFuKQkJCV9NTUlPX1RSQU5TKHRy
YW4sIF9MTkxfU0ZGX0NUTF9BLCBfTE5MX1NGRl9DVExfQikNCj4gLSNkZWZpbmUgIExOTF9TRkZf
Q1RMX1NGX1NJTkdMRV9GVUxMX0ZSQU1FCVJFR19CSVQoMSkNCj4gKyNkZWZpbmUgIExOTF9TRkZf
Q1RMX1NGX1NJTkdMRV9GVUxMX0ZSQU1FCVJFR19CSVQoMCkNCj4gDQo+ICAjZGVmaW5lIF9MTkxf
Q0ZGX0NUTF9BCQkJCTB4NjA5MWMNCj4gICNkZWZpbmUgX0xOTF9DRkZfQ1RMX0IJCQkJMHg2MTkx
Yw0KPiAgI2RlZmluZSBMTkxfQ0ZGX0NUTCh0cmFuKQkJCV9NTUlPX1RSQU5TKHRyYW4sIF9MTkxf
Q0ZGX0NUTF9BLCBfTE5MX0NGRl9DVExfQikNCj4gLSNkZWZpbmUgIExOTF9DRkZfQ1RMX1NGX0NP
TlRJTlVPVVNfRlVMTF9GUkFNRQlSRUdfQklUKDEpDQo+ICsjZGVmaW5lICBMTkxfQ0ZGX0NUTF9T
Rl9DT05USU5VT1VTX0ZVTExfRlJBTUUJUkVHX0JJVCgwKQ0KPiANCj4gIC8qIFBTUjIgRWFybHkg
dHJhbnNwb3J0ICovDQo+ICAjZGVmaW5lIF9QSVBFX1NSQ1NaX0VSTFlfVFBUX0EJMHg3MDA3NA0K
PiAtLQ0KPiAyLjQzLjANCg0K
