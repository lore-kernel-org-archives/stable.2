Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341482;
	b=sF4O8++6yH9Z/mU49+ULJu+OYceKOxuYf3nsb+KWiovFQ8QunZz35fIUefakyh/RaUdI
	 U5P6hj+KdfoiEVWHTUW8ywtnGe/E0C6bPu+Vo9xNsAkKkYILbPmlbY8jlYKG/yB0cNZNg
	 Azoigkx7XmtRUtv3efqIqMGiBxylWyn72yEk6JZoN1IoPYE9p0BnT1OUtoEjaTGkw3iAa
	 qlJEMYNT1f/HaYIu0Z+ouzvAHzbfoeyqI3vDpzc0gwsd1fZd4VqwkJREVPeZPAoxUBwfx
	 mJN8kV7xj0GeVewmmdt+BBV0v+bYqvHCn+GrS6hz3dDJDGPUfOejm+4dBsRtI3AXuHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EuAL+9cHbx7j9914yzuZfSc28LjNpYAUuLeRMc2T+u8=;
	b=Laxria28ibgcymk3Iot8XYu5pqlENf3JTH8ZCOpPXJshLsfqk21RMGCnDshEb57qHKIp
	 Gn3F6EbrQ3sjfLTSjENCmkWwWu9llIDWHV+yEO0RUDbUQctWKqlQkQNlfOQmOXrQvhnUy
	 pQzFN8Jb5qSjDA+8SVnEPDkX9fv1nTOhCz81AY3AFE2aeRGtX9hEeYwDIRcpYXvu4qx4J
	 oNE2JzyqIf6WXpsVJq5ahiZ2nlTZlZQIG61l/XedBirE+j8x8aPf08f2z6C6jv+wVRFLD
	 /p6miie3pKOg0VeWawSjl4C3WSN2TY1vC+/nULD9Ej2qR7RZ6FMgxqDZ4B2PqK8OO8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LH2oREEx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B55606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LH2oREEx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7B01F0089F;
	Tue, 10 Nov 2026 20:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341481;
	bh=EuAL+9cHbx7j9914yzuZfSc28LjNpYAUuLeRMc2T+u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LH2oREExmOTvA1XsZu0U/UGXlzkMtBKueH5W4kgEZrnNNox87yaOWmhvBJOuxi04B
	 BGzYyDms8NaZzpuHT7fWmsJEqWlt45a1mM58gi8yS5v3TOEKsQf6mMpRh3yyKTkp2W
	 YXfvdFnT2PQOqr9FkHt3Guw5SKJefqnXhQ9RGTkxWF4WiQ/PUqHg5Y55hhBRywxPaz
	 uPHkjJ6HyXMyaGpU8b3p1wPdf/sz76npmimmnCAjEcM733a0hBRAVeDPQ4o5IUz6Kp
	 jV/lM50TJZSOm4/7ubpYeMMuaJgiSJkbGthnKrqAgl0us7IrRTiiexCTvQgm8ntUgP
	 RaYkmlyBh3uMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chintan Patel <chintanlike@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] fb: Add dev_of_fbinfo() helper for optional sysfs support
Date: Tue, 10 Nov 2026 15:11:18 -0500
Message-ID: <20261110200947.3702749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051054-failed-6.18-317a8be73091@kernel.org>
References: <20261107051054-failed-6.18-317a8be73091@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chintan Patel <chintanlike@gmail.com>

[ Upstream commit 39b65316fe9d6d3f730632408ace28d49c5845a4 ]

Add dev_of_fbinfo() to return the framebuffer struct device when
CONFIG_FB_DEVICE is enabled, or NULL otherwise.

This allows fbdev drivers to use sysfs interfaces via runtime checks
instead of CONFIG_FB_DEVICE ifdefs, keeping the code clean while
remaining fully buildable.

Suggested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: 317a8be73091 ("fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fb.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index f622f5f520cf0..e50fc8f0801e6 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -631,6 +631,15 @@ static inline void unlock_fb_info(struct fb_info *info)
 	mutex_unlock(&info->lock);
 }
 
+static inline struct device *dev_of_fbinfo(const struct fb_info *info)
+{
+#ifdef CONFIG_FB_DEVICE
+	return info->dev;
+#else
+	return NULL;
+#endif
+}
+
 static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 					   u8 *src, u32 s_pitch, u32 height)
 {
-- 
2.53.0

