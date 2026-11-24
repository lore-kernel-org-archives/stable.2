Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533119;
	b=4+KCHiUoF9PKLYGzxsOKdLeMthy/KKVPvP1Wdg5RNDS02/dhjyQqZlRQwK+zZSGcUBxS
	 1iseYhkdgBZ10DHE8Aly9pcdxqtR1rkLE9f5bj629xj5/juybZaNZGtK3p2VLu0c8xpI7
	 80AwIT46rZn1uSdOQE3EQMBPCWBd7vg/qggt1s/zhOwa9D4ds49Ulu+tCrnoajl118UnK
	 DE4yDyHQWHz3GoayipmEKZ3YaDozLd1nmg1GWwRq+Gb50amBnrlXBotiqNFrDcEPZlteE
	 GbZbFRJPe55y1AMFpaoc1GnPnqtnLxkCNn8yjFAemmYetExVbpN9ZAXbB2Dqt/MXVPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533119;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dVBxJrfBeYwnLW7mrW2TMXeZcX+3e7fcFL9VBp7/+fU=;
	b=uGa4X1ckeGfqfldcIu9W/KbsaH0f6arYdTmhEWa3CgF2dQxd8xyppeOQr3nunyU0vdng
	 wVaplU7yT9OnZsdMHCdMXK48fuxIPMY6AaCc6gEdoguritZWW3yTIWNZstUU1TtySkzrn
	 5nC1Hd4/sV2Ocu6lwomMjxrlOUVpUkKQnxettsHZnUo8wLJUFpyT37Fa/q90+JtaUpHWo
	 5PPMuK7VLtamOVEI2CICbGWIpn8xTZM1FPEd2DudtmQiJEMgrHliX984DYwYbuFvfnRcQ
	 i3g1Wlrr4ZgNo6nBT7YQlpTAwKvHUVK4HXsG690fUvBDE3sAWY3x5mv1RRam9FfOVFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tSj4uZf6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C3606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tSj4uZf6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C8D1F000D0;
	Tue, 24 Nov 2026 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533118;
	bh=dVBxJrfBeYwnLW7mrW2TMXeZcX+3e7fcFL9VBp7/+fU=;
	h=Subject:To:Cc:From:Date;
	b=tSj4uZf6vE0BZe6/cqy7jGTgJ/LOFlQq1iW7W+6PgFTkWsea6WRKBa6a/W+6BPxwD
	 mTZocgqiJ6OQ2GwjDQNQcyYUhrXbXf83B5gHBZTTXPOs2bVP+WktE18LcYz3xfmMsV
	 KFL4O7TXrggoCm+lH3uHwaxT+2qko+pqXRbXZ5rU=
Subject: FAILED: patch "[PATCH] mmc: meson-gx: report the longest busy wait the controller" failed to apply to 5.15-stable tree
To: iav@iav.lv,neil.armstrong@linaro.org,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:12:18 +0100
Message-ID: <2026112418-shading-sequel-d38d@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 18e9f7fb05ada68d491ff49165b9644f790e0e0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112418-shading-sequel-d38d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

