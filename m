Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330766;
	b=Xa65ORZeirX8s07I0evAKQOT6F5bCHD5ZHKZuSu3Q7IpoeHAMV+yqPw351UXVHTK738s
	 iZgtFRcKIHyhSOiViIqgHMztSphRMZQ7fGinSP7upuc4Bi46d2QzSIOEsSZxIrCpujUDW
	 wNFP3FRhST0YKlPl2xA3b9ZHy1GQ4CaFuiWzOi51/9plf4HUNKLRMmPHX+mA6lx9z+C4+
	 YvCcM1TMi5FhmUez3JxCxiqFzESovP9rbn//p9dGxbBU8ZVqqRormaRYJ55JEtrIy1UDL
	 MN8a3LWnPus15uVJnlTJ40FM82NtrVjVrD1wt8FpzdEWWBhJEplHYtnjUhfy9yf5dBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330766;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aACRyqhzFTx9CNSAen5kh2sgj/4arPvhYSP5mC29irY=;
	b=OJGO80vPXr7gCiVJWWzMkQ3KDeSBk1pwhgN/L5DcEWL17ZW7XnHHp7peirA4gUrVfe/i
	 VUdYzJtOc3BdzFO662szS0dH7jOpZOSlf+rPwQK0iFiH4oOBhTscD1eVcB/N9xW9IQ2Rl
	 ORbbzsvc92wykc+sQj3o1hfD+77taCX94/GJiftGMfdMhSs3oTbPYae6RxB+pboIYjq1m
	 psS/kJguZ2H8kztw55lasQTO5Uk3pwmuYZt0uzuGTqDE3oaesQ7PW2BTadJw8SpnSXYYt
	 VpkMxMkukrlt/omgXHsyml0wMt38vA95THCn9pogUIRUFZXNrU2ge6zR92frul8AUOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWqZJOKm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC765606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWqZJOKm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8B31F008A1;
	Tue, 10 Nov 2026 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330765;
	bh=aACRyqhzFTx9CNSAen5kh2sgj/4arPvhYSP5mC29irY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gWqZJOKmnLAvkLXxMI29gChXMzPTkz0ydmKjy4YNee8q854zKmFTF8S/vjT2U/Eke
	 NBXLbSv9oG/ez9PcDByII9fHStbEC83NSRC8xp7VubFD8bDa7Z4hFwjFnTNhRqkw+L
	 VpziCzx0HLWx1+w/qBL1SnY7c4OVLKMHRjEjbwFi21vABBfmj7w++K2AUGfqUQMXsL
	 9/aqxlksJnSMMalTXniFHXaaMpF0MYmsfixhAkMfKK6oK/oO3bYbe82hdQb9RroKOa
	 kVLouidY6z1MkGuVTBmRdWrxLzgtu9Y7BJiXtl8vtn/lI0cTbO6XEGSp6JgKmvWrV8
	 pZRkank2XK+Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] net: use .data.once section in netdev_level_once()
Date: Tue, 10 Nov 2026 12:12:39 -0500
Message-ID: <20261110171139.2520111-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171139.2520111-1-sashal@kernel.org>
References: <20261107060713-failed-5.15-56453199d28f@kernel.org>
 <20261110171139.2520111-1-sashal@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7071732c26fe2cf141185ed16a8a85d02495ae8c ]

Same rationale than prior patch : using the dedicated
section avoid holes and pack all these bool values.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 56453199d28f ("net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5283487dc64..08b8ec57cbbd4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5363,7 +5363,7 @@ void netdev_info(const struct net_device *dev, const char *format, ...);
 
 #define netdev_level_once(level, dev, fmt, ...)			\
 do {								\
-	static bool __print_once __read_mostly;			\
+	static bool __section(".data.once") __print_once;	\
 								\
 	if (!__print_once) {					\
 		__print_once = true;				\
-- 
2.53.0

