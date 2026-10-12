Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BA468C38
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805367; cv=none; b=tCdlc0jBCu3tNnjmNDH9WDXmAEthxIKVgbFFk1MdI0OvxDZdOhPwfJlO+2Kx4lJCI8CIAH5RVJ4jXVPwmUMPBEGPxrWtkdk4herioETcbVE0qmLMGtyI741AVo4ozkbxRHKAvc8hdS13RMnWLIRTYnxau3knDlT3M/MUgS7ALN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805367; c=relaxed/simple;
	bh=JeIBfQ2fUrSMJYNLIV4MtCadustM99JB4yDQntfrH24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LrzlYevxIWAFmssXtlvd4LQtFsBMKn29YIUDNE1nXr5xyfK7smcarwkDCQ9vVMyzC26fAQJECtdBl53MzBetFIt0xk3DkOS4tCCRfz7qL2Db569mjzEAOXIByqI9SC+YEfF53h2yPHRPHGsOlko5BFWEdXNa2z7AawS7FZUcZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XwtYB2Ev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XwtYB2Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4091F0089D;
	Mon, 12 Oct 2026 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791805366;
	bh=PenqOQTDd380GZKNvLua74cJ+JGkvFe+q5Aeg4sIYtU=;
	h=Subject:To:Cc:From:Date;
	b=XwtYB2EvqqTwIgcFjD4RFC1ptqfG9Xdq4P1r/9aaXf504eE3DEOf2f1TtzmhJ8Z7/
	 MhAUejN5J+TrDsj7bL1fMynsEt5NagriC+j9Bf5CHNJrJE3t4ePUhubTD2XFc2Jghr
	 Y09u/fY9TeiCgYp60zrzymoPdaWKiSvTrof/Phy0=
Subject: FAILED: patch "[PATCH] ice: fix metadata_dst refcount handling on representor" failed to apply to 6.6-stable tree
To: tristan@talencesecurity.com,anthony.l.nguyen@intel.com,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:42:51 +0200
Message-ID: <2026101251-unease-coastal-c9ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 58858b8f14803a7eeac297b3ce20f3b21bf2ff66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101251-unease-coastal-c9ea@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58858b8f14803a7eeac297b3ce20f3b21bf2ff66 Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Mon, 28 Sep 2026 16:04:25 -0700
Subject: [PATCH] ice: fix metadata_dst refcount handling on representor
 teardown

ice_eswitch_release_repr() uses metadata_dst_free() to release the
representor's metadata_dst.  metadata_dst_free() directly frees the
underlying memory without checking the dst_entry refcount.

When ice_eswitch_port_start_xmit() processes a packet, it takes a
reference via dst_hold() and attaches the metadata_dst to the skb.
If the representor is torn down while packets are still queued on
the lower device (e.g. in a qdisc), the metadata_dst is freed while
references are still held.

Use dst_release() instead, which correctly decrements the refcount
and only frees the object when all references are dropped.  The dst
subsystem already handles metadata_dst cleanup in dst_destroy() when
DST_METADATA is set.

Other drivers sharing this pattern (nfp, airoha, bnxt) already use
dst_release() for their metadata_dst lifecycle.

Fixes: f5396b8a663f7 ("ice: switchdev slow path")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260928230429.495442-5-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index b069e6c514fb..6e7bba473898 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
 		return;
 
 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-	metadata_dst_free(repr->dst);
+	dst_release(&repr->dst->dst);
 	repr->dst = NULL;
 	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 				       ICE_FWD_TO_VSI);

