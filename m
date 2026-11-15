Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727192;
	b=yBXbUtN0sOEYRvjXiKSXkNsjizLCavfFcCN8wrxZ003jtZHraQXBdeYMAgdfDjy+2XNA
	 rKCAdISoGlA9s4lwbSc5mA+qoyUNDNOE731WxazmTSN8zHl5SDoHQhOZ4ieek1Wq0nQAR
	 dSYq7IOcJbXV3Kg1xNbBuixNDv29T8JjxzeKvlrgWDeulGqtTZNBTkjPxP9EDOBadzVB8
	 ewWHnmXkxhlUshYojQO1vkTWPygiNiqapKfuppcIHM9pH7SxnpkdBHEYMVNuNMGL7jce7
	 mbVNJHq/wS6gEN2fZ9l8EVbH6etVPltK107GUD18WjF26k+tsPmWUyGlNLDCsx4Ib0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
	b=LlrcXLOMoDsfF+gObKHlqK+sRc+uujpta5SEIDDHPJSMRfXTFYGyDOr/lkkA9xNAybOc
	 3Ryh8qB0oMBccak6SGpN5SnlA5NaIQPlt5mG7DQNxtuu9UifeGyvIxVh4RO2GXajbVDvF
	 djx9cBlh8ifyic7nt9S3A8s0t17LjhrkElwydGAnXN33XWvCrNWUln2PFug5XvjGFvTVZ
	 4A8abwpj4QOP4/+Q58yDLFXbvLv4kwKKKuQB8FgUS27Vu7POjA9jEsbUDS+Eey+8x6gSg
	 xx6H9VWp3Cm4J1soMTMeuoJq78QDSUrx3Sn8spOabRjTZRBt1u8e+mMCTKLWe7PPxOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2YgrPrk;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBEA606A89C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FBEA606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2YgrPrk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-71ac798b8bbso1114003eaf.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727191; x=1795331991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=w2YgrPrkqUsnRysCkNMt3GErNmxcugHUhCjZJugSCecv+b145Mg0blwX9XY84sOBNZ
         kHi4poF3jcKjW+SLuPUNnpRvHfw7fg9sdry5lgGZu/27hvwM5i1rl7t98kY/dGs2VooG
         RJytCHNMMaKDvgiStjN+6n5nho0U2El1KaOixb/8s53a06CXKSh5AAQc/QnCkhemfnTh
         Cd8T6pbZa7kuLIpYgJo92wipYNH+qyfEaj9nPqmpsjz2dmYKeedxVWEOqafLBLfCkMbd
         EopS2FBcglZdJ4oAxwhXjrriBhDUnO0GHVm6yy6AkPHAYGInCeZcH3p4fEoBjUe1GtSA
         bNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727191; x=1795331991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=G9me8Q2C9KBUoozysXZHm1BcqN5+jj+zCWPWvFqXulXyt1qY/z03hJteJR5K7SiLs/
         5qq3EAZW2tQtN/Z0Il8OGMERnEA9emTEoOZBFzJt48wdYDGVLbhYU+yBYjmiSbMct4vJ
         S2evUvnOoFCRqWtrt7HSwgAsFPKLhNA6CX5qJVBcwdNJxs+n9TpPhg2rbldr+EJAgELg
         z71JKjlOJMO7SWo3znZcze0Dj0M3eTwMkbfeMqpY1NT4gaN/0ILbgmB1OHkQbnBUg1Gz
         jnhukB/Nx/KPezhZNG5rQKuz4LvyhtpueDKA9yPYqWnoCOLrAK1w7XL/TH9DKxwSjcCE
         QGvQ==
X-Forwarded-Encrypted: i=1; AL+hErEFH1x0dMxslq+CbMsAdb+Yqp9LJry8Uh5wm/c/OuEhloUhxuf+XzeNWIAmKM/U2690M5Sr7Hk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g60QL8WR2mXTkIQqDmVKzcPSRXT2mspYj5JRYLLMpkzDRhkUK
	gFiwJz4AuVonp8g+emUaSDo//LXIrXYrL9QDUp5PM3cfCShJ1DGx+/TF
X-Gm-Gg: AYBFou26WUlQavHxFBc8NG/1wvUAltwNK5VUD2CwAwW5y7VvSXAbC1rHTktLfVge40n
	stDSc2hOijCZmye1Njpsacalyj7WhTOk/rdZsNdD6FUlpHjRhZLXKVwN5b+qpuIyOl1yVcSU8QF
	nXx9mr3jRN4799roCioXPVyjhJYQJNWqgIqRbubbAfZojqsDf9kDR2/h0ZjdK9ZTC2aBjLo4p4y
	FXSDBdgquSQG8/F2dB4ws4N7Tx03O3uG3HoKznFgQ65SPIExtjhpVJ+8CAtlQNjBuQxj0Ijqu62
	049Z2G4jL/QtgXopScX6o47A6MsUXOjs3ClUh8A1AXduPIQrCUvjzORY0zUmeAjvtTR13eDhaEQ
	XsjO2869/CzwwSCf4EgV/0meycGv3oAazZEA0YXYv4+l2CiGBZ15DGYMr/of9s4u3yAQPe05EhZ
	9g97MOBLStWk+GmsOAY78dO7V5mLYz472y0sITEMWrc9vCuQaPz82lpGksfye29Bz+NoIB5PCD8
	QXU6B+m94R8zIF+D2E8+ymdFqSFTp08PZi4qvT4Pi535L2aWXBpjLXt5XCiDepA4pQfBNogLymL
	H/VZj5MFzmp5eanl82pKLutx+4HcQv0yAAIxMSHzXTyggjVUe8wW9yhzR90H4TsKxYyT1AcVNp8
	BhG/+WO6/WoBQNPX4RqYNc1e6olqN/L9GjVQRra/REZZsdYLIhFWSBrIJAIA+njKUTcOdfvJkhI
	adtoYRMjysCJB8a8e32lYnv0gchLZj9HcUW7FST1CZ0O/YqsBbhVs=
X-Received: by 2002:a05:6820:3385:20b0:716:bfdc:a084 with SMTP id 006d021491bc7-71ab50d4472mr2939790eaf.60.1794727191190;
        Sat, 14 Nov 2026 23:19:51 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:50 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:41 -0700
Subject: [PATCH v7 08/10] dmaengine: dw: drain the tasklet before releasing
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-8-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
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
index c602ea01cb83..56a422ba14c1 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -419,6 +419,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
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

