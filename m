Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792638829;
	b=scEm/wiZ9RJyuYDBySeUX32w0N1cqXIpcC8NqjFCgm4y+SENECzfp61iXHYOGuVccSOf
	 MLW/dnl05stnfSVlQb3aaXFTzSfPQa74FMAhx5aiRNUYvhRQV3nnSv0l/W+NfdriheT8Q
	 9sUoXEjK2wvgwa8SkQBBwZFDKC5E1yhRSlAfMXVBmf3V9iZYqECKTOoelwm4dRFJPI9lN
	 dQWCS57/cPWrA8JMeBxOujizyOvcFDJdvjLcDUxDcsd3YmkYHanxe91FXQvr29a6JL2MZ
	 V9lCR2JqYjvV48zrJ7OP43x9eEcLP/hIaNi6aemcMGfwMqgGWVRCLSky+mdOFGQuehg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638829;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PLiI9Qs2TKiiAVMY7ibIYMOqfRGGs7NOjKb9OVDEkuE=;
	b=xdFYn4tUU7ytzoLQxBzoyxeRefhO9JoMToWeCpzHeD5xs3ZJ8EyP9nDxNX00sQ1Wks4w
	 APdSPk9TkNM5FIsu085aux2MyxXUyKds1VINsVF5N0rXnbhRGAP/m1apApbx89ZQOleg8
	 xapmxZfVA3Udwcol1lPoDcxXZ6BQ3SoBJzBISyGDpm7uuQWzp96wu/GOjFoW4OQ7+MG/3
	 3mS3Jx3v6BPUlId/t3aJksVb4S9uPJzpPvjqjSMSXBg7TlnsZ3vkJfiOQr7yIqU1SNFgG
	 CJyViKgJnWHx2t09EtC7iKowY1Pakty4FXqx3ryWMIkXhrnrGNtbod/BmdyfoaaEQqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mBId4PGO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.59
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FEE606A319;
	Thu, 22 Oct 2026 03:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FEE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mBId4PGO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL/Cwp1wWsUJH6/hdNcBBH5pOXRYTnC8UnzaDwgUyGJhmyK6SCXRLRYWTpLFPX2f+WhCEkmLTGJfYREjM5viDPOE7bwQpCnWLcrkKchXBGYLMxLPGIj8FOczgKMoC6OZ+HKErjucjDeimx24mVrEpDSw+WZd3pQTx04j9M+Fqa/lFc9Su6zXozK9Ek28XJvpHGWSDq7B9++0ELOjbx3pyILgzEKHEDjrHQ81locX5nztdCiAdSDPL7Zy1frl3NMRKyfpTqWCX1TyBfCDHpuJPK+5N0LlQMM+mZYdpKzjCvp8Q2QRkOTSI+g5/tWA9lnj1Jsbi6+ATo0d8o/Wa9pm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLiI9Qs2TKiiAVMY7ibIYMOqfRGGs7NOjKb9OVDEkuE=;
 b=pxgbkkJyE0x6fvyf/bCQAKPGhsbE+r2Hcep8wCzNKSu12KgSUsUVrKjzPG/nAYy9J0STi6TukgD0XgIdu6H7BmZwnJ0aXRn7xSv/oPgmaetJyzogtAJ81b0dizvSb7ve5zbnkqaQR3Apk0zfbZCwWjgqHPuP+JhATPIExMCbXWdh1raJy9s0vu1pr5BHFHkywa7PjDIi89C0s1d5zx4V3/NMZpn7ngfxNiipOzdrt3qf9ikkK3XGm9cdKmK58EckhgDdMRVaA/6d2b18GycBuZyK0b5XzBO96gRrGc1IKrqnkfqq4lHPX3Z5OZQ6CPl2dgdx0S55yaiSK0K1QQD1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLiI9Qs2TKiiAVMY7ibIYMOqfRGGs7NOjKb9OVDEkuE=;
 b=mBId4PGOBN+Qto2nJGFlN2FkwAUPEzx8WWl7BEG2GqiW10/L5VCXixolj8LagHqbB+s3PQ6xN/V5R4L6VwVB4gXGtelxcWNv6fYtRFkG9r+flbU06rmvJnPQvGADzR6YUgIlR+WAzKzvTI0L7a6ayFZYfgRQy0SwhH/27WcnQFHTMmksO0Zo20IwHLvojZVZS4P9vLPOz/C0sDN+9TKUi0AGFerEr8gmjG9eUDsjOK9N4pgIcPj0Vj+IM4uUb9Onme53OjoqvZuov4st675l2nMsRpqRD39PCiq7HWwaso5O7ljXME6OKP+uvDLRVI9AHRzJA2NZzkRPwKAUDMxZUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by GV1PR04MB9198.eurprd04.prod.outlook.com (2603:10a6:150:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:13:44 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 03:13:43 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Thu, 22 Oct 2026 11:15:55 +0800
Subject: [PATCH 2/2] tty: serial: lpuart: disable hardware flow control in
 lpuart32_startup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-b4-lpuart_rts_fix-v1-2-207f91580dee@nxp.com>
References: <20261022-b4-lpuart_rts_fix-v1-0-207f91580dee@nxp.com>
In-Reply-To: <20261022-b4-lpuart_rts_fix-v1-0-207f91580dee@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jingchang Lu <jingchang.lu@freescale.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792638983; l=2309;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=G1NquS1Q3oss5NBklQagpbVKkhFuVXhRkPowe8dMVcc=;
 b=5PYMmdHgA61tnf/1bZTjrOVFrZG5qVi5jLWfycXxgo6wYTOQIaoGB1wVbcWhsrPsumWaDXDym
 ESxs5I7bP9cBmq6dU9bnbgAxwzuVOpbWn74ZRYNDv1/T8lquHFKxLpD
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|GV1PR04MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be01c73-e89a-4753-b011-08df2fea7a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|18002099003|22082099003|261021123027099003|11063799006|261009221227099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DxKiCZl3vt6z03a0HaZTe4Q/WZK7C7FN7eDSXizR2LE7ZpaE1m3H8fp5MXrRcSAnpf9vQvvNmWN7uVtLIfgV3g1WAPOs5Mkhlvb+ubbMDpk0b1uZHTH2IlgpOpFbJ5CZHr3vdqv8ZQyerWoy/w5CZIwu77XXaDLvOBizeCmEsHVA1TMRN/40lKjCUA+EM7x8dcqqfSJ4v45sEGbgAbwbeQkYeXpC9ALRjOVt+VKj/ydcCcZVU4h7QGqLpun/WWoWlbSPqEBcmu8xyURQNIci3MNNUssJyEBpZPavPRRpkVlddzUBlICVI2zTZJs8dUprmjFGmfaPLlDz6Rt+eIv0bdSbO1JYTPvObsF+0H0shNpwHcuT5DOFvInky5NhVAP1b3wtefBAxfoVTKlx2asVTfKX5VJjeY76keV5xzsCQfcAHoVd0Aaa42Umkgpk9sxIU9LMyRyFfkBKMel7v7MNzzweYEL/yZMkBf+7jCT6EP6rqzeIbRKH8I2etvlDrDW1cDfY41Xp9tyJoRVmdicG9tcuY6WC8jCSgi974N4eLHk5K3T0RhT5XF4yUsgkkQ3SiBaS2WoDwhu3kUZQsa8X9zVPc3C0xkZA3Va/bkOFuXhvYA4ZuF6TvFDW4brmkqMMpDL6k5VfD0eHlEGhig9qK7MIc8CqfA2H3lr4wfs/fv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(261021123027099003)(11063799006)(261009221227099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDR3elZMZ3NEUG5nRTRKVTFQRks0Rm9lZVlXekt4TFF4amJUTHlQMllOQ0Jm?=
 =?utf-8?B?QVozYjZEbDFpaCt6OXU4dFowQUlqZVhYWWw3QVFIUmU4VXNyTUx1WnIrZEQv?=
 =?utf-8?B?akF4TVUxeU50dW55TFRMb2RXVEtPUm41WFREV1VUalFHNXVmU0pJbU9DUExE?=
 =?utf-8?B?RUtxYXR1ZkRtcWdLK29YWW4vZWg5WmVaM1Mwdk1meFVMd2hQY2c0bklHcWpO?=
 =?utf-8?B?WHM3SHZkVTZRUGY4cEhxRDA4eVlBay9UbjJUOE1tenNYZE9CKytJdS9KREd3?=
 =?utf-8?B?d3BXSUlvT1h0M2duRnpSMDhrQkZpc1RITlY1OUp0RDUyai9FWWlGVUxQNk1k?=
 =?utf-8?B?V3RXSm1pQTIwZlR6OVkzZUpyUDg0SmFZcm1tSHNFTlQweFdDUDltU3RjUkVj?=
 =?utf-8?B?ZGdnck9IYjN6T1BjTnVkOExpWWRaU1daeG02Qk1WeVhTbDFnWWFmUWRaWW9i?=
 =?utf-8?B?Um5PeUFQeVdiKzhnTFBTcmtsNExzeS83NDBuQUZpR0VvelJKbTdkUjVyczkv?=
 =?utf-8?B?cUZyREhnZk1GeitTWWRHWnhHQlpJWmNZL0p6MVBnMmxqNjdjbzF2ODRrUnlj?=
 =?utf-8?B?TlFSV1RUZUc2bkxadHZ5eG9Cd0NDbnBtaTJDMHVPRGZaOXJlY2lacWtWbllk?=
 =?utf-8?B?NEdTU0UwNkQ1WjVGU1lqTVh3Z0RHbHpzelFDcmlzdEFHd3FHdXkrU1hiSDVC?=
 =?utf-8?B?bmVnU28yczZmbEo0WTdOVmVKdTdjTS85c1Nzc1FRYnVSL1JuYkd5L1h0ZHNp?=
 =?utf-8?B?RUxoM2RzWmdVbUxxWUhILzF5S0l4R0lIemdZeFlkdFFrdjdwSUhieVhLNDNF?=
 =?utf-8?B?c1VTMFVrc0lEaEhMbmQvWVdVTnRtN1BnS2kreUIzb3RqSFE5blhNMnRoTHhB?=
 =?utf-8?B?VHNXR2tjRUM5MEZOcmFQRERDbVoxNFZQSmZoUThGbDJMU0d0WGtDeURITDNC?=
 =?utf-8?B?cCtSMEpPU0dYRVh3eVpXeHJPNEJzd1lwamhWc29GMVFYV2Y3K3JZMWQwRXh1?=
 =?utf-8?B?UVNIUy96d1dZVWovYjB6djY2bjZNc0U5dUY4ZkRCbWQ5WHZoeEdwK1VXa2V2?=
 =?utf-8?B?QXEveFpLSk4xcTJJQ2ZKVUpxVmJ0MW0vVGNnOGE3aGVHOHpGLzY2dm1VTlhm?=
 =?utf-8?B?YjdwN091eGVERVlJd1FnOHFWZWJDa080WDdBQVRPbzVQdnkyMVp0eVM2SWtT?=
 =?utf-8?B?WGpUT1ovK0ltNmhVMlZDWmx5OWNGNnp1N0xLYm1YcmxGTng3YVZSQi9rbzIr?=
 =?utf-8?B?TmF6YnRFL2pnd2F5YUZQb2owa0JDVzdlZVIrNUtUc0tkY3B1VFlrMS9BcmZq?=
 =?utf-8?B?S2F4dVZzTktUNVVWSWpUam9iSWdlY3pQNXcwZExLMnBBa2pSMkJCZy9ld2cy?=
 =?utf-8?B?SzhlYytQaDBlSEFzUGoxY1ArS2hmM05iNW5Ddjc2aTBNSC9ORjJEd0piWjhu?=
 =?utf-8?B?K25TOVM3dFJQZ2ZyUjJlbHgrcE9QcGdyUVJtZFo3VnQ3c0QvdlVRTkpTTVRY?=
 =?utf-8?B?NUR0Z3BQTzNDOGN1OG9BWFVqWDJtSWVoVVcxeHN2L3d0SlpZTXRSL0s5ZVFY?=
 =?utf-8?B?NkdMWTZpWHVRUUZLMEFYRThSOU9JdkxXbmN2ZWVxdThGb0dMdGFDZEZjZmlJ?=
 =?utf-8?B?bDlNMkVzeHNlanVWTnRjTVNZcVBkaW40VG9DbFhoa0c2Q3lMbHkwdjMzQzRa?=
 =?utf-8?B?VFFKa01OM3c0dGRTaFNzbXlEWTJTOFUyUzJLeTFSR1hlR3VWTDV6KzcxZ2xL?=
 =?utf-8?B?ZG5xWlZ4N3kwZXZid2Y4TTRyalhBbEhiZVV0WDRhOUZHREs1RGtUWHFMQWhq?=
 =?utf-8?B?UTBpYVZQTGlIbHAxTEc3ZkpqZjY3OFRQTlVLT2tuZTlzeTZabzNkSkwyU2E2?=
 =?utf-8?B?WGtHbjJhU1pWQyt5a1UyRi9UcDNFZDA2NFFUYkRzcGJRZTBsWkZRQ1o0OHJR?=
 =?utf-8?B?L0Z1ZWpaM1dRZHJCc0h2cnBpbEpVTGF3OXZoU1NUa2xpWDd4SWdOQklZV2Fn?=
 =?utf-8?B?SjhWdHVvcVZoajM4ZjV4WFBpTDZURW9LK0NOSWZLTjBDd2JMWURxeHhsTHcx?=
 =?utf-8?B?N3BZdm13akJLd3p1d2N2SDRZUXZVL0hLdkM1YnVRQUJ0SExORERHREU0bzRn?=
 =?utf-8?B?QnlJaWl2SlplZUNlcW5pUE5qY3psRlpMWDYyVXBkZWZtMy9mK2FWZVpaOG1F?=
 =?utf-8?B?TFdpR05selI1bDg1U25vcHhLYUdpM1FMUFRTVnhsekMwT3o3dDZELzBrdUR6?=
 =?utf-8?B?Q2wzODFCYkZCRkJjaWI5UE0rb2ZqY01CZmgzaXRGV0pvYWF2eXdKWG9LcHQy?=
 =?utf-8?B?T3lCVzgvQzlTMHRHQnc0L0E3RVc2UDNZLzhqYU8rQ1YwUFBOeUlFd3RRd09E?=
 =?utf-8?Q?YqvWqHgCU6UZO6/GDj6Jxn/9QGm798OtVDn5T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be01c73-e89a-4753-b011-08df2fea7a92
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 03:13:43.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdC9oN0JySQEyklS5g/Vl9T3Y4rab7kntXmElOCgq4pkSX+cPxyYMJFcE7sx+MOpy7RrjHoyZzYYQfYPzFhLqO4jLtC7mipI8iOQ1lmoNl4ULXVEKO1mJb5bBntNZZqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9198

From: Sherry Sun <sherry.sun@nxp.com>

The RXRTSE/TXCTSE bits in UARTMODIR are configured by set_termios()
according to CRTSCTS and are left untouched by shutdown(), so they keep
their value from the previous session when the port is started again.

On open, and on resume when a tty is attached, the serial core calls
ops->startup() before set_termios(). lpuart32_startup() enables the
receiver (UARTCTRL_RE), and with RXRTSE still set from the previous
session RTS is asserted immediately. The remote side may then start
sending before set_termios() deasserts RTS again, disables TE/RE and
reprograms the baud rate, so the characters in flight are lost or
corrupted.

Clear RXRTSE/TXCTSE at the beginning of lpuart32_startup() instead.
Together with set_termios() keeping both bits masked until its last
UARTMODIR write, RTS now stays deasserted from startup() until the port
is fully configured. The flow control setting itself is still owned by
set_termios().

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Cc: stable@vger.kernel.org
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 70b69870aaba..87737f0e0f21 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1889,7 +1889,19 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 fifo;
+	u32 fifo, modem;
+
+	/*
+	 * The hardware flow control is configured by set_termios(), which the
+	 * serial core calls after startup() to apply the termios settings. Keep
+	 * it disabled until then, otherwise the RXRTSE left over from the
+	 * previous session asserts RTS as soon as the receiver is enabled
+	 * below, and the remote side may start sending while set_termios()
+	 * still reconfigures the receiver.
+	 */
+	modem = lpuart32_read(port, UARTMODIR);
+	modem &= ~(UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	/* determine FIFO size */
 	fifo = lpuart32_read(port, UARTFIFO);

-- 
2.50.1

