Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106A3C4542
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075785; cv=none; b=c6T5W/sscrMNBfhC8+jsB8YjXMYlV4F/P9B0QL0TAvJBeXGf7XKrSlHWXO73b0IiU8l7tec/LIL/BmGAxjlqU+/zjAGvMMQ7AQvAbaC1uLJr0cue3z6dLOE4bDJpUY6GBaF6kL7ezf0p6Ve0TyuDxf/HvIcFoDxM73Y6FZQwHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075785; c=relaxed/simple;
	bh=kAMB98C2TO+dg0RpAZ18Gg4F2DJAMfSCQrSzGZazOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJnFYieY1CMLAl+uUu3lLyVD98Ih2JZPEuwQTiha+dr3XnRUm+62qTh7As+pEjwOL+JA+ku3sU0X9cwpvfLcWrmvcPJtJBTHVRYT6/B1RcS+/7n2s2AAidWJqeMj3e7MI8O79TjFrWyndxjv6SbWgkOhfvt6oWF80tm02/Z7xB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=KuukSs23; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="KuukSs23"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917866225aaso74162326d6.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792075782; x=1792680582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WAcdpcTpnQbvHYYEUHq7bhjUU7mNPvOKc1GObp15GFQ=;
        b=KuukSs23oDQ/EusgapzJfiECQBPqhI0oep/R1++k391hryAAHDJChRLm6GZkjjaYyF
         QFvVoz4CHgZ8JGs/E9w/Z+ouvcKZFOlYtLT+CNeggxPSgvzWEWbd7Fls7lunj9zLtt87
         I9QI4U5/Cjy52G1MPHU68RgC4NjHTUMvTMN7Kt3CMNnK8s2u7y5gAbkL93cBZsUR3N8p
         cGlTItcAuxvPqZSQ/knmGq5ALnD5wxpCimprkf3oFF4hwPIx0drdRPq44CRtanf4c68z
         baSrmoRBhmtOUDrhDL7qqV8984mhUzuweEz0Mchxi05mkkXPzXvXh8/lRiQe1btCgkq4
         XeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075782; x=1792680582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WAcdpcTpnQbvHYYEUHq7bhjUU7mNPvOKc1GObp15GFQ=;
        b=WHFl+g3mtulqMbquEWislzcCXGy9nFGM00ga+srt4pMN4pYc9WkIgFIkMJ5E+1OwTm
         5sHO08XXmfet3pkbS8j9aw40sS2WQbugw0WyP35VLTeiRlVkjIS/iD6DZUHPex9RTXyO
         Loc3oNwGcANLwyCWGhGHZE6oOZsk8TsbBbfo3fO/vaAU9IO0HzUuwemihhLst+GZ6ZY6
         cV7gs7kX8ejdhM00d7hADyO16XC85OTLqXYzsFhxf+N2vo5Z+9LSMSq8/Vo60xZZKKjZ
         mpmGyfWGjGAU0jYmyIGCHwDoNWqMzhaNW948SGL+qfuplpNfBE015RktxqwOXLcM40Ic
         c/VA==
X-Forwarded-Encrypted: i=1; AKwUvByZ9fE3yh6UEvVtTVTzmmYMVG/l3gZJW6KoNOrn+4jYRUL8SQotNMdoJUtb0g2Jn+5JljAIA1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtSesyvPig8nkdINzQD0QlyY95pvxukga8MCuBDR/uZf/BByG2
	IOwX98BFLHVN/6oRoF6Wt3/c1flS7hfTHZjAb/KekJYIBBo2kdoqhmyzLpXzGkJNpA==
