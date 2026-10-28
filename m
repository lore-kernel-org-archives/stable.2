Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164254;
	b=alnwntjOt6vsBo3pqmjiwvMorsaDke/Wt9pVkWouiQjYcvnafNW0YlP00De/QJtdfhM2
	 X6Xw52PNcmL560cUA7+6mTEdeA921KFlXx1m+O0J5kUreRbAVEwZ715KVE7MtNowJKGzS
	 WP2xpnW7k23LAfGpeR6ZH9f6WFTfUPKsrJd8L1mCRVN/rLUbJWDqoRIYu9xbdtbFcaNZu
	 5GUO3ZlZcMvhcdqgii28+SuW9E9o/X4PGrPbwqxhkmXFo9TXJdrMLT1ikYpaCSwuby23f
	 TlG9woKEHbS9NZuv78fowpfshm8UatETzjtQ5jUpMyLWlv90DfnEsAM0ux+t6VgKx4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164254;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Qle6PKpbLiG+C4WiRNBNTT2whjds2n+JexlNVDlzam0=;
	b=FYWG4yojy2gZUUYM6L0AtaNk85YW7b6Xy9hb0J9DO91FmgpOJ0gQVZwqVVttiB/Wogyy
	 8PyFRKSFXW0l7PABr309cvyrvLiXA7AT83QbVxSPmw/tHKTlyTPDck8nCSehfaqI/HiRt
	 0Ba69avLdKXnpGX+YbvwJ0hpepIO5481LdarJevsP/4ZHxsMc/zcVnwZDR7QAHmf2yafW
	 /QWIaAaG+ONQu0pGDKlRiguG2o5DYdDID/MpXUmDj1quthG1ClLO9SziIg+6Mx18PfrLi
	 Aw3L2kjeO09Si1X0ybMr89f/YkchoB/ieBDiKU9OL0cCXF9+0OC1dXuqkDggrKzotDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ChhhHpem;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B6606A31A;
	Wed, 28 Oct 2026 05:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ChhhHpem
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ql
	e6PKpbLiG+C4WiRNBNTT2whjds2n+JexlNVDlzam0=; b=ChhhHpemiPhjJ7QdbR
	YocXYpYfTKGORXS+QOP/QukFFZn7tY57629/AghK9OpvcNEugXZ6wZML9MZp31Sb
	rNLNiZFAjc965gH/azNwvhuTLa/WQdWqe9kZEUFej4SA8S52MTrR/vJ/M98/KuV0
	3BykzNdqsLVIsDfzEzFC4f29k=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3f_nFg+Fq9cgwDg--.58935S2;
	Wed, 28 Oct 2026 13:10:30 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] platform/chrome: cros_ec_uart: check ACPI companion before use
Date: Wed, 28 Oct 2026 13:10:28 +0800
Message-Id: <20261028051028.142416-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f_nFg+Fq9cgwDg--.58935S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkWw18Xw48ZF1DAw18Xwb_yoW8Gr17pF
	97Ka1DJa1jgr1kGw4UJw4j9FWY93y2yw4UWFWxZa43Aw45XFyUtFyYya90yryFy3s7KFy2
	vrWDtF1UZasxXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uv38nUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgYlX2rhg8YI8wAA3H

cros_ec_uart_acpi_probe() passes the ACPI companion to resource helpers
without checking it. A serdev force-bound without an ACPI companion can
therefore cause a NULL pointer dereference during probe.

Reject devices without an ACPI companion before parsing their resources.

Fixes: 04a8bdd135cc ("platform/chrome: cros_ec_uart: Add transport layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/platform/chrome/cros_ec_uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index d5b37414ff12..779aabd16674 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -223,9 +223,13 @@ static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
 
 static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
 {
-	int ret;
+	struct acpi_device *adev;
 	LIST_HEAD(resources);
-	struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
+	int ret;
+
+	adev = ACPI_COMPANION(&ec_uart->serdev->dev);
+	if (!adev)
+		return -ENODEV;
 
 	ret = acpi_dev_get_resources(adev, &resources, cros_ec_uart_resource, ec_uart);
 	if (ret < 0)
-- 
2.34.1

