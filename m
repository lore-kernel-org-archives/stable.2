Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1262341057
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673977; cv=none; b=kbzUsQOI+VQPzaM9Y2OU2OxGkl9jex/vjQzaSHXkqkC6vvteVtS7UO3GkRUAogClKjg4kJhOZip57BjcTYsCKuEXL47EHKDmu0wnD8oUJnHBffDya6ZbFAacfOfzC0fY6IjOUgOgUWcbr+CakhH8aiTUbNPv1eANL63wHKYMPbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673977; c=relaxed/simple;
	bh=dE6mRWx2T0gb0Lonp1XJbF84cgeLN2z625cxUjDsFVA=;
	h=To:Message-Id:Content-Type:Cc:Subject:Mime-Version:From:Date; b=Sze4Z7RwVzr5ucQtOMy3wUjRyYRkz5BrTcXV0MFy+VFvbq2fo1ywY6ku0xVBrm2EGEnmSBzV6X0uSBEAjFtXjsj3I/HjnvatgtLR9UCcz8SSPFripnVmbAo4+Lxx6cyPFyILWynZjXL5b95kNi9LgCFb89xx5NmV4WaTPy+7feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E1oYkDyb; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E1oYkDyb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1790673843; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=X9o+2/Ax/kfeSEtGR9Uwqu9diBOxx2zKNjv4SBV/Gd8=;
 b=E1oYkDybpLVnvEzMWTvWvsGgzxqddB5O0GU4ulGx3M0dEFP8mrs47G+lqL+IbISl3rSbLq
 q1oXCzGBmBVLaYSBSbpvqBa8antym6Er5nDYb8SdO5Az7070YY9lKb1sg5l2bGyKagLRec
 huSSa0aBjIRfyHVccfqf13+L4JPGavxq/NO6rikibygSwh1e+0A/apOyuNSRy6x/Se7UHs
 Hyg+wBKXA1hkRNFIW2eVPGy7MWuB/3B8yiLLj4u1qqv2Gi+Tm4Mn5Aq4WqdCfd+jIwLl0v
 FTuFraqAX3kiFes41Tid+ta2iy/uH8/l3nmSyxgmGHQwJH0S5Nh7NWoZnK8l/g==
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26abb83b2+142286+vger.kernel.org+weiguixiong@bytedance.com>
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.50.1
To: <weiguixiong@bytedance.com>
Message-Id: <20260929092342.91295-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <stable@vger.kernel.org>, "Yijia Wang" <wangyijia.yeah@bytedance.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Continue restoring limits on resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Date: Tue, 29 Sep 2026 17:23:43 +0800

The PM notifier iterates over every uncore frequency instance to restore
user-configured MSR_UNCORE_RATIO_LIMIT values after resume. Entries that
have never been configured legitimately have stored_uncore_data set to
zero.

The refactoring that split common and enumeration code changed the
iteration from active control CPUs to all allocated instances. It also
changed the skip for an invalid or unconfigured entry from continue to
return, causing that entry to terminate the entire restore operation.

On a multi-package or multi-die system, configuring only a later instance
therefore leaves its limit unrestored after suspend, hibernation, or
restore if an earlier entry is invalid or unconfigured.

Use continue to skip only the current entry and restore all remaining
configured instances.

Fixes: dbce412a7733 ("platform/x86/intel-uncore-freq: Split common and enumeration part")
Cc: stable@vger.kernel.org
Tested-by: Yijia Wang <wangyijia.yeah@bytedance.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 667f2c8b9594a..c44e7e38cae25 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -211,7 +211,7 @@ static int uncore_pm_notify(struct notifier_block *nb, unsigned long mode,
 			struct uncore_data *data = &uncore_instances[i];
 
 			if (!data || !data->valid || !data->stored_uncore_data)
-				return 0;
+				continue;
 
 			wrmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT,
 				      data->stored_uncore_data);
-- 
2.50.1 (Apple Git-155)
