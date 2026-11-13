Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562603;
	b=sNfy4wekBVN9LzjJAAkUJj4NspBPRX+Bg6zo6q349RDGfS7mkSaUe32cY3I914uTNlQi
	 n27SYCeNJ+bH7uSvvQYdX2d4+r2OC1JBGxp/9F7NGLmV8Hap8S/UG65Chhb5rLsU9+U52
	 AaRu5BU9LUI/ULuSUefE67BhAlvr+VaibM5/xXjjUSjgQGr6j2i8gwYWkW7dVFsfS2bOq
	 F+tDUfgZv1Vt8vi2yfWIOPDP/1MFKTZuwWn5Vn5RMcvluP84c8KkaGVjLPD88wSjSLNR5
	 1r5hqoX5pgMSM8ncuK0Qu34RTtqRdFMszrHkcAJKQ0Nbsiurhylph9ohVKcAcJ/9h6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
	b=HnOGyOIckX0yHcCilk/4oMoKhWxkMHmVVDSUesMZ+FeA3dyMrbbDg9uuot2vCkDfl9qs
	 NPEXZN/kUJzMZAR3g92+wLF54z2XlUYo6kpt7WiTgWQPDKWQYz/JL/fmaqVSnCjtNrQ7v
	 DnISoytpGvssPxUfm1qToDpx0YyVL5T6G6LJxFDhXZkF0qKAk6Mea5Car0zKTuHEWT/wp
	 VENw8udNxmxBnPGFo0Q1yH0K83SxDk4ti84cObq+Tc9bJTQoFeaSVydFmnH2G3BgTsV49
	 CL3xXV1ft7+ZEtC0zUcZEidH8yg9Oy2WOcxQdv+lNn8VhprDfXonnAToi0Pu8JQxPiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YZqKS8CO;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4257606A8AD
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4257606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YZqKS8CO
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4af81963f35so932239b6e.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562601; x=1795167401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=YZqKS8CO+L47qI+y071rEAYWsqn8na8lPqPIfRIuKVIskEb0dO8N2TTSUgOKp9OHMi
         dXOJjdntFBfJR9n/mWYCP2y3k+NFaz8kz3cxsxurmXBbaqQwH6PHFJuTuP8s+5dlBA6m
         VezmHGZCz2/Fxq6MbEO30+gLcJdoHDVcUZuFyjJNeZ0/WKBqN9y4ryFOabHueE3xEo/y
         b/qQdVwSgkKbEoWhcC6tI887c7m/N9chrlN+mQ55g8iWRuOWmbAbzXDSZwNGM5fjO5Bo
         MfltO8ZNnptKtZG5GMUZ92z0R2xaCxOhqAHQsAvHaeamh9uZNu6Ws6a3VTcwTY2g4u/w
         bVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562601; x=1795167401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=OWUYoTQ6gVpOJ9k5ZYtsyHHFn3XTI+kgv/UWLghSu4TvuL4b8oCvuxWv2jsBfVuaqS
         7PouksnMNnvzjTXoHs0Os/p46E1vvOdHe4YpPkODiXceCjFNhvpfX/i5VKDvqAqllfsF
         WG5tZavqULtUjobqdlPQxyQfjQptn5fKYC9c6K/eM3Ui+GCELOsYGvIvKa6H4v787j39
         9zUNywqkZnQ2XS/frLV00oIo+kaeATN3L2sxWXGh5odjKnTRf3yYikKaP9C7dT9Al8GJ
         fsjjj5DgZXQFMhXMVGJGASeZcfTQn9Cm1bCEbCAYsmv3gTmqBL1Yw7KnMADTPw0DXcKo
         RTwQ==
X-Forwarded-Encrypted: i=1; AL+hErEBEzQrIFxp8KWjgoeB6PsuumGoRrBmEF9yrZhW3q5ICDzCn9EtKwniVZPB1SuZTwWxMLj5Xpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TbCR6JePmUQTxXnhqKjW9XxPqJoLtpyQTo+E5uSEhhFMGITyD
	LYEbnSKzPz9mefzcIk03o5pXHyo87N/fniurLGae36yQM/y+06B+ud36
