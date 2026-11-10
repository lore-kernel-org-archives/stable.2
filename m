Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279746;
	b=WpPwb6CHS0YsgFZZL8HFhKjhiBir0jBfXkfm9EOKqFJryEfb2vaiW6LU2xcuXuwoE8gg
	 QlvjZiRZAKIMyr3RKQihWSkTuw/7jeztkrnNYxrPZqwM9QdVbyLuTNP2v1VTWPH4NDuvC
	 9JguX2c05bzBA9wRonHT4BHFViRqkn3f8jJZSEkc4dIXIWFEopknzGmXUxwwK0qnyoVXz
	 eybwhmmxUhHnLlrHU0u1mzNmCpwECwo5e5zDgYKeyZLZK+OBOywUACLgjEUM/s3DLHE7z
	 f9Qx8SkoVjD7yG8LtdS4/dMAQu7NSNWoY5YP+clvOqgmqhfmO7GZxN3ysYn/kExu1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=lNlAAFeqvPs3+2DrLUisJfKXmiq6ODin2NN2Dn+TzsQ=;
	b=r0cVztY5e0OFR0EvwOvtqX0cA4kje9w4UekGTmztM7KQsp2oWAwOgx9t6ZbspSYGuSmE
	 mZJuV/bzZc0YGxaUCrifXfuquwVrijPE6lWGS/is1WJGHRCzG/CuE/pcgGxCraSxmpaWz
	 DRgTQw+JDYDeUf70fxEwXpTizx7R287HOk4G1Kl6ff6thII8y+6Xj9W26BWvDdr+fmS2L
	 vHrL5VAK4iH1Tra23Tz53iHT8w1VIdlwmHe0pIVWuknmETfSR/U0WaOsrknsQkPn5S+ad
	 a6MmMSa355flBNZVNrWdXQRIk8XxLBIH0DPHv82fvOh4SC5BRUUNeA2HRZCZqIxubcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gFbBk4Zv;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E8606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B57E8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gFbBk4Zv
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f84a55e31aso879051a34.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279744; x=1794884544; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lNlAAFeqvPs3+2DrLUisJfKXmiq6ODin2NN2Dn+TzsQ=;
        b=gFbBk4Zv4HAt4Wxj+pKFz4aUR6pmLgUYtSl9v4+p5Qa2ZurJFBBsdjonxf6lmsYMGa
         fRBWiOb5lhEaD4kGO6T5Y5PQcoUS9XbE1F9vVPW29HUDvlIdrnfWwAyg01diShoK77C1
         MC9nGnbpBtO3NTY3NiIVQO01wk6HO4x7tc7yKdoFJx5/YohrMKb+E3NhgShT6d6yJlhE
         YVR4qxvny/1di+qAfMiizlOUuwMc4DTKh373Drz2wT9jq56bgrDHiQaWJWMLm1NQdJoG
         xSqZmPpqudZoM2duhXKvY4l2uJ6/wrDCaJjI8z/DpE41YpddAghl1/6zJ0RBMcC35kYD
         3luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279744; x=1794884544;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lNlAAFeqvPs3+2DrLUisJfKXmiq6ODin2NN2Dn+TzsQ=;
        b=YnKrDkUz6i5YiHGR4beLV+F6suuzsPjiL+OjOrFSJHB0edLDr57vFOTiELloJhDftG
         rtFBwui7qklAm4RMD+L9sE8X+Ci0ziXlERXvTS6M+bNSMhZFydEnvVKt/tDyWH58FBbS
         MVCVJVjl3EnXhBXnCSWim9P2dCpYarwU5PbhyWpg19slc9/P1ys6UuLUowVlyTfXvqnv
         DG45iMy+yd9DlBHAr9us0hjxG/3GeHT6EHFqBwqvU+dDt7UxE+vlVv237r9OuX+HMKkD
         BuFkn9i+xQ/yuWllDP3cglaHQl19OPqSa4H927CnhKPTI1ZJBarRc/xY2hIEhQ8mdcKj
         LOlg==
X-Forwarded-Encrypted: i=1; AL+hErEps+K1m9ptnaaHMvwFK5yfmuTsdEFVgnmeEtfrMw7CD+qOnCy8z0tcjARD793zIrMqr49mtXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DZ9CuGg+efjb/riy9iRlUtolPta5vHPAfsGMPN5GvhmDaSoMW
	YkAw5e+gTyB6+zq6efI2a7BQSVBCX3hQsXWDIgEy7Aw6scqfaaOz4YLEruJ8j7r1
