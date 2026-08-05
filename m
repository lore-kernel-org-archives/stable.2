Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAF3D7D77
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929926; cv=none; b=FvYEuDGHr6ID25yFOkrt+RtShAWs/AHPqmfPl9uDAJfMC2N6Nnt3mc/Sb490TlOc978vZANoO4ardu3bdG8gbqB2IVrcI89VXBEsQi3Yiky9sKGWaoGthVMVdaaDiF7zBDLd6XqS2SMbn4Deo/EXTYYg1py+YVVt9dbqAD/s6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929926; c=relaxed/simple;
	bh=Qs3r+TZAq2yc1aAAfm79NsmZzIuB7MyBPFM2jNW4cVg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JG0cLjsCgl1R1dve1dw48QDf3yBIVgAJyywqTdNU57tcNNBVsArSmKnqGvMp6IkO/k1JeOxGdaNR9NxGQepJePM09hks8sp3ieOul6/cC8GFnHcEiJxDjwlOGLiSGqeaUaPRNfSzGeJOmCvSzExO1D8Myg35TWzzI9lUTJgYuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQDD2Sew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQDD2Sew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1151F00A3A;
	Wed,  5 Aug 2026 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929924;
	bh=Dbli8mMbiRj3a514R/ONSIwSXRAS2qY4eUgRHRwR0q4=;
	h=Subject:To:Cc:From:Date;
	b=WQDD2SewyuWZlyWmnqs749KumStPmpVVf2n4tt48BvgvnZ9I9+1JQGaUc2kXtovRU
	 OMOyOf6hYrWIEf/vhVuM7Ik6zURvUCwBO1+p/vAyJEcAvBXPAgyE5yldztYcMWyPK6
	 ckhV/hupyP3AoBcutKcbuv5eV3Z7hoQT0UJaEBnw=
Subject: FAILED: patch "[PATCH] gpio: pca953x: fix cache_only and IRQ state on" failed to apply to 5.10-stable tree
To: phucduc.bui@gmail.com,bartosz.golaszewski@oss.qualcomm.com,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:38:20 +0200
Message-ID: <2026080520-coma-console-65af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d233087c19f6607ef926ac3f47d776e2406ffd1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080520-coma-console-65af@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d233087c19f6607ef926ac3f47d776e2406ffd1f Mon Sep 17 00:00:00 2001
From: bui duc phuc <phucduc.bui@gmail.com>
Date: Mon, 27 Jul 2026 15:02:05 +0700
Subject: [PATCH] gpio: pca953x: fix cache_only and IRQ state on
 restore_context() failure

When pca953x_restore_context() fails, cache_only is left disabled and
the IRQ left enabled, even though register synchronization may not have
completed successfully. Restore cache_only and disable the IRQ again on
failure, matching the state set by pca953x_save_context().

Fixes: ec5bde62019b ("gpio: pca953x: Split pca953x_restore_context() and pca953x_save_context()")
Fixes: 3e38f946062b ("gpio: pca953x: fix IRQ storm on system wake up")
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
Link: https://patch.msgid.link/20260727080205.16353-1-phucduc.bui@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index e03bf1b12091..aac9ea7520b6 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1378,9 +1378,20 @@ static int pca953x_restore_context(struct pca953x_chip *chip)
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(chip);
 	if (ret)
-		return ret;
+		goto err;
 
-	return regcache_sync(chip->regmap);
+	ret = regcache_sync(chip->regmap);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
+	regcache_cache_only(chip->regmap, true);
+
+	return ret;
 }
 
 static void pca953x_save_context(struct pca953x_chip *chip)

