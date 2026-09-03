Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DEE4B66E1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445479; cv=none; b=C8aaFnEORqQCFdFYnXGC0GFJIjnJ+aC4bVjja2ba0SlXk9E0+1hxQ+sp94tB4wZHOdiNPh7lUTzJTJNb0ZP5vOEa3zMRIpZQljIjCM38KwFvs60YkxEiCY6ommyfWAr72hDQMrvL43vUulyP9uk7GW5hDLKzlCVHM2gIjiJK/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445479; c=relaxed/simple;
	bh=W1cAsqF3xvbjryFEJQEpbz+Q91+25wEJNXVvo02c2co=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WKiU2Dq+SVXhYQKUv+AXN7h87iuYgq0S3lK4+7YQMcnANeNMLUWUeU+OdQTglL3sI9deAA5x+VkkdlZNJF6pyFNFwj4cUJFaP1e1hO3+dqZcwPvjN4fKgeMRDLcMDADQlhfkifAb6ByXYal+CVasP/P3qD0c3MW6dfPWzk5WscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i0VRKfl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i0VRKfl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B819B1F00ACF;
	Thu,  3 Sep 2026 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445467;
	bh=ACrNXXTOeaVsuh0JOHDAb8tyRE4YzAv2/5cMarJvoVE=;
	h=Subject:To:Cc:From:Date;
	b=i0VRKfl0PNTKQpE9UJiZiqfxwQ5OxFhZFJ2AHR5iuSusM6vK1n/qY7bxpy0pOwAW/
	 DzRSjVupgotcoLDDX+Dw+wEzpB3oWU9QXbAVebJJUxugSBHeQFAD4QJL/WlU2g2bMU
	 /mZoUJEeZpl12YCbFBZ4txB70aL1QKAmqICa/PKI=
Subject: FAILED: patch "[PATCH] ipip: fix skb leak in collect_md mode when metadata_dst" failed to apply to 5.15-stable tree
To: littlesmilingcloud@gmail.com,fmancera@suse.de,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:59:59 +0200
Message-ID: <2026090359-hurry-disagree-2db4@gregkh>
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
git cherry-pick -x 6776efe4a52f289a3fc18f8adf19b035a7d8e1bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090359-hurry-disagree-2db4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6776efe4a52f289a3fc18f8adf19b035a7d8e1bb Mon Sep 17 00:00:00 2001
From: Anton Danilov <littlesmilingcloud@gmail.com>
Date: Wed, 19 Aug 2026 13:43:39 +0300
Subject: [PATCH] ipip: fix skb leak in collect_md mode when metadata_dst
 allocation fails

In collect_md mode ipip_tunnel_rcv() returns 0 without freeing the skb
when ip_tun_rx_dst() fails to allocate the metadata_dst. ipip_rcv() and
mplsip_rcv() are registered as xfrm_tunnel handlers, so tunnel4_rcv()
and tunnelmpls4_rcv() read the zero return as "the packet has been
consumed" and do not free it either. The skb is leaked.

The other tunnel drivers all dispose of the packet at this point:
ip6_tunnel.c jumps to its drop label, ip_gre.c and ip6_gre.c return
PACKET_REJECT, which makes gre_rcv() free the skb. Only ipip returns 0.

Jump to the existing drop label instead. It frees the skb and still
returns 0, so the packet keeps being reported as consumed, which is what
we want here: the outer header has already been pulled, and neither the
remaining handlers nor an ICMP unreachable have any use for it.

Triggering this needs an ipip or mplsip tunnel in collect_md mode and an
atomic allocation failure, which is why it has gone unnoticed.

Fixes: cfc7381b3002 ("ip_tunnel: add collect_md mode to IPIP tunnel")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Link: https://patch.msgid.link/20260819104338.432631-2-littlesmilingcloud@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 1630325c77d3..f684baf8e58f 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -248,7 +248,7 @@ static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 
 			tun_dst = ip_tun_rx_dst(skb, flags, 0, 0);
 			if (!tun_dst)
-				return 0;
+				goto drop;
 			ip_tunnel_md_udp_encap(skb, &tun_dst->u.tun_info);
 		}
 		skb_reset_mac_header(skb);

