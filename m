Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE430EF68
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966311; cv=none; b=rgYJpqFAoIarLE2qYTEQjTD6V5cGG1G8Apis+KeSVWRjbB4isp7aZ/CSWoRJtcGDdf6uwQgqb4aitrg9gAXXKT+c8FBlaOZQk+7G2/4ddhgC/kVybighE/6L35qYq6xki7Msi6GkQjbrAu0ay2YOUEP2pav9ZVdBdftZB4Lc3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966311; c=relaxed/simple;
	bh=pLbbvvwZaSN5ynxW8Uz2C4odHSZFmLXQdlmrfklun94=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=alZbc5T3/mNKoiYtuOEzCAgaggg0AcAqZYcmvKatxx/6BdfgTdJ1vmV8zdio94PNRe3vPxY6mWGogHcjcTd+lWtka9E1oCo6yWI4uPxTKTdJdE+hvI7VI+KtzzWVSWlhcbBThBIrN95EaBX+X5OtJwiF9tPmLDsHnPwbLaiiHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IUK2XSda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IUK2XSda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19F71F000E9;
	Mon, 17 Aug 2026 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786966310;
	bh=PzqVG1cV+gXdX8dL3C4GAfY2cbNE8s2+PRPT0F0xJRw=;
	h=Subject:To:Cc:From:Date;
	b=IUK2XSdapGENqPIeOOqmYFlW+FPCPpj0NXb6HhSt1DGuz+3WGiZcKfBLCz+2/34Jr
	 Qo/FRQwG6/s7aV73KuFko4ylFmnN6SFIKHiBcsRm4nyK8wpoU9rELQSwSMRGKMaIBs
	 nk28gICLSo81mQIKn1E+vedwT9+cMS0i5S9hR37E=
Subject: FAILED: patch "[PATCH] net/sched: reject overly deep qdisc hierarchies" failed to apply to 5.15-stable tree
To: milkory@outlook.com,enjou1224z@gmail.com,jhs@mojatatu.com,pabeni@redhat.com,vega@nebusec.ai,victor@mojatatu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 13:30:13 +0200
Message-ID: <2026081713-crushed-deftly-56ac@gregkh>
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
git cherry-pick -x dedd34b0f2310e28c5f6d4875cfbf4b7ed821c01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081713-crushed-deftly-56ac@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dedd34b0f2310e28c5f6d4875cfbf4b7ed821c01 Mon Sep 17 00:00:00 2001
From: Zijie Huang <milkory@outlook.com>
Date: Sat, 1 Aug 2026 21:42:33 +0800
Subject: [PATCH] net/sched: reject overly deep qdisc hierarchies

Deep qdisc hierarchies can lead to excessive recursion in qdisc tree
walkers and exhaust the kernel stack. The existing loop check does not
cover the create-and-graft path, so a hierarchy can still be extended by
creating a new child qdisc below an already deep parent.

Store the hierarchy depth in struct Qdisc and update it when qdiscs are
grafted. Reject new child qdiscs once the parent is already at the maximum
allowed depth.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zijie Huang <milkory@outlook.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Link: https://patch.msgid.link/1e9ab39597423fd5d13cfaaf52279b8ee3d9fc3c.1785434373.git.milkory@outlook.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 45a1e8c78222..cbc248776511 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -99,6 +99,7 @@ struct Qdisc {
 	struct hlist_node       hash;
 	u32			handle;
 	u32			parent;
+	int			depth;
 
 	struct netdev_queue	*dev_queue;
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 668bcd60d183..65b35528d125 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1114,6 +1114,9 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		unsigned int i, num_q, ingress;
 		struct netdev_queue *dev_queue;
 
+		if (new)
+			new->depth = 0;
+
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
@@ -1211,9 +1214,15 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			NL_SET_ERR_MSG(extack, "STAB not supported on a non root");
 			return -EINVAL;
 		}
+		if (new && parent->depth >= 7) {
+			NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
+			return -E2BIG;
+		}
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
+		if (new)
+			new->depth = parent->depth + 1;
 		notify_and_destroy(net, skb, n, classid, old, new, extack);
 	}
 	return 0;

