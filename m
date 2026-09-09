Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0674F30EB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954578; cv=none; b=Uf4HhOREEWA7tXW0sBgjKScWFzCF2i2QP8k/gUxHfHUaqsy4LXvqPp+vTnBgLeet/rROzO+4AClWJDPCnBaKoJ3Mo7gptQ/K5LkltuOFUFftSJf5cAYz5eXjQqJyUa+jIH1DwrsScWVoE6P4Iq5EeEIghKXkTbD6On4F0T+QYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954578; c=relaxed/simple;
	bh=QEQQlG9IfvxwSh5t54UeS/2kMxPZhFLJmajC0nOfWwI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hOQMmTinjILgbUmiby2eQG1nzywcBfS7dOvIiRbwYwfmwVvS21ny5a6DQW6Npbz9UcmAQ0JRVg+Mvxz97mXBDYgeuzlvapWbMfNy74qmMQzuFwuVXJ4PiO3iIwa0BDJ0Cfc91LxcNr79YNUjWluinymp4sSP6yxGm8nTce7axqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Ka/0Rkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Ka/0Rkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE81F00A3A;
	Wed,  9 Sep 2026 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954577;
	bh=x5FxbtyBhklV6wTTRKjKdroT4aYam+STiPJUcohWA0E=;
	h=Subject:To:Cc:From:Date;
	b=0Ka/0RkgyC13wW/pyWcLzLwLAf3glE4jBiIWh0v2cZD8jdBHzX1PfheWfgoQolPuk
	 CTwNY4enIBXwHpVNNipSeelgkGz6hAhThPVjwbYCVlVMUUEI4Si3keVjQhDKsK5t75
	 gJlLr4NPdl1LjKaPPs6d0C9HEXN/Leo5F8bg2OVc=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Keep track of non-OA nonpriv slots" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:00 +0200
Message-ID: <2026090900-deflator-dropkick-d3d3@gregkh>
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
git cherry-pick -x 15739920b71ef3c56868973b4e7e3164a793d09d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090900-deflator-dropkick-d3d3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15739920b71ef3c56868973b4e7e3164a793d09d Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:21 -0700
Subject: [PATCH] drm/xe/rtp: Keep track of non-OA nonpriv slots

In order to dynamically whitelist/dewhitelist OA registers on OA stream
open/close, we need to keep track of nonpriv slots occupied by non-OA
register whitelists.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-4-ashutosh.dixit@intel.com

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 6d642c2f6fd7..b5ae7d26e5ba 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -161,7 +161,7 @@ static const struct xe_rtp_table_sr oa_whitelist = XE_RTP_TABLE_SR(
 	},
 );
 
-static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
 	struct xe_reg_sr *sr = &hwe->reg_whitelist;
 	struct xe_reg_sr_entry *entry;
@@ -193,6 +193,8 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 
 		slot++;
 	}
+
+	return slot;
 }
 
 /**
@@ -206,9 +208,10 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
+	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, &register_whitelist, &hwe->reg_whitelist, false);
-	whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe);
 
 	xe_rtp_process_to_sr(&ctx, &oa_whitelist, &hwe->oa_whitelist, false);
 }

