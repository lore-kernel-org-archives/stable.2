Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55DF4570EF
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840467; cv=none; b=fsN3k5Q9HRsJguKyZmG8MgAWIu1jMiFuWGqsvETM6mTo8KqXjSY1gXR1LtI2Ajssjfu4QqK3TxQpwahBGxCZgUkPhI8YXT0Ld3NqNu9w6+ecwlOsaiKfNaVfNughjOznAtaCCx6PsNGYzXm4x6Pp/6VCaxrsXrJmCrhxR7W7mQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840467; c=relaxed/simple;
	bh=CTYG+lF5FVzE66I2ZdZtw6ebyjdVagNRyj2VpuPJNig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmQCoi/h4bCiRY/jEEfIu4igxd3K/nuxeus9b/MkhsophRS5C3zl+LEpFOBTOnmEYqNgwPuuHr2dGgpdszoV+dJs4yK/YiqpYKaeGkfwkp09RIX+IeMvZ8myLzl8m7VMIXRMeuGL0gJ9cfRAgranYWKn6wycRl17clenj9ntWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbQMEIlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbQMEIlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D91F00A3A;
	Tue,  4 Aug 2026 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840465;
	bh=k8Yp+vOoP0w6LC3+gB0BaXXm041RjM5lhgAu/rY1Nxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbQMEIlLLsDSv/QCd4kf7cD0Xf/jtzaEGfLOU58rf75Oymb2abBG51eYBKxKmBTRM
	 VSj0k+OpFpOS1Wx340+kcOIoAzS9FS9+ErQ3J2o69VEzJW7nPI/O1VZf093PvhODM1
	 eBfzb5mKBGQQkScSqyQKJD7iKHh+ZjHysagz3FjspcN0JrUmYegGUvDLnU4ApaWM+Z
	 R6X9MEuCAH8EC0dgTOhRSFR8Atu9+tLOvS+OJV24fnqFp+VQ//P4mLg9hTnkzCV8Sy
	 eapRxr63jm9qGRKHlDgNTB6E2dfsa+K9bgW6GRD/9xmRr5WNWhQbmZdGvhkqvoysZb
	 2VKmks5rIPgKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] media: imx219: Fix maximum frame length in lines
Date: Tue,  4 Aug 2026 06:47:37 -0400
Message-ID: <20260804104737.2827302-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804104737.2827302-1-sashal@kernel.org>
References: <2026072955-retouch-favorably-ee17@gregkh>
 <20260804104737.2827302-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 2c4f1ba7354312ad2d6e34e70a518a51a9344715 ]

The driver used the maximum frame length in lines value of 0xffff, but the
maximum appears to be 0xfffe instead. Fix it.

Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 457d4d1ed4c2b..2b287c1f8eda4 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -72,7 +72,7 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_FRM_LENGTH_A		CCI_REG16(0x0160)
-#define IMX219_FLL_MAX			0xffff
+#define IMX219_FLL_MAX			0xfffe
 #define IMX219_VBLANK_MIN		32
 
 /* HBLANK control - read only */
-- 
2.53.0

