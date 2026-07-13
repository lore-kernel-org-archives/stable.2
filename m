Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A56438007
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951121; cv=none; b=ItwqOB5swOacHbPgsdMg/nIj22zWSxbMwHqGespERajgSH8ScM2R1WVwWz81Jl3kRX6TIlVaS1878DKwxJhj3ZntF1b8hDDB7WtUiUb+CKt74JgyNVquykq2pvEh5KRiq1s9gAflz31SXDqBScmbKxY7Vcc2O0WGWVgAFXojhdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951121; c=relaxed/simple;
	bh=LU2XUR1cFn2wANRSZ4L+LIHSTX+QKa2pAZr1dviT4G0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EA/uUJ/3J2a8JkvWGMooGBXVuPxCZxwLqwZDi1w8NQIOz5m3ZjtkvFcfnCTB7nW4XFCY8TzAWEtqMglTFSvR/UuN6Dg70Dsc0h1YgSbdQz9DddPjkSLXD5K//hBYPbaa13etoQGwpCgYzy1Oxij/WhZBCk5qjkFkeDWDI8vYXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a9zSClwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a9zSClwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E8B1F000E9;
	Mon, 13 Jul 2026 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783951120;
	bh=s39+o4lSwAOGsB/BfV3Elo47q8ETwvjJaSUzD4HMU3E=;
	h=Subject:To:Cc:From:Date;
	b=a9zSClwnzGPQes/Xkjqmgc8tLvWCj4bbjAf5nRVKECcYqAfotBCmKIzdHuPrjo03i
	 gslhFwcuj2HA+kVLuf9jYTJ/kfm3p1E9bWILIMz7UOylt6T5ek19P5PYEYzRVsEBSm
	 QdQYyuQZ7RD4SIak2p/Qp8Pky9BXKrMkedLloEao=
Subject: FAILED: patch "[PATCH] netfilter: ebtables: zero chainstack array" failed to apply to 5.15-stable tree
To: fw@strlen.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:48:35 +0200
Message-ID: <2026071335-donator-saucy-140c@gregkh>
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
git cherry-pick -x cbfe53599eebffd188938ab6774cc41794f6f9d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071335-donator-saucy-140c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cbfe53599eebffd188938ab6774cc41794f6f9d5 Mon Sep 17 00:00:00 2001
From: Florian Westphal <fw@strlen.de>
Date: Sat, 4 Jul 2026 10:23:31 +0200
Subject: [PATCH] netfilter: ebtables: zero chainstack array

sashiko reports:
 looking at ebtables table
 translation, could a sparse cpu_possible_mask lead to an uninitialized pointer
 free?

 If cpu_possible_mask is sparse (for example, CPU 0 and CPU 2 are possible,
 but CPU 1 is not), the allocation loop skips CPU 1. If vmalloc_node() fails at
 CPU 2, the cleanup loop will blindly decrement and call vfree() on
 newinfo->chainstack[1].

Not a real-world bug, such allocation isn't expected to fail
in the first place.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 5b74ff827493..48187598cdd0 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -921,8 +921,7 @@ static int translate_table(struct net *net, const char *name,
 		 * if an error occurs
 		 */
 		newinfo->chainstack =
-			vmalloc_array(nr_cpu_ids,
-				      sizeof(*(newinfo->chainstack)));
+			vcalloc(nr_cpu_ids, sizeof(*(newinfo->chainstack)));
 		if (!newinfo->chainstack)
 			return -ENOMEM;
 		for_each_possible_cpu(i) {

