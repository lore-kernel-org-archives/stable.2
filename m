Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36943A05C2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458344; cv=none; b=PY181o3Cdu0B7mB1KfyPHNNPx0nO2MWpKJ8755NLEBdi+uIB5LJGWtAtqmmNFHrgDm5/eZOu7D6ck11jWb0dfCDJd05KPJ7nzXLYDjzzTk4Scx4hQWQOAn3S8/1MtGtKoc43gT0euJDjiIJFKJCMIso0mKM/5/LJCZPJngoOAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458344; c=relaxed/simple;
	bh=0q5TYPEfU84TUtHIpVpq1q9mIMVjpkW5D5F84PgxMEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4EfvwG/tEPHky7IoploZ/o8BtUpAmZ04yUL0Btt+tBzA7yxXcH9gsOSVmDAeWEaKq7SngIEGxM4o6bWDKkQYKLsP3o2YdTJF1YhhcIeQ0KOiVT/EsfHZyEg6JdsXv2t7acUDaFT668KgrEoh7VyyKl/psAz6mJfF8IsZoFcjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raA+ysyO; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raA+ysyO"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a34907so2856814b3a.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789458342; x=1790063142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l9ECc5+a41AFo2eBSy7WthuxX+hdHIx1RiULVK1OybM=;
        b=raA+ysyOwHeDc1rUo95GLLwd+Q0lmvXPXgPMeREeLP2DFOoDL/KMUwRt+AfPk7Z+W4
         +HB1W1PZGQRSpLZj5tWMlsLmumSnPEwgU/y7Nd/YDGIo4VOYgP/NUydL8fGjp5aVJM3S
         niNOk4R1h9pW75DKtpxE4GvHJu2QJsPdZT497t7xhhWWbT9mosFQVTPat0m4f2pmdP39
         vKILU6Oz6rurbBVmZ7OJ00ZSqXKvaGVY2YIncyAoWfoX3GvbLjPw9lZ/LxDYeC9pXSBd
         OefjGfRGqnAEeNUw2GqEUoyb3ge7Ccb7DUHdP+2QF7RdStNSWojTT/AYoIunskNbzkzo
         zcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789458342; x=1790063142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l9ECc5+a41AFo2eBSy7WthuxX+hdHIx1RiULVK1OybM=;
        b=R0mTQrurLqCY56HHSaGDlp5XLtYfeOWBhIg00+sy04JUAJHhmF3UHxpLsZJIg2n9P8
         XyDkioUXXoqclxT4or3zmvSQPTh+yfGmjuqrvrMXVnwRla4M9sQ8P8lGFkRGHwSrh8jO
         VUikYeO3+kCXtKDxGBz2Ua/0ZgPEoyUQ3owZjG6IEoQBBlwG+zQ1BoztfCfGaf0/4Pl+
         eHdf/VCu4U1VcQ0Who1XGm3oRXW/XCOWA1dblhSSbS1XqwPwr+J3KdpxaGCPHUWV7KRg
         XYJX/hzmANfREykcZOTYy63zVnhiuLSs5ZI6XZUy4ZXFdJDny3flwxdRs7KGQWYg2U1Y
         QKxw==
X-Forwarded-Encrypted: i=1; AKwUvBwLnFoN0TbPnCa51zw5LIezUTiF180Nji2e5chDS6xBWuZOtJ11sdQYdGb2wXL5ZmUcFa8gDYM=@vger.kernel.org
X-Gm-Message-State: AFuF++mvy+ldN2w3B8gZNqxG4eIEF0KOb+U2LyEimHv9DnAUcv/1nqFD
	4j2CLJpZqnWhUSmw4NzHulXHsp2FV9jaHPZNaY2FwmdSpNdWtkbEMvve
X-Gm-Gg: AYBFou3ZfFLHxsPn4VArDcIhNUFsuJdxwSw3yYCB1eZQrH59Bzb90SHfE8WXH1lyMIT
	o8wxn/72tGogjG56Q9gXHZUkDAX3A3dida0ZM9WqudfdRnElEGq7r5mKQs9PbAbpUXaISl+eKQw
	HlBRjZT3pHGhn548XUQTUs/vjogGBcbUX4sOpd2gs7nHKztVyJI+RFPjr2zsWnryi0iCHIdaJpG
	zSNE+/K0XybDXoJm4+I8AnpZ5ELkwapqd8zE7WuonbD2PvNtim+1K9uVQ1ZY3w3koN/UkpmPmlp
	v85Tf5SyLIb4+xYXPEyh5Y62JBrd5SVbSIkWzqBKG0W6LJnFwY655sWhiW+x6nxdN6UDMwZvoA1
	ExquLseil3raFC2T858p0lwuVdrKuR2jWbX04FFEpovUgRMpSLVnYV0Fa5qUFRAgzdvt6k+wmVf
	jV6BiqEGfQYct4o1n4zLCo3T5pDGdO6yYuyP03JlM7EDHJUXQVoY9YYQ==
X-Received: by 2002:a05:6a00:44c3:b0:848:62ab:7b7 with SMTP id d2e1a72fcca58-86f84b1d7d7mr12325942b3a.16.1789458341946;
        Tue, 15 Sep 2026 00:45:41 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b4c39ebfbsm5795970b3a.54.2026.09.15.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:45:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>,
	Martin Hecht <mhecht73@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: alvium-csi2: balance runtime PM usage count on remove
Date: Tue, 15 Sep 2026 15:45:30 +0800
Message-ID: <20260915074530.2081225-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alvium_probe() increments the runtime PM usage count with
pm_runtime_get_noresume() before enabling runtime PM. The probe error
path correctly balances this reference with pm_runtime_put_noidle(),
but the normal remove path only disables runtime PM.

pm_runtime_disable() does not decrement the usage count, so a
successful probe followed by driver removal leaves the runtime PM
usage count unbalanced.

Add the missing pm_runtime_put_noidle() to the remove path, matching
the existing probe error cleanup.

This issue was found by manual code inspection.

Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index f51f9b987759..f218999e0ed9 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -2523,6 +2523,7 @@ static void alvium_remove(struct i2c_client *client)
 	 * make sure to turn power off manually.
 	 */
 	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 	if (!pm_runtime_status_suspended(dev))
 		alvium_set_power(alvium, false);
 	pm_runtime_set_suspended(dev);
-- 
2.43.0

