Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717018;
	b=e3rmuA4jCMFqQ7fbKoUy3XVzLbp1N+ww2VM1L28LdyUGnxXgJUCtFGgtw3CStd+vNEeg
	 vhPMMwybH3HOvcOkBTZTJ1WzbU7af7ZYU+gHO1D3i53UC4jlfTeddUz4eNfVwphjwFwNl
	 B48WlO8AZtw7a2AuZ2KRYMGhTrSxlrkfogXEfAsOkl8a58RkC6S4AmmXElyMxdumcBs6C
	 MOIuyGPrPPjMrKuXbq70TBgY32POrScgbQNxwyDnssx6to5nzwXDOl/paIZsnSkb/Rqu5
	 HRruiLufycumv1W77BkVEdFqdp1xkmfwmhPsTbmwLEJXu8YbV/aHg/s4m4GFV7VKlsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717018;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qSWECCtGDXdUz5py+dVMGpmrzXXOmBWZXWLybIApoNY=;
	b=vXMxBM1qFjvWN8IX2WLr5ixbP7E7pOpArB57/inaQYNim0eYoDXHDaZraXZlJY25EXZy
	 x43BEku2spddG91SAlibELY4jO+xQuphWBQu5LtbSx2jz8C9rPWS2r5MioWArS8W5NrqK
	 EYB7mu2ihuOSQPNL/jihvOC7nLGQ1CG+G7+SYodwI6bRSvJ/8Mkt2k/I9dlyB1hBpGIXz
	 pXbZmWSs85WJLno00E/CSGOclV0LBv2aeXJLN+gJTG+F3YF7hdFDAoBr4uUAv60my5ch3
	 0Utf+kmcgz6KeXxI7/FjHqcXtMqIrDU9c4w/2mj40WdRsYPs8kjQ5QXUdi6omAbWAgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJbOOHAf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3168606A323;
	Sun, 15 Nov 2026 04:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJbOOHAf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A411F000C4;
	Sun, 15 Nov 2026 04:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794717018;
	bh=qSWECCtGDXdUz5py+dVMGpmrzXXOmBWZXWLybIApoNY=;
	h=From:Date:Subject:To:Cc;
	b=BJbOOHAfJ8JcakyXQ2lueLKzkN8+oiF5xbu7e23UJJjn27lLLKTIYFJmma5RIh64D
	 ZCvUJ0xaiEGuyNNN2lghrMu2+1zqwUueMQvkWph6fCCg2i0RURcJHszzxXsd/5Ku/y
	 03u4/v2NJBzAIu/Z48Gzih+P7kUH844A1rpcdHzvoiVhqeQJtQ55pLTycNMNNHPbVs
	 iKV0mXFlFjQF5e44WxzFEog3jElJSbbnDN/eLwrmhjtplYd6FasD4pq5q4VZL9ptEN
	 WMs9TDeW4X7uSlf9lRK9IJAg+sfe7ypuXbfanIEz9MdWezzD3vZ9uvVfMjhHMyUMGz
	 0nUojFCDNOmBw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:30:07 -0700
Subject: [PATCH net] mptcp: Avoid unsequenced accesses to jiffies in
 mptcp_reset_tout_timer()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-mptcp-wunsequenced-v1-1-707a73a6c172@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWMwQrCMBAFf6Xs2YBbSxF/RTyYzatGcI3ZRIXSf
 2/U4wzMzGTIEUaHbqaMV7T40Aa86UiuZ73AxdCY+m0/MvPg7qlIcu+qhmeFCoIT8X4/st+FQai
 FKWOKn9/0SIpCp7+06m+Q8t3Rsqxa9bLeewAAAA==
X-Change-ID: 20261114-mptcp-wunsequenced-ccbb861b3d4c
To: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=nathan@kernel.org;
 h=from:subject:message-id; bh=J/YSlnqi7aQ98+addJs8Lr4CNVb3jotGxM7r3NCMf7k=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/TUOePuv7w8r5I5zPMe9kik1ElAaT5y+7yM2nbjg8f
 pjLPGlKRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjI62JGhuvpbdYi29fHVCcL
 Nn2XsxSuqn+6L9B02np/4cI3bmF8vxj+Fxx69bSAozl73Q4O1z0sZuXBbKnldhafxCdEaJtNFDn
 IAwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in mptcp_reset_tout_timer(),
which can break the build with CONFIG_WERROR=y / W=e:

  net/mptcp/protocol.c:3044:20: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
   3044 |                         tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
        |                         ~~~~~~~~~~~~~   ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.3, unless otherwise specified, side effects and
value computations of subexpressions are unsequenced within expressions.

Add an explicit sequence point by splitting the addition expression in
half, eliminating the undefined behavior and clearing up the warning.

Cc: stable@vger.kernel.org
Fixes: 76a13b315709 ("mptcp: invoke MP_FAIL response when needed")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2193
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8968db58083e..8a9efebf3497 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3041,7 +3041,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 		return;
 
 	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
-			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
+			tcp_jiffies32;
+	close_timeout += jiffies + mptcp_close_timeout(sk);
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active

---
base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
change-id: 20261114-mptcp-wunsequenced-ccbb861b3d4c

Best regards,
--  
Cheers,
Nathan

