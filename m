Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC353CA6F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954604; cv=none; b=pxwOBWvpaU4mF3BfpT84zdSxl2ZdElITMutunuKJ84B/Y07f2z9FXg1Hvtd2kiaN1qOlSXA89kysKPcoBQcrJTVxQXaR+SRJlfKahYNkRBIKk0AfTlQ8HW/Cy6PSjd6QYSiWK36fOOVfBSuq5dD0RqDWLyD3mrPZNjudPS091hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954604; c=relaxed/simple;
	bh=mv9Y0rSoYDOQ1lOVj9soV7VVODgWUSfKeb5/867BG4s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ENzw66P0OuM5SvGWVdIGgw8hsuQ0h7WhPDQjeWq634hRa+6pj7DN5aVbPmdxi7MFlzF/Nm/IQ1THEvaEsSrcbf3tGLEVxbrUn+olWyLtohBlchqJhiTyt7k+fA96G0e6S2Vqzd7Ldmu5ge48fCuMcutQM1ffQdIe7iAsJS8e5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cm5tRXLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cm5tRXLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA33B1F00A3A;
	Wed,  9 Sep 2026 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954603;
	bh=qF61rUuApOW1fRgHuKLVrsfoovbBxlsAYK/yjKYrwz4=;
	h=Subject:To:Cc:From:Date;
	b=Cm5tRXLNI+nPqYec/ETjShHhAqbBLx04zO8TJDo0LB39kXCpZDNaN5+1Hk4lCLYPB
	 Kr8pISbkqaa5TWSvQNA+ez/QqTYv1vf4TjCKiuWkzGGbTCV2lSluhf/YTDh259mpt9
	 y+S248lVueqlDShkUgvHiKCs7Lt9Hun0+MoFbTPw=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:28 +0200
Message-ID: <2026090928-cricket-maturity-af35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aeaa7d2bb017272ab9e18759fe00bf758cd3299f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090928-cricket-maturity-af35@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

