Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648069;
	b=A/qvVrk+CCC2ERVUc0QkQal+YILbg9m87a74kukkouMjeW9R5YRdus8Odd5XIYz3DO6s
	 MvNTXljGYs62unPs6QUC31nbJmPm5vHcJ8RFy3dq/PsqABq4i4xvVjtOSAseBwVrQD2ci
	 9oinwBwJc7VNCqNIYOwV24IlY1x2BOuQxDdo2OTUVoGZYIoILHtPB3bC5lCyd09WuuPYL
	 BkTqls6AefiK/AxyFZcOZZvJiUBBKLTr4zZZzQYiRkucIoM+myxwK+HVrSXsuOiV0c//o
	 vrsNuu1fuhp0t3hYYRhJkgivSARDwO/S9+g7l7wQrmetIT5pxig0rlsyJpAwY66BOIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=E7gBCzFYvmg/wm0ZG+Fa6cYfj054waIZVNwZet2Fyzo=;
	b=lKPipcauAqy/BQzGTxC67d1dOF9I7qVuY8j7M2kBv1SKdCyHT4FjEBI1cyvFHrrt3JWU
	 cOe4dkajFRP09I7jMeETu27S07kfWSQEQrzsM9mTOorH8jDaqP7+nyeyKpMC/YO5zdc2n
	 qoXYv/140ZjxMvu+liXWWtGz2dKUnM3m/wWWXHZHYWGpkJsfSOGXWWA1p6a0x/mKGhsHx
	 GNARfeE8h85KCmeAi0S4R42gsYuYCKQMpUOUYLncYcStkEVZku2ims10x+jLQMrMUR5hP
	 S/9YLjqRhuo8I2Dae1lfC9m1CXNut0RBUHw8FXJOPZzK9LrKYd9n3MaMLgLpG083CiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxQzlu+B;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC275606A32D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC275606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxQzlu+B
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8256106635eso1644349a34.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648068; x=1794252868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7gBCzFYvmg/wm0ZG+Fa6cYfj054waIZVNwZet2Fyzo=;
        b=XxQzlu+BSk1rbUr3fSK3jJwHiSV/vHO2sI9CexZymuWrVQVZFQ5EgJ8lB+oxsZ5mYI
         gF4lxzQn6U4UwVH6JjmVsogo/vmycOgclfKwkcy7lJZ6uvB64287SHnhG/a1mAxBKW8e
         eTjFzmR0CMhp8EtpV7ENV2FNhhlltgGPghxnOcxxQrXs/h+YFYLCljA2Awr/OA7ZxT82
         OcpOFy+Iyv3HB5m41M2hP6xB8cpbWoO0dVTGBE2D5tk/RXRACcgrkbcVZ2Vb8qLQCI5H
         Y+5NnRzZfU028nkHnxKO0pre5/Gq/AovnbqE9i4+F7w1YSKc6Beh+0VKrJWiXNAimo2L
         LHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648068; x=1794252868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7gBCzFYvmg/wm0ZG+Fa6cYfj054waIZVNwZet2Fyzo=;
        b=quYgui+05J+3U1bawy+6Z2JRq6/J6Qu6CLHKV46IIve9Xx8b2yYqFmhra4nniNAbo9
         TXa+BQOLoS+hlf92aRdIGj1lyiRwgLLVQ7/1fimLb+BqXHOZO6svjk2vlZU5apWW0Po4
         3d4vyPWi5nh7E7Iy0aWq9xbWAD2D5iGoS1os1K3AWenblFOvs3A13ecZM3f3hu5ETXCG
         X6ra81HgIcQ4crKF3zuYT+5IThw+KuatgwWEpJVrRjMeCdB9jwbZZE1qCPdv27V27FYt
         X3fSemDMUTa1p0owNo4DFWe8oNHLE9L6LcmX/byM3U/LsQ+dRxWOAN2RE5DS13Ki9xgb
         LqNA==
X-Forwarded-Encrypted: i=1; AKwUvBx07w8/I+bTSXlJfLw0Hp7uA4ai6RyqjGNyHVFMEmPN4dmDzH/vBjKhyMu3hXH3YlZzUza3XfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYICKkULb9bqC5VXySyUXrtmtICsq1gvK5laCRVSNwVNM/sx4+47
	DVs/r1byNo5x49r/dPD91eAoBoZALvOQN4G9goswKmZKPpBUSvtDiR18
X-Gm-Gg: AYBFou1UOHR9OfMrEY1/iMNXQQ6pGEaQ1yGrHdNXGuC4AdRLf9v52SznYMNivYo8/6G
	4j7YXKmyH5v0LxTNSo0QrRWYQKVVTF+CTIDVe0FCjfGYAU0uRm9qbWBgiBIPBq/9L3alldHcUOB
	Z1+bVuCvYJKgcU/E7cJcqw7moxg3UdaXrF2ozJpc67e1xmw4jusIQCw3PJKF5YGxuUKIAAsgTZz
	iiDWEpDOYMeN/btm8R9BEqGNjglBCyCCKB9pJ17x0ERzVvlSYtAqvtgZ7x0729EtemZKg/d2iy9
	IclGrqRm/dO9aL+UxD319BOFIbf4TgO/Tz+IC5T+60dj35RCv81Pf42jPNvZfxUIL+UyAXW9sJm
	ECgEWUCeqCsI6PHr/WAaV4FjC+WnHgWIFcc9zBKZoruGeJKKlmai4aikNDktw+RF69kjaD9nz/6
	Uit4vyDVRstQ/Q5A4SVCf4gKcbBuUqJbh6vx0HlJ01eMz2PHBvNnsuEO5EJABG4c1DVBEznly+v
	1SbX3VwNO9lB9MDft5uN2F2yGskykQoMoNslS6Bklam5hjQJLWdScfvGa6PbmU7o432v9ZdOoBy
	TVUlTr4au1j9Fmf+fptrly2UpAokB0G+if9e1RZ6H0ui3p1dfSRjbQQ2UEnGCf/ytJH1B55l8jq
	4yXGglO/JXGYKMEiWBAe3STim99TwLS4Jzp93QURDv5Sic81sVQxiLOmgByuypQkJi42il5ElOI
	SdYe5DcBWmUU6AbiPXlY7Y4GCyTra6vIh5BiqC5c9Go0YtojvfaXM=
X-Received: by 2002:a05:6808:f13:b0:4e4:627a:e094 with SMTP id 5614622812f47-5640dc2c8a7mr7309751b6e.11.1793648067810;
        Mon, 02 Nov 2026 11:34:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:20 -0700
Subject: [PATCH v5 08/10] dmaengine: dw: drain the tasklet before releasing
 channel resources
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-8-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

The controller tasklet invokes callbacks after dropping the channel lock.
Releasing a channel can therefore clear its configuration and disable the
controller while that tasklet run is still using them.

Disable the tasklet before clearing channel resources and re-enable it
after updating the controller's in-use mask. This waits for an executing
run while preserving pending schedules for the other channels. Have a
pending run return before accessing registers when the last channel has
already been released.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 0fd49ff9257f..339ca85952fa 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -393,6 +393,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
 	u32 status_err;
 	unsigned int i;
 
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
+
 	status_xfer = dma_readl(dw, RAW.XFER);
 	status_err = dma_readl(dw, RAW.ERROR);
 
@@ -1062,6 +1066,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	tasklet_disable(&dw->tasklet);
+
 	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
 
@@ -1087,6 +1093,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(dmaengine_chan_dev(chan), "%s: done\n", __func__);
 }
 

-- 
2.53.0

