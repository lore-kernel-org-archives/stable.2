Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164294;
	b=vE/ytMSvvV9cZQgIHHg/oCRtMmp4wa22W2HPAV3IWhmVAcbRndEYEPBl9JRUMAnNseWy
	 Yy0Gsgv7AQFVH28oGucTUkJC+26s8XXcFqFTzM/v5o4plRAvKzRl7XjyaPxC0UhBjZkhq
	 CrHMxVXxVV1bbOV2XyprRblyoP4rf+FAgo6XQbEdEb21jKTlTrp8BRIF/rW39K1b3um8a
	 h/br4Vk/ElqduIwQMZPUgW8QMD8OTyNmeqVZGEDGOSCU21H0wiF/x5EMOu5zcO7SPuBqj
	 x2Te4ce4UYRfAIPCvsgxHXDUCn8ynoB2Sk99rKnyeLt/G3MVjBObrGGKsblR8gorFXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164294;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=nYsLqUlsjGDEPJYA9NcU3HBE54LgzTei1eQnGwkc7PU=;
	b=3tEVz/muIR3Zch3M+Zrj+jgU5AQDlPQN+WmeNDfH2QINA3ReWXMf/zVhk9yvUe5UDtpI
	 HmeiChYiu/CBiyMjamcW7+kByZQfEN7jnK7AUFS5B/tArj2oWHbofw+Ext8Xireix/gps
	 HJa99Fx43mKfP10bL2Jx3ZNbeng9OY53HE0virkVQ/eLYB5rjFFnmFxbMsNRvBR5npgGc
	 gU2UR3dpUd7qdKQcoHxOOsLoIgjXhvipZn6v0tFTyV5ZpkbVlHMKNCrko11AzxwiXTqRb
	 tmTVRKKC3lEVNPM6YIaXJRpxjI6p4GG4kUq22mp823bjhm5DMvUNbAwL/Bpbma5RPuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eMsD6tmn;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E813606A31A;
	Wed, 28 Oct 2026 05:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E813606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eMsD6tmn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nY
	sLqUlsjGDEPJYA9NcU3HBE54LgzTei1eQnGwkc7PU=; b=eMsD6tmnGUEywxZmTu
	LNzSoXZpZnM7WLRAC/o9T6sIXdMH0GpvCmV2D1BnTQHTVzm6bJ/pZNySwHx7q0e3
	IYo8fzhACrPx0d9oYg0GkscEoumw+KN19aR3TIfaPPLU+4/5xVEDXWAHeJYIoVQx
	+kG+DbYYxkeIE+XS5ny92gW5Y=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnr6Tlg+Fqeq+RDQ--.25782S2;
	Wed, 28 Oct 2026 13:11:01 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] platform/chrome: cros_usbpd_notify: check ACPI companion
Date: Wed, 28 Oct 2026 13:10:59 +0800
Message-Id: <20261028051059.143646-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wDnr6Tlg+Fqeq+RDQ--.25782S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWxJFWDGryDGrW7Jr4rAFb_yoWkXrgE9w
	s7uF4xArn5Kr1kKr1Yyrn3ury3Krn8tr1fKFnagr1ay3s5JryxXFyqva4Dur4rJF9xZrnx
	Jw4UWrsa9F1SyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbIPfJUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQUtZ2rhg+XTfQAA3B

The ACPI probe installs a notification handler through the device ACPI
companion without checking that the companion exists. A force-bound
platform device can therefore cause a NULL pointer dereference.

Return -ENODEV before allocating probe resources when the companion is
missing.

Fixes: 7e91e1ac60bb ("platform/chrome: cros_usbpd_notify: Amend ACPI driver to plat")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 25da31ec1996..1d82c74583cb 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -105,6 +105,8 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
 	acpi_status status;
 
 	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
 
 	pdnotify = devm_kzalloc(dev, sizeof(*pdnotify), GFP_KERNEL);
 	if (!pdnotify)
-- 
2.34.1

