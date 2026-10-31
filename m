Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438932;
	b=QqrAaTpYh0soixC75+BFm0llwyESOETytIqaemqoxdbIisCenKdPLjxLByPWAfyFgCVk
	 EX9hOa5T48PCqDfXCxjnhM9LN7VWVz8F1Sn3lYvinVNJLuQfnx5j9MZszH+ZS6nKhkaPl
	 2eeNLDIZWeJQ/8StQDmjWNa60GSN5FiE1/B4Bk0Z2Airk6K9EDDlQKRzQq08iT0pTdSOn
	 k5SHSaS5K/ltGY4WGMXXpUqg6VrQ+SXXYRlwe1GpyuYhjYhXaHmN+Bv46voHJvmwo27vU
	 pV3Ro6Oys3uTfkEj0yapiCSqZ4rKMao6ccIN/3fjyv/2XblWmGOiQ1Y3hWTaHEqkYQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hjlx15+/WpY84ogewYYrVLgz+B1Dn4l9XY08MaKTAGg=;
	b=H0DLHLo42neLfF9jsjawYSOhDT/Y9mHGg3ywP94g5AgNECeNh6zI0hSpsUdvrLuf+gVH
	 A5x1aaHcijX7ihMSFP48Z9OOM3YoIB60YSoTymX3pltPLmJ9SiuWChS0Ki2CKpJEDe5Ns
	 aCCPO9TLNYhAyV64c4aYV0Km3VB8XK24OJaNQe9AzTyebnj6xCeToDEemE1US4gx8g/Hi
	 cm/aHgk0DvSfgR1CX65b5uceGqEzsj9CvPfnaReGm+RKnb3dpXGat1MNmLxHCX6j2Pdsr
	 3UcK7/gxtm2Go4bfqd/iXhrP2sMcfEh1+HR8SqDGF/FcB/vrE+7BORD+xW2grmNImLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2aagzNJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 58291606A31C;
	Sat, 31 Oct 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2aagzNJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 72B821F000C1;
	Sat, 31 Oct 2026 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793438932;
	bh=hjlx15+/WpY84ogewYYrVLgz+B1Dn4l9XY08MaKTAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B2aagzNJ0u5XHXtRkKA00L0HjBODN++HJK24OwSS1vJiIXGckLB674qBBiVC+JXJK
	 SiabNm89cVZrXMg/EnMKerCnch0Msw7hUGOZ10uUQYf70j6ZTdZ/L/BENOejpM5mTO
	 pZGVb1VvR4yz4GB4Ajf/zwo9G9ic1CVvT2xe/oDwjsuNesD3Cejd9waRfJ47jp5Vcb
	 YRScHYavJt7wa6M+OmwePgWXuFW2XiCyOOq4ZgbG5XirARzqA/y72vWATOATwiTHPo
	 h6P5d55M69j0lt0XruiLGDLLjWU/sQXIJQuBcQkOM/K4w3CQScuLF3ygtjKKSPDe6U
	 hMMjoVTEVH13g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Anvik Loitongbam <permissiontogallop@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: Reject restricted dest_keyring in construct_alloc_key()
Date: Sat, 31 Oct 2026 11:28:19 +0200
Message-ID: <20261031092820.497238-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031092820.497238-1-jarkko@kernel.org>
References: <20261031092820.497238-1-jarkko@kernel.org>
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

construct_alloc_key() links keys into dest_keyring without checking
restrict_link, allowing keys whose key->state reaches KEY_IS_POSITIVE to
remain in a restricted keyring when instantiated without relinking into
dest_keyring. Reject restricted destination keyrings with -EPERM after
__key_link_lock() unless KEY_ALLOC_BYPASS_RESTRICTION is set.

Cc: stable@vger.kernel.org
Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")
Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
Closes: https://lore.kernel.org/keyrings/20261030173930.40948-1-permissiontogallop@gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/request_key.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da5..d4611dd7cb49 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -404,6 +404,11 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
+
+		if (dest_keyring->restrict_link && !(flags & KEY_ALLOC_BYPASS_RESTRICTION)) {
+			ret = -EPERM;
+			goto link_alloc_failed_unlocked;
+		}
 	}

 	/*
--
2.47.3

