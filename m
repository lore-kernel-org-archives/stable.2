Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97C3016F2
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181413; cv=none; b=Qo5lIJ3fGaaHDA3/vzGLy8JskcqzS5txjaRzVelm5OKc45Qcs26wz4TUyBmsBsUSltY/Xb+yW6v2g4IfT1reJbBIHG23SARe1s9QslJVqCtMd8KaaxJ+2/AGfMvPe0LrLMDqMP+bzRhqObgO9f4qj6Mr8O/imHiStX8hgbkq0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181413; c=relaxed/simple;
	bh=vg5m1xjjoc9iv+IDM2I9NjMNBw4J1A4pYDp+s1gN2Fk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iys8+8FOtXL7EH3xG1nzrYNw6EgCNq4Nbe0KDwk5tiHcIyHLqIRbss0e7yiNCQ4kSkMwxRl42v/JXjwCSaGa6u25T5HfECp1p3hOZnmI4nP41Kfv5qa8v17J5Ic/FHEUAc9m3633E1ju1ffJRPqEhTeOEvcFbyAesVohDXnYfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UtZ/UKdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UtZ/UKdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F3D1F00A3D;
	Mon, 31 Aug 2026 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181412;
	bh=ux2jsvZBzai3wFWZfCcrNk5K2+UDp4TJHIRamQg2f40=;
	h=Subject:To:Cc:From:Date;
	b=UtZ/UKdgvc14He6d/HjAiMgZ140nuBOWc/9h3kAoAKuoYzQrEhMGkXVTgbiWOcmCW
	 jHE99cv1A9eMJfX8lRHVgNnBHuHLf1DGrEvo4Vdh+yj5MhtS2/uNwaDkw8TPQ20gru
	 RwsvOvWTxjYYHyV3qeGMlIKognqhjBL3PnTGgQoY=
Subject: FAILED: patch "[PATCH] crypto: atmel-ecc - avoid stale fallback key after set_secret" failed to apply to 6.18-stable tree
To: thorsten.blum@linux.dev,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:03:12 +0200
Message-ID: <2026083112-dugout-suing-a5a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f07a0d251db7606e4792d2610788fbcc7b2c0d12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083112-dugout-suing-a5a9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

