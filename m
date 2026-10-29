Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312994;
	b=DPO+4I7SILHQms8GpwSyofKgWnmhxnusFFCr6MMMBT+Ui15FkvkAylojmK8VT+bHVPCE
	 4EoWFoFLBaL+yjQ/VgjhAxeWvabWL07av4XUxYi5+tNm6NsXVyBfqXZWAUDT598TFtpsy
	 vjR+QXgV1KEGzsL9DtAgxoJ6CCg3fOhIVnNmF9OtBpPOf1yamKl3BV+Dwb1ynKJHNZjEa
	 Y5qELllaQusjYFT0ZqIHg32540SkP3KXtVl0PtRBVx5w7PPVR/khGKCr0yUJD6Z1p4ILa
	 7RGLh2PTs8Tt2dZh2YBBC0g01zZwzwohMGTIleCtUTZ2ahAjzNyb+Ref+8gRZgL9X4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=94WZMClHJfI/hK5hnDLaJYjY1fIJ24YVjNi0D7Blgz4=;
	b=QOcX/mTCybLphHw2k6y33gDP6jwlvabpepbittih/LaVG3ZN2AuLIVlrXacMsmLBuLcq
	 LDfIUOlWDL1iM19zM2RLaglb3LjfwfK4sJC/eUo11vzIm2jpp4nSp4DkpsJi1xaBf1y1S
	 j9VHLjrXqPhEClMCfR+CeOP2eDrRpjpJHbnE9ubSMWFh3N8OUgZZn7zUQgl1w3hofV7tq
	 Dh+xyXusj1hRdPxAh0H4cua/qCAHR/vPNd3AZgRI3Jt3ZKSlFKqjVCa7zH4DAfiHKhXLO
	 WCMTTcI5KzCogjGeCKuqsaPLzFByxWGiopaoiTxNOjIvS3t99YfuZuwyZCG+hgBvBrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcfI8QcX;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317B60A2604
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9317B60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcfI8QcX
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-847ac7ccd85so103112a34.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312993; x=1793917793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=94WZMClHJfI/hK5hnDLaJYjY1fIJ24YVjNi0D7Blgz4=;
        b=JcfI8QcX0MkbuJpYSDzzNklIPIfn0nH7EJu8TYdFgebu+YQVrQhDw+mvk1wGbaKMGq
         xXY8+WzzD737OMw3GX0zgsKKqQ9YH4TuqEoT1YoDbARN6o1chKnJcJoPFErnm+vJ+FSm
         mZ9oUf/MyGxkQ7u9HVFZdxFYzHEVrB9+L31XZQKFeX/f1nZAj+yXbzHI+oWBCQBke45s
         ceFmyKnZfwWgN3YGJP+6huiuqz8HgijQwNUpOeyOEvATYJyRFxub0h0P59AjByjU3Sxg
         /sfcdJ/FPTo+xawFPEj749PiJlPbsg9E3yRB4iGMhZpW/uN7xGBhaqqoCq4yVJUqjKXs
         hntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312993; x=1793917793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=94WZMClHJfI/hK5hnDLaJYjY1fIJ24YVjNi0D7Blgz4=;
        b=IEyzAuq3brnuzhWIivQGiaPz6BGPHHpI9+S2E1w5kB9FW+W0ouzn69VU0rMBSwRi/P
         J0MXCJo0jmubytn5fRX9Xk4W710yzL+1dASXmPGwE0pvmOZflVfNAnyi6OA70ux/vSdw
         3OQda+M/uZVHxJdtHu6ZKektN/s1r3tDO7HyGmMz/nZIrFDkOR6b4+4AK8pmYZfkgr8F
         nI6jRDL0TxlOWqUxD8W+uqHfQtzboxtzRoPU7yLO3TC1yFxn6RISZFgH0qa8PAoHbbsL
         Sj8efx37qMcQnmjkbVgGcINRbUeBpc6M0FQg5WjOM3EZlzwmsfzncFfhTbnXFvCyPTbx
         bWEw==
X-Forwarded-Encrypted: i=1; AKwUvBz8Jz9/WloZQXQxAtl4RJ570HQPzyUWZxceT94wXeUmBSAL7aD48cfDt5HbaeevH6yVHA2xasE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs89pTlThdKfR6g9gj2ieU8kCadQZXaXge+RDKBxndAmqaqn9J
	XoS8A0kWhAeZZ3B5BntOp0JgfcvfYbC2y7DYvVqTU6EP1i8OmRyVQ3bP
X-Gm-Gg: AYBFou1+hn10l9AdCIlYQ8fkgsh2jBleuP25io/bnP4NJDnfH59JqYXhqOqm7WeHydI
	PA5n+rDRAOkYE0nih/0uX5hYXPrh1dwisYQQfnHvPdyjqWQraQLskcWkDINOejCeinCi88y8CSL
	ECM4zkBTHZg17K0LeLrKJclDndxXjA1p8sZ5Qo2WGViQakY7YgM534EYdOA838w6uAvpF8nX+tj
	wYOSMbMHGn329gOK8/wqT/3lxymMvOHRUVNECsl5oVCUHBpdNfJLcqjFDgqpQZoq4HpDUhBP8zO
	3JtAqMi1Wk8l/ejb1VEguzFA/A8VJU7DXkKkHlvwXSCXzUWCDGYrPpbOAzIJi2jQaSjojnXp0dT
	aV+zaDpIHRDICo6OuWaFwp5lTzQO4uythx55cjw22cy9shmr8tmR5C62e4b7Ya1tkxXQFVWTjqZ
	qNDJn9qiljDBP9nybx9Oc71B+maj0bVxUTUcPP5xBABgQqmzJO10Wl/tZS94Ik3YydAGq0wGJ7d
	TSrrwRnXQ5IylFR3Ut/bXKbvfZ1nwQj9JC4xYx+69JyRqg5vVm4Ep0P4MjOwP37C4sHjfp9l9Xd
	alB/p11MeQmMPYtGMmBoZIQOdYo7rhN9kIFc/wTgQKlYETKzVJqIs4t04bkyn9ZaFlENGaPiW13
	6rzQxLdttwqNR7XUvuSxsvKu76NEFDjei0IgFdLbkR4aiXq6nUvAA6svHlq3f1y9fOl5ltfaeBn
	3P1zDNcb6S8XCFIBw75MDfDJeOGX6AHYfZG8TWOQ9sINgJyeotLPOL
X-Received: by 2002:a05:6808:1244:b0:510:7dc8:5ff7 with SMTP id 5614622812f47-5640deea651mr505285b6e.19.1793312993474;
        Thu, 29 Oct 2026 15:29:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:39 -0600
Subject: [PATCH v4 5/7] dmaengine: dw: drain the tasklet before releasing
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-5-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 1d6419e1cd3c..3bda85adbeee 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -398,6 +398,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
 	u32 status_err;
 	unsigned int i;
 
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
+
 	status_xfer = dma_readl(dw, RAW.XFER);
 	status_err = dma_readl(dw, RAW.ERROR);
 
@@ -1067,6 +1071,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	tasklet_disable(&dw->tasklet);
+
 	dev_dbg(chan2dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
 
@@ -1092,6 +1098,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 

-- 
2.53.0

