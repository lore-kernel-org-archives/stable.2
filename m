Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A6433BCC
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929918; cv=none; b=eKyBr95C654ajEP7k3dJGGTBQpvnWfORYJJgl4H7FWxQiX8mXLGSlpOYjE2k2uu5l8th09Z7ZQNw5vwChiC77Tc/yVDDoidgJZYoUD21JztyoPeAPrDN8d4YW2Igf6RWaeip5fbC0u9qn7c+QHKifPm7gw+d7sbKfTvr3sIClqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929918; c=relaxed/simple;
	bh=cUUtPrs+Ssp9tXtTTszFIekqWx0gIUm5zNbFvAd1JBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p1zpQL9a6Fjn/LasJ3M8xzFrFISD1TDmdpleNfyo+EHmdUTK4O0mWiggbo3Gxi3W+xsNtS1b0jdTfgpkH7zJgPjIOA/ujPrmocKcEuE1xtv5vk1sH0p8avX0O78R4oqmn49iWGCdw7shTp1R7neJC7s1u8Y7D5D/ErqzaaVAsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YMAXg34o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YMAXg34o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF021F000E9;
	Wed,  5 Aug 2026 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929916;
	bh=kwro5ae7JIo2I1Xdb9NOiEGmI1UsEcZETC0lvHT3ZWo=;
	h=Subject:To:Cc:From:Date;
	b=YMAXg34ohgDBxY/VzSqpG6O2erFxuI7aMaG2xBdkL54eqE/PzHBmVnlExW3lLl+PD
	 Hq2buoqNz3jK4wk/cWfOA5k2+M8DOjbYQdiK08RIWX2E/ZSSci/WTHM/WNAZwuG8FP
	 ddio1pCewZ2ZNbuTsZL105cO8AFd1XbKqCqRq3e8=
Subject: FAILED: patch "[PATCH] gpio: pca953x: fix cache_only and IRQ state on" failed to apply to 5.15-stable tree
To: phucduc.bui@gmail.com,bartosz.golaszewski@oss.qualcomm.com,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:38:19 +0200
Message-ID: <2026080519-unblended-resort-81cc@gregkh>
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
git cherry-pick -x d233087c19f6607ef926ac3f47d776e2406ffd1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080519-unblended-resort-81cc@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

