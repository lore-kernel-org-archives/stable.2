Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019B416CFD
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550958; cv=none; b=PgL9Zl1FtyIq0SuMBNDv1h2A1NnJqcJOQ5QocdmdDO2LWUB+crD/IVzDRUCAo0338tsPReV895xAcK0hpyv84VHkUBZ2J9Kttov2y4wu9Mfu6hKffK/ILpvzOY2QqXCJKEVwZgnNZSjOvcbS9a0h6G3srWNO42O5EHV+eMNL8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550958; c=relaxed/simple;
	bh=+5PUwnZaIz/GFN0SoktzxGIub5fD0HJK5kCec+RAySE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nAc0RmwUAJr0A47rivZswKjrouvwW1sqSZDx9YZz4sUW2us8YxlT97fU52pCzJ8ptdWM2H12K8qG5IfPMLJh3oJBr5zubKvDWJvIsLm2cCE/DBy+nfurP9GJPEgzWZVDy1aYjealqvs0x2DHgjL3BlC1iMW3ecOVFXzOUX5lSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yZN/hYuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yZN/hYuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455931F000E9;
	Mon, 20 Jul 2026 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550956;
	bh=MXFHJYDHibBacdDhhfxGih8ABtLTMpxUQYj4Q48ah5c=;
	h=Subject:To:Cc:From:Date;
	b=yZN/hYuAZT4Ms+X1TxYLC44myMbx0NFbrNz6b8OOQv0De+HyT4k24GzZ6J/juxQbl
	 s43QYi3MNPaHh9C3iHExhiwI6d6ZaPdDT1D6esR0fsgGIQsX1E1fPGui/TD/1UmB/e
	 7hHvJZ99AVJpIdguXt2i56Yz6/cUmkP7dShIywUk=
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_sip: validate skb_dst() before" failed to apply to 6.12-stable tree
To: pablo@netfilter.org,fw@strlen.de,n05ec@lzu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:34:02 +0200
Message-ID: <2026072002-habitat-confirm-9500@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e5e24a365a5e024efef63cc49abb345fbd4852c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072002-habitat-confirm-9500@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5e24a365a5e024efef63cc49abb345fbd4852c5 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Fri, 26 Jun 2026 13:24:49 +0200
Subject: [PATCH] netfilter: nf_conntrack_sip: validate skb_dst() before
 accessing it

tc ingress and openvswitch do not guarantee routing information to be
available. These subsystems use the conntrack helper infrastructure, and
the SIP helper relies on the skb_dst() to be present if
sip_external_media is set to 1 (which is disabled by default as a module
parameter).

This effectively disables the sip_external_media toggle for these
subsystems without resulting in a crash.

Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Cc: stable@vger.kernel.org
Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 5ec3a4a4bbd7..f3f90a866338 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -956,7 +956,6 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 			return NF_ACCEPT;
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
-		struct net_device *dev = skb_dst(skb)->dev;
 		struct dst_entry *dst = NULL;
 		struct flowi fl;
 
@@ -978,7 +977,11 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		 * through the same interface as the signalling peer.
 		 */
 		if (dst) {
-			bool external_media = (dst->dev == dev);
+			const struct dst_entry *this_dst = skb_dst(skb);
+			bool external_media = false;
+
+			if (this_dst && dst->dev == this_dst->dev)
+				external_media = true;
 
 			dst_release(dst);
 			if (external_media)

