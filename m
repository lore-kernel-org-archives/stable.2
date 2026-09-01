Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6737F315;
	Tue,  1 Sep 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254402; cv=fail; b=q3XDq40KzUPOKghDJgUHoLUonEfE4zpytOVV5+TcHTozINYaVMRWcJaerctBiihwjU6HZajmqQtDaxs4EYmIgbqDJaxjCtyxIBAHNNmYyR86Hy0WImHOBCebWEQj3YIAxWwXaxrGAWaLf0H1KasQ4Z+PZXRZ9Yb9xAtFyUjXeAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254402; c=relaxed/simple;
	bh=hNuO82ZwxpLj611Rz72wRi/PkEBU3FkhHPOMl4huRuc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aVvzuDbuB322WdPP1VAVNOb4nEKy/7oPgAOEBhnBuX06Z2dzdtAG/WuCeEQph0asuhXiGIH5QsecTbNjjZuYpSpxjMlp943Pg2QUmEMVyViDe0YOfQGPTxdHqg3X/rRWcYyloEX+ujUGBNtVWmu8Zl9yXM/jlTQo1AhRH6AOzlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sRmFmMHr; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sRmFmMHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6M3WmJFiz+VoMCZiChff9gOlLgCic9u8MOmX2yVP0Ybe/iAgbADvXEu/GogyBgWAauGmW2HG4Q9q+IJBXfAoxZoDXYTVhf9+08jX/tduxQoCyuB3a1J4KoJejdSFfaiYurgI0Grl3M7RKrtghYZp5Yf41BmMP7lI1hXOm1/tFQVTubxTDfBxVHGIeWSpedNHCb1Oi4Ea3A8nrYAiPI4xpOXF46mPpW4OmUD995bfIYCvCSs+guXSHUb1gh6Sut1g7jd1oY5Aik2XWDwacM3GhEUW4DluoMUbDZ59pyDAqrR/cVh/UcW9PiCRDTgNW4863MCGDNix7IqSH8dKw3Z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0KbYwektKee8UeOVsvHKt2RWqocXfJSHo2zxflHtPU=;
 b=jT/Yf6B65CcGYD/0Uvtd2BPknB6QgANfE0Gb5jGG8LuuycBP1/M7qRQYmfpb0ILuek+LjcbGCitXM4yeyEBElg9njoygmZbRzQTn58lJJOQ2aw5lsnCEpepJvv2dujfRZLAyyePZOf5wfoHYQOAI9Syr2Sh66lZ0bRaQ/adQXWahQ3K3j9bLCWmVT/z6kGuMg6lKNpkn6n3q1k9OdUP6AoIpZNdthwJ8qO4MMs7jrAyL0Ft3Z0Uz7soP0YVZzwcxvDavH/gB5yKI6WcQ5kXjVe78jkHOrWBqLejgOrH/sTHGSdThiCtgtPhBEa4fyWOf+ieAiUMn32PWKeO5gtOhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0KbYwektKee8UeOVsvHKt2RWqocXfJSHo2zxflHtPU=;
 b=sRmFmMHrjJ9HQ3GxfP8bRjc7UzwdIkDcNMlcBRJc6Qp4zfOBNlN17YvepjlAwp/9Jfzi289kRdRglZLgED8onl1vS1TupsKCKDmQQ+9RSp9QPAYmGbhiZ67cYU5gIybghtuUyhD9XVEXCpblB4WQcmsmXMBxLiKauuW1JuLaw0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:19:57 +0000
