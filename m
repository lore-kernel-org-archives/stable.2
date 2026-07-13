Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AF437448
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951124; cv=none; b=T/o1lHyPNGvdDYkLBXXLdN6PFJVmywcOC7V7lXJUL+K1neufo1/l08UZl9Mmi9wZp6Crq6jCeIcSvj6RT7gRdRHQgy+BOkFFikcLB7LR2PY94EovpvEYETVZYhW2BGFdGSQdY88b+y0FNRWmWTaBe4kA4fmLBHmJesluhphzenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951124; c=relaxed/simple;
	bh=5a+uLfZu3ZU9jwV1ec2upOVcWxVkSjDG9QqN6WM6aYU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iBGW190vBt6hvKpJO9PM2CEVe+GKRlg/UacLcaTyNc4I2BlJF/MNsDHXaJrlFlCtksTm/vC//5cHTirEzPjXA6FpM5u6Rm6saxmp2lshxmKNlBb+UizMdg+pNofcUfJ2TGBYMYuKG+0M1Z+ZLOaMG30AXo5VLZ3jbjVR7os2X/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CSsW6ew9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CSsW6ew9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB2A1F000E9;
	Mon, 13 Jul 2026 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783951123;
	bh=TnHYac4zypW7qSpedPF6ZmAbZrlWPvcr7p2ex4csMT4=;
	h=Subject:To:Cc:From:Date;
	b=CSsW6ew9j+dsieMnDxBSrs/96XIwxou7FuXkX5X/7yoClECFuqYmybTh3g/yTM1wj
	 BYX0f+qkEnAGCtgpjPCCt3pbvKyeD18uKtPXWJBPtvP03yIB5D1bXJ0sn70RUeqP6U
	 YfGdgluyvhJ6YzOM7QdE6SHRZ+aadjCp2IcedYMU=
Subject: FAILED: patch "[PATCH] netfilter: ebtables: zero chainstack array" failed to apply to 5.10-stable tree
To: fw@strlen.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:48:35 +0200
Message-ID: <2026071335-dolly-tinwork-7a6f@gregkh>
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
git cherry-pick -x cbfe53599eebffd188938ab6774cc41794f6f9d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071335-dolly-tinwork-7a6f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

