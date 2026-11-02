Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793620847;
	b=JOX+3yAQiTmhXn5U5m/Ve85PEZj33luPqE7PQ2YXwZMoysHnjP+vprCDEowB0y5tHr8k
	 3MbPsBaPBVlMfm4wzHbO8PAEgPu4BHE17WrpuaNFc6leAnf5EIRSTcWUHZ5LdbG403bPk
	 qw4A3XJR4ru4/7Yujh3oy0WhMLVXllPj18025HTlhALoyDmVbRZntZvu6ZflHCoDVj82P
	 l3jXE7tFzy98BkWSG598p+KQ7XZBXz69phjXRnodhXCCVv2ka1xOWfkCdseXysgjt/dIM
	 T+VNST9AKeuHObJLGqXlmAYhhJOfSL56fFIUWQCmJ0wUJNT3NoM5k27G4Yjb+6pCHWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620847;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=PgdCOsUu+4FttafzDpIpB+3a5mQS5j5KeqSvzdj7l40=;
	b=upROVAsl4Oh+JCgQRXlD2OaOOOZSwmjeLGQ+3LV3hz04MCyhfMLc3V7kjEy9ZjGlfIp8
	 XDkKgLAAZTL/fCwq9F7Dn79R8YqfDXX3r/DKPhKjdtySGhbtLPKZQlOEA2wZiKdD7QltH
	 +DY6gzx20w07+ahm44TFOFaDsP1uUblCRk+v3353gUg8RBnU51huUH2p28smnuFd9LgmW
	 1wgz78qXMnnMyL3FEZDYiNLzjHOI5HnhwUBcussxXuqemeV2WZKkpqVs7ihfFk5fH1CdV
	 wWwUnhMpN9vhvOWUwIPgB3c3rQqueqEAMfhvcqMhIJmWMCPminbOj7Y7O0mGduqctfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=sXx33X1R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CB606A331;
	Mon,  2 Nov 2026 12:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 634CB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=sXx33X1R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5yWGgneIHGWXSm6CznMaNKJ9GIkSeYaJFJEuje9QLXr9wJA0yv7hWGdT3Sks4ImfjQaRau2/WTTg51ss4e+Qu+GBVu39WAWGA1va2X6MPh0kAaTUisAbmG/TZybYQwgZ91nepYGPQX19yb/tzIWMdbY4DZMBq8PFxK/uzFz3HnD0zWHbxcR1RdrTKmqY+x0Igb28lt+StzdYZcGQ3BOI9uLCx7aIK0iRYlJmRxdSq6rX7qqiDHXejpGcuTG9dMmeeKlQnGK6XlrqUGd4/GFueibqothC8keN3stS6oCOhdilWG1ksr9uTp1rEQWoeeVNDw5QV44vcgNGRc1v6GuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgdCOsUu+4FttafzDpIpB+3a5mQS5j5KeqSvzdj7l40=;
 b=hsf7/BZAtBPV88lXH/IK3RxqibvphcU+wFXHXHAu1RkfyMsFx7KQm7UtyYtzGnadkx+pu7+0B5PtMsNrxjte0YDcQHhwjun8X0Rz9+JBSMuGmx8/Q8usZ9kFqLdFwaqJ4gOcuvEDxSkOehK2ZGkxLxitGwJOCglbcXEE6fIT1lQHt8TnCLnwV7uNP+cEEo9ax6QDhNzka4cTTJ8Ft0j1+Q0WrUB2BsKC0sDpCeGLniqOc+fmrjBQqxxEOnCaW4ylNpTBocuYsyjr/wy5oKFC45+ox8gybxZkSYKMT+CYZtNSvvw/bVWJscTveDQdsE8whIVyF4Ms09pEIL6C71l6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgdCOsUu+4FttafzDpIpB+3a5mQS5j5KeqSvzdj7l40=;
 b=sXx33X1RjdYXHd/85Cq5WLZjUDCJqByji610mVwkaPHTRheP1Ib+VV/d/i3nZ9OKgHANs7cDNuQjtBdr24RbzWF8uBHNzpzbBUoukFCBXchgRWxIUuHBecBhBtAVXlPfv0H0+XYuX/KOlB+qpfwvFhA+9wd7BHNVQxbZ+rBHlDFjl0G4AnyN9m9A28Yv3gfdtX9PPfFbuLJ4SGWNtXv9eDACgr9FORBdLJRaholvoO4pVUbuidPFX8LNmnfRY3Am6Fozlk3aIY9knkt43fjSDkxr7ZsKOsyY6Rn3ywfYU0HmNNwk48J8DHGRJwdwEv1FQfPB9iRRzeSF4HLgVxNu1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM (2603:10a6:d10:1a3::22)
 by DU4P189MB3469.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:00:40 +0000
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a]) by FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:00:40 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH 0/3] wifi: ath11k: fix crash recovery panic and order-8
 allocation failure
