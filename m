Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F5538D96
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075100; cv=none; b=tMIeEIuPPm4K4fK6lTr+k9KXgoOxgtSTsfeRF+pQJlC1Gtl+G/K7+ncItPkoHpdpNsLg1jBa7000FhgUQOA73htQYMYOAYXHGphM1Q3Ak7C56Bmboqb/XFm2v0iztezH0ktHWkbyXN5wNbYcdFvXmochzhxmoJU7oT/RBU8PQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075100; c=relaxed/simple;
	bh=BnRMPaeMzrBAljD5YlMFboSkVlZcxwY3+u76pCTJ1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ft+kj6KVXQT46mGurkx9aDrz9cgI4uiw9ZE9kpX0frh1X+q0weSZv5Q2CIZsHGnVxq8G8fQnYqd7SD4ypl3Qo7aOSOlI7WOzuDyroIKE3BT5O45AFHQbi8ynaF+EJZAMsWfz1GFBK4l5+oplkttD2/0jfef1RJPQY3/25iigUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHQyrOlG; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHQyrOlG"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so23877155e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075097; x=1790679897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFtEyhEkshA+zxoqPRumtFsn9ptd3jIB/+02u5UcY9A=;
        b=BHQyrOlGrdVsyIAFpWfy9dYr3Zgs93rp2RGjHB0hQTLMDV6ly6aoOqfy8javUxpZ2Y
         ESuSwgEPUCCeUnyy9dejz1rnve4+LLNUCS9s9bV39fPFFbm1ynYY8VqzsXbjuk34bxFv
         iijbw/tNfPmVbuIMlHGfz2zEZP4AoMgoReEszmNC2lCvuIKokKHx1ziOeypnCL9T99sM
         sTMzWzvk5FgTuadajQlrUQ5KuNIm2VzajcMIeZGJkEMWk0OO6v/RGkWxEFmI8Zt0JUtN
         iQN2bCNscrJmpwcSzBjqAk0r4/09uoSI5trdXsaT6eIQH2KYlTjVbnTRCSPcoaVOY4dT
         j1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075097; x=1790679897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UFtEyhEkshA+zxoqPRumtFsn9ptd3jIB/+02u5UcY9A=;
        b=DzuqrPw/e3dd/Xow/RIUSVc79TZYMwjo9T4QdWoPlDJHTCdUMCtKbEtztP/MZ4VweP
         Sh9N3Xc3tJ+A9sJ0FmkssI+ceOO+wtgV89tuqXxR7AKAxYAsyxem2A8czT4Gi+imZlK8
         1k1WZU60/dooZcE0E5E3nY7emq1GKdEvn/30uAaUbpRKfX+aWU4+TO0mkqrVrfNrIhgC
         Md1gyrMKoL+sdnajV7ciePi2/2CD4KyPgj5KuWNx5LIsZnDdflimS7Fy6TNNkQ5+XASp
         lKx8jyb+5lk0TH4fIA8Mj8/1BVVBfJrOwit007JsSH833tZWjMbpsMT6i2vhLK0Tjmil
         U/pA==
X-Forwarded-Encrypted: i=1; AKwUvBxi/w6MdkKgT5XgPOGC6rUr+2dlWRKL/+AyIDYt8NR17gYx/vB7i2BnFxtoZjZ7fkI5DM6GbJM=@vger.kernel.org
X-Gm-Message-State: AFuF++lL4nrWd5+Dp+UlMysyKEzbHhGXxIDaI4e0OynsYa3Fk2e/xo8E
	57HNHqDEPq5IQEJ5heIhcKR/D5DhL8YC8ua7o7A9DUgwqVxUo8TTkf1C
X-Gm-Gg: AYBFou3+Hg7XiGHQwc/+I29J6CLChwB8laS/PezRJYi9BjNxh8d4miGgN0kIwzJd+cz
	00pAph77SLeFRK13OYbJQhEg1uPl4Z4IhJAXWBWCyqb2kK/j9eDNsrcYDIva1OnaE36CIICUPBu
	Yf+P8wDXmkIh8gbs74WzT9ZLcs0ma3+wndt/tnGwDcXEolCqdSNuv2QC/ZTbeW2WfhCmF/oyRnG
	KB+YdLuAF3lPLcVj6vvQVcrQRJKg6rdLz3hnSkM60nUFVIIEpkD4pmPg2TUJUQ0dMCaCJu6ov0p
	abPDgii/Sy3867GzoOZ0Aw4yJVMDzx1JuGeFEcufQdvWTyIS4/JLW7Ze+CLzNCy+zCWvVI1L8UK
	+PwdkJ/0Qetdgnfgb82OO1ZVIHSKyEp6Sk+sLYFjDozAH8DEwMFYijf1Yx7IbeIeRXjsdQDVlCY
	nzqHY8P4ULjX9cLEVDs8Ldk8zhwMtuaRSuumoijqu8yxpAKY0vfj+Ai2kVDJgfSKsI5bZyBNjE9
	TWqJASk8yqHBRef7I+CoA==
X-Received: by 2002:a05:600c:474c:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49fc569587bmr204550375e9.14.1790075096967;
        Tue, 22 Sep 2026 04:04:56 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:56 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 25/26] xfs: don't let hidden_space go negative in xfs_metafile_resv_init
Date: Tue, 22 Sep 2026 13:02:20 +0200
Message-ID: <20260922110221.1431-25-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM points out that if the amount of fdblocks that we can reserve for
a metadata btree file goes below the space already used by that file,
then the hidden_space subtraction can underflow, causing
xfs_dec_fdblocks to subtract a huge amount of space.  We never want the
target to be less than the used sapce, so fix the logic that adjusts
dblocks_avail downwards.

Also fix an error in the adjacent comment.

Cc: stable@vger.kernel.org # v6.15
Fixes: 1df8d75030b787 ("xfs: make metabtree reservations global")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/libxfs/xfs_metafile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_metafile.c b/fs/xfs/libxfs/xfs_metafile.c
index 71f004e9dc64..1f54d39003c2 100644
--- a/fs/xfs/libxfs/xfs_metafile.c
+++ b/fs/xfs/libxfs/xfs_metafile.c
@@ -297,14 +297,14 @@ xfs_metafile_resv_init(
 		goto out_unlock;
 
 	/*
-	 * Space taken by the per-AG metadata btrees are accounted on-disk as
-	 * used space.  We therefore only hide the space that is reserved but
-	 * not used by the trees.
+	 * Space taken by metadata btrees are accounted on-disk as used space.
+	 * We therefore only hide the space that is reserved but not used by
+	 * the trees.
 	 */
 	if (used > target)
 		target = used;
 	else if (target > dblocks_avail)
-		target = dblocks_avail;
+		target = max(dblocks_avail, used);
 	hidden_space = target - used;
 
 	error = xfs_dec_fdblocks(mp, hidden_space, true);
-- 
2.55.0

