Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9689437440
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951127; cv=none; b=FEjZsPeuWP/n7pX7eLAnSRwCKDDvvYnihBG3TqV5hc7SHMzrn8LuN0H7ZurefmuMIaiozShRxM8APAjUuiMltBJA7A4MlpXJMBJ1bCvWB1Iz2J6h04+djyNXgeN1rvi7qcy+wKLFWffx1tnQSPgBusMqN4Zft4G115aZXv3aI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951127; c=relaxed/simple;
	bh=OnybZcynIdt7zNyVpfLogG+WnBlEen9/wo8sEeXFAVQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nR420m7+3zkfj3nSgE8KDUAM5x8qBAMqVGRZXdxtSHOCYA6xxaTi38lL1krLHeRhumaMQ7pevTHQQnuT9NE7Ds6qgX/HbvWqladWvSoBxuRzBZfJTFCLnK9WkAE2WVL6t8PcXLR7gsa5oMgg/zMUHERdqOsHnTkE6deuovz7W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCW+CkFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCW+CkFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5949E1F000E9;
	Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783951125;
	bh=9QHliI0Fc1x1uQ3N/7M/nTKcTgsj1CwolCJ+yUEb1Bo=;
	h=Subject:To:Cc:From:Date;
	b=rCW+CkFbh2E2lvXgG+1zhzczEhnkhRm0hbf16oG5jJGeNllR2HfyFn//OIFhqAxCK
	 q57PjP8QXJKZ2P/s8s7jMLwoVvgBwk6PQvi9/jbML7ulG+Ll3b8KVcxIjs7jWFLPJi
	 u0V4FlfO5xrI2dpjOKhLG95iIExuLNwfIFXK74LY=
Subject: FAILED: patch "[PATCH] netfilter: ebtables: zero chainstack array" failed to apply to 6.6-stable tree
To: fw@strlen.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:48:35 +0200
Message-ID: <2026071335-exemplify-sheet-ddd5@gregkh>
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
git cherry-pick -x cbfe53599eebffd188938ab6774cc41794f6f9d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071335-exemplify-sheet-ddd5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

