Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283003B83FE;
	Fri, 31 Jul 2026 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495283; cv=none; b=ZGSTw3atJ4iw8A7cmFsTSxbCDUFpgGRXrBNSG303hH2NcelA4x8qlw32Z0OX+rM9kIX4umiPt3aD8rdez8WSTBBGOphl9XHVMc0icCWrLMOggqYcMOrUTVe+NBZYuBEe7Jalskr5axDGzVnq3TtE8YvLm2okYMeq8SNkvqPySXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495283; c=relaxed/simple;
	bh=opKORBieQve1PBtOwkTqy4ayYxkg0xZx5VbSMhf+Fo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tvbvKrbzJhoZJjxL99EkXL0LioBwh5WBMmHE4CCIPwZkgkLv0Ll8WZyJpITGKMWpKGJA1MP3gfo4DNOZW1AKGu/KL/dFa4Q2728GncNIhPaAodGUl22/GgigCGNe7vwLuEX4PrVQ1i5+Hib3Zo0++K/zmfI7XMpCdMkxGny6q3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BBQowLeK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BBQowLeK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CF8974E41048;
	Fri, 31 Jul 2026 10:54:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 876A06039A;
	Fri, 31 Jul 2026 10:54:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2ADD811C166EE;
	Fri, 31 Jul 2026 12:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785495262; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=PVfTgw5RIOrG0Sy53AUsU/OG/wjlitk1KG+YHSlD8QQ=;
	b=BBQowLeKYPdiotIGFnRSN9CjBzZyEk/eT+yLVf3CdtGiKu8+xCoZtMnw8R38cCT3FdnSac
	iJuNIh2T9fEka7i9J/y5gLiVJO5sob2YtmhKIEWMn8kG371RnZk2pZi+STEhlP8rZkr+2c
	VswE2O9p2+tCsQGVcAV/KodZAP9emxpZoMGwT+s1wqpyaVlNI7uEEUY7UKdXG0PZpa5LYw
	pR28SDDJHWgk73RsLlbfL9TCQ21VGeOuXRUfh3Bm03RSvoZqe7DudIiH/Bc4aifFBRLD9a
	LgnXvNwJGNT8tRNaExeWw9cWfkNnI+FsZsvx2cagWULaum37BU+Lw31gjL0NIg==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Subject: [PATCH 0/2] spi: cadence-quadspi: fix probe error path and remove
Date: Fri, 31 Jul 2026 12:53:45 +0200
Message-Id: <20260731-cqspi-pm_runtime-v1-0-ff0bfc9e8e56@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2MD3eTC4oJM3YLc+KLSvJLM3FTdRItEw2QzQyMjSxMTJaC2gqLUtMw
 KsJHRsRB+cWlSVmpyCcgcpdpaAIH1BER0AAAA
X-Change-ID: 20260730-cqspi-pm_runtime-a8a1c6122944
To: Mark Brown <broonie@kernel.org>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 Pascal EBERHARD <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=opKORBieQve1PBtOwkTqy4ayYxkg0xZx5VbSMhf+Fo8=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqbH7biOcDH24gqSmcosoTEL+bogfD+O6wVshWj
 0GNijhq/OqJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCamx+2wAKCRAGvnxbVl7J
 RYQDD/469bGLM35Q+R4GOElEYpojPrXwKnXu6goXfESIkwZPDETF+NHqEoTSJ+QS6L2H+OsvhuC
 wPAi2UTebnkw3i4KHmJWbGdszfOLhuXTjSRXfwMfA4IU5NU/9J4AF+qX9GxT+DzdaoAaWG0nUfj
 wAFR3KOcnyixvaHbIyVDwwpLxRJbpOrEYpYE3fBfZlTZ+pcvZn+FhNuTjzAIzrTxFbd3vhV2lxJ
 XzC76u3YU6rx2LCqyQ+P8sV0bt4ne42pL+otail8oHhjPk+UOmRQ8y/iyZHxHgqbLDRoOqfasvv
 4HNcV/P4njHcPw7OxKI9NBgA66T3rpkRlkiTJUo4srMr432PUAsMnvDAdWd5z05rYM7DlRS5jht
 QAp07uVOND3XsQdM+W4yQWUqu4tp2h07bcDgrcuLi2SRLUg45QehyNC6eIhHjanHuDzOOmh5HhM
 Xyut8h4g+5DLxFvM9M17BLgis5fKxQ15s/4uWt5ViZIQ3CyyWV+nj41rsLvH1ejehIq0QG42C85
 BmpOo5B6kUQwy54OMLFdEplCKAbhlGoEH561nhMw0rpoktzs+PwEaiMLLkWaBrxjZaBPnuZcGwd
 TfIuxqGN8ZFzhEp1ENcKPJmLp3JtkRdFpNG4CjEA2yon0o3koLtC4mFzAb6ruAJa4XwU3qNWCzA
 xvLc+UcFrqjRx9A==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

This series fixes two resource leaks in the cadence-quadspi driver's
probe error path and remove callback.

Patch 1 fixes an imbalanced pm_runtime_enable()/pm_runtime_disable()
pair: when probe defers after cqspi_request_mmap_dma(),
pm_runtime_disable() is called without a prior pm_runtime_enable().
It also adds the missing pm_runtime_dont_use_autosuspend() in both
the probe error path and the remove callback and a missing
pm_runtime_put_noidle() in the probe error path. This consolidates
fixes from upstream commits 5ff4d5d1af0c and 5e8bb0cc72f1.

Patch 2 fixes a DMA channel leak: when spi_register_controller() fails,
the channel acquired via cqspi_request_mmap_dma() is never released.
A dedicated error label is added to release it before the runtime PM
teardown. This fix is one part of upstream commit f18c8cfa4f1a.

Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
Diogo Ivo (Schneider Electric) (2):
      spi: cadence-quadspi: fix runtime pm cleanup on probe failure/unbind
      spi: cadence-quadspi: release DMA channel on probe failure

 drivers/spi/spi-cadence-quadspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
---
base-commit: 52a355b23cd2dd77b683ed1a1bbe2b7408bd9c74
change-id: 20260730-cqspi-pm_runtime-a8a1c6122944

Best regards,
--  
Diogo Ivo <diogo.ivo@bootlin.com>

