Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205615;
	b=v/g3mDmF81Qs6x4pd/jiJ5xVDXmP36PeY2D9DDqoZNV+xQhhvgwVRHr84UbzlvPEFLtS
	 uLfCdAsrndagAqbglK/NCySSQwFM6C5pkqcM37X7ueAJH7OXz24VFzgVfUIxsyPNmg4Ws
	 0Am9VGZNwEFNwHVtg3SHWJJpNMQULnQj/lK52TDr/Tzx+H1fPdQCyAwqq0HYHOfKvyd4H
	 Bljrw9v+4fWKT/B2Elypljy+Eup9r5JpOQ9ynquS9cX7ejgSkc/VVVdZFj+iGQJP4AQ9Q
	 bov2T+5wTRWvvVY8Qz2BoFd8bsu+fEIBn2pjBlnFQfY8aNc3hcMjqVX30XIjekBMeVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205615;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xNK2Vi9NFO/9iYCHLyiJD5QqWF332fhbH3KfLnc8vzo=;
	b=slHAA4CI0pHsWe8e+9a3xqRwUXP1DsGfP2H446HUu3WZJQH/5gOHkk/f9Efr9oquVFwa
	 By8PsGg271OFtpi99cT7joQ0NW08gPePQgnJ78Y3kIrk6WOkJoJk5e9d0f92ARmgKf0lL
	 zdkcQi++zPNeoj1sm+Vq+LXfOQfe9kv8a/0Cyw21ogs1TGgho62DnXPyRVIDWY/G95uI5
	 LfAHJCFAewgghJcmsypH1mC5YLlJYUZauoFvejGkzviDtSCHbp10Volmf6m0XZbelkEbM
	 EQv9JUbqoIK9I+xFrbcISVjiMJ48pn0aSFHuoS4DgmBYalDrZIYMEpVeEI5xm0ueI7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ofN0X14P;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1AF606A31C;
	Mon,  9 Nov 2026 06:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ofN0X14P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ofN0X14PHErCJTBzujTAEoijx4zfa3uBXMdJIX575Mu/BP5lKO9t/QfC8Jvteqgnhgj+V8sXg4R1w
	 9/U3RuMbULKV6b2PKtxxO4rItvn4VugJhXuJD3t1lxJkgmwlSQItpKmRv7xKFdIGj7HKzxzRswvlBr
	 9bI1I5inaD1yvHbM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af167aab98-c23cd;
	Mon, 09 Nov 2026 14:26:51 +0800 (CST)
X-RM-TRANSID:2ee76af167aab98-c23cd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af167a89d1-844c2;
	Mon, 09 Nov 2026 14:26:51 +0800 (CST)
X-RM-TRANSID:2ee16af167a89d1-844c2
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: linux-wireless@vger.kernel.org,
	libertas-dev@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: libertas: fix runtime PM leak in if_sdio_power_restore()
Date: Mon,  9 Nov 2026 14:26:49 +0800
Message-ID: <20261109062649.1321-1-zhaofeng2@cmss.chinamobile.com>
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

if_sdio_power_restore() takes a runtime PM reference with
pm_runtime_get_sync() to keep the card powered, and the reference is
dropped again by if_sdio_power_save() when the interface is brought
down.  If if_sdio_power_on() fails (SDIO function enable, CCCR
access, or firmware programming), the error is returned without
releasing the runtime PM reference, leaking it and keeping the
device runtime-resumed.

Drop the reference on the power-on failure path.

Fixes: 7e1f79a1f5fe ("libertas: implement if_sdio runtime power management")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current upstream master.  Not runtime-tested (no
libertas SDIO hardware).

 drivers/net/wireless/marvell/libertas/if_sdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1086,6 +1086,8 @@ static int if_sdio_power_restore(struct lbs_private *priv)
 
 	r = if_sdio_power_on(card);
-	if (r)
+	if (r) {
+		pm_runtime_put_sync(&card->func->dev);
 		return r;
+	}
 
 	wait_event(card->pwron_waitq, priv->fw_ready);
-- 
2.39.2



