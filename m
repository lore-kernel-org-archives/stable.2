Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72194570CE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323263; cv=none; b=TD/F6ke4g0acAcmuE3UwUXfMosCtqCOU6QlBkr+pe01Z0fwpY2vxBReOfDI/Wr9hKGSpengbu39CYK9iGstT9B616fefzSwSuAhcxIrFNplUdwdZJFSusZeHNDRF2hAFf0bWdPmhphJQ6kaZ1UqIvI5YDdKEdE9iT5JOjAYLArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323263; c=relaxed/simple;
	bh=l9du2O/nHcLAB77M8qNv1Z+AEdYbAKfAFDK8W6V3WhU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oD7sZetfEwHnPaHMGGNx2E4DBYFKEexD+l7jHSIOZWcpTyllj2IWBr8UvR6naFtufTRQvh2zml2Nx2YA/ZX3oxyTIxavxtEYuyKBZiUfooNok8LUkJR0UaTNFBQqRUgXLcY+siDkRuukMo5MlNE7cw9QPal8ZGRY8HYxQwR564Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ZeL6hOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ZeL6hOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C9F1F000E9;
	Wed, 29 Jul 2026 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323262;
	bh=KulkNr5lVXrp1N2mf72qvB1eMvjs9ZrpccpnH/WtDmg=;
	h=Subject:To:Cc:From:Date;
	b=2ZeL6hOiav60K3ZHKgDq9+YNaeTV1jSCUk3PhyrqVsgX83Eyf9yeSbJfKphtgq36O
	 o6ypV7hGi6IvonlPapnZy2YEHPvp1zeF8mNG8cNUWReejDlirgX/0VZtdGiuFjwFBq
	 guLXWKJA1AF9V5JhVd160VxxTnMo77fUL1U5zkjM=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:07:21 +0200
Message-ID: <2026072921-devalue-judo-1a54@gregkh>
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
git cherry-pick -x b422babd77fac2c96b92db484050e460899bddaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072921-devalue-judo-1a54@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b422babd77fac2c96b92db484050e460899bddaf Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:24 -0700
Subject: [PATCH] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Whitelist or de-whitelist OA registers by setting or resetting the 'deny'
bit in OA nonpriv registers and writing new register values to HW.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-7-ashutosh.dixit@intel.com
(cherry picked from commit aeaa7d2bb017272ab9e18759fe00bf758cd3299f)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

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

