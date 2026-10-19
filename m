Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52D53C025;
	Mon, 19 Oct 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419948; cv=none; b=Svenz9d4lwuCGS2VNmZreX6sqWlJmdOmvFUTj1exK4T1JxOQsMZIKd49pPHRVCfSKzB6zu2Fy2dOM++tF9yY7WS7ilRYA3fpzD895Ct3dZjhT/3NVK7uDN5tqXOPdJupTt8OAHSkpu5/+/J5jwcihb9YDdZu0GCP10Weujp3lko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419948; c=relaxed/simple;
	bh=KzlJxrcEwOc+Wm4DDpDhvcSOlyJtf7WDqtaQExnJi6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYBCowaitHasjZuYk9dvv7sSnRNHvW0TZQUniRrDtv1utwN5G+WlTi2E8SRVDTFsmJ/K3rXnCbLFOJTZ5RdJh+SCT3Av/yaaVZhoB6OCJcSGSphhkJmgVuaGHMyS4ZQ9bnghH8/VXILqSyQTZvpKPOC9FYLLuXOl9p+PnkMWrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaGr6pq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaGr6pq3"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DF0241F000C4;
	Mon, 19 Oct 2026 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419947;
	bh=r3CDASqOxmw/tgSs1bQht6L0qkVktMahuo2BFM3/UAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CaGr6pq30srGnzh0cSMoFAj1TNjAxJxMFWbSJnIb0LU8w9ODYPZEkqzHv0RYtjVrB
	 abPXoX3Q2J2Uf7WeLeiu40tk6SZgt8zXrX6lohZaJpDw2XP0eBk0QBK9ugvyotEGq4
	 NWEcQg2IVmWJ4rxR4W2m2m0kp7QkdWGb0496FZiq8TwMJB4W+HNY4XKtsxl3xmfsao
	 hSctK37mEh55Rao2p0Nfxo+QWMvzyIi/+pr7p33CQlJRy41ef+wk4MezTQu7SaLZR+
	 isq6czxMJa6sF9hds1u9x0tp5QTtvsTECjJTFSDe5kHS7M7+bNS4ZKiio7ljCSPlMV
	 uVKP/Zq3HK/3Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 4/8] KEYS: Prevent overflow of user->qnkeys in key_alloc()
Date: Mon, 19 Oct 2026 17:25:04 +0300
Message-ID: <20261019142516.300040-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019142516.300040-1-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing check rejecting allocations when user->qnkeys has reached
INT_MAX.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 7888c0c6a772..30f8a8dea206 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -263,6 +263,9 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 			key_quota_root_maxbytes : key_quota_maxbytes;
 
 		spin_lock_irqsave(&user->lock, irqflags);
+		if (user->qnkeys == INT_MAX)
+			goto no_quota;
+
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
 			if (user->qnkeys + 1 > maxkeys ||
 			    user->qnbytes + quotalen > maxbytes ||
-- 
2.47.3

