Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200562;
	b=OrOGt4fZsO2dP7psyXJrTwzVA2fylV0T6s79Lam46KsvCi9wS49quCMkt+WoalzlPD2m
	 in++4TKdGn2LYBfKQyk7uynNorEAAn/r3PGyNsRikzZupKmpQT/v1FOlxUt9POpgU8tXk
	 +p0GvtVHBRRZBtzIEAfYAbY5u4hmFjRBjG4gfY2DntFzY2jz3UjEYABoS+30vQ/P5Aeks
	 YgTLxuYchlF5XSVXESndNR73x9pvk/urX+asMmkuFwNWIllZcBj2PJZLQT9pkwMAUIbD6
	 4eHefrdJtBzg37msPZLlx7fW/mHHRoCSwJZgK3GKM4819VFr457IhD9lRpiwRGFruTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=fmZWmm/0VCdmfPHxX0/wFVft9JJWsuY41pTezuz/3H4=;
	b=WP5B2C+l/m17Y8Rnvj+KLhp1XmX3PFNiWyl4kGQ0PnZfsUEyR3cySLHJyrb3Q4mmbK0B
	 wSoMzZBMsNRO1llTEQIcUoUoRpH+mIw/zHzLOXRIvFmqSo9rTvLYvL2Fq3xYzzoVD+0+5
	 QSJNbVKpLfAQm6WZLZaxmpGEwqgDgR8wgtjKBUCSr36kgvKL/M6is/cGYTRq85T37yci5
	 DutCAMEjXcl38MmMUmjnLb+D5xq36qN3I47aEc0v+MDcd/35V/OdcrKgzmdSAKnHYKUnw
	 WikYiVwjBi7j0kvS47xPQZWB5iqrJVUqnmnRYdQC1ScDgYDdv/4/DTl2yOKXo9kVwsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rf0V5p0x;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B2606A334
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 05:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80B2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rf0V5p0x
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-5641f26ce05so158268b6e.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 21:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200561; x=1794805361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmZWmm/0VCdmfPHxX0/wFVft9JJWsuY41pTezuz/3H4=;
        b=rf0V5p0xsdWdI/wOsBFvhtUY9s0uFE3whuPcHt8ilVnsyYKdD0bIjW/L4vb+DJ2bJ2
         krE4tztoopmqnDakpTWCiG9NHV2IG3Wngxz8sY2l+Ny8wHTgtMWQcjnc1YRnWCCDizyU
         y19eh8I93hr27leJlF4TvVWNhUIxxGWEcECp2EVpj4dUHu23rxAzAJYXM2bex7rFjrbO
         O3sH0NykuccDWyNUT69XVewENnC8G1sDIktCPRXtnMBiyGHCZumvGJxNtR4aPbITi9nh
         TtUZckqStcHNHJxitiftzGF/UwkwKzHKDF1De88CT+IlnxPMzSvU0KJSza0OcD6lSV8P
         /uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200561; x=1794805361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmZWmm/0VCdmfPHxX0/wFVft9JJWsuY41pTezuz/3H4=;
        b=h6p+Gm7+tnxmIKQQx0ebmb+lYWlCjRa7xkUzRPwHunKLmnGOO1NQ1R9SF9kNGsOagU
         Qt6B8ahhfT3IUdcIrX6N2PVQvYpZNZLrAGbIhV22z/8kWYHvRa8dKNuEWJ6jFiymAaQQ
         RK4tC9jy+VODofoI+gVwthjXo1nWQLd5W6H2vYKa+3JfS7VBmBx1o7mhPfQmHBU4fdVH
         7VqxqqVqmFl20tbq24dm8Sr8F9erFg88A9vED+UTbzhb0CCejWZptLZcYjlIiT6MwD9g
         OK7stJ4HgV6ldQc2i4JpCcWC6uISOwiOEteHJmuQ6uvBN3NVef80S3sg269xMP0MTY1q
         P5NA==
X-Forwarded-Encrypted: i=1; AL+hErFYRV0kwpZXsFZtsXsZ+nyi1Dym9qfQ0aprXxIcmMOBK9GEmOkOVfeb0XiZDom6d8X9ZVvCSk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VBuM7n2UJvb3jA30ip6zvhC3VsoQVWcDJ6M+L185a751w74VK
	IIuh9D91cSdRvylm00rbBMMhgn1hJgpES5iAYsLdnUI3JuHurF8p3BOW
X-Gm-Gg: AYBFou3jU6gZyRIQWfimiWqieilAAapQ8Jvp8Vejp/XAoTnYyDq612Fu/0jIm3hKC61
	jEbbrEg5RqnLU3GBjrNt/aYgjrzy5tQSLdz0dWPcqwD7tcIIso4rbElTq2NCeyK7p0QRZouDkkN
	ecw79zdFOfEJ821+M3rkTVE5/GZevo77iz7JR4nU/dWSWfRo2JTMbIEeuc3q8MnKjxILMcNXMam
	CVJXp4pf5Pi2zFkez9pQkMWWxuGgJv10mkXpTLFLX+7hmS5wxAx3HyH51uTWTdN49WH5PptqaxK
	81mi/dUpbTd+q2ZG0m+2TKE9e77Rpp8hWfi431oaKfldfnMO/LdQ/rUtJnA1IhqSdNrWzftrW/b
	4O/7uf98uZtYnK/RbbJ+xfcmdSnV/T6wne5l/D4LnIKNFi8+CKkszzRGt1Smu5xULRihGXKc0Nv
	xKhb1Xbmw7uTembLtS1EbFbNQIxwNChfdQ5hChkDdrClOSV+4i5DU5XdBX/c3EOV9mO0nVRoHEX
	P0nGI+cRDkmFPB3/7gaIckp4/zJGPSlradqgXsXPSBPwZkkC1arCGDMJXx0xIizUiPNN3dOCHqQ
	uB6LLZDe4MuknJVqA6Nuem6sYkD4Fy5ZdTk3BjfcSlekhHaHGCDp1aesMSxvqmpueWvoZehoEVS
	30dgRyLuCKIyRuDdZ8Lnk4SA8g67DKda2Ayqi/6jaFnDjQ5lu6lg/8cOX3bJbM8xMiWb+5GwESc
	/JbvrPtdMDRfUUP5MCuMQYCridIECTfh/2MmbWLtzstDw7dQ+VGyhF
X-Received: by 2002:a05:6808:f14:b0:4f5:e12:b47c with SMTP id 5614622812f47-5681442c1a0mr1599763b6e.48.1794200560806;
        Sun, 08 Nov 2026 21:02:40 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac6352sm3570841b6e.1.2026.11.08.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:02:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 22:02:36 -0700
Subject: [PATCH 1/3] dmaengine: dw-axi-dmac: poll the correct enable bit
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
Message-Id: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-1-c48ec19e9ee4@gmail.com>
References: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com>
In-Reply-To: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com>
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
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f55cc..49f65486e862 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1181,16 +1181,15 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
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
+	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
+				      1000, 50000, false, chan);
 	if (ret == -ETIMEDOUT)
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));

-- 
2.53.0

