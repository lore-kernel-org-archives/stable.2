Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270358;
	b=z3Z+Q0RAjFmJDX3ZypBLN2MAoCmaHSL+vG0SZsTi5f0VKTWeBKNohWDxHFQRx2gaSgu+
	 27MFVkmcJmnVLUl8677OhTWJUnLYQSsBg5lJIWvE94Zj99eMLSdLwA0DtiRpsJ5OI+GlF
	 +uiAwZ42TIaiCBsqEYO891Khq6DNiddmlUjgo6EnSAZNoWGZdTLukMT+jYJQxvf/ANbE7
	 BB0x9RDref9PnrprOc0jELfubHX0+vaROiaVnhjrHwjZtRMgOP8Rq0GdXwDxy5wTLcqjh
	 Gep0SwhzPmUsBZAT2wKMu3ic2+Ocg4VUzVjjh5ifp2fY6TAnGOrdpBU3P6ZFCHfsfPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8eGXEP28tBZsuowcYGbYE9SLL2m94ii1a9Wvq9NDd3I=;
	b=Q5XO0QGKVQPWUEL7VabrXPfSuh4xCSt0btyZyaSdfVyDDoaIIZ+fYZjsFoac36FFNIsY
	 zV2dFasMcbNQYULJe6ZyuOsZhJtdwcSkxhSQ0FWOOtRFI1O3aGaLMuQeDPIt2xOU2fj0O
	 xxc61UzO/AOja/8oN8SnU2u8eJhgkJCenhItcDet6bs+9vJoYkbkDhAQdlk22kzyf6UX4
	 jWfOWetzv6fQqEIxCZgd+HdGlnaQGF7wUp1hjifyrFdpEBGOMAxZjjOF4S9lZ7Y4lE+dU
	 VZjUIvEaVBqt5z1xsHml4o1Z0xW1lMGhF3vwJA5mWrcztgcFS1spzQ+51g/Rd+pqOcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qurrekCU;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A13606A330
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A13606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qurrekCU
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c450ab1483cso309217566b.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270357; x=1793875157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eGXEP28tBZsuowcYGbYE9SLL2m94ii1a9Wvq9NDd3I=;
        b=qurrekCU6tTX6qsWPGalnXvKxeHMwE3Uml/W2Bj+8qWdC49HwCv/BidCIm+xyr992d
         vopDsO/aci55ZL0mJhc1m05Ul7SFK6OnTnp773aBGRstm1AJXYkcc3BnJkyRQC6vh9gD
         NLzZ510CoYbmFraiCKmolkqZQetWGsDckN21C0P7N91/vK6gBsy3NaPGMJsNvdH8hYqx
         CmTCAgaFOBNaaCNRH4XHoX9NujuiZfzTJFPsXoem+yBuFhO2jCDxvkU39ihoPp5m4fJC
         U8aNwe7hYQEKquOpUErq/vJo7IwBFMenEmgw2fUHEb+VYBwai/TY3IkyeoyKeKTAan9s
         EwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270357; x=1793875157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8eGXEP28tBZsuowcYGbYE9SLL2m94ii1a9Wvq9NDd3I=;
        b=ACxsXpmvyc6uJ7DosGlLrEgmfMGhB0NBV9IsGSDhums4nXygpaNw12L3o0PwP1pWi0
         03FTtTWawgUvUxOitbgfX7SXL8vyaqnyo/tF6TKeruZyd6xoU1gdkXFHQkLb5V+5LayW
         beuYpcTiGmZL7C++hQpTB7paq8oVqCw88dNAJa2SnYOOrR68Y5XkhJdXAyxu4UpTn5NS
         cSUcMozW6sGFKPHNePUP231rQP/qJi6SevgJ3jReildRP5xhoWLWJ4fzJGxXQqoj/P0s
         7/6SEmbKc2KxSCZUZpaLEF1JmFnDWz41BVLOs7TvCRzA8JKE+9JJA3B+OMUyzgFphiUr
         5KJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfqBE0DUDIn1On3foR2mFNj33r4AtAGIwOhCN2N5P9D8ROAbj7NTHwbkARcQCNcE3OQQqj4Mc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8KbN4aCZfGX9pd/bGFGWHmuC65BURN2ZlOzPrOCpFe12fH+Id
	l8yMQh3OaeUHY2WUk5SIKchdWJUheNg3z4oq5yDKLmBeSyLNnMrJRjhmfsBOznfU
