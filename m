Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF93D8912;
	Thu, 10 Sep 2026 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032953; cv=fail; b=UggAoYwiIMBJ1PsNxiN7HjzRDv5KYVWp1qaWc4dRvoLsj+gYdV6MmYCDMxWXkvfdhqBMONwI1ssH62WhWiRd84+lWKSwH5OvyotsGk608wjf1EOcAsS1PT898sBXldxiyLibpcrhku0O1fkwPxJ1X6Bk/tep5mCrwtxu6EuFpy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032953; c=relaxed/simple;
	bh=zkIpoQ8jmDk/18OLKcqQ9RL27qxOV+Yac0uB0SSO8QE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCj+vtdrinGBysvsGqnPy70d4LVYCsSm84X4sfrLv2qrgiVbyruaqr/4MxY7xvQBK03T+nNng7UMug9PxpZv48CPjBrDGJsIbe+h+fwPjFZkMuQCqE+Af4joyvOsqYFPwNiMnnzWPicipo8dEu8erKQpNansol/bXbGJwHqcqV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=KPM+NfCc; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=Ugn3Ywys; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="KPM+NfCc";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="Ugn3Ywys"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A8obOP3181305;
	Thu, 10 Sep 2026 10:35:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=zkIpoQ8jmDk/18OLKcqQ9RL27qxOV+Yac0uB0SSO8QE=; b=KPM
	+NfCcc8JzbKo3NhiZnF2iLBdZscxXbBX98nWgD6Kspq9TuyVxZJlG7c7jlf88b7n
	jiYLsdHgZZovTe8qLjkBzgpz8Z91JIrWYRpIi5zrsnV5SOVbqGFH0pXpg/pvjuya
	SWPr2apW7alL7SiV7QwZQbQV4wgknS2OP3qG2THagF4TyeVnf6aDvZ/ldrtrla+r
	obwqhfss8PPn/wPwWGGKEf7tczDYyVpbVnpNYjDroQCggKW8Vm+m9SDD2qLITgJG
	vOA2PMKnO1tc7VCmtMhJcsecuuJoUd03JyvKg4/BgOQYalsjhpewx6ce700QTGEX
	aongV2gQdoL2DDUcy6w==
Received: from cwxp265cu008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gkk89r7vy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 10:35:18 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4PerbIOQsZ4CO0UxGSfVGUL6VaIwHmLlKvPwf9Hv+RtQOr5fRp3OPQ3vGSGTisQj7Z6/vV5qP3levfbT1DaEXYs848NQHk1QKADzK1jLv6/pkOcJPQbRz/0EnCjFkjrK5t5BYWt7Rn0HE+05RujLNaG65TGDmdON+nmF3OLiXtKO3wCskXTsbN9GtolOUfsgzsXFpq+5qc6KY49tbJ8QhwGRfYLJKopeFGX4NukhuFlUCgNP9XQfc9D0jNQLlwccY3Rr0wJ7imBLIbTW1cezbknuWUWbljbDVIohWaT1C/HxVTuyLE8PLp5JqI4LZ7qhxvEXtPg9+kju3JjGZEqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkIpoQ8jmDk/18OLKcqQ9RL27qxOV+Yac0uB0SSO8QE=;
 b=t0wRW19Bkl7HXtd9HI2RclTZXb4DWAl+IaD6GP3u0yqyfSqEepZ9wA+PD/f+sEFAhyKaLUhp6t6hqAvFcXXlrCLNS+pK1IGbGTY+oQL45FyE2GGl7A8BG4ytyJp7o/DvKS1C3ZebC5fkmoE5nIzhKASz4vNiZEdXh6yV7CTHd+sm+kYuR+zZbaE7yhxYbmU2+p7+XGN/6m0CUdaVcSX9XkJypwzJ/LYpSerAgJfUQF5wuAmVyGs2e6IiRaymyL0csMR96HxHCYBUR94gw0mPbK+rmndInprjI/Pzdo7QJ23UVcCUb6RQzEL4YmwUqU0SAtZYL7H/68kyTlrQIagaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkIpoQ8jmDk/18OLKcqQ9RL27qxOV+Yac0uB0SSO8QE=;
 b=Ugn3YwysD6bUz9qTv+issAvZL8crMmiCjOVsreGaWtnhcG9dLsr9u1zYtDpI+Q+EGVR3mfDdveZ/LyQIkvi3m6xQ2W0ibQq5eoRQ3cPPLTHuf1uKJOcCDtcmG34v7QF0qSF2SLQsKg7uRYXLOBa8rgPV5AYq+Up1P5V0M18fxKk=
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d2::14)
 by LO0P265MB5144.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 09:35:07 +0000
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b]) by CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 09:35:06 +0000
From: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        Alessio Belle <Alessio.Belle@imgtec.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
        "mripard@kernel.org"
	<mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/imagination: Propagate map failures correctly
 from pvr_mmu_map_sgl()
