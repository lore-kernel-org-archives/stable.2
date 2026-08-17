Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951C3E49C3
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966362; cv=none; b=rB9LsWGSMjPwF1x3Jk5xy1XqNHHny8lX/p9xO2rwjT/aG9KQ6/+rlYWlLR/59VFNrv+9xUd71AregDm961mvJv2xSxevj2lLA3TIxp6lXNs9qFMCH/sCXcICCUmAtiK4rKGMR0AIRbIrdcXfzsYt7ksM/C7h//NRSPHI+c3zGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966362; c=relaxed/simple;
	bh=xW/dSGqdQ1PIEcWPPPWmFIdx8yXK3Cd/rb6/dkQNAK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Txvb3lqZIeAEBePXmOVaWcLO1mce4454INpkaRG3Emtiz7Zc9ldhQeC/PunNVo4JsP03Lu88rexGY8KAXQhtNvE7OLuQLNHOj28sUQd279K/Dm9d5ql/FQ2UfYtqSiHCS+V4f/6dQrkFb94xmsDkl7vZq0SS15+fBFr/DfCCMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvlNNVp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvlNNVp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B42E1F000E9;
	Mon, 17 Aug 2026 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786966360;
	bh=M8J3jb/WeupXlTzCl1jNaorJBXuQKcSU8yywLmGLyp0=;
	h=Subject:To:Cc:From:Date;
	b=vvlNNVp9SkAMW65odNDtGpem/I6YPSMXrhZc/jPDlpFHBQpHH1ifS6h5/IbsXefke
	 rlr24lum9X1brpoloKOSzKJrnZbPWJUXaIYYfngzTtP29jW2zXGjIxxWGQbRtCVq43
	 CHBG5jUFZ1Z7/VK+kn6vEUGRuaW3O/33xKgGf9QY=
Subject: FAILED: patch "[PATCH] inet: frags: publish queues before arming timer" failed to apply to 5.10-stable tree
To: zhilinz@nebusec.ai,enjou1224z@gmail.com,kuba@kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 13:30:51 +0200
Message-ID: <2026081751-nape-kissing-c981@gregkh>
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
git cherry-pick -x 653d7ddf6cba867777a3d14c4f83ace008c5ad13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081751-nape-kissing-c981@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 653d7ddf6cba867777a3d14c4f83ace008c5ad13 Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Tue, 28 Jul 2026 01:23:29 +0800
Subject: [PATCH] inet: frags: publish queues before arming timer

inet_frag_create() arms the fragment queue timer before inserting the
queue into the fqdir rhashtable. If the namespace fragment timeout is
zero or negative, the timer can run before the queue is published.

The timer callback then marks the queue complete, tries to remove a node
that is not in the hash table yet, and drops the anticipated hash
reference. Creation can subsequently publish the completed queue without
restoring that reference, leaving a stale hash node after the caller drops
the remaining reference.

Publish the queue first and arm the timer while holding the queue lock.
This makes timer expiry wait until the queue is visible in the hash table,
so inet_frag_kill() can remove the node and balance the hash reference.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Link: https://patch.msgid.link/bf66785e7c0c139d7a1900e2f01faeeab344b960.1784948849.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 848c0f0c2ed9..fc0cb993959f 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -393,8 +393,8 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
 
+	spin_lock_bh(&q->lock);
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
@@ -402,13 +402,13 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		 * we need to cancel what inet_frag_alloc()
 		 * anticipated.
 		 */
-		int refs = 1;
-
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q, &refs);
-		inet_frag_putn(q, refs);
+		spin_unlock_bh(&q->lock);
+		inet_frag_putn(q, 2);
 		return NULL;
 	}
+	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	spin_unlock_bh(&q->lock);
 	return q;
 }
 

