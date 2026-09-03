Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389594B66E7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445490; cv=none; b=ShWqJX6ejBydpYdmxcQpl2pgVEHIXArKNZnS3cGut8yr8Umc6ztVVpQkaVhznmDVpsTfpej9PtBzNPnaKe6rEiqDIuHApVE65fCPoMUTM+BAqlWcaNdwYoIN9zD0hqRDxBi83Gz+ICAC40URar1tPzXoCOWeaxxqw7kXDWw7hzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445490; c=relaxed/simple;
	bh=/4yF8qkbM6CT+JQ/yXeJJ9AIO42HGEETujVZTEHuTGY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lRd5rxaifJ55vlzNKQbN5SqBL7dW9WFrVUvBFaTVBIj8oXQA5oww64lNfkD9/1SIQ0qNmw9Um/g+Pl37SI3jjVA31YE4Lx1sVFazoSnvEYak+/y4eKZWys/4VCnlm1lRdEmv9ldMx6ZQIs9PkWeLQ++4zYICIpC2WE95M4m22ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UrCHiL7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UrCHiL7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3A71F00A3A;
	Thu,  3 Sep 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445481;
	bh=zt+54kqa2ZFQNN1M8cuJYoBNkxuWcgFSnfdw4jyXwKs=;
	h=Subject:To:Cc:From:Date;
	b=UrCHiL7YJDUr9gz5bc+yn+slg4P8pNbGs+4KA0sLD6aN9UFFbA9eSOy80B5MT3Ssm
	 S2u5X8J5bO+sgUjJT/dBXupihSPo7wUTu7b9G7Gs284//+M0CB6bZM5Y5//2BT4Oew
	 6Q4qRSjkdZ1uv2tuVz3XxbCbRwZ+0FaTGiJOKPbA=
Subject: FAILED: patch "[PATCH] ip: orphan prefetched skbs before multicast forwarding" failed to apply to 5.10-stable tree
To: zhilinz@nebusec.ai,idosch@nvidia.com,pabeni@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:00:20 +0200
Message-ID: <2026090320-tiptop-scrooge-9ea0@gregkh>
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
git cherry-pick -x e36ce6e78fe3fc3c071a26750783b7ba081ce10d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090320-tiptop-scrooge-9ea0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e36ce6e78fe3fc3c071a26750783b7ba081ce10d Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Thu, 13 Aug 2026 00:36:38 +0800
Subject: [PATCH] ip: orphan prefetched skbs before multicast forwarding

IPv4 and IPv6 input preserve an skb->sk association installed by
bpf_sk_assign() so that local delivery can use the selected socket under
RCU. Both address families can also prefetch a socket in UDP early demux.
In both paths (BPF and UDP early demux) a reference is not guaranteed to
be held on the socket.

When a multicast packet is not locally deliverable, IPv6 hands the
original skb to ip6_mr_input(). IPv4's ip_mr_input() similarly keeps the
original skb when local delivery is not needed. Either path can put the
skb on an unresolved multicast route queue or forward it after the
receive-side RCU section ends.

After the prefetched socket is destroyed, a later skb free invokes
sock_pfree() and dereferences the stale skb->sk. Orphan the skb before
each non-local multicast forwarding path. Local delivery retains the
original skb; the existing skb_clone() calls provide multicast forwarding
with a socket-free clone.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fce..e5f2b1c6150d 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2213,6 +2213,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8972863c93ee..d332ec60f915 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -622,6 +622,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}

