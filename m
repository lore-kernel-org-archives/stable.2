Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD63B0AF0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980855; cv=none; b=goz4LsyM/2545vaq+GeHvJR5ZcPQHa/IeSC9CKRo6OGygIAuOeN7oFEx9RZOV/Grw398wKtjzQ03MMUI/U6BcJn41C9yTn3Lg02beq7tv2GEOgIgLmcVc2MXD9twREYdC6D6x0NmU9MsXHh1CN6sResxfddOsP5Y6KHQk77Ie9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980855; c=relaxed/simple;
	bh=lWtZW9B64jITIrIEBwKcj02m/YKU3hTT28o3FXTJ248=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A54u6Y5+hMMcxTV1ejB52T6Ou9b8FVn+/FEjdy8R0nVnRDiNWojzCLSluHfxl3PT0Ow6HKA6mDi2iKdoOqOzAY/YBRxYqoJi+ym814THWqW7d7ZAW93BzL188k7sp7Pk0wGC/nmUcr9D+5XbwHoZdS7MgqT89LfCFAiSRvil3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN7VzIFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN7VzIFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3051F00898;
	Wed,  9 Sep 2026 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980854;
	bh=z73KKqtNdsm0CxB/s5N9+4ogA9mU4Zg9yzX8B604+GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nN7VzIFOLLyobhLxKZpYVeZHPdk5c06IwXDp51jdFeH0sXhKdisj4lMaO7jGXl9Yh
	 IXfvavPNO++ljHs3tF2qeWVa0FDbL/8hwtTi9C0iAAN7m/qFK4buE8k/3rxLLgBThc
	 yVcNcZtYStaew54SWHupISk6C9QUXoYGT7bkb74Cjw1g/mHMu0Cvqp3Q9rvGtgLM45
	 zpZ/+cZN1xzPLSVu3rV6skfLycxGbitTxTB+ST9rS8InK6otvxjE+AUIXq607+bkJ5
	 F/6dPxa06nSqAxaYSMp6q0Iq9f3CnI3CjWmd8fCl8Pn6VsTahosHSiHvb05J6vhSYa
	 anCeXLgA0GkQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
Date: Wed,  9 Sep 2026 15:07:29 -0400
Message-ID: <20260909190730.3537245-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190730.3537245-1-sashal@kernel.org>
References: <2026090344-refresh-reissue-e253@gregkh>
 <20260909190730.3537245-1-sashal@kernel.org>
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
index d2b5724b463ff..ae9228d52da0e 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -183,8 +183,8 @@ void snd_hdac_ext_link_stream_reset(struct hdac_ext_stream *hext_stream)
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

