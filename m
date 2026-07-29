Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48629AB1A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323126; cv=none; b=U0/4xEloUKRegUTvnDg1Uw9bcNxm/DDoc0WAVuTWvvDC/gjqGdtl3+/z4r80x4yG36eFRSb0j5/Z05jWW84bFaLE9q/wlBVyzv6FWHsPcMoO2P4X7Cgqga3q4w68/86quaR1cOtSMCXY/FtFNjzCjkD7viYqndBQdGP+5DhcPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323126; c=relaxed/simple;
	bh=QRXtQbnyd00qDzacFhn6wRRvOP8oyOg6KtiYaxZWzYo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c8W9yK0iCmfOLBKEdjxPKCjdjFOK+kY+RtLm8AJvPh6pVwbgvhq5ZhQuUadSrSsCsRQd7aoQV9jWIpyLHyQMGZzHDwK6PilzPtEUEzziK3nBpl55RHJcrLaxTMOgxkSqK0FmLPw8wQgN/Uj9gTSv7ZwVDv0GGouuzPNa/SmW0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/6i4CK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/6i4CK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA141F000E9;
	Wed, 29 Jul 2026 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323125;
	bh=TMTxi9F5HSu11u9zP/TJURjioZ/gY6I7Phx6C51Kt8k=;
	h=Subject:To:Cc:From:Date;
	b=c/6i4CK++MeXCQYxHar/mv3owBYNoy8xwbnixm37fxfgzwgJN1RjmdO3jloXZYZ+F
	 Iunyc1ja3Ufw3Atx53O/fHgivZO/TDSyfIWBj0nOtKjOvAr74yNieOjCgb/gYXWNq4
	 3kAucP8ABsDv2dwwypV7Z/UIT82hIG6HCCOw44e4=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a" failed to apply to 6.18-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:05:03 +0200
Message-ID: <2026072903-unshaken-prism-8b04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ebba7ce65252a4ab0e3794ff14854df2afca5c08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072903-unshaken-prism-8b04@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

