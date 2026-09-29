Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A71379C39
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699523; cv=none; b=F7jcMJUs8qcm90axyNK5A5xM9M7WUdJjvvfwON62dCGoMdKrgF+UT3fna9EAdX0H+SKnXBJOWF6g0PoSIXS5qu0V+v4+ELWwkqzg7vzBzbd6wEqRBiqT8ONBWAHtO8U1gNCVIrKU/WYu67f2sLICyd0uROK/+5dX8g07OnqW96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699523; c=relaxed/simple;
	bh=dE6mRWx2T0gb0Lonp1XJbF84cgeLN2z625cxUjDsFVA=;
	h=Cc:To:Subject:Date:From:Message-Id:Mime-Version:Content-Type; b=HpSl6WGGKd0lRi1vuEOfxk/JjWElrQOcnGuqPvkj2a2v2kqAT4kkZ6iv4dylY0w0aHACf4Ds9AMq+P8ZGqm5SVQLvHTm5L/EcFvpUz1TyH1mZfzvHUFDuTmwJkAPHrL7xj515cYk+X7F7RdnQHA4ftPRyhpr1wZwT3KDsR6aPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fJgvkVJi; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fJgvkVJi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1790699516; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=X9o+2/Ax/kfeSEtGR9Uwqu9diBOxx2zKNjv4SBV/Gd8=;
 b=fJgvkVJiPoutQveVcB9nrXKBDdH5Njo7xj3qkCB6m8TL7JO39lTMCYISy1Xsfq6lzMPxXv
 NlSNvpsnXTBk9fNTep0HhCLyB6Hsog52PwTIHtOVdnkhCSveywwkb9yGsVC+QqTWS7bHDm
 0TF6JoCHO1dCVYhKWasPYStmyrh98dg9bwOzPNk01ahtanNToxtjyocbEswNKLJOd/4/kF
 1YUozvCFT4Knqn/Q1lJKhBDIxAtnJ+fmvro41rM9qfApKyRolC/BFLwW4aNfIRzKAJySMz
 UI+0kQO0zEBc1BTONO+tjGWS7p5e+OT39cbuPAthgysu7UYuxwgQ5oXeYE/maA==
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>, 
	<rafael.j.wysocki@intel.com>, <platform-driver-x86@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <wangyijia.yeah@bytedance.com>, 
	"Guixiong Wei" <weiguixiong@bytedance.com>, <stable@vger.kernel.org>
X-Mailer: git-send-email 2.50.1
To: <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Continue restoring limits on resume
Date: Wed, 30 Sep 2026 00:31:34 +0800
X-Lms-Return-Path: <lba+26abbe7fa+f5574e+vger.kernel.org+weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Message-Id: <20260929163133.14326-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