Received: from LV3PR12MB9409.namprd12.prod.outlook.com
 ([fe80::f1ab:939b:242:d9ae]) by LV3PR12MB9409.namprd12.prod.outlook.com
 ([fe80::f1ab:939b:242:d9ae%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:19:57 +0000
From: Ke Chen <Ke.Chen@amd.com>
To: dri-devel@lists.freedesktop.org
Cc: Ke Chen <Ke.Chen@amd.com>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/gem-atomic-helper: Fix fence reference leaks in prepare_fb
Date: Tue,  1 Sep 2026 17:19:30 +0800
Message-Id: <20260901091930.2796079-1-Ke.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5c::19) To LV3PR12MB9409.namprd12.prod.outlook.com
 (2603:10b6:408:21d::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9409:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 865eb0ce-95f7-4525-a8d5-08df080a30f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	QWh/AqmqYoHuuo+1p2gcxXgbb6y6YIImI3l8tTvJJpltk2PAldXaEKSIgi72yXrdUo0uJp1LbHOn0raaxHU+YnCYamJf3GCqV0xwHVS7+VVUHQgk03NJbIcquFwxaUr8EONpwlUjUJsLMwg1YmXDorBgrkUyv2MSKxpr2AihWexH0Q/y+h+PJBK59xR282DAEVPExvjJs5HVTVf4ngg3Jb2m1+J4GfA8+427Ry6+PcMxJZMLkmSF/aHrpdH590fnk+kh1emNSkljd42hs0MMcTPjHBeoNnjDaFXrFnmsrBZafsjjn4GzKFhLHN/P3bAfH3OROZHfEcp9PnZfs2I05VYJDb/psHa/NxjB9cIALKUu3BliIDRz5n4RnK0zJet4/CW8GfqeiiGNLZA3ERY7sTniCGtQD3uVDsj2x+BgCRVnqJvtZjFn7/NZaGIteAXakmNc5BEp6lv4bea/coMuLoaoeqMUiDh7T23dcvEvqRV044DBkOVwS+WS9VoppdK1ZeXeYEPFbNiPg5vwKIAN55V1wcU6UpmfESFi/Y/2fgkEoEYPwn9vfNGLpGfjMbIAw9PL14nGI2krDY8Oxcypflv0DfIdCqS19pTqJCjuhqjG2PKo7CNdLZcoi2fZ4Pl1ql9g14lEBUi0I1cIEQXRxeqo05qj5enm+34GOtWWOKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9409.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7JnVzjdFV8YwrFXr8wjRufpSw968WCnQdu3C0mlQU/as5BW8biNUzOq3M/3b?=
 =?us-ascii?Q?AsY4qPgtGzNx0ZUJ+SCRMmnuv8uCHrbKbADzMGmxSgTwUcviv5wMMmOeYcUh?=
 =?us-ascii?Q?iM3r4ZjqEuomNhoCpn029fElyIGYvUema0CDrxOoh0Ha0a4jfkhdkit9YBJh?=
 =?us-ascii?Q?nfCyuMWjleT6pYrsLcu3ekf7joe9v3NIc9imSDR7I+0xTI0/N8ecwsOGm+OF?=
 =?us-ascii?Q?1u/ad3JaaMx9I/hKciDbg80Ib1z4j6U9zeVgO8EjI8sZ7JvOJd+eFYYOOIou?=
 =?us-ascii?Q?Lc7eSHWmpROGuI9/NfToSE2/8gzmTd700RiS/Wk/oSdFE2Lqpn5foweWhnER?=
 =?us-ascii?Q?G7CKVllDJiAJtC+M0w6RUqNtPygnYeeFCIHCJ1EbT2O6/BU73sAJeWJCljjU?=
 =?us-ascii?Q?r/4isx2U+hFp4dmU9usAzUHgoIIiFr55W8nbcRpj9GGk0J77lXJI6tNRHk3+?=
 =?us-ascii?Q?my4sU4wegOhlO2WBn+NQl5MrpOELwI1ifC00fcuJ+TOzwKvqDuODme6Mmzrg?=
 =?us-ascii?Q?7S5UarHuCnaqITgJ18GnZbQcXsnaabtXecZEPwj7+f/u+lODxaefTCGTmG8T?=
 =?us-ascii?Q?mMIe49/829KRnlcY47+38J/4lzO0Npf3TJEplamDqlrrGWl0+y1KMl5D1yb8?=
 =?us-ascii?Q?+a6jg71EOHQhP0c8oyvcMGOBxhLn1P6RnU8zXBy3aMI9M+cLvR5Vb/u+088k?=
 =?us-ascii?Q?1h+PYRqMs11JXhRoHvpBi3sf6lbjFLpmDRzlXiORN9qQI2aR9NkuSON602I2?=
 =?us-ascii?Q?5I2Fpms9lR6Xibh4FZbBpzP9F2+7QKa5tbwCVu12md+WVxK1BtSJBj9nTZI2?=
 =?us-ascii?Q?h223lmYzSodeRiBHC5bnJwLg9tbVv+ixj/MM3jMxWcJF4gHMzh8NfMfQnqZW?=
 =?us-ascii?Q?tEHcancRlpTzZD9007L9EnGQjpo/2fEhRycBzBd1i7URE7raTolDDjM1e/cX?=
 =?us-ascii?Q?STqCxsecmf/6AKD/53MTtiQEiJiy4Z0XbGwXfyOch4YZ5Hd3SkswNRKFnlm4?=
 =?us-ascii?Q?ucQg5vMOfm6EUcN42N3bCQqRCxPMf5gOLHCVMZFa+uld65vXHcAxeTT2BeGn?=
 =?us-ascii?Q?hNQtPUbWbZVKrEoVovnbwWXhU+YGGJRK07HdoHE7tuZflIHktpxsztGpFBRX?=
 =?us-ascii?Q?pPyNZNzX5NCs9EfQZ5yQOBwOCRBuxCu+95CZ2Lcb9VSogHWAEz+PasGQgop6?=
 =?us-ascii?Q?+k0dJHtmvccGCesmH9rxLtnmZmCzeAYcG65lnWyUh2TFF8crlGdyRyfk+kP3?=
 =?us-ascii?Q?12TGAYYOy5SNDjEUFup1A8q9fmWa2IY/rNgI6V2oRbE6aOT7LggxUCEFi1zs?=
 =?us-ascii?Q?+TIdSl9Bn2BvUsGzkdRt2wIeDv/AKzwPzCiNx5mimr0bMt2jaqXl7rZWrkGb?=
 =?us-ascii?Q?wucjQlyPLiuriiJCConLS/7PFfu2cyt7Uxf1uP+PmMxoGG9jffDfpSJL7YM9?=
 =?us-ascii?Q?2ZDFEFJRr55FhJ9krf9uTPNaH7k0Hny9zHUywISwumtQnARUogfMsY0s8YHA?=
 =?us-ascii?Q?4hwpihMUqr0jUy4tR33qKuqpZVo0oohdv1Tl9NVFO+IohW6TIEcehnxFMsc+?=
 =?us-ascii?Q?gdrYsHUsquAw0ZCpROQq9+3RAFRM6DoNzp+vVbhkiqeBmNipf3AjwDtyif4B?=
 =?us-ascii?Q?RxnOHplKxihjWigAtOmISYexzap/R0VYGQPXphNh7Ky5AmSTcjbeTLmz+5EB?=
 =?us-ascii?Q?g0pO6FR3xg98uTcR2+vqwPne6hKK8F/Rr7vdLpwNO0ssA+Fz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865eb0ce-95f7-4525-a8d5-08df080a30f8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:19:57.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+GMo85dXfCscZxG6bEjtHT7NqN6bHiXPbLfDrlNd88fp0kQpq5lbcXgZLR67HqMlLBGs9tpo+MeoujC+GMQoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195

An atomic commit can set IN_FENCE_FD while disabling a plane, leaving
the new plane state with a fence but no framebuffer. In this case,
drm_gem_plane_helper_prepare_fb() takes an extra reference to
state->fence before checking state->fb and returns without dropping it.
Repeated commits therefore leak one fence reference each and keep the
affected fence objects alive.

dma_resv_get_singleton() also returns a referenced fence through new.
If dma_fence_chain_alloc() fails, ownership of new has not been
transferred to a chain, while the common error path only drops fence.

Take the explicit fence reference after the framebuffer check and drop
new explicitly if allocating the fence chain fails.

Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper_prepare_fb v2")
Cc: stable@vger.kernel.org
Signed-off-by: Ke Chen <Ke.Chen@amd.com>
---
Tested with x86_64, arm64, and arm target-object builds using W=1.
Also checked the x86_64 target object with sparse C=1 and
CF=-D__CHECK_ENDIAN__. Runtime and allocation-failure fault-injection
testing were not performed.

 drivers/gpu/drm/drm_gem_atomic_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index abef865c5f2c9..4c0a23f4b2970 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -114,7 +114,7 @@
 int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
-	struct dma_fence *fence = dma_fence_get(state->fence);
+	struct dma_fence *fence;
 	enum dma_resv_usage usage;
 	size_t i;
 	int ret;
@@ -122,6 +122,8 @@ int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 	if (!state->fb)
 		return 0;
 
+	fence = dma_fence_get(state->fence);
+
 	/*
 	 * Only add the kernel fences here if there is already a fence set via
 	 * explicit fencing interfaces on the atomic ioctl.
@@ -154,6 +156,7 @@ int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 			struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
 			if (!chain) {
+				dma_fence_put(new);
 				ret = -ENOMEM;
 				goto error;
 			}

base-commit: 20839d02c0cf7437bc508d4c5430538d9dc4f428
-- 
2.34.1

