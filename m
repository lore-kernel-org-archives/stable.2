Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266B3A1E69
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879896; cv=none; b=G5NTeonqHyw37s9Kn1Ukfs/iNlQpgANNJU+CrwGTAk2zHGOgxxXBZDxCg8Vn5txr9VOBj+Oi1oIpJgTCKByuE1y2R0IQ7Cx8NibmYrwn/2CwQEcRO+Dm0P5WZnZmxMhmwM5J1sqPAYwhO1NRCOJV6KKzMGYMXXHnbB0fJou7hVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879896; c=relaxed/simple;
	bh=NU3782cVOybHYBLWoHmEeKhEJd3b7gxDgkIUQa1NAw8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=U0JdXws/XY5mEQzaVi4aJZMCTOUHT5runAnU2mfTZHXfVYVPK9I/V5n8QmmXB7BFJxKpDRTYfpYx6fxAIX611eGqVUgcE18tk2wHbqDDlxaEfq+gC+ZHjVF9WXX8TVmuhekHEFHUaZOXbbu9owDmlNOaf+ffVjUUsebUT0jIhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=E5e0RmCZ; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="E5e0RmCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781879561;
	bh=NU3782cVOybHYBLWoHmEeKhEJd3b7gxDgkIUQa1NAw8=;
	h=From:To:Subject:Date:From;
	b=E5e0RmCZmnFSIVKL40tyhHSkcLD/0QhRWf6LnyOW6nb+vlS1djsRl1msIdITxCohc
	 Xa2iRn4LYmxNgF4wybwOi0Hf5IE3rLlYjwG4QyJVztU7VJZ0meBB2CrCnhwY+VmEWd
	 vlkuMQcRHgCFHovPi+zwmEJ0ThdgOWORFY95BGN6sDTx9CgupImyStCs0l4gjE0B7e
	 4E8Vgzo5+pU+/Lp6ucwBZDygasvkpunoQNs6LyvqYrtXK8QqpjIAvBxSEMH2VS6YgI
	 YQrBGrtj8OF6Xe6qphlsyx8bAaMff8ufMW8lBySjFVVV+xW7r/mUNqBp8Os+Jo75hr
	 zaoGpQPfvc4Yw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 6F14B25ACB;
	Fri, 19 Jun 2026 17:32:41 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 17:32:40 +0300 (MSK)
Received: from rbta-spb-lt-115149.astralinux.ru (rbta-spb-lt-115149.astralinux.ru [10.198.55.79])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4ghg6c507Nz2xxw;
	Fri, 19 Jun 2026 17:32:40 +0300 (MSK)
From: Elizaveta Tereshkina <etereshkina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15/6.12] iio: light: bh1780: fix PM runtime leak on error path
Date: Fri, 19 Jun 2026 17:32:30 +0300
Message-Id: <20260619143231.678036-1-etereshkina@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: etereshkina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 108 0.3.108 b3af89ff4c48cefaff455d02ab4cd72c6de3312f, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203954 [Jun 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/19 14:09:00 #28254292
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit dd72e6c3cdea05cad24e99710939086f7a113fb5 upstream.

Move pm_runtime_put_autosuspend() before the error check to ensure
the PM runtime reference count is always decremented after
pm_runtime_get_sync(), regardless of whether the read operation
succeeds or fails.

Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ moved both pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() before the error check instead of just pm_runtime_put_autosuspend() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
---
Backport fix for CVE-2026-43355
 drivers/iio/light/bh1780.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 475f44954f61..f478f12640d5 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -109,10 +109,10 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			pm_runtime_get_sync(&bh1780->client->dev);
 			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
-			if (value < 0)
-				return value;
 			pm_runtime_mark_last_busy(&bh1780->client->dev);
 			pm_runtime_put_autosuspend(&bh1780->client->dev);
+			if (value < 0)
+				return value;
 			*val = value;
 
 			return IIO_VAL_INT;
-- 
2.39.2

