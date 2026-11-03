Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703860;
	b=go30x3hVL3FFDVecmTw8t5GepyunyqRB9tBODFul5m2VRerIMTCAsnWoBGlRGPdc/ffm
	 7Md9m35RHDNLGH2HeStA8RI20IMKQsrNEigDc1luBNCD0SNdHzRaSbdKRYFNzC1ia2HWX
	 q4UXMa0FGRgTWyoZB1TcdtCfK4DlZtH8s5eHc3Ox8Uy6YPAPu/VS1/0UvtSQwmIyZUBCV
	 pakENoUw6iFiyQALamnmE6uh1PtdHTMCUPtCGI10+RYC4Rqo0uOXxBVJ0AIzlVkVGZxrY
	 Tjgm9YR6Fly1jM3bLYJu1x5emnpuGC+m36EirNUeTB29n8xFPpYp3iEwRXpc4aOWIfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703860;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OXg4obVeKhGS7rF4EcSZzO0spR+VQnbA8L16/fRPdhQ=;
	b=5bEmZaVf5/GqGeuAzWoKDNXZV7UDZMBwqpHC0iO/M0uo897Aq8cgqZ8SDx4uXfzBlaSj
	 6i7Fu8NTm6VFYUNdFYhyBUGtE+yc0d8LBV6BlKpsVuknI7bCpYtG6abY6LQdiaNDNc2kS
	 aqETawxBQ+aRRu7CXNNA4WKK8V/JVWKpsgh7INxy02fA2EinfmyqnOII+HK7iPRnXADuE
	 jfLUb9EqsUDawEN+ojDJXFnwZAyBKgX3HKjV1Rm9QsHO6fIjz4BBzHme3da+eJEblPPb5
	 g026GnkUKRsTrv1JuRhHnbyGPdJUVQUwOIIN81W/nb8SgjvOAkZGgtiUL9aznLzWGoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=je72VPNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389D606BFB6
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=je72VPNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D136B1F00A02;
	Tue,  3 Nov 2026 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793703860;
	bh=OXg4obVeKhGS7rF4EcSZzO0spR+VQnbA8L16/fRPdhQ=;
	h=Subject:To:Cc:From:Date;
	b=je72VPNYIWro5UgWLKy0ANDCCxO9t1P0WzcDxt6GcZsz0d9V+V++eolqUemcIdkgl
	 aF1AQ9eQJDG7DwUKlR44HpPqrScq751BAm2cFJnNhkUiV5L2YIfWuVHr5l3/Wc+DSn
	 JizQ4sk2klQ4bYi2Jx80p81ilQY6O6I7Hj17em20=
Subject: FAILED: patch "[PATCH] net/sched: cls_bpf: accept dev-bound programs on shared" failed to apply to 6.6-stable tree
To: jhs@mojatatu.com,horms@kernel.org,kuba@kernel.org,sashiko-bot@kernel.org,victor@mojatatu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 12:02:38 +0100
Message-ID: <2026110338-strangle-revoke-5922@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x d305547d1632a242818c5ebb430c85121a2ed434
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110338-strangle-revoke-5922@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d305547d1632a242818c5ebb430c85121a2ed434 Mon Sep 17 00:00:00 2001
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 10 Oct 2026 17:02:49 -0400
Subject: [PATCH] net/sched: cls_bpf: accept dev-bound programs on shared
 blocks

The issue:
Follow-up to commit 120977e2c096 ("net/sched: cls_bpf: reject dev-bound
programs bound to a different device"), which derived the target device
from block->q:

	dev = block->q ? qdisc_dev(block->q) : NULL;

tcf_block_create() leaves block->q NULL for shared blocks, so a
device-bound program attached through a shared block is rejected with
-EINVAL even when it is bound to a netdev that owns the block.  The
offload path (cls_bpf_offload_cmd()) never consults block->q and drives
the per-device callbacks for shared blocks as before.

The Fix:
Accept the attach on a shared block when bpf_offload_dev_match() matches
every netdev bound to the block, and reject an empty block.  Every member
must match because the offload path broadcasts the program to every
callback registered on the block, so an any-member check would re-admit
the wrong-device attach on a mixed block.  Every dev-bound SCHED_CLS
attach is skip_sw, which becomes err_stop and aborts the offload on the
first failing callback, so the all-members rule is the offload path's own
semantics.

Iterate the public block->ports xarray (913b47d3424e, v6.8-rc1) rather
than block->owner_list, which is private to cls_api.c.  The shared-block
rejection reports "Program is not bound to every device in the block",
distinct from the non-shared message, because a member can exist without
a registered callback (netdevsim registers its block callback
ingress-only).

Context note:
This patch is not an independent fix: it re-exposes the shared-block
replay path that commit 120977e2c096 ("net/sched: cls_bpf: reject
dev-bound programs bound to a different device") had closed, so patch 1
must be applied first, including in stable.  A stable tree taking this
patch alone would re-enable shared-block attaches on a kernel whose
netdevsim callback is still unchecked.

Conditions to recreate the bug:
  - CONFIG_NETDEVSIM=y, CONFIG_NET_CLS_BPF=y
  - load a dev-bound SCHED_CLS program for netdevsim device B
    (prog_ifindex=B), pin it in bpffs
  - tc qdisc add dev B ingress_block 22 clsact
  - tc filter add block 22 ingress bpf da object-pinned <pin> skip_sw
  Unfixed, the filter add fails with -EINVAL ("Program is bound to a
  different device"); fixed, it succeeds.  Adding a second, independently
  backed netdevsim device to the same block makes the attach fail again.

Fixes: 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs bound to a different device")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/QDISC-PYC7.v2.20261010165947-3@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 188cf0f949dd..07ad9556889d 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -392,11 +392,31 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	if (bpf_prog_is_dev_bound(fp->aux)) {
 		struct tcf_block *block = tp->chain->block;
 		struct net_device *dev;
+		unsigned long ifindex;
+		bool match = false;
 
-		dev = block->q ? qdisc_dev(block->q) : NULL;
-		if (!dev || !bpf_offload_dev_match(fp, dev)) {
-			NL_SET_ERR_MSG(extack,
-				       "Program is bound to a different device");
+		/* A shared block has no qdisc of its own, but it may bind
+		 * several netdevs and the program is offloaded to all of them;
+		 * require a match with every member.
+		 */
+		if (!tcf_block_shared(block)) {
+			dev = qdisc_dev(tcf_block_q(block));
+			match = bpf_offload_dev_match(fp, dev);
+			if (!match)
+				NL_SET_ERR_MSG(extack,
+					       "Program is bound to a different device");
+		} else {
+			xa_for_each(&block->ports, ifindex, dev) {
+				match = bpf_offload_dev_match(fp, dev);
+				if (!match)
+					break;
+			}
+			if (!match)
+				NL_SET_ERR_MSG(extack,
+					       "Program is not bound to every device in the block");
+		}
+
+		if (!match) {
 			bpf_prog_put(fp);
 			return -EINVAL;
 		}

