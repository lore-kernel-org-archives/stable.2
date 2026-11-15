Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706174;
	b=2R7KVH8QkCRyRMRUsXiYziiSwg2U2H93Iv46QFjV9fCbX1sEGUqswkD5C3EvZVByOnJB
	 HhPAJ25Nb/CiueysSBphSw9fCPxr6PTKhh1aijdGyMMFeeEZDnro7eESccYoMtGyDjt2q
	 83X8dkfNgg2Ot03rd0EaAnJKEoyOlff7IOrFrmnCUIa7P6X/8UO/XF5vrk4KdY6ZWN6Zv
	 42ahp8aOYSfj2WrXTm7FzSKG44VD83u2vENeA6vzgzeMHgLjcACHMaFBpwYGe88eFIw5m
	 JBYFcticMXxLjfKxkxXpkPssHaxA90AC8/CiC9al3o9pEmnjUm3YYMt1mjEBrCDnGPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706174;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pr1/5h0sh6TbBZVZLb1G9TfsQmujR5rS1nffbcM0bqo=;
	b=eyq2uiGaVSubsvrWA5OF/MYf9sUI2qsZSDW3G2M2xUL9pLw29kUIicVp4trq6+YObfRz
	 IRcC4tljd2Hm28SkytPvWiLa4Ci1JwruPalskwQOyLpp7ub9IoCODIXjgUthWlCQE/XuK
	 mqlYwaaYXWpmwQ7HzAwJXEYhb7ak2oCVKzuKa1MFTY1EKwuo+IC0OgescX/tV2RhAzNUc
	 QRwb/QfX33nTAShzJ19Zwanu8l527xz6Y0af8f9He4qY8UfrEYZJvlLmeYwYyOm8wQ/s1
	 /WLf9wa13fpcmX0LZMT7xl8+KlhefcW5yzNdyrVTs5T7m92RiSUA6vIZjvFs9pl30ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndjZD7nP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11504606A88C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndjZD7nP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542381F000C4;
	Sun, 15 Nov 2026 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706173;
	bh=pr1/5h0sh6TbBZVZLb1G9TfsQmujR5rS1nffbcM0bqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ndjZD7nPFv05wEHhWrRaIvKdV2w3/mo67N12duyIiikGresat2PxZPiYA2qSy85Ag
	 RgIKMYinXhnvNS8ehv8iEX0u/z9LxT8HDlSnEB+ZR3BI9uhzKcfE4S48N+O4i6wI7I
	 qKeLtYBE6AfpUWDuVOWs5Tz+3mPPyyL9bH2nsAKGDMsLkbbXlG8jZH3ZowAxAH5h4P
	 GpgF/lubxjDhvOLrDj6TfB7sO5gnfmu9NNo82nFBpAtqrtjW2/lvsmkME2+pXRcTve
	 /8RS56mvWML97LmjOEj5f1ro9HSo6US0jBbcYiVMY5UXpmTMpHCABceNdkuRWROJ2C
	 gvANrqZLuh+4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Date: Sat, 14 Nov 2026 20:29:31 -0500
Message-ID: <20261115012900.674278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202038-failed-5.15-66dfb2cacda7@kernel.org>
References: <20261109202038-failed-5.15-66dfb2cacda7@kernel.org>
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

From: Zhou Qiuyue <n0ps1edzz@gmail.com>

[ Upstream commit 66dfb2cacda7faae614d688943d85e75abf7f586 ]

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
[ sashal: Replaced the unavailable dst_rt6_info() helper with a direct cast to struct rt6_info *. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/raw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index c3719e5ac89fc..2d72f5c5d8381 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -650,6 +650,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	if (unlikely(!skb))
 		return 0;
 
+	/* l3mdev_ip6_out() may have replaced the skb dst. */
+	rt = (struct rt6_info *)skb_dst(skb);
+
 	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
 	 * in the error path. Since skb has been freed, the dst could
 	 * have been queued for deletion.
-- 
2.53.0

