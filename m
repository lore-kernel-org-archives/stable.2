Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640607;
	b=ZdiAzacATyt6dQwpf+00Kp2awRJUQ75fms/tIR6I3Cga8s/umZsGS5zXc+ogFohpK/JF
	 CxcGltVJCd5IBlCW/DdyB24kfGUgxTFlwOzbWQAE6BP1odLuaxCrC0aedRYx3sWCtHMzL
	 K/RFbUHXRmyExZIn2neRhEH0k2Atpa3ha/Poy5g2lCDNKymlKqUNWTjp+I8ZaB0CtHNW+
	 NLuQ5Ybcul/yIx3cW1YDvQM4tbQ0FYnqKR9VSeLLCxRI7nOeh+PqgIYnVM5VYySwPbKL7
	 RSsNaZVECtKOfqgqoxcCXd9VfgWQCR/BquhMjQadG4sOk9vGK4rcD3FbB+jC7c+gxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cdCoLtaTTGUaGxI1jTnhB+YJONuG5wImcHwWlYmKYMA=;
	b=vDMosiSFe6zyPxeIL6il+p0YZ1/9KxMWVSfaHKSnk/zvKV45OB9Lgf1I6Tn6g8uuw5Bi
	 7KphyBpMB7TAPyb8coGInrFDIiJ52SvH1eFT55tsS10YcUEnJSH5tULOHltNpBAKQ55Z/
	 4aNHS6A1ejBI9S/WKACTNmbk9c9x+PKDwwawx+E1aF6p/gBhq/ApjQY2BCAxaaLZqJDoJ
	 WdAG5Z1Xok1W8odpd/H0mK3Yye7puUKgUaYu4yOgBpr+XHJtP95Y8XAGyszN4LcitJVRX
	 kx8aStGZZtjmjpkiUZypTC4X8bKfKD3urqwdzjLBInYJm6bxSJDwSCjoFMT0hS32SqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l162Q2Fg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC50606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l162Q2Fg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373841F000D4;
	Wed, 25 Nov 2026 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640606;
	bh=cdCoLtaTTGUaGxI1jTnhB+YJONuG5wImcHwWlYmKYMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l162Q2FgVN9dRWkQ8mUIfHrMqzYO7NY/56BFE8p1l65fukEfI7qyiNENBgbsmMBWI
	 JXtvNCcSPYpm88/2Zjoat1BOdVlQzQL42v16w0VV7/bX2FmHdFk2104Fm6WvbDAZr2
	 1LkhJHBUbuli9f7i+IlMP+bnilIl4Ql1r9Zedf7kXoc+p+cZYtG15QIS5YcRflm5FA
	 FJMzHBVimtUF68lV0PccJT5vYCO/WMJ3mgrPRE2ut5Rqnt1ZNdbRbbiSnnVTwC79AK
	 3Jn8YmTchkNPJkwJhcU87Mh5bH0IxeKaxLVMJOkoXuIjfHeQKQVk8wdD5lQ/EPdJ+9
	 IxmrMhoyJbtJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211_hwsim: ignore non-generic netlink releases
Date: Wed, 25 Nov 2026 16:03:24 -0500
Message-ID: <20261125210302.1518487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-colonist-aide-c6b5@gregkh>
References: <2026112525-colonist-aide-c6b5@gregkh>
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

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit 989f47c56e48d442d79497a25ed946d029c4dc53 ]

Closing an unrelated netlink socket can remove mac80211_hwsim radios or
clear the active wmediumd registration when its port ID matches a generic
netlink socket.

mac80211_hwsim_netlink_notify() handles every NETLINK_URELEASE event,
but netlink port IDs are scoped by protocol. The notifier therefore treats
a release from another protocol as a MAC80211_HWSIM socket release.

Ignore release notifications unless they come from NETLINK_GENERIC.

LLM assistance was used to find the bug and review.

Fixes: 7882513bacb1 ("mac80211_hwsim driver support userspace frame tx/rx")
Fixes: e9ed49bf4c2c ("mac80211-hwsim: Add support for HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20261028141751.6728-2-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: adjusted the context for the older file path and the older remove_user_radios() signature, which takes only the portid and has no netgroup argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 20d9f0c6142cd..64aea40621b37 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4173,7 +4173,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid);
-- 
2.53.0

