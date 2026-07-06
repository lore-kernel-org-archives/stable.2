Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DE40A933;
	Mon,  6 Jul 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343850; cv=none; b=VcrTb86adhBMInLs2ZqySBGhCV6mm/rC7TNFU+83z39PVpSVFEx1k4ZfNYXj/fMisrr+hc84r7xA/hcEC6uz4Q/5LB8iugbgDYVbH5joMTGN+joXmYjLDJY18hdeYPhfKC1psKAyDgp1MB1eOGLImbR2sil2kEwottiRjqTntwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343850; c=relaxed/simple;
	bh=sdK/bIunMo2jlgdfKxH+DwdzFngmIEIaJAKn96X05II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hL275q+9Skxc6PPptOoNYjDNWfI1VLjNG27CVEMnD1/AfD5k03+S6AwRZ3pRFWXyaMU+XHbg++SlHE/RJFJM3CMWaM9keoWWaQpjRHLiraEcioewmuCXtS7Q2lAjY+gHC18Kx9oOIB7PVdbCRIjqZRtBUk4dgl1e908Ff8GdBW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=EhBS5TGu; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="EhBS5TGu"
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:494f:0:640:ed81:0])
	by forward103d.mail.yandex.net (postfix) with ESMTPS id 2391FC0057;
	Mon, 06 Jul 2026 16:17:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp) with ESMTPSA id 7HH7Vouh6Gk0-UGOmfjR3;
	Mon, 06 Jul 2026 16:17:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783343838; bh=0//cNyPgkDdvk5L3OrxuLFpjjJl59Z687lOZPDLOfxU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=EhBS5TGuAg8RUUGciSFO5zY/8EAwd9pvBtzUBrV4BRheiekRBScVe1LAdVcLJh02J
	 9BAT2p8zCJvzsE49gHrWckoh4elv4Pj5Cx++2qan+xxKX2r2XnCih1uVL0pVmWZe+k
	 89XVJEenOHrs0IkigpEyVhEspgT37u+gIy6+d7+o=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@baylibre.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ALSA: via82xx: Remove unreachable branch in  snd_via686_pcm_pointer()
Date: Mon,  6 Jul 2026 16:16:34 +0300
Message-ID: <20260706131638.15311-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The condition

	if (count && size < count)

can never evaluate to true.

The VIA DMA count register is masked with 0x00ffffff before use, while
the DMA buffer size is limited to 0x00fffffe bytes. As a result, 'count'
can never exceed 'size', making the condition permanently false.

This branch has therefore been unreachable since the driver was
introduced. Remove the unreachable branch without changing runtime
behavior.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 sound/pci/via82xx_modem.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 9b84d3fb9eaf..b32f84ac17cc 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -573,24 +573,18 @@ static inline unsigned int calc_linear_pos(struct via82xx_modem *chip,
 		       viadev->bufsize2, viadev->idx_table[idx].offset,
 		       viadev->idx_table[idx].size, count);
 #endif
-		if (count && size < count) {
+		if (! count)
+			/* bogus count 0 on the DMA boundary? */
+			res = viadev->idx_table[idx].offset;
+		else
+			/* count register returns full size
+			 * when end of buffer is reached
+			 */
+			res = viadev->idx_table[idx].offset + size;
+		if (check_invalid_pos(viadev, res)) {
 			dev_dbg(chip->card->dev,
-				"invalid via82xx_cur_ptr, using last valid pointer\n");
+				"invalid via82xx_cur_ptr (2), using last valid pointer\n");
 			res = viadev->lastpos;
-		} else {
-			if (! count)
-				/* bogus count 0 on the DMA boundary? */
-				res = viadev->idx_table[idx].offset;
-			else
-				/* count register returns full size
-				 * when end of buffer is reached
-				 */
-				res = viadev->idx_table[idx].offset + size;
-			if (check_invalid_pos(viadev, res)) {
-				dev_dbg(chip->card->dev,
-					"invalid via82xx_cur_ptr (2), using last valid pointer\n");
-				res = viadev->lastpos;
-			}
 		}
 	}
 	viadev->lastpos = res; /* remember the last position */
-- 
2.43.0

