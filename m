Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202155;
	b=UpMg9eytA2mNg2JYlQDzXTTV8OiprTPkSUv4dEZdysobRLHJn40Bv5rmVR+TeeqJVV7i
	 6zRqyRNvuOT9fVh3UpRMcHWidl2LpMIn9NTDgRTjasNANJtFYvQ2hJM3mZn9t67pEwa0f
	 AncU5RFTVzFr9jSmMKDnPH9PrwO2xxziP9sq3asB48Q5Y5fciky0iz4MKRICwgsDja3Xm
	 vM9sKSEsIwCDKegddDEtd78JlngxdAGL5uM5iLHmM5G5kSpBqmUxRVOTV2ePGD7soGMrc
	 IhQeDXlfMB+W75R7kVVx3Du5niUfm0c9q561UrEfC9BUo6bpwwZdwbpiFn/FnaIA4IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202155;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UF1KiSDPA3yHB/vfgsjHvkHBC0fKpxkCCUhPLGWmbFc=;
	b=u1m8UjJDy1sPT9d9Aoy+C2bMFZwSbH226PI/EXlEt04u1/E8kAOY+7dFTXZHnMEpVr0W
	 yG94RxLrjRdWaPXhm7RJUZsqG9BS9vYS8OrSgaeOvqTmOtzx4MFjo7KsIWwM0KEmwDwIG
	 ddKfnjdbTPn7jkEzV2q+AgnPtNl1EZKD8bfvJU5Wnq+CNJhjGtnyP4nyFzmsXq9xRYrs6
	 /PPG4gYBKhEqdIHax4WYAeX5CFXBZEdYp6Q5DdlD5Ke38AUOHUqZJsHhxf6X2d/a9QOal
	 v+LXWmuBnG/WvOONjtvnmrjIWDRC90KCEGv+O/+IH5lQ1PEYNNqqqvFtYkEbiuk4+HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b="kUcyyAe/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A181606D807;
	Mon,  9 Nov 2026 05:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A181606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=kUcyyAe/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8nxYUo4gnp6NWFL0RlDtnBU1QskW++wqV+GlzhmrOSYABY5b/122QQxy15Ru5nevFbZ8oVaRwQayCuDqP0EG6F2wtJMHmt8ymDghfWjGjpRs3Lg+Cm0j5xZhlWk9VW2ZQivPOIdMR0CUIqHfluT6DT8LfGWNa+XimERJgSSVnjgvhACdkLgYaanUbB08WK/b4CkUzpkTxtcUXdE8lvDjYTrbTmP3+W+qLAAi7Gn80RDVkDETRwsqev36jLykms2orf50E5NiVKIExhVWG+BY6MtsGA5G89nNo0awhzThUHgOfD5SfnLzAhig90Pl0a6gfGUABkozx0d8QLvjuy2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF1KiSDPA3yHB/vfgsjHvkHBC0fKpxkCCUhPLGWmbFc=;
 b=Bi2Nznd9NqU6b3v/Cvchwyp+gGMUF7/T5w09nf4r8bG5MR/+yUn3K4l4mO+iVIg2s0JcebRHl/GPnRxggegQFOhxT+aWNlG8Kd7G535+iFh0SzLH5YSyKtiDi5rJsOWC0BQ4Q2L6zuG8NzeGYjKhjx/UBarOY8FJgi8oBVECRVLBAtEEZq+kv4LruZThSiTQEr52hLn1N8mQgc314veQ4yNkfwMCuaaQLupDbc3ud5X93U4KKg5npyHcCiKXppKinzPRkeBX9n8VdbPJUEIsLD+eY6yw36kJ/cE87P20lqa3ypMgAWhwcdivxwElWV9VFve37w8W+q5/f0G8lnt4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF1KiSDPA3yHB/vfgsjHvkHBC0fKpxkCCUhPLGWmbFc=;
 b=kUcyyAe/HU+yKaxdd5eEUlv4aAQxoeuDClIiwbcDl5Gp6UBEXJ8lF4t6cxvJ/Gazfd/y4V77rI9a96VarRNsa2ZICiNm0K4NxhxaMFaEZbJVYtNjkErpOxthjQVMCNyO6Hrk+QDtwo6PfOddKehrcOayba0rnsOqg9j1MdH3W1IHJJIn/vr6XYz+uBUwAwHDnMGxohLOtnBZmvju8fmJR9rUHDXzkmeOP5MVLUaSk6RABVXMHEZnk6fLJAbxpAWmOKliAj7uot8iDHekry8X9hHcHTw2U4wLpw86TUX16y7Xd97iOeg99zdG7D9JC/PlMyAaEjD2xI3s2xzGQTZZ7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PUVP216MB596218.KORP216.PROD.OUTLOOK.COM (2603:1096:301:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:29:06 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 05:29:06 +0000
From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas.dufresne@collabora.com,
	bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	stable@vger.kernel.org
Subject: [PATCH v2 6/9] media: chips-media: wave5: decode only when the ring holds unclaimed bitstream
Date: Mon,  9 Nov 2026 14:28:50 +0900
Message-Id: <20261109052853.110-7-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0135.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::14) To SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:f::14)
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
X-MS-TrafficTypeDiagnostic: SLXP216MB1148:EE_|PUVP216MB596218:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5e7122-f81e-410a-e904-08df3e225f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|5023799004|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261009220027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6klCp/eSULt8wbxwSWiQNoHOcD5/3X/7LVprf3i93Tv2N9JjNDeV7AnICcag9iSbldyXogJNmOdk6qiDeGGGnaWSIDv9y1GSkeAiGP/3Xic9Nxh3NwFzLLcVHRNkTPgntxm/TVgxLEJthYmdwKHxaQdsvpnAsSuK31RYXfsH1R26vzhsmaLUYmJxrO4tO75ebwhXJCw8gtA7VEOPZjWRcmiib6fE9jhHegr+r1xXdmDihSRF8aB2Q2PvZ2S4FXDfBDX8iWpWwQrd9+K5nraikh0r/9wCNNFPkX7+b0YqTbr836oaPCoCZaUV2VKU7sRW9B6O6LXVM+qpT9vz8otrX6eOBHiTR72Fc7QE7CQVMYI+BbJcWLxpcxUyxJUZYQ4Vtn2VUjRlsG8fu7Unz4k+lrGGR2h5QN9UxMtcbyJqRa2l0LqEDYexNapxr0KdQaXsyD+Y8YqcVVqvofBM2dHUjIb9h3MA/6T7CVTG1H4gvPcKgVRxegUSgf5GWxHNPKHsG+Bi6AG7S71M+ifUWDDS5YlJXq9rFVsSn3ZctAKeT1EwOKtslHLPFMl0XGnIXqxK+FL/r7sEVYgetjr7GoujMhpKspbpkAk9j3EfIlzeHPYXxU9T1CISGT/5U9rI/dUdLC4mov6HGh3P+yOGIxeXko6Th5Lz9i7IBEWJsJ2zN899tW//rw48NQOk+hIMtEf1lBAxcA1Tqz8Zo4N9RsYCPGP0SiUmHYgAr1gosaBnRI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siLXZqncGOnIPNxF6a87SanRnchRgQ/SXkE+pfFXyzGRKouAUKLDg6OG1s9i?=
 =?us-ascii?Q?KMGXyL32xQTMApueeAi6lkXzHja/XnnDEMwK4uUC5R77WQgOihPM47l5h3ba?=
 =?us-ascii?Q?b5tzUeNrkjB63TaAbu6aOgqpXzTBx/KMJUIQEd2CIJKMmj7S4gaH1q75xe+T?=
 =?us-ascii?Q?u+r7f/boc8R8xiE+1LrYcgKTyxKADgZVQBzlHyTeDyQCkStW+Fxd136nfDTh?=
 =?us-ascii?Q?9thBNGGJz2wJwKgDsdVO3MUafIBsB5S81P2GPKCkn5N07sAcXCxJ06+lSlCR?=
 =?us-ascii?Q?z48iUwpTCPtDBio/zKTGgVC0SipQRvnjZFCZZPOh5Min7IEF2O/JBVDG71JW?=
 =?us-ascii?Q?/6bc7fk4y+H9LzHIHdnbHb+8+sXvWhSDl41zODPeMtfXWOjQoHNjUoZQBgjM?=
 =?us-ascii?Q?zZIDxykPP3xDrQxLSa95glcAQuRiyw5E08twGir+OEoCzEMOg6L99FlB7f1o?=
 =?us-ascii?Q?WimRroa+im4SEmTTSu1OzqaWx4K30Ob2bDcNLIvlRBNGeUKVoo5a2sKxTCKf?=
 =?us-ascii?Q?iF3WLaRwfVwAbP7aeekByk3rVNL+bHmCApUQ0f+QbGrejfmZNrn1/xmpckis?=
 =?us-ascii?Q?2HmDRjx2SPKEAAr6Bgc881KjJ5jw/GPG5xKjJpVflkdTS0MBOqXXRew+CQav?=
 =?us-ascii?Q?jap4Q8qqtjzGB2jlVxmLbeT+gQwe9dXTPsaUN8BEobItLSbMTlj4mwm7weF0?=
 =?us-ascii?Q?Y8k015nyaxYOYEpY081H4dxKLuiwUXQvyHwxYe4vqIbeBQr87+VqzYtFYuZL?=
 =?us-ascii?Q?CDY/5AF0Y9mxKf8CTGDpO94Eet1CgRlNExc6i1+uoaUNwMO/DAduVfnCAu5I?=
 =?us-ascii?Q?cksKrdR81uGEiQBXPglYfCUY8/67KNUzquQ5yBzDe6f/TCY2UFDwnfFmlyHz?=
 =?us-ascii?Q?Y4CHWpuFRZkPALgHMK2nUglOzanPIL8kRNvS6Nda6/OUJaRdU0XxwPdGxyW0?=
 =?us-ascii?Q?tVtT6Nj7nLL5AEJ/lyhfHJWxAnG10FTlMkqf2rd67LsAM5bm87eM69D/cxIH?=
 =?us-ascii?Q?hJ2GBsEP/3lVy6u/dxn4aSlP5HNfFzt1jHWpMIJFlr39GYVQmwYynyOMIx4V?=
 =?us-ascii?Q?mi7q37zxVO8ZJtgYpPPv+7QU5uT/ZQrs+4YLzfrXbUgkwnOAHYcvrU6rkWAR?=
 =?us-ascii?Q?jB2AVyfDpLMGrlR0Fw1JTvNhqU2NT5jzrz8UfrHCCy3B9wSrf17YfvAukQk4?=
 =?us-ascii?Q?O5I7dpTaHJWTR2e38GmfQ7/oqOhailKxdyeN2xw2HuKr2Z5ShrhERsh/7j1i?=
 =?us-ascii?Q?wBD7ApDs5C/P6qQyGI2idygh26I1tKNx7PV4FiL748dDeEkbpxnAIohJdX3w?=
 =?us-ascii?Q?aOp6vGfqRNSQ9x16Uh6wOEJXmes5HAl2lqUIQj9kZs/EeAeD6I3KhfNSbxCB?=
 =?us-ascii?Q?u7mYIYHBPL6OpFi5C/y2wKvO79KIVfDC/eCzjGfSXtejb4X0A1l9ytrHjPn+?=
 =?us-ascii?Q?QfI7tPPLiuwnmZTXRio97M2t+5adc9jiehNFLcuUQWJWzrgWuxRGZCgN7nNU?=
 =?us-ascii?Q?tPKr+pe8ki3nZrgexafPLHWQjr2qg6EjruQ/Brn6GSmvldkuyXLRPl0JKmvh?=
 =?us-ascii?Q?DrLNV11ndNUmrpA4EmdEuY9lepxZuHI187qkr6mqOacBYEK/YN9dixRQsZE3?=
 =?us-ascii?Q?DzuGObJ/0raSQ3eUStzIiqRkjR+oTZs8RGnRBdWrNgIY6Lf2d200sk5BlW2I?=
 =?us-ascii?Q?9yFbYCaS3s1lkBXp9P5jXhrgKwu4wAG+i2HU3GL6Gbo5ftM+hvjBLYKrUJeb?=
 =?us-ascii?Q?RiKbvuIj3JDlV8z0Lm8k3rJOWs1FuSM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5e7122-f81e-410a-e904-08df3e225f51
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:06.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuUltT8rwhCzg+N/A+Kuu/urlqBj/Vk54aarOxnAx7gRzxy6xQkFllrfnMf33PZgdPN0Gp678Q+ByfBnJ4mNFIEJ5ZnfDVDRPQXMzDi3v+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