Date: Mon, 02 Nov 2026 12:59:50 +0100
Message-Id: <20261102-ath11k-oom-v1-0-f3c391bd63f3@est.tech>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZ76GoC/yXMQQ5AMBBA0avIrDXpNFi4iljQDh1CpUUkjbsrl
 m/xf4RAnilAnUXwdHJgtyZgnoG23TqSYJMMSqoKUSrR7RZxFs4tggzqvhpKg1hACjZPA1/frGl
 /h6OfSO/vAe77AcY0XTBuAAAA
X-Change-ID: 20261102-ath11k-oom-ed1cb6f5d114
To: Jeff Johnson <jjohnson@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, 
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, 
 Shashidhar Lakkavalli <slakkavalli@datto.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Jeroen Trappers <jeroen.trappers@gmail.com>, 
 mike Seo <mikeseohyungjin@gmail.com>, 1152007@bugs.debian.org, 
 stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Sathishkumar Muruganandam <quic_murugana@quicinc.com>, 
 John Crispin <john@phrozen.org>, 
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>, 
 Sriram R <sriram.ramachandran@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Yunseong Kim <yunseong.kim@est.tech>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793620836; l=5783;
 i=yunseong.kim@est.tech; s=20260824; h=from:subject:message-id;
 bh=YPZamDP1K0MSCIcDtVuddEU5SKRBxzIAGBpc08SUYXg=;
 b=HW4q5U1n1oOEycs9WoIvuSv98EyXZXOZEK7voYKu8hsuSd6ZbQeaC1gy9EzVyWrle8/3nzntw
 HKyeh7KLTBhCkQaL5Rpn5/xI4LFgoLe9TxYXK7cLMCARRThY8jLoaA1
X-Developer-Key: i=yunseong.kim@est.tech; a=ed25519;
 pk=nfdmjNawkxBHo9UNdzLNBEht8sYmXp0MYUsa/hwC7vw=
