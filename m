Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5965431499;
	Thu, 13 Aug 2026 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604193; cv=none; b=VhUBjht7PjrpspcX1sp8otQXfHvoxOmW7j170VS8i+GySdwyfqnms5QMm7XBBky8AO5B+9JueOvEjnfcLKztT8Naoprc8Xa5K7arnAUJvRkylp+zoGxjCX5ro2CF8n7KuEId5drefFPGMGNsKo9zsFn69v+2R0yOfrNAwe5HxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604193; c=relaxed/simple;
	bh=SP5GqW4m1YVdtCMSpHE7ag5yOxc7xO9DM77FT6iFJMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jj2syKkY7W3B1A3rAaye5Vnw+oap6/lsA5Z74N4OQO/DD2eP80Ez7Cm+5P//xnCrPuK+Cj6lFstqMl8iWsTkJUASqOCmpJfrMlGyhemeqUfOg2S2Q6lhoYbLBrxHBkF9wYDpHEh71K1w/DixKA1/7chK2iyTTS3jcAn8esQ4saY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eNxYy0mL; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eNxYy0mL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786604145;
	bh=XroxsHEEQrQoXSNsUELbrX43VGX/h2TE7Wlc+SDX8hs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eNxYy0mLKDAz4/syHAdXLiogBP34Sob8AjAZsTKiQjHQN+7elNBaubtu85OnBfpfj
	 OeuhjTR1Z/w0Y8DdR+2vTBW8G4xTRAj+C2fh3V3KOLPjHwnR1UQMsMn9kXGBVZo0bA
	 y21FT6Rypc67/wj+MCxtz8xXqqk8P0+oZDH3784M=
X-QQ-mid: zesmtpgz8t1786604128t9a3dbc2c
X-QQ-Originating-IP: XKS4LQ683l3tR73WJcVL/Cmdla43ZnnlLXgcGdRooIM=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 14:55:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4120267061097452523
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	kees@kernel.org,
	raoxu@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
Date: Thu, 13 Aug 2026 14:55:24 +0800
Message-ID: <43BB7930B0F07C09+20260813065524.1955696-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OZg1hzYlSoBD8M41PTlkwI0sRotw9Oh7J7V+pEXtqRZsixZzHxW4dwE6
	llQXYM5mqguEnr7C4RRPkjdZo/WeFs6xvXA5TP87t3pq/RMEA59AHWh6rxOW5uo9SFLnpST
	OZE4J2gUZiJC8rkIk62gsuWMNSpKVXU+DIn6BpKjnaH+TegEZneloSDq5FLF0YVMLrlTxAB
	gEFws2eEMjdgPENqT+uGtO172ehRelQ5vj5Yt1NIkxb9TSyZf0v52K2YULN4sdzrrkNCy8D
	91gj9fAoOS7/uWlLBZ+q1YRuUYK568DLA3ZAlNSILzDHNSA/zvrtX3kxIJAkWnWoJeko863
	Bt0Hb+qcNE5Zv93sfh9UEahzeI9MvBY4mWrAV4utdkWPx7aVQR2RvEPnwjUGRvSzcpiCLdR
	/DxWrnuuTRfP4J0k7V0RKN2A5qDtj9RrY8VEeAeRxJWtxvQ5OOOOslURGQLoizfdRHlvYc/
	DW6zRBLwGr//Z9CO6G55qYvv7NRrDKoyuJkgTbBKzUsnYI4gPDZ97Y4Gai4gu74JkwkQ4T4
	jT/pIZ4a4wN3B+GU2tD+ThWIbwrPHg9rhZOPFPmVjY83iKttcBYqsEaMAkpTj0Qc+vj3v2v
	U778XbHX+HmNmjVKJJwXTSM0dCvlTXpJcStziAmfdqhO+BXCtoaNMsY3amQNBPJ1/KUT/c7
	yT/R6f+jKAkaidUdwA4JBiiFWyhqwEC9NHG6NbDUT6UqqL6qxjh1e/V+5kUyNrkHNOsPQOp
	SiRC6pyllTmlOTwqolpiZc6BS1gvnDncaWtHMUoIPX4W8RK/ppyx91gRL+EXDni09mIooK2
	skuquvsM5hf9xG3a92UMP/TCZ4Tju4aKPC0WIObcSGKsCCnPAwbPz2hdg6VC5Eh1mifI7Uj
	DXxyd06ct9cmS53gpSefPP3lGqwRF1eYQ1Spkr+s8qrXYtRGiRE0vmPooo+KGnQKZGqQvNW
	GZ4+uGEYx+wmmtSXZr6mYf0s4h8w12i/9U/hxPtgiFKssZxNSx6lthuFJGDreVXSTt49sfR
	J8T6+XCknGUcmjHkkvja6uJ6BiB3n+W6O2d+u2Kg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

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
---
 sound/hda/core/ext/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/core/ext/stream.c b/sound/hda/core/ext/stream.c
index 4c7506d49f55..517bd151fcc3 100644
--- a/sound/hda/core/ext/stream.c
+++ b/sound/hda/core/ext/stream.c
@@ -210,8 +210,8 @@ void snd_hdac_ext_stream_reset(struct hdac_ext_stream *hext_stream)
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
2.50.1

