Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012014.outbound.protection.outlook.com [52.103.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560F38837E;
	Mon,  1 Jun 2026 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300659; cv=fail; b=JR26z4Cqs02MOyyjbFqeKj96h3/Ts68TA254+vnDbnrmQrXfensd3AgnhUjbtZwuJTdunCuP4b3w0NlEjkOw4SIxHyZKI9/b0WuVIUT0SXvbY2QFLPY9Gx3bGlSpYqpj/I2u0vdvIncx2mSpWVVCI93C7Vy3h5/Yh5VXKfrpdpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300659; c=relaxed/simple;
	bh=EoiYdNm7KUqR1DlYqdtTOrNtiW/Jb03P4Tq/uHFopeQ=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=kJ6qjZ4rhOAuvSYftRvZI5zVW1z5tx1IcBRCKJa2AuGUyfZEoc8nJimCUDonptRhf9bud0KFid4ZOusDU1RK7KNLr5YMhpOhiRN1K/p/FUOOQYCh4FnEk/biTYoboy7os+zq5fKo4JsrXfGNMY0Bu8EFHpj55Y8fRUQ9Bd7KECE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ONcHWwxJ; arc=fail smtp.client-ip=52.103.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ONcHWwxJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXGBkNqlK2QA6v4NuepYMVsmx8r1WZrkjsC0j0Mhmn2QQBCp+K4Zv0QRJ8PHViSh2bDBqrdkUr6/3Jd+XCpszifTy5zrrU2zlnsek8RH9Kx6W6FxzJPyLTf75sHzvJRRIqLU8uRTY1TiVRZSh3Z16f4TsbBpmsnW6/9Db1ch5bsivWTzTNH2DkraU8OJJve6VCHVDghKsAqma/V0O1iag6zv5/v7bJ2lUEfSh6SkLmwSXA+IU0QeJrukK3OMB9wf/ULYamI8wc3l1kbEJHWaXasQ6JRe2Q6Q6sLDofN9v6SJPUKKOdd2iiC8919FwZZJG3wRmZzBO9Fi/VNCoJAc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W2nDXjUN7ZIi1CKTHdTAygF9q41lXDJ9g8eFDDsuxk=;
 b=iqSne3B+NxKgxyAJ9cbIPhrZxuOX8O+zhPwjoMbUI7i0P9Imyx0AaT8JjXDHcxRYkjNZ92IdaphX0Ci/kbxusHAAPYCcB06S/B3fxhdy31bo72j0+AB9dcgxczbxOrpkajlsvIk9qJvk09f6WBI2o7NOTmDcvFqCHwSZuS3lpqMkxnDEwUXlBm69/oeTpvu3KAIay7FGUF/ZDe5As12z60tmnNEnX5y+N44ldxjS9IA54V8zumQzUmCEbZGoUQdHk2fKkT/O3H3Pn36VtUAoghB58zCzyYw2+QqvN2bC5GoKFEU6IHD9mTobJ29ISDKgje13SrEms46gGvG/WEXGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W2nDXjUN7ZIi1CKTHdTAygF9q41lXDJ9g8eFDDsuxk=;
 b=ONcHWwxJflPRqVsSenuc/Y9QNNDnE4RfYzqn7A1JsMob37oit5Cub0+K4BQ+ll7rcq41dkQSQa1sFXlr6Gnx72gPtCWtOhks4XvQJ7QXptRsDzgeBFR1Ko7dU0YKeZzi2hN++RzFyUjbdqZAtf/CJxZgFnAuMfUTV7qjksHcKhLyn5zg2eZi0bfAla3wSgSNQeystcipKDH69Id+4EFmNxZgQrfW7U2LtnnadvRrBLuI05DBrApsqjYTTSj4HtyjFW7nVDiZH7ZXmb1poIrEc6eieltqa++nONnWrGD9VE0sHgyhNltJDtEaryCM2n+hsjFpXBZa+fO4AqzWKNxP/Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY9PR01MB10160.ausprd01.prod.outlook.com (2603:10c6:10:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 07:57:33 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 07:57:33 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 01 Jun 2026 15:50:00 +0800
Subject: [PATCH] powerpc/spufs: fix out-of-bounds access in
 spufs_mem_mmap_access()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881EE775E8B51C09F5A29E7AF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAKc5HWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwND3bTMitRi3VRzY0PLRIMkk5QkIyWg2oKiVLAEUGl0bG0tAPiNp7l
 XAAAA
X-Change-ID: 20260601-fixes-e7319a0b4db2
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=EoiYdNm7KUqR1DlYqdtTOrNtiW/Jb03P4Tq/uHFopeQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLFnL5Zs9q9ZOSTy4rfPS+j0VebzvL9jvULTPrv3d/
 6BJ5m/NrecdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMJEaD4b/eRtnhBa12J36
 H/80/0+gxiqrZ//dHv2bFiH7LJy7XrG2m5Hhw+8dfcvyX3BqR/P5fjzFvUCruVjV7giT/55jO6X
 PKP5gBAAWk045
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
 To SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260601-fixes-v1-1-3ad7347d75b4@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY9PR01MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e8d88b-99a6-49c9-aa5c-08debfb36fa9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5072599009|22091999003|24121999003|51005399006|8060799015|23021999003|15080799012|19110799012|5062599005|6090799003|41001999006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rks0Y1B3eGt3VDhVMHZxQTZzT2sweC93dEV4TkR2N3h6SEgzMno4cllYbUNB?=
 =?utf-8?B?dDFSTXZmM09GcWNXMXlBdzdCNU8weXVrTGNDd1Bxbnl6blNjbnh2dTQwSGRr?=
 =?utf-8?B?YUNDbks4bFJWNVBrWU9GVVdlRXdHVlhHdk8xOGZMTFBhUUZGTVpaQmVYclhL?=
 =?utf-8?B?bStFNW9aNGFkaGtJbC9HYnpua2pLY0plcFZKaTdBSFUxMjRka2ZhWGJkZitL?=
 =?utf-8?B?emg3a1M5SVI0NUFvOXhiSHVQRFF4VWhnQldPaWFNWHpkTE5jbUE2UzhrRy9D?=
 =?utf-8?B?RHR0N1M3L3dJaTBUdlhobDM5ZmZLVCs2c3gzbUpKd2VLdXhONGtBemhmdnpN?=
 =?utf-8?B?azNkZU1vOFJXQXNyZjZyOHFGeGJPTCtpWFJBTVhVcU13bGpkSVFMZGE0Q2NN?=
 =?utf-8?B?VkIwZGt4TGhkOXBTNmdoOERFdWEyREswTHdJVUhmZUVGUVZmMjlTV1BQc1l2?=
 =?utf-8?B?L1hrRlRnNzJkc1J1NzZJeGdGQXprTUJTcFBXRUlGNkNBbWdEaVlRcUxsS0Ev?=
 =?utf-8?B?ZUx4OHZnOTRubXpZZTNyekV0SjJwcnVFK05peWV4WGxhcEhteHdEZXlxVFZ1?=
 =?utf-8?B?cDRFa3JpVTE1VnZGUWRQMU1qeURVQW1xa1VhdmtFd054RXFxZlErTG5OdkRX?=
 =?utf-8?B?Q2NTWGkvYmdKb2t5SXRsS3oyMk01Y2x4YnY3MnorbXU0Umppb1Y3bWhLQkRs?=
 =?utf-8?B?Z0tLRUxOOFJMN1hER2o4NHNCaDlhcml6UEVrVDI4YW1wdW1DclNsSTUyQjBI?=
 =?utf-8?B?VndjVUEybTRrVlFuVUV1OXprbkh2NDhVQXVvTjZ4VVVqS1d3clk1d05ZM0kv?=
 =?utf-8?B?Q3IrMGxwNHpyQXoyTkoyazJJT09BK0dVeVZ4amt2MDMyUmErUFVmVmkxYWFF?=
 =?utf-8?B?a2NtNFFpcGZoRS8rSHlrQThHQ0F1TlJJczFaVlpjOWNHdjR6UzZDUkJqOWJ3?=
 =?utf-8?B?M25lbnc0VGRKZE11QzF6bElQbjE5V1dMenRYR0RoeEV4a2FwYU93d012UElQ?=
 =?utf-8?B?eXNNdkdsR3NyVzBOMkx6aFQva1RyeWYySENIYS94Q2tVdDczaFR6c1IzVTVM?=
 =?utf-8?B?Y01MeFNsQ2ZYY21RYktzM3M0YXExbkJoU0tIZFR3MkQ1Z1RoenhyRzJ2M3Nx?=
 =?utf-8?B?d1dITnNQcmU5UjJtbWoyQW9qVnVkdzJzbS9JZm13U2d6ZS80eGpSYVdHK2JP?=
 =?utf-8?B?MEpDSTZpaUtpalBIOTlETXhOcnJHVlFLMFFLVXBCSlBXUytvZlRpZ0UzdWl3?=
 =?utf-8?B?VU9lb1I3aVQ0MUNFOVR5V0w5WXMvcVJNQzNpa04xYkRrL3RJR3d0SmRWNjlR?=
 =?utf-8?B?eW9BVDRFYTdsU3JkSVJvUUNzM2RDcVgwKzlaVU85MEdmU01wS2ZBSHJZQ1B6?=
 =?utf-8?B?eEd1S0NDVFdiZm9nNmloNkdiTnR5cXdsbEc3UHFSc0lDUkVBK2loYS9DSkw1?=
 =?utf-8?B?dWRvYktnQ21mNk5Sa1huRTNGd0hDMDFWbjFQWXA0Zy9YRThpNGRaYkUraEQ2?=
 =?utf-8?B?QVlQVUJZd3g5NXltdnppNk55dVpkMTMrNmFGVENoWFVVWG5BN1pkVXdnZm1D?=
 =?utf-8?B?RWloQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NndZRTh4Wkt5akNKQmtFdXNTY3FwT2dNOVQ4UWlVYXM4bVpGZEhObkZnRXdi?=
 =?utf-8?B?M05pOFV4T0RHWHhRaUJ6TGdiUERxWEdxdmdnN00rRk5aelFGRGdISmd3U1ly?=
 =?utf-8?B?Nk1mQUoxZ1VIS1Y2KzFoU2R1L0sxZXFWRHMrNlNJUzlrcnJrcDVVcXp3bWk1?=
 =?utf-8?B?M0FFc3puWTZXZ1FWU0xMSUNYOXRHQTJFSGIrcHZSSzBsZGplN2J0elRjZ1Rz?=
 =?utf-8?B?a2JzRHNobkxKM2VKR3lVODhjVEFCdVRtVnJZRmlCTzdWTU9hWDFzY0FUZVJz?=
 =?utf-8?B?VGJGbjZma3N2WTJwaUZLbEtRMSs1VlpKZ1JIVzNLc29IcVd3UTMrNWdjckRa?=
 =?utf-8?B?ZnZnbmJWOWpLakFJaEEweFpDVzZUQ3piV29kTW9JbmdpK2hjQlpFcWFTdU9M?=
 =?utf-8?B?RkxmNkhvQTBIdFR1dDFGMkJONXRhczVNR0dJekRpZkZMQWZIZHZXMnVpZjR0?=
 =?utf-8?B?dmtzM095Z21MWUZzZW41LzNvRnBjUEtYY2hRVUlYV2VrZFJMcXVqcS9Vd1Vw?=
 =?utf-8?B?cHhkdVRPQmVRWVhIc1cvek1mT1d5RU9SQXNhSTJjZkVuVkplSjJxejJMQjIw?=
 =?utf-8?B?NDdOUlZPRmE3Q1ZwV29TTlFQM3ZOWXdBL2wzTFQydytkY0daMi9UcHo4UWVZ?=
 =?utf-8?B?TFh6Q2Q5OVdGTElKK1d1Y29Ld0VJZ3pxV2lMUkM4S1R4RkdsM0dmWUpqQkh5?=
 =?utf-8?B?OXRyeEJhQjBDMElDeFhoR2JMbHpkZDBJNm1oUXpXdlplcVdOdFY3OTNVbXZk?=
 =?utf-8?B?N1Y1aWRhOVNuVTFSZEM0dkdxbHBoZXBXS25zQjhydkRwRWZvUXZ6NmRCQXJl?=
 =?utf-8?B?UkFHRUhHdktNS1J5UUYwSDNZRm5lZiszQ1RQbzhwZGxBc0t1dHF1ZWlnQlNE?=
 =?utf-8?B?cGJpWFZxZ0dIc2IzZVF6OTR4RUp1Mml5dlQ3TkZScFNvejBqeHNsdGZ3V0tJ?=
 =?utf-8?B?ZUp3NmhlZmhjRUFCN0NISEoxNmgxRGFBUG8rRy9ab09JUCtGNFdURnRnTW5k?=
 =?utf-8?B?a1lCd3dGY0hMVnFSQWpDMjQrbjEwNmVHanRrcGMvdEFGNnI4RzIyaG41dkZT?=
 =?utf-8?B?OWhjd3RHcTdrQXVhV2FsbXM4U2ZBTXo3UHFnOTNHT3RLUlVOQnNCaXcyRXdu?=
 =?utf-8?B?TzVQUDNxWGVrYXUwTEMxcTZIM1VZeHppNTJvT3N0K2JYTlI2TGlmOCtwWk42?=
 =?utf-8?B?MktsK2x1ZWpTdmw5YlJCa0Z6NFRZYWZnYkd2eTNTWkdDWnRvVkVVeHRZM091?=
 =?utf-8?B?THVUWUNwLzNmQWtiRllLa01DNmEzZHBrVUx1NFN4ZVhTbVlpUzRsbUFQMTJa?=
 =?utf-8?B?QUU4RUozQ3l6aU5SZ0tmKzNPK0hDVUNUZDJBV3hTNzlqZ2RmZUYzUTdPVmRr?=
 =?utf-8?B?NEhJdm1RR3NQWDRDNlpMWEwwOWp2eUc3L2JBbVN0dENFSFRxbFBjR09DYUt0?=
 =?utf-8?B?S0wvTUZCTkUzZWNXOXA2Sk5yREU1YlYrOW1EOU44R01ZbW1PSnpNQWZWRldI?=
 =?utf-8?B?TkE0WWhJU3ZYRUlDU016R0NXWlJiY3pjWHVVQ29XQytqbXFsNjd3YWY2eE81?=
 =?utf-8?B?WHQwd25PNUgvWERvSDBIalNBK3pMREJjUlBFZzFYdmcvemVaaXJDSjNUQUVz?=
 =?utf-8?B?ZWVSOHc3SkN5cCsvTkZBTHRKTzFYSmhMeUt2aVNCK1g5b2Y1SFJadThwaXFu?=
 =?utf-8?B?eE5ydlgyTlM4OTNLdVJLVExoVjVJQXQvZEpyVXRCMUVFY1ZLQVphcHBsaUFE?=
 =?utf-8?B?NnhyV0VJeXBZWTRGOFU1b2Y2eHBsdVhGZ05jSmtlK2JYVFNROGtZUTAxSGhG?=
 =?utf-8?B?d1NUWHFTTENHWkJxaXV1R2Q4cEdudU1UVFFZbHVXWnFsNkJnNHJoZ2t0ZUZN?=
 =?utf-8?B?azZUWm5pUzQ2bVN1YkRKK0V4RFBTU0VEMUI3ZG4yYUZHSHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e8d88b-99a6-49c9-aa5c-08debfb36fa9
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 07:57:32.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB10160

spufs_mem_mmap_access() computes the local store offset as
address - vma->vm_start, but bounds-checks it against vma->vm_end
instead of the local store size. On 64-bit, offset is always well
below vma->vm_end, so the clamp never fires and len stays unbounded
against the LS_SIZE buffer returned by ctx->ops->get_ls().

Reject offsets at or beyond LS_SIZE and clamp len to the remaining
space, mirroring the guard already used by spufs_mem_mmap_fault() and
spufs_ps_fault().

Fixes: a352894d0705 ("spufs: use new vm_ops->access to allow local state access from gdb")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 10fa9b844fcc..94c1ffa8792e 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -268,10 +268,12 @@ static int spufs_mem_mmap_access(struct vm_area_struct *vma,
 
 	if (write && !(vma->vm_flags & VM_WRITE))
 		return -EACCES;
+	if (offset >= LS_SIZE)
+		return -EFAULT;
 	if (spu_acquire(ctx))
 		return -EINTR;
-	if ((offset + len) > vma->vm_end)
-		len = vma->vm_end - offset;
+	if ((offset + len) > LS_SIZE)
+		len = LS_SIZE - offset;
 	local_store = ctx->ops->get_ls(ctx);
 	if (write)
 		memcpy_toio(local_store + offset, buf, len);

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260601-fixes-e7319a0b4db2

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

