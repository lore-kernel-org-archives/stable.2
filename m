Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960478;
	b=nZaKbRDqzHgpV+JZEFWfDwvpRTVXRCfNfikiynXSGXpz+4zDWeM9WJkyONuqjwYv1IJG
	 ocCLlBUZPQ5WSem6ouCKGfgruln240XcIE7x9LKmqOggNVUFhv8hoBUv8PiWKREMp7/MV
	 Na3j5vu9BPUaG/4JeSNRTHmKHJlOvSeZ121oJWPVAuqtjDIaC2O3+tHyRZH2HAaafa7Bk
	 Cn8+73zZgdt0j8s3Lz1LUnW2nSZWEkEtvCY37MKbkQoBwm35G+lXsd9muFs5V+39JvZ5d
	 0Nh+NnPCUQMwUpgWgSWLpisGcZwm1y37qM7ynTdptQQtQSf2osvtdTV61wDoiKlKS9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
	b=dFx13tvz/UENsdyikcPBPuA8NNZ3fGa60bfUPdlTU1pk+YThdn6aZmm0wLxb0F60JwFa
	 u6VEQxQKb7R8u1ZHPKdWcaRyX8nKOjSr74CZUGG3aWV3GYNxLVe5mjojPtStFx9xoklnh
	 JDhwC8h3yk5+FzcGdjLOy+TL5ldZ3q5iudpDrvJf58J9J67aaR8jgdgYs06qN/anmEHsW
	 nBWAy+8FvudgRihNTwjPKa56DlRDFWYx4jfYbIpbYBvN3fzOuJspNrY1GM1HBDL9OBs8k
	 woFWECVOAox3UOYBxrD1PxlVIQAdKfjOu5xKrhOucK0xxguB/hCclovRI+PVg/iPUyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TG8OO5sR;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F4606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B50F4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TG8OO5sR
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-57297329b3eso168878b6e.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794960477; x=1795565277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=TG8OO5sRdGdUt09EZBY5KLUbbKwJFAAZgRkFs9hz3cLqeb4Ox0FhXdC+l6EWe/l3/K
         zxrRL84w4viTDvdzLDbVCRGI5dyxtzH3U2vLZe7abhs2HuqdunzcfTmM+r8pGZlTcCTq
         +seLN+jg+PzB60eTa7cnrgiYV37/PUcY/u0w1mx+u93qpwuPKKAmM4QjBXgBShEktodf
         Mz2+q2WkYFySmnjBVTbwL7RGiUFe2Fg3r6YFl41WTgucWSMEMJFeWzfslMGJq0T+1/7g
         SNhZdcg3sHsStcLL23NZB9xSfja8muqz2XEpD+5zUvrI1Oo1bKk29xQn7DTp6JeOmdcd
         zFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960477; x=1795565277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=mSyFyqPFwLnoO1kUlBaGdbRDLq7N+wk/E7SvK9H+kggpYTDa/Zc9QNWtP2w4u7X7b/
         1v4q6UtV4l+Mwt8z7R9h1G83otwSNhD7AWa07GZFY/h2yNkez/Z7/FozCJVx2iAQispG
         Wb9f8iFjGH05hc4lNKzz/wRg4gmHkyNMVm4+YwnoMvWv/LwA4bzLEu7OD0v89216mgxE
         xp6Mgc+uz8fgfnemMIjSyGhPFouJ/QbwrvKWJoB/U1/fWQd8oz33KDXn/DyUXd5NCvIN
         rsaf8xJ3RRl7d0sAICqWMoY+CjV2IB86LGY7AkTIe3kn6x+sCPZWnRiCfzTzwJ1mxUK7
         +uvw==
X-Forwarded-Encrypted: i=1; AL+hErEuzmj5vwK2W9N7nrQX9T+yIMNgtiXyZP35h6Lu1+T1O6vHhOie0bLnir9u+4dxS9qMzCsggoY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dD8yDDS6+HYVm/gV6rNB/0iRPSCf67cuIUOMEWteT4YDoovG/
	Jrdg/kTGrUw8Jl5tQzkpnIz9poO+0UA0eACrx42aewQH86RJ5TKtdnMB
X-Gm-Gg: AYBFou0/LrZH3HQg3QgWUuOiXf1LmveMykLQX2+OWBT69RNhxL0W8skQDiqeMUmLpMj
	yJislu8ZcRIVdH6yJ9KKq4tesqGPFatpbRPfTrsSLLwZT972Xovgz7PFFn5PayXv7rj18h9KCPq
	FgqMTQ/M98mVvJf8GhbJN6wf5ku9T7AkVF0ITmx8L6XoWKjSYZ3R9z/deKrCWWdjAsfqlwho8G2
	K4Y7Wvorz0vAnp52ky8hyXgKzASpA5LQE2/PjvS3GiRVvQxHbdrr0RIGCdqvrjmi4nU3pTts998
	PmSm/e4RL5/9G8JB4iiaiaSXy/f5tdakOkEQnLsO37SkZyAmCedbaZPK3FgroMJ/whzVrgRI36v
	8Gl7E7NFfSCZOwiaSwG2IdeCwmUuvKm+La7Aw7GjXb2iZM0EATsBygV4boQbzcGfEJnRXWmEWzl
	viTgXZcdDRo8TDFfa4KsMPCeKhbKWUW7kcgSFWwATBMbruVBpnxXEkqfFg8idP5qzvh8xEgySyL
	KvwMQpo5ygEcIMT2T/zvnXUUXNchvDtVk3kVb9aXQXBPmYI17cbtt+5nbcQNYWcg8kodcZPGjY2
	HSIJGBocgZ7ntzMv8lJ9cCfTo0Cy72aB371OyX1vrYHYb78uN8xPTCHecg/XLbC7N8z3P7GQKUh
	Gdrc4edG6Mk3Xuy82AG1vBrCL14KAFj91imzXgMxuRoEkjyqBSCld5I5jXKICTu2N/MxK9T28kn
	C27rFj/i3GXcSvqBX3Baq5MNkv8lsOhL5DbYrmVZiVSQ9WzPN9mMA5t9PYdSI7Qhiu0VhXf9Ch
X-Received: by 2002:a05:6808:14ca:b0:4b3:8d45:aa2b with SMTP id 5614622812f47-5774045ca4emr1613768b6e.16.1794960476659;
        Tue, 17 Nov 2026 16:07:56 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777b393d40sm434954b6e.17.2026.11.17.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:07:55 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 17:07:41 -0700
Subject: [PATCH v7 2/8] dmaengine: dw-axi-dmac: poll the correct enable bit
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
Message-Id: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-2-d5f2309afd72@gmail.com>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
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