Thread-Topic: [PATCH 1/2] drm/imagination: Propagate map failures correctly
 from pvr_mmu_map_sgl()
Thread-Index: AQHdOsFPuFxdnNYLOkCyM5GKiWsKMrbHmc+A
Date: Thu, 10 Sep 2026 09:35:06 +0000
Message-ID: <3675aee3bfe55e406e7b1081e519fb765b08a2e4.camel@imgtec.com>
References: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
	 <20260902-mmu_fix-v1-1-c55a23fb7cab@imgtec.com>
In-Reply-To: <20260902-mmu_fix-v1-1-c55a23fb7cab@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2913:EE_|LO0P265MB5144:EE_
x-ms-office365-filtering-correlation-id: a2cbe986-9bf2-4910-26d9-08df0f1ecc99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|3023799007|10067099003|5023799004|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 HPHZBeYn/HRDQ5FkyktsieVgYX6mGj2f3i6VLyWtgKOzmKSoIlxr/tGQ0w21lkqbFW7vruwKfpTl8pV2cRYNM5tMM0BNjuBRLSBmVfIrHU2TdvBMeQ/pRtj/rv7Heo2KogS0OBLtSkXuAEsJoIovAiPstaqvCilVbXzMtLzWZKXHvHrLraoXn5CEOJe+v2bL8Kb+Grh1Y8plLRrzzrsEM78idC7It5vjpdFLVi1HiEooSFJ75n+jZMIr568TmfSXKEt5R4Cfn/pF8DdpyNOSH5TKJAumW8Xk6LJr9h49JCCVEUGgseXMdHyupr7iqP3u0ldupkesAbDJfncsyuRH2w1XeUqnSU3dKU2Qr8lDa9ujJQPaG2bFDKB7Ru1AvKTYuoq+8i3Fi3CmndZphPw47VuV3lxVj9L34bFagg1lVTRGPGALQWkRShqQEoAC+XMn2rS4JnA3eqhYlaSErPUboahCVB9z1a8bhnDkZmu5MtkDoLKNYZpqc475rr1YIlLSBesgx9mGp/gWlfQLD67J77/jS7JBQNw0vFn3R5oRjyBYWpTfEhEVmSSmdJDx6hXPNAR+XWYR5cYvIuijKTuqA5s7EEW2vDhvWVVINy123S4LUVht8TV6g2j/Famt/U7AKk69MiN0waJ7YYy2QQ8NiVGW39+XE8brwe3ZJt7dDwkPm7lnBo+n87j66t78Ve6nvJGf3iEurFt6YjuT6flvRfXm7wqlaCmoVhh9yOPfq38=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGI0eVVSdDhqUnIvVmJYSXA2Q1Fka3l6RUU2WWR5NTl0a2lwTkRQa2d3aFJu?=
 =?utf-8?B?eGhzMUtaMjhqOEtmd1Nkd2RCR0ZlOVRFSWlqWklMQ3F6SjNIZ1c2WWtsdG9k?=
 =?utf-8?B?V2VBaVFOYWI0S0E2ZmhGOWFFVmpBVWpYZk1EUlRGb1BsL0xNVUQ3d1NZZXJM?=
 =?utf-8?B?VHMwZzhvdWZWRWpRUk1yYWprL0s1Y01WOWFkdWZOT1Bvd0dtNkJGV1ByY204?=
 =?utf-8?B?MGw0UDI2Z0xOR2xGYkp4U0llRi9WNkkxemFHcjlPTmUraU9idUhSTlhTN0RN?=
 =?utf-8?B?TkFWVENtOHFTeEdlSmZkTnVtbGhRYTA4V3VPVkNFK25WbDRLbU54ekpqUmlm?=
 =?utf-8?B?aWtvWUNIY1pMaU1iSG9zV3NEK1A0eE5mUXZ2UkhKQUo3RFZsREZMUy9uakRr?=
 =?utf-8?B?MjZQQUNZNG1Pc29WckdpVnhFcVljNGdXRkUzVEFOU2hOZ01vRit5aGJ5SENs?=
 =?utf-8?B?RmpQR3lkZ2VyVTVIUDZ5REtibkxPNlFCdWVyWlQxMnJTQVEwQXpKZnlkZ09N?=
 =?utf-8?B?eXJZWjFwSlQrQWY3U3crdEZ0NTh5bzJlMGZFeFpud0UwUDZFQzdEZEJjT3pG?=
 =?utf-8?B?TWYyaXY5N3dSY3hPMDkrQnZkcHVEdXhIQXNRNUUyNVpTbjU1d0g4NnkyZU9O?=
 =?utf-8?B?QkVlYUlqcjhDcy81TFlqNUVGck9TLzlPUDlkZlE0eHRLVEd1UUpUTWY3R2Ez?=
 =?utf-8?B?UFpodURZS3VnL2tiajdlSzg4ZHlDUXc3MSs0M0pycEpXQkNlUjEvWmhHcDJ0?=
 =?utf-8?B?SCsrSlF1YTE5V3hCTnJ2T0hZelhVbzFhWjlvaEErbDQwNjAvT0FKbVlUYlhW?=
 =?utf-8?B?NkxiY29SY05pOTdQaGlYSjBPUkE4bnRsOHk1ZWw0dEhrNkYxVzByOG1NMnR4?=
 =?utf-8?B?MzFwSlkwc3VCaHhXUS9WcDloZUk3TGxnK0gvbEVqWXlCZ09IaWhFanpxT0Qx?=
 =?utf-8?B?TVArN1NMRDFWejdZV3VOTnNmVFczS05HNFZHbHF6RVNQbFE2OVVMREpsK3Jv?=
 =?utf-8?B?bzA0eGVFVndXRCtRMEdOQ1lFQW5vcGZkYmhaZFBnMGppMlpZcXZCVlNCbnEy?=
 =?utf-8?B?S0RHZzVQMTdndkVTY3pKQXJzZ3VPWFNSMzRpVXVBTVRSSDc3ekw0dXQrUlBP?=
 =?utf-8?B?K3E5OEMvL1p2RktWMHFBL1UrQ1Y1MnAzWFBXS0VPb3RlWUpWTjN2dmZHYVJ0?=
 =?utf-8?B?dUpUYnhvMk5wSnZDeE9UaUJobFRRYzdSaHhqMjR4QWdaTzNTaFNERWMrSWNr?=
 =?utf-8?B?TG5WUDV5T2pRY0JPb0w2OG5BM1lZekZYTG5tc2VGaE45S2N5ZHcxNjJjOHg0?=
 =?utf-8?B?eGczeG5COFppcU0xUUZTdTVDTGxrVlVuNWluZUlLL04zRmxZN3NNQjlERGhR?=
 =?utf-8?B?RjZuMFU1SUl3cTg3aEIrM0l1VkR5VjA2OXp6VDhkYlZrYTdZU1gxNndUbkpV?=
 =?utf-8?B?ZTNyQU1RMVRaclNTS05ocTFKS1I1TzdyM0FWVS9sbzZidjJJMWxhMFY3MExi?=
 =?utf-8?B?RWlvN2FXcHlXNG9QdHNSRHZoVGZydTc1dk5ZNHQ5WVUxU1lPVVlPdVp6Z1dl?=
 =?utf-8?B?dUczeXI4QXpvMEVCclJpRjI1VWNMODZKVHB2NVFXYXJ1Mm9QZVJFRGNGUGph?=
 =?utf-8?B?N081ZEc3Qmh5eEh3VExNQ3Z5VWVSaHZJUVdJYWdKYkRaYkZ1M3d4UUdlQmo0?=
 =?utf-8?B?YTl1a25PUHY2aW9yZEprLzE1Q1hRU1ZOaFhpUFBZTmt2bGhaSTBwaENDbHhs?=
 =?utf-8?B?b0VoYXh0d1QvNW9obDE2Rjl3RUg5d0E0M0xncitMWkpGWWNFSmlyYXdrTVZl?=
 =?utf-8?B?YUpyT2d4b3B0eG5PMGdQeU0wYUF5SGJMUXF3U09xb2hCQWswWjZETy8yeUIr?=
 =?utf-8?B?RSsxRlliVVY0M3FlditKaFVWMlRTaGZ0a1JLRmRwOElDUVUxdkVPbk5JS1pG?=
 =?utf-8?B?bVE1d1ZLM2huODVNellCdERoN1hHU3l6dnFQS3ZUaDFKbjFsaUZycVcvUWRy?=
 =?utf-8?B?Q00yOTA4UDZvbjB5UVc4bjJyN3cxb1pZUTZ6bUN4dksvWjF1cktBNUVmdHNk?=
 =?utf-8?B?ODhjZHFYU3ZvMkVPYjVsK0kzK2RyWnJzaGxIY1UyQTVIU2JBQjRIbllMYnA1?=
 =?utf-8?B?T3N5SFVCcHN2NFE3MUUxeTdBOG5KUFRuODVtMWFGWWM4aE1yZ0paRkhmWjlC?=
 =?utf-8?B?QTM4ZGlNUmJreS9OTjM4amtzMlo4K1ZSVyttaitzbDhNS2F1VzdHdlROWWtN?=
 =?utf-8?B?RkJMNkRiNzVoMVMzTW5qOUZBcU1KelNoaG0zK2h2cW9mSEcvYTRpbWtxaG5j?=
 =?utf-8?B?WTlZbStvS3N3aUpHaTJuMGFMV21PYTZ2VUYyUDM0aE5JUlBGdEx0ZDJTenhq?=
 =?utf-8?Q?whmuMJ/LgfoWUa9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C82C756DD3BC31499D0442113A00B90D@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TWkTgnWnVlwjGQtFoWfc+SZXGBXVnOEQJXF5DSwh1StK00hddJBxnyYJ9iey59KMc1XPPaoXo2DHDCFXXWzWdkPSJCJvwY8hFxaigfLSccjhaAdaDPc69X1SXV4JFifv6tl28vP7+wiooPgWCL66FBmgRkcKlcCmMe+q1ZNGEqeZ5Gs6+hFQh7QND4q1Zm7uTFiLGX5yZlN9V0tqklsJH1HD3wxIbdd73XvUSpPwaXkoNqg5TfpIH6RhA48eQOcM/VFv2qn0jCWG/ibXfTBc9JrJtx8ArM0TcMqny9m6hcxX342dfF9dlK/ehOvFjJ1puw9XdHfxeL++P1k8sjZFAg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cbe986-9bf2-4910-26d9-08df0f1ecc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 09:35:06.5546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tvtiSrSKoxFajWYGvR5zwD8W9IV0h+xVdzUVZ3sySk7+IK88x0I94ds93GsVDn8PKFAe0F54BiYgva/IHlKO1BQhmrI4k4CteL9zjnj1ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5144
