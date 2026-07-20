Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5D419307
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550965; cv=none; b=GMXuV9+S8ZyzkMW4Blsjrrr8cBdkVLvnecD2HinPhSGpCkqQE6IkZN4O6zsBpRyRE8nXdVWT6LFzmxpzbnpn61mlRYUazA+BzBJuVohKfVSAt4S/7GqOco4gLdEeE3J9ncRNlVBH4qaRj+5hl9Rf7WE+UKCtIiUWWRZCJ6rciLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550965; c=relaxed/simple;
	bh=P99gaKPJ2mIxgTO2cJ5yQkFIJBeD9bjfhTv825b8fmE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ujZ0sHIRjJhvuohk2o3yHpyXK+UKk1mse893jAqqD5ObJC8dYUzR6nmalDb2GfMNPhT1ZBAXnzDgHGmqXJDgmSzByH370t1GngjNx1nL/qj+KjTYXqiUskkDK6pIuHHWK+hMBTaKWHrvBDfRVmeD9+Hi3IhMfV96JkhjsAb/pM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HHR1d1mu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HHR1d1mu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322C41F000E9;
	Mon, 20 Jul 2026 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550964;
	bh=b/Ea406BWFPEP87/k6lCUCYlYECpcN87ayAfnYTJNrI=;
	h=Subject:To:Cc:From:Date;
	b=HHR1d1muYv3XuJOOLGjUReb04COTQ5ZpvBnJp/LomSJ9PUUZw+/dXHkMFaubnCpa/
	 6HDckxMedsYKBEom5z4v8dibXfKFK3jII1VNNkshoCJPjcqUK+X3Qt1A/UgE5CE78C
	 xO8/ZC6+KuxEH83zyQZoMKzzgeMDtGEWq+ctxRlw=
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_sip: validate skb_dst() before" failed to apply to 5.15-stable tree
To: pablo@netfilter.org,fw@strlen.de,n05ec@lzu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:34:03 +0200
Message-ID: <2026072003-quintuple-cascade-1edd@gregkh>
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
git cherry-pick -x e5e24a365a5e024efef63cc49abb345fbd4852c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072003-quintuple-cascade-1edd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

