Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793620855;
	b=nuBz7LAMFN2sFb1vuXKE9WbN6tSPX/AVLHN93rWTkHmoXoiemd/ijgdkOxRcisGgUg2E
	 AcR5GOYBlVoWxSMJ+4kQmoH1Y+EQiAYWEiuPhFe0cAJ1eIwcG5TW2VaBSC6lWodt9tTOl
	 3bhOXbEZqCy8oy3Bi9KlGwHvgmhI74W8jhLL7gFypLi3uhX16JYUhsl0jKwjYm4Tn+Q5E
	 O1GiBmPEIj603s7eP07GeP8j+kn7L3blQSxVxYQ8tNJwB8eMa+KcNIomdTP7qFBpOmutC
	 YhIo58g0Bg33+giZtvj8q8WPo2khajXhUw4WXXcXlmFCjI52KhAdRzBG79dNC6pdfiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620855;
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
	bh=U/jbz1/Lb41ClWavGFMSh7IIPfWinYeXERxf4sLBjU0=;
	b=nu0HDBY9xvZxdIrxHYv5nJFpzYd49plN4EyADHHLqd6ykiDKudVrWRF9Upd/3sETVkDS
	 08LLImfhVQ7L1KcKoHMZ2N00vzacVTU76YD27ZxWMozt1FWN0FO0fJYekJYO+gEY5U+O+
	 gdZd1QdXgDhlNvGcei0tr3HWyLjJoOGQVfOOmH7zX3dXUmX2nPFQrrksjd2a6BKV7cxmv
	 qXFqzXHoNftWAv+gd2BHigq3gjoe3Gv7O5UZEt9lY5nLkIEJ1gKmauMbzRC3TTL7zDCVE
	 oZjtIuphgl0TfM6e2bMWDRrmBez5BCBg8t/CdeEB3pHJvO17V9C8NNi8RfOG/StZ+Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Cnem6i5f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A30606A96B;
	Mon,  2 Nov 2026 12:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A30606A96B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Cnem6i5f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eicFRZMEvJfsVUboZB1ZXJ7RuMbhIbrxM3vBhTWSIoaWGxqxLFTeJDxWgkv+2z1V4bUVllHqEvLGB5/j4UPzwmRHpOMUhrfHJKhreqxBu7S45kyiwvR5PU3f+jAjROwCZBMLHBs1v1SwuDHwl5uhjPNOJvCmwizarUKZMZB/ob+/T9gmR5uSMCuzy1ceYqsMMiIwPBo53oRFfBbhetW4EFtIThisNfat3tcg+K6kxM3HRAr9emggscGqm6wySqXhu+NcIHH9p0diJ1RYhTnFg7efr9wVZVe0fRZ1EHRqqGLeInmGKH3Pipw/NwiR+4MUosJ0GAngzwAgzD8koEgvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/jbz1/Lb41ClWavGFMSh7IIPfWinYeXERxf4sLBjU0=;
 b=RXlna7B16snqOzip8PAjpHhzdc38jRM1/eUAhPKPBtBP9iSiEJ1h6KBsaeXkDbnV7nHfpLYFSQw0hsqprNwXQtCbltFiSkVG9MY+qf3+TfU8a60WwbiYkgq+dNTRdgh+9dJuL9vj68N8JBmVTJcXlb+yG6aW1qVEgGMetOhYnSOtqpetqIDrXonIxJlN8hpA9W8vOpgqWWEI/GwGaeG8+6gMK7IIJUml4PgYKlExMsGECPs6MfLqlTmzLi6x0u5tO/ykv6pZdByfjUFqVF1bMDsfjStnPZU7Yca66ifxY5B2GlezZyrRZa81Gu4DlI8tNpe7mqYvfaymYxTiAScyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/jbz1/Lb41ClWavGFMSh7IIPfWinYeXERxf4sLBjU0=;
 b=Cnem6i5fTuKg47lAt7iuo/SRLyHTxmg0G/vye6vXKHR5kFQJAOzSeDJnDqtVeRD3/1rMAtsPm1li1Ry9qqad9B2t3fiw+7zJt8SPx8rx7sRkE3EBdlK/FonK7F7gww+fVSDfxdXtv9KDrvKR23Ey2g213s6hnY0KHUcon9R7PK5/rjMSkjqRF0Um1JZOkSQpbXiarSzSmHWVpsGlkdOpK4yWD1nyennu2vTp9OrbmFDJXjf9u6wS+q69Ai2AjD4oQqf4tGpXfenTyNqArNNzZi5Anp6UuyX/xiCp9UOAGDmLBc+NlYfDP1g7KLt4cqyAfNZOAFceWNJ+Hek3Pkk45g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM (2603:10a6:d10:1a3::22)
 by DU4P189MB3469.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:00:46 +0000
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a]) by FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:00:45 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
Date: Mon, 02 Nov 2026 12:59:52 +0100
Subject: [PATCH 2/3] wifi: ath11k: use kvmalloc() for the TX completion
 status buffer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ath11k-oom-v1-2-f3c391bd63f3@est.tech>