X-Proofpoint-GUID: 3eAIq4eRUn7kGAsZAzK2cHC3SicLvjQ8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX6SY0Ft2+olqc
 MxXQ9VeKNMfRwkB8oaL8ek1p17bGUGw5CkP5/4KmYuhr0g8JjQ+fzsElwUvAUFLkGF80z6DccD2
 lSm0/ir7P5iKc4LnJePuLwrkj8e63No=
X-Proofpoint-ORIG-GUID: 3eAIq4eRUn7kGAsZAzK2cHC3SicLvjQ8
X-Authority-Analysis: v=2.4 cv=XJyl2ghE c=1 sm=1 tr=0 ts=6aa279d7 cx=c_pps
 a=AX1dvq5UWgG4RJnRAZdcPA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=1XywCNsVXZosl8JwlQgA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX3dmok9QUJIZS
 urD1MoQ6Z6cnDZ8U+sT0wofEzOVt0E+Pjdk6nbB5swI6GTH6TJBEMbscYMsSIZ9zp6EPq6P4X7a
 j7tzUttmCiBHCBEjPfhCzgGKXVuElmkFHSi/q/v7jRcVP0D5grDaw6XkW455wJwa0hfVC86DthO
 KGvjSe84A9XpH8gtPGloBfW9xK2c0/hEKtuQj6fgszQ+S4keXlwGiKrJLhq0KzKYS1v8QFMX6qq
 OrHasdQo1sDlZAVtRefPywaDIMNrvPT8ooUuabwupILgFuQZopQzLhErhluJfzLfHrqxv4Ac/m3
 nTeLdgjbgxRdIYIvaTt4qsdRcLFvmiuwImppT+KrsJdpLHCb1ll4ibXnVbtOZmeM0xo2fIHRRpe
 RpNkiQOm8vBZlh7JL9uTrAVIFFMnd0Ltt25wqjIPzJlABrI7qZ+DF9DiJd7gxpruQfe6OeG9Lp1
 KyFqpg62puoHf38rpvw==

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE1OjI1ICswNTMwLCBCcmFqZXNoIEd1cHRhIHdyb3RlOg0K
SGkgQnJhamVzaCwNCj4gKioqIE5PVEU6IFRoaXMgaXMgYW4gaW50ZXJuYWwgZW1haWwgZnJvbSBJ
bWFnaW5hdGlvbiBUZWNobm9sb2dpZXMgKioqDQo+IA0KPiANCj4gDQo+IA0KPiBNYXAgZmFpbHVy
ZSBmcm9tIHB2cl9tbXVfbWFwX3NnbCgpIGludGVyZmFjZSB3YXMgbm90IHJldHVybmVkDQo+IGNv
cnJlY3RseQ0KPiB0byBwdnJfbW11X21hcCgpIGludGVyZmFjZS4gVGhpcyByZXN1bHRlZCBpbiBw
dnJfbW11X21hcCgpIGludGVyZmFjZQ0KPiB0bw0KPiBjb250aW51ZSBpbnN0ZWFkIG9mIHJldHVy
bmluZyBhbiBlcnJvciB0byBjYWxsZXIuDQo+IEZpeCBpdCBieSByZXR1cm5pbmcgYSBwcm9wZXIg
ZXJyb3IgY29kZSBmcm9tIHB2cl9tbXVfbWFwX3NnbCgpDQo+IGludGVyZmFjZS4NCj4gDQo+IENh
bGwgc3RhY2sgZm9yIGNyYXNoOg0KPiBbIDExNzkuMjg2MjM3XSBVbmFibGUgdG8gaGFuZGxlIGtl
cm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCj4gdmlydHVhbCBhZGRyZXNzIDAwMDAw
MDAwMDAwMDAwMDgNCj4gWyAxMTc5LjI5NTA2N10gTWVtIGFib3J0IGluZm86DQo+IFsgMTE3OS4y
OTc4NzddwqDCoCBFU1IgPSAweDAwMDAwMDAwOTYwMDAwMDQNCj4gWyAxMTc5LjMwMTY1Nl3CoMKg
IEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cw0KPiBbIDExNzkuMzA2
OTg3XcKgwqAgU0VUID0gMCwgRm5WID0gMA0KPiBbIDExNzkuMzEwMDQ4XcKgwqAgRUEgPSAwLCBT
MVBUVyA9IDANCj4gWyAxMTc5LjMxMzE5OF3CoMKgIEZTQyA9IDB4MDQ6IGxldmVsIDAgdHJhbnNs
YXRpb24gZmF1bHQNCj4gWyAxMTc5LjMxODA5Nl0gRGF0YSBhYm9ydCBpbmZvOg0KPiBbIDExNzku
MzIwOTkzXcKgwqAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNCwgSVNTMiA9IDB4MDAwMDAwMDAN
Cj4gWyAxMTc5LjMyNjQ4M13CoMKgIENNID0gMCwgV25SID0gMCwgVG5EID0gMCwgVGFnQWNjZXNz
ID0gMA0KPiBbIDExNzkuMzMxNTQ2XcKgwqAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERpcnR5Qml0
ID0gMCwgWHMgPSAwDQo+IFsgMTE3OS4zMzY4OTVdIHVzZXIgcGd0YWJsZTogNGsgcGFnZXMsIDQ4
LWJpdCBWQXMsDQo+IHBnZHA9MDAwMDAwMDA5ODIyYTAwMA0KPiBbIDExNzkuMzQzNDAyXSBbMDAw
MDAwMDAwMDAwMDAwOF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsDQo+IHA0ZD0wMDAwMDAwMDAwMDAw
MDAwDQo+IFsgMTE3OS4zNTAyNDNdIEludGVybmFsIGVycm9yOiBPb3BzOiAwMDAwMDAwMDk2MDAw
MDA0IFsjMl3CoCBTTVANCj4gWyAxMTc5LjM1NTkwOF0gTW9kdWxlcyBsaW5rZWQgaW46IHBvd2Vy
dnIgZ3B1X3NjaGVkIGRybV9zaG1lbV9oZWxwZXINCj4gZHJtX2dwdXZtIGRybV9leGVjIHhoY2lf
cGxhdF9oY2QgeGhjaV9oY2QgZHdjMyB1c2Jjb3JlIHVzYl9jb21tb24NCj4gc25kX3NvY19zaW1w
bGVfY2FyZCBzbmRfc29jX3NpbXBsZV9jYXJkX3V0aWxzIGR3YzNfYW02MiBhdDI0IHNhMnVsDQo+
IHNoYTUxMiBsaWJzaGE1MTIgc2hhMjU2IGF1dGhlbmMgc2NoX2ZxX2NvZGVsIGZ1c2UgZG1fbW9k
IGlwdjYNCj4gWyAxMTc5LjM3ODk5Ml0gQ1BVOiAxIFVJRDogMTAwMCBQSUQ6IDY4MCBDb21tOiBk
ZXFwLXZrIFRhaW50ZWQ6DQo+IEfCoMKgwqDCoMKgIETCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ni4xNy4wICMxIFBSRUVNUFQNCj4gWyAxMTc5LjM4ODEyMF0gVGFpbnRlZDogW0RdPURJRQ0KPiBb
IDExNzkuMzkwOTk0XSBIYXJkd2FyZSBuYW1lOiBUZXhhcyBJbnN0cnVtZW50cyBBTTYyNSBTSyAo
RFQpDQo+IFsgMTE3OS4zOTY0NjddIHBzdGF0ZTogMDAwMDAwMDUgKG56Y3YgZGFpZiAtUEFOIC1V
QU8gLVRDTyAtRElUIC1TU0JTDQo+IEJUWVBFPS0tKQ0KPiBbIDExNzkuNDAzNDE1XSBwYyA6IHB2
cl9tbXVfb3BfY29udGV4dF91bm1hcF9jdXJyX3BhZ2UrMHg2Yy8weDEzNA0KPiBbcG93ZXJ2cl0N
Cj4gWyAxMTc5LjQxMDE0MF0gbHIgOiBwdnJfbW11X29wX2NvbnRleHRfdW5tYXBfY3Vycl9wYWdl
KzB4NTgvMHgxMzQNCj4gW3Bvd2VydnJdDQo+IFsgMTE3OS40MTY4NDhdIHNwIDogZmZmZjgwMDA4
MzlhYjhjMA0KPiBbIDExNzkuNDIwMTUzXSB4Mjk6IGZmZmY4MDAwODM5YWI4YzAgeDI4OiAwMDAw
MDAwMDAwMDAwMDAxIHgyNzoNCj4gMDAwMDAwMDA4ZjM4NjAwMA0KPiBbIDExNzkuNDI3MjgzXSB4
MjY6IGZmZmYwMDAwMTZkMWRmOTggeDI1OiAwMDAwMDAwMDAwMjQ3MDAwIHgyNDoNCj4gMDAwMDAw
MDAwMDAwMDFlNg0KPiBbIDExNzkuNDM0NDEzXSB4MjM6IDAwMDAwMDAwMDAwMDAwMDIgeDIyOiAw
MDAwMDAwMDAwMDBmZmZmIHgyMToNCj4gMDAwMDAwMDAwMDAwMDI0Nw0KPiBbIDExNzkuNDQxNTQw
XSB4MjA6IDAwMDAwMDAwMDAwMDAyNDUgeDE5OiBmZmZmMDAwMDE2ZDFkZjYwIHgxODoNCj4gMDAw
MDAwMDAwMDAwMDAwMg0KPiBbIDExNzkuNDQ4NjY4XSB4MTc6IDAwMDAwMDAwMDAwMDAwMDAgeDE2
OiAwMDAwMDAwMDAwMDAwMDAwIHgxNToNCj4gMDAwMDAwMDAwMDAwMDAwMQ0KPiBbIDExNzkuNDU1
NzkzXSB4MTQ6IDAwMDAwMDAwMDAwNjA4MTAgeDEzOiBmZmZmODAwMDdmZmZmZmZmIHgxMjoNCj4g
ZmZmZjAwMDAwNDE5MDQ4MA0KPiBbIDExNzkuNDYyOTIxXSB4MTE6IGZmZmY4MDAwODUzZjcwMDAg
eDEwOiBmZmZmODAwMDgxMWFlMDAwIHg5IDoNCj4gZmZmZjAwMDAwNDE5MDBiOA0KPiBbIDExNzku
NDcwMDUxXSB4OCA6IDAwMDAwMDAwMDAwMDAwMDAgeDcgOiAwMDAwMDAwMDk5MGM0MDAxIHg2IDoN
Cj4gMDAwMDAwMDAwMDAwMDAwNw0KPiBbIDExNzkuNDc3MTc3XSB4NSA6IGZmZmYwMDAwMTZkMWRm
NjAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDoNCj4gZmZmZjAwMDAwYTdkODAwMA0KPiBbIDEx
NzkuNDg0MzA2XSB4MiA6IDAwMDAwMDAwMDAwMDAxZmYgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgw
IDoNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiBbIDExNzkuNDkxNDMzXSBDYWxsIHRyYWNlOg0KPiBb
IDExNzkuNDkzODcyXcKgIHB2cl9tbXVfb3BfY29udGV4dF91bm1hcF9jdXJyX3BhZ2UrMHg2Yy8w
eDEzNA0KPiBbcG93ZXJ2cl0gKFApDQo+IFsgMTE3OS41MDA1ODJdwqAgcHZyX21tdV9tYXArMHgz
MWMvMHgzODggW3Bvd2VydnJdDQo+IFsgMTE3OS41MDUwMjddwqAgcHZyX3ZtX2dwdXZhX21hcCsw
eDQwLzB4ODggW3Bvd2VydnJdDQo+IFsgMTE3OS41MDk3MzJdwqAgX19kcm1fZ3B1dm1fc21fbWFw
KzB4MjUwLzB4NDRjIFtkcm1fZ3B1dm1dDQo+IFsgMTE3OS41MTQ5NTJdwqAgZHJtX2dwdXZtX3Nt
X21hcCsweDQ4LzB4NWMgW2RybV9ncHV2bV0NCj4gWyAxMTc5LjUxOTgyMl3CoCBwdnJfdm1fYmlu
ZF9vcF9leGVjKzB4NjQvMHg3MCBbcG93ZXJ2cl0NCj4gWyAxMTc5LjUyNDc4NV3CoCBwdnJfdm1f
bWFwKzB4MWY4LzB4MmE4IFtwb3dlcnZyXQ0KPiBbIDExNzkuNTI5MTQyXcKgIHB2cl9pb2N0bF92
bV9tYXArMHgxMmMvMHgxODggW3Bvd2VydnJdDQo+IFsgMTE3OS41MzQwMThdwqAgZHJtX2lvY3Rs
X2tlcm5lbCsweGI4LzB4MTI4DQo+IFsgMTE3OS41Mzc5NDFdwqAgZHJtX2lvY3RsKzB4MjFjLzB4
NGVjDQo+IFsgMTE3OS41NDEzMzddwqAgX19hcm02NF9zeXNfaW9jdGwrMHhhYy8weDEwOA0KPiBb
IDExNzkuNTQ1MzQ0XcKgIGludm9rZV9zeXNjYWxsKzB4NDQvMHgxMDANCj4gWyAxMTc5LjU0OTA5
MV3CoCBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDQwLzB4ZTANCj4gWyAxMTc5LjU1Mzc5
MF3CoCBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KPiBbIDExNzkuNTU3MTA2XcKgIGVsMF9zdmMrMHgz
NC8weGYwDQo+IFsgMTE3OS41NjAxNTldwqAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHhkMC8weGU0
DQo+IFsgMTE3OS41NjQzMzRdwqAgZWwwdF82NF9zeW5jKzB4MTk4LzB4MTljDQo+IFsgMTE3OS41
Njc5OTZdIENvZGU6IDU0MDAwMzAwIDM1MDAwMzYwIGY5NDAyMjYxIDc5NDA5YTYyIChmOTQwMDQy
MSkNCj4gWyAxMTc5LjU3NDA4MV0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0t
DQo+IA0KPiBGaXhlczogZmY1ZjY0M2RlMGJmICgiZHJtL2ltYWdpbmF0aW9uOiBBZGQgR0VNIGFu
ZCBWTSByZWxhdGVkIGNvZGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFq
ZXNoLmd1cHRhQGltZ3RlYy5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfbW11LmMgfCA1ICsrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9p
bWFnaW5hdGlvbi9wdnJfbW11LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X21tdS5jDQo+IGluZGV4IDNjYWM0ODJlMTAzNC4uMTc1ZjBiYTRkOTkzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gwqAj
aW5jbHVkZSAicHZyX3JvZ3VlX21tdV9kZWZzLmgiDQo+IA0KPiDCoCNpbmNsdWRlIDxkcm0vZHJt
X2Rydi5oPg0KPiArI2luY2x1ZGUgPGRybS9kcm1fcHJpbnQuaD4NCj4gwqAjaW5jbHVkZSA8bGlu
dXgvYXRvbWljLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KPiDCoCNpbmNsdWRl
IDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiBAQCAtMjU1Myw3ICsyNTU0LDkgQEAgcHZyX21tdV9t
YXBfc2dsKHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQNCj4gKm9wX2N0eCwgc3RydWN0IHNjYXR0
ZXJsaXN0ICpzZ2wsDQo+IA0KPiDCoGVycl9kZXN0cm95X3BhZ2VzOg0KPiDCoMKgwqDCoMKgwqDC
oCBtZW1jcHkoJm9wX2N0eC0+Y3Vycl9wYWdlLCAmcHRyX2NvcHksIHNpemVvZihvcF9jdHgtDQo+
ID5jdXJyX3BhZ2UpKTsNCj4gLcKgwqDCoMKgwqDCoCBlcnIgPSBwdnJfbW11X29wX2NvbnRleHRf
dW5tYXBfY3Vycl9wYWdlKG9wX2N0eCwgcGFnZSk7DQo+ICvCoMKgwqDCoMKgwqAgaWYgKHB2cl9t
bXVfb3BfY29udGV4dF91bm1hcF9jdXJyX3BhZ2Uob3BfY3R4LCBwYWdlKSkNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX2Vycihmcm9tX3B2cl9kZXZpY2Uob3BfY3R4LT5tbXVf
Y3R4LT5wdnJfZGV2KSwNCj4gIiVzIDogRmFpbHVyZSBpbiB1bm1hcHBpbmcgcGFnZXNcbiIsDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2Z1bmNfXyk7
DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOw0KPiDCoH0NCj4gDQo+IC0tDQo+IDIu
NDMuMA0KPiANClJldmlld2VkIGJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1n
dGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxleGFuZHJ1IERhZHUNCg==
