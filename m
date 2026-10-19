Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3461547057;
	Mon, 19 Oct 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419957; cv=none; b=txJp3wrXJqOmTsycYan/jwZDY8sbfE3riV20lUHeFYELlw2X7KxmKKrSfuFCpvZjkYx85zRXduD0EvIxlsQLvhp9WYkhiVx7dHq2ceVm+zvB/xITyWjhu502C7iz8YP6Tn2rRN/EpcSLSKKX2H3z3DKZWgQ8b4tBKHRZ5XKPf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419957; c=relaxed/simple;
	bh=Bns3VyUQd85VlPzRnbzaGp+0P47iJm2aydn+z28Z80A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyvV6XqhA59rSz1zIwyHLj1QsIB0ZOcA6udVd9qy81CjMQs2FZEKBSlerTJG5+9nU4xRJZmrnRJf+IEy5Acx1/ptngLk7w1EJwXMSb3tjx3RygzRXLk34ln1maLX3qOxiH5BUK2IO9jklvc1ZC/cusow5deCwTL2Z4lfbKwRd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Win1nVvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Win1nVvF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5C5581F000C4;
	Mon, 19 Oct 2026 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419955;
	bh=QL1bVDmb+txSMPsD0rnky0p62TfIUAQrcHw7KfSbJVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Win1nVvFdpIxFKnZyOWllKAyH7TVe0HxWGbClUOvIUZ/lc06eNx1HyhVFEB9J3FM+
	 5E7d0k3DTW3N7ChSLatvY18vNhAAlGxjId6OSk+spOfsiWQd7rEe6aHr6ZbyOze4Da
	 /PB/w1YINEif74lZfsYjHtKdnBWDrgFUlKVNdAPh92xCHE6O2Ce+0aUaTOJBXWNUu5
	 BxeM1ET4v+McemrZu9vA+ATdKVgCkeRFuCV+QKvBdZFJp2fEigGLFveulWMQJrxbtw
	 JeLx1Q+hUXk/vKj3Qq9uxc1JOS/VtWrJykt4BXJ2QutXucfPtdUWBE5kNIYqW4ePbU
	 an/tzrhYnHuHw==
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
Subject: [RFC PATCH 6/8] KEYS: Prevent overflow of user->qnbytes in key_alloc()
Date: Mon, 19 Oct 2026 17:25:06 +0300
Message-ID: <20261019142516.300040-7-jarkko@kernel.org>
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

Add the missing check rejecting resulting byte counts above INT_MAX.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 18043251365f..5afc16425daf 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -263,7 +263,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 			key_quota_root_maxbytes : key_quota_maxbytes;
 
 		spin_lock_irqsave(&user->lock, irqflags);
-		if (user->qnkeys == INT_MAX)
+		if (user->qnkeys == INT_MAX ||
+		    quotalen > INT_MAX - user->qnbytes)
 			goto no_quota;
 
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
-- 
2.47.3

