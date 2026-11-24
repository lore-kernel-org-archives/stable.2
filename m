Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540590;
	b=Wtu5K8Gzx3CC4LAvyLPDzE+I3v///iMI2J5OUI+j8ab5eBJ19Err1kTqT1Ey3ptwvLhD
	 4/hua+740/MGEyYMad6dRRGj4AMU5HVbkeJFAdkFgcBzify2G4ZnpWX+hVcXcwTDWp72b
	 EfQq3BRNkIaHSuLtLspnPr9AFOne+FRyEmKahwL6M0zazX6oCEhJ9WeDlicukwS+qaAAY
	 Z+zIzXwsBfyDGr529R7YgDiY6qCgHsnP6U8q5ugd92aw7QQiM/EHSWLv76wW3JNpCRNBQ
	 ljNlPcMaZwSTWeccTBXe0K7G8iNFWEM8h3olt7BJaOoZH9s3O9PUPWiuMh5nJkg5f7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=huXqvi2jm6yjb1/t9kBYvGCrzZFO+qOvfmGDlDYoDds=;
	b=kqQyYY/t17eYNovBICgaGXnynVxHCdyDxXYMQKBli6ZcLQkd3b3ez6v9V4gVDCsfoRqK
	 LaIMKTRKp4c/BwIlKHmTzuA+kkIHSkPZHvgiwyxuateiuU1ITbEKCfrduV+5zERoOmykq
	 hEPOmpJl9WNPdyGBCsnUd7fWLKax6fdBoz44Gi5JoEL4m+DipehyUGKmoBvyVrwi4mCI8
	 S0xZ4X8LDZoLcvCVdY3pxYmNHXYkjQHnigCldbjFlz51g6xpJl9AKKoHtFRIWyeATsJcD
	 OWimHS1lfZ29GoN4FwbcP52e8dU+UrE5mcQVvTB6IJ38TTdr4CiRE5nEOwpyp+IBuew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLueYk4l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC48606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLueYk4l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315E81F000C6;
	Tue, 24 Nov 2026 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540589;
	bh=huXqvi2jm6yjb1/t9kBYvGCrzZFO+qOvfmGDlDYoDds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLueYk4lvwgTPdmfL5XV9PD4n6BJlkmV4mAn+znKSubahjfKlma/ATK4YTsooxjSS
	 +Gvu6fIvyoDjX5/rrSOD5l5rcKiVv7GNuE7tbmtYbBsW/xucGSZrowa2gtexkvFVuS
	 oN+Zw2ZTi6vjpWxNZoXjLqLfQvWEolsawY0zRb3a061ukzxYiQdG4wVQbNTa2AVg5o
	 rFo/bW+KURvCVlnL3saKpV+wsgcrUC7Y7JomQigpWkxxuKFgjK1wyXfaFzpUcnjOiU
	 HL63/lPfJ1YiPZ7LmlfZn41Aiqaz8H/AX5ZN4L/d/9zuCPQyUZzfW3rDCdqNVVJ5Bx
	 GBHKHSDDYbCew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mmc: omap: synchronize clock timer before disabling fclk
Date: Tue, 24 Nov 2026 12:16:27 -0500
Message-ID: <20261124171556.1815642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112428-nullify-reactive-9011@gregkh>
References: <2026112428-nullify-reactive-9011@gregkh>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit c931c51681e33b24bc8d65c6df35b70e1827daa2 ]

mmc_omap_select_slot() removes clk_timer with timer_delete() before
switching slots and changing the functional clock state.  timer_delete()
only removes a pending timer and does not wait for a callback that is
already running.

If mmc_omap_clk_timer() is already running, it can therefore call
mmc_omap_fclk_enable() while the request or slot-switch path changes the
same clock state.  During host removal, the same window can overlap the
final clock shutdown.

Use timer_delete_sync() so the callback has completed before slot switching
or changing the functional clock state.  Keep the timer restartable for
normal request handling.

Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
[ sashal: Replaced del_timer(&host->clk_timer) with del_timer_sync(...) in two places, since this tree predates the timer_delete* rename. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index ee0940d96febf..973e6ab1401cf 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
 	host->mmc = slot->mmc;
 	spin_unlock_irqrestore(&host->slot_lock, flags);
 no_claim:
-	del_timer(&host->clk_timer);
+	del_timer_sync(&host->clk_timer);
 	if (host->current_slot != slot || !claimed)
 		mmc_omap_fclk_offdelay(host->current_slot);
 
@@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
 		/* Keeps clock running for at least 8 cycles on valid freq */
 		mod_timer(&host->clk_timer, jiffies  + HZ/10);
 	else {
-		del_timer(&host->clk_timer);
+		del_timer_sync(&host->clk_timer);
 		mmc_omap_fclk_offdelay(slot);
 		mmc_omap_fclk_enable(host, 0);
 	}
-- 
2.53.0

