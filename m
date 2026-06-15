Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D6408003
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538689; cv=none; b=NHzMXonfqtzmSbAqPHaMhArnpd7i+znGezekb3huSKhcHdBn27Owg1zqnPdGmeSjOc8SKaj6J6aaN+MWQliSc+NPBfyJG5gGHY/cnkb7Dk7kCXshLnh1YsuVY+QWtwGMUgG8rsgS6Lp9Xpf1o3cYgrCW4j/onsaAZ260hBYlrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538689; c=relaxed/simple;
	bh=4owpLVZ4T2ma+ZzTEn7sG4Scod146669jEUmPvrkGAY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rg6oAXrg5zHZu2tdbHpUVTIvraHbwZqWAJz0OHLRSrHC8Z+bqDGAkGp5UBdeRUKTGul60LgMy28bl+D7A/hOzGA5tEX1MYS+7n13df9wFyyhiJphvqFmGcwcSUKU2F3ZixiWOdmcDp7rn3hqZXOjuZ0XONoVnLKXneSKzSNK5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MrkmwGUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MrkmwGUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3C21F000E9;
	Mon, 15 Jun 2026 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538687;
	bh=VE61dPwO3VOF+tMYlYsVou4ILgKcnuq44a3jxqlSNGY=;
	h=Subject:To:Cc:From:Date;
	b=MrkmwGUPR6BS2k92Slkg8UgyF9Ni0fo313hJrTizwK9JLJ8kAmxbzMyIO1e4yn08P
	 EGLGHvg0vOWTxHKGXA7stGq15vqORU5EmWDV4JBBZe2KpCygaRFwJw28PF1hIWNQLN
	 0yz0fF+4BXo8/yochhR7vt7PWmDJ8kr0f3EtRje4=
Subject: FAILED: patch "[PATCH] thunderbolt: Validate XDomain request packet size before type" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:45:20 +0200
Message-ID: <2026061520-civic-shiny-9fb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a504b9f2797b739e0304d537e8aa4ce883ecce39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061520-civic-shiny-9fb0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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

