Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808882;
	b=ZgMmnW6TIkPplB/J2fiFMMK/I66Jy3oaj2NHKs8bGfFCTP6fwzSHep9vCqbMS/nH0zv1
	 h1Rxr2iDbXd4dJ/wfTMW2EsFKfHZ7WNJlzTDjBrZgCWFec4RrNxDCLI2hQ9sd8/ZwUyJW
	 SL9AeMXBRRjCywIsN5gnACvylZOfRNgjOm7Q+EIqteG3PVDx+CXxdCQ4E1AHZVRPohaxN
	 G4+OkpMJBiIGUzSHU/UjdEjMYLeI5l+a7/mMj9V2cWIp8XFjaizLJck20pymVcfxRuJ6F
	 qnDL48QHM3+6wcbahavdbQ1Yf8U0vllUUhDzn1QmvlOGB8RoMR8DsQJ1inCOMkGzTYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
	b=g4xnWaDYs5uxd5blKvKkjta2Nbia/zO8jVH4IRp4STB7dJn84knBEP1N59SaUgEMYixY
	 Xr7hQ3myxyv4MDUyp5Q6uCu0kN4SlInl8cSIkSu0ZLOITP4AwLi7CPKSnMuWWezUDESGo
	 1vK/TghjHm6z8mADyhEk4niqAfUso5HPH+3O0pC0btIQYyYEwgDGGh2e6hd+arcGxJt9y
	 mTsRpOxh/kIoqyAqEno0aW0XEsR6fdzfjkYZQ1GPV5KDA/OBoSvV7BQV4DIyK0rqkCURG
	 jPu38rG+2zjElyQOBv+jTmpOkhSbBvo9vkOFwT0+89zMt07j78gpyn9kviokHm4Q3qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P/En0gAp";
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027A606A884
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B027A606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P/En0gAp
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6d68de53053so1967735eaf.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808880; x=1795413680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=P/En0gApUmL5JhFwKBSaELY/MyPtlTG9oUUc0wNQR7tScXvNx5NPcpZYtaPjCOuY0V
         EDAz5K6zAy2NyvfeADsaEc5U5TRNrQKw5LykSnWVojGoqySha/TLWQ9yUcgS7LPZelzh
         TgIbcvM1useOztFvhRS1oqywlg13+TWdsFy7hAfeheFrync0py+c1+JGBnPVmDgxyVsD
         w/HQU5KEtHMNBziDhQihNh239boXBdQU6tyXnETicm1aPtN3DDrMNtPOaj/C2zy+QVt5
         QgJeiC2GK1XEbVc70GGDVYZAN6xFmjP76YEqi6eRNEPlocHD6UhOMKgKU6iunGsYg2Q3
         bRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808880; x=1795413680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=LCaYlcfUo/Frb6WxB6y3PTWXQdHwKMuBiQvylVn/3eRC8JjzCl1VgpcOs+iIEssrL9
         kqENiNGVTleyI6qPBJlVatMPdehNO+MoJy+X5yLAy80jnUae3cyUUZwu+FxpwawuY6OA
         vfxjWs63LnWD/V2VTH0xxuHzrRSOccXZiAKTRk547mN1iVgrbh+hmVzi5x/c8vuMUs3o
         AjSfN/6eK5WO5QxuPhBr/s/d9epR5rjeE5r5GzQk4s3jqV6Y7KrXPU37eva6VyX5pp57
         fligCTFB1AN1yCObivjTpnitPcKzG6ZPQEcMHt0rjLS0nuQ8YCa5vQPEzU4gYN140tOp
         L8Qg==
X-Forwarded-Encrypted: i=1; AL+hErExCJVcgClJutPrcuhAnqXV7i2hCXVotz/vv25HMopha8JeysNWZcH2GLFSCBJPHcKIMyJI8w8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OOcfKLV1ycjA3Iy6FLPKADtY0y+oaR9+ZIMYWfq8SmzwFw00d
	1cXtf2Y+/7828c+cQ1pROKt2dOSdDLaEvgqzrXMs32C6vrQzHTTS4i+V1KIAEUP+
X-Gm-Gg: AYBFou1eMarO/rbnGYJRSsed2XOl5yvQdhjoaQwXhH1cdWhOY1PrUiLKl1/n43OBmD+
	BwO+1aJ3BgNINgdTWdRoMWu/FhWIWeNjSGjEo8Jhmmg9dNsOMPc6SdU42aXhHRwIvS+MEC7vTeS
	mAl6haXv88QMacTuW6nCgkuV1lluJZMUxIvnk3VBMj76Ag9rxvIiF3aUaN0JVR6GKzfo6Igdn9o
	gWLEzkOoB+cHX3gcwM5vOGspwPKZDyw2RWWqvkXjZRzrhtoVW7hevqZJDfFXUd9j0k5tnYUfhXq
	yFXeU2Thfm/45ekJI1AbmMUBgaDRDaVp86jYCL3xgRpwUq1tD9BeGcNiufZd2slfyh7NEfDFk8I
	Y9pMIXbjIV6+EyiKAe5WDq1luyR8if20EjPQScHSSdhBnPXbUr0U+V4ADomhuDKoSvQXCH1IV3w
	AsuZJtUpvo3/5FMt5HbxdBy4wRUEa0iKjeqrT3bkUeb5FUVC64h2Dz5Hjhl8UHGqRAOxO1/yiIs
	WJZSiBJpWqpLZxIwBfYdfG6cyJVdbX3TaybFc9n+ON86MDRqntRY5Rj+o6yrTiRmCc+/Ml1/Ojc
	S5s+HcqiC5QdFdLbe0frdm/4e81LS3QsJC1P2nCC6d2X+Vj3yntG6ScM5DnHLVB02t2Xm4AzAVV
	eviAxc6x3LiVXeyN8cDkz28YR+LLIRwQL/00hqDEkFRFBqm+ed8keLbiUFoB/15kqjBwcdr/PUR
	ucird1qHxrf7BwPbYwAMKhOaaJQ3fXIHDi8DZf8GWAux+wjnKuPYk=
X-Received: by 2002:a05:6820:c5ca:10b0:6dc:8f59:6ba7 with SMTP id 006d021491bc7-71ab522206fmr3884129eaf.73.1794808880626;
        Sun, 15 Nov 2026 22:01:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm9375160a34.25.2026.11.15.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:01:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 23:00:43 -0700
Subject: [PATCH v6 2/7] dmaengine: dw-axi-dmac: poll the correct enable bit
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
Message-Id: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-2-bcb23d1e7029@gmail.com>
References: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
In-Reply-To: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

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

