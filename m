Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CA32B112
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966359; cv=none; b=fpMRei14cFQajHss1TGcnRBP11dtfEUKZBVcwxnxxrjMOBKJTm7J2GmANAmzGCiMFaNuenqERqt6Xkly/chLDlW+UMagGvB4XQv3U+ovaEeVm10/8ij6t3OMeD/aWYKFXMagd9FzXHvefTiCxlOQvV45kI2yfrxkodu/7MZio0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966359; c=relaxed/simple;
	bh=lWhIRdASeJ3/OdoLxUlWOQXVaEWejD6cSkb84QwIDhE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lAQ8JssjezUc4vSLSDfm2ezCKM3da+jfsNHhjw82msp3MzHpxpx6mK/c/6gm8pjceB/Rq3AILOySIsmRbjyYQQ0Y8I1IFWyC6Kw/87SH61FoLcXFQF5jp0hSVZDKf2R7jToCWo5MKVBYwylYqvgbDJU9NvIFIRS3rvQSYYz2Mro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lnm2/9dT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lnm2/9dT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5839F1F000E9;
	Mon, 17 Aug 2026 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786966357;
	bh=quA545YyCJ5vloSgA5M8+pvRRrMvlMRjAgERHVw8ySM=;
	h=Subject:To:Cc:From:Date;
	b=lnm2/9dTKA6BV82XVvZ6I+p39rT9+MyeK9S12TjYCvJW14bh6fGPlAGfXNoitJmbo
	 3ONkYQBMKF4EHPinwBVRxPy5pVSIwcwlTqW9RPlTmEdLrT1C3WyAIYnO8A3jJ06/W5
	 AnDx6pPcls9XH6NbCalnAWsoOviCA1kJAoYFc8D4=
Subject: FAILED: patch "[PATCH] inet: frags: publish queues before arming timer" failed to apply to 6.6-stable tree
To: zhilinz@nebusec.ai,enjou1224z@gmail.com,kuba@kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 13:30:50 +0200
Message-ID: <2026081750-scion-darkened-b02a@gregkh>
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
git cherry-pick -x 653d7ddf6cba867777a3d14c4f83ace008c5ad13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081750-scion-darkened-b02a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

