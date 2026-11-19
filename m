Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795064929;
	b=KKKmcjemfG3nnPrZnxHpIciBEoiqHnJ+U7Fkhk2oVR85BVbBxpw0thZOwBviz1WA0SpP
	 Gkf3+gllfYs+GuWEkdBPF8OOhm3Yl35XGJ0e0B68iEYpBaNzlyfTqXAkl6zuOpf2nRNyC
	 zWyQBmmCMboVlz888NAQRB6PuozKsleVu2+bHtLRto/dI8W7O1oyqiCs4d+/hQyFfS/3Q
	 ZuxjXFcIZlGTLWX9UF9wjEC/ssP40zIIm7MkCw5oUdq9LMlHWFzxUN3JX08nomSGWvij6
	 65i8w4iKtkaugGJIz5sgkjOx796fBypZppK+hJ515llNo73nxmwWszUzYZAClMtOoSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795064929;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JsbfZY3YpWLLXS47DzvZ2q2Kiq9RcJQNoyxoisr/Mwo=;
	b=k7DGG3d6wLLEjW+Kax3aHoopKWaItk1q3UORuOJwJ3rBvixq1+Fk3aegioBUyXtQykHn
	 7hJp+92EjDNUowuDYuqrJkp5RurrHpyc0mAwVE99a861XJb71wt0QmF+O22f4Z1IEZmb4
	 XOO20FufJaMzh9tLh60/5hhVUCUD8MuFRs5Z8tFjzZR4wxOK34FK5o3jab4farsaVreku
	 5GFOyCZUlHcQHmiGETjuGYY624ty0yVi7UwJpkuG4DjQ4lgPlNMZDNxEaaKH0mgjnlOB6
	 cd8bL09bO+pgwUFeJj/mwu5/8VjKWR6Sm2Lbwu085PDgYb9E1zazx0xKOn9U84kaueA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OvL4dOcN;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC42606A320;
	Thu, 19 Nov 2026 05:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC42606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OvL4dOcN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795064897; bh=JsbfZY3YpWLLXS47DzvZ2q2Kiq9RcJQNoyxoisr/Mwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvL4dOcNp6G7yW3vYLDoGPVA/W81Kn9Wo/dkHdV+nYQN9FatSielf3ceLBZxuYeLX
	 pecY/v0li4SID7cUjkQVKYashEWxQ0mfpDqf+psV8l7A4LiJKdRn6WBsRDN4ZjlTUV
	 bH6kxfnNEYi5bxPG+0ccimBLBkH3H9TdgEvj0xqU=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 20E0EA98; Thu, 19 Nov 2026 13:08:14 +0800
X-QQ-mid: xmsmtpt1795064894tzj3vxw18
Message-ID: <tencent_46F20906773869221623F9FA26275C133107@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahL9Rdr7kBZOzUd7hBssibtBW4fxsYFWhzn7D8Sf7HKB89xOZPch
	 10V03tpg9+cy26bKqWWlouNaA27Jn/eUYrbStSxuWlXR98X6UzwDlsjSxvMH3yfEdVHYSUH8oVbX
	 RXiuN3/BHyPZybjZleWHnUhoPcwjVaN5GqO/aU6bzev9zzXz/IL4H5dhZ69VygR/8KuXtbCfbmZY
	 2dRsaWeE0L16T0gwfxqWn0fL2OHKPvRfCFn12GN6l5AgnGICougkR6S0syjbwWucZdjO4oaLazzk
	 qPx2/b5eBwmcCRbBlonCU8P7P7RXfR32+LY5+arDX6g6qucUU+XHs2Gvn0v//Vix72HhEBoh7e4K
	 gMi/CWhLMcGPICHO4yrJhqVXOBl5htc7AVhatLinSLcwk3yi759A7KBof5u8lx2ftdvVvNKtHxJH
	 ehpZjxcB+AE5qshvlsj5FylUk4w3BXhqzs0Saxi8SX6h+6eizTtnCoUohNYZiXjz2qPqsjcVwE+F
	 R/cNfEMWYUKee3KFuy6EbcXHHDNxMIXbBjhqgcCiMJ7QCSoNU3r+7kTFXco+muk57BaHgGQRhTKE
	 PrJ9FvdqWYF8qETmyzE6H+BRYjvYdZe44IT7RM4szLNlQCUzjJTiH15zKPmOLGvMHbJ3LEAamlix
	 sPeateQz240FWT2S6d6HBfeXVKmbJSEAojQ3tDVrr+6QfsiYO1jNA50H0cgbKdcZ2J6MkWraLee5
	 XhG7WL54KM08mFg/M+tdW8d5wcBIaytLh4RHa40VAdJfb5DrIcL3OHYowRIB5O2JZacc41J+slBb
	 I8zb0I97QL1mlBLZp5BSO5SGFLrrCgcsAgP7y4GPYIUHqOD1DCgI31K0G7TKATENlkcuH0weiAit
	 CZZWCjI7IYtKgrbIxC2MVHJ9zVCqP9VPxkm8kscAq+afyJpt4IsNBkFV7vd4D+0iT8HI3D+3T5eA
	 B98pmD6Hce4DPIZ0eBiY2D6Xq7C21pGENpTCWT3mP41LTDHUWw0vUGRDw0n26swdMXkkKUvvdM3c
	 LtIV+E3bQDqj4hRNITSBSQKhIh+hPB7+kcBMJbVx1auwVRpv8NpIGo6IzwDpfz2wPSTETo5kE73U
	 TVDT7vkV+PZYdVvItYCYaehwxSxtsKk7pBPnwq
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shuai Liu <847807867@qq.com>
To: netdev@vger.kernel.org,
	steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	q.h.hack.winter@gmail.com,
	stable@vger.kernel.org,
	syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH net] xfrm: interface: drop non-IP packets before pskb_inet_may_pull()