X-ClientProxiedBy: LO4P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::15) To FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:d10:1a3::22)
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
X-MS-TrafficTypeDiagnostic: FRWP189MB3398:EE_|DU4P189MB3469:EE_
X-MS-Office365-Filtering-Correlation-Id: 5617aae3-8c49-42c3-83b7-08df38d8e9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261021135927099003|261021123027099003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261022075727099003|261021121427099003|261021130227099003|261026135527099003|261021133027099003|261026130827099003|261022113327099003|261026121527099003|261026140227099003|261022115727099003|261022105027099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qnKyPjNbAqU4WKlnI6Faaqmef34bSR2rhI0fhbLB+ofqrVZHZsagCH5VlrWA5DEd5Snxm23PMmjl9Actbzr4d80Lj8ajSYdZC5HNUWbm67JbgfP5CzcEc1wkdZ7WiZuBkgO3+fONkaCytIIZoPnHzJ3nWdbI3jKcVDgxI/Y2VnA/3a/hUJMeFwkhrCMpwuaYTpnVFREfHgsPXpWJNiqU0aG3magEkSwsr+e57/VDH4rhiYoHsGkTotcs0v6HP8dcU1GBbsCzowBzywoK6Luiy6wB0w3cdJnH2NibCUZpffcPWb8ySWQfmiJkjrwebyTBB0VviB+9+jqLi1HEv53S/9uy+j9A9gIv0pn66FKwHoe9CvFsM73nNUCts5o/4vc5kT9n6mhbys20GbK0SUdk+hkw3QF88ixBjIVXoQL6XWFgmYFUxOFmgSH7OdLj4W8kDC2VxFwS4P5v+rBbWHoECCuS3XMqD0VL/P2m8o7GCdNkDbHMoNlGX/id1Lo0Pq0L2nnCjIs05UJSU+IzZSvUDYhM5oaZRtrGr5DKjIed4lzaV3hKwDFonFdi/pJSvsXyiy9PHD/vpCxocTflz7/bF2CxhjHMOovWxtZ3gh2FvZIOC7TUTD/87EiIx9deUEFJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP189MB3398.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261021135927099003)(261021123027099003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021130227099003)(261026135527099003)(261021133027099003)(261026130827099003)(261022113327099003)(261026121527099003)(261026140227099003)(261022115727099003)(261022105027099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFJWng4U3U0UktMeGZHUktlbWxDNnQ5Q3dZUTlSSGpLSjhkTTM2Mk1qVjFP?=
 =?utf-8?B?ZFVGUUN6UWEwQjlXZ0xYaklRQkIycnc4eDlHd0dpWUZKMTZYbDFURUlvWG83?=
 =?utf-8?B?OGs3K1ZMQ2oyUlR5U3lCUFJaRG93Sk1adFhudzR4YjREbUdHYXB2RXp2T1VS?=
 =?utf-8?B?aHRQRk9tTnVVWnV1OWhINWtBeXZHdGNMR2c3QWxnamVtY2RrU3UvZzQzZEE3?=
 =?utf-8?B?NmQxNzMxcG50Y0FnOC9FcG9PTjkzWDVWQjBETFlueXY1TnN5eHNJWlVObU5Z?=
 =?utf-8?B?dkF6STdRVW1haVJhZFVCYjBHT09iV01NdWhSaDEyVnlmM1R6RWFmeTFVNFhR?=
 =?utf-8?B?VE9leU8xUFllVkNjTDFZbVRGOUw3SXZQYWRoSjlGdndxQXJNK3dnV1htTWpj?=
 =?utf-8?B?M3gzMzlEOTBGOTdGUVFlUE1OemxTVFdtVVZpVGRYRnRMbGJocEdmY016VWZq?=
 =?utf-8?B?TW5Pa3R3MGdBT0ZIOHNiS3BDaHRhaS9NTElVRTBqWEY0OUVVT001eGt5bzFT?=
 =?utf-8?B?VUphN294SzA1RW5JMWdsRkI2enlLR2hUNHNXbVNpcUYwYnRJMXpsMmtsUE9Z?=
 =?utf-8?B?aHNjNFA5T214WFhqN2ZNVGtjcjFWWVVGOXV2YmhBaFZtUnFUZU96a3JISEl0?=
 =?utf-8?B?c01oY3loemlWNnlqSUoybXVoWDJ2bVpBazdDU2x1WFFqNkx6TGRIYnozcFdH?=
 =?utf-8?B?U3J6STVNUEdIa0diakdBOXpncG5NbWQ4Q2lRMUdMUkJLSHJFS2QxR2cxNVJo?=
 =?utf-8?B?d1Z5cEova1dzN242UHdNamErd2JYbm5VWXlvUVA2eGdoYmdKbHNFYVp3UXdM?=
 =?utf-8?B?N3RzS1VaSWQ3ZVZJNnkwOWlqTU16anBUK1VuUkRER0J3d0ljNWFZZ3F5eTUx?=
 =?utf-8?B?V2duTzU4QkRLNXFFVUQwNFh1aytMNHMrbE1tc1hvNGYrREVHZWI3Q1Iwb0lq?=
 =?utf-8?B?RlJ6dUZuQXZ1YjFxNVdia0ZFb2ZqR29ZOWFNQ0h5M2cvTVVoUjk3K1UzVURW?=
 =?utf-8?B?S3RzOXYwWXM3U0VMblo5L3BCZWsvSjlLRkQ3bVFmNFlMd1RldVIxd2phVFBi?=
 =?utf-8?B?ZkIrYldHZ1hvZkdISU1POW1xUWM1cHlXNFlmSmRGTFN2TjY5UnJmTkJIV2N4?=
 =?utf-8?B?VW5PeUFtQlRiWFVyY0tqeWFUaTJjWHZpNm9QWTZkeFQvTjNiaVl1KzdhQURL?=
 =?utf-8?B?UjlRaXBGalJ1MUFSQVZmcGpod3pyWUJ6Nk9Fd0lIQ1p6b21NVVJyK0g1dnA3?=
 =?utf-8?B?YkF4S0tIVUpoWFhJcUt1VlNOV0pYcVhZSzE4aEpUTWFmTjc1elpXcE9BT2c3?=
 =?utf-8?B?V2QwVVlzSmh1aTVPQkRpSTg3ZXp2ZUVlMi9kZWZrVUZ3VnEyS1BxeUh3OHdB?=
 =?utf-8?B?cXUrMnlVNDBLcm5YbTE1aU1xUmNnNDVJVTZBSDZ2YVpUWlB0YXVmSUc5MVpK?=
 =?utf-8?B?R0hkSytuYTE5OGNMYXNtWHhrek5GRmZiNmc4SkhuZTlPYko3L2tFQ1hOVm9a?=
 =?utf-8?B?dGVnVjgvYjl0UUtPeXBkTkdLTk96dXg4blF1aWVlOG1pWFNDTlg0SnpxdGZt?=
 =?utf-8?B?cjJST2VOWVAzTkQzKzc0cEhuWENMUmV0Um1MSFJ3RjhBOEhiSjBZdVQxZ1Ex?=
 =?utf-8?B?c2V6MGhFQjlGQVlhbE10UUJtSzdRQ0RUanorNmhKUXY1MWtvdXY5RnJDMldi?=
 =?utf-8?B?d01EanpsZG5GdjM3R1cvOHBIZVUvK2pYZFEycGJPT2RMaVpRRUJiOWNtMHVo?=
 =?utf-8?B?NlZ5Y3dqQ2tPNE9OTkRxbXR6MTFlLzRPUjhLd00rTFU0Qko1SW9JTDRTUEF6?=
 =?utf-8?B?L1lQZmMvZ09makQ3MWxaWHg2T2ZpamN4SHlGTEF3ZkFDNzZPUkVaYXY3Z3dQ?=
 =?utf-8?B?Zkd0eU1HSGJ2N3VHdlFqdDVuTzFITzVwM2RKcXJVSWVkYm80UGVNTXB2MTEz?=
 =?utf-8?B?WXZkRUpQMjRzemhBdHdHbnh0a0pPN216Njc5QW1OcExoZURETEo5RTF6RVZj?=
 =?utf-8?B?NytTTE80dUY2NjR0MmpwcmZneFJKZUYwUXRpTG1raXZ0eEdNOHExaFpXeHRR?=
 =?utf-8?B?VHhSUzdIcklRVEFvMlQzbGpMcnZqWUJEa1ZzaDlUUXN5N3VrMGRpSUNURHQ2?=
 =?utf-8?B?SHpZM3JJUExQYXJNV1FrSkF6UDVERjcwVnp6QUlCSkloREJNVGtCMmZJVjUv?=
 =?utf-8?B?d3pwdlkvSUl5S3VlVUJLNHFmQWVVSHJINVpscUlqRUNITklESElxaXFTTjJN?=
 =?utf-8?B?YU5xQ1J6bktHOSthRHZ4TlZhVk11YnBNUkhzSGV4dTRtcVJaZHU5a1oyeVl5?=
 =?utf-8?B?MXFpb2VmdEtyNGhsa3dGN2tVbFZGSi83MHJuZ2xxVkRJZVl4LzVCZz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 5617aae3-8c49-42c3-83b7-08df38d8e9b2
X-MS-Exchange-CrossTenant-AuthSource: FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:00:39.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5h57X78344Y8OEAyryjfDD2k3wFpmhqswIFqaNuNl4c+1zRkyMhZH6unSyf1eUCsr8XS6Wa72onfXTcohB3qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB3469

Reported in Debian bug #1152007 on a ThinkPad P16v Gen 1 using Qualcomm
WCN6855 (ath11k_pci), When resuming from suspend, the driver may enter
the firmware crash recovery path:

  ath11k_core_restart() -> ath11k_core_reconfigure_on_crash()

In this path, ath11k_dp_alloc() reallocates data path buffers, including
the tx_status completion buffer:

    size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
    dp->tx_ring[i].tx_status = kmalloc(size, GFP_KERNEL);

With DP_TX_COMP_RING_SIZE = 32768 and 32 bytes per descriptor, this
requires exactly 1,048,576 bytes (1 MiB), which corresponds to an order-8
contiguous allocation from the buddy allocator.

During system suspend and resume, the PM subsystem restricts memory
allocation flags by removing __GFP_IO and __GFP_FS from gfp_allowed_mask
via pm_restrict_gfp_mask(). Under GFP_NOIO:

  1. Direct memory compaction is prohibited because
     gfp_compaction_allowed() returns false without __GFP_IO.
  2. Page reclaim cannot perform I/O to swap out anonymous pages or
     write out dirty pages to backing storage.

If physical memory has become fragmented over uptime, the buddy
allocator cannot assemble a 1 MiB contiguous block, and the order-8
allocation fails with -ENOMEM despite ample total free memory.

When ath11k_dp_alloc() failed with -ENOMEM,
ath11k_core_reconfigure_on_crash() branched to its error exit path and
executed:

    err_hal_srng_deinit:
        ath11k_hal_srng_deinit(ab);
        return ret;

This was fatal for two reasons:

  1. HAL SRNG memory is allocated once at driver probe via
     ath11k_hal_srng_init() and freed at driver remove via
     ath11k_hal_srng_deinit(). Freeing it during crash recovery left
     previously initialized CE and DP rings with dangling pointers into
     unmapped coherent DMA memory (ab->hal.rdp).
  2. ATH11K_FLAG_CRASH_FLUSH was cleared at the start of
     ath11k_core_reconfigure_on_crash() and was not restored upon failure.

When the PM subsystem proceeded to resume subordinate devices, mac80211
invoked drv_start() (via wiphy_resume() -> ath11k_mac_op_start()),
queueing a command via ath11k_ce_send(). Because ATH11K_FLAG_CRASH_FLUSH
was clear, ath11k_ce_send() attempted to access CE ring 3 and called
ath11k_hal_srng_access_begin(), which dereferenced
srng->u.src_ring.tp_addr (pointing into the freed rdp buffer). Under an
IOMMU, this triggered an unhandled page fault in interrupt context,
panicking the kernel.

Attached decoded stacktrace with references of debian 7.2.9+deb13-amd64
vmlinux/source code:

  https://gist.github.com/yskzalloc/9c3d1980a5ea0fbe0cd119042e09c54f

Patch 1:
  wifi: ath11k: don't free HAL SRNG memory when crash recovery fails
  - Preserves HAL SRNG memory across failed crash recovery (retaining its
    probe-to-remove lifecycle).
  - Restores ATH11K_FLAG_CRASH_FLUSH on failure so subsequent CE, WMI,
    and DP operations immediately bail out with -ESHUTDOWN instead of
    touching hardware rings or unmapped memory.

Patch 2:
  wifi: ath11k: use kvmalloc() for the TX completion status buffer
  - Confirms that dp->tx_ring[i].tx_status is a purely host CPU software
    circular buffer used only for memcpy in
    ath11k_dp_tx_completion_handler(); it is never mapped to DMA or
    passed to hardware registers.
  - Replaces kmalloc() with kvmalloc() (and kvfree()) to allow fallback to
    virtually contiguous allocations when physical memory is fragmented
    under GFP_NOIO.
  - Fixes the error unwind path in ath11k_dp_alloc() to destroy IDRs and
    free tx_status if an allocation failure occurs.

Patch 3:
  wifi: ath11k: add KUnit tests for crash recovery and TX status allocation
  - Adds hardware-independent KUnit tests exercising production recovery
    and cleanup logic without hardware emulation:
    * ath11k_test_recovery_success: normal recovery flow.
    * ath11k_test_recovery_tx_status_alloc_fail: verifies -ENOMEM
      handling, ATH11K_FLAG_CRASH_FLUSH restoration, and HAL SRNG
      preservation.
    * ath11k_test_recovery_subsequent_send_prevented: verifies
      -ESHUTDOWN rejection on subsequent ath11k_ce_send() and
      ath11k_dp_tx_send_reo_cmd().
    * ath11k_test_recovery_resource_cleanup_and_teardown: verifies
      recovery retry and full teardown without leaks or double-free.
    * ath11k_test_dp_tx_status_kvmalloc: validates 1 MiB sizing and
      kvmalloc/kvfree lifecycle.

Testing
=======
- Ran the full KUnit test suite under User Mode Linux (UML):
  Ran 5 tests: passed: 5, failed: 0.
- Verified build cleanliness with CONFIG_KUNIT=n and
  CONFIG_ATH11K_KUNIT_TEST=n.

Reported-by: Jeroen Trappers <jeroen.trappers@gmail.com>
Closes: https://bugs.debian.org/1152007
Link: https://bugs.debian.org/1152007
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
Yunseong Kim (3):
      wifi: ath11k: don't free HAL SRNG memory when crash recovery fails
      wifi: ath11k: use kvmalloc() for the TX completion status buffer
      wifi: ath11k: add KUnit tests for crash recovery and TX status allocation

 drivers/net/wireless/ath/ath11k/.kunitconfig |  14 ++
 drivers/net/wireless/ath/ath11k/Kconfig      |  11 +
 drivers/net/wireless/ath/ath11k/Makefile     |   1 +
 drivers/net/wireless/ath/ath11k/core.c       |  50 +++-
 drivers/net/wireless/ath/ath11k/core.h       |  17 ++
 drivers/net/wireless/ath/ath11k/dp.c         |  22 +-
 drivers/net/wireless/ath/ath11k/test.c       | 330 +++++++++++++++++++++++++++
 7 files changed, 434 insertions(+), 11 deletions(-)
---
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20261102-ath11k-oom-ed1cb6f5d114

Best regards,
--  
Yunseong Kim <yunseong.kim@est.tech>