From: Jackson Lee <jackson.lee@chipsnmedia.com>

device_run() decides whether to issue a DEC_PIC by comparing the instance
queue count against the number of OUTPUT buffers held. Those two count
unrelated things and diverge routinely with interrupt timing, so commands
go out against an empty ring buffer, or duplicate one already in flight,
corrupting the decoded output and producing display results the driver is
not expecting.

Decide on the real state instead: decode only when the ring still holds
bitstream and no queued command will consume it.

That can leave an instance idle with data still buffered. If the in-flight
command completes without freeing an OUTPUT buffer, nothing re-runs
device_run() and a client that has queued every buffer it owns cannot
restart it. Re-check on a 100 ms timer, which a normal wait outruns.

release() disables that timer rather than cancelling it: a device_run()
still executing at close can re-arm it until v4l2_m2m_ctx_release() has
waited for that run, and a cancelled timer would then fire on the freed
instance.

Fixes: 8c5a74a24cbb ("media: chips-media: wave5: avoid skipping device_run while VPU has work")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 67 +++++++++++++++++--
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 3ecf535f5622..668c923dfa36 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1618,6 +1618,7 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 	else
 		streamoff_capture(q);
 
+	cancel_delayed_work_sync(&inst->unstall_work);
 	inst->empty_queue = false;
 	inst->sent_eos = false;
 	pm_runtime_put_autosuspend(inst->dev->dev);