Date: Thu, 19 Nov 2026 13:08:14 +0800
X-OQ-MSGID: <20261119050814.1788751-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6afdcf01.ca6cd63e.174a34.0001.GAE@google.com>
References: <6afdcf01.ca6cd63e.174a34.0001.GAE@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP sockets bound to an xfrm interface submit skbs with
skb->protocol unset (0) and skb->network_header still 0 from the
__alloc_skb() zero-initialization; skb_reserve() only moves data
NET_SKB_PAD bytes into the headroom.

Since commit 86de3a1118a16 ("xfrm: interface: validate the IP header
on xmit"), xfrmi_xmit() calls pskb_inet_may_pull() unconditionally.
For such a skb, pskb_inet_may_pull_reason() selects nhlen = 0 for the
unknown protocol and pskb_may_pull_reason() receives
len = skb_network_offset(skb) = network_header - data = -64, which as
unsigned int exceeds INT_MAX and trips the
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason():

  WARNING: ./include/linux/skbuff.h:2856 at pskb_may_pull_reason [inline]
  WARNING: ./include/linux/skbuff.h:3286 at pskb_network_may_pull_reason [inline]
  WARNING: ./include/net/ip_tunnels.h:483 at pskb_inet_may_pull_reason [inline]
  WARNING: ./include/net/ip_tunnels.h:488 at pskb_inet_may_pull [inline]
  WARNING: ./include/net/ip_tunnels.h:488 at xfrmi_xmit+0x1844/0x1eb0
    net/xfrm/xfrm_interface_core.c:534
  RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2856 [inline]
  Call Trace:
   __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:5164
   __xsk_generic_xmit net/xdp/xsk.c:1288 [inline]
   xsk_generic_xmit+0x27d8/0x47a0 net/xdp/xsk.c:1344
   xsk_poll+0x326/0x670 net/xdp/xsk.c:1472

The packet is dropped by the pull returning PKT_TOO_SMALL and hitting
the default case afterwards anyway, so the only visible effect is the
warning; reject unknown protocols before the pull to restore the
pre-86de3a1118a16 behavior of dropping them silently via the switch
default.

Reported-by: syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=d29af9ef5c96a3f5e96c
Fixes: 86de3a1118a16 ("xfrm: interface: validate the IP header on xmit")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Liu <847807867@qq.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 9835fbe63ccb8..aa6e42c3e0e2e 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -531,6 +531,14 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	memset(&fl, 0, sizeof(fl));
 
+	switch (skb->protocol) {
+	case htons(ETH_P_IPV6):
+	case htons(ETH_P_IP):
+		break;
+	default:
+		goto tx_err;
+	}
+
 	if (!pskb_inet_may_pull(skb))
 		goto tx_err;
 
-- 
2.43.0

