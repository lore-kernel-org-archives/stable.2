Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57070456E00
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323255; cv=none; b=OX89s1ru4ZUoy6zxC8Pfkk1DCt2cS9Tv+bZxYt7xQPzcst0ebESWiHjuxcNUnj11p0x6vm5xjmo9nVr+Nz5MwmKTwNnGrAyH11gbWBgy3IUH6z1s1CQmRs/RmFy32lk5C/2Z7cTt36y/OT/iNOf2h3DlCQNHGnGHIcxfoa6OWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323255; c=relaxed/simple;
	bh=3pZCYElr6Cu06rj+OXdz5Um7yaD21EFGcyin0xByOJQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GdVUZjO0+WWBlCJBo7tSk4pE0T+r51iWyHsDsuvuIfdu+6dECuvNUyr3KpXanUo8pfW1y/5A1lSsM0sBpTsXadPax7XyOwlk+AT5WuePUDOUcO+O2cEHARkcc3yFFxLINnHROAzJNCqNKeBi1vnq4kX2weQ16FKjLfBE0DLtP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxqxXTYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxqxXTYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B486E1F000E9;
	Wed, 29 Jul 2026 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323254;
	bh=JqZTeMBBNisQ4Gu3cgBDEVbFzSeM0J+X9OwplVWtUgU=;
	h=Subject:To:Cc:From:Date;
	b=rxqxXTYwPXtOZqKybPevPCMu2lHPEjbY467o5dzBk8s0j9fFPAhWhumQXSRdiGgAg
	 GZW8Qd1fXHBiH1m/63f7Na+nin4q20wai0DkYCNqIS1884FQ2VTFrzkFNlufw/xiJg
	 NT1mbSkd+nEQj9V8r6SkKXWOHvqi6yDHpUktc5z4=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs" failed to apply to 7.1-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:07:20 +0200
Message-ID: <2026072920-plunging-amaze-5e74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x b422babd77fac2c96b92db484050e460899bddaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072920-plunging-amaze-5e74@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

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

