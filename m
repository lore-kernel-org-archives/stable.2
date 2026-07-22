Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020124.outbound.protection.outlook.com [52.101.84.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BF315785;
	Wed, 22 Jul 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725383; cv=fail; b=DkkXtcuuKB8DbQwXQLMtSkNxUIp2g5uCRRU2RCnOxK1V4QP3EE3pP7+Dn+bPIDogqftiXm9nPzZX2w4iVrLf9Drc/IlOjU9BXaVtSB0c1zqWxEL+xI6dmvmH7EMKr9bm857xw6IxV/DT4TvfNRVc0JDTQVFErhnzZsX0dHMEiQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725383; c=relaxed/simple;
	bh=YGhqM8kq89F5BeCGIrNC6WE/Xy9ZVMzxJhMwbECrM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSMcx0Mw03eoObAl0A7PYXggcRBAkTjLdEwEo7lSKvX8izCZT/RGZBhfItyxNKNG85dc74EcZduQcY/Zv09fpRgvx3kPXYtoFpL/HV/PXt4npY8wtbE3dB9IFWDj0wlVmcy9nf8LJ5l9sXq+Xr8SMTf28QQGzMr2whu2PAMtdKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=MjHwugKg; arc=fail smtp.client-ip=52.101.84.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="MjHwugKg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGXK1S2dPr65OsoCZYy/Vt+5LlmnAacNjdCsPGtaEpQiFHK9kzeG/ujlWag48AxXGrhxKlFMtXbNVD20swEjM0Skv+laEZfiyHTlU3JukkqB+vVKi+e4lcaZ6WvEp/IUq5FIExx/7wMZ9h0pt1d/psgaRrfwTU1FT7fEpyLFA7m/elhr5q0dVtQdqzBlJPMSd/i9k9m7itwNqhSqzLby+kF0QIS7FHFsQoKc9eOqLEXM/WNJ6mzoaRuokF3pohwIw+H4X+3+g2OyKs7Od9b9aUZorkN1cseFxo/nucIOXPM9dIde8LexmdbK/LnbxHpc+1KJ11gsOAQ/U+cnuaC2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4v9/IgDERqVqKcJXgAO44ONXqJsRcHAFHlsh97PBeQ=;
 b=FCmsjOnoWosg7E5vowGBl2y0C10eAfGxReMUw6zTVm7SLZNvT5hbQN5Iyw7Y47m+YO0Qlk18I/9c5ndjLS6J5C4wvMj6smgIfbGFbhSCHhAdHv88P4rsgz5Kurr5AvMGsO3ksryrX5p4d+xtobE7kZHh/b2vlpg8rtDcfAMlOb/8qBvUgV3yN5SyFn3+zZmomh604g5EmKQq8UoLzJlu5wcIIAiSetROdx8NyKjKtevUmFarxsM75AOaEDCzdfAIrCxMzTk6U37E/r+yfPy85/FVuLjKxjEXHCmqABgJSbPD59asDs8IZ5jxpM+po6+7pC0Y1g4yhkOAP/fxyK8JZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4v9/IgDERqVqKcJXgAO44ONXqJsRcHAFHlsh97PBeQ=;
 b=MjHwugKgM9kirAyUqKlPfQJxqM3xHxKDEKPyvu+6Zjhni8cNelgokG5V29zG49yLv3kjEiC6fVZPMx7u4bVi5qxi0om7bGKloC8tC67H76T1BZdnfP20AVe9IffbwORWzrNR9J9RV1Nm28S6WkBcnOVYY8Yhp9F8mV0/wHcFtf5Hg9ZkkfBGwghqDpzCvfCTZCvGCLyvHW6I23zd4K0ONfdr7eJNtkAAwoGBCjhTShm3WL0oNJRugU1MJp6E0OnYJKa4FzYciZERHUskIaQMDKnjim9AgCu4PjteVvNjrWr3U8TjWMMK+kPslCuKCXul+oLq67fhWB192n1YfCXDWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM7P192MB0787.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:17c::14)
 by GV1P192MB1739.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 13:02:56 +0000