X-Gm-Gg: AYBFou27kWnfnm1bI8E7oB8wTp/xHALn9uu284zTLqQXEq4EkRGhcbAdPxn4nSl7H77
	xisb8GyGrtSDkpqhWd9gBEtTA+z1TZS0EQLCe78FK7csob3yPWIHN3vL7CBT5r5v2eBKCiIfKkR
	+BHFuo9pRc843AIoFweT7A099aWHUn48Fu07cjaHxZMKS8/OY24iJ05fZru+c9w9CEdiSZWF8pd
	5bzq2pbmBfosnRsOulUnRYk3PC6U3rWELdXXLwrDIpJpSTS8eAGSNx4EQfo1KA2gWj8BhTJ1aKh
	wr7V9hG8eL4KFD26wM0xGTQsjlZShh1PqWj9MlEhJS1nYqKHqMEGzHgtco6MPE8j5E0s0a6Vqsp
	qXtRGAp1wGI303SH6W0yhMm2vaz2o6IuMqolMrJiAqE3xtROYaD7gpik/YGhDV+zs9guORP7fDx
	O0xaT/55TBeRtH7qPUfw35jlXCEPe9EiUFkxZgdsNKYqZqF4vYrvOgWwM3vH8YrW5TEHnWAl76I
	1Exai0S6fyy4ujFNaOrkaukKAGb7KLc6Y2wYDmvD2mk8St+Jli670TNUVV85WWhGCNeUx7O+Nkq
	FeOOsw1snUourRXefkaOA7f1KC+tWeNlX3A0eUaBLI4/Pa1NE0mJIs3X7UU8UvDQOjV5Q6GqZTT
	VdVB5H2MXIl0=
X-Received: by 2002:a17:907:1b1d:b0:c42:a326:78a9 with SMTP id a640c23a62f3a-c49be054ad6mr449212166b.42.1793270356461;
        Thu, 29 Oct 2026 03:39:16 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a4e2401bsm400326566b.84.2026.10.29.03.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	Fahad Alharbi <fahad@codepure.com>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 01/16] ovl: do not copy up an xattr value that was never read
Date: Thu, 29 Oct 2026 11:39:05 +0100
Message-ID: <20261029103913.2785828-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

Copy-up stores uninitialized kernel memory in an xattr of the upper
file, where the user can read it.

ovl_copy_xattr() may only pass bytes to ovl_do_setxattr() that
ovl_do_getxattr() has read. When the read fails with -ERANGE the
function asks for the size again, and if the new size fits the buffer
it stores the buffer although nothing was read into it. The buffer
comes from kvmalloc(), or it still holds the value of the previous
xattr.

A FUSE lower layer that answers every sized GETXATTR with -ERANGE made
copy-up store 4096 bytes that the server never sent, with a kernel
pointer in them, as an xattr of the upper file.

Fix this by failing the copy-up with -EIO when the size that follows
-ERANGE fits the buffer.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e963701b4c877..c220cb5d0b70c 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -131,8 +131,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE)
+		if (size == -ERANGE) {
 			size = ovl_do_getxattr(oldpath, name, NULL, 0);
+			/* Nothing was read into value, so it must not be used */
+			if (size >= 0 && size <= value_size)
+				size = -EIO;
+		}
 
 		if (size < 0) {
 			error = size;
-- 
2.55.0

