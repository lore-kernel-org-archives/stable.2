Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533127;
	b=Y/DN1cYlYyfO8eGoxwPKm9W1GIPS4jJv17v8FKjtw37PQ9lBMJYWypfeKkVK5cViD1CU
	 KsPcwZ3UltePDZmfz/8RwnH0iy1P2TDEArruljCZ+sWEhivlZs7TxUQqKhdYXK3YO5ekA
	 Zxf+wDJ/wWHiSuD+BzlFR9JS2zK6vfZuSN6CqHqPQGgToYO8NtSa4K5E/3Uq8zA6baap1
	 JYrlkDct5DB6PlP1S8Xqdz2+uNMrJvCovZ4qpWeMjsabws8IkeAhnP7g2s8teDU1v9ZhM
	 Pjolj1y4tHiChQAZ4DNYlv81qwnEfgwZwaBE//9xQ+JClYimEKKNmSKxknoRoHYWzhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533127;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/ZZbegTlr3GeN3JMgIrd9FHkjMame/XNJnE1jaHd0kQ=;
	b=MX9NffmUhEfwOiSnecaSA+bHeyVpELFAkM3P4BPY61BCg3JPVPg6tnpXHl/AajssFjK/
	 yGmplB2CX+cONpF/DT0dsLg1jt1NJdETXCdrz9CfIw8xZ0Ek/IW+qZpCl91W2sC84XNRn
	 bHalh5lrBXICTp+uXwcdMYIshxV7Cfaq9FMf/b4JpZGl8FVPtA5Emdg9QXs0mBExU8pdI
	 wtP2hJ78wunpXUnnK/i4wRpYxjpvGYtPxX76wMig2MVQyIAxBS2Q2B6Hd2t5YfjUGSXU0
	 KEDhPkxFjWAlsYAjRha9f7H8HLA5+4ASwuIz+sgbV7RXL99kfJuBbJE2/9n/rmdhEPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qsoSgoQz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40538606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qsoSgoQz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E059B1F000D4;
	Tue, 24 Nov 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533126;
	bh=/ZZbegTlr3GeN3JMgIrd9FHkjMame/XNJnE1jaHd0kQ=;
	h=Subject:To:Cc:From:Date;
	b=qsoSgoQzYnSgXMKoD5ez1BzojLuJpVnVUCe8RuuqEcpSIb6W5bl0jUR4crxVAgq8J
	 dmxUmbX+PoAhys8eqrW08UMowdj4L2U+oRbCIaRQ/WEaH1zedLqsCOmtVmPheNFrB1
	 H9/Xe/VtsSspLBPBOwuf+ebRDnvMP5Or31mHEjyY=
Subject: FAILED: patch "[PATCH] mmc: meson-gx: report the longest busy wait the controller" failed to apply to 5.10-stable tree
To: iav@iav.lv,neil.armstrong@linaro.org,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:12:19 +0100
Message-ID: <2026112419-tinker-unsterile-d556@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 18e9f7fb05ada68d491ff49165b9644f790e0e0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112419-tinker-unsterile-d556@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18e9f7fb05ada68d491ff49165b9644f790e0e0c Mon Sep 17 00:00:00 2001
From: Igor Velkov <iav@iav.lv>
Date: Fri, 9 Oct 2026 17:03:00 +0000
Subject: [PATCH] mmc: meson-gx: report the longest busy wait the controller
 can do

The driver does not set max_busy_timeout, so the core takes the host
for one that can wait for busy indefinitely and sends erase and cache
flush as R1b with busy timeouts of up to 60 s and 30 s. The CMD_CFG
timeout field holds at most 32768 ms, so the controller times out first.

Report 32768 ms as max_busy_timeout. The core then sizes discards to
fit and, for a longer wait, sends R1 and polls for busy itself.

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Velkov <iav@iav.lv>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index abdb12e5f997..49df33bbd8e5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1183,6 +1183,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	mmc->caps |= MMC_CAP_CMD23;
 
+	/* The longest busy wait the CMD_CFG timeout field can hold. */
+	mmc->max_busy_timeout = SD_EMMC_CMD_TIMEOUT_MAX;
+
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 

