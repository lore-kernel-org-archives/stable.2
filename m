Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1230568B
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181405; cv=none; b=Xz3+6VI97c1bl01Hnnu520eENJ8d/mk8FgJ7/G0HDmf/d5wGSO+gU+5RibbB9m14wolP5gLj8OwNKrPq8xfG4rITotW5TKO3p3WxPDkwsIOmdi33IWM9f7bL3KiC+oiOKrggd3W2ZbjKJUCpp6tPtRgZZYcLuJ8K4YjmdrHsi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181405; c=relaxed/simple;
	bh=M2z+gpuuWxAiZXhGK2/0mTOcMkgFvqS1a760gXkR+XA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I4OeVd5K83/5HtfTfx7n29/ONppAjtx422qahXes5RHr+hRKJFIYdf9UHFpb5q5wR7ad4BX9/IUfOVbX3OdUehZwBwGdZaQFWFKIkhoAkPckZvinApTnK8GDr77zGGUIEDo08cGl3DuJnWlb6SK6II/nt3G79Qtpm/FS64LhIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h9URAIlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h9URAIlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FCA1F000E9;
	Mon, 31 Aug 2026 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181403;
	bh=Y+IE/QOuqQW6KrkylzE+KG940baWjPA5udQta3qXi+w=;
	h=Subject:To:Cc:From:Date;
	b=h9URAIlIIB12SYinVvw/9Tt05V5bCotVDS/NHgahBMBmGsCFCabIZg91e4+yc6v/t
	 vmXUFpOqDmwaj7r/T9h/afBckAOolz1FS8nJgKmtwYQgVJk+rauBhovKifp+8a47Bm
	 LboEszTTCd4SfKohY5mDG92uD2WBgOF8cdvqjh7k=
Subject: FAILED: patch "[PATCH] crypto: atmel-ecc - avoid stale fallback key after set_secret" failed to apply to 7.1-stable tree
To: thorsten.blum@linux.dev,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:03:11 +0200
Message-ID: <2026083111-derail-placate-9202@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x f07a0d251db7606e4792d2610788fbcc7b2c0d12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083111-derail-placate-9202@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f07a0d251db7606e4792d2610788fbcc7b2c0d12 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Wed, 8 Jul 2026 22:42:48 +0200
Subject: [PATCH] crypto: atmel-ecc - avoid stale fallback key after set_secret
 failure

Clear ->do_fallback before decoding a new ECDH secret and enable it only
after the software fallback accepts a caller-provided private key. This
avoids using a stale fallback key should crypto_kpp_set_secret() fail.

Fixes: 11105693fa05 ("crypto: atmel-ecc - introduce Microchip / Atmel ECC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 8e13aeccf011..4add3b2ddd0b 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -82,6 +82,7 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 
 	kfree(ctx->public_key);
 	ctx->public_key = NULL;
+	ctx->do_fallback = false;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0) {
 		dev_err(&ctx->client->dev, "crypto_ecdh_decode_key failed\n");
@@ -89,8 +90,9 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	}
 
 	if (params.key_size) {
-		ctx->do_fallback = true;
-		return crypto_kpp_set_secret(ctx->fallback, buf, len);
+		ret = crypto_kpp_set_secret(ctx->fallback, buf, len);
+		ctx->do_fallback = !ret;
+		return ret;
 	}
 
 	cmd = kmalloc_obj(*cmd);
@@ -101,8 +103,6 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	if (!public_key)
 		goto free_cmd;
 
-	ctx->do_fallback = false;
-
 	atmel_i2c_init_genkey_cmd(cmd, DATA_SLOT_2);
 
 	ret = atmel_i2c_send_receive(ctx->client, cmd);

