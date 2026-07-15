Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE143B6E2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110252; cv=none; b=LR5sfFfaVV2pm2Hu1nD5Zz1Tr+CZwbM/DF6sMu7Pp4F+ukSWc1nOoweR9XgeE42r2twl3WUt8Hkb+EovnEvN+pnZo3hCF9k1Sm/nomzrHxVnCpELYjhFlKy5RfrGF7MSxVWdSHIoGv3ODRqlKWqM5GzNpgLvu8S5Ky1DBBe81FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110252; c=relaxed/simple;
	bh=IBve9qEWj3QB6lBWg7pDqPD8F1ha1bs+tlxfsJBFjas=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jnNgbRFWZKV6vthrUy6mjfVLjKPFmjLc3vacP8UOy54OLzmdkIwfTD9TSR0iF+SRh9hLHGnHIpwuTjLR3xIJGEa2tcRHWXcJIQZ31tjLyoRvu12LNC6uvEh/W1qIIt1EOirj/9c96vqPMgWGxuXVj1ppeQwP4Fs7cwoTaBBdOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IaxkYYWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IaxkYYWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA301F00A3E;
	Wed, 15 Jul 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110251;
	bh=aj0TcEZZYsyb9GMQEI4Q8wUl855g6w8uobYxUwejWSI=;
	h=Subject:To:Cc:From:Date;
	b=IaxkYYWey6MEZFzLHuXaXERUuq3QQaQSURcpnDKHjUM1WnCObMYcuncEeTcDWahiz
	 WoYNSpJlMwXfGXShv6hr36ypFb/JYT0/SnOSaPG11KiX5gG9x28ZTVYjoHkN3o95iC
	 EzQZAsq7d2vVXKn4lbrE75Cv7GtJEATIuH4/fJCo=
Subject: FAILED: patch "[PATCH] crypto: xilinx-trng - Fix return value of" failed to apply to 6.18-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:10:30 +0200
Message-ID: <2026071530-lively-distance-841a@gregkh>
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
git cherry-pick -x 2dd67774228930ccf6441e5628996021f410c4e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071530-lively-distance-841a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2dd67774228930ccf6441e5628996021f410c4e0 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 31 May 2026 12:17:36 -0700
Subject: [PATCH] crypto: xilinx-trng - Fix return value of
 xtrng_hwrng_trng_read()

Implementations of hwrng::read are expected to return the number of
bytes generated.  Update xtrng_hwrng_trng_read() to match that.

Fixes: 8979744aca80 ("crypto: xilinx - Add TRNG driver for Versal")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/xilinx/xilinx-trng.c b/drivers/crypto/xilinx/xilinx-trng.c
index a35643baa489..a30b0b3b3685 100644
--- a/drivers/crypto/xilinx/xilinx-trng.c
+++ b/drivers/crypto/xilinx/xilinx-trng.c
@@ -239,18 +239,21 @@ static int xtrng_hwrng_trng_read(struct hwrng *hwrng, void *data, size_t max, bo
 {
 	u8 buf[TRNG_SEC_STRENGTH_BYTES];
 	struct xilinx_rng *rng;
-	int ret = -EINVAL, i = 0;
+	int ret = 0, i = 0;
 
 	rng = container_of(hwrng, struct xilinx_rng, trng);
 	while (i < max) {
 		ret = xtrng_random_bytes_generate(rng, buf, TRNG_SEC_STRENGTH_BYTES, wait);
-		if (ret < 0)
+		if (ret < 0) {
+			if (i == 0)
+				return ret;
 			break;
+		}
 
 		memcpy(data + i, buf, min_t(int, ret, (max - i)));
 		i += min_t(int, ret, (max - i));
 	}
-	return ret;
+	return i;
 }
 
 static int xtrng_hwrng_register(struct hwrng *trng)

