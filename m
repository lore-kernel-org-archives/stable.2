Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021107.outbound.protection.outlook.com [40.107.42.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E83546C4;
	Wed,  7 Oct 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338409; cv=fail; b=VSsaSJ6s6A8Xtr0QGJ+LICjajSiTtD2Ub1aXBwZHxC7NkVLO2sy/w9ziTMQmRKn6Khvmp6gqenVWLvl99e0TtvO6m22lRiuhgoV4xRecB7AA1tV8xniSDXhVQQhA0dyT2vDBt+i11yeotQjmrXXrPrtRwMiqOoI9/SlRw03icSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338409; c=relaxed/simple;
	bh=8p33NhFAsGV+pKyby7uLv4EiSKClZ+hKpeV9j7ZW1u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YR2pRwr7mtLa3t26/5xBnf6NTxiAtAzIILlXpmbCf8TkeZY8JLXOr4BQG2KV81ShQgPoL3DvGAE4nRN+ijZrdnFhT2QM1/oSCnNXMdkwkvrB8xd4v0PjvbSUkWO3oMLyN3gMyQHPSj4vAi8rZWMs0/b0cErm6FGfGLoZU5dE7Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=L4lgDNP7; arc=fail smtp.client-ip=40.107.42.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="L4lgDNP7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYkIoR1cGNFvOqilUm3N1tvNVkKPQKsjOJUrZVkm72b4KrmDahpJvLspf7sx3ISZn4FVpjHQM6i3nSFQ4uRhbslCLiA8CZ9SnP3F3WEoywa0Ox4UPLQ+gsThfBXDCkLa18PyZYIpw1eZ4VMQVQY1I1hdvhKF+DWG28SM8okkQTmBCgUg9tFxRlGqV9V6862WDEBHsOdMj6YyjbqF/pQHIDiCbnXqWVo6/okVosflWGaKJdQUqD9Wf/ZNtFd8YHJXcJ7BfVyejoWPIuBUUE3Q7AfnquQYAAhq6GA5sxcZGvng4q1vDCBW0yzATUU2PjJywBgsu94MwufjvAG6OT8yrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuAQEWzre25kqcDUoD5P/wM0sqqFJ/zZQhizMGmE3VE=;
 b=iYEr9sH+Yn01B+eTXagFC3blJJIY4fOTjTnYSIatFAXCQrY+BlepU5DLeq5sfNSX37SiOy91r4p3wcA20CZpfHTvT77rLSiYPwJYXGeqjt+lZdv7oaIA43sJ5KnzAfiWVhIIBWdo/SFJcaIhNl2A6XMwP8jnEyKeVo33StIBseC8xUmSeZ8dzav7gc/8XvwONIi7mq9rAJ6PKzA5NxRVQe0H10HsDFmm8yLKKgQ3PAvbLteOxPKVx7R1NQsKOlvC/wPYn7QpFuVG3j09pn2MFXBJe3JnG2kSDYP5VSIjrurIo7hj5r7OM0xyIzmr9dnlhPFhPS2KHKTR3bkfoT25Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuAQEWzre25kqcDUoD5P/wM0sqqFJ/zZQhizMGmE3VE=;
 b=L4lgDNP7dIL92cTplkEgfXkCX8f6beqeaOCt0bj/1dPdKKrB7R5GerwdKW9estAG9gpifcsBOyCqcVWxF/To8J3BPAymuf5UCyaV9UhDTMrzZ5QUWJFEfDk7I3Qqd3B8H7Dk0sm4iQa3KAyUNg+tqyY7SzxDAX1ISu6tXIG41pHsDiHmh9f3j1xeWrGKUZFJy+sKz+MmRRfNLWCoDQCr0qDIS3f+H9dIENjjTlItzkivd/0ZK2Zlsd5wPzUVeeao6AwSx4trl7c+g2DHCEPZzDA2h7gYENY8/0FjByepsJV3+G5f3hN30VWY1Dc55Sr0SbQnUkIvcaBpL7qnSZglyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:59:59 +0000
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f]) by PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 01:59:59 +0000
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
Subject: [PATCH v1 3/9] media: chips-media: wave5: wait before retrying a refused flush
Date: Wed,  7 Oct 2026 10:59:40 +0900
Message-Id: <20261007015946.53-4-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007015946.53-1-jackson.lee@chipsnmedia.com>
References: <20261007015946.53-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0127.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::6)
 To PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PU4P216MB1149:EE_|SE5P216MB118462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b12bab6-661d-456b-efc6-08df2416b167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	WcHrm0v9l7FDL6wulkpyP+ARBUCSJaj5ZCgHVtWqP6nKAWRF3v/v6+bWTJtbZwTHMv19ZU84+u716U8s3sR5DPv4P4ua1QPlU8BXUeVoo+d5Ga0cXWXqn4SDlmcLy5lBmH2PMmQKuVcnKd77tUSXR0PuwXgiLkdouDDPwFk+rOKVm9mSPbxZvqD3XDq0w2nuQY0EJtII9d8bctWQDk1BC1LHmh5F1QrgfGBYOXQUj/LYKNqYVe39U4oJkz/by66xxXSToRA/z/pWWb3AgFZ9/zaLE5gv3rUnxi4eKQLwPH7vWDKI6hyehv0WAXpW5IPt7jMr/UXvsUqTHd6FDnFAIpzZVPHBV/vzOLsKK0L2EvIO2FVUuSRjiwp6zgkrpM4i8Tod5brF7TvpG25UNWEvo/HBAAhVSSEuD4+7QwGROxi2hMPwQutq7AumV2YpJyCj70ith4/YOfL8A38dGVRCvcBGBsE2v2LafAa457CM9+lsshm0JKjyYXOUBQ0TBmK7josXh8+A8TbA2551qCDuuswX/OlKhgSHSkjaKfbGVewPXgzY9wdIcj0IU00XtzmKxSS8EJN3RRCDsqCgkoHOQ0ln0M9MZE4OkqOxyuYt6IFyjpn73ZYUo69wwjYmYuCeso5HJlTMUsPtpf/OczjM4SabloGKUhIKH8yZbZKoqucSgsN2Ki9aK+jxx9jjm0CxqprZk9XHWpsN+PEi/PBLVlJZmKm8MBEAP7jAYXQThiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+KzM+y3hADfV81Iha1fBEFj5wAPlYLc801q7MQAL+y3dOAD+RUjXP5xDaYL?=
 =?us-ascii?Q?/gZv7E4Hc1TUKp4xWeZSeVeH2971tnrdPofTh25Bx1g6o2Jr9M/4yMHikXAs?=
 =?us-ascii?Q?H2pJ1OE5TV808YSal6D+DHiq9AaMJ5zkRSdm6lOvhTo0LxV1VS+870ZNOoN1?=
 =?us-ascii?Q?Gwuh4AUzDB2mRZfL7h201Q5xgzdcPw3tS7SyNwHFNEFRjMdeGby8kykLj7Qj?=
 =?us-ascii?Q?c3mZFCXjvmdbCZf/RJlv9OHuBiHGp8oqm0zX7i1HLfijzCA/PrbqOo+8wKbz?=
 =?us-ascii?Q?BnwKXsK8ojsQs3Ew5I/53WtZjU9yKop91u1b92NJSaAbR29enzt/59IBZXvx?=
 =?us-ascii?Q?Dne8mz9hJyX0cuMiWcQWfJ0Zt3MNC6MvLwd/qR+LdVJeovD/hEKBbv1anszi?=
 =?us-ascii?Q?qo8cm9QHGb7DYJxIfGorKkeK8a9+vKQ4dN3xAPJDx3Inkr+vxJY5KKzJBO3G?=
 =?us-ascii?Q?p6xjmTJOZikGKsxU0aW8QXAh8kgQB6ydDm3fcF6Qti6/OpqInQF5ZK/TYiYT?=
 =?us-ascii?Q?+pmbHtYlzA+NfqaBzgVe5e98hWrvjTqQl9ceN8Tvy7iIWFoEC6VmxiEdyAyx?=
 =?us-ascii?Q?dQIVdffvZcaxwOP/2mBbTtofTI7oZ1mvu9EnRdUIFOwS+2uqlyj2khrEtFcr?=
 =?us-ascii?Q?WJirLmKGR4wI8G1TZxpfbqUET+2FZGislVIRztgA6BBjLqxNhMA8j1z+WGuw?=
 =?us-ascii?Q?2cjFHo0SUrwcX8q1DS76jjDXBeZM8XT9ehJ2Hti9WUcrFGkIoloawtV5NxzJ?=
 =?us-ascii?Q?OdzDRV5PH62SDNFcSaMQu0pjmQo4ItIJEt39LR3kscpXCgKbC1DLuIAXzDAc?=
 =?us-ascii?Q?nOR8+ME7HVrps5kPO1plx+Kc3vZOrNDZQNGYUgg+tcfwJYwfIbZEjow47DuT?=
 =?us-ascii?Q?eqcMskOw9+14rqvqkK47Lx4srPWrEofmAj/Tf1j+/nmy5Rq/HY/3P9erdMz/?=
 =?us-ascii?Q?xcw54mbIDdXKW1hBKyN3hEwvTj1YCaIs6AqOG7S8B0/5X9To3CLB6fL0blBw?=
 =?us-ascii?Q?Ql+vi0cyA063g6c975hAx1NQPziJifyeyHKsLwOvvOTyXEZD9kNOFovlIn3v?=
 =?us-ascii?Q?Dws7sqpLzJpBP1Ut46Ve4EhaB+ITim9bbNsFk8b1ToGHRVpHf+dArvrIu6En?=
 =?us-ascii?Q?CJEma6pLs0iIfe4eS1l9UGp8DuxytW1rQSmSCqk9LJ6IjJpwTmQFsK8Ii3PG?=
 =?us-ascii?Q?C652cs+fkeUmfgu98e+kBJDx7DbrmjGgXXuyRTWPka8fXLYro78Zhe3lpzdL?=
 =?us-ascii?Q?eHXPYH4KhaOnhPcnRrriq+/wzf+Zgk+xXeurUkZ0uVu1EM57J2gRYiaQQyCd?=
 =?us-ascii?Q?7f5BW+PY4QtYnjmDD910GGqiVxRdteegTbJoSpgx2zBZj9akfb/sNSfDxTwk?=
 =?us-ascii?Q?5tDGqUMmPNDvXVd7kQ9VHPcoOyusX0+wbnqNDIMEeRwMKkBX6VyInlD7VlwM?=
 =?us-ascii?Q?EEKKPonttT/+Ivc1UwkrA379Ps/Vz0XJTs701ZANY9ZyN5rAcWbo0qGh5p5X?=
 =?us-ascii?Q?jaDSsF8MDN9/7vMdllS74ewE1vF5O5uldZG108l5b0Y7m43j51fIZmqGrZ9h?=
 =?us-ascii?Q?exjDqejIi0VepHAq2N13CkX4PLP6YxrnD0IvXsYXcnyeb0smKQbk4Z2ZmPox?=
 =?us-ascii?Q?IUxUbClslv1Elymu1JI4AG3J+qCZcKcv14a/fvvnr3rVLE/zRzp+Wu6ffFFH?=
 =?us-ascii?Q?pVLOMgi8VyFBhFpXlfuxRcdi9Z4Z+WjazgReCZQlhLUsoq74+yoD722Ao7BZ?=
 =?us-ascii?Q?xivHStlxOvNgejFe3q/0t/0dmFB0uFQ=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b12bab6-661d-456b-efc6-08df2416b167
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 01:59:59.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNvUP1LNYSag+o2L1eV8gMRVNKCGtiS9vSTX90NUHNhqSo3GQ/CMc/xsb+sHE2D6F29FSooBqCFFLOCgDUQvOcl9N9tNRZqPEg3Z8PcE4eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Jackson Lee <jackson.lee@chipsnmedia.com>

