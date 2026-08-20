Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF53D9DB3
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220958; cv=fail; b=ArkUMZn74XBys7bbVxQLDePg+FAwE2UW+nFKmdRFGUO/zTn/GLh6ZmOyhtF2zuqaKhDlsy6oR5yzMAsD8kJYnkXsarNhdyd8BAnagYh6U53MpEQxyesfOCdxHRshhSnzUuHvYH8+S//gCCoqtU8UOCSb7viwb+n3gxAmP/JB9tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220958; c=relaxed/simple;
	bh=gxpQ83SLqvDNrE5GgS0G6/KxxixfD9oscB98HRGNStU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=khSWNLVZqf966TZe5nhxn3LwoWk1DhjMetJAQj4gvwPV3swgZ4NhwEG3dASx30NEsPqDaq+EiDXkd1RkMjy6ZqZ8yhJ7qgduZtP+sXdBHWAyHqN/muTenzXN8A4z7tii80KulrEKcnpJOb3EFzL7ICa+oynQ5uEOshmXIE7N5v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DaO2oAQf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=orTMVcMW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DaO2oAQf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="orTMVcMW"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K9cvDa2202522;
	Thu, 20 Aug 2026 10:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=gxpQ83SLqvDNrE5GgS0G6/KxxixfD
	9oscB98HRGNStU=; b=DaO2oAQfaicvYkeFqLj7wYVUmLDKgcHiO9uJGGet++Hpu
	KEqYmsuJWf8vsRbssJVrztJQl4W5+GpTCWXT4F6VBIcvk0zR1wxrn5s0Hy0+MsdY
	J0cCoRWIQ+8a0xPcYhF5I0nT0xxTTo+T0SQQZ3i266GX16sGLjgLJUWTlEo3qXwG
	EQeo0rf1g1k9EibTUIL665SV4FRELJv1CbnsWzbu3usas3HTctRuSP2yyfvNEvQh
	/SgUeMc9YwDJg6L6S7ikKVyMc2qhdU98K1rYE0AmHqwRnTc0DMfxMtMooAyZrFbe
	4HFM3sWcF245ZFfhB75GhMKvMYLl80h3I1rozh/VA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9tya1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 10:15:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KA9vZQ020533;
	Thu, 20 Aug 2026 10:15:35 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejfa0fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 10:15:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfmyrKsS6oWRCwK9xZ8oNKQrbqMcX9e+KCm//GWG501LS/r9DUiQNWnukXem9U+tSJi/7OY7hNonHN43/2t7b8pBPU8dhv63NcuSC2b4gzTexyEO9cEf7pqNd107YsxtjAdbC9dbfjZvJVOYzcWGNk5V/85Mm6tY9vtNH7Gu54GUmPmJhqv8bhdinyx2VGaR/A/RxrTxB6IXYDncx1RElOis4cboG9nR9Rq6Mse28HyqC6jyqdbGu55uV6sL6azByPVQ3Ei86Ft55u51vrAGzZKJboE06ghugskGS78lXi0liP2ZyhYZ/nYvzk55gikSRiOCaCs/r7h0YrmhyFfiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxpQ83SLqvDNrE5GgS0G6/KxxixfD9oscB98HRGNStU=;
 b=uCVbrni5NHuVQXqlg6ScFHOG1uCYjNbM1EvtwQbC7Jx2CbDWjkepIJlPlsUpPQH535HnJqlK+tq/D+Dw+OatEn0GePZMejBOR0C0NUZzDPU/5aCvSAjdQ9bTwGvPfULiYNT1J+qa6/QvPz9Y80aeQhVNAlYFOsUbQZubG9Nc909QN8hoWXUDt+6Yu7x7RHNPdqXMwB8ASX0ebTgmokxsSVvF9rSW1A4dIKldIA5g7RT7feAigI4x2P/6gw1g95kDrjfCes91oZqY12Z6Ah8YLAf/Y1n0sgm1tSno4dS98TKSPtXNv8+ewdfvk20ByG2Twy1NHJbsJVbbIz/4WfCNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxpQ83SLqvDNrE5GgS0G6/KxxixfD9oscB98HRGNStU=;
 b=orTMVcMWp2pw6xTqzwzislhMisjPYUrIewMnDX9TWdXcnljTsgCbnRcVgXT0PrVK20mPrCXxbWjbjOaYGcUDIFIWRjGFOffbvumhqhrpWwittRP182l8uzaXopC+XArOS3vI84NsSPYVcs3rawZWlxNO4fzjU2AQXkexMIPK33g=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DM3PR10MB7970.namprd10.prod.outlook.com (2603:10b6:0:40::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Thu, 20 Aug 2026 10:15:32 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 10:15:32 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "sashal@kernel.org" <sashal@kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "willemb@google.com" <willemb@google.com>,
        Dongli Zhang
	<dongli.zhang@oracle.com>
Subject: Re: [PATCH 6.12.y] net: tap: set skb->dev before parsing virtio net
 header in tap_get_user_xdp()
Thread-Topic: [PATCH 6.12.y] net: tap: set skb->dev before parsing virtio net
 header in tap_get_user_xdp()
Thread-Index: AQHdMIzVYc0ujQsN4kShTbblXJapQQ==
Date: Thu, 20 Aug 2026 10:15:31 +0000
Message-ID: <8590f5d9beb6fe031a92cb0ddf716badc7106668.camel@oracle.com>
In-Reply-To: <20260815155517.786060-1-sashal@kernel.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|DM3PR10MB7970:EE_
x-ms-office365-filtering-correlation-id: c9f100a0-91b1-42a3-5227-08defea3f792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|6049299003|366016|10070799003|1800799024|376014|38070700021|4053099003|56012099006|10067099003|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 3ufGj33Y+BrA8hTmhr+BtCs3K7fXaoXTed6CEx/emArRgJV/ZEoDPRb2jR5uFtwbxfQyVdwY0yS+csEZFvsxAMcFzjaErjpOiLZ3omS5eLF/fspfKs1G+yBi80h2tYOTIuVN2LKcIJZQYOmhr+POHfu9V/ulirvsueA+ERSu8KjpTgFx6xlNVp0q/LXWdq01iK4u0r26jI06r/fZ3J6xcHiA92sZz1MvO/HHG1ao0fgakwlYuo2Xblb5Le7ylsygXMYyXIUnylxuOyEnbxsRrxv5t+egVoM0SluMfOfvJXGF3Ua2UD26CHR+gnFbMaP97TRJIfytuVG3wBoNGZvgSaYwf1RRVRMjSnrVcJILL1iwv8eXtcTNjZMVib4EbWSSmhFUPOzSMo5IK2oOr0pu42TvVGdU/CUs1MBU0r1rlx14/ITyVZ8fFyidKTFe3NFNx6XLAhKg2pxQvxxgD30bOp5xCVDYme6K/h6Mfj3nw5XyV7RRp5lSWeTchAp4ZlECA3+lsov1oXVAk8UAol4JkmU40iYoWp0wLSdB7xpsbq7bFD9UJAAoueqbttGI1zct832VCc5rzFrXep/mwXjLqQMkoYl5UZgmDImzbZzGiNsYSy4Ny9p8NLqxzMenu7r1rjb66SjxyqYHGAgJanBSsQxDOaVANEryIw42/xQssGSxANmRGSXuMeWvZqO89RZ3oMsgzxkHcNEyHOGT6p1pUuwT4W4+9S2FzX55d7f1wNo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(6049299003)(366016)(10070799003)(1800799024)(376014)(38070700021)(4053099003)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkFObVR1MGRvQmQ5YklyWnprVmpTZWloZytYTWRqbzFtUDhTSDZoTVVXRlI1?=
 =?utf-8?B?SUZSMkkwRkd5eVVyMkVXb3BQT0JoNXlHcHJVSzNkclNLcUl3M1NxWXp5R2dn?=
 =?utf-8?B?WitMZ1FscG1mbGswSTdQdm1wQXVhbXpYYjJ6TGw4aHVWTTRRSkltRThYZ2Mw?=
 =?utf-8?B?WmVpREZySmlyZGIrNXlSM2laNHVUQ3ppR1hacjhQdzVHbVRVRkhRQUFZUTdR?=
 =?utf-8?B?dmttYlVHeGhRS01ocGEzQVhrL05OclZPRUV4N3RlelJCWXBuYW5IOTgzMG1T?=
 =?utf-8?B?c01NOXE0OVJwS0sycTBRaDZxb2pGU3RiOUZCSlFBbExUbUdjUG5pYkpMZFls?=
 =?utf-8?B?SHlpclRYbVh1N3c3VVZkOHZuTC9KNkdsM213MXEwRTROWTh2N2xuOWlqcnkr?=
 =?utf-8?B?cFVOUlFaaExZSDVtZnJOSWlCZUs3U0JhcnpmUGxuUUhlQmVmZTVjQVM2WUN2?=
 =?utf-8?B?eWxkcUZqTzlFV1Z3emZGOGNwRTlXYUVzQ2dWeTNjMVEzUlhaa0lZSGs2L01w?=
 =?utf-8?B?d2xEU3JDTy9hY0pvcUpoenlpMGdnMk5aMzJGY2VMOEx6MzZjNXhoQ1djMHBm?=
 =?utf-8?B?Wi85NThxdTFMSDFHUXpNV2M1TDFENk1vL255QjUvTXVpWDdBOEIwMnUxdDZJ?=
 =?utf-8?B?b0g5d1U2SWp4eHJEWGdJMWFoSE93OENKUzV0ajhJQVpNWm5JV0N2YVEwczRi?=
 =?utf-8?B?ZExJRVRiRFc4eXFTRVh3WldJaXZXQmRPdndueExESExER2kwMWZvVisyOXcw?=
 =?utf-8?B?Vi9jdHI2bGpYTGtHeUtDcjBBQjlwY3pUMXhnMXVsZ1RWYmNTYjFxOGM2NmRv?=
 =?utf-8?B?WlZueVdIMHlJaGV5a245NE9GRWorZVBVYmhwTDRKbDJZQ1VPS3I2ZGFzdUcy?=
 =?utf-8?B?UUJBZ2t1Zkx3aDQ5VnI5aUlaZHlhUXdEYUJUTUVSeVJzYktSTWt5eDFCY3Ju?=
 =?utf-8?B?TndOT0xISTdRRDBiNGpLajcvdlM3UGVNbVBHMUErbWJqZXJtTXpIZ3R4QUU2?=
 =?utf-8?B?MkdwVEM4Y0piNFVaSmJ3UUlEOXVyaWJjUWJDSjZnNzdFOXlIcWR4YkVmRDJV?=
 =?utf-8?B?YnRuckJOMmJ4ZlA2UGRRVGRub0I5dmxTWmhwZ1dwVDdxanhkSy93RytWT0Qv?=
 =?utf-8?B?Rkk5a2tSNjh5Z0xtM3NQc0crSjFLdlE1V3AyTksrZ3hMRzhSTVlOWWJIYyth?=
 =?utf-8?B?akpjcjV3QXFaeDZ3UjJha2xQeVF2TGt2QkdWZmRjbkZhWUQwd1VPd20yd2Ew?=
 =?utf-8?B?MmcyYk5XeElHYVYzTFEwaVdYbjRucnpsRjNIeW4yTkdCVElMekpXaExVR3ln?=
 =?utf-8?B?UEE4QWNnRzlIak4zV01scVRrQ09vR2hLWXc1eUZuNjIwa2x3SnpobHNUUEZG?=
 =?utf-8?B?aXpUd3EyWHYwWGJSOEVDdnA5RUovN3RaUnYyeWRGQi9kS0E0Y25LaGl2OVp2?=
 =?utf-8?B?dWk2Wk1LY05OeUpybkNOeDRZemJ3b2hFeEc3U0d0SHNvNDhlU0VFY1dtV29k?=
 =?utf-8?B?Mm1PR0pRUmxLWEZnY3ZSdlRQTk1iVldpM3hyRTFTano2VFREdDZ2THBiNUlS?=
 =?utf-8?B?VjRGUFBYWGlMZmFXSlNUeThTYnBsUVQvNXIzMm1WQ1ZZUEhKN1NLVzVucGFL?=
 =?utf-8?B?anFWWTluYzlCNEFhcWIya3hlNCs2RVMzdWlZSnFGOFlucFQ4MWNEemlVVUox?=
 =?utf-8?B?QlhsN1RKK1pyZCtyeGR0aXB1THhFeXZjc0MvcHNoRmdjRG04dVlxcURQTm9j?=
 =?utf-8?B?eEFsQXFNWDdSSVduUi9BdGh3bEY5cVpLWmRlV043VVZLZFFNU2ZETCtGVkty?=
 =?utf-8?B?WVVJRWNPbWQ0TGNaSVpqNGE2aXpWRTZSWnhFLzBaMGxWNHlkN2lWMjZWaGJr?=
 =?utf-8?B?REdWY1NnZ3NqT1I5R0FwcW9BbkRjN05GSHpDanFWa1IzdjZMZjJTYktCZ29D?=
 =?utf-8?B?a2xmTWZET1QxaUFGQVB0RERuQmFEY294ajZ5RkRLckR1RHB1THg1V0JZNlkr?=
 =?utf-8?B?M3Jka0dUZDY5OWZEVnFGTTVHbnVTOXpMWFR6bEQ5OVBHejFVbDhuakZFTzBy?=
 =?utf-8?B?TkZmanRxcjJzenl5NUoyZFZ3UGhJY3ExSXo2MUpJYmpNUWROSUxLVlkxd1lZ?=
 =?utf-8?B?K0EwYU1pblNoUzlPV2huVGxHeXZEN3p3ak4rRDh0VlFFYjdvMk9hRVZ0aDlF?=
 =?utf-8?B?MDgxSTk3SktQaURHZldnQ3lpVkNJKzRLNVVXakNFT2pCV3JlbHhzei9IS2dn?=
 =?utf-8?B?cVFMUDMwUGZYV3pTR2RCc0dkWnFlWU9QT2FHQlpta09kK2tCOUQwMVpSMFB5?=
 =?utf-8?B?UGZqN1AvMDdURmJBU24rZ3cvMElRekl2Qk1qaHJ3YkNsTXJnQWwwSDlCamx3?=
 =?utf-8?Q?Lgec1Wlhc8LyWRjNnK4M3dQcXlK4O9N0/Hx7LfzvRgJAv?=
x-ms-exchange-antispam-messagedata-1: OHjmDYqVxUt8EY9nkFTaqdaU1HjGA19nTKo=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-xMMe3h9+LWtWlDDEBqDL"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	W4GmUefHsae9wMNLMj1qJHZD7EZJMVyVTlqUk0lpTDfhFSe2kc69O5cFcXDcTZgIGA61jVb3y5gdMoGRKWhMrWxVF+MRpAbkjJd2LIXDDOC39pxMPXhCRgDxEeWziuNwVr8w5gzL5XNRHdLsRGpiYFM1afKdQOL18/ymvSs5mYDXZcQ1fTwWEfJsf8yOQz3yamkBjfG/6nGoAQEZiMqb/7fMAJBE6E65wp6PV1Q2daKLY6vl4oa77oiDPoWxZ9Axu4AbwPCqYyFQMacNl9QzB8PRu0E4tvrsldyUVp/90O/Ky78wQ+WipCJFejuBFVdhXX2/QZ4foL9vzr88UOw6kg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DHHpoFpP9ichA0uiXXZF9iaW1IGSlqSZYc9XWyxQtEdpV3SPNmM8724sPgK99j7ei+b+SsaV7xlH56ugKhCVYfip9YEO8DGb3shlVimnBItUNXr9uBQMW/azel5qn7vZbeKBsz+bxti7+0OYZ93QG5N9oO3uHoTNfkcHkmY6TN4ZErnwVj2/RgWEl1XOJG6/M3QIKF6vB6kl9liL+HdktsuZ1Z2gUqfkGt75lb7ZvuwddQ3F3ln0f9I8+EVEKzJntn242/pIC5iBT4m7+DhQ976DtCVtjzFBY6ZYS2sIfGKj5F0JG+9vRm6S5jAlF9rp/wzj9kWrg+cTblQoU6ZocxQSYUnGjdHZfS0w06pMeXiannod6P9qvjirC48s3fG3icSTKigGGGjv2qf22U5VbgauFtywXCCKcI3g9q0Xny959NxSaAOtQIFsJInb+JVXJfqauwlY2F8vISWSlA+0vyy1GlgN/UumGTK/CfHNFVJtYtTv7OpoPne6nErv5SPsnzBdVjdoIi/IfA5X2FJxkmisLIu3lHyWu6Kfa7JutJ+9CZ+BIPvg7i5u8ktE7gCIzF+7PY2orOtjoFQYN+vioEe4ZphJuP7InncOs9bTzZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f100a0-91b1-42a3-5227-08defea3f792
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 10:15:31.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXgIOerX92x5WQkmk+Fv6wyd5QZ0njiK488qy7hHDlWWXCDZ8vxQuvPtQBhmc0bO/PFP2LNjare/aA2F7IfCVXJkY8KS2R0P7zTjIGb4kDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=917 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200075
X-Authority-Analysis: v=2.4 cv=VNvtWdPX c=1 sm=1 tr=0 ts=6a86d3c9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=U2YU7bBCPYuE-C5gi-QA:9 a=QEXdDO2ut3YA:10 a=E3jW5n9IINM6fAjA4JsA:9
 a=FfaGCDsud1wA:10
X-Proofpoint-ORIG-GUID: AiU-4bPrYh_lj3o19Q9btvtj6CkXczoE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfX9fjNdaO0AP89
 w9J/8V0eBJjsvWUhCIhm1pM/elNSQUXaD08DxYD8GxlES6mE9oetNgnrNicTSW6320Rz8vNrE03
 qJw4hDwj5wWLe6Vh/BateqwtueiKgH+jNZhz6rSadTiwENFYaYHfHKdljDuZGwsh/haiIikxqZM
 TEaAVtB/CTupIQRZhGzK9SROfiy+B17Eo4KO8aK40MA8+OjicXugvTte5+jFSlRYKpzgdNEYPXW
 QTGEZDna+htQdmvQj0Y6siwoJBE57KbYflzqHVuWcvMqLsGJunTsaCtZUrPQPTQyawjRqxFg2QV
 2GQ9Ppm060ecSMpYIZifOmPPV3dj2Hqei2mWzBwxD3Bu+98j9gG/ct8y/6/4KuVTbVl3iwFaYHl
 nf80VQCznt4rTZ9vVJIn5E0EKVAHLWtDJGr4rMyHdA+Agb45pzQ5S7ZqJi/5F94meOrZSJN54TV
 DPO5wJkvfqkd8qyzgJw==
X-Proofpoint-GUID: AiU-4bPrYh_lj3o19Q9btvtj6CkXczoE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfX8JXx5kjcnURN
 in7KDbYWhB+eGIclMWbhyMqn5zcGgiJXwRLy49Ti8EqEzF4Gs/yc8k1jLlq8+LPeGGJtbb6wGnJ
 44f9+MA+/liBbL9X6EpDHD0GGGAloBl8OJOevmKfWek/+WzWg7Ve

--=-xMMe3h9+LWtWlDDEBqDL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Sasha,

Can you post this backport for the remaining stable too?
It seems you missed the other FAILED emails.

git am works without any conflict.

Thanks,
Siddh

--=-xMMe3h9+LWtWlDDEBqDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmqG07kACgkQBwq/MEwk
8iqOWg//bkgV8BLWkfc3t4K6b0VvsbLMma3DvqkcehZivgIVSmdy/BqMkV+011eZ
iFuX46DCnzmh1HvX+sbh4QbBDg4nnVPsC4JbfUz2yIqjWSr/N14yeZbh2Hgy3o4b
beLz0rVf8uIkdE1KZVy4/JmdUVpYGKgVPy7JNB/BIlCGLFmT66YJbe8lMEPRElLo
3eZYwYFmIV8nVXAQ3ep8YPsUBlDgPNLyOBTRFH7iH+b1dk1+0e+Ix0/hkSwl1a/F
eJu8wOwEnCnQi85h8Xrx6RekDdlmV2cgguuMbFw6Sryc/a8hoIjzQ6T7FGftK8yS
MyFBOOvdnHK0x1iATQkLzuDNsmXpCB88vl6/JogdHU9IDHIcMJPAmoicuMdoW25H
/XWNztzQyEje99vvKjlNLofkbqV6rSJ4V24CcCX7QlJxb3V6EsyQ4xXF8dxrJOrC
9ZpW3IEjjMRBLS/2w/wkiK6z15jYm0+3uAD4mc4LN9QQOHZWX4P//PH0I718avMc
O8GgHpxOk20kuus52rmKVTqDSIbmNzqs3ax+rBe/LqsTJFHL1FFV4UqY0rmjU0DR
0Qd/2Zuf8hFUYC5Lh5xPm2ni4+bFDVQ8LmTws5ywL1liCA5t+uz5XO51KnsPc6zp
2ZZUzvrrkdK7KKwiRHWSFEq+SMiaLFsEl9C2lgaOWT5ooSpUjgI=
=/8dK
-----END PGP SIGNATURE-----

--=-xMMe3h9+LWtWlDDEBqDL--