Received: from AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 ([fe80::c1d1:f20d:9fb5:72d3]) by AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 ([fe80::c1d1:f20d:9fb5:72d3%7]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 13:02:56 +0000
From: Chris Gellermann <christian.gellermann@codasip.com>
To: christian.gellermann@codasip.com
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	david@kernel.org,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/mm: Fix potential wild pointer access of getline due to missing init
Date: Wed, 22 Jul 2026 15:02:46 +0200
Message-ID: <20260722130246.2135563-3-christian.gellermann@codasip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722130246.2135563-1-christian.gellermann@codasip.com>
References: <20260526113848.530105-1-christian.gellermann@codasip.com>
 <20260722130246.2135563-1-christian.gellermann@codasip.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0162.eurprd09.prod.outlook.com
 (2603:10a6:800:120::16) To AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:17c::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P192MB0787:EE_|GV1P192MB1739:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b01d4b8-7faa-4d09-fcf4-08dee7f18c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10070799003|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	NOZmYjcU7azAu41rpI0QBGPkCu15pHM4Zr40Jtujr+znHNsYkjVu+gf0oVI/GqOjX/NJBLIRxMLf+Lbn4SS4mCrRXSCu6f54bhegB5TuKVpeVohoVXWguivdRhPQj3iOFxGnRiofTpo+ORFE8+UwqaCex2PNtYFwhHwEd6fHQBCWeyc3xRGPw/C+ZqtB/oo9QHe79b6lIyykorS4DFImUb7ZDTskdRcOV/iNZyzVxaVaiLoHX+1uYTTbvfdVxQJBfVKvRZireQmiVVsDWNmu4Ren3I+7nm3VFz7/ZSUh76jqqHqrthL1Rb3+Wm/7f5mPHmF+U326zfcAk9eibI1U7ZpQNpzNnisMhOsqqNtOxbiMbe0I+XoDaTdU7htXQkRaWrJ6GUstX8mZNQPByzdunWiGtA6IDBvaHkjEvYq5MgziH4+AnqshwXPgt+2U+UcUuDdk1mTNXGHOB9EXhkquBs6xPS/7zFStFVQLCJlOVRj5x4yPvSkcPtVPMzQvlPxySRzRLCFDyKG67NQN+ZOC2JlcEltLLcYN/wau5MYscO3xv+G6IhoIz6q+/RoG1vlWMiWgkKP1lKGTVmxr436wbL0/6NppAwJcnF/xQcY7+9PQnnyTaGGTzpo8Yed2PsdcgijMMmcpRAAA3MjnRhsvb7+NHWY7yRRZdAZABjvGc6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P192MB0787.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10070799003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYe63CZ2KDhS6WZnWV+w2sAYiz/FRVc1UGvOQ/CBzYQWpCGSuWBarBSHej9o?=
 =?us-ascii?Q?3xWqUDl/TN5GlSMEsywhe2HtRRZFMbKjFndMoPfKiTQDQGy0t4u8ZSI8R8mO?=
 =?us-ascii?Q?n/JTC/XNnS3hcTzY09Paj5Qfc757ijz9kmQ113mMSDeaVPBY4knb97Mbul4v?=
 =?us-ascii?Q?WykCURnhKXaR6o8ATw5OZ3+gCqf/LYze+iPKp8R5T81VNLEt7PKdI7v+t7vo?=
 =?us-ascii?Q?oS/9Pojgq+Wx05mek4XrfG2HuZvm0/QAS7lUzSUhIn6DYgmNfngLg6T86HHD?=
 =?us-ascii?Q?5c7kVJuNh4XR6RwHQiK7fxXNuou9/nUkdeZuoiHqPr0YA88N83p5gBwQWjVi?=
 =?us-ascii?Q?90YhXA1/XZOvn5C9rVcmhYnR4Vl9CBNpzWcPpvdKqB0ev3V7FdpQanT1mu7T?=
 =?us-ascii?Q?2SjUZrb5zOsHrEiwy9FqWPTkaQlLjwOt13GNDQswGoTPHueiskbnLVdJzmIP?=
 =?us-ascii?Q?I27asAifwDovG+UCKBxwZv4Rp4cypVr37SZwulR9O0k5E+fZcfw1LeugNAjZ?=
 =?us-ascii?Q?5XuJmaYTjhVTm83tcJXs3z8JWHpH/Bfp3yQyTUcDS3eaIr+GYFW3G6IpLSr2?=
 =?us-ascii?Q?KJp5/iPMpyLCemCoZUZ7aJBqqwQgnBdRTUo8xchRv7w4uaPWy7rnlLtM2mB9?=
 =?us-ascii?Q?wvaOG4KO1I3CeRUGdwDuS1cG5U85Jp5Z2jwaT/1VTcHCJN6sF98Wi4oA2Lij?=
 =?us-ascii?Q?FAKl5z1l9OWvHGjImW+ab7aTZWxHwZDKrGTO0Nc7agyLO2mgES/+SoCKHEu/?=
 =?us-ascii?Q?VevypoLdlGkGGPQjqhDClXelZ2ZFcM+PDHkqjtTp5UfLnI6RKsodK4jCV818?=
 =?us-ascii?Q?V0h65P5MuqQuEAnW63pWgswnP5Ndbd+roUYbmmp0iU7rI6XK7DjvIy9hG3om?=
 =?us-ascii?Q?U+uoWkNUt18vN1ypW/kbk+zwDDYdO1+fkmwMY7hxKDv+XT2viGv4eAndXXCU?=
 =?us-ascii?Q?4z4UDtlbl1XEYNqPPUk4dpMRtq4E3bSaapCFu/HSAisjfxURFerhPpmVZWD0?=
 =?us-ascii?Q?u0yyHjiEPGbco8ZfP73a61R9IlZRh2Ogd445flT9LTgC1T9+yI+I/Lfknge2?=
 =?us-ascii?Q?K4nQm5S8kunvcvPXBrEGJEVnNCTn+LpGFImug7sc25jtV51uVnHxn+7p+nRD?=
 =?us-ascii?Q?GvT8cwmV87Al/djEjiJ80jMxW597HEiWLRsuGa3gjML3ASbMOv3yOexDThgJ?=
 =?us-ascii?Q?Vp2R0aLTJHdEQ7tgqm5ELkKf5RIc6qNTDZ0lEK+BwdkYUG7rml55JiVeSA2T?=
 =?us-ascii?Q?hEEferW7H04BI7SYkxrQtQN1gU/j+O1Lj1qQ/1mx3hOC9YiKUb76JEcRegk2?=
 =?us-ascii?Q?A/lFsyjEnSWyOeVVR7GX19j9uRtzkQd1J38SAtgR2j3zuzHW+v9tPPJVivnD?=
 =?us-ascii?Q?EOguhewAGHRkiPZmNSBq52nxPL3GJ0kVpUoNDSQWZ6Ziq2DfPxO6afkpUQxj?=
 =?us-ascii?Q?G1L+527dmZ1z8UCg70/OTBe23bnabzLHmKk/P1JXKiH1PFR4MNJDaDI2uDoU?=
 =?us-ascii?Q?bySGPpGEBw8SFEfFMLMmNppkNoUpajxE5WWWFdDETyNyTtwwt9XSL2sTAqlM?=
 =?us-ascii?Q?StekVvKQpF58z15rwDERJB9cV3qmP4VJffLCA9hpOZxUUqVV7eCoFdNO1glr?=
 =?us-ascii?Q?cmU3ZZGNuwyHzzQ//ZeS98kxTmc0whvuxf1QbxFRwnsnq0QF2bB0Dfkpqvz3?=
 =?us-ascii?Q?DNRn5LzKQs3ORkj5FNDIdrxDt+5OjCzIRuYXcY2hyR4RVEGDL4cmwdJmfDY7?=
 =?us-ascii?Q?ndlzH9A8Qs7LvaBnCDEQssdGz7diTNaqIiEswD47nZm73ivmhzquX9FcR+Up?=
X-MS-Exchange-AntiSpam-MessageData-1: kRm01DhlNjmATTtqvWveCrqn7kwNijVAIEI=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b01d4b8-7faa-4d09-fcf4-08dee7f18c70
X-MS-Exchange-CrossTenant-AuthSource: AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:02:56.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3i2JvjXOdVeBoil/ntHkx8YqO2Wv2feBwz5XR+y81PW9HQXxSKXA3T4tqSj+xmJESTltCVFmLWXwiIigK6VgSf4YfyBAoeRiTKyQRZcdZ/wHSErzndW33tTaihFPFdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1739

This is another occurrence of using getline where the code assumes that
getline allocates memory to store the line, but the pointer passed to
it is uninitialized and potentially a non-null pointer. This
violates the Open Group Spec[1] and caused a segfault in a similar
situation in selftest/clone3/clone3_set_tid. Fix it by initializing the
line pointer to NULL.

The issue has been found by simply grepping through the selftest code
after running into the issue in clone3_set_tid. Whether it segfaults in
its current state is unknown to me. But it's good to be addressed due to
defensive reasons.

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/getline.html

Fixes: 26b4224d9961 ("selftests: expanding more mlock selftest")
Cc: stable@vger.kernel.org
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Chris Gellermann <christian.gellermann@codasip.com>
---
 tools/testing/selftests/mm/mlock-random-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index 9d349c151360..16294bc7dae6 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -84,7 +84,7 @@ int get_proc_locked_vm_size(void)
 int get_proc_page_size(unsigned long addr)
 {
 	FILE *smaps;
-	char *line;
+	char *line = NULL;
 	unsigned long mmupage_size = 0;
 	size_t size;
 
-- 
2.47.3

