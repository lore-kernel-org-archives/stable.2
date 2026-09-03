Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F564B66E2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445474; cv=none; b=Hv77b0meiuLRyFZ4dcMFi+3vutBFSNHuPR1xvPZAunTG6JM03zA98HnL7z2qahGHhENlcngoxMHfdQVVnf+HU7Yci0iUCgyGoZAxeFeZ5qT2HFnOX6pGaYsqu17cD6yI6zdQ/tEHvQDoYxqSXLusyoIlMdVCDsZbnUyjj4e4LlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445474; c=relaxed/simple;
	bh=3aNPvqrQQngovu0sMNnBl0sysZfO5H/ypYkw3ehBl5M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TgVsKI5O6fbI88p9wSW9hUPP9XWrP/j9osqcVmWxvPyNqRgY1BKukWqWy9zgRArnEwqIcJBY+1Fm/LWAt0WJpHlAjkXepyJ0ISSf8c9We0skftyXSmItdyl+9NbNrTtnMW9nUWTC12ApcasXifMCpLY+L+B2tK4LCDvWYhdNiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tfuNm6HI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tfuNm6HI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD271F00A3D;
	Thu,  3 Sep 2026 14:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445464;
	bh=tC0Z5x+vtAdbsBZ3aPJFNAxWLjU3fLcnpIAxJfZFkNw=;
	h=Subject:To:Cc:From:Date;
	b=tfuNm6HIWRsUbJIm/dHjAupTPAkOqU0BgeNREYv0gbHNvyuZbIMls/24bygNpSza2
	 kqwUE8g7TuFyGpdACuI2bwU0Ulna+sDa9CIZUTUXYW/dhvWDBm/n1sPbuCr4SsyvvL
	 81mK01BbNEpNiJyqROFp4exF889vYcbHaXZzid64=
Subject: FAILED: patch "[PATCH] ipip: fix skb leak in collect_md mode when metadata_dst" failed to apply to 5.10-stable tree
To: littlesmilingcloud@gmail.com,fmancera@suse.de,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:59:59 +0200
Message-ID: <2026090359-reflux-womanly-dd73@gregkh>
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
git cherry-pick -x 6776efe4a52f289a3fc18f8adf19b035a7d8e1bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090359-reflux-womanly-dd73@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

