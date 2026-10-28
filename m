Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203352;
	b=VgoGFscY9FcT0Il+ey2kjlbNPUsWZaGXbbvwJ/YfOvi42VSCY7ZIp63uHDQxjV2m2Rc4
	 LX/R8dgNiuItQcoCjVfwZybWEaork6pikW8LJ2IVM3puN5CKuKZ8CsBQ1We5u81snhAZ4
	 PCV4Zqek1dUyOAleVo8MP8q8Oy/xoMZdthXX+wJYDlIpxlk0IQ0W7TBzyS42VNA2B2LAT
	 /KS8fa7xPs+HwfxVmNS/smEtshcuWYQuCyxvHY5XTC3TUknHD9WzUqb6e029u9ahrfScj
	 talGqHluO4sVQ6LvHrc1PFChfxLm6Z3A83Vxu+IR/WvkvVZTZLYNpvXKK75CyxapJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CzKE5iyUgg+4SzFYVIEIVG/mjsLgAPdxq5ThukfklTY=;
	b=kPods+NCFLUV2HAJi3PPd+V2DdkqqkKM3pJZLv+fqnWA613fsL+Yyiy0E8s0XwebbAua
	 VrpsZQB9/t8DzIkgUwbf6jvkV9YJMSEeM9IRVk6tkaqplPb7yllTE8w09guicrVypjxD4
	 8Yl6poUejVHfK4XdGRt9xt82bwRT6w39/uyRl9F4DiuCWg4dXcN4kTZ8jdTmVpC3PlT3C
	 1hKOkG2jyHarda/QXLJ0k/BiJ2w2yeoO+aeSSdNP3OaP/UlA7o6zjVaENrITb9OQvDepO
	 yuGrLKSmH4ZSOJ11gM38AIXmdIZYti2Gz7Na7SjfTuDDHZoV3xKXDk6oQbeu5Voy8PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRYlUOGM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2B606A31C;
	Wed, 28 Oct 2026 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRYlUOGM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3B91F01825;
	Wed, 28 Oct 2026 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203351;
	bh=CzKE5iyUgg+4SzFYVIEIVG/mjsLgAPdxq5ThukfklTY=;
	h=From:To:Cc:Subject:Date;
	b=kRYlUOGMLnUjnInWGPozm2b00L3DNEyCG+d12mx3gaRN+oBRmnc6yj56tr1F7UP63
	 5T4x+DGzXOCDQApMIcSUojfJCm8ItIxRuaQYtemd/EaCepafUbl6q3zkOp8n+qetrh
	 3aPs2rmmZgZWhuW6TFUyPMLwaRlD0NT6jAnRGPyMpSDBvN3NA+CxhLIR+JQu0+fKd7
	 ymQ56Ee0eZry5ihgUWvgOKgp6HS5YazJxpGsc/jQjZ+frW5V0W15oaxAsU5U/Wcwd6
	 Vf0rqS66LAjjAKPTMANgLMZdpmXHCKiwsUSJMvw2MT9pHA6FT5c8U4G9cWekBTNoGR
	 xSjc4mC5DgaUg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] tcp: fix reordering addition overflow in MTU probing
Date: Wed, 28 Oct 2026 17:02:26 +0100
Message-ID: <20261028160226.2170244-1-edumazet@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

Commit efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and
MTU probe sizes") widened size_needed and the MSS multiplication, but
tp->reordering + 1 is still evaluated as u32. RTAX_REORDERING accepts
an unrestricted u32, and tcp_init_metrics() can install U32_MAX.

In that case the extra-data requirement becomes zero. A write queue
with probe_size - 1 data bytes and a FIN satisfies the sequence-space
check. The coalescing walk can pass the queue head to
tcp_skb_can_collapse(), and tcp_clone_payload() can produce an skb
whose advertised payload exceeds the data in its fragments. Local
delivery followed by TCP_ZEROCOPY_RECEIVE can then walk beyond the
fragment array. KASAN reports a slab-out-of-bounds read in
can_map_frag().

Cast reordering before incrementing it so the arithmetic handles the
entire u32 metric range. For U32_MAX, the required size exceeds the
32-bit queue and window limits, so the existing checks skip the probe.
The calculation is unchanged for all other reordering values.

Fixes: efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes")
Cc: stable@vger.kernel.org
Cc: Wyatt Feng <bronzed_45_vested@icloud.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c8865205cdc8bacea4e37f67eb60730cb17294aa..39803b874c3373ca635454690a445ba072c05a62 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2720,7 +2720,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	mss_now = tcp_current_mss(sk);
 	probe_size = tcp_mtu_to_mss(sk, (icsk->icsk_mtup.search_high +
 				    icsk->icsk_mtup.search_low) >> 1);
-	size_needed = probe_size + (tp->reordering + 1) * (u64)tp->mss_cache;
+	size_needed = probe_size + ((u64)tp->reordering + 1) * tp->mss_cache;
 	interval = icsk->icsk_mtup.search_high - icsk->icsk_mtup.search_low;
 	/* When misfortune happens, we are reprobing actively,
 	 * and then reprobe timer has expired. We stick with current
-- 
2.53.0

