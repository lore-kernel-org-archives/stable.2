Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597963;
	b=LLqdlcus46GxKU/Umesd/4ojNBEoIyjggM5c0M1SNXmnEnY/03E0d0Z9pqAyVJeFYAqB
	 KJixxzuLeCvN6q0l1JntXCAs78lPQjmQrrEtK39j0u60dodFlT3jITv/8XrvoQCAZ19i+
	 yExAZv2JTJlkhEVBGQdHScVfI5hN3x/0Ar0RTt4XlC4ytdUp91cNMQXe/+5d2i5bRz6S9
	 1y4a+7cfaVM5Y9OoGMK3UePHjPDiOWjaedH6A2O0vZeE1B4Yla0f5LalBU2EL9PxDR6P5
	 vqHiQDoWTkVwNs57C8swt7u2nxBsi9XrO0fKS2NosMXU4yd8rGOW5rSQnjZ6Itn8AyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597963;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TIkzhDUVDhkTz+voBwMZt7D2HzoHmpuxSXFe3+46NY0=;
	b=AOhG+oLRHqKaHJYVns6AKBRJquwmdlsu2YIo4sjm3BGHEz2t/NFXPaRPaY5/u/yjiKKM
	 pwOc2vDWGMn/J/BsI9Bavhn/rlVgu2G//MG60Ad+CdjgYqrK1CreQhZeleOxRcKveabTk
	 DOQSVs0dpauvc0hGDbJebEjSHdAtCqs51Hrc76bRiyKgw8Ew7LlG7fE0TnPepIvy/IbFj
	 oKX+3yBfZ6BATJSF4wIJIzGTlzAp4hs0KMZLFjIB6puWyuV9lyX12JpdArEz3bZYJL1OW
	 JCdxZnKNPxw5QnOA1X8i/BKNoq0VOELAdldNK+94mR1iSRh9gkFecKZVdmt45WO03JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DLDGJ9nU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82360A2637
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DLDGJ9nU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8C11F000EE;
	Wed, 25 Nov 2026 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597963;
	bh=TIkzhDUVDhkTz+voBwMZt7D2HzoHmpuxSXFe3+46NY0=;
	h=Subject:To:Cc:From:Date;
	b=DLDGJ9nUYsi07yBXB8PbDsWM7fGhQjg1IZsX8XQputooRZEGh9yhnkhW7h5xT9Cb/
	 7DZJsh7+sMrxxDubeysaXaCRRmxVadwT03Id70k5SROrT7eDjyYnddRDA4xY1PU/kC
	 llt+AWt0QQ9g+hkqgSe+twNfCXkoSuWgjkzJ6Png=
Subject: FAILED: patch "[PATCH] netfilter: nf_dup: preserve guard across NFQUEUE reinjection" failed to apply to 6.6-stable tree
To: zihanx@nebusec.ai,pablo@netfilter.org,root@tr0jan.top,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:01:52 +0100
Message-ID: <2026112551-expiring-pursuant-4942@gregkh>
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
git cherry-pick -x 82052e5b5ec36504fe1b9c3c28a711a78fcacf37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112551-expiring-pursuant-4942@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82052e5b5ec36504fe1b9c3c28a711a78fcacf37 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Fri, 16 Oct 2026 16:14:17 +0000
Subject: [PATCH] netfilter: nf_dup: preserve guard across NFQUEUE reinjection

NFQUEUE can suspend traversal of a duplicated packet while the task-local
duplication guard is set. The output call then returns and clears the guard
before a later verdict resumes hook traversal.

Save the guard in the queue entry and restore it while reinjection
continues hook traversal. Preserve and restore the verdict task's prior
state, including nested synchronous reinjection.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 86021c55ba3c..4a8cefd8398d 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -23,6 +23,7 @@ struct nf_queue_entry {
 	struct net_device	*physout;
 #endif
 	struct nf_hook_state	state;
+	bool			in_nf_duplicate;
 	bool			nf_ct_is_unconfirmed;
 	u16			size; /* sizeof(entry) + saved route keys */
 
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 166d05e994ac..bd603e3a99a5 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -219,6 +219,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.skb_dev = skb->dev,
+		.in_nf_duplicate = current->in_nf_duplicate,
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 90d887546f7d..a8aa7ad832c3 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -44,6 +44,7 @@
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <net/netfilter/nf_queue.h>
+#include <net/net_debug.h>
 #include <net/netns/generic.h>
 
 #include <linux/atomic.h>
@@ -365,21 +366,30 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	const struct nf_hook_entry *hook_entry;
 	const struct nf_hook_entries *hooks;
 	struct sk_buff *skb = entry->skb;
+	bool old_in_nf_duplicate;
 	const struct net *net;
 	unsigned int i;
 	int err;
 	u8 pf;
 
+	DEBUG_NET_WARN_ONCE(current->in_nf_duplicate &&
+			    !entry->in_nf_duplicate,
+			    "%s called with unexpected duplication guard",
+			    __func__);
+	local_bh_disable();
+	old_in_nf_duplicate = current->in_nf_duplicate;
+
 	net = entry->state.net;
 	pf = entry->state.pf;
 
+	current->in_nf_duplicate = entry->in_nf_duplicate;
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
 	i = entry->hook_index;
 	if (!hooks || i >= hooks->num_hook_entries) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_NETFILTER_DROP);
 		nf_queue_entry_free(entry);
-		return;
+		goto out;
 	}
 
 	hook_entry = &hooks->hooks[i];
@@ -402,9 +412,7 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	switch (verdict & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_STOP:
-		local_bh_disable();
 		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
 		break;
 	case NF_QUEUE:
 		err = nf_queue(skb, &entry->state, i, verdict);
@@ -418,6 +426,9 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	}
 
 	nf_queue_entry_free(entry);
+out:
+	current->in_nf_duplicate = old_in_nf_duplicate;
+	local_bh_enable();
 }
 
 /* return true if the entry has an unconfirmed conntrack attached that isn't owned by us

