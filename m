Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590554C4F6C
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359103; cv=none; b=Tjswu08EQ4PDhp+9/5FGbVyjaJBkESP5pmO9qOe9ndnInwHrXBLuu/uXxK5RZMI5JxPlPWWDDnqxohfwSaKDwlO8wcdqzyNn11X1uqzJrMKCA9daZCsxQbtXNKYB9qIlH7GOs8ZsqWR0fdG5BVKAZQJnkAtlVPEJu9I30jGTnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359103; c=relaxed/simple;
	bh=iOZHQT4IOAIyVGF4UgMZZiMxiLFANObxfB3HkuQmwoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPBlNzk0rugNW61UmtSOH8/HTewm1WWeXYZUd4vYBEO2RVcmnrX8BVdNc2rgW1VrEgiM492bDcPhsgCUl7JHIXFWHFUkF/nES9710Hyq8UUaf5sPaH1N/FzrldJ1VBDrk+76UCoFK8Jpr7L6Olm+ktM4CAsIe134pO7oh1Q/Xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZWgfEoT; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZWgfEoT"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso479165c88.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790359100; x=1790963900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJ/NQTl1WNpwK1sUwU0K8HlG1PwVQbHpKjHbUF6bYOc=;
        b=QZWgfEoT09Bisc5Fojz1pSZtBoSM4htRvJTQG8kGERI2MyI6EYlL6g0f7PunI+C4Fg
         MvyGgKYHzFegfvBCZxqXLoD12trHzahGYgylpfbHoiWeqwj78G8Uh2ZuISlkIuPUZzvD
         OUcH3X1feRGhGEwZQZ10uU+c2TBfGG77zPN/WS9iR7hCiRsvVkyrXbLB/tkgUSlSzXyS
         faVyYXZpgsVlK5bADQsOb3ezq6fs76Z6XhKiAGVNpSFY3xmNJw44kgXqDtp9scHQFN5p
         cPFTyyNQ120AJrbFf1Rv9aTqXwoUjW822i6kWcHVXzn3wQ3/P3xwqOzb5DGMKxhGv7H7
         E6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359100; x=1790963900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJ/NQTl1WNpwK1sUwU0K8HlG1PwVQbHpKjHbUF6bYOc=;
        b=NCyNgAPBPuDZZKjCDSzrE1ltTj+RjggtHmEY4XOm2kO4+NBD9pNlAuAaE8bYe+G7fH
         +NfUVzvSOBFWE1d57dTeOeWwwr53VEjXukN5IuxMT1vjRZNZZQ/YWdvtRV8/+Ytz1SJr
         zSgMwi6Li5VadN3WXjhf6mNWLrBFrc+Mh7k6/gF43qBXy2sraI8WYdp6y7sMwW3lmsGJ
         nfbjP9gr6iP2EGJFY8QLqwvrrU5D5nZYeq+WF1FYPJ2d1KIif2WeTwZzQTTdkBOzFjwK
         WKvrsexhv8uhnA4SOLejEqTDzWOFEraFU/ArOhACxp2vn7nat6NpthIuEH16JoPgPMoJ
         D1cA==
X-Forwarded-Encrypted: i=1; AKwUvByaoZt1oNq2yCQYIkOnG4sdsKtZ9ajf9lOUvz2XKRb3Sgmu4zwx+TcTMXg8crcebKZ6WnQsGsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m4LZboxmyrsvC1t+pIRRldgN0VAmHKjELURMDS3Vk4o1kA8tSL
	ILp1ijlDI86sLn14vAqbP9J4XPNw3iIXk6MH1gkKsX6XB5W/tNVs6gVx
X-Gm-Gg: AYBFou0HUczT21LE3ZBU7Ex23630sC42rDfNR0CronEGAfj5kIBPUQvpE6Y5jZJWfB9
	tai2ALWkJ3E0AI6lWQrJqnX34UJPfvFSrcza7jI4wVs2bk6szG2yaCO30SWdwudk44SVvfkHxw0
	ZdNMVWuCi/mIvdOLeLEIYaxChWLIbUU3vPqtfMqzpDTPbWb5Z6qp4Ki0iHWWCOUOQD8m0WRjryj
	+Pex2fbN+PTbEpvxbGTSVTHkG/B0jlxFrp5OxOMrfCflizk6pW9etbFnKngjxeriavMaSKyW6c/
	fpu1qs8gzj6NPeQEMQfPTu9BzT0/CHvYScLSQjRMxO/r2oipJp+DphpNHCe045h2ztiXGg5sFi+
	iUiOgWEGfcwWfSZQ71HaRkMiBGT2+Wc9YQpuhlhDr7pCVqUpfPKTt1H3Rtab1T7xOBG3fdIhOs4
	1saSzmpSC8lFaYmxMoQqQkkQC7jgCFyO83g/K2bb8My+fGsrJZTUQHJGxoXgScNklAGJW8g3rOw
	g==
X-Received: by 2002:a05:7022:2525:b0:144:f096:4dda with SMTP id a92af1059eb24-146d096d302mr1238633c88.43.1790359098946;
        Fri, 25 Sep 2026 10:58:18 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145727589sm7005744eec.23.2026.09.25.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:58:18 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: david@ixit.cz
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] nfc: nxp-nci: fix IRQ use-after-free in i2c remove
Date: Fri, 25 Sep 2026 14:58:00 -0300
Message-ID: <20260925175800.3694044-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_nci_i2c_remove() calls nxp_nci_remove() before free_irq().
nxp_nci_remove() unregisters the NCI device and frees ndev via
nci_free_device().  The IRQ handler nxp_nci_i2c_irq_thread_fn()
dereferences phy->ndev and calls nci_get_drvdata() on it; if the
interrupt fires between the nxp_nci_remove() and free_irq() calls the
handler operates on freed memory.

Swap the order: disable the interrupt first with free_irq(), then tear
down the device.

Fixes: 6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/nfc/nxp-nci/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -346,8 +346,8 @@ static void nxp_nci_i2c_remove(struct i2c_client *client)
 {
 	struct nxp_nci_i2c_phy *phy = i2c_get_clientdata(client);

-	nxp_nci_remove(phy->ndev);
 	free_irq(client->irq, phy);
+	nxp_nci_remove(phy->ndev);
 }

 static const struct i2c_device_id nxp_nci_i2c_id_table[] = {