wave5_vpu_flush_instance() repeats FLUSH until it is accepted but never
waits between attempts, so the whole retry budget is spent in a few hundred
microseconds - far less than a large frame takes to decode. A flush issued
while a picture is in flight is refused every time and gives up:

  Flush of DECODER instance with id: 0 timed out!

streamoff_output() then returns -ETIMEDOUT without resetting the ring
buffer and the instance never decodes again.

Sleep 1-2 ms between attempts, and only use dec_info when the call that
filled it succeeded: otherwise index_frame_display would set a display flag
on an arbitrary frame buffer. With a flushing seek every 500 ms the decoder
stopped after 519 frames before this change and ran past 2072 with it.

Fixes: 45d1a2b93277 ("media: chips-media: wave5: Add vpuapi layer")
Fixes: a2c75e964e51 ("media: chips-media: wave5: Fix a hang after seeking")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-vpuapi.c  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index f77abd5e122a..397da200a9ed 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -78,13 +78,27 @@ int wave5_vpu_flush_instance(struct vpu_instance *inst)
 			return -ETIMEDOUT;
 		} else if (ret == -EBUSY) {
 			struct dec_output_info dec_info;
+			int info_ret;
 
 			mutex_unlock(&inst->dev->hw_lock);
-			wave5_vpu_dec_get_output_info(inst, &dec_info);
+			info_ret = wave5_vpu_dec_get_output_info(inst, &dec_info);
+			if (info_ret) {
+				/*
+				 * A flush is refused while a picture is still
+				 * being decoded, and there is no result to
+				 * collect yet either. Retrying straight away
+				 * spends the whole retry budget in microseconds,
+				 * far less than a large frame takes to decode, so
+				 * the flush times out and streamoff_output() bails
+				 * out before resetting the ring buffer. Give the
+				 * decode time to land instead.
+				 */
+				usleep_range(1000, 2000);
+			}
 			mutex_ret = mutex_lock_interruptible(&inst->dev->hw_lock);
 			if (mutex_ret)
 				return mutex_ret;
-			if (dec_info.index_frame_display >= 0) {
+			if (!info_ret && dec_info.index_frame_display >= 0) {
 				mutex_unlock(&inst->dev->hw_lock);
 				wave5_vpu_dec_set_disp_flag(inst, dec_info.index_frame_display);
 				mutex_ret = mutex_lock_interruptible(&inst->dev->hw_lock);
-- 
2.43.0

