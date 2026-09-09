Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6A39CCEB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979794; cv=none; b=dXfTj6yPBPhOxC2dAJXDK8zt2ydOBxAADFu0SUV9KGfgQBiCwlhEwq/JC9YKiL7xGRMyHi6W81XNX8ofhcR8d31TubnFj4WpKWFJu63GG3bycEbGUbqMIzxPzAsfqdbuPDmrjusL89oQUDfabOwQTjJ5fzsveNk1/gzga668niA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979794; c=relaxed/simple;
	bh=wCSzarYsS7MIbAFazRTnBBvBH4uPOR6pOYnM8S2bzQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOf/eFYnrGJgdlG4AJMtoyXQP/bhsS3m7H/QyRX/5GyPpTUjve8/BjOnkb5YSyAHVz7DOs5R4jMUfQECSdlo+gvomtYXyy2/CeYm3PMFhacC0cuZipZ1DBaGp99ZPNOIoipzN+Bl5GuxHtMFkUgiQ+IYwOqkkDwvT94Mzlg93pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfXWn9aF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfXWn9aF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B95F1F000FF;
	Wed,  9 Sep 2026 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979793;
	bh=gpvofhMHWQ4lsJQY0G4Vn3HHvGkMAw369ygVlgc1uQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BfXWn9aFpdpJzo/RkjGj3q4tljp97TR18WfMEMM3dgasCJ0Eo66j9aMWrbCtgvTkq
	 VASh65MFZh6KhawZbw+/1jTT1SL4nPa4mdoxZ5Ydp0G1yS7uo0wv7FN8YGRHYXheEU
	 kfApXA8Gdd1C1JcnjK7qSXv2rR+IOGbh0VFRk42+HYDYVTuwZxeltUNceBLReqDLTg
	 Cl/uttknkXKLFOxwlOvvhz46J/4kteDMu0xC2DubhhPNpOdmqe9vhYjsop3MPZ7iUs
	 R1vb6nsJplsrCSwwzKnhfLSvPei7uoiEtwQCAUm57isNkjcI6g44D4b7pWIGD4XKtB
	 LvCTkPi5YVq/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
Date: Wed,  9 Sep 2026 14:49:50 -0400
Message-ID: <20260909184950.3474376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-sincere-deputy-aa5c@gregkh>
References: <2026090343-sincere-deputy-aa5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit 36aa66de481d29edd63cbad9b5c4dc18c340fdf6 ]

snd_hdac_ext_stream_reset() polls PPLCCTL for STRST by masking the
register value with AZX_PPLCCTL_STRST:

	val = readl(...) & AZX_PPLCCTL_STRST;

The same masked value is then used when clearing STRST. Since val
contains no bits other than STRST, clearing STRST from it always
produces zero. The subsequent writel() therefore writes zero to the
entire PPLCCTL register instead of clearing only the reset bit.

PPLCCTL contains other stream control fields, including the stream tag
in AZX_PPLCCTL_STRM_MASK. Those fields must not be modified as a side
effect of clearing stream reset.

Use snd_hdac_updatel() to clear STRST, matching the existing set-reset
path and preserving all unrelated PPLCCTL bits.

Fixes: df203a4e46f4 ("ALSA: hdac_ext: add extended stream capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/43BB7930B0F07C09+20260813065524.1955696-1-raoxu@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/ext/hdac_ext_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index a3ac738f1130b..f19cdc1194f1b 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -212,8 +212,8 @@ void snd_hdac_ext_stream_reset(struct hdac_ext_stream *hext_stream)
 			break;
 		udelay(3);
 	} while (--timeout);
-	val &= ~AZX_PPLCCTL_STRST;
-	writel(val, hext_stream->pplc_addr + AZX_REG_PPLCCTL);
+	snd_hdac_updatel(hext_stream->pplc_addr, AZX_REG_PPLCCTL,
+			 AZX_PPLCCTL_STRST, 0);
 	udelay(3);
 
 	timeout = 50;
-- 
2.53.0

