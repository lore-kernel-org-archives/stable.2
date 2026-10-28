Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164351;
	b=4atxK9oHuIRVxSX3WkZp8trDKXdi0xkM8/i65aa+ZHVjDnkCK46CXVW8Ft9ofz7kxpBd
	 /7iOvKLDckPoPRQjSuvhsadE31/0C/oZokpepZH81Wlh/aMmcub94CHRK6TT/VaAtU7nD
	 r7ZcyXBFnh94NG5nibbaHg+9NrULPHe9/YIz26SdfK/8S8cJOtwp8tNiSyRj2hvHO7zfR
	 +BPKDvvVekgThq1Ju5RuFFETC9Q7L2LV3rYCu8aDBvISRt7ReiOURf2Q28vbag4Z2MFVO
	 vwVAs/sxQhDzgwc/6PMYmbjLOG2b/DEtDBR9JkXVfWRWrq18wvCLaWbIVtCePSvji/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164351;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nYsLqUlsjGDEPJYA9NcU3HBE54LgzTei1eQnGwkc7PU=;
	b=ph0dyB5/UzfAyHNXmZI7OBSLi0Fr3EO5OwY52eVflZ8ZQ9eS/vVOYh+xoUjsKJ3MVPcn
	 fdyDABhNcOI6wfZVrRIbLTs7wAXLKGx+GHiqjvQUnGs+zQGy7xxLD64ywivXnyr12ZV/W
	 JbTWmsGlxHR3JTXVqB9njbzuTnqQyBE2hpzorfKZE3A0+wea/GaHhZi8qKKT23GrDcFH7
	 wBCt3buU12oKfdFleFQ4pqWBDXh+tKJ+uYVJr06sEYeFrr0dJart82SaW1DtT4qAK1Ff+
	 PFf5VPky3gnwLtU6EOUTxwYAMsliqwq9QhDa81YLKcLgnM/xzeOnRIHm0GJN9h00zQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fV6ZoNem;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72D606A320;
	Wed, 28 Oct 2026 05:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E72D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fV6ZoNem
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nY
	sLqUlsjGDEPJYA9NcU3HBE54LgzTei1eQnGwkc7PU=; b=fV6ZoNemMxZy4Ah159
	PZBM02gXW0Z2/UKU2yRq1Z66OwflrcCSjUyzqU7HrJWCUBBFY31pLbiAJ7bLk/f4
	BhCOjH0mo/GfaTcPNCmnw2Jj2W9ty4flrfx0WSdu8aj7MKfPkgqs+IyP/SgQDFX+
	X9r0F6mNcZ9UuLeB1eYJUYnso=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDX_wMghOFq5BQxDg--.58804S4;
	Wed, 28 Oct 2026 13:12:02 +0800 (CST)
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
Date: Wed, 28 Oct 2026 13:12:00 +0800
Message-Id: <20261028051200.145621-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028051200.145621-1-yaojiale02@163.com>
References: <20261028051200.145621-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDX_wMghOFq5BQxDg--.58804S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWxJFWDGryDGrW7Jr4rAFb_yoWkXrgE9w
	s7uF4xArn5Kr1kKr1Yyrn3ury3Krn8tr1fKFnagr1ay3s5JryxXFyqva4Dur4rJF9xZrnx
	Jw4UWrsa9F1SyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU81qcUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wM8dmrhhCMLYAAA3h

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

