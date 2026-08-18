Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A43C65E0;
	Tue, 18 Aug 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052776; cv=none; b=IiGSB2FGDm9Yzk1gLWKThfwGIKdVUsWH3wRdGRcKjOKyHUasPSWnTsCiTVTKvgv0PDKki6/U+vu+3hFhJJBD5CLacWDO72rWTozj1iKJ6kiVbRmzG9dGOp5SZC9nwW0slHPSaQ6t1WwNaVdfqW6c989gYIRSTr31jnpuuKFSKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052776; c=relaxed/simple;
	bh=EakNYh9kUDyy5tnxVvIk7oHliuUk6LONJgb+cBSWtmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbJ0xcmFo0LkngaPy25O9oPC0Yq2c9QgGGS9U6w9+FyrsOE9Tabe7vUKUDWZB6YP6xto5D4AcC3/xLcT1bpbymXb7F4g3syoUJ1tyKTVjhG02XOzNG2N8BiD2/9R4e0MlOJBiAJhPUhsPbBac9iZrXsYIrx3Wkz8whq3qqE5wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bb4lDBQX; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bb4lDBQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787052736;
	bh=/rHXuTbZJ777DLlB13Eo79dpg7xSIMLf+a1wmQs1xlE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bb4lDBQXEfFnhH364AbZlKSEw+9HJiB1kLYdElIxjvLfv6Q1oMOfOikmhAo/Rbnyh
	 UIijrnWK7Y/tMToMXw9Kak4g1Q2HokM4sMyq+M6pwabjWyve9FRm2Y2aCWZDSbs+1r
	 ruQhOwvNSH6rZ8SAPDU6wyXIOh1INNpz5O/McUOM=
X-QQ-mid: zesmtpgz5t1787052718t8a59aaa4
X-QQ-Originating-IP: Uxaq1WO9BaDFSUMhf/L6k9leD3Dr3PtK2pNhVsKQWWk=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Aug 2026 19:31:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13596695146941906174
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: ulfh@kernel.org
Cc: error27@gmail.com,
	rex.chen_1@nxp.com,
	kees@kernel.org,
	raoxu@uniontech.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mmc: spi: reset bytes_xfered before retrying CRC failures
Date: Tue, 18 Aug 2026 19:31:53 +0800
Message-ID: <CD1C18732FB187DE+20260818113153.3521044-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NvjhxCSDgXICZuUYhqeWsHl7ZGbF0aqf+7bUt7Cs1clUpbATUFW69/DE
	KG/M29RDOx4BcitiroB2NSUZbc1DPdNO2e2QNfl8FtJKtmlUfti2Co0z8NbgwbMqCQTGtpF
	ebSfEgzIWKCTIr9lQkAvdcOPmdXg5UlSMwvjmdZDUSdU7Q68EzpEk+/jw8sG4cTUpznKPR1
	KKMShr73wkPJsgBAo3YItIo3mfjS8PPgMA8OudeBeZsp+l2NBeyBmWk8jPfv6+qe+OucQ7f
	vWTfkQ/FmbZZbdIApGcZij9KfCDj6V0f3FPifcNF9XSG0heo1ERv5RVk1hmc3Gqx9KVSUgS
	+P5pJK8Q7d6mYB9/Ox2NvTXQn6GNSSq1ID4fULg1qCob/s//IQ0yQZpKOfpYB1ze3P9kUqJ
	Qu+mDWOxgwIqwyYXg3hhMtOOrpxugjLgpDRlKCl+G4nJ4CCLRADaZpjEWuxPNQVWf93hh/I
	RYwNT1VUnEbR2U8IDWGs0g9D98BAxrGa5G1XEIwi1klJEcr+AoQHah31a6tCe8itcgN3rHy
	giqmriQrIaRfJa+IWQ4U46qtUyjounCGdSnraboFVszM425Yy+plVhR/ukj2F6q4+pMP+rf
	nxq5ZZXo/+09OBMQ2blpAIrU1BSF0HDhFjj8p/bnwO3keUsDhiCE/ZrFPYu27sM0z3YWPMb
	DWnsJkk/R3Atg9LQJDwxPgA7ccsp7iMAWuPeSOP5eTTIjjfly0KW4mNzyL07gguxh0v9HwS
	Ky8kbt1BmMauVx608z08DWvr9EzrVJQ7ZeHtaMQNSpj/lRrj0YOMFdThc5yjwFDNN5PZxKM
	r03Zx4KwBznrpdIKlvqWbt8uuIphe95sZFYHwk6LNVClZGz4TvuLOrpjahhdSUfFAjc0qDL
	9pp/11SYCV3lpuacXZucS3cmbidjYql+nptR0ATwHbzvVsp8yKUgzFjqpTgLgMgdXKhM3i8
	Soin02506yf4Z8cByf8jtaNOBuRP4S1y5un7yh+dAdvfloKvWgmcujDw3IO7QMcvpH1SRlg
	Ao9zKK7tJwZFMYm306bcbJUYl9c+fl2sOulwIY5dGBoL6znAbIISmymdZCU2+c9HFm2GKZp
	17z1Ubh7WEO
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

mmc_spi_data_do() updates data->bytes_xfered after each block has been
transferred successfully.  If a later block in the same data request
fails with a CRC error, data->bytes_xfered may therefore contain the
number of bytes completed before the failing block.

mmc_spi_request() has a private recovery path for such CRC failures.  It
sends STOP_TRANSMISSION, clears data->error and jumps back to
crc_recover to issue the same command and data request again.  However,
it does not clear data->bytes_xfered before the retry.

If the retry succeeds, the request is completed with the bytes from the
failed attempt still included in data->bytes_xfered.  For a multi-block
request this can make the completed request report more bytes than were
transferred by the successful retry, and can even exceed the request size
when most blocks completed before the CRC error.

This is most likely to be observed on MMC-over-SPI systems where long
multi-block transfers occasionally hit a data CRC error but the
mmc_spi-internal retry succeeds.  The data itself is retried, but the
completion accounting is not.

Clear data->bytes_xfered together with data->error before repeating the
request so the final completion reports only the bytes transferred by the
successful attempt.

Fixes: 061c6c847eeb ("mmc_spi: Recover from CRC errors for r/w operation over SPI.")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/mmc/host/mmc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index b471a7795b4d..5217d713c826 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -952,6 +952,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			status = mmc_spi_command_send(host, mrq, &stop, 0);
 			crc_retry--;
 			mrq->data->error = 0;
+			mrq->data->bytes_xfered = 0;
 			goto crc_recover;
 		}

--
2.50.1

