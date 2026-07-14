Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21B496906
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044708; cv=none; b=cc0rPclHBENK3oeeCQczbyAeItfPAsTaCXR0bLhWUI4si+zOE9dv/UJ2KLYqIq3RTqdNyYSmm4e3/ENcMnjxKiYoZHetUgrapdMAOTZP2k5qzyuytLSpfWfou3HjlGtOxn17ZWDjxYNx+ahjdBDgvSSP1L9GGElx11Dh4pFdqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044708; c=relaxed/simple;
	bh=JVAB1nTQHv1aRIiv9O0ICktJKmg8epzDhLy+BNazAfE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BICsJKHjDFhRJLx0ItqLb1BO0ta+/+GTPS7h/kv18QWJ7UtrKATx2eTROONQVhSS9Ll2pqOotPPH760c3daprMNCrnKPDZ4dbB9lqa0gtAcq6EVXEzunY+5Z7f9xxpjQtAPG4ix/Vb7SfiFPreXvhAuW39sLn5sAzUm1/zoj8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FITkPp1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FITkPp1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD41F1F000E9;
	Tue, 14 Jul 2026 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044707;
	bh=nvKE8mXHRL0r9nwdheynKDO2YJrsEeZRBG+whXNTgxg=;
	h=Subject:To:Cc:From:Date;
	b=FITkPp1taFJswJ789m7iY0V+hZEihvUqqXqHrmfJtK/Ma/AzxpIx4EBs4bV0TxZOo
	 8FqWdO5UFX+RkOuZ1hBU467TFr/yqU43RahKKhoRO7pL0UX/9BMwTy87VQR7S/S5Nw
	 mvrBE92gtNDtKDMleBQbvHIT7K4FOcQ0F4Domzko=
Subject: FAILED: patch "[PATCH] bpf: Reject fragmented frames in devmap" failed to apply to 5.15-stable tree
To: zzhan461@ucr.edu,ast@kernel.org,bird@lzu.edu.cn,emil@etsalapatis.com,n05ec@lzu.edu.cn,toke@redhat.com,yuantan098@gmail.com,zcliangcn@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:58:21 +0200
Message-ID: <2026071421-video-bucket-8e49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x aa496720618f1a6054f1c870bf10b4f6c99bf656
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071421-video-bucket-8e49@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa496720618f1a6054f1c870bf10b4f6c99bf656 Mon Sep 17 00:00:00 2001
From: Zhao Zhang <zzhan461@ucr.edu>
Date: Tue, 2 Jun 2026 16:43:33 +0800
Subject: [PATCH] bpf: Reject fragmented frames in devmap
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Devmap broadcast redirects clone the packet for all but the last
destination.

For native XDP, that clone path copies only the linear xdp_frame data,
while fragmented frames keep skb_shared_info in tailroom outside the
linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
without valid frag metadata, and the later free path can interpret
uninitialized tail data as skb_shared_info, leading to an out-of-bounds
access during frame return.

Reject fragmented native XDP frames in dev_map_enqueue_clone().

Add the same restriction to the generic XDP clone path in
dev_map_redirect_clone(). Generic XDP represents fragmented packets as
nonlinear skbs, and rejecting them here keeps clone-based broadcast
support aligned between native and generic XDP.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..5b9eac5342a9 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -581,6 +581,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_netdev *obj,
 {
 	struct xdp_frame *nxdpf;
 
+	/* Frags live outside the linear frame and cannot be cloned safely. */
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		return -EOPNOTSUPP;
+
 	nxdpf = xdpf_clone(xdpf);
 	if (!nxdpf)
 		return -ENOMEM;
@@ -726,6 +730,9 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 	struct sk_buff *nskb;
 	int err;
 
+	if (unlikely(skb_is_nonlinear(skb)))
+		return -EOPNOTSUPP;
+
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (!nskb)
 		return -ENOMEM;

