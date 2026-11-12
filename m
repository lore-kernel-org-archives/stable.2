Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487561;
	b=RJY76POsFOewTAuTRxoAoy8pT76wsiTbSRJRRbCXaVUNxzJXaZ+CDCtbet7Sm+yus9AY
	 EsfXJ0QiCIuxW8OYqgAwyG14DIKcSv6a4/zf6/r+g2S1j3359yZOQ/J4S4XyCbF0b3Rdl
	 q0aInsWo+oniEnD6d522qWBdzLROPLzYkc8tuLD/lRxLoCi68/yTUjoS8IWOC+ZyD4oYc
	 BnvRAltoWqvR3jEgIQt5pPbJneOyY1r44PFFE7JNtHzBJSqCLsO+rc+42tURIXYgkF+16
	 yZVMtYr3Kgoq4Q25Hnr+/IhFMIl7qPSCzRPe26IzGQXtto/Ftatgznp78AFrdReIdxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487561;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JqmpB5V0UJQajlsRMfwMtixeo10RY8jo/QPsCgZA0d0=;
	b=b3dzz9z2n7emlKqMtREzWZN49hI3KNvGZTZJUqEkd4rcOsmyEvdwg/q3bvkKsWMeT4CG
	 SoUVb9fn/c9eyeCYEGzZVXK9j/qiehDOXFXG2d6JuaNZ1blgZieYGUsaQxDU1ZciOgT7Q
	 bbgMhSUgmjmBkVAeaOWCq8d50ovCt189Mw+TIS4et+kYo9vTTKMIH3pzaXgxolNhg/ikC
	 M7mALEd3GnzHJqMw8u4Z+iqaBO5X3Z9svQcgqcvZH9ShuX+yHJjoagRNqoSpAXtvComMT
	 +06avzG5mqnOTe/qW+C+lH/O8dXPLRnegazlWtwLTUlzUzUGwEbgJh07u1mNnqEoPag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kHo7EZ9U;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E9606A337;
	Thu, 12 Nov 2026 12:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B33E9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kHo7EZ9U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794487554; bh=JqmpB5V0UJQajlsRMfwMtixeo10RY8jo/QPsCgZA0d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kHo7EZ9UsL2ZrfiBY3IxAXLVh/7LfYfS/9OXzo01hS93BHitatOalsEMlJz+LKSR3
	 9r6dmZYUNocP59fmhClhPmTXggdtiapklkHUK0feo7i3+fvD60JEdF5/wf/u6uwvav
	 2cmNa3jcNQWAeBXFJ5WMV7D2jMSk2U2TuBHmyV7c=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:e498:8f16:a485:ceef])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B70218AE; Thu, 12 Nov 2026 20:45:48 +0800
X-QQ-mid: xmsmtpt1794487550tmaw77872
Message-ID: <tencent_28A2BD1631FE531992E91753BA6419FFC506@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJcREJkrvuUFCtWib1OPE3zJrun6iOGxYUjNRmFzinPQeY3ZFj9S
	 OX4fwCIbRte4ky5NM+1mQIpDpYXMEAPAg11hBuagfwLa1TBspC05uwLz/ETALXv733TijF2W3Gap
	 8yAF4dRmgBf95NTm/++pIqRvKMBdnnSlvyCACGB+KSflIBwtrn3SvXbT05POgLOZeVbMOiuGJ9K+
	 o9+gUaDZFcbR5d38K8fftjmLoXgDXNSh+KKhpfj33PoNOsO9fRJtfKLhA8hHd9HPNgkHfL5QuVs8
	 R4l8fB0+pqXc7jisR90iPKm81JfrVGDDeFBa/uahvlbulpztdTzj90QwPndR/iXWdzSVoWcNk4bw
	 gD+JMfCDT/119EsJw/lRRk3v9RyjQu62/MM7yBRi2IhLcgr+BZlTN6XHey+rVyVsuv5JRi+JfxDI
	 tDaeO46iVuJ5o1iEVwkRX9bbc87A3Pc9ej4GHUs2d9cBoNRG5o9WgiqHTdREjki3HWdv/uOvYSQy
	 qsENugSnGl1fJjsE7IRgswk+6vSJe9ZwIx8M2YM1kK8q9vJxK8LuX/ogtmXeoBisrp/GzOamBcEm
	 CGmDTB0Gtub7yd5gGp+Jb4wwfFjRFYExJddrKH1vIzbBaLl4S2Xd57fpiNjyMSWi0hFv1R0a2yOg
	 SpGiLh4eLB8qfWg6zQfvWr5umkgUsQlSeS7mZ3AnDiuq0+ZaVZ8i4ZUTtqOwIwnfBbRxpu9Rj00h
	 o4Kilx/RXdoilxSzlmwBbQ4VRnlUf9jfTgLcf0Of0Ci6FcXxwV5oY3HKbOHi1BP4S/3+Q33rYMGL
	 AdGnGOau+CXbniPBBBx+iHpEGKUA/KfkkhyN+/i8JeRITEnFBAFO9l2lkrIs+uENySnV1OMhWCM0
	 RHxIheVMo1q5MEo1AQme/Fi1YYwSwZFpHwkKx6tx9NNfNiHg9TJ62NJkc9KnfrY3jo21APCvMrAk
	 4w01dxwLzEiBISQxQBvsjPuf8j7iqdY2IZIjZ6bn6BIFVnbQ1ni3enaPg6w5H+newufXC4HKAfRz
	 TZ2Ok3wQsFNkrqyWQ02nlw30bLRcO4ilnobNpXwl/RlmdRPzGwA/nDvkSmHTJxDaQdx9jcVfEm3X
	 iQw8aK
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	Hang Nan <2122295973@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: mptcp: take token lookup references with acquire ordering
Date: Thu, 12 Nov 2026 20:45:46 +0800
X-OQ-MSGID: <20261112124547.193812-2-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112124547.193812-1-2122295973@qq.com>
References: <20261112124547.193812-1-2122295973@qq.com>
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

mptcp_token_get_sock() validates the token and the network namespace,
takes a reference on the socket and then validates them again.  The
second validation only rejects a socket that is being torn down if it is
ordered after the reference acquisition: mptcp_token_destroy() unlinks
the socket and does WRITE_ONCE(msk->token, 0), so a reader that observes
the token before the acquisition can return a socket whose token has
already been cleared.

refcount_inc_not_zero() does not provide acquire ordering since the
refcount_t consolidation in fb041bb7c0a9, which removed the ordering
that the previous atomic_add_unless() based implementation gave.  On
weakly ordered CPUs the loads of msk->token and sock_net(sk) can
therefore be reordered before the refcount increment, defeating the
re-validation.

The same pattern was fixed for the IPv4 and IPv6 established lookups,
inet_twsk_purge() and bpf_sk_assign() in 5b5d8f351dd9.  The iterator
below has the same shape and is converted as well.

No behaviour change on strongly ordered architectures; this only
restores the ordering the second validation relies on.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index e0f2823f92ef..3429b43a9f7c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -309,7 +309,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 		    !net_eq(sock_net(sk), net))
 			continue;
 
-		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+		if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 			goto not_found;
 
 		if (READ_ONCE(msk->token) != token ||
@@ -370,7 +370,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 			if (num <= *s_num)
 				continue;
 
-			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 				continue;
 
 			if (!net_eq(sock_net(sk), net)) {
-- 
2.53.0