@@ -1698,6 +1699,31 @@ static bool wave5_is_draining_or_eos(struct vpu_instance *inst)
 	return m2m_ctx->is_draining || inst->eos;
 }
 
+/*
+ * How long an instance may sit idle with bitstream still buffered before it is
+ * assumed stuck. A normal wait -- including one instance queued behind others on
+ * a shared VPU -- clears in a few milliseconds, so this never fires for it.
+ */
+#define WAVE5_UNSTALL_DELAY_MS 100
+
+static void wave5_vpu_dec_unstall_work(struct work_struct *work)
+{
+	struct vpu_instance *inst = container_of(to_delayed_work(work),
+						 struct vpu_instance, unstall_work);
+
+	/*
+	 * Someone already made progress, or the instance is no longer running a
+	 * picture. Poking the scheduler for an instance that is tearing down
+	 * would queue a job against a context that is about to be freed.
+	 */
+	if (!inst->empty_queue || inst->state != VPU_INST_STATE_PIC_RUN)
+		return;
+
+	dev_dbg(inst->dev->dev, "%s: restarting a stalled instance\n", __func__);
+	inst->empty_queue = false;
+	v4l2_m2m_try_schedule(inst->v4l2_fh.m2m_ctx);
+}
+
 static void wave5_vpu_dec_device_run(void *priv)
 {
 	struct vpu_instance *inst = priv;
@@ -1717,14 +1743,32 @@ static void wave5_vpu_dec_device_run(void *priv)
 		if (ret < 0) {
 			dev_warn(inst->dev->dev, "Filling ring buffer failed\n");
 			goto finish_job_and_return;
-		} else if (!inst->eos &&
-				inst->queuing_num == 0 &&
-				inst->state == VPU_INST_STATE_PIC_RUN) {
+		} else if (!inst->eos && inst->state == VPU_INST_STATE_PIC_RUN) {
+			struct dec_info *dec_info = &inst->codec_info->dec_info;
+			bool ring_has_data;
+
 			wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
-			if (q_status.instance_queue_count == v4l2_m2m_num_src_bufs_ready(m2m_ctx)) {
+			ring_has_data = dec_info->stream_rd_ptr != dec_info->stream_wr_ptr;
+
+			/*
+			 * Nothing new to feed, so stop here and wait -- unless the
+			 * ring still holds bitstream that no queued command will
+			 * consume. Decoding an empty ring, or redoing what an
+			 * in-flight command will take, corrupts the output.
+			 */
+			if (q_status.instance_queue_count || !ring_has_data) {
 				dev_dbg(inst->dev->dev, "%s: no bitstream, skip\n",
 					__func__);
 				inst->empty_queue = true;
+				/*
+				 * Stopping with data left over relies on the
+				 * in-flight command to bring us back. If it ends
+				 * without freeing an OUTPUT buffer, a client that
+				 * holds them all cannot queue one to restart us.
+				 */
+				if (ring_has_data)
+					mod_delayed_work(system_percpu_wq, &inst->unstall_work,
+							 msecs_to_jiffies(WAVE5_UNSTALL_DELAY_MS));
 				goto finish_job_and_return;
 			}
 		}
@@ -1966,6 +2010,7 @@ static int wave5_vpu_open_dec(struct file *filp)
 	mutex_init(&inst->feed_lock);
 	mutex_init(&inst->run_lock);
 	INIT_LIST_HEAD(&inst->avail_src_bufs);
+	INIT_DELAYED_WORK(&inst->unstall_work, wave5_vpu_dec_unstall_work);
 
 	inst->codec_info = kzalloc_obj(*inst->codec_info);
 	if (!inst->codec_info) {
@@ -2060,6 +2105,20 @@ static int wave5_vpu_open_dec(struct file *filp)
 
 static int wave5_vpu_dec_release(struct file *filp)
 {
+	struct vpu_instance *inst = file_to_vpu_inst(filp);
+
+	/*
+	 * The unstall timer dereferences both m2m_ctx and inst, which
+	 * wave5_vpu_release_device() frees. stop_streaming() disarms it for a
+	 * streaming instance; make sure nothing is left pending on any other path.
+	 *
+	 * Disable it rather than cancel it: a device_run() still executing
+	 * here can re-arm it until v4l2_m2m_ctx_release() below has waited for
+	 * that run, and a cancelled timer would then fire on the freed
+	 * instance. The instance is never reused, so it is never re-enabled.
+	 */
+	disable_delayed_work_sync(&inst->unstall_work);
+
 	return wave5_vpu_release_device(filp, wave5_vpu_dec_close, "decoder");
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 2d515c9028a5..28df7f19c459 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -9,6 +9,7 @@
 #define VPUAPI_H_INCLUDED
 
 #include <linux/kfifo.h>
+#include <linux/workqueue.h>
 #include <linux/idr.h>
 #include <linux/genalloc.h>
 #include <media/v4l2-device.h>
-- 
2.43.0

