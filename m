Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511B569F04
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980131; cv=none; b=elbxSM/+ObPK0oz0KDVFK/ErveexMp4p8IUCRE8aMQ8odw9K/bMgzSTbaybK6wEl04oYiWpCigTsO/jR3gjKzcQRyZ6h48IGiZFmffJMfLj8kTp9oM7LoAXBCZFQCRj2JJC8RXurwyYI8Y/qH8oCr+8044BeWTRxX6XeG86StVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980131; c=relaxed/simple;
	bh=7BrlzvJ/67C26VtprYgh85NjjAMZ/nbJBojN8qB+VxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAnt9ZcE27l6byu6Itm3PmgeoQ6RU5RqcayctpusbDnik1B9Oa8FtYMoClvSE77oS0QOwBTC2zxvTiKC9E/haj34BMyBlspde22MYcPB9G0urVl7xtYajOsCM+hLjdfBwrQusdnCCI3kKHOPEl1Bq1zN0YxrwCWjuMbAQQvPtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy16QcH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy16QcH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA71F0089C;
	Wed,  9 Sep 2026 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980124;
	bh=F+9q5TEx3+6fgUTF/zE4UY+kc3DyZv733vCs5rsYYn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oy16QcH8rYd/qD7JaviRsFhoEnMd7i+jCUZEcrT0vXrXFCMcAbFoWI1vXOSETSj/t
	 yF63Le2ehPxxqY4ZtRwLyORQfBA/vWXeF366t9yMYCKR3+b/SkldovJg4uyH3sAoVT
	 WpwY0Jr7jQ5zCguy5qbA8UfmyPznvWiJO6futNuJrxe5nsp1f3CeFifxAyp6QNCMna
	 bJa8vRmJbwSOA9Gt2IOSapShFLdKRRHR/k9HoPs4z97Z0Ur8aj1FmJ23//oe2yizvM
	 R4BqqmxHehedu/RUowl/JHymvvDfPIu7oUGp56WpzP89pkuFslJ6hGdvdFnmq4ZJLi
	 1LPavtk1lk8eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
Date: Wed,  9 Sep 2026 14:55:21 -0400
Message-ID: <20260909185521.3490025-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-fountain-landmine-4fb8@gregkh>
References: <2026090344-fountain-landmine-4fb8@gregkh>
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
index 11b7119cc47e6..75b56fdfb216a 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -169,8 +169,8 @@ void snd_hdac_ext_stream_reset(struct hdac_ext_stream *hext_stream)
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

