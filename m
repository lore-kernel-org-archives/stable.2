Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B7392C4C;
	Wed, 26 Aug 2026 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727056; cv=fail; b=r6ixg03nsHZMYScK2RnFvXf1h6iQ21UdiSDnuty+4j2uErGl4GQd7qWslVwc0O9V9q6KbNSCbv8GUYrqTqtGvF28gKPCoDhK4eIM2jN4RF7HIkOdc2VFVnebvmfQTPwELCXnI8qyMqM7OZmpTTvppPDcIsij2/ARf5cihDxHz3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727056; c=relaxed/simple;
	bh=hKJETw30NEtsO1JfkEBy3VmODkDfSu+GN+WndojthvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xj4924gD0Y439GSz6TVgREKTdZcPV+O55LWRQebsPA2XoSPDEoKci2g1Ys1x+t/WDCG4AySqEi9+Tnx3lTkwaWyyVYpnw7oK+dYYI4ol6cieUmk53JFD9VaZsqP7G6SJ+DO3QgbFneaXjfL07otzFz90G/jtbhnYjaO9qb2+XAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V4PMRUxJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=isE/s5GF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V4PMRUxJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="isE/s5GF"
X-UUID: 76d3af0ca11a11f1b1788b6acf885367-20260826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hKJETw30NEtsO1JfkEBy3VmODkDfSu+GN+WndojthvA=;
	b=V4PMRUxJTwyXW5+l9dLCJeJhXmvWaauWFzStEhZV1K3GSSTz6CQPQ9es/wTeXXb8q5+mtOsVaPF9JGzKwJjMR5EFvc2b02lhyXTogGGPLJ7C0ZMtIBM3WMG7QsFGUoTTEOUxmRRTuDJamFHdNyjunNhATqMRNzMLA/472Vxk5Eg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a1330eeb-f887-46e4-bf53-a2619418727d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:70996efe-f4cb-4ad2-b022-e3ac6648bf25,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76d3af0ca11a11f1b1788b6acf885367-20260826
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 59138076; Wed, 26 Aug 2026 14:50:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Aug 2026 14:50:44 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 26 Aug 2026 14:50:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqKAlR9RnObJwogq2TA6V8LbQT5vedWulK4fdhsSOie2tuL96SuCcZmGgVE+8I1z7ri38sKrsdCoSMwnYUbikMmDQi4pxsVu6g2ZAXmhHqlI32qOJ9nP5T80oU15E6oTVcg7GcaVccARGX6PkM11rOiqxaXfSTyXjg5bHRitvVvSHY4NZtrY+QgObVbwC1aZXJu4QKDT5nQmtg/sjihszQpbG9wafgSSJoKPeBiggIcNMDP+f3hBY8oA18nseiOV1slpzCY2q7RqFzNbgHKqNv92vi4JEfdSksnvfjynpBWNtmxsCbr28N6a0s5sfGfMLk1Y+ntrk7gcWiOreEVJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKJETw30NEtsO1JfkEBy3VmODkDfSu+GN+WndojthvA=;
 b=CllMFnwGKqrMha2g28DZ1siSlPw54MArK5ZMF4yUXikU80GSZaZ/piGaqdI7TIFvUjRBr0Wmvl75l12JJlhpc8Oronqq2ZLP7UFskqKc1tvPukMQC6Wen9TkWVoxrDNaSond6X/KhfYEEtgvT/CcVL6XyYdj8M+GilaNeV49aBDCkp/3xsxCGnIaAgmSBQVHB0YtAFSZvF5wdmDLPEQT21X1FdA+1k3kl3EKe53QZC6x5c9TmqC7f40CI8GgV7Q1hZeQV4KmTv/J9Xsna7HqlNWEcw8WdyQAL4U2/pM/l/W2bp6qYsxWm0xxNT0gMqMFnavz0rvsLXPKCwheIoPBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKJETw30NEtsO1JfkEBy3VmODkDfSu+GN+WndojthvA=;
 b=isE/s5GF3eOQgqhp93Iwdn63tHAhkcb2Qw0jDIRav/hIkLG8A7/dnGvp33AdDvwu/oT2GeaIYLeMdVlCcKLOXt6uFWX2wVfWmKfQCpmarQb4pB1pfkoSaYPtDxCl5+TnrpUwCTj0gpELEfeFEBvwxSOV2ro1Tr3QMiHTMF+Yj0s=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSQPR03MB8642.apcprd03.prod.outlook.com (2603:1096:604:298::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 06:50:42 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 06:50:42 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "lihaojie@kylinos.cn" <lihaojie@kylinos.cn>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/mediatek: Add missing IS_ERR check for ovl_adaptor
  platform device
Thread-Topic: [PATCH v2] drm/mediatek: Add missing IS_ERR check for
 ovl_adaptor  platform device
Thread-Index: AQHdNHnWUAca3YBEW0KMqFKH4efjB7av5XeA
Date: Wed, 26 Aug 2026 06:50:42 +0000
Message-ID: <bbe41ca6c73c8e0c690ea381e2274c7406482740.camel@mediatek.com>
References: <7a3cbf55bf6a97835ee426eb38c34b2c153437eb.camel@mediatek.com>
	 <20260825100845.438893-1-lihaojie@kylinos.cn>
In-Reply-To: <20260825100845.438893-1-lihaojie@kylinos.cn>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSQPR03MB8642:EE_
x-ms-office365-filtering-correlation-id: f73f47c9-d2c6-4986-0e92-08df033e58d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|42112799006|6133799003|22082099003|18002099003|38070700021|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: VclenXaYVzKRYvlf4ucZdeZ0wm0qxmcOwqPQ9TF8qf7Mo7zjK+HgHGhCYJwKcTdd6ulHggDW5KbqGqGybPZnQDcEpKhXiPNVdrApucxGgILhoNds0XRhEC87kwDdr9YxUFgBXnRkr59Ioz1y12PZ2iwgf0E19gFh134E4p3kGmzuNEgv6D+CTFpWP0dqlmVmXW3uidnUGwHSAgwIwPEcSzZz3oWWAtjeuYJNs/LAAp5uFGB1C0dqm5sriDLhwUd9AOaDWl6ELV7X+WDUu/kj10M94KekpsOrBvYGUn6sO2zRTdKpWyfnbX0kQYbrNxz1i+Kmgz6EKmZGW+vk0qUPs6vWt64qVL2qpTnemUy3cIi50i6doSu22pT6Ll4UubGD2aFe4hfRQ5lbQLE1CF9yRhwK7zMDwrEfy3RRVa/Me6CyIP3+s5qCRH7CWD1kzQ1CSSz4zddk248oceGb9OHvHxDT43LgCQA3pxAj1Yoxft9rdLL/BnFUjJ+GSp+h3YUSQBI1+u5CMFxRHc8UCN94L4RrVsYJLx95FhkTP9v6DIZJM2Vq6lGaPhC3ammso1/PXQSFNf64joV5yG+4Vvej1VN3ScRQf2UJT05bQ9zqRiqK2Z4lO+20WWVczEZpY2+UILhNVl/joPGsJA+Fgb278bCZ3cBJvCQWIbEZfGeRAaZ1YxhTP5IMd1WmPPZxljVMSHK85+/5hgPWq9prNWzYMbVkfQz+SKJrseXnl88GRAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(42112799006)(6133799003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d09PR2UvTmRuYmN3NkpQVG42eEhkaEkxL2Y4MnlIMmZUSTVGOHBhdnlLam1N?=
 =?utf-8?B?cWZZMFdoRnRvejFNZ0tMbDJFdC9UY1JlRktoRmZ0SUczNDVHSCtCZXZUK1Vm?=
 =?utf-8?B?VndWa1JNSmpZT2NnaFdHb0cwQ1cwUkRGTEdVb0pENkJ1SlVIVG85VjYxNjVO?=
 =?utf-8?B?T2F2SWYwNFVsYmtCb05NNExOUWZGQ1E2c3NWWHkySWU0cklpQjJFN25mblJh?=
 =?utf-8?B?VVk0R2tRTzhjT29ndlg5eGRYQnNKR2ZlclNUWWRtTnhYaFQzbml3M2wzbFFP?=
 =?utf-8?B?cUVFcnNWVzZlRFJaUDdsK3lpT0JaVFFwS2RGVXY2M1d0YTZqRTR4NzVYVTlj?=
 =?utf-8?B?c28wSU1zcXJCL0VIdit4QjhzUWl0S2pGMU80N2dncjdZUTViM0tVbUErTTBl?=
 =?utf-8?B?Y2IvK2sxT0ZLdXdvU2tUZ3FOUmxNbWtBU3dHc0RCd2FWdFkxRThXZEROSjRJ?=
 =?utf-8?B?T3ltVzdDT3JSd2dwek5nYndobnNlVzd4ZHhqQnp2aWF3cGxFLzNuUzllMWhi?=
 =?utf-8?B?N2hXamJNN0FzMjc2TzZmQzFwQjVaN2lJQnZGbEU0Y1I3N1FBS2lBM0R6Zm0v?=
 =?utf-8?B?OGNRME1oT3hldjdqNWJVcUloQjliUFlMS2taS05HOGxwS0dwcFc0MHpPTU9s?=
 =?utf-8?B?bm1LS1VBdUQzUXNISE5idzF5Z01PMll2WW5LZmxnZmplRWFxTGRCOGxzY2Z5?=
 =?utf-8?B?S3I0azd6YmhYcnl1TU9xeE5jaTBoTEJjMzI2Z1NaWGVRTytMTVNHdkhETHQy?=
 =?utf-8?B?WGJhYTBscGdSK1IrNGlVNTZ0Yk45QVZJSHFVWW5mV3ZqWis4R0pYOGRBRGEy?=
 =?utf-8?B?RWJNNTJka2hrMkxSM3F2eFlQVXY2ajlnekY5dituQ0N3YkR6ODRkY2pYcXgw?=
 =?utf-8?B?MUZ5SnRYVzIwSFJzeks2RGIvL0ZreC9OZENIY3IyUnk0bHErc2VOOHgySDUr?=
 =?utf-8?B?eTk1c2p0aWRXc3FoTlVnbkQwd1RVQzlQc2dabmdWYWVHUzVWQTl6MHljT1Aw?=
 =?utf-8?B?OG9rM3lDME1xQ2NYUldNVlZaNVM3ZWpDWEhtcVkwaXcyZjJzWmx6bWdGaGZR?=
 =?utf-8?B?cHRxMVQwUmtCT0QzK1dBMFo4aDNIbEdqL2lQTjJVdlZOQTkxb0tBczlkbmNa?=
 =?utf-8?B?WU5XZFQrYlZLdDVJbEhWT1RwOUFFRStrT292SVF3dlBMSUxIQ2pRN3V5V2xM?=
 =?utf-8?B?S0lzWTFkTzYvSWZEMk1EOGpkcW5XcDVxdHZyQWZUWTdBaWxCZFZsVlFpdk5Y?=
 =?utf-8?B?SkdacVVvWFRUQTFJMm5tVDZscjNWRElUN0Yyck5ndEVFVGhGRWZNM1JpY3BE?=
 =?utf-8?B?YXRkMGgyUjZiNW1lUzhqd3BGUGxzQnM2WDdhdzVXUFJ5MXlxMy8vdFZPODd1?=
 =?utf-8?B?UlJXQ1oxNHlrOHQ1YXpsa0k4dG5tUi92eEk2OTNPak8zTGVBQnBIWndkZG56?=
 =?utf-8?B?WjIzMkJjTGZUbDBzY2RYUldkenFUUThXMGkxWW1aZXUvQmIyem9DY2VtTlNF?=
 =?utf-8?B?RTVqRXRqa3RJdjNBUUMvNlRjR0V2VkF0czJFOEhOR2ozMlZMdHh6Q3VHZlA0?=
 =?utf-8?B?Z0JYdU5PazRzM0tJM2hNS0R2bEdUZ00xRjcyeWZ0b1M1cGJvdGk4cXQ0aVJX?=
 =?utf-8?B?Q201VjBnUEJIV1NUeHNMTXpDNzdzLzduVGR2S3pJaFVUSWhuRTNFV250Lzdr?=
 =?utf-8?B?VGVKWXViaTBka0V4Vm5CYlBEREdScHk2UmorKzlrdTVUbVhjVWxwaVhIRzBI?=
 =?utf-8?B?WG5IRC9uMnFYbVJzZHFTbWxIWnRVeVF0NzFCUnNhc0U0NVA0NFZ6VENyeDBv?=
 =?utf-8?B?WkpnaXRQYURiVzEwaE5yMEl6clRMZ1JMQ2RHdWFNUHlDWGtFNTJWUTE4WkJh?=
 =?utf-8?B?NVpnVzZmZTltY0cxdlYxR3BqWjJweFVtd3daTHh6NllJZjZxbTJNWlFnT3NE?=
 =?utf-8?B?VVJjUm1ZWmNFNkxHOWVxd1VJZnhIOWlmZ1VMNE0zTEZkNm1FZ0FmbldVOVJt?=
 =?utf-8?B?Mmp0UWIzdldEdkxvY2tPUHoreENHMTR6WGdSc2lxeVE1eTRSSFR5QnJpWjc4?=
 =?utf-8?B?dVQ3Q0lpTUsvYU00S3ZQaEQ2b3V2M0Yyb3JGQVMwS3lzTk13NkdiOHpZMFFk?=
 =?utf-8?B?M0wxUmo1RWFJc2J1UTRwa3F2VGRkN3FVUXNDZjRrdHF6TGdQb1VvNmhvQUJL?=
 =?utf-8?B?MFpYQjNsVFV6ZXNnOTVXQzNpNmduOXNsRUJqYlk2Q2kyMUgyM1p0Ymo0QXgv?=
 =?utf-8?B?cWhzNVBCR1lWZFYvaXBuYlhKbGdUZytFQ3hiaEo0WWRVMm5LUHMyVHdlaENX?=
 =?utf-8?B?eGxlMU8xZzZraGpWd1d4bzNQdWxTSkZHUFJiRUtBSUc1OFA1ZG1NQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3EBDEC60B7E1F40BE2B6E70DEDAFEEC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SROTHwgg/LPb3SfQmdANFp3DsbjSNcZo2vcTY/gzauxOAE3K9H01wKRUmyfpiPr+ZX5L5YD2CmfSaNk8NCPR9UiAuBT9iPFG8jdKlFVVVpX8dbpvyB0YqDXQYrRWsveb5EHXxt+cFMLS21CptWLopjCG2CMJL8OpZ8uc/RMMgewANdLksaYbcqh5OB6bQzrFualQBBR3leZECh7JVn63Y1VPfsn0yTXdcvzWU1nFSkod3GqMYIlBVAD1gR3ZxDIm43kKHbgdeL8Kwgqr6AaynYbQ1tguLY349gzgr6DW/T0Wp1IjEBKOyFm0PXq+TNcwnl5dmbMChEERiRMOfmsLZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73f47c9-d2c6-4986-0e92-08df033e58d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 06:50:42.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcE9wqL7iKUBtdloYkpGHKmatQIGNDkunjbNfuzJAgyuRqK0JTUo7URpsW2K3/YbQzdVhELF7rrkaL883PpatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8642
X-MTK: N

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDE4OjA4ICswODAwLCBIYW9qaWUgTGkgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
IA0KPiANCj4gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX2RhdGEoKSBjYW4gZmFpbCBhbmQgcmV0
dXJuIGFuIEVSUl9QVFIsIGJ1dCB0aGUNCj4gcmV0dXJuIHZhbHVlIGlzIHVzZWQgd2l0aG91dCBj
aGVja2luZywgbGVhZGluZyB0byBhbiBpbnZhbGlkIHBvaW50ZXINCj4gYmVpbmcgc3RvcmVkIGlu
IGRkcF9jb21wW10uZGV2IGFuZCBwYXNzZWQgdG8gY29tcG9uZW50X21hdGNoX2FkZCgpIGFuZA0K
PiBtdGtfZGRwX2NvbXBfaW5pdCgpLCB3aGljaCBjb3VsZCByZXN1bHQgaW4gYSBrZXJuZWwgY3Jh
c2guDQo+IA0KPiBBZGQgYW4gSVNfRVJSKCkgY2hlY2sgdG8ganVtcCB0byB0aGUgZXJyb3IgaGFu
ZGxpbmcgcGF0aCBvbiBmYWlsdXJlLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlh
dGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDBkOWVlZTkxMThiNyAoImRybS9tZWRpYXRlazogQWRk
IGRybSBvdmxfYWRhcHRvciBzdWIgZHJpdmVyIGZvciBNVDgxOTUiKQ0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBIYW9qaWUgTGkgPGxpaGFvamllQGt5bGlu
b3MuY24+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMg
fCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggYzg2YTNmNTRmMzViLi5iMjgx
NDgyYWI4YzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+
IEBAIC0xMTEyLDYgKzExMTIsOSBAQCBzdGF0aWMgaW50IG10a19kcm1fcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUExBVEZPUk1fREVWSURfQVVUTywNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHZv
aWQgKilwcml2YXRlLT5tbXN5c19kZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZigqcHJpdmF0ZS0+bW1zeXNfZGV2
KSk7DQo+ICsgICAgICAgICAgICAgICBpZiAoSVNfRVJSKG92bF9hZGFwdG9yKSkNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIob3ZsX2FkYXB0b3IpOw0KPiArDQo+ICAg
ICAgICAgICAgICAgICBwcml2YXRlLT5kZHBfY29tcFtERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURB
UFRPUl0uZGV2ID0gJm92bF9hZGFwdG9yLT5kZXY7DQo+ICAgICAgICAgICAgICAgICBtdGtfZGRw
X2NvbXBfaW5pdChkZXYsIE5VTEwsICZwcml2YXRlLT5kZHBfY29tcFtERFBfQ09NUE9ORU5UX0RS
TV9PVkxfQURBUFRPUl0sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBERFBf
Q09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUik7DQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
