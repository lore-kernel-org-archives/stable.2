Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C1439AD2A;
	Wed, 24 Jun 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291546; cv=none; b=ZE0mHgH817CumDt/A3lZVwmvLeywDw8/4ijoiA9F+VRqSirNuJdF0w6/NVJ/L3NfyeVvf5qvVTTkTdl+EmFY4UnmvRq0f0IhxQiczmUoN6jFOE9vyDR030G5p+RxY37JGzoTGhSY7CX0Jj+fOSco8mG152u5nmufCWqle1XMN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291546; c=relaxed/simple;
	bh=q1yKq5xFWZZq8HfJQbkfl+0pICHYmFCHMauNv1dbPdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uMnffx7+epfyef6mVd0Tgdph2p/Ukl5TjSqgf7CseWyfx5w0qww3+GsDMaACFdjFhxKzgSRE2NBzVhkiXY1u024hVrmybjgj07QxIsKtuBrDIQ/BxPxTyX9Kx3dEZ5OaVvQtTSSCpRjPzOL0Ft0oYX6Nzhts9kjtwi3HI/wmrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cYb+wp9V; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cYb+wp9V"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 439346c16;
	Wed, 24 Jun 2026 16:53:43 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: dcbw@redhat.com,
	linville@tuxdriver.com,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: libertas: fix memory leak in helper_firmware_cb()
Date: Wed, 24 Jun 2026 16:53:43 +0800
Message-Id: <20260624085343.575508-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ef8d5d31803a2kunmb529f3b436b20
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSR9OVhlLGUlOH0xIGUsYSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cYb+wp9VIK/jZ0M07lze5FVnYxz/OsdariDViVt9frw3zLigrstBp9fRyZavzdSsil7zobhXpJsF9Zvi+E1BQ9u6/Jq91CsTp924tCtBdXxDboqaKYDywGpaZFPPtV+bmy2B718LjUBfGRZf9eyp6qcRKJwZKyetFnkJB5rf/gk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=pT0PSJhixHWP9s1HilDFom6gtr1zqVKS5vVqz9KIQ2E=;
	h=date:mime-version:subject:message-id:from;

helper_firmware_cb() neglects to free the single-stage firmware image
after a successful async load, leading to a memory leak in the USB
firmware-download path.

Fix this memory leak by calling release_firmware() immediately after
lbs_fw_loaded() returns.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
the current wireless tree.

An x86_64 allyesconfig build showed no new warnings. As we do not have
compatible Libertas USB hardware for exercising this firmware-download
path, no runtime testing was able to be performed.

Fixes: 1dfba3060fe7 ("libertas: move firmware lifetime handling to firmware.c")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/wireless/marvell/libertas/firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/libertas/firmware.c b/drivers/net/wireless/marvell/libertas/firmware.c
index f124110944b7..9bf7d4c207b9 100644
--- a/drivers/net/wireless/marvell/libertas/firmware.c
+++ b/drivers/net/wireless/marvell/libertas/firmware.c
@@ -78,6 +78,7 @@ static void helper_firmware_cb(const struct firmware *firmware, void *context)
 	} else {
 		/* No main firmware needed for this helper --> success! */
 		lbs_fw_loaded(priv, 0, firmware, NULL);
+		release_firmware(firmware);
 	}
 }
 
-- 
2.34.1

