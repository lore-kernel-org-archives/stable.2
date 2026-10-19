Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3653C012;
	Mon, 19 Oct 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419944; cv=none; b=XOpvEIUZlNtX526PHDEd7vnjDzzEvw+MGdVS75MQ0jGWUHQ3s9Ys0fSHjY61DYSJOKPkI8Gpmck6oCb2aenW2ojf5oSeQyY1DGIeLoij/KNm8oh3GIJFmSlD7bsKsiCCmh2tlIWh9OyQiUOnG8zkxpfz1O3wcPOqaTa/F+vVSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419944; c=relaxed/simple;
	bh=p2G2lP2zW4OuqUyJbbccm1x6zKEjrNPyl0BywwNZTsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxYIUKYScKUDoPYGwpoHfk+Qc4yiA8Bnk4P8g8sP2tmxPaiL3sfRDiVOhzEEWlvmzi7Q5uO/jnYPwAylwFMnThUWLJ0+1neUWgMx1us2w409/hEt6BeCBMzJYi2u+64uxycrEXBprRe4dJNnoTTYOoNERRD4Tj87ZqK6IOvxwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGmzooUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGmzooUF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C5FE81F000C8;
	Mon, 19 Oct 2026 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419943;
	bh=cj0fIYU2oAbSnQlk97T67CaTvZalAZQ4W0pfC1dQ0IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGmzooUF0T/D8ciygKkRhAgAXswHz9nVwUIQ9B7V9PVl+HBR+FvbpkQaTzG74deTC
	 QEJnQg3r4xIj1OSv2bs4bUoWOkyXyz/NkLBN+yMOdUNn7XBP7rseaoeVdLqvne56oq
	 PkJutUtAgKoq4KFgd4cgB+62ZgoRnoqSwsGN9y21qrn4mRtV1M8b6OsVeVHlhoHSAw
	 YHPPZNNcDMFQEYXX+xf9/lr3PNPJTx5z49mBeviBy1uIjELFAcr+c/1TDKtFZuiqDZ
	 pz+2ZOJkmFlXcy/i6FxS91VLm8gqyqeFkssJMa0BqwoC1GYmLfguSBS9spYTt8tqE5
	 hDBRRlIWj4Bwg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 3/8] KEYS: Reject @desclen values over U16_MAX in key_alloc()
Date: Mon, 19 Oct 2026 17:25:03 +0300
Message-ID: <20261019142516.300040-4-jarkko@kernel.org>
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

@desclen in key_alloc() is saved to the 16-bit wide desc_len field in
struct keyring_index_key.

Reject @desclen values over U16_MAX with -EINVAL in order to prevent
integer overflow.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: f771fde82051 ("keys: Simplify key description management")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 6ebb8691551f..7888c0c6a772 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -245,6 +245,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 
 	desclen = strlen(desc);
+	if (desclen > U16_MAX)
+		goto error;
 	quotalen = desclen + 1 + type->def_datalen;
 
 	/* get hold of the key tracking for this user */
-- 
2.47.3

