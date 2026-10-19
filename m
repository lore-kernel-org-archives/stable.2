Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E80547057;
	Mon, 19 Oct 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419953; cv=none; b=oPLB1C/IyYh3fMovH43MkGdnZsyOeoDhYQ7TEqg4lTjv4HP0pvYqXci8Dn2OsSTFVbTVnMczIy5k+XpZzbOmabVSUySodGdZgJIN+4mjuitl6Bqv3CFIGFV/8k9Aet1vX+DgG2ITolMWdWB9EIbZGUA+rcWTjb7sWzJbb1fApDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419953; c=relaxed/simple;
	bh=FhD8cjOul20ufMRUv/7NkvhHhd+yl5KRS/rCOUo9Img=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMUClN24vsb7JC6wHNTN9cGEpX2e7qctkqRlN6Tz6Zo6sXzyyKg92use66atk769FXZKnZSiQ+gXElpEdFNVONL87Zc7Z9Vnt05aG9cvHqznJckHqWCMn3J49bRGIFo/N7S9/hQKq8sfUiZY4QpcK8IdhhS+mT8JjPetshWLctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLxtgJ4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLxtgJ4X"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2CAC01F000C5;
	Mon, 19 Oct 2026 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419951;
	bh=uJ9P9whz3YrqTRLsNq+bGdQfSSG5w1KiCyo/gM3zDYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLxtgJ4XFOFx74Pb8d0wsC7YPGdGF42NsRmVXNKBB4rZur/D6goiGFFhd/nxBemEq
	 wbuZMtkV+xtSdBQmQ/Ipgji6wuTYjKvmuuItZY68JjSpOo7jzmcyzxwPGka/aRmYWy
	 AitYV85rqYP/dWFgbJg5IcQ5Y/UruBAmBZWueKPal5Q8X/bG5owlW/Yi7zR1TVK/Yx
	 sPiNSs4Q2Ac1KF49tVf6UNqWdwD1V1igpKjmz7cS2pVkTdupiclCzuPGRoEWezNCeA
	 +qSSUP4IfIXUqfhjpYfm/b2p4vyeYN8yZ6dixQR7/yvx3UZb9+gcz5be6W0Npc6TUL
	 cWCVyJD/WBJyg==
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
Subject: [RFC PATCH 5/8] KEYS: Prevent overflow of quota in key_alloc()
Date: Mon, 19 Oct 2026 17:25:05 +0300
Message-ID: <20261019142516.300040-6-jarkko@kernel.org>
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

Check that the calculated quota length does not go over INT_MAX.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 30f8a8dea206..18043251365f 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -245,7 +245,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 
 	desclen = strlen(desc);
-	if (desclen > U16_MAX)
+	if (desclen > U16_MAX || type->def_datalen > INT_MAX - desclen - 1)
 		goto error;
 	quotalen = desclen + 1 + type->def_datalen;
 
-- 
2.47.3

