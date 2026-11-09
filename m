Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200001;
	b=PmExBsyKrdPvCc+RtilGyJmpDpGAfvPtmfyvMIWVJlbgidtU2DZwDc6d+cp376d2NkFZ
	 8S0goGPqUkhWL2q6xp/vcnE4ygeWyjqNCQTFU2b6qT/jt5fUkxxCO0eUdKsm/KC/amx2X
	 xSv69zf8dvG4WidPVnxEzQjIrO3Nn1JgjBYuEo/F2Z9bLrVSfU6SIvayVgVkiIbLzAik3
	 faRvHSwWf20YXMUVJv0WytWcEm8MfIeKy0MIJqTodY6cI1XhGYh+HEJ5B8yKWOvKK5fK5
	 AZ1+jZNMUj8GwHdrG+3ZdTS+Qwxg6v9JaFczLGM1Hyka1fi4Ev5tOKY3giZKSZGmcHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200001;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p7/QgpmviwHfjax+QkdbEV+4kJ4JiqjCSrBG/PO1GFk=;
	b=luaazchaVuy/igHRT4OVd7ksISmNeFR/ZZyN0cckbqLR83dpOfbjzqn9qGG11c1KEfBT
	 F1qQJ7mHZ2Dm/4crFrZJjKclMQre1optnohckPm2dC2SkYd8z6QITiieibnIbHpOB0G2M
	 JyytcehpHuU6TTh/Vaa0Gj0LM6QyH8mnqsOMqNy3plzLW7Qh/JCZGQMN+wKVbP+7DQUYC
	 zjHUgAbmQxGkwSqmvxtqhLl9VVWk9RpMkGVPxWn/9Z7+nEp73QcaPhH7MMSHRqf6/tIfz
	 GeJdFWWdVAn2oKtoNYlzPnooWJRC1dGjvJnAiHMZsMZuzRbcDQnQlOY+Kl8tAGx8Kug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EUKmgY52;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B266606A31C;
	Mon,  9 Nov 2026 04:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B266606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EUKmgY52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=EUKmgY52HfAoLeLPfvsSQR6UQVi/MHUQVYsEsbujlL2k29zFprxGChk59R9OOs4bGI2gqcwR7stj5
	 oWS8dGFnVDpOtDo0OieQhIukU4uitSXF1OUh2T947RjXUCm4RwgrptEpJDM/vW+iLgDL0BRvaTtaLB
	 PJ0V+/tCpWHl7/bk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af151bab8a-60c34;
	Mon, 09 Nov 2026 12:53:16 +0800 (CST)
X-RM-TRANSID:2ee86af151bab8a-60c34
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af151b9571-81ff0;
	Mon, 09 Nov 2026 12:53:16 +0800 (CST)
X-RM-TRANSID:2ee96af151b9571-81ff0
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	lhjeff911@gmail.com,
	linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend
Date: Mon,  9 Nov 2026 12:53:14 +0800
Message-ID: <20261109045314.1211-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

sp7021_spi_controller_resume() enables the controller clock with
clk_prepare_enable(), but the matching suspend callback
sp7021_spi_controller_suspend() only asserts the reset line and never
disables/unprepares the clock.  Every system sleep suspend/resume cycle
therefore leaks one clock prepare/enable reference, leaving the clock
usage count permanently unbalanced.

Add the missing clk_disable_unprepare() to the suspend callback, in
reverse order of the resume sequence.

Fixes: f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current upstream master; the probe path has been
converted to devm_clk_get_enabled() upstream but the suspend/resume
asymmetry is unchanged.  Not runtime-tested (no SP7021 hardware).

 drivers/spi/spi-sunplus-sp7021.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -509,6 +509,8 @@ static int sp7021_spi_controller_suspend(struct device *dev)
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 
+	clk_disable_unprepare(pspim->spi_clk);
+
 	return reset_control_assert(pspim->rstc);
 }
 
-- 
2.39.2



