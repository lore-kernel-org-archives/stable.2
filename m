Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03E3D16FD;
	Thu, 10 Sep 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044787; cv=none; b=bzo5lNdeuaPu1ifYo5IBva97xClUGoTGYkbAIqejsCh5SLS/InsZKeNv4mh0w1NC4+U1CWLgdDltDSHPhgmWXqOwa9OyL7SMb59seFoLPco/nHMGol28J877Nen0ZW1EsAjctfdSailkMndX7WcWjvHZg0si6SfwEYQKuI2p7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044787; c=relaxed/simple;
	bh=lqTIdEaPrpwGl5K+cpZOtpgI5Wdv2a5OovOLiY9Cxz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXsQW+T4HAXv6rfbecy2Ow/sy5eCcGfxS+sjuGireUj3uMP9Lc8JFrHZK+yPngfWeQ5wMngDwNeGUTNlvRXZO7qxyK9GECaf2nS6OWhF8vDCSzNuqg0iU2a25jWpPw1kiaMbm0xD/8maAD8PHDc0cc2KTuXxcupc7ym3CzOIwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNNfCWYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNNfCWYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474A71F000FF;
	Thu, 10 Sep 2026 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044785;
	bh=ZAwZPihDUqVguGMD+e1WxJuQTdm2jQpWWVdsIj5EqYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNNfCWYTWUebqAFKXsVLyRZhODcZ2qx+QcZYV3Wwm78IszmXcn9+j/9c9PXs4d+Q+
	 7UA0xPv2dxq9IeqpkgP/O3wuoCDbHJkoEOhHL8RwcgRd/4gAxnY4YnoSwCfcsKXz/g
	 CN6fIzmZbmQvJ1ighItnJdozc8yB0zO1K01RG1yRntg5ab9Pt6I63XExcLjW0hIA6m
	 2wqrl/juqRYmdo6LepKFKLEzq77f7377A8EDFQ194aK11xwjYJFmR+kXksq9hOZb7x
	 KDeIq5mSpMkVW3lkz21KsuQsQd+lVsy2yTwA3Umgl9t1wniQZsmQUK1/WlMRbjSiys
	 5d0J0GA/HsJPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] staging: sm750fb: sm750_accel: Provide description for 'accel' and fix function naming
Date: Thu, 10 Sep 2026 08:53:01 -0400
Message-ID: <20260910125302.184373-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090831-improve-varied-70b4@gregkh>
References: <2026090831-improve-varied-70b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lee Jones <lee.jones@linaro.org>

[ Upstream commit d12dd1e0e3b96b1a2c9ffdb0fa9c115aeb82b569 ]

Fixes the following W=1 kernel build warning(s):

 drivers/staging/sm750fb/sm750_accel.c:155: warning: Function parameter or member 'accel' not described in 'sm750_hw_copyarea'
 drivers/staging/sm750fb/sm750_accel.c:155: warning: expecting prototype for sm750_hm_copyarea(). Prototype was for sm750_hw_copyarea() instead
 drivers/staging/sm750fb/sm750_accel.c:321: warning: Function parameter or member 'accel' not described in 'sm750_hw_imageblit'

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20210414181129.1628598-26-lee.jones@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: cc7cd2a92281 ("staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/sm750fb/sm750_accel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 8faa601c700b2..24b9077a634a6 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -131,7 +131,8 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 }
 
 /**
- * sm750_hm_copyarea
+ * sm750_hw_copyarea
+ * @accel: Acceleration device data
  * @sBase: Address of source: offset in frame buffer
  * @sPitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
@@ -298,6 +299,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 
 /**
  * sm750_hw_imageblit
+ * @accel: Acceleration device data
  * @pSrcbuf: pointer to start of source buffer in system memory
  * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
  *	      and -ive mean button up
-- 
2.53.0

