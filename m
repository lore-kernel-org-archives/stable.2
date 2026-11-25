Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639964;
	b=E329/pIGlfiABRzAuYWrEtVx0J4lLdaM4NUPx4TA6syyA46P89l93UuvnVKqTTQQWc/L
	 oRwEFDuzXpj9DD4n08i1vEMH1w/n4VFWgjUmv2OOavJILSzE13+O6cg4RWrKudadmzCQv
	 8mpH4Yst91fTxcUdVrMzbMUXuK6LYHbMA+bPHuPw3J1hIHT/tTZN3F0GJk8XQ5H7kUp1c
	 GBkL9KIj3TJBV9Yqxd5M/RUrSK2UgsICH+ZyqryNZv4GOb1dWQE0MJMdh4pqdUZcc/KtE
	 hbHQJKBZl/PTJKDdZCLJEuTA5Mf+UumfGRvnPLU4IBwxYzCVk1DpKAJTQYKNQw94Zng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=00pzcdeKPC8L0SMlq5MSE/+9Ty3j0Exs2QccHyk1JEc=;
	b=wOmFpXjt0nqJ88uBsYpfVXnGxAN170FFSSs9Jt9torSOa7uAAvwzcGvEZ2z1SulzOJ5P
	 YF/+fYx4TdWydGnY6QqZvDr7urq08a+nnIldasft2yGvtffqJ2emjCsHctlyvBmgM2QPZ
	 3IKt6nPKq0Jqg+q3jZut9P8nCBMJjrcCNN3j3EDNsV4GkqMRmlNX8Y6sIEoqelskklq0C
	 4Z7sHjjCYw0BPzTwWGzUT6SweVni5cfK6VMr6+5ezMPmYRhayJ8O+fJ9JD3SOlwE17sqB
	 NVbe2BuDUGpF7cDMQsGu6INLsSiJ0/+9BTD4iGvdhdiyy/0T6hQwT6usjbyzGELLnqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLmuvoHg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23B606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLmuvoHg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90261F000C0;
	Wed, 25 Nov 2026 20:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639964;
	bh=00pzcdeKPC8L0SMlq5MSE/+9Ty3j0Exs2QccHyk1JEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dLmuvoHgTzaqQfhKko4vxSYsXY3pCvjec3Z+9euEr1nZj9qE2QwSM/JN4qediJJyY
	 28ZoADH81I/Xw/k/vBSkVyYuxtkLELxbkmV+udyib84Sep2rsiSYGLDi4Oj+USpepv
	 ovf5gYqpA7GmpkefxpKRt3dWGdaF5zhtWGWRwlsD6T1d4NduyKgHSsbcUMTyM58dcO
	 eHjj/ifprhZRVeK+jxFiM2+d5TeO6pJFLaUIXWsXkZmuphfeqcgavah/jxXzJSji5z
	 hCbC29eZfaUzAO9Qo7isYO6TcNYDv4QWNKXXaegurHPL6vTSLwzdSpfiKAHqlYYBzt
	 i/Sh3+ZyF4VXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mac80211_hwsim: ignore non-generic netlink releases
Date: Wed, 25 Nov 2026 15:52:42 -0500
Message-ID: <20261125205236.1485793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-unmatched-vascular-e8f1@gregkh>
References: <2026112525-unmatched-vascular-e8f1@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 8ebc76cbb0d98..7b076fab1f1d1 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -5412,7 +5412,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid);
-- 
2.53.0

