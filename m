Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD65175A85;
	Wed, 29 Jul 2026 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303906; cv=fail; b=KAkJMTlDrhkUaFJrIe5eqJ0zSMkvA2rUvfGawxfD7Sl7AoEC6iRkeck5NviQa4yRBP+p6eSCurVjwfjxMr946kotRhtdKsSDdla+nEA07aMn+aaJ2UqjeOczmfB1wyHmTTn5gN80s6awj2NpuFe/WWJb/2wsJMy9Qey46xjJUck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303906; c=relaxed/simple;
	bh=BsUYhMR1MNSAxiu9BPmO/Tf64x2qey9Wy6T2eFO422k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hm8i/i4yiQ0LPbM0Gg3GNIp12zCFk6tb9n7+cKeUEgBNDNBXGQzsW76nGE1HOwYiRlPZXPJ45EVaLMYJjttxjaKu2029dXplPQmzNl7BxhBV906Iclrtfp7gCarXpIT8hhCz0sMBmKjLLsvGgN+sUke56DadUKCOQzxHiddxonA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T+qBZZ7x; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gYCKQ/z2; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T+qBZZ7x";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gYCKQ/z2"
X-UUID: a1f728b48b1011f18dc8c9802ae25ab1-20260729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BsUYhMR1MNSAxiu9BPmO/Tf64x2qey9Wy6T2eFO422k=;
	b=T+qBZZ7xS8+0mfVxw6im0egAzVZ4iB5LY9h6awzYcyMzpgfDhB2FhqNceRpkLvd3yYGM1XqstrhAdu40AemeujJhOvAEFjpZXoaN/k8D0Dyj67wro97QQq6VRfx+KHehscm7g+Xo5wmDh6a8wwhuQ3c0xjR/k9iONzLoz8a9arc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:badbd305-1be0-4bd8-8e4e-75846ba4a346,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:48eeaf33-ecf5-44a3-a34c-573dcd551473,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a1f728b48b1011f18dc8c9802ae25ab1-20260729
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1437430227; Wed, 29 Jul 2026 13:44:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 29 Jul 2026 13:44:56 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 29 Jul 2026 13:44:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5qsW64q6JDhxUWe3lqeoGC+SWgpTpuvrN1vO4WNjhUBTpf9/hNJaeC+emBLVa3vdHK2z9hKsdLx1vSxAH2NlV4ZSoSID3Yaq+LnhCBgqZcAKrAc57bzsjUG1Pg46gdlIYuIx2iyGWUPqiDKN2lVGGJpgNFUjwXJAfntCyLXNl+YK1F/06X4XOypia7rNp9cGWjyWlD0GTrAfxgTsWzsprAduDOCZ1KYQndpfFGprPkUSJZDJ2SM8npMR0p0RtqA2IH63A7liDTLbxs43+PndeRUf7kkqnJG9HZqq6kEim3AD1YUxD1BI+gFFAzjUCLGEiRet4vyx2Af01zQ6NFIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsUYhMR1MNSAxiu9BPmO/Tf64x2qey9Wy6T2eFO422k=;
 b=mxNmmHhuPkuITfVeq0b/n6oPmDNoXUnqxa6sAapCbX1oEe4WyAKh9qO5u99u0u2sgAB0MfjotUZCCtDEKYZ0mXIaSchwuS74Va23YxtWYem7ir2Y7sWo2RGN3U+ouZIJMHnohkGhok44UOYPCG2AXjxFAKin/V05mBZG8zhG0f4tq3w298SUwCQ2C6rPXDdgmrGmntJQyRzwDax04TDf/WxmkjCA7BoAoh52XID0IVg8k2ZQESxiIekPVEtr0kGmcrpH7V1ltd1rekbxQFfg98Eo4VpCnVEizkDg87X+OM4m1umqf270Mkib6H9U78hZJ8CstX30lQ4oW3HtD+M7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsUYhMR1MNSAxiu9BPmO/Tf64x2qey9Wy6T2eFO422k=;
 b=gYCKQ/z2A6DnJTbNiATVEiuGvCA5eJCl5jz2+u20R4zqgf1yh4g8a5Jc67R7WP8Oc/x4YOM0Tis5jeTab2qBvqWb+qNLSc44Jfg85jJLCN9EyzzmndxMyAAI6U1yu/pV7QE077sqphXeb39YeefMRLmd2LgZ967Pud7hLso6Oek=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7700.apcprd03.prod.outlook.com (2603:1096:101:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 05:44:51 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 05:44:51 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "regressions@leemhuis.info" <regressions@leemhuis.info>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "me@adamthiede.com" <me@adamthiede.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"bisson.gary@gmail.com" <bisson.gary@gmail.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kernel@collabora.com"
	<kernel@collabora.com>
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable
Thread-Topic: [PATCH] drm/mediatek: mtk_dsi: Enable HS clock only at
 pre-enable
Thread-Index: AQHdHqZLslBhzgd3skSoLyc0iTK9QbaD/XKA
Date: Wed, 29 Jul 2026 05:44:51 +0000
Message-ID: <89059c1a8853ff9f6488a41c8444420cd8fae01d.camel@mediatek.com>
References: <20260728153145.578404-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260728153145.578404-1-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7700:EE_
x-ms-office365-filtering-correlation-id: 9005555a-1088-4ba1-730c-08deed34828f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|23010399003|1800799024|366016|7416014|376014|11063799006|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: SP/cljBXssL7BZxgbk5Bv0VxjTIZICexbRJI2U4UVtrMTExTeulbTEU3KsKjwjPxm8X1IcroTBOzZf3SFLo5u7ApxvA3h0LkSJbbEWSpPDN6hofy8dhwctuI27cA4XhvLRR/UQPg7oZP0OMVRzbhrwlEy9gVIsXNgxpjuPEdGHjaL3eVsNqgCjdMUtz8MfjeNHU+UIc+NwdG+mxh5sN2/yaBvGyKA254be+HTDxUrrY4oetoMSpZ282ExjzkRyX66oTfv2uDQADRRt2AxzIs69iW6dkcGxP9Tf2KNvvRcQR1qDhj5ZZImblWkIFVYAJHkIUgP9VkrqbqWxfmDkkOlWF1oEYkwjfPVaY7eBVHLoJIoMzgcrgbOQDatJTwVOPvvlCB0gErDPf60ASj18UMB6O0nmKYcI0TccuYVpCjEvpuW7G7BukkmAnEs0hwEeXyI1f6XBVEH0M1OTFkrq/PzdJDZw5jI1NCMn6q7eoBpLlGw7YK4c9702kJeudooGnQfJuKdogXt6M4j0qgL8PtQrfoZD1OqJ/MY2Iu868IEaLz0zknl0sQU0aeTxl2hut8BrTwQSili53Rz9y4iqSDq54ze+Yg3vx4jgoKaig9YRJDYfhpU5mrhV9EcJ6c1h6mQuB+pxQtwVEyNoYyGfXyyNKZZuibMC4+BEmwtUmSyFSEXHCkF2Kv+IWd5+FyvZxT9qLULtWMBA5tqis7gcDmuOrllK+XoTiwnKzKKJSS6Mw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(23010399003)(1800799024)(366016)(7416014)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmFrMit5WDNSMkZNSk5JNDRITTdXcWpRN2JhY0gvbEx6THdKcnlrUE9mT0VQ?=
 =?utf-8?B?c3pYTW1EeDlSSCtzR21zWmZsWmc1R2psbWZyaFlkZjBMRFY2eTNDL3NIcWhu?=
 =?utf-8?B?M1dSUTEzRFJaTE53M0dxNWo4cU5GbHVZblF6MmdQWEZ0Q1pkeVFzTzAyWHlh?=
 =?utf-8?B?WFhIRG5JQkhvbzVoRXlyTzJ5bzIzMWtwRlZ2Ry8vOGdGb282amYvR3RNajhI?=
 =?utf-8?B?aDQxcDZGb1hnTTNZOE4xblpJdGw1UXNPZXphVkVLa0Fic29Dd01sNEs1Y3Jk?=
 =?utf-8?B?TzhKM3dLRzlxVlV6YWllakR3bXloYlN2TEFmRDRPbEJmSSsvSUxmM2NZQUpn?=
 =?utf-8?B?akIrenlEYVppOVJYK1huQUtuelBNRFhKZ2QzZzVISlZ6ckZIcE9zNUhwemNS?=
 =?utf-8?B?SnRKblREaUgrY3hzZGsxSkNuUFBMUkJwUmYwdGtLNWNiRDBwN1VoOGVTQS85?=
 =?utf-8?B?N0h1WlV2VHVxWG5za201UVluQ0I5bitSV2NTanlPc2hzclJSUjBFclo4YkVV?=
 =?utf-8?B?dERVT1pJQkJnMlMzSDVCbHFpMHRrSTd4bmNEdk1JcnBtb0hJTHY5YXo1SFRZ?=
 =?utf-8?B?Y0xTNXU3dWxzeGxKeU9DZ0tLcHFWclFxdFlzcUZ6alFZQlVEc2F4SzlBY0Nu?=
 =?utf-8?B?alhxUW1sSkFJTmlRSnozWE5pSUwyOUdPQzBrSmRRSmhkTUtWNzdNb20vSEVF?=
 =?utf-8?B?N3pSVzZ2SUdXeWpaZHNsVHNJbTludUJZdFQzdHZid2ZHSFhyK2VwV216ZHZk?=
 =?utf-8?B?N2RJZXBTWnJlNC9hT053MHNMcU40c3hKYmszRDFxSE1EdlZhenFBWVh5WktH?=
 =?utf-8?B?UWFXSERHU21CeGNDQkJIdTJtbllvb3hyMFBsa05VTU9XWUQreDlEMVZVZlRX?=
 =?utf-8?B?RXFBTjhPS0lZZnBtQmx3dnFPcDI5UDhuRWR4L2xPQTNST2VnWGFMSmZEb2cz?=
 =?utf-8?B?MGl3T3Vrdm11cHRXcTBlSm9URnJPaFlCYXIzcmdyVW1uMWxCaFg2RUx3bXNs?=
 =?utf-8?B?VnhNQXFkTWFJT1hVR1RsdXFCZlFkNHVYS21sNDRRdVVLTG5pMmJtbFYwazMy?=
 =?utf-8?B?NmxYQlIrYVVBSDMvT0RnaUhoZGRVdWsrNFFSNGFybUpmenNpbDdUT0gxYTFE?=
 =?utf-8?B?N1VCSXpKUXJOS0JJR3pCbDJaWWdITU5nUVgxQVpxSmdKYm41SUswMmZEcEtw?=
 =?utf-8?B?VnRrMUVnNlNtZldOOW5pb1RJa1JGYWdFenZrV2hNMzZjZFU2N1VWeU85UWR6?=
 =?utf-8?B?M3kwR28veVdoZ24rQmlqK24rN2Q3Tm9xQlI4ZGdTb3AyVDh6T1dUNU9ZOXZN?=
 =?utf-8?B?cWZXRmVPdnFBbTFLbGg2L3JqeEltYVI2Qkg2V0FmUUVQcllzVUd2SUF2bXRX?=
 =?utf-8?B?SGEwUXNJTVZTWGVhMkVVU1I3UXpjQXZGUmFVMGw2ME00RDZYUVl1dWhzNDd0?=
 =?utf-8?B?NGlHZ0pvLzRpMjRHK2lrblo1dHVEQnRSMVloczdRMHVFN3B4UDArdHc5OXF2?=
 =?utf-8?B?V3g5RStBejhHTXh2RG1kYUN0dUE2QWRWWW4vbWZjTkxYcWgrQ04rNlJYUkZ1?=
 =?utf-8?B?MVAzanlsdHlUbVdxdDhNTjRyVnkyUHdiVmpEUFp5R05lUXZsSC9YMWhkSnBV?=
 =?utf-8?B?SVprM1RWU1RiOWlTckcxVG9KNGI0L1N1UzkzRHJYdndWc1p4VkNibnA3UHc3?=
 =?utf-8?B?VUIzcHNad3k4ZFU2em1OQkM0V1JMdUVPUFpUUVBFbkRmY1plRm1vc3RUS051?=
 =?utf-8?B?MFlEV1VHSVV2dGQxdXVTaGMyd3RhM1dRZUwyZ0ZBVzBwTGlyaVpiazR4Y1dC?=
 =?utf-8?B?RUFRV05UdHlRKy9qSlZkZWJINGZqU041dkRsSG9xUng3VW1zRXdZK05qRngr?=
 =?utf-8?B?U0ZiUzZJVDQzNmJiWFZROHY3d1gzRmk3bFo4dVh2dW1XWjNIeGY2Z2htdC9w?=
 =?utf-8?B?QVRIMzBCdE1Pd2FYNGdHQ0hpS3ZzTXgwcWFmNkF0VTRWbGRUUjlWV3VXMFFK?=
 =?utf-8?B?dUF4YUlvc2dQZ2pQOEdlMityT0syZGczcHU3aEdiS3UvTkppTVRmN2V0QVJa?=
 =?utf-8?B?cncwOVNtdW1JWkp2N1lJZ3ZKTjBXZjcrUEZWb3lnYWJ2d3ZyajR5RGZXcGpv?=
 =?utf-8?B?ZXppRUdtMlNqOHVod1laQUN5MVJGQ0M2RWE1aG5kU04rK2JKdG13eGp5U1FD?=
 =?utf-8?B?akpyKzZxWXhmR2NXdmJZRjVsQm9mRVpuVGdlQ2dpU08rdWRJNTdydENPOHdv?=
 =?utf-8?B?S0hyQzRyNEU1SXVZNXlzRWc1OVJzTlN6bFk4ODBYU0QyU0F5aDNub3FsWkdT?=
 =?utf-8?B?QzhwblBoeU8vVDY3aFhzV3k3STBVK2lpU1prYm1FK1B1QUY1Q0JmUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <734AA25CCA85B2409DAF384BEF9560DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ToFR7p7OoBnSGH0J9KWwGsiHLEQbn6R+VVb3UXkFIgVRNNl7FO4zhEdI4vQsY1is/DYDVhgC6pdFaIwq3v8p/zeMHN5y3kSySlA/T9/4tnx03LpZCbiCZC6RS/PT8WHXvReR1MSH3S2/oF/D2tavvK6eGr9H+slPJ4Z1Xgu+KMZ6mPfXs57UYOw3uLst0PZoFJLL5MLk1KSsUZQgbeL0WIoyAT5hL/lt0QUnENc9/ZvjjgK4jTMHmKcdIeivbXK2OzBeEjusDEZLcdeuIWzqv3aPTjdAcovtB87rhbUyIdzBM0xQwFBqHn1K1lyR/haDuXyfeeDXWyQ5Kc4/W+L+aA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9005555a-1088-4ba1-730c-08deed34828f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 05:44:51.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tx+0WB93BGdoN1uAFntDjbdQ18a0re+Sz4ZsjQfPtY5l0tAL2qxzsjFRjq8oCcGOrv9yHoY3QWYD5pIw4WGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7700
X-MTK: N

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE3OjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQ29tbWl0IDc2MjU1MDI0Y2FkYiAoImRybS9tZWRpYXRlazogbXRrX2Rz
aTogZW5hYmxlIGhzIGNsb2NrDQo+IGR1cmluZyBwcmUtZW5hYmxlIikgcmlnaHRmdWxseSBtb3Zl
cyB0aGUgSFMgY2xvY2sgZW5hYmxlbWVudCB0bw0KPiBiZWZvcmUgYXRvbWljX2VuYWJsZSgpLCBi
dXQgaXQncyBtb3ZpbmcgaXQgdG8gbXRrX2RzaV9wb3dlcm9uKCksDQo+IHdoaWNoIGlzIG5vdCBv
bmx5IGNhbGxlZCBpbiB0aGUgLmF0b21pY19wcmVfZW5hYmxlKCkgY2FsbGJhY2sNCj4gZm9yIHRo
ZSBEUk0gYnJpZGdlLCBidXQgYWxzbyBpbiB0aGUgTWVkaWFUZWsgRFJNJ3MgLmRkcF9zdGFydCgp
DQo+IGNhbGxiYWNrLCB3aGljaCBoYXBwZW5zIHdheSBiZWZvcmUgdGhlIGJyaWRnZSBvbmVzLg0K
PiANCj4gVGhlIEhTIGNsb2NrIGVuYWJsZW1lbnQgc2hvdWxkIGJlIGRvbmUgYXQganVzdCB0aGUg
cmlnaHQgdGltZSwNCj4gb3RoZXJ3aXNlIHNvbWUgYnJpZGdlIGNoaXBzIChvciBzb21lIERpc3Bs
YXkgRHJpdmVyIElDcykgbWF5DQo+IG5vdCB3b3JrIGNvcnJlY3RseTogdGhpcyBpcyBzZWVuIGF0
IGxlYXN0IHdpdGggYSBQYXJhZGUgRFNJIHRvDQo+IGVEUCBicmlkZ2UgKFBTODY0MCkgb24gdGhl
IE1UODE3MyBFbG0gQ2hyb21lYm9vay4NCj4gDQo+IFRoaXMgcmVzb2x2ZXMgYSByZWdyZXNzaW9u
IHRoYXQgd2FzIHNlZW4gb24gdGhlIGFmb3JlbWVudGlvbmVkDQo+IG1hY2hpbmUsIHdoaWNoIHdh
cyBoYXBwZW5pbmcgb25seSBhZnRlciBhIHN1c3BlbmQtcmVzdW1lIGN5Y2xlLg0KDQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gQ2M6IDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPiAjIDcuMS54DQo+IEZpeGVzOiA3NjI1NTAyNGNhZGIgKCJkcm0vbWVkaWF0
ZWs6IG10a19kc2k6IGVuYWJsZSBocyBjbG9jayBkdXJpbmcgcHJlLWVuYWJsZSIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRl
bHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQo=
