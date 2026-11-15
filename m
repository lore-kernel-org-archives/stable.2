Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706674;
	b=C+fETRbdEnyJuuUJXiwmeq9HOLE1B8NGkHhQcTTmsZ7RpljXO60NRC7obNA4fBcz4VX7
	 kj5HRNCwJUzkRA3hJikQUs6M4btb5H84u1+JoMuBb5fU4vDeLGLcuc6HyW6uAU02qS0Wa
	 VOhZpOL0FA2GVSfhSNmBg/27wClaLd+mP81UBlhACFJ2kT4DhzmYqgcbtHTvwGvHerV6B
	 p4gKs7WCTBVr/k5U1m77EdTmrD6BK7CzcmLym+bQ08tsl4FDa5WnLPDm0MSH7STmXJFQT
	 0vDTRvx63cbk+LkQ+JwvDeLJqTVzfWZn0cNQHU8/zwJQ7L/F/4ZRyAovIoE46Rxh+Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706674;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qw0vchi07J5a23Neg8MphcsEqpjuPMnpEriw1d3MbJs=;
	b=r2+ww/E5ZIRqlmkiHmaYal8ClQ9aiEpagOo1x+hpnOnjDV0yj/RjBO/Tv28If7Ob9kwp
	 V58ZIwtMaMbV4kepW4eo6kDa11hldg9eeMlqGAc9diRzoUrB7zHiuam3R2pQpVj172hzg
	 qem29Rbw9dlG5S3bI3Hr2e0hQkwJIf0Lb7A3f8ZQ4LkiMevKHCD3btIGYexBOFhWEyHyz
	 X5/JUqE7XkTGROMGfyxi603dfTZvwePY95DVUONknoxMD/8HbdsVpk/M98Gj5KMFN0Ena
	 Y3Y0iA71N1qD6sLGKsI13pzuJZApUhe3v7z0EwiR9lMh6D3A+juAE4StgZJq8tv4bnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nC/G2+bz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB6606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nC/G2+bz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C851F000C4;
	Sun, 15 Nov 2026 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706674;
	bh=Qw0vchi07J5a23Neg8MphcsEqpjuPMnpEriw1d3MbJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nC/G2+bz9yIcooc+NuML8P1LILM69upNlLgCvfWu8TOXofIs2xg+jpaiqYILwhMU5
	 fV+gRtU15S86DLiRMpCazPE4rjg1VN954W7wQwHXnU9DyYyngwsy0avl+s4yfgiwLC
	 wNgD6UJOXTR8CS9QeJz3e2yOzlasVa8SzmaqPSdXhGNjSp0gCZUFn1dxLsTbHUrRVT
	 S6aU/TpeSPYr/VxWZayjN6cTw8i5lsrV9rWVijtg6Gum5d/t9TBS7s1xC6cncFMEhK
	 8GMEHB00Sl8EjZcCHZ8rNT04FvQVRjdtapFN8tHQ4x47ezbVK1vHAFf+eULvZ3xyZF
	 qEFmGUY/Xj/kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Date: Sat, 14 Nov 2026 20:37:52 -0500
Message-ID: <20261115013731.709166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202548-failed-5.10-66dfb2cacda7@kernel.org>
References: <20261109202548-failed-5.10-66dfb2cacda7@kernel.org>
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
index 6ec51b1a4e26b..e24e49cdf141c 100644
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

