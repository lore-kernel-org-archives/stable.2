Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DE54A7F1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954601; cv=none; b=Q3PBAW4uzzeXy25dXkqL2Ult9XWgpuGAhS6ENz2mJkd55XGYvdIvTk0Nz2mqIwCvyKmCZ2RgrpnNyaSkLoV387RYBYv3sg86OIRHAdyDIJXldsAXX8bE3J/lafb/ey79/NCq2W+w+nzBVpSa40ff0q+x21gpFVKjCq6P+FK7aAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954601; c=relaxed/simple;
	bh=ZfbFN02LUYpFvFjicAIVjK7hT5hGL2Oih7l2Fw7pPm0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oiko5wy4qhQrzRgqegZ3i9sRFcZkAYAcRaDFK7OQRByV5aqgxcCAHwK287h/d5+LgwCJmuMz2qB5LASRNLSmS3K6JmkwR6fPYw9JrzuYMo5rdGYKbj7ZobOvsw5tGH03GrUf5L3Xihr+vV/h2nMQDjC3e8uHGXCWMZQmbG9izvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eJBD0e7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eJBD0e7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDED1F00A3A;
	Wed,  9 Sep 2026 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954600;
	bh=MbsJIKbadcsc2XQhwgtOFUlrklvWPE2MS53Ud/TNp4k=;
	h=Subject:To:Cc:From:Date;
	b=eJBD0e7cOaOg4lz57o8r76KZgaDA7d5ygUUtY5y7gpSSNBi+i446CdGV9lLPmJ0kX
	 ++90U7hC2IgKBkdiLSr85n/ZhEVyi0Bjrgk4BdcNpGQQ3ryqMOjuI+9cr76CZFaQJI
	 GKxJtqN2+HBN1hg7BmrnndbLf+uFFUFR4TZLYI0o=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs" failed to apply to 6.18-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:28 +0200
Message-ID: <2026090928-pellet-pranker-2a7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x aeaa7d2bb017272ab9e18759fe00bf758cd3299f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090928-pellet-pranker-2a7c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aeaa7d2bb017272ab9e18759fe00bf758cd3299f Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:24 -0700
Subject: [PATCH] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs

Whitelist or de-whitelist OA registers by setting or resetting the 'deny'
bit in OA nonpriv registers and writing new register values to HW.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-7-ashutosh.dixit@intel.com

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 76ac23644a4d..7186998df498 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -229,6 +229,21 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
+__maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
+{
+	struct xe_reg_sr_entry *entry;
+	unsigned long reg;
+
+	xa_for_each(&hwe->oa_sr.xa, reg, entry) {
+		if (whitelist)
+			entry->set_bits &= ~RING_FORCE_TO_NONPRIV_DENY;
+		else
+			entry->set_bits |= RING_FORCE_TO_NONPRIV_DENY;
+	}
+
+	xe_reg_sr_apply_mmio(&hwe->oa_sr, hwe->gt);
+}
+
 /**
  * xe_reg_whitelist_print_entry - print one whitelist entry
  * @p: DRM printer

