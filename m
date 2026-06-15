Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C54071EA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538681; cv=none; b=TmYJWBYm5ufAcN8NA1OZ8ttkv/ZJTNAoB498l5AypGIUqzbGrfLSoLPfPDLVLLFaM5zE2KKOO470niaOvKgYQutWkCuxFT2wa+fd9dWo9oCuqYUbcBUvXgwItaFxOkEkeGAWSotlHEGhw+q8s1R9/kPNgwqqXV2IlRKL680FzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538681; c=relaxed/simple;
	bh=Ik+NALzGGJ5ErejDzG02VqywW93g31GmNEAx1agaHp4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UBf5PDS29b8Ua9u/2QQ9ODdCpObZXLLDJhs0iD4FJQ2KQettHhy/3FZyKtlgejVej6xgqMnXORO+uf5TOBbxW3ZP84kT3kuIS+0rwqpCoEpKPO4jWMjJOdNcTGDstFRNWG2qygwB6Q4A7LzEIfdayuZxYOVLi1HQh3yTZ8Qdj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfZiGIE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfZiGIE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51181F000E9;
	Mon, 15 Jun 2026 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538679;
	bh=LKDA/GyzJeOhaAFuUiGpqZ/cxZvF4q8dXTTcmqj4eZY=;
	h=Subject:To:Cc:From:Date;
	b=MfZiGIE4GCaqWwhv+wqVHs7LMYO8+p2xVTYJUq3dUcho9oLZP0Hn4mg2/aFDOi7+G
	 bxkVJyvXK0rj0jZ6MWpkwffaxMJ+lPWqVe2v/teBP7EO8WP0N3/YynYawYwl+IeSAo
	 hnLZnHvB3YIRlM4j5+JGvGZuAKwrPrgcr+JPYe6g=
Subject: FAILED: patch "[PATCH] thunderbolt: Validate XDomain request packet size before type" failed to apply to 5.15-stable tree
To: michael.bommarito@gmail.com,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:45:17 +0200
Message-ID: <2026061517-lyrically-tigress-4a4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a504b9f2797b739e0304d537e8aa4ce883ecce39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061517-lyrically-tigress-4a4d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a504b9f2797b739e0304d537e8aa4ce883ecce39 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 25 May 2026 05:28:28 -0400
Subject: [PATCH] thunderbolt: Validate XDomain request packet size before type
 cast

tb_xdp_handle_request() casts the received packet buffer to
protocol-specific structs without verifying that the allocation
is large enough for the target type.  A peer can send a minimal
XDomain packet that passes the generic header length check but is
shorter than the struct accessed after the cast, causing out-of-
bounds reads from the kmemdup allocation.

Plumb the packet length through xdomain_request_work and validate
it against the expected struct size before each cast.

Fixes: 8e1de7042596 ("thunderbolt: Add support for XDomain lane bonding")
Fixes: cdae7c07e3e3 ("thunderbolt: Add support for XDomain properties")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 4099419c7479..9d54e3ccc827 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -55,6 +55,7 @@ static const char * const state_names[] = {
 struct xdomain_request_work {
 	struct work_struct work;
 	struct tb_xdp_header *pkg;
+	size_t pkg_len;
 	struct tb *tb;
 };
 
@@ -733,6 +734,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
 	struct xdomain_request_work *xw = container_of(work, typeof(*xw), work);
 	const struct tb_xdp_header *pkg = xw->pkg;
 	const struct tb_xdomain_header *xhdr = &pkg->xd_hdr;
+	size_t pkg_len = xw->pkg_len;
 	struct tb *tb = xw->tb;
 	struct tb_ctl *ctl = tb->ctl;
 	struct tb_xdomain *xd;
@@ -764,7 +766,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
 	switch (pkg->type) {
 	case PROPERTIES_REQUEST:
 		tb_dbg(tb, "%llx: received XDomain properties request\n", route);
-		if (xd) {
+		if (xd && pkg_len >= sizeof(struct tb_xdp_properties)) {
 			ret = tb_xdp_properties_response(tb, ctl, xd, sequence,
 				(const struct tb_xdp_properties *)pkg);
 		}
@@ -818,7 +820,8 @@ static void tb_xdp_handle_request(struct work_struct *work)
 		tb_dbg(tb, "%llx: received XDomain link state change request\n",
 		       route);
 
-		if (xd && xd->state == XDOMAIN_STATE_BONDING_UUID_HIGH) {
+		if (xd && xd->state == XDOMAIN_STATE_BONDING_UUID_HIGH &&
+		    pkg_len >= sizeof(struct tb_xdp_link_state_change)) {
 			const struct tb_xdp_link_state_change *lsc =
 				(const struct tb_xdp_link_state_change *)pkg;
 
@@ -870,6 +873,7 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 		kfree(xw);
 		return false;
 	}
+	xw->pkg_len = size;
 	xw->tb = tb_domain_get(tb);
 
 	schedule_work(&xw->work);