X-Gm-Gg: AYBFou1Po/Vagzvs/NQUaN7sDWdchQsSE/Hac0qyYCI/5WfS4+upYFEF4ujG1baOwWN
	2R5LBovzxI0RskGvzNjLsBGhsEG7FFRqwUSioWCVpw7KTCBFQIT8Pj8sTAT0oMylpj6SbcPG0Ol
	0u8iPG/RcmTfVJTo1aoXc+fv7IgyIC44dkyRjyAxYONm3xATwMLkDUkPXFx8weF47BY1JVyWOjn
	YQTQfUP5E6Ajx+BgTd7xlja6BHTzqE4b8h57TDZP8Qy0IsO5Eyl8ZivC7dkVzAsOuY3rsRiKlRL
	r4rxBj2UPwMfkYGQ8LtHODTFD8hKRpsauiORXFAhCsSI3LY0bJd3sWUJ0RjHVCrPV96WaW7f06x
	Z92ygxwPbkQM43lW04dZshaDLeCrVraKpcxbSaM68rPDYEUvQWuwctp0aLAiZPxnW6qxJ3Umae7
	q5f6USynbSaA7LYC5kZcpjsBcown/e4pPNH6m9nd6rN8T4mfsTEmiCLDSdTZVjY7uxGUSVwythh
	gnFvgePdQ8I5gRo0JyGfewh+jR3AQU60Sx1ZIkB4b0QdGAgILDvmd1ayw8+87DU9+TpvJFwYnhy
	14k7EHq1pdC3mdel0ZfheyGIeXpEbFF6t3Xgp/MVh1azLyQadWbu0K+r+otWQIV3eXN4j2nPW+S
	ea9WjFmuT/NHAOUMGX1fX0ITeYR80TOsr4KJNFThTrEuOmsDDPYi6HBYC/RgEPyqCun+QkkEf2t
	95oz4xbC1tU1qdvi6WxhlHmGDzXrc9enIE8cJortP2ZD/KfYYdACCQ
X-Received: by 2002:a05:6808:3387:b0:4e7:3fd7:2752 with SMTP id 5614622812f47-56e6530f73bmr1545762b6e.54.1794562601546;
        Fri, 13 Nov 2026 01:36:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc42a8asm1627607b6e.3.2026.11.13.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:36:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:36:35 -0700
Subject: [PATCH v5 2/5] dmaengine: dw-axi-dmac: poll the correct enable bit
 during termination
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-2-8523a27b5788@gmail.com>
References: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
In-Reply-To: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

For channels 16 through 31, the channel enable bits occupy bits 32 through
47 of the extended DMAC_CHEN register. dma_chan_terminate_all() only reads
the low word and tests BIT(chan->id), so it can conclude that an upper-bank
channel has stopped while its actual enable bit remains set. Descriptors
can then be freed while hardware still owns them.

Poll axi_chan_is_hw_enable(), which already handles both register banks
and the smaller channel layouts, instead of constructing another mask.

Fixes: 495e18b16e3d ("dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 6dae63024721..405ab9a78955 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -28,6 +28,7 @@
 #include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "dw-axi-dmac.h"
@@ -1179,17 +1180,17 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
-	u32 chan_active = BIT(chan->id) << DMAC_CHAN_EN_SHIFT;
 	unsigned long flags;
-	u32 val;
+	bool enabled;
 	int ret;
 	LIST_HEAD(head);
 
 	axi_chan_disable(chan);
 
-	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
-					!(val & chan_active), 1000, 50000);
-	if (ret == -ETIMEDOUT)
+	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
+					enabled, !enabled,
+					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
+	if (ret)
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
 

-- 
2.53.0