References: <20261102-ath11k-oom-v1-0-f3c391bd63f3@est.tech>
In-Reply-To: <20261102-ath11k-oom-v1-0-f3c391bd63f3@est.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793620836; l=3754;
 i=yunseong.kim@est.tech; s=20260824; h=from:subject:message-id;
 bh=dqzWZAl5pXYM5MqPaltYm1q8eR6nqdc7wV1pnpEz5bc=;
 b=ML76rRZN+PHkLa+YrU08RtvCOb9z8f8K/bt+EkWrJ8LOV1DR/5LKDTDTkS+VfoETY52B8Z218
 JxuLswy36SXDi9z36IFa2IECRFPsBjYrvJbzx9E3Havdx4wlc07Ny6b
X-Developer-Key: i=yunseong.kim@est.tech; a=ed25519;
 pk=nfdmjNawkxBHo9UNdzLNBEht8sYmXp0MYUsa/hwC7vw=
X-ClientProxiedBy: DU7P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::17) To FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: d96cc247-10e0-4cf7-27bf-08df38d8ed04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261021135927099003|261021123027099003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261022075727099003|261021121427099003|261021130227099003|261026135527099003|261021133027099003|261026130827099003|261022113327099003|261026121527099003|261026140227099003|261022115727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4RKn0V+NFiiAaexBaO7JMgBR3BboSGgNt7tb/13tDGWq15KVUJRUAv7Llp3n7kQXMRaqpV1PoUSUEvSk0Kh3rAPm970/yMua7qBdlU48uoogFsd1DUkt271ABtaJaYFwOITbAKEEO9Cyvewo3Tb1/O1+BlTHn69ZhD7/ehDmOg6eVAHUep9k1xGbZpY1KtV7TI3euwm002DLye7wnMSzkjVkzRWj4d6kbWthp1qYltPbOVgjm0aNeH0Hs1IrAGIqvprm7ipc63zaKOuNnbRktIybOBJNyoGHKiM9YAldkS8gvc6W/guYsGrOsiryPK9DNDX6AGgtKu9NyApYQwnchIJ7o228nhsjWGS6CD63C1naIRmWaAn7eM2skQFjlIsDlUOgbtu/WxkEXXopDLnJzeDOv84qgd9nXXrNmd4uoSjPp5HMjPTDeadyP5QXtOb/A9ko6mEz1viNUgI72IwNPOoSC78YIcmwseYqE7dgDJhZ/9nAkfX0egdRIjla+hnHe9oPYD5bdoCsC0mKqwfIFaS/9lNlDlEFo5wIeGe8MZu7X7yUdnQ4gbpwhxyILJzY1Qq98uihPTjF+vNDqR69FESvXknlFaIPNTujYI9c0C7uYjqavd9yYaAHpN+38wjt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP189MB3398.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261021135927099003)(261021123027099003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021130227099003)(261026135527099003)(261021133027099003)(261026130827099003)(261022113327099003)(261026121527099003)(261026140227099003)(261022115727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhjMUN3R093bkNSSGRqQnNRdjA1RU1TNXRzdmN3L0NSYjJXQU1iWFN0cGcx?=
 =?utf-8?B?ZHJ4bS9oV2hHSGREa1Z5aUlVNTRrOHhic2NQYnZ2OWk5b0JSVHJvUmY3bi9p?=
 =?utf-8?B?YzdZTUVacUVVaUV2Y013YnlFRUpac1h2SENVZ01vMjBiSXFDYlZxRk15OGlJ?=
 =?utf-8?B?YkEyZ2VDS3NaY0VNODVxSnJtYzgwS2lLRFdoVDdIY1p2Ym1jRTRNbmZtcFBH?=
 =?utf-8?B?clk4cXpaZStzQXBnZWg4cGRhOFBET2VzckM1T3VRV2wvT1NyNy8vd2psSHoz?=
 =?utf-8?B?enVsQk0vOUphcVRXaUdLZndMRHR5ZjF2aTB1V28xTzZoSG85Y1A5aFp2eDVw?=
 =?utf-8?B?S2UyU01NejFvZWtOSngzbTlnNjdNWUpPUGZ0ZmJPSitYWGdjeUNNQTV2dzho?=
 =?utf-8?B?ZnUvZHFKRXVKbXU4WFBwY2xQQklxdFV2RXZOSnQ3azRhUk5Ld2JXaWZzckVC?=
 =?utf-8?B?dkFDU2NlU01EYVU5MmhMSmNRb0dnR09Gc2ROYVVpT3pFV29HcTFIdnlMMGda?=
 =?utf-8?B?Vks3bHpZNHBvbmwyaTlrbzIrZmZPSWFYclZnY2h6bUJMK05TL2Y5d0tPc21O?=
 =?utf-8?B?Q0hhcWhJd1lqV3RENkphUTN1YjQvbHB4Zy9ocjZpU0ltVjlwS0JsSXIyTnN6?=
 =?utf-8?B?NklSWEZKbGNiMFdGajFuUENST2p3REYvNDVsbi9KTmdEdFFuWWozNFpSUkI2?=
 =?utf-8?B?SUVPRlJ1S3U5UmpDaEs1OFkvMVJxRzRFTi9weWNVOGNqbm1EQUVkK1dBbGNV?=
 =?utf-8?B?MGV3TFNSMW9FNlNVckFWWnpZYkorSVFKRzNCSWhIZU1mNlRRMkVlTnMvdWJi?=
 =?utf-8?B?RmRGK3ozK1UxcXVJL0gxL284VnlSb21nWGlSRmRKazZ2aDFLWUthbnVOTjRG?=
 =?utf-8?B?YlMwSUNTUk9jemRpYTdmUTFaLy9xYXdqM1dlMmlXQW85OFk5U082ZHVuRThS?=
 =?utf-8?B?NzJ2cE9YTXhDS3lnMDM1bldhekgzOTh4TlJGU3VzVWM0dEdvaHM3WVF0UGo5?=
 =?utf-8?B?MjdIVUFVM21HKzJjWnZpejRudmkzTWpWMkYwaUZtZlBJRzhZNEhVWWVIR3dV?=
 =?utf-8?B?Nm1DemhlZVBCRGc3TW51QThkQWc0cUlMV0x3V2VZaU4xVGE1SHo3eks0aW9Z?=
 =?utf-8?B?VSt0QStXanM3M0VCdXllY01GdFJjUWlkek5odjZNZzk0WisrZSt5VytSNmZu?=
 =?utf-8?B?OVgrWVFhUmhBSHlYaHQ5TzNBa2ZUYjhsanZQUEE1MlVLRDVQTjVibEhVRWNa?=
 =?utf-8?B?bm1NeUtQM1hCK0VuVXcycmdiUWVpeWZPZ0I5MXREUVgvL3lsWkNUWFRHbzhC?=
 =?utf-8?B?a0svWE9adStNVHN4ZitQbWxhZ0dXMzJ3dXBwL25YQlAzdjBQS2IxTTc5NldB?=
 =?utf-8?B?aENzRlk5Zkk3bWY4NjYwc2NMNzlxM01zYVd3cU9jMUtNS3dSMG44aEhsNEVt?=
 =?utf-8?B?Y0dSa0JqQll6TDhLUUFCYXR1Szd6TW5ZdEZibng2aHltanY5M1N0bEpYbWhw?=
 =?utf-8?B?VEdKRnBYaXRqUWJVUU1jK1NzYUtLb1F5aC9rTFZqNlNybHZLajFzM2JBUFhv?=
 =?utf-8?B?Sm9FdVFmR3RNL1c2UXhKNVZtWnE2cXcvaTNYMitQODBhek9aU2d3Nzk1UnhR?=
 =?utf-8?B?MWEwZ3BrSWltTGlDeVZ1eFRLYURoYTJ4NUZTSjlyeUFSajh6MVBlTGFIV0N6?=
 =?utf-8?B?K2phLzYvNlhJNWdhMUhtdVg5SU5aZGNKVHZKbjV1ZlVoTmZxVzFtNitFcC9v?=
 =?utf-8?B?OTNpTG9lS3ZYNVhaMjluYkg2VXhrRi9aVzJheG5vRjczbjByUERvVkhpMUZM?=
 =?utf-8?B?SVNkbVB0bVFWQWVHbzJsTFNHK3dSb2J2Mkd1L3R0bGcrWWJyemVlWGhhTEgv?=
 =?utf-8?B?Zm5RMXgydEdmRjFWQWZVbTdDWnQ0NTJvZkF3Yk5USHA5Y29UMXRiNGVkL0Rh?=
 =?utf-8?B?UGcwTVBaMHRaTXpEcGRwK2xTbkRaM3MrTU1vaHlKM1lGMVAwZlJIYUluaTNQ?=
 =?utf-8?B?bDIxbFFRRktwU3B3NVQySEs0K0ZSYVFYODcyTjdpK29DUkRnNHF0QnFHQWtT?=
 =?utf-8?B?WXk0RzNIK24wQkNBMFFEdUp0cjdIa09Nek9LdldUd2MzSXRMOHA1NHc4RDBj?=
 =?utf-8?B?ZHdMeVlnY2JCdVNCeXdJQXJDOHlKSk8zeUp4ZlNCMk1XT1ZKTFdMem1EY1E4?=
 =?utf-8?B?TjNLNCtyc3pGTDByb3VHSGZDbisza2huSkRSZ0N3N1RMeU9aVG1QenFjRlZD?=
 =?utf-8?B?ZFRxaHRhMkcxSkZCT1N4ZE1pZU5WN3BrY3F0bHZYMW1kOVdoNEMvYlpWSVZy?=
 =?utf-8?B?NS8rNzhkNnR5VzFKWGlPM21QWUZpS3dMWnFMSlU1MG9JU0g2WXpCdz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d96cc247-10e0-4cf7-27bf-08df38d8ed04
X-MS-Exchange-CrossTenant-AuthSource: FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:00:45.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBnyvJdNIVfuiVkS2SXeoY+If7dI3loRNETcGAq8BZ0t4HBmwT6mE0FnUpt9PnzfOoCskltpsTKc/AK4vG1N3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB3469

On devices where resume from suspend (e.g. s2idle) goes through the
firmware crash recovery path (ath11k_core_restart() ->
ath11k_core_reconfigure_on_crash()), the driver reinitializes the data
path by calling ath11k_dp_alloc().

ath11k_dp_alloc() allocates a host-side copy of the TX completion ring:
  size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
  dp->tx_ring[i].tx_status = kmalloc(size, GFP_KERNEL);

With 32768 entries of 32 bytes each, this requires a 1 MiB allocation,
corresponding to an order-8 page request from the buddy allocator.

During suspend/resume, the PM core restricts the allocation flags by
clearing __GFP_IO and __GFP_FS from gfp_allowed_mask (via
pm_restrict_gfp_mask()). Under GFP_NOIO, page reclaim cannot perform
I/O to write out dirty pages or swap, and direct memory compaction is
inhibited (gfp_compaction_allowed() returns false without __GFP_IO).
When memory has become fragmented over time, reclaim fails to assemble
a 1 MiB contiguous block, and the order-8 allocation fails with -ENOMEM
even when hundreds of megabytes of total system memory remain free.

The tx_status buffer is accessed purely by host CPU software (memcpy from
the hardware WBM release ring descriptors) and is never mapped to DMA or
device physical addresses. It therefore does not require physically
contiguous pages.

Switch the allocation from kmalloc() to kvmalloc() and kvfree() so that
the allocation can fall back to virtually contiguous memory under
fragmentation, avoiding the reclaim failure.

Additionally, fix the error unwind path in ath11k_dp_alloc(): if an
allocation fails on a multi-ring device or on ring 0, previously allocated
tx_status buffers and initialized txbuf_idr radix trees were never freed
because the caller (ath11k_core_qmi_firmware_ready()) does not invoke
ath11k_dp_free() on failure. Unwind all initialized rings cleanly by
destroying their IDRs and freeing tx_status.

Reported-by: Jeroen Trappers <jeroen.trappers@gmail.com>
Closes: https://bugs.debian.org/1152007
Fixes: d0998eb84ed3 ("ath11k: optimise ath11k_dp_tx_completion_handler")
Cc: Jeroen Trappers <jeroen.trappers@gmail.com>
Cc: 1152007@bugs.debian.org
Cc: stable@vger.kernel.org
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 drivers/net/wireless/ath/ath11k/dp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index be65d73b904b6..45602ec2dce63 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1040,7 +1040,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
 			     ath11k_dp_tx_pending_cleanup, ab);
 		idr_destroy(&dp->tx_ring[i].txbuf_idr);
 		spin_unlock_bh(&dp->tx_ring[i].tx_idr_lock);