X-Gm-Gg: AYBFou2477Z7qMtniHnbC5C/QyM4h5tDRz5WQWcjtby/KBqC0LzOQGVIixBY297zWaF
	dDzscst1YH9ro73JnJxt7P1W9wYF9EuTFnTU7EJdXVaxsoQhV5Qxx6MBp6SYTu7UsRxiJGP7Zu7
	Nxx997Czm/vVFqm5OyrXZUaWW1jXQHmEPDvBDctR4FSZnsxHx85fxwC25/zRV707NXCGf6RsQqJ
	GK2qZlG5KipukCepyTNOzwXYgrg+pvYugdsbyUHKseyGX4/8J4i1Gt7Q2VZVkZUI3cMOkSKn4Is
	QPJXWA6JjqBmjC6+SrdmpDIlDsTwEMSntMy5dmbCuFvuZ07AOREz8gnpTtvXNaWwFjVIwAdrYKD
	B5A62yuh/yccE1rxCa/svykL6pdqmFeL2XBIqeHJi8qN2EAPZBgh5wjelkRa9PrFi7t+1yrkjjf
	mLSXh3cHHA4noFSs45ms5+inBKfDltMcpXil5QWnq41ktNirEbf4MUjme7YowBqhIMKXE42A7if
	5/Dds1bAQnMU3wH9MLu
X-Received: by 2002:a05:620a:4454:b0:939:6dea:374d with SMTP id af79cd13be357-93ebd22f201mr3559144585a.49.1792075781768;
        Thu, 15 Oct 2026 07:49:41 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50295edsm790347085a.22.2026.10.15.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:49:41 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	chizhiling@kylinos.cn,
	exfat@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] exfat: fix reading a directory whose FAT chain is longer than its size
Date: Thu, 15 Oct 2026 10:49:34 -0400
Message-ID: <20261015144934.1800240-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 08cf4a8181b4 ("exfat: use exfat_chain_advance helper") made the
directory code walk the clusters of a directory with
exfat_chain_advance().

However, exfat_chain_advance() returns -EIO once it has walked as many
clusters as the size of the directory says. The FAT chain of a directory
can be longer than that, because some cameras stop updating the size,
see commit 1e5654de0f51 ("exfat: handle wrong stream entry size in
exfat_readdir()"). As of now, opening such a directory fails with EIO as
soon as the chain is two clusters longer than the size. Reading a
directory that has a FAT chain after a seek past its end fails with EIO
too.

The issue can be reproduced with an image in which the size of a
directory with 200 files and 7 clusters is lowered to 2 clusters:

    mount -o loop exfat.img /mnt
    ls /mnt/d | wc -l

Before commit 08cf4a8181b4 ("exfat: use exfat_chain_advance helper"),
the result is:

    200

After that commit, ls fails with "Input/output error" and the result is:

    0

This patch will make exfat_chain_advance() follow the FAT to its end
when the directory has a FAT chain, as the code did before, and keep the
size check for a directory without one.

Fixes: 08cf4a8181b4 ("exfat: use exfat_chain_advance helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/exfat/exfat_fs.h | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index a9131fe03302..f324c4cba26a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -623,19 +623,29 @@ static inline int exfat_chain_advance(struct super_block *sb,
 		struct exfat_chain *chain, unsigned int step)
 {
 	unsigned int clu = chain->dir;
+	unsigned int i;
 
-	if (unlikely(chain->size < step))
-		return -EIO;
+	if (chain->flags == ALLOC_NO_FAT_CHAIN) {
+		if (unlikely(chain->size < step))
+			return -EIO;
 
-	if (exfat_cluster_walk(sb, &clu, step, chain->flags))
-		return -EIO;
+		chain->size -= step;
+		chain->dir = chain->size ? clu + step : EXFAT_EOF_CLUSTER;
+		return 0;
+	}
 
-	chain->size -= step;
+	/*
+	 * Only the FAT tells where a chain of this kind ends. The size can be
+	 * smaller than the chain, see commit 1e5654de0f51 ("exfat: handle
+	 * wrong stream entry size in exfat_readdir()").
+	 */
+	for (i = 0; i < step && clu != EXFAT_EOF_CLUSTER; i++) {
+		if (exfat_get_next_cluster(sb, &clu))
+			return -EIO;
+	}
 
-	if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
-		chain->dir = EXFAT_EOF_CLUSTER;
-	else
-		chain->dir = clu;
+	chain->size -= min(chain->size, step);
+	chain->dir = clu;
 
 	return 0;
 }
-- 
2.53.0

