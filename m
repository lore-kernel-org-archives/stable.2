Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E35436BEF;
	Thu,  6 Aug 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009346; cv=none; b=YK3RVWxoAlpC6N9PC67TsGNFkj9UkWCLdnQuyXQGUu8FwWPqh8UwLxUFtW2WiL4KPkt8zJnFzHInqs60x5e1ek32+bke20dUJUQ+M4vPNmt5Qyg9lV3KxIj7wQI9hH9ga3ogDuagIu/0E5O7UiV/sY8ro0vPeMTxdRf8hZNYZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009346; c=relaxed/simple;
	bh=DoKNxfTO/fzbJMAtUtKzgkSa3PQxB9iQRPpjcM7OQkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uqv0RvfHHHcA6fAyk0tvsZipInJ1pwB17OXrks9iMlPMVeSL3aDzOQB9dj/1Y697hkbIJYzd1fJy8FAPkUGo8Q7XJS3ZJA77/h/uCwipAAkEE2MItNa3rc5sxzdNp/uUENSVwIge4I5Dd9YnykRARl0N+PGaGfg16GFhWAAaZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uKauCL5Y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uKauCL5Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/znbLFWIJGDEHm7zyltBl/3f6fK7G+wN5oiP1zFaujQ=; b=uKauCL5Yqx0XGVwCQGACDcVbbM
	PlHCdNM/EusnqHjrmhfkD2ql2y5FjB1aApxJEPyeLZvrHiuU5efB+xkc3BJKLX7DQvRjZn/yxRDXH
	I0Db3A3Tg5TX67QHlznheZprIXsp6zVHaXZVo6pM9ROuIgdkea8426nzoHfED9ZLvYdQ/ZZH35VEr
	9nib3CaqxtP4AIwK4T+ST1wE29qO6Q8YvzS+Bccpb7yhEftvrBum4kC8PZlKxqDjIWauBoB6ikEDm
	ZCmTQgySUPT5auRv2v4bAY3LdzlQcHUw7+sMDiseDdgsJVUIevaU4hlIPPRuU58eT/qioG4hlP4Ts
	HrIWyl1A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrucI-00EbHm-0j;
	Thu, 06 Aug 2026 09:42:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Aug 2026 02:42:01 -0700
Subject: [PATCH net 2/2] ipv6: mcast: do not write past optlen in the
 source filter getsockopt
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mcast_fix-v1-2-bed0a5518e57@debian.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
In-Reply-To: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2165; i=leitao@debian.org;
 h=from:subject:message-id; bh=DoKNxfTO/fzbJMAtUtKzgkSa3PQxB9iQRPpjcM7OQkI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqdFbxZdjxkL/skcUI0ncQ/oksH3fa3MizDR6Re
 XZI6WbMckGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanRW8QAKCRA1o5Of/Hh3
 baesD/9uHb/ekPwQ6e+vczzmOIEo42WiDQFVByRD8Kdb8U1VSvwC2CEKkew4siUPmz1cQ9AQVpR
 RHgtamMKukXaiQqaiMnMQtnBOizZCRvbq3t9uaqb0HlzSwviYKRwzrh9Q8jW1cBXo9mnNZqk2SJ
 czod9DjlL/pCQAdQqRSVb/m6aMz1GSr+abs5I3R26Nls2OsacOxb1Rh1f552eLWnLlUu0OqVOwz
 8i70rNmGE4tEIVstFAyifNP7JsTBvARDgJNJHu1VnFIEXem0SHZbBlF9x0OhvDgWubS4qqijbP/
 9LMkp4wRc5TKytrIuNiXPn8+mLmr/DR9SiwcesBjYgySD9hRLtmXei5G4MNI+r/XSbay59FPXNc
 jQwxhjZ0MvUB/ZVHlweG2+kP8H+TVaXexEjdZA/weexm49TwC3eKy8GRyP2Q24UlATzD+ToFiqZ
 1AlDdClXc6RBMxIjHkPXIVWTLFH98zLXfxTUmduemJlMfFO+E33jXLF4yRIFc54zbns8/5Bz+AB
 cTCb3twEsDOYk6JOaB5IU1KxGOqIM42QsnrASjcmkqRQ9gtrdX1pbW7rBXcDVzMGBPTTbnBZXwT
 Fd7rc4J5mc6Ogu9Oud7Krw+vvgJvA0p1boJ3evH3uHoLsNqv8IYcWfBP44lM1cahKwdzV9cNhqO
 18RUfZDh9/xcd8g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

getsockopt(MCAST_MSFILTER) on an IPv6 socket overruns the caller's buffer
the same way the IPv4 one does. ip6_mc_msfget() fills the source list from
the numsrc left in optval, and nothing compares that against optlen, which
ipv6_get_msfilter() has already reused for the length of the reply.

Clamp numsrc to what optlen holds, as the IPv4 side now does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ipv6_sockglue.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e0..2c3fbde7cb058 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1012,6 +1012,7 @@ static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
 {
 	const int size0 = offsetof(struct group_filter, gf_slist_flex);
 	struct group_filter gsf;
+	unsigned int max_numsrc;
 	int num;
 	int err;
 
@@ -1021,6 +1022,11 @@ static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
 		return -EFAULT;
 	if (gsf.gf_group.ss_family != AF_INET6)
 		return -EADDRNOTAVAIL;
+
+	/* Number of sources that would fit in the userspace buffer */
+	max_numsrc = (len - size0) / sizeof(gsf.gf_slist_flex[0]);
+	gsf.gf_numsrc = min_t(u32, gsf.gf_numsrc, max_numsrc);
+
 	num = gsf.gf_numsrc;
 	sockopt_lock_sock(sk);
 	err = ip6_mc_msfget(sk, &gsf, optval, size0);
@@ -1041,6 +1047,7 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
 {
 	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter gf32;
+	unsigned int max_numsrc;
 	struct group_filter gf;
 	int err;
 	int num;
@@ -1050,6 +1057,10 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
 
 	if (copy_from_sockptr(&gf32, optval, size0))
 		return -EFAULT;
+
+	max_numsrc = (len - size0) / sizeof(gf32.gf_slist_flex[0]);
+	gf32.gf_numsrc = min_t(u32, gf32.gf_numsrc, max_numsrc);
+
 	gf.gf_interface = gf32.gf_interface;
 	gf.gf_fmode = gf32.gf_fmode;
 	num = gf.gf_numsrc = gf32.gf_numsrc;

-- 
2.53.0-Meta

