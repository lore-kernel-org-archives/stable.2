Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273951;
	b=3+Dw/mo1UG0SdpV9NwpWHwsg7BUI4t7E0BX760cUpmce52W7hSuoBAj9BSYbh08MHnj8
	 vKfcV8SH3MkWvMGvqpwP94fbTkHhNLXBvju1AukXKMUP4f7n1WL4xpQ4zzAX4+N8cAqCO
	 f1+MfB6TTqQRFISBotmMKrX0u0hxLf89USpVrW2KIJrmcNkHRjSNNFHGixW6VDWhKLt1n
	 7kP1M+YySZgEVhGbYispHeJbCtdSoBZz0PFgJDGIC6yxR14AczjOx6NPlnmfd+MEwEXMa
	 6ETWx4Ncj8QwE0zSR2VW544ZqJ/uhMHKnSOEobalglws4Wya8o/c85b7AflfUL8NJ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3IJUrFHhFchAa4Y2a2xH3xy9OWaZ9gsj4eIi7kftlss=;
	b=QlMUOFc66Ia0U3U1oT5BMihcKgTY1goINPAPsYe2C3lrxs3On5tx3MpchvLKJpdNwKZV
	 iUHRzMkyv15pQxu4BNGNDNMDhFojQUrt+/zlSWnaOMwtQzrmBPkpsEr/S1VzT95qfSZvn
	 /ZlQMcvqUU2nTNk9+a4SX+Q2EaO8INh1n9Xh768lKBAkbmsgFrL68EX7LPlFB8TUtTcGa
	 ANA/H5tvwIXgOTEX0dbGauQAn3jO/r1YFmmkldCN+Lbs7qFNqtxuWZyjPFzCnahmhR8j4
	 0uCimkLmJ3HOpROWJEJippddVj7VogVacOtfFkiZ9OcHflEbU3mfgeXEBd6jSEzZycw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IejczDDg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IejczDDg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDA61F0089F;
	Tue, 10 Nov 2026 01:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273950;
	bh=3IJUrFHhFchAa4Y2a2xH3xy9OWaZ9gsj4eIi7kftlss=;
	h=From:To:Cc:Subject:Date;
	b=IejczDDg2kvOVHWo7g8JbmtoBvFIA56Le6g+WxXMc3E19IQ+32mAzAYZkRCB+Trsw
	 LrIyOZ/8TJLLloUpgccE6nce9gik5fxLKwf0LgbuKRVpIEH5vQ2z4qn637xP3SjsXa
	 6RJDXUX/EuQVpnBSl+XwGfBfOG+bPtFEKp0YEjWBBEtO25lATVyF/trDBBECmPwy5i
	 QZFA/ExKDT+JyXB+hJRG2MBqEB9EjSQHjX14tFJU4+6ofOXwp3x/yJdEHbA86m/9g9
	 4vVYH0Y1WrRiDHFwggC+7B+6jdXcPxZCtx7g1uNI+xQf8/s3TpaWYCMVJXKwq1ZZ/+
	 R4JKBPfWRoVcg==
From: Sasha Levin <sashal@kernel.org>
To: n0ps1edzz@gmail.com,
	liuhangbin@kylinos.cn,
	davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:48 -0500
Message-ID: <20261109202548-failed-5.10-66dfb2cacda7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 66dfb2cacda7faae614d688943d85e75abf7f586
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202548-failed-5.10-66dfb2cacda7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




