Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367447;
	b=dyAeih3pJHv+J+cJoJfhgM1ksZ+SvEa0fY2UEUrGEFvUMCusfwwybrkcz3YqFUmVnLU1
	 NS+/nTdYAq6Sx1mcKj2C+TwQkFcikzMTpQ/5V0MLkyT9hBgVTm3wE5pAlyleQM7YTblAc
	 wPhc07gm//5IiXVKIOV0qMMCf36fGe5Pd/zJgwmLRWQPxh5qjNzSwMpUDhSTE5fhfuNgc
	 skmdEWsm1Vgg/dEcCExRZmU1xaBRAdXVjNM7peD6LoVeag1hlU0BgSrFOgD+R3L9/ydWt
	 f7szX7GTDNIXibTq1Mzor5EOW4k9Uy9R108fXSs+O/EGlKW2Hx0HIOo4G/dY3r6o2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YGE5KBSGrApG8ZH6Kme6SZLg2gRVNDoLFjv7nJ3tGc0=;
	b=EzG54WRkxxP0NtNGDH5a1jZqn4tyQnJdsmszrNxrtiwrIhPb8VFAaTq6F+sdghLG1cSo
	 AJqL0imCSbxEIcwh+kJVzKmEvgXoESr5XPk3EFFHP3v3HrVacobFbcQUC8doavR+qAjbi
	 7xNPcE0yazWOus5vNw3MWF16dRx1lm0q6nu04OAylvdwQsizNl6MbZq+rBkt7nD43Ddv7
	 Dk1mR2iRgXUh/MEJouJwdm+oR5OlSSoU8I9bZmijVNM/jOnhT7G3a0RH8NUh8knIHcJXQ
	 fRzfSMj7+bHVj7gU3e5MsFJCF7eF0CpPm5Tc9cAkTEc4Tj7tFSfI7JWrY579qhc9HBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gezEkYw0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFD606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gezEkYw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F501F0089F;
	Wed, 11 Nov 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367447;
	bh=YGE5KBSGrApG8ZH6Kme6SZLg2gRVNDoLFjv7nJ3tGc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gezEkYw0wZfuCSN/kY/JdZljLnb+nBnsTrGyiFlK7f/ed44VQNqAHmUumT/9C+Zpx
	 i8PvNpBCgsw8wh+h4OZOYUFWH8TRa/aHqHPLAD7Q3J48uIdU0PQtHB9MsbZq2uZNN+
	 xZmhmEB0F46WVDj2bRmDzp1M/UX04vihSbwiH6JxHoJAVHS/N8+2S8pYa19w26eFTn
	 Own+Klmd8W4pCexpidnXWFS/91irxrEZKh3PWCxC0Swf6wkOosOhr061gZRrJcaMHP
	 KyJ8FdXlsIDpi1i+mOgDvCFQgrYO4+tm5a0KksoMOLqWA6v8G/IBs5RyGu3kzFP5VJ
	 nu1jYe6v12q0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Naman Gulati <namangulati@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ipmr: drop packets with unknown ingress VIF
Date: Tue, 10 Nov 2026 22:24:05 -0500
Message-ID: <20261111032331.874244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055535-failed-6.1-09280680f2ea@kernel.org>
References: <20261107055535-failed-6.1-09280680f2ea@kernel.org>
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

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 09280680f2ea060514be2a39ea84209fb6d721d4 ]

A packet can race with VIF publication and make ipmr_find_vif() return
-1 even though the VIF device pointer is already visible. The parent VIF
device check can then pass with an invalid ingress VIF. For (*,G)
entries, this can also let the packet be forwarded back out its ingress
VIF.

Drop packets whose ingress VIF lookup fails in both IPv4 and IPv6
forwarding, before checking the MFC parent device. This prevents
forwarding with an unknown ingress VIF and avoids the (*,G) hairpin.

Without the early check, the negative index can reach the IPv4 offload
lookup only for an skb marked for L3 forwarding offload, currently done
by mlxsw. The race is rare; the supplied PoC reports only the UBSAN
negative-index diagnostic.

Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
Fixes: 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling ip6_mr_forward()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Naman Gulati <namangulati@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/5271fcb94a4d9e697ed64a348e92ea9e74faab1c.1792608753.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted IPv6 context to preserve wrong_if++ for the unsigned long counter instead of atomic_long_inc(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c  | 3 ++-
 net/ipv6/ip6mr.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 948993a4f4157..452aa813d6017 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1976,7 +1976,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 	}
 
 	/* Wrong interface: drop packet and (maybe) send PIM assert. */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		if (rt_is_output_route(skb_rtable(skb))) {
 			/* It is our own packet, looped back.
 			 * Very complicated situation...
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b677f48179c87..c7ff2d49253a9 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2159,7 +2159,8 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	/*
 	 * Wrong interface: drop packet and (maybe) send PIM assert.
 	 */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		c->_c.mfc_un.res.wrong_if++;
 
 		if (true_vifi >= 0 && mrt->mroute_do_assert &&
-- 
2.53.0

