Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202158;
	b=yN85ArGbPuGvPBPW1EeOPUND2zeuWCzFpMRYF2T//g441B46A21MSjrqn+iLDBDGyKbd
	 TjLtp9sJMbGPC8g3sNlSV1pCKnaL6wmr4mIqpTD38tpQSRPngrdLepz5ToA5U+9hN0tVY
	 tuSP5aF2Rfx2p50avJK1JbpqRiJIkJuxu+qq1jQNz3j5bd801qGI5pDPGecJu1UAvhHM9
	 5BADittIMTbT8666hpgEQThRaJOKqVjPg/ufl6zkJdCKoXlhglXCOXtC3rNONcoAwpCXJ
	 m7pe/MmGLPz/0kq5I30vkBWFfm7j4Z5LZJrHtY0ENhlowEbQnAfzRqHLWO7iWTgKoPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202158;
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
	bh=TU4OpGS6fA0aRPaKWXHoHN+S6Kzluj06Mtlwao00iQw=;
	b=48dva7CSBbSz7gCnDoMwDsC5BAjgVVPFVEIPNhtcOFD/OBwrIXEuhcAZzIOz2J0vfd96
	 9VL0/WONQSlSnXEsdBJkKDyegpUFruWB0QGsQebDn/SRnSyuYOTxsFOmmY68CWDKJB5Lx
	 /pWKMJnDY/c3jEYIhy7vqk3phogBYpRgGNAglfBvle5aLDO3+fkOxP7NRfA3I9gVC9ap3
	 LJjkgF6eFViUhiQc6sNE0GWTBLE+4hAbXxYiX82OpbeMPUVMUs2LjAHEL1c40jpDEtFNa
	 x6XTvTgoqoFywBwuYkDzKvjOgETYQEdCyHvtOBkIutjXSbkeZQSPXNuVK2S71hEV8Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b="W53Iid/W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D42606D822;
	Mon,  9 Nov 2026 05:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D42606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=W53Iid/W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pV08GYI3hwgh3jAn+VxA1ke+5kaSB/lO+ZvBptjw9MK3YINGqYv3HCKZGroebK1ksPQMrFd1PrO0SBjgmSPreICXyvqEK85aQ0w5iOerElWVBkUEPSuHwTSwcJGam8NnbyQYkgDzhQGSd5ors/y5J6a7NzIYng+VhPVoGRtWbSwuvpyeWoHR4+btiy/E35ynTIEkUflIxRQCTVWbf2n9xY7W5LMhC6gxpOB6RvGThGP27kW0wQOcwxp+XwzS3aA5brm543teXA8ZWf3ESCD8TUbsj0jsAfyxeSk7vlyj83wIpJEjaWAFgazLqXfMHBm61T3vZl3DMqwehkHJ768gPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU4OpGS6fA0aRPaKWXHoHN+S6Kzluj06Mtlwao00iQw=;
 b=XQEdWjOULOql/vWD7aa36QsEXsv6+o8YJldAqTvc5NPK+VfKpIHE7hcCVzP3eMaDl4SIXW1b3Cy2ndDj1gRTHrzmp3d/KMxqLPfKJbOw2Hir/R9rtpV0wWqI5L8j3O7dh2vtLsxVga4nw9beyhFVpw0jjvnMkT1ZD4yNkG+SIATb+TQJ4MH/ObNJ61MX88vwe/glkeP4+sjcYZZK86SBcThOKJopHnW6u91d1Zr7rHE7SQWjMDOScYH2/8HOTvrmOcB+kuWmLkFiuhrkP+UvvDECNelKttzbT5eXyn2FjwMOgRg3n7jdMpbZXgPcyLybIY7EAaXUoFEaqFyzFZiuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU4OpGS6fA0aRPaKWXHoHN+S6Kzluj06Mtlwao00iQw=;
 b=W53Iid/WTfTxOGXCL4TqLu63dprt4OOT+3iaXoGwjMx2Qcp2QAHHGA/WotgHn8KLi+NhqM3nlWjcKbwBG68+s3VP80L9uxqtzF19Zv1bd15vFcOX8C9xsQ/ZOI1QaenTRasviw5icriC4h9OCYYzI3Cj1Hnlt1YC6u6WnkZLNz+8I7JTLA4aEc7Zt8PgxjaA+TLGKloLVDu1K4BKEvFUa2jg53M+LvilOWWh/kemnkeg5QaR7WvUyveA2FXxPuV+qSQsJkiSdayqljC+3wv3WwVzJ16e0qCq+mQ4GBzSVRdB00zklDRFRmGlO9H9H49XnCONncVHhBBMIjLlkcIOkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PUVP216MB596218.KORP216.PROD.OUTLOOK.COM (2603:1096:301:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:29:07 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 05:29:07 +0000
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
Subject: [PATCH v2 9/9] media: chips-media: wave5: Stop FrameBuf Reset During Seek
Date: Mon,  9 Nov 2026 14:28:53 +0900
Message-Id: <20261109052853.110-10-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 00f3d1c2-9937-4ed1-1caa-08df3e226005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|56012099006|261021135927099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Q4vQc4l6meEC+Nciu1IlmROvs427xayVN2aO/MSDf1QJmFpbHT5ZzSSAm9quOcex2lNsVzJs6G7bmhRvauop9ztLyzDZn1wMZ6MI7r6i1+4K+8KxJhTv+TVYEn8hjpgNxjhqDLY2MBz1iqqRs9R57mKC1Oz6q6uN30fw2yt1Df6SYxoxHY/+8ihgnaJA2HvN8khoIV1xH1ujXlPVq1y36H4gL2y5gXKIG39idg2gJq4IEXLuYGY3DLfKsQU/m6mgGl074ITIPQgHGh50izAEBz1IJXkSXJbIt09/t/kurd/JdZV1+q5Pqv5i9eyo1Vl03r1pfjN8zw0EXNKA0DwdECCTidAqXxNQCOH4wbG3uUfH9NiVeS9CVTeKB93hSRt+8l15P+bqO9BqO+0jEAW9wzsxnOIBhKNiduBKjJJF5ejkk9NUvJVnOI9UxIGcdmgzY+Asrf+jI86kLH78fs45yaxR6KiZ58wYI2iJoaO8KBJdc89rCxrXWxQewodiTpFSBnu80WVOCaK4G0mKwWMTWHMpGkGlLCPmM8jhWoW332C/4u1NZdj2H0TRS+LjH1gMfapPnSWpxqmfIv88vIVJL+1+/vrsEzNYyMV8LglEww67AoFBsXoRoDQ6Wb4oRQfk/77UrV6sxRtvBnwo6kvQVe0tYCzMWAiTbnkh3ie2Z/U0iDrGvZcj1OTe2dmGQOmN/7LCk8tEWTWDBsPDM4BjoJLtp99ImTeeLzBT/qBZUsA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(56012099006)(261021135927099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnGKk9Dsn/SIWrpqpgC3ecQfzLs+vJyQpfuEp/fW5+Dmh8F5/sdVbGFdXSRo?=
 =?us-ascii?Q?/4RngWck3Fzfa7Yq84hDG68aI/ejNA8ogMAEudmMnLkRe7EpzORa2oHKvkpG?=
 =?us-ascii?Q?8AzfKy/TYK/TeY51JeUnMPMEisY8YNx/3g10FnoaejKGDF38WAOMKPktadFx?=
 =?us-ascii?Q?EcwQZKpEmdvGmPd6IHUv89pqAM/5n3vNtaOK8JRzgVcBjeq+YME/j2aE1qcr?=
 =?us-ascii?Q?/DPZfF7A41ANMugocYmBTjFz+U+xTi5sYiP0gm3Y4/gRSLM6cC8WD5NQ1gzn?=
 =?us-ascii?Q?k2K8y/aAadhi57rpSvpFBG3jFDHeS/RWOxQ5fZ23ELpSYvE5VY9IrafXpunk?=
 =?us-ascii?Q?mwklWBjal6+6PaQzNjmw+4EjuEn4+nZdlESGy/BzS7sHYUOFrBEiKBtZkHEq?=
 =?us-ascii?Q?CHGf8KUP20CdSDZTp/MCfOD2buw4hEfUmdvim6IP8sWLlEZkN4mfycwPlOel?=
 =?us-ascii?Q?oL09P8OsHqdzMtjgN/2WCgvCcAzvuwItdnBES/7UvSev2hMn/Hh5I5/wOf4W?=
 =?us-ascii?Q?zDKN3V43w9iD96LryWvDSUoSDY8nxAXblq1W2WhBwqDeE4potMm35Ue5riKf?=
 =?us-ascii?Q?JQYE5MlaSeUcOlFVr8DmEG5m4I/c36q+VIrr+MR1v7DoEQKx8PAsY0O8vY2s?=
 =?us-ascii?Q?xfXmxcDi1XkApgYG3q1OU1CU+JWagIMYJvJATQhkeiT+oek0QneNyK6WoFZ3?=
 =?us-ascii?Q?n4yHASZIDV8iNphfv7HFxlBHjLeC+aQMDPHVJyt/Gbx7J9w+t1Gkc3Ahe51t?=
 =?us-ascii?Q?FpcyIqODkTJOkkRz4VkcJckivVXm25tfSLMu+yhmiySu5rnJYsPXgqdecSpQ?=
 =?us-ascii?Q?qzlO0GyCD/m9BNxQ63AemrKDs4BjnjFaz/7OnEhatXQVlTPfGxTJ5ThvUvJ7?=
 =?us-ascii?Q?4kRn6vJemA2Y1BqeFkAdjXtDQBD12W+TlJCqAKKTnxic80Ee2t52cZmJRfEH?=
 =?us-ascii?Q?lqthteDSlNen6MoKVnQhogOC+kfGxg3RZJ9oHL2lWg5eKzIjqiFFHCT4QpoD?=
 =?us-ascii?Q?1kJ+flAcQxIRMWvsoZxNHyQDpfNtmVjwFSfUGNwrVE1eHWcqAgILYo5VQH55?=
 =?us-ascii?Q?I1MUL5buj0Yh4boAsoSe5pB2e3H14JsM+JgIj5eH1Iwm6r1Eu0CAdR4lfZyB?=
 =?us-ascii?Q?zm7R4px2ADE81z2Ufmq7oBMRyaFVQ+Wfbcka+Yz0UNrt43vTcqmfG5WV62zQ?=
 =?us-ascii?Q?AyTpeiuNEAQLl7p4b2nQETB5PgTupZnZvJJG0+IVeDcZvysZy698Gf7vFiAs?=
 =?us-ascii?Q?ylD4NZzrMgCdhPo4AGb3v0ihm/Z8NHZ3a+rG0LGPyB7VfFyyTUZl5YkxoOX5?=
 =?us-ascii?Q?2sRor3Uv9kZPSrdEyn9KM5eGEZiavTiehV+H7W1oQxFiCOAUzeHRdFvWT3d6?=
 =?us-ascii?Q?7qZUHs6Fi4Hse6m9wq3uBNOa2vTNRUBO4VaX2VRuPa3Z386rm72eRGB7e0Pg?=
 =?us-ascii?Q?a2kHb4ne2j4ABXXaV7hCdsSJzzqXreCDch9RnVJx4cVmHTvtKUKDBVijXK1L?=
 =?us-ascii?Q?Ao8THWoYRITWTAD0/rM7+pu5Oxdje+HFWLZn1n92wWG4fcy3cOmgF/2E/QLC?=
 =?us-ascii?Q?WKYz/TLIc1iQnya9IRGIs4Q/LS/HrMQmK+8ThQXp8eSA5KuNv3F4O17qz2/V?=
 =?us-ascii?Q?+MkjqhtZCty1xHhJsLKBYN9trxzm7TSKZLgzNdDFCPuQ/RoR+rZZ5QEh9trS?=
 =?us-ascii?Q?hnbFgnFT8/z3w2DQBQAJcnm2kC/AI3EGx7CK8z+3dPi0sTzXB+HVCIudRPcT?=
 =?us-ascii?Q?7JuFt33clO0tq+CGc89V5Dw9pA5CYLU=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f3d1c2-9937-4ed1-1caa-08df3e226005
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:07.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vbhmhx669ljs7u2JiyOvA7CUKERKCQ33aW1WcEyEM0UFpWXzI2ywic9uVvBRVqRY+Gp6a7bNLqpn5IcntOhkqI3qIT9FI1c/PJcEw5r5IOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

From: Brandon Brnich <b-brnich@ti.com>

A seek drains the capture queue via stop_streaming without stopping the
m2m_ctx. streamoff_capture checks needs_reallocation which will always
be true after the first sequence initialization. This will trigger a
DEC_RESET_FRAMEBUF_INFO which will go through and deallocate all of the
frame and auxiliary buffers.

Video output can have corruption if the firmware is still referencing the
buffers that just got reset. Clear needs_reallocation in wave5_prepare_fb
once the new buffers are registered.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 102c07979d08..57511acbb28b 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1250,6 +1250,8 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 		return ret;
 	}
 
+	inst->needs_reallocation = false;
+
 	/*
 	 * Mark all frame buffers as out of display, to avoid using them before
 	 * the application have them queued.
-- 
2.43.0

