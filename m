Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788543803F4
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674781; cv=none; b=oc9QdJB8IFPI8Z2QLHxedlAkFyUkNY4ZbBC+y1zufdHn7oFpYrZoOnW+aDTvw8UCvffL2cOJIzU5VOE6Q1Klwp+t8dWfoYPOKwdj58YkWlGbdwAEiRo59OQdaOAuubRcWRpPoG1IMz7s1JV0HyiioS4cDiWWKKUbw3GulaqGEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674781; c=relaxed/simple;
	bh=k1Ss91Xzx8EfXKnC491ndAkcTFLxiJnf47KAW873ezY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tJRxFf5B1fIdc2+tUhKpt+c0JBel2Q0jHSL+5wdmuem+qsynwXMlZ3PzxpTraue1haLaYPvj5Q8C1rpsac0gdyJoriacBkw01nGr4Jt49lEQUS6vUYOx6UvkBoyYWXimXSXPmDc/1o9qXa/DuI0wwtcqaAF++sLlfspC3QCvCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0HRk7i7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0HRk7i7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29751F000FF;
	Tue, 29 Sep 2026 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674779;
	bh=4BwvdE1KwuK/gPdb7QRNvKwjrmCjSHBIr2w9noMLAxo=;
	h=Subject:To:Cc:From:Date;
	b=J0HRk7i76Eu1ab46DX4/s1eIC0txGeZ0T72MCH8iq1GfKS7QPvkyvU0wPjkx8ihZZ
	 gSn7xzUsYTZR/AV8jvyCf0bESPFP5MqhqFw1z26VOl9OJNVMVJFuxsHSCC8LG46C0U
	 3RARMJPsxMxQD3SOMKcNy49PloHuAysYFA00MXCY=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: skip expired catchall elements on" failed to apply to 6.1-stable tree
To: henrymei@tencent.com,corvus@tencent.com,pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:39:23 +0200
Message-ID: <2026092923-thievish-makeshift-9a83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 70194dc37670bd08e44b471389861cc01bd3a3c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092923-thievish-makeshift-9a83@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 70194dc37670bd08e44b471389861cc01bd3a3c9 Mon Sep 17 00:00:00 2001
From: Aohan Mei <henrymei@tencent.com>
Date: Mon, 14 Sep 2026 19:51:47 +0800
Subject: [PATCH] netfilter: nf_tables: skip expired catchall elements on
 insert and delete

nft_setelem_catchall_insert() looks up duplicates with
nft_set_elem_active() only, while nft_set_catchall_lookup() and the
dump path additionally skip expired elements.

Once a catchall element with a timeout expires, this predicate drift
makes it invisible to userspace dumps, yet it still blocks
re-insertion: with NLM_F_EXCL the request fails with -EEXIST, and
without it the request reports success but silently inserts nothing.
The stale entry only goes away when the (user-tunable) gc interval
elapses, so the catchall rule may silently stop matching for an
arbitrarily long time after its first expiration.

The delete path shows the same drift: nft_setelem_catchall_deactivate()
picks the first active-next entry in the catchall list, so with an
expired entry still pending GC it retires the stale entry instead of
the fresh one, and it deactivates an element that userspace no longer
sees instead of failing with -ENOENT.

Align both walks with the lookup and dump predicates: only an element
that is active and not expired counts as a duplicate or delete
candidate, using the per-netns timestamp taken at transaction start,
in line with the set backend .insert/.deactivate and catchall GC sync
paths.

Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c0b754a2d45b..b59628e6240c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6995,11 +6995,14 @@ static int nft_setelem_catchall_insert(const struct net *net,
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (nft_set_elem_active(ext, genmask)) {
+		if (nft_set_elem_active(ext, genmask) &&
+		    !__nft_set_elem_expired(ext, tstamp) &&
+		    !nft_set_elem_is_dead(ext)) {
 			*priv = catchall->elem;
 			return -EEXIST;
 		}
@@ -7092,11 +7095,14 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
 					   struct nft_set_elem *elem)
 {
 	struct nft_set_elem_catchall *catchall;
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active_next(net, ext))
+		if (!nft_is_active_next(net, ext) ||
+		    __nft_set_elem_expired(ext, tstamp) ||
+		    nft_set_elem_is_dead(ext))
 			continue;
 
 		kfree(elem->priv);

