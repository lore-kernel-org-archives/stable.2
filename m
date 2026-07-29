Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E5448CFD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323129; cv=none; b=Dl+EW3H8d7e2nXS002/NdxeP6ORw5mRSZUr4PVy4HfdbbxDGpv7SXvGJTJ/T0icLPLdFTDPdr7KzILiNEAyQgw7eU7wAP3nBlvP4N0Q310ckYl6XayVCgDdjJlD5prz3Tkc4HTPUN2w6/PfzGg9HU/c5G5JE/XXPp77aPjn3PKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323129; c=relaxed/simple;
	bh=PXgDVFbuNWwNn7mZ0fFsQwmSlU2LePKBjH0PnU0qST4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MUFKLjSkwT1NGNN8EkZWeLpKQuzLtNVwyrNMkrf0WwkUKiI/KYDmQe7hV/iwzPWl27pzIL+enjJFKYGI6JMnmp75tZdZtFvSZ00ZY8oFS82nsNfsM6I+q9R7H6hr+MFALRnYocQh+yrCabCuj0NcPweLNPppFS9hxiCS69pr58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=razldKyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="razldKyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851E11F000E9;
	Wed, 29 Jul 2026 11:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323128;
	bh=Ihz/HDd1thasHGAiWrNPgU9pEi3AzSaTtVPjqYqKmzU=;
	h=Subject:To:Cc:From:Date;
	b=razldKyCkbISxLDigaDXhPfsJI8Y83+pZEAQH97YP8Zit3/UbD42DdzkEUcTRJdzs
	 tZraqGjL3+MRbGqQspujGAhVeH7xhqK5RzRb37yhWeH6Mgn6b1zlLeH9moT6cfgFNQ
	 s8xu8X8tZzSFj8MLviAhQnZzRFHcIeRlGIXN5Kpw=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:05:04 +0200
Message-ID: <2026072904-petal-dividers-511b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ebba7ce65252a4ab0e3794ff14854df2afca5c08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072904-petal-dividers-511b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebba7ce65252a4ab0e3794ff14854df2afca5c08 Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:25 -0700
Subject: [PATCH] drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a
 gt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Whitelist or de-whitelist OA registers for all hwe's on the gt on which the
OA stream is opened. This simplifies the case where an oa unit has 0
attached hwe's (but which monitors OA events on the associated GT).

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-8-ashutosh.dixit@intel.com
(cherry picked from commit 6f73bf8fffa728aa5d5ee143ba318fa0744113a2)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 7186998df498..b2e7aabd19d7 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -229,7 +229,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
-__maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
+static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
 {
 	struct xe_reg_sr_entry *entry;
 	unsigned long reg;
@@ -244,6 +244,36 @@ __maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool wh
 	xe_reg_sr_apply_mmio(&hwe->oa_sr, hwe->gt);
 }
 
+/**
+ * xe_reg_whitelist_oa_regs - whitelist oa registers for gt
+ * @gt: gt to whitelist oa registers for
+ *
+ * Whitelist OA registers by resetting RING_FORCE_TO_NONPRIV_DENY
+ */
+void xe_reg_whitelist_oa_regs(struct xe_gt *gt)
+{
+	struct xe_hw_engine *hwe;
+	enum xe_hw_engine_id id;
+
+	for_each_hw_engine(hwe, gt, id)
+		__whitelist_oa_regs(hwe, true);
+}
+
+/**
+ * xe_reg_dewhitelist_oa_regs - dewhitelist oa registers for gt
+ * @gt: gt to dewhitelist oa registers for
+ *
+ * Dewhitelist OA registers by setting RING_FORCE_TO_NONPRIV_DENY
+ */
+void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt)
+{
+	struct xe_hw_engine *hwe;
+	enum xe_hw_engine_id id;
+
+	for_each_hw_engine(hwe, gt, id)
+		__whitelist_oa_regs(hwe, false);
+}
+
 /**
  * xe_reg_whitelist_print_entry - print one whitelist entry
  * @p: DRM printer
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.h b/drivers/gpu/drm/xe/xe_reg_whitelist.h
index 3b64b42fe96e..e1eb1b7d5480 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.h
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.h
@@ -9,12 +9,16 @@
 #include <linux/types.h>
 
 struct drm_printer;
+struct xe_gt;
 struct xe_hw_engine;
 struct xe_reg_sr;
 struct xe_reg_sr_entry;
 
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe);
 
+void xe_reg_whitelist_oa_regs(struct xe_gt *gt);
+void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt);
+
 void xe_reg_whitelist_print_entry(struct drm_printer *p, unsigned int indent,
 				  u32 reg, struct xe_reg_sr_entry *entry);
 

