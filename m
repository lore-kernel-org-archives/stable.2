Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395B30C14C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181416; cv=none; b=i/Pp60p2JXzgQQcdoUZ6tkCiSVTniOTpLjUOT7pOCU89IUHCYtseZ+BwpcLR/ZF4c5g9M6iWCLC8zkxr2yUlJCRBBBL/fGT/35cy/l6IVdIY1QSejkytrjSYf2pDP7GAYbr+0VM7upbo/l8dtqiaMmywauwOi2VMP+RAfkrnGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181416; c=relaxed/simple;
	bh=ZJK4OkrS66M/H0W1pSaE6Xubru+5rMlFf+ioQihOlE8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RI5/jq+Bl/YWaqlnPqiGZ6OR/yqgDbn6WCnRczpyKOado1L+OdPADigQ9HmwLvXq1ScruGScsyYvLzTIvVASLrXZb2uT1acNNavLAacHEA3cmEFgUd7AFvRInihkLQuUkQDPKhETSaxgoXBzW0QWEZmkOxecAH7PV8u173XZFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfbYLVov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfbYLVov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD4F1F000E9;
	Mon, 31 Aug 2026 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181414;
	bh=4O5/1vc2bzmjFUzxyeWR18HaIj0NS8vCTa2iXHb3jls=;
	h=Subject:To:Cc:From:Date;
	b=hfbYLVovuTe+w+uiPulUFv2kWiftPluIBWOdU97a7oZunnYm12cuz/1lvgRYEz+em
	 KZVhQw9mxeJ7lCBaJ0zwhgpEyj/Wmc2DV+Ru+40TgvIQZe9s+d1sdo0333QIuWzUHM
	 EA4537wNVS+f6OKdohoTEgKTuFSLPf3xZki1j3ho=
Subject: FAILED: patch "[PATCH] crypto: atmel-ecc - avoid stale fallback key after set_secret" failed to apply to 5.15-stable tree
To: thorsten.blum@linux.dev,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:03:13 +0200
Message-ID: <2026083113-trough-translate-08c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f07a0d251db7606e4792d2610788fbcc7b2c0d12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083113-trough-translate-08c1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