-		kfree(dp->tx_ring[i].tx_status);
+		kvfree(dp->tx_ring[i].tx_status);
 		dp->tx_ring[i].tx_status = NULL;
 	}
 
@@ -1093,10 +1093,10 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 		dp->tx_ring[i].tx_status_head = 0;
 		dp->tx_ring[i].tx_status_tail = DP_TX_COMP_RING_SIZE - 1;
-		dp->tx_ring[i].tx_status = kmalloc(size, GFP_KERNEL);
+		dp->tx_ring[i].tx_status = kvmalloc(size, GFP_KERNEL);
 		if (!dp->tx_ring[i].tx_status) {
 			ret = -ENOMEM;
-			goto fail_cmn_srng_cleanup;
+			goto fail_tx_status;
 		}
 	}
 
@@ -1107,7 +1107,14 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 	return 0;
 
-fail_cmn_srng_cleanup:
+fail_tx_status:
+	while (i >= 0) {
+		idr_destroy(&dp->tx_ring[i].txbuf_idr);
+		kvfree(dp->tx_ring[i].tx_status);
+		dp->tx_ring[i].tx_status = NULL;
+		i--;
+	}
+
 	ath11k_dp_srng_common_cleanup(ab);
 
 fail_link_desc_cleanup:

-- 
2.47.3

