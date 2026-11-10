Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273640;
	b=XFs28WQn76ZSXe8KliWCAYN2Sdtw/gH+XZ4quiREXHwPVoITkbhHY82ziNJ6GAO4II40
	 g47c5FYBrBHgOIQyKUZYK8D3FgM0aQhhJ8iZSpiQQJk143G0oVXJZA4L3/UbQOTFkbC5k
	 IkQAptpWdv7gzwa8pX72O3GNoVzxLD96F/or2NvDhAVLLvMXlTQLHkSTuwio3Yio9F+Ng
	 gZYK2Rdrx3pnrOcp00GYpOJj/+XPf1D/OnbljLeXdLtVy/Wgt7d5p+BneedqLgx+kfEX0
	 KWk8Nz9/vBlkMtUigP1B3IwC8X++1j/BjasyE/zy/A5MgxSRxUQ0NJvBnTX4P+9tldQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dy/06mplnkZK6bKol5Qgs8Jt0t6m9TXIIXNprA9tA/g=;
	b=lgWcB7s9Rl9irWWWmwPy6XqB1/P8ETaq+pghGUkAO9q+kN/wnFapCOu75R7CQYTM+W/+
	 e+TVx60i0KltUZhsxAcOdEDEfEqxupZB99pNmeTW4YAtXJqA+mbQy2NfQKmDoTdJdzXTL
	 7+HV41Q3tod/LoJSgKxlUAHTl39fd4k4ImyWH7DjnNDElCGbeRehpL0yf6hIBxxtK7Mzv
	 Sf3o4Rn6uDJni2HCJzodIHQUugcgBp6rcQXuYY01hiR2CjO+oJKP1WbOF4xvZK+UMstm4
	 GhlzhpBUDNKAyx9zl1vBwy3S05BsmufpdiPkbXKJsBdlar+o4naq8NRDWKvtc5fv/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERVhvDRa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD6606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERVhvDRa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9481F0089F;
	Tue, 10 Nov 2026 01:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273640;
	bh=dy/06mplnkZK6bKol5Qgs8Jt0t6m9TXIIXNprA9tA/g=;
	h=From:To:Cc:Subject:Date;
	b=ERVhvDRa7RQrPMqegURMuPq5N8IfTMl6tiwUCRG7+wnwV1h+JRB9ODZxkrLQNtnyF
	 e3szwhg96vpKbpVhj/+Z31915jBYjnMcz+PkxX473Gqtql3jhmtewGG4w8TMNupg1X
	 WC/skOnNbN6VRPI9yerAaLA6EJAWv+wNu2qnnX+2BRckMTYz/zzO/PLg/ml93Feeb7
	 nIXVCZ7rWssc+tk3c5TU4YG9rMicXesGryIMRgXX72/4b77ChLziK3Z2oZI1wvtadr
	 TxgPz6IR1tq0x5AzhonL/SrW4OL89OmS5pKxayosWKbxYVx7Ctgs07rXEKckO1duHB
	 lcZF8kARnSdbA==
From: Sasha Levin <sashal@kernel.org>
To: n0ps1edzz@gmail.com,
	liuhangbin@kylinos.cn,
	davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:38 -0500
Message-ID: <20261109202038-failed-5.15-66dfb2cacda7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 66dfb2cacda7faae614d688943d85e75abf7f586
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202038-failed-5.15-66dfb2cacda7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 66dfb2cacda7faae614d688943d85e75abf7f586 Mon Sep 17 00:00:00 2001
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
Date: Mon, 26 Oct 2026 12:48:08 +0800
Subject: [PATCH] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

rawv6_send_hdrinc() caches the route before handing the skb to
l3mdev_ip6_out(). The VRF output path may replace skb->dst and release
the original route, leaving the cached pointer stale.

The function later dereferences that pointer for statistics accounting
and as the output device passed to NF_HOOK(). Its RCU read-side critical
section starts after l3mdev_ip6_out(), so it cannot prevent the old route
from being reclaimed in between.

Reload the route from the current skb destination after
l3mdev_ip6_out() returns.

KASAN reports a slab-use-after-free in rawv6_sendmsg(), with the route
allocated by ip6_dst_alloc(), freed by dst_destroy() from rcu_core(), and
the related RCU callback queued from vrf_l3_out().

Fixes: 4c1feac58e06 ("net: vrf: Flip IPv6 output path from FIB lookup hook to out hook")
Cc: stable@vger.kernel.org
Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>
---
 net/ipv6/raw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b965258cf9e5f..bdea825434ea7 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	if (unlikely(!skb))
 		return 0;
 
+	/* l3mdev_ip6_out() may have replaced the skb dst. */
+	rt = dst_rt6_info(skb_dst(skb));
+
 	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
 	 * in the error path. Since skb has been freed, the dst could
 	 * have been queued for deletion.
-- 
2.53.0




