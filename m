Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080843AB0;
	Thu, 16 Jul 2026 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167631; cv=fail; b=s5ka+6+tyiYDR6GBf9MTgbVPPcJi5EY8HXzsr85MVPYWx8OxG039mO4eGgVnhQ/setvwdobHjquDLVa41qxUMNb+f0FuhMC/83ZcJXFBdCLTnwFj1fNSwYEU3aRIcuyKO4uM37WAi8r6pt9WCvN02BWg9kAjfBveCifNbAyi8vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167631; c=relaxed/simple;
	bh=whNCmdXAsvwQjby32Q8fwxwX859R5RSKkNLOpgqdrRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cz4R8RtpTQOijNIxdYCI7WcNqVSOaznmixx4nw2jKKDLPqS71N+D8oJMSiBwvLDeVxrNyEq5qhpw8DBMg9GBx/3cPKv0cqXViO1TM3LZWepkaLgd+UZ5cCxnnCCpAgntyz0Gkc2bv9iQWyjyNNE2KQhQ/1wzTs49oLTDAuYZGOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sIMwjHuO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nsKnDLTp; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sIMwjHuO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nsKnDLTp"
X-UUID: 0a19718280bb11f18dc8c9802ae25ab1-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=whNCmdXAsvwQjby32Q8fwxwX859R5RSKkNLOpgqdrRg=;
	b=sIMwjHuO9i0JpGyHYm3YIFKEqaJPU2r3qlAMSlvYd3tXNj8FAuyJ/WwYcEl9QBzUE13WAuLzc9UUu5EbvFs5d2RewWtvm5Tl7N+1TlHnrxo7B/6J/oaMFYsGIXGUOUSUQ1/fCKNaeOtFrKr8akp76DsILUeQQE1r/SIN4tWNiBw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:1e939a7e-c492-48cd-9396-e728db0db706,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:d752a7c6-b6d1-4d54-8526-d85a67206e4b,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a19718280bb11f18dc8c9802ae25ab1-20260716
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1824096838; Thu, 16 Jul 2026 10:07:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Jul 2026 10:07:02 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Jul 2026 10:07:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9qN+ZXDcEVxr4OwLrfXar9wIah5yf04wR7NpDEzEcnYWTEjt4Mvh/Qd1Fbx3Hgm9gyplxu6mk0x7gdwSsXEdC1SVjHnk3R+gFUA837ftV9+6Nm+Se6pfVzeLHCeKAJLHv+UUIWhKe7iW3795txQ2YmasFdR5jJ8Wrg2QFS90TJdDUpFRHGTffHYeTzhKIPxouItgw+eT/wzCRdQUR1e5eKoadhlOaZAS5VQ8arha5CM4FSEfdxtKjwmAnhNOKVVLxEBCpFyoj/oIes/ZgaW8AEJEE9Bhk+ZbCkvj35S0IBkShAroiFz2ykpFQtCcjrc225ZjKyCW/weBKDs5oLI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whNCmdXAsvwQjby32Q8fwxwX859R5RSKkNLOpgqdrRg=;
 b=leJyYNo6ZFdpFqPWfbAEm4BX/uJGr2q/4EnI2DGYV+2BxWbeiH8Sc1GPYcy+qP6vVpzEXIx7TozpiH3Wl2pAXLK/Dq9JMzbDYKydQlmIdHv9R+ArQXXaOg07hMQDhxCfTJnQaEuBmOXv3v+pKoma2MI+gNnf2NIKK+LxUOGyblagr+5e9ErgGw3ufBgjw7nVUszef+eqoN4U7sRB/+KyOjryli8QYCLM1zunjwRmLRzF7p5G6p/oajEP5XZLZF7y7llZh7cRsTm6lXq3RIKT2BlRdFIbVbPXzG6Xpomx62cMbHJb7TlKXzUB6O66zAGWXVIEPiROtbpl14GniXDGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whNCmdXAsvwQjby32Q8fwxwX859R5RSKkNLOpgqdrRg=;
 b=nsKnDLTpdjZBtfdtb2XrYttek0+ecUXZiVmAc2R+7sSzWTgVH+l7dZ1ToipnXV2l29ZchW8Xt4hmQsJ3uGhoCaPMLd7azwtbMarnSG3trhTQJvVthiy+RW39UbcmWxfzhwk165Gs4KvC31suzdiTIsHdJkofE7qUu340TRqLgh4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY2PPF2525F04F7.apcprd03.prod.outlook.com (2603:1096:408::9c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 02:06:59 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 02:06:59 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "vulab@iscas.ac.cn"
	<vulab@iscas.ac.cn>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/mediatek: fix of_node leak in mtk_drm_probe loop
Thread-Topic: [PATCH v2] drm/mediatek: fix of_node leak in mtk_drm_probe loop
Thread-Index: AQHdBwmsc1xiYzegy0+FYUp8k+PbtbZvgXwA
Date: Thu, 16 Jul 2026 02:06:59 +0000
Message-ID: <eb2062305868dca02d34d8f09caddbc8a91e5cd5.camel@mediatek.com>
References: <20260628141751.47090-1-vulab@iscas.ac.cn>
In-Reply-To: <20260628141751.47090-1-vulab@iscas.ac.cn>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY2PPF2525F04F7:EE_
x-ms-office365-filtering-correlation-id: cef087d5-df17-49a7-e32f-08dee2deeb98
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|42112799006|1800799024|7416014|376014|366016|38070700021|10067099003|56012099006|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info: 8TcliIzK8V4v71nOClZdiDn3/uKdQwh2DhmVwYJVkCLl55bjufsNxGmxJrTYtuOEwNHVeWf+m4KY4DEbBAnfadjwcGqIQsbE3v7QUizrxwFDbBlOt8qBbpCjEQ/kIhKemW5eP6m7TlCPZ+/RvvACIwl04C9QK6GHQ7A7GSV3pPdWxW4qWkNWqFEX67x6fCN7qI7Ez41wvmE0vRMruCU5rXw+Z5+kdXs7ny2mwz++wHwo6Lawvebxvh4gAi+NXi96+yp8sQblCwDCPa694ZOOWBbWZZscJb1GnMiY6Es8fyDDr6Mp6sLjJMiLuGOYQoZvrxGSp9+PQiqJAuBKlIv08aM+c7z038s5GZ2UT7HLQwtVciO997NqZLxAZACrGzaMPN8auXOmcZdPz0HobIXMyzXByYdjiBRTIqdIEI5lZoN+ncVoWa8vaEC9JjF2GZSKpKP2pBqvBWHc6K3QPX8a91acBsGgHgudoA56WlWQSVyUBH3ejxLo7CCnKqBMZMiKWTWkyrrDdOC4KWsFCQZkhhO/v0cUYDuuVS38D0eUaQ9nUBOOGbO4LwjCu2IgYRhj+Rj9Ut+8CBGm92OIzIedKdWA9vV1w89mJiLoG8qTJvVFddQhqzOaSD3lwF+PuxOQuJpqb/TM4TtPxu+Jdo1F6Pd4gtCEifRP+GS15fpYofHFFgY+leSOyFWaXIcWutXUHfvTqf9RiBjU3cQiy8zIMXcdm5rl9oOPL7vSWXvyqo0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(42112799006)(1800799024)(7416014)(376014)(366016)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk8xL3hPOUV5TGVsQXBsdTg0M2EwcTdWZ1ZjeERBYXpnZ09WWForNnVCWmY2?=
 =?utf-8?B?UVU1Uy9nTEhpSW56d3l3dEJEQm16Wjg1dGx6SEsyVmJEdGdzNmpJN29GSjJY?=
 =?utf-8?B?V3lrREk5VFdtVllqQzBiM0FOckNqMXNra0F5OWVOaG5LaDZCUXFnZW5BODlK?=
 =?utf-8?B?bXhRQkVvMWV2L3J1a2dtTUd6MEI0aDJmVEovUEVRMS92dlZvSGV5aUdkOXRa?=
 =?utf-8?B?aEhMSkl0Rk8xdFk5WGx1Tk1hYVd6OEpDZEdnQlFuK0V0TCtEWFovVGZkVi9R?=
 =?utf-8?B?RjlwQVc0MHhHZGpaOHB5T05QbkJOVjJ5dGJxS2dEK2ZmT0l6aXVzMGJqcEI5?=
 =?utf-8?B?d2JuK3pxdGFNNDY2aUJwa2hXZEtOTlEzajAwSzIwdHNjZ3FGZU0vWVpFQ3dj?=
 =?utf-8?B?N1g0R2NpeWthOXVkRkliQ2xzaXNRS0F5M05neG1Xb2I2QW4rQlNZelVlaTBH?=
 =?utf-8?B?NXJVYzlyb0lBSHZ0RVFJeW9nZDAvclk5enRRc3JYWUhQeld4YnVwUVRDZ2J1?=
 =?utf-8?B?UDJXaVJ0ZDBTUVJwd3BOejBBdnhwWFdNMXFYRHhSeWRFRnQrVk1sQVdnVzEw?=
 =?utf-8?B?N0VmWFdnbE9Nd3RjMWsyYmxzSnVVVk8wcGI4NW9iUTYybDA2b3ZYWng0TlYy?=
 =?utf-8?B?VjJDVVFqTXN6V0taSW85M0F1aEk1OWpMQ0RBZnlOUWVKLzRreGJRaTBJYlky?=
 =?utf-8?B?dzdXaUxUM0ExanVLQk5Hb3IzVW00UXAzVGFUQXNuRFhDeDNTbUZRSHE1Vkho?=
 =?utf-8?B?QmpXSDZ1TFZKWlZVR1psM0hjemx6Zmt0amdLbDErOTBhaW1jcGo0OHJiSmF5?=
 =?utf-8?B?UXdnZDNCZWVMMlduZnVyRmQ0L0lxYW9Hd3RNSEg5NFI3d3IxcHh5amFheFd1?=
 =?utf-8?B?bk1IQi9oeWdhUGhITElJTVpkc1dJUUVHL3BhQ3g1YTNZK2pVZVNHTlUyVlM0?=
 =?utf-8?B?MzNCc3NyM3lmUXFNZ09HdzBHd2FMUFJSdy9rZ1RYeTR6cEw0NVpCUEdrMDl6?=
 =?utf-8?B?TStOMFE3c0wydGxtRkJicDVUczRtNkg4dlFaenkzeTgyWm9NZmZ3TGNxWmVx?=
 =?utf-8?B?by9qSjYySmpjWWVXb0VYamdsd2pmdXJkYVRXRVZSTWFJVHhUTjhxc2x1NkVs?=
 =?utf-8?B?YnB5QnJVakxHRW03SExQUm5QMkFmcHNoUnQvYzgvR3RkOHFYTkpPOWVFZXFJ?=
 =?utf-8?B?a2htcVF2QS9xVjBoOTFhZDM5RU5MM2E1dmMya1FlSExSRGxROW9kazN1UHZp?=
 =?utf-8?B?TFdLUnBRVmRpNFJUTjBXTmZ1RHNxTURXSEVubml4bTBUYnpaNW1talpOQzhV?=
 =?utf-8?B?TnIyL3NsQ2ZHckE4N1A1bFQ4TkZ0MTNkbmM0UURrWmhQbExicFJWS0twbTZM?=
 =?utf-8?B?aTRHZTVoYitCMnJUemF0NE0vNmdyTEdERHY2UE5XNjJYVTI4dUd2TGwxSCtv?=
 =?utf-8?B?c1oyQ3NuWXVkcTJJa2xSK3AvQU1lb2xYRndyclFudHEzVzY3MjJZZXY4akpt?=
 =?utf-8?B?WkNUOFp1bm11NVVScjdwL2ZmOFVYZDFqaHcwNXNXbFczNGNXWW55akhWUzAy?=
 =?utf-8?B?T01qV0V4dXNmays5Zko3L3ZFUjh0TVpkUU9Md0Fxc3cyNEpTbzJHK1pNdUVu?=
 =?utf-8?B?YUtTcGs1U1ZPN3RSenFaWEpmWGhQTHJVK2xJOFRyYmg4Ykoxc2xINmJ1U3I3?=
 =?utf-8?B?c3c3QldWanlGNU1xV3l6bXUvdFA2SmpScHhreUFrWFE0UUtmdkhjYUQwaWxk?=
 =?utf-8?B?Q0x3bmFqMFl4YkNuanYzeDlic0IvbjcwU0x5ZWt1bHczTThDNkZ5dlJiaThH?=
 =?utf-8?B?K3RBcG9EbURoMmdON1NRR1R0M2IrZGVuQTJ6Sm1YdjI3d2tGRDZJYlRYakxY?=
 =?utf-8?B?dUVVWnNlQVFLc3dZeEl3NGFxRitRZkJ3MnY2WWJYRmVVZytZekdaZytLKzcw?=
 =?utf-8?B?RXNSdW9MSnY1MTgrRTgxdXMveTc4azhGOVhXei94WWRFbjQreFR5MkRrQkRB?=
 =?utf-8?B?TUhNaWdGbnNaME5NbTJWOXFYK2NmaWtEYytWa3Qwdm9IOE04YU1nREJEWmND?=
 =?utf-8?B?NFlwSC92WDEyT2RoVkdVU0FtaldjekJpVEN1b2FvNU1QelEvUHc3MWFvYWE1?=
 =?utf-8?B?ZHVjTWRBUnc5SEhwWjdLOWREbVNuRGd3NHJWdTk3VXdMeDNYQTY4MWZiREk2?=
 =?utf-8?B?bWFEZ3FKek1jcWxROUhUSm1zUFhxdEUyRjVYbzk4VGN1SEY1dFRBcXF3RXlX?=
 =?utf-8?B?SjR5Vkw2aUo1VGpIYjJJUU5wT1I5dHdYdlEzbDBMR2ExUy9oRlJ6YVVUVlhj?=
 =?utf-8?B?b1h1TXB1MzlOaTRrcjNOdG5KSHZSTG1Idk1KYnFueThQc0pWK2ZFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66566AD5C22B954D9DD352035319F721@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jTbohME+EB7wc9F9kB6hNnMEiIGcSpYjA2lDS/XMPr0gtzzHPmO/Vp6nsbtCsIx+DxMr3gZvSVPSaB8Uzgg1Pt5ClYgBZxXN9+15p8A7Poq3k98JKZpUS644CU++o16sxR8d7dN/1reFtMc963Z5kEAjy3rMQ+a5QQKeLnTR0QKM5MqXeOu8AeK8keIDFgS3+R8nbm9ykCz1ocYDeFBBwrnWopn2gWWZSQ+fV8f3mqGuFraKIobnli4afLG/UJrcb+e+gYl5d5vHTi+WuenOZ7B577xp+Z/d4jnddCXKoxvcqbSKk/YHW774Q7jlcYPnpqpoXMrerX7TNdx/4ffadw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef087d5-df17-49a7-e32f-08dee2deeb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 02:06:59.6187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVpdFo2y3LFpVGiciuHCnuumNQspLG7fA0Q3XbEbjH5IDbAliWJUQqxOOK4j/d53rSIeloeR54k1QX77LI0AfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF2525F04F7
X-MTK: N

T24gU3VuLCAyMDI2LTA2LTI4IGF0IDIyOjE3ICswODAwLCBXZW5UYW8gTGlhbmcgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gSW4gdGhlIGZvcl9lYWNoX2NoaWxkX29mX25vZGUgbG9vcCwgcHJpdmF0ZS0+
Y29tcF9ub2RlW2NvbXBfaWRdIGFuZA0KPiBwcml2YXRlLT5tdXRleF9ub2RlIGFyZSBhc3NpZ25l
ZCB2aWEgb2Zfbm9kZV9nZXQgd2l0aG91dCBmaXJzdCByZWxlYXNpbmcNCj4gYW55IHByZXZpb3Vz
bHkgc3RvcmVkIHJlZmVyZW5jZSBmb3IgdGhlIHNhbWUgaW5kZXguIFdoZW4gdGhlIHNhbWUgY29t
cF9pZA0KPiBvciBtbXN5c19pZCBtYXRjaGVzIG11bHRpcGxlIG5vZGVzLCBlYXJsaWVyIG5vZGUg
cmVmZXJlbmNlcyBhcmUNCj4gb3ZlcndyaXR0ZW4gYW5kIHBlcm1hbmVudGx5IGxlYWtlZC4NCj4g
DQo+IFN1Z2dlc3RlZC1ieTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+
IEZpeGVzOiAxZWY3ZWQ0ODM1NmMgKCJkcm0vbWVkaWF0ZWs6IE1vZGlmeSBtZWRpYXRlay1kcm0g
Zm9yIG10ODE5NSBtdWx0aSBtbXN5cyBzdXBwb3J0IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogV2VuVGFvIExpYW5nIDx2dWxhYkBpc2Nhcy5hYy5jbj4N
Cj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gRml4IHBhdGNoIGZvcm1hdCBiYXNlZCBvbiBy
ZXZpZXdlciBmZWVkYmFjaw0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggYzg2YTNmNTRm
MzViLi41ODg2MGY3MDcxYTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2Rydi5jDQo+IEBAIC0xMTM4LDYgKzExMzgsNyBAQCBzdGF0aWMgaW50IG10a19kcm1fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlkID0gb2ZfYWxpYXNfZ2V0X2lkKG5vZGUsICJtdXRleCIpOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoaWQgPCAwIHx8IGlkID09IHByaXZhdGUtPmRhdGEtPm1tc3lzX2lkKSB7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQocHJpdmF0ZS0+
bXV0ZXhfbm9kZSk7DQoNClRoaXMgZHJpdmVyIGhhcyBhbiBhc3N1bXB0aW9uIHRoYXQgb25lIG11
dGV4X25vZGUgaW4gb25lIG1tc3lzIHBpcGVsaW5lLg0KSWYgbW9yZSB0aGFuIG9uZSwgdGhlcmUg
c2hvdWxkIGJlIHNvbWUgZXJyb3IgaGFwcGVuLg0KSXQncyBub3QgbmVjZXNzYXJ5IHRvIGtlZXAg
Z29pbmcuDQpTaW1wbHkgcHJpbnQgZXJyb3IgbWVzc2FnZSBhbmQgcmV0dXJuIGVycm9yIGNvZGUu
DQoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcml2YXRlLT5tdXRleF9ub2Rl
ID0gb2Zfbm9kZV9nZXQobm9kZSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2RiZyhkZXYsICJnZXQgbXV0ZXggZm9yIG1tc3lzICVkIiwgcHJpdmF0ZS0+ZGF0YS0+bW1z
eXNfaWQpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+IEBAIC0xMTU0LDYgKzExNTUs
NyBAQCBzdGF0aWMgaW50IG10a19kcm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gICAgICAgICAgICAgICAgIGlmICghbXRrX2RybV9maW5kX21tc3lzX2NvbXAocHJpdmF0
ZSwgY29tcF9pZCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4g
KyAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KHByaXZhdGUtPmNvbXBfbm9kZVtjb21wX2lkXSk7
DQoNClRoaXMgZHJpdmVyIGhhcyBhbiBhc3N1bXB0aW9uIHRoYXQgZXZlcnkgY29tcF9pZCBvbmx5
IGV4aXN0IG9uY2UgaW4gZGV2aWNlIHRyZWUuDQpJZiBtb3JlIHRoYW4gb25lLCB0aGVyZSBzaG91
bGQgYmUgc29tZSBlcnJvciBoYXBwZW4uDQpJdCdzIG5vdCBuZWNlc3NhcnkgdG8ga2VlcCBnb2lu
Zy4NClNpbXBseSBwcmludCBlcnJvciBtZXNzYWdlIGFuZCByZXR1cm4gZXJyb3IgY29kZS4NCg0K
UmVnYXJkcywNCkNLDQoNCj4gICAgICAgICAgICAgICAgIHByaXZhdGUtPmNvbXBfbm9kZVtjb21w
X2lkXSA9IG9mX25vZGVfZ2V0KG5vZGUpOw0KPiANCj4gICAgICAgICAgICAgICAgIC8qDQo+IC0t
DQo+IDIuMzkuNSAoQXBwbGUgR2l0LTE1NCkNCj4gDQoNCg==
