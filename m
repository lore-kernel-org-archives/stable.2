Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150F3B4E84;
	Tue, 28 Jul 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230943; cv=fail; b=p4/Ty/j0OPnAZmU3Te90QNnKhBRJuEcW9pwgVOKrGH/FD+8wj0ODF6L4eJZkxf1s1L3qg47fFT7lqU5aveMwwZN1RtHHvElgslVwWhhvcLzUOqnbeNkFSmSlw5xlh3xyW0p/re8kH5xhjmOKZ6BCUdaWEkcPftFxGiFjFdA9vA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230943; c=relaxed/simple;
	bh=o059ZrmTYHc5JDt8+PppE9HDuODJT7LyjJOzcCUsK24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RWzd/14KRuUkkFD0RSmnOZhb+E/7axW5ijpZdIYN1U82SuA0yW1BJ4OmN/usXPvA+0IxGZbVjhVkmSfDy8Uk4v/2tZBEQbWIbwmbzFVo8K5Ie3Fwuu0m2SHhL7USS8yjdNlINbHB43vPD/1rkNtjet7A2StQTIoC9AzQYOdpUb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KcEHN35j; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=c97nGFOM; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KcEHN35j";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c97nGFOM"
X-UUID: bd4b04288a6611f1b1788b6acf885367-20260728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o059ZrmTYHc5JDt8+PppE9HDuODJT7LyjJOzcCUsK24=;
	b=KcEHN35jjtYoOFg9fhoSIjiK38yqiSOQ4K/c6Gg6YwpVxIpWRkXemXctKlWJtU6hFgpYmZILDqtiKJADGV6JxlYFhAjwiubboz3mNwJ7aVRISTJk+n8IuE93ovgUi5KmaYZvSO/RwHjdcifMxLA29pa18VzG95fu6XwRK8cGAHU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:45b4f468-224d-41a1-8fbe-f0c726c2ee98,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:4678dfe1-71f1-405e-92eb-6802d6af74fd,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bd4b04288a6611f1b1788b6acf885367-20260728
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 884913919; Tue, 28 Jul 2026 17:28:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 28 Jul 2026 17:28:47 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 28 Jul 2026 17:28:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0LoCF1S5sFJx1Magvr+sqDw/93dA+R++Wj+u56fRvbkPb9za0cmsJQr6WTc/ieULXlJv/vUoWH0+U47VjEr8lqk26bSIy+BA3mbpvRoXPEFzEiO7kvix4J251aefZKNS816/zK3h4XfJmFvxm+8ZOBGDex8uYcP/+Gh+jQp/qGvrZvopXKeKJj41RSsIYCFk6/w7sDkh2YBl+mRoLZHLQdibr5zQte2Oql/brCKvO+FY6dabLzAPZnquQb7IKEXOX9W/j3d6j2gI2D99nIboWFGS2CbBS30SreCIbaFbptbixnXzaBbpi9wlpNtofdlVFY+lnUE+O//qBxJDFPFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o059ZrmTYHc5JDt8+PppE9HDuODJT7LyjJOzcCUsK24=;
 b=URT0xQiiEAUpxkKqU88XL4pxbDddrzwvImt2k/pY+2UIGUICU+amHKfxNmT2rkGMC/BmN7TAneaiZ0S+y3XEvBeFqTCmezXhDsc3r7rN1v3cuqKtVScfDtxOPH60QHYe36wY6O94glyYkXNnlXvp0nQjOZd199SyG90d/wMfzOiDl3PCvxVQ3b03IQFldkFGMIpFZpEsyaOPPws6JD8QJVyq37OFyv2Y1kMoFBz4Tt/aQmob0sMV7MUptIGdNwFkHYl/OFHtXT+QMjhxXTrMPMyHrF+f9lZ6ZRhaoSTndon8F8LsNly9Yc5t8IXLunyigYPQmegcjdhNL+lZs3s3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o059ZrmTYHc5JDt8+PppE9HDuODJT7LyjJOzcCUsK24=;
 b=c97nGFOMDV+JEDbGJFHc5+3A7PT7zf8nXS3i++LWlTAIeQa0fIysE3tY2MbugRkm6ekpfhTfEpW08oxCe2vqTU0Koel8rf4v5gR50eib2QFjoCY7TtdTvm/4TJWZaBFZV1GB/eixeSH8Mlb+5Nkxgm/Jy6vW3wF84Z34SopHInw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8626.apcprd03.prod.outlook.com (2603:1096:405:8d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 09:28:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 09:28:44 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "mhun512@gmail.com"
	<mhun512@gmail.com>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "ae878000@gmail.com" <ae878000@gmail.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: ovl_adaptor: balance component
 registrations
Thread-Topic: [PATCH] drm/mediatek: ovl_adaptor: balance component
 registrations
Thread-Index: AQHdGSTl9LbkIqtDRUqDOHGvqXwcCbaCtKsA
Date: Tue, 28 Jul 2026 09:28:44 +0000
Message-ID: <7238da113aa85cf19c1cabf73911f4b7149c18f9.camel@mediatek.com>
References: <20260721152242.47138-1-mhun512@gmail.com>
In-Reply-To: <20260721152242.47138-1-mhun512@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8626:EE_
x-ms-office365-filtering-correlation-id: 846a856e-c136-4d49-8348-08deec8a9e93
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|42112799006|7416014|376014|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: FeiGBAq2w/n5j/M/HcwU8UqSIM5wm7K0uTh8m4sPDzfbYli9OFCa4ZOAXPXgUiCVloSkFetswg0WO7Qo633yu6na9ICo8xv2w2mMAOMX3AhIcwVVgDcCJiMPujEXeFJtOHLqq+1fyRY5bMRThpFpmWkQ5OedP85ToaBzLpg4c090E40iCZZlgAGbT0+mdBUtBrE4RhnS3WUtQX3heNQVPWQkukss3c+UENvB+VwPZB1YXCqo1cXQ8EhdeHug2A60MD3S+R0X+FNPLRvmDoAjL0e+JgU4M6osIeBVLu4WFAWJVSaw4qms29piaQp6zOXO4e24dC/15pOjNhg/VMuwmbaC426Ci4S4c5+IY38Vf7ogHfmCES63tL+Z9xzof0kkZ6MOEEZk3amSktsgXnA3ane8Nx6Iy/+8S6hgJYJCgfbkpgYwys7StRA2lW8s6HdCwKqV6rAHZsfMSA0eFp/qfw0kGkSDStAgmT6Y0RRvDeyYSZVkdEhA/QvHbaeP6j2VgqvL/3cEx/o3Xeq63hWYnq+bWc59Pn1Ks4BAvZ2Ui9ygdfNiZddXas0dC0hP2ayX//LAybKWTj27IpoLtfXWc2Ck2maTXlvxAsIbkHKm4tNN84go1jaKIgJ6lmblyXkdZPnDYU6KGaCHbAXGcTPxF8zNUF7ilW5DE4dvJMU1OC/exIgJRri2qG6bWLdMWaQ1pBevGC4qC/W0vEKLyxYjyl3GwB+TSVWAHU94A9dkmu4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(7416014)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnhQOG5RT0k4bzVqMjVQUkVGMVdKM2l6Sjd2RG1yTjFSQlpDaU03bmN1UW5W?=
 =?utf-8?B?K3ZEeWJidjBDU2pmNkRMelVjT2k4WTI2TDhnTkxCd3Nuc3Y5RjJEOTc2VXVt?=
 =?utf-8?B?SWVmV2o0cjFNUlRPazhJNm1PMmwzOXlLL3ZKbVp6SzFjQi84WDUzTU5JLzdD?=
 =?utf-8?B?akNMODhuYzNiNXJIeEJSdkFjbVZYUnA1L0lCbXAxWEZZOGF4WXVOWmp1eXVY?=
 =?utf-8?B?NmlZVmFLV1RoZXVLeUowYUpXb3Y4VEg4TEp5SW1RUFRYRWZKOGE0cGtVQjEx?=
 =?utf-8?B?b1BjdEc1UWNvNVpJZ2ptV3Q4TXZnMGFDNCswUGFjN0JrM09IY2dWQkpDY2dj?=
 =?utf-8?B?TVRudm5PK0p1Si84azNKV2RnYzA2NEcyelFNSTFLeWNVTUlDbjg2QXZCUURa?=
 =?utf-8?B?UXUzTEJiU3F0ZlVLL1EvMFpDVEEyM1d5YmtQTmRZMmpGMXVNN2J5UHV2STE2?=
 =?utf-8?B?YkVSK0lCRythaWdaWFBRcWtEbnFPZFRFUlRXRFIyc042Sy9CaENNU1FSakh3?=
 =?utf-8?B?Snd5eUpRa2c3dC84VHBMcTRSTG9RTWtBbmcrTllpYitZUkFQUUdxdWJMTDFH?=
 =?utf-8?B?OFVwTS9zRWQ3TDFraU10cWVIdEpEV2h3bjZGbUxjMmtSWmlSeFRaVElIWU5Y?=
 =?utf-8?B?bGRQNWJwd0lqTmFWclV1QklvWFpjTkhMNzZFTkxnSHU0MmNMVjVLbGlCbWkr?=
 =?utf-8?B?VUZ0cjdEeU55QzEzcmR6SnB4OUhlRWRTME9ZcjJPUllaR3d2bWJ4ZUdHUThL?=
 =?utf-8?B?ZXNYQWZGbWEvK04rZEVWaDlZK1FNeXYwSXc2NnQ2M29XbW40REt4TjRGTm90?=
 =?utf-8?B?cEdYQVZESmVTQm14VW81NE85Umk1R2VzbWQ3VnlydXZEdkh4cFpKOGliTFNN?=
 =?utf-8?B?cmw1dXFFR1QvMzBHdHhIMVg5YXNIaTFFMlVmeVNKeUEzZHV3TFdBTW5HNjN4?=
 =?utf-8?B?bVBPN2hMUytacFNrM3ozQnV5clBaR0RDM0xsTHgyYXlNQ3hMdUhVOG5xMkVS?=
 =?utf-8?B?aDFQUzZvWWNDeW5UNnVNcnMwWWdSSmV2YlBuYnJxZHloR2lJMHV0VkNVZ2Va?=
 =?utf-8?B?b2JMdWNUTU5XczRQWm1HN3R1TFhwajNPZWcyd1VNSHdNanZ5d005bmxrM05D?=
 =?utf-8?B?aFpST1JsT1l5YTdUQmhnUzNWb2NacTA1ajVUbmJRWDRsNE4xSVdxT2ZGWVNY?=
 =?utf-8?B?Z3ZrcXNUMHlsZjNnSzl1SWVWUDVsU0NIbFZBeVloOGVYUnhDbXZvaVRBYXAx?=
 =?utf-8?B?OTQyZ1RXSUtrY1VzWjZqdXhoTHV5RU5xdlVuYVYwdU1BL3FybkFvUE04eTdU?=
 =?utf-8?B?UUhHTURnZlRNbkwwQkFONjBjKy94Um1nelF6RlkyRExVVElHNkZ1ejJCOWda?=
 =?utf-8?B?TG5VZHZiRlM0OTFqWGVRc2RTT1NQUjFXYkVpWUJ2TTVzaWxpT3JnR05QQW9C?=
 =?utf-8?B?VklYR0ZGQk9oZ1Z2YnpmdGJFcjc3d3pma1FJa1lObDZkaUJoSmViUnJzMUt3?=
 =?utf-8?B?RU1qc2JIOFoyMkg1cU1NUEM0KzJ3eXBsZElRSHU1OUJ5cHVnL0dMWjc1ZHky?=
 =?utf-8?B?TWFteEhFSTJrb1M0c1I3YndueStrQnhmM0NEaUNuWjBxUDRucldFaEZQU0lF?=
 =?utf-8?B?dyt4NWZmU20wMDNGajJkcDE2clRCcXRVaHhxSlNrMWRaOXJNTWNqTGVXS3Zx?=
 =?utf-8?B?R1JOSlBXdUhoSHlXNVhPS29lbG1jNkU4WS9SeGhpRTJoT2VwTDdLK2dQbjI1?=
 =?utf-8?B?UHJBTnF2TmlHbUpmVTVXeFlhTU9IT2ZZeG1CUmNYaTRMa2lCRSsvM0ovN1lD?=
 =?utf-8?B?dVlySkU0ckMrbE5qVUlSUDNLdFZSUS9aTmR3ZWtPbkQ5bGk4V1M1VHJqS3Vp?=
 =?utf-8?B?Rm5QWEtRTjcrK2Z3VHM4cWdtbDQzcGFUZUJteFFLS2ZLOFlVS2s3OUQrVXUv?=
 =?utf-8?B?TkxYaFRTYUx1OVBoamJLWkZEZmJ3UmxPODM4Wk43NkNyRURuWlFjN0JvejdW?=
 =?utf-8?B?WWwzVDhrcFZOdmZnVWloMjhiTTBzSlVaQUxkZUh4b0lFa09WREFJb2lqVFZo?=
 =?utf-8?B?RDVsc2c5VW5Ramdock5vUTBJbitBRGlRdmdoTzE3L2grMlUyNlViTStacHBR?=
 =?utf-8?B?VENPZDh5K0RsRVQreFBpWnZudFRnL2NRWUdRR29scGJad2RjajdlaTV0R1VM?=
 =?utf-8?B?RkQreGFyaGYwMnJ0dHhyZ1dpdmkybUtxWm9YQkdCRU4ydEx4dmRYRG1wUEhY?=
 =?utf-8?B?NXVSMkpyNG9KbDIwV0YvNHd4ZjJaZ2syUmJ3RXd4bDRVNXpodGovZnVvdHlk?=
 =?utf-8?B?VDVOSXNpVEtOeHcwdmtZdXoxWGNEVDh3V1NXeFlBdDF0VWRwL1Y1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DCAE90895C8794B9A3B6414F7C6242E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DrSBM1+nnqzwkgIXast6ey3N75IZ1rVK3jWcjosWHg4yp4cRfKYApsuPTIIhnLiwWwb9jPxX+mIEeKdpoEM7rIV0lr5vHikjsdCxEeLntO0UdhnXKZLEGx0JIxXdwQSUtlaaM0bZz8kMTYPRAzbweSuROLpTUuD5dP0DNyHZeGs3821dNNTQRQ6cs1OzTGJ7MUSaRAFifCH3EGO2duVJadoYudxvb+0Sr29u77BXJfydlFcgAyXBuwUay7B6/sD6glMDpXbxSkUyIhrvJtcfSJG6pi22NQ1oeuohy02PRT1/rwnz3Lj9E1JaOXP6ZfMV8xMX5Rrrgy9zWP1Go5pBUA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846a856e-c136-4d49-8348-08deec8a9e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 09:28:44.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hgChXS5MEM9/5LAcaDOPIH98QiSVq1M2vEOdSohNkp3b9Gj/l07SA9pc+m9mjLYTIwr+LOP++He+hGx99ai3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8626
X-MTK: N

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDAwOjIyICswOTAwLCBNeWVvbmdodW4gUGFrIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IFRoZSBPVkwgYWRhcHRvciByZWdpc3RlcnMgYm90aCBhbiBhZ2dyZWdhdGUg
ZHJpdmVyIGZvciBpdHMgY2hpbGQgZGV2aWNlcw0KPiBhbmQgYSBjb21wb25lbnQgZm9yIHRoZSBt
YWluIERSTSBhZ2dyZWdhdGUuIFByb2JlIGN1cnJlbnRseSBpZ25vcmVzIGFuDQo+IGVycm9yIGZy
b20gcmVnaXN0ZXJpbmcgdGhlIGNoaWxkIGFnZ3JlZ2F0ZSBhbmQgbGVhdmVzIHRoYXQgYWdncmVn
YXRlDQo+IHJlZ2lzdGVyZWQgaWYgcmVnaXN0ZXJpbmcgdGhlIERSTSBjb21wb25lbnQgZmFpbHMu
IFRoZSByZW1vdmUgY2FsbGJhY2sNCj4gYWxzbyBsZWF2ZXMgdGhlIERSTSBjb21wb25lbnQgcmVn
aXN0ZXJlZC4NCj4gDQo+IFRoZXNlIGltYmFsYW5jZXMgY2FuIGxlYXZlIGNvbXBvbmVudCBmcmFt
ZXdvcmsgZW50cmllcyByZWZlcnJpbmcgdG8gYQ0KPiBkZXZpY2Ugd2hvc2UgcHJvYmUgZmFpbGVk
IG9yIHdob3NlIGRyaXZlciBoYXMgYmVlbiBkZXRhY2hlZC4gVGhlIGFnZ3JlZ2F0ZQ0KPiB1bmJp
bmQgY2FsbGJhY2sgYWxzbyBmYWlscyB0byB1bmRvIGNvbXBvbmVudF9iaW5kX2FsbCgpLCBsZWF2
aW5nIGl0cyBjaGlsZA0KPiBjb21wb25lbnRzIG1hcmtlZCBhcyBib3VuZCB3aGVuIHRoZSBhZ2dy
ZWdhdGUgaXMgcmVtb3ZlZC4NCj4gDQo+IENoZWNrIHRoZSBhZ2dyZWdhdGUgcmVnaXN0cmF0aW9u
IHJlc3VsdCwgdW53aW5kIGl0IHdoZW4gdGhlIGNvbXBvbmVudA0KPiByZWdpc3RyYXRpb24gZmFp
bHMsIGFuZCB1bnJlZ2lzdGVyIHRoZSBjb21wb25lbnQgYmVmb3JlIHRoZSBhZ2dyZWdhdGUgb24N
Cj4gcmVtb3ZlLiBLZWVwIHJ1bnRpbWUgUE0gZW5hYmxlZCB1bnRpbCBib3RoIGZyYW1ld29yayBy
ZWdpc3RyYXRpb25zIGhhdmUNCj4gYmVlbiByZW1vdmVkLCBhbmQgdW5iaW5kIGFsbCBjaGlsZCBj
b21wb25lbnRzIGZyb20gdGhlIGFnZ3JlZ2F0ZSB1bmJpbmQNCj4gY2FsbGJhY2suDQoNClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczogNDUzYzMz
NjQ2MzJhICgiZHJtL21lZGlhdGVrOiBBZGQgb3ZsX2FkYXB0b3Igc3VwcG9ydCBmb3IgTVQ4MTk1
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjQrDQo+IENvLWRldmVsb3BlZC1i
eTogSWphZSBLaW0gPGFlODc4MDAwQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSWphZSBL
aW0gPGFlODc4MDAwQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTXllb25naHVuIFBhayA8
bWh1bjUxMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bF9hZGFwdG9yLmMgfCA3ICsrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGluZGV4IGMwYWYzZTNiNS4uNmEyNTk4
NzJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
X2FkYXB0b3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
X2FkYXB0b3IuYw0KPiBAQCAtNjI1LDYgKzYyNSw3IEBAIHN0YXRpYyB2b2lkIG10a19kaXNwX292
bF9hZGFwdG9yX21hc3Rlcl91bmJpbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgICAgICAgIHN0
cnVjdCBtdGtfZGlzcF9vdmxfYWRhcHRvciAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiANCj4gICAgICAgICBwcml2LT5jaGlsZHJlbl9ib3VuZCA9IGZhbHNlOw0KPiArICAgICAgIGNv
bXBvbmVudF91bmJpbmRfYWxsKGRldiwgcHJpdi0+bW1zeXNfZGV2KTsNCj4gIH0NCj4gDQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IGNvbXBvbmVudF9tYXN0ZXJfb3BzIG10a19kaXNwX292bF9hZGFw
dG9yX21hc3Rlcl9vcHMgPSB7DQo+IEBAIC02NTEsMTIgKzY1MiwxNSBAQCBzdGF0aWMgaW50IG10
a19kaXNwX292bF9hZGFwdG9yX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
IA0KPiAgICAgICAgIHByaXYtPm1tc3lzX2RldiA9IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhOw0K
PiANCj4gLSAgICAgICBjb21wb25lbnRfbWFzdGVyX2FkZF93aXRoX21hdGNoKGRldiwgJm10a19k
aXNwX292bF9hZGFwdG9yX21hc3Rlcl9vcHMsIG1hdGNoKTsNCj4gKyAgICAgICByZXQgPSBjb21w
b25lbnRfbWFzdGVyX2FkZF93aXRoX21hdGNoKGRldiwgJm10a19kaXNwX292bF9hZGFwdG9yX21h
c3Rlcl9vcHMsIG1hdGNoKTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAg
cmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gYWRkIGNvbXBvbmVudCBt
YXN0ZXJcbiIpOw0KPiANCj4gICAgICAgICBwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiANCj4g
ICAgICAgICByZXQgPSBjb21wb25lbnRfYWRkKGRldiwgJm10a19kaXNwX292bF9hZGFwdG9yX2Nv
bXBfb3BzKTsNCj4gICAgICAgICBpZiAocmV0ICE9IDApIHsNCj4gKyAgICAgICAgICAgICAgIGNv
bXBvbmVudF9tYXN0ZXJfZGVsKGRldiwgJm10a19kaXNwX292bF9hZGFwdG9yX21hc3Rlcl9vcHMp
Ow0KPiAgICAgICAgICAgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICAgICAgICAg
ICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBhZGQgY29t
cG9uZW50XG4iKTsNCj4gICAgICAgICB9DQo+IEBAIC02NjYsNiArNjcwLDcgQEAgc3RhdGljIGlu
dCBtdGtfZGlzcF9vdmxfYWRhcHRvcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiANCj4gIHN0YXRpYyB2b2lkIG10a19kaXNwX292bF9hZGFwdG9yX3JlbW92ZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiArICAgICAgIGNvbXBvbmVudF9kZWwoJnBk
ZXYtPmRldiwgJm10a19kaXNwX292bF9hZGFwdG9yX2NvbXBfb3BzKTsNCj4gICAgICAgICBjb21w
b25lbnRfbWFzdGVyX2RlbCgmcGRldi0+ZGV2LCAmbXRrX2Rpc3Bfb3ZsX2FkYXB0b3JfbWFzdGVy
X29wcyk7DQo+ICAgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiAgfQ0K
PiAtLQ0KPiAyLjUxLjANCg0K