X-Gm-Gg: AYBFou0ILloUaAW2bH4YZ8S8mWHepXzOnuJG4jiYMEtqzycxtcNW0KZPEbzzw0940ND
	qPjaO/hHEUtoLC86HmDlcLkcGIfDh8UJZkn2o+Xq772xU6ZXE2gWXObe+DqIh3GU/F9VFqQZqBs
	QiK0O1hnNrY7DTM9R9kCifFOrTkXdEe7zoBnXr33LO2XvnL+hhYkxBbb4FbNkILH1kJoHRiyVYo
	9Wp/C6+U4X0IcB3pkMsOL2doRKpuniCVIGnLrcrpxRbvVC0sY36g8sYje57kSMDqmr8FWP/3TY8
	LLa7ZyC03FBEEbvJo8DTtfM32u70ptMmsxMPLi36ZH9lJtLm6ZhX8DRQH4LI41XzYwTyIm3rSLk
	+59DXCuONifJXKIU7j4iUPu1w1tv4xoiWtNlXGQU7PID8s6FhKnZrH6pj+BYa0qwFSDR/NPga0F
	oO8Lsyuvghn2cFdyvsnv97eTxB6mFOqtVHYEbVWEu0hBFJ3M/tWLTV65Zn+zqnQv4Gw03E1CKc9
	+k3RqV3QqHK6i3+rxKEs57TNXB/FdsSU+WLTH0IT22NO8oW5rqokp77yxQDA09WmDffYqbJFi0I
	4exBsOF28DwgB2zFs6jJ8WrVjS+RTxWEn0mEfI+LTAqIaVttQuoaOFB9DqHykRmQtdCcJI264hA
	M+xOYhJKbYkAk4kP/8Z8t/lWiuYmHToqbZgm3SjuVrdNaCMYb0HRvxJ9y4Dxr0wvY019EqGFGO1
	CgPFWfGelCaR0GqBKp8Wjj+ZJS7nFdmF9QXCxDfAjToRl3vEAV+R0=
X-Received: by 2002:a05:6830:913:b0:804:365a:bb82 with SMTP id 46e09a7af769-860dc818e73mr1351189a34.22.1794279744586;
        Mon, 09 Nov 2026 19:02:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbebfc6sm882545a34.18.2026.11.09.19.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:02:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:02:14 -0700
Subject: [PATCH v2] dmaengine: tegra: only advertise supported pause
 operations
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-tegra186-dma-pause-caps-v1-v2-1-accf568bf0cc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOwQ6CMBBEf4X07GpbFMGT/2E4LO0Ka6SQFoiG8
 O8W+AKTvcxm5s3MIpBnCuKWzMLTxIE7F4U+JMI06GoCtlELLXWmlMwhjFXLAwxUe1R5BrZF6HE
 MBAb7AJOCLDtblWppL1KLyOk9PfmzdTzKXUfIi8ywgldHhTFeeXSmWV8RSa5mR6c9Fx0Nh6Hz3
 23mpFbSP4viKSiMKSp1RZmm9l63yO+j6VpRLsvyA7Q7gp4GAQAA
X-Change-ID: 20261108-submit-tegra186-dma-pause-caps-v1-664d1320d502
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Pavan Kunapuli <pkunapuli@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: Rajesh Gumasta <rgumasta@nvidia.com>, 
 Thierry Reding <treding@nvidia.com>, Akhil R <akhilrajeev@nvidia.com>, 
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Tegra186 does not support pausing a channel, but the driver installs
device_pause and device_resume for every variant. Both callbacks return
-ENOSYS on Tegra186.

dma_get_slave_caps() derives cmd_pause and cmd_resume from the presence
of these callbacks. Clients such as generic 8250 therefore accept RX DMA
channels that cannot satisfy their pause requirement. A receive timeout
then reaches an unsupported pause operation instead of being excluded
when the channel capabilities are checked.

Only install the pause and resume callbacks when the matched chip data
advertises hardware support. Keep them available on Tegra194 and later,
and remove their now-redundant checks for unsupported hardware.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Remove the capability checks from the pause and resume callbacks now that
  they are registered only on hardware that supports them.
- Link to v1: https://patch.msgid.link/20261108-submit-tegra186-dma-pause-caps-v1-v1-1-9cc9b17a033d@gmail.com

To: Laxman Dewangan <ldewangan@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
To: Akhil R <akhilrajeev@nvidia.com>
To: Pavan Kunapuli <pkunapuli@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index e76c58f213d8..bd606b71e714 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -419,9 +419,6 @@ static int tegra_dma_device_pause(struct dma_chan *dc)
 	unsigned long flags;
 	int ret;
 
-	if (!tdc->tdma->chip_data->hw_support_pause)
-		return -ENOSYS;
-
 	spin_lock_irqsave(&tdc->vc.lock, flags);
 	ret = tegra_dma_pause(tdc);
 	spin_unlock_irqrestore(&tdc->vc.lock, flags);
@@ -445,9 +442,6 @@ static int tegra_dma_device_resume(struct dma_chan *dc)
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned long flags;
 
-	if (!tdc->tdma->chip_data->hw_support_pause)
-		return -ENOSYS;
-
 	spin_lock_irqsave(&tdc->vc.lock, flags);
 	tegra_dma_resume(tdc);
 	spin_unlock_irqrestore(&tdc->vc.lock, flags);
@@ -1518,8 +1512,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
 	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
 	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
-	tdma->dma_dev.device_pause = tegra_dma_device_pause;
-	tdma->dma_dev.device_resume = tegra_dma_device_resume;
+	if (cdata->hw_support_pause) {
+		tdma->dma_dev.device_pause = tegra_dma_device_pause;
+		tdma->dma_dev.device_resume = tegra_dma_device_resume;
+	}
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-submit-tegra186-dma-pause-caps-v1-664d1320d502

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

