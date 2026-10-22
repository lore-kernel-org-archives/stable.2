Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695175;
	b=cZv9m83wJhrf5/Rjl40d4Z+rbfG6RECUW04rX/pNgL6sijjF57GAmhZrmGglgwZDXt0e
	 h0Yd7z07xfCCNNOTcWT8cLcAc+EIkZx7IN0Kn36e1ufjO72MmOBH2YjZX0bnVTtecKMVQ
	 rIFW0VR7/iXlkRVbcjwXUjgETmVcMFHPFE4fjpHahrTOhEjN51rkUXiEc4XsyWQA/a3qn
	 4pdhml5CW/jIbwkkZ8yxfaORi4Wptz2ju9T4DJ5SCW8/y6LMYDmvQtXEukCkebHduvCT7
	 XsaySGUXY1gQ+lp/DSDHCYCL49q1TurKDbTdryJrScehvHkUdUdlwXAbmnSkrySP8hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=iUu/R+fBQNIMW0hUqQNheGWUYLG4zuBOi30rdtyLED0=;
	b=oXN0bWfIZ+aIS/vScxmp3lSlvGXmS5dOdm6p0p30OU5J+1w+hvWNYsVi9xZikKEbb0hj
	 KLNbc6DQkdeGAO3dw2K/igN051PgdnWA4aC3sY5dfgSN0v5/u2z9PhQJDAW/IIRccxz7u
	 sdOTUPKzQxlJRqINwTuHiqUJniuild20GC4i1G3hetYRFUTtNyE23f2A42CcGLFUPcL0T
	 EcRKkcsmrSP+CJblzxIwcY6Se+NZBst/LuOkgm4Z2mIEFnxGV59U5oYAWNHfGYj8iHHKU
	 GCVCN/JpI/ke3C36/t/6SFuO93HkErPT06aVPWjZmElCHLGtGuzJky+DNsoWDuKxW0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9v8HJvl;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFB60A2619
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27CFB60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9v8HJvl
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6e560e00a86so79422eaf.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695174; x=1793299974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUu/R+fBQNIMW0hUqQNheGWUYLG4zuBOi30rdtyLED0=;
        b=P9v8HJvlMMQn/I0jrZo9LW4QekCfzsbPcKDzCG5Gzku+A4Z0mQP+5wl2UdUnmSaSEz
         oK0TZgnRqOE8h3/SQL1R8vbvgzqU9bmZ+lOJZyK+r33IJIhVFSgH7qCeXIAeHRcDCUy0
         rgqVYwjMOPf3bx2XCmkFsvAPjdeGhsRk904q/4wv2Wcjle5tBOda1jvYlimhAf6kwY6h
         amrrKPs5g3BsZiFR0qA7NcQ0ERBn2L0gLhHk3TTTR1XdJVhA9kRprO7gmGbsnSAEkYc8
         8wzHiU0Ura/HV1Ipn4TO27c0qvzjUSb4v4PLPmtoKHftkogeL718sDeBg7PxYHDIwvyg
         baww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695174; x=1793299974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUu/R+fBQNIMW0hUqQNheGWUYLG4zuBOi30rdtyLED0=;
        b=hAnoiemEEDTH5YLYHbpgScmdzeweV1lECaBg3P1cTayA/Hwfkso2dRK+AbEvAqNpe8
         lB8G2/LoDJLHC/1XSzoqMLX6OGGIdf9QqXEul1ivVO9Nprx4TFtp58aHFQqpzXDDFuwO
         Q/1HDEtI0ZrDzFusMs18XTGiiVJ8Wn8jAd5ZluetFEZJtEjpkG2mTrci/OdhdTXqCS7b
         RWBbupw0WnpDesLRWxxFMh1UIXUsCHLqkv+ChDXdhV/VwERN1i/PX+l5FcKVqTzW7jq2
         +WJzwO12HnUCn0NrCgeLO/yhg/pGTlFf/L2uV7EC/+BgiE59dKxa/8kCSxpleeJmq1zs
         iPQA==
X-Forwarded-Encrypted: i=1; AKwUvBzHYTcqt4XLcT9c0U4QpVy6FVQ9zctT9u4Nn8OMtHB45jyuDUDrLrK5KLoUt1vvBOUiEqRXvGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJAsCTbDwx7/D1GskCREP8IOXHrnUp6px+0NI0RI12KiSKucO9
	Iux3znZLb8iohp0NM6rGXzC/KVCDEoa1YuwndX0PNBHp15httwOeEw2s
X-Gm-Gg: AYBFou0hSp0ganY6NrrHIOpgGS0bDwO646fra8Y1TUMQlpkXZrEvpsQbTkfGg27886l
	tjrXXVVHIc7owmM8fdn3K+qYwBZVZucOQ7qd+3XM8ED89cO04REmSBG8wUFdxfiQYJTEd6Ii0KT
	WNL+mP7XVXxg3CCL0YsNYO63V0zHAB5gpQ7r+kDnYIYjgty+NKRJ2zAT3CixhlD4+3nMxvYaI4i
	9XhGhkdWNGl6iJ80v5X/8bf72UzorTN/B3zPXopBJ3n4yqcRc2FTE0KAOb/a4HjDWxEPDHz1j62
	uaHODozutKOScx4leyUVkp62YOddAy5fzR+vZcpuzKhHmtQAzh45unXUHdiHRD6dByrdVdEScAi
	Pdk2repjz1M3rdPb08J5meDBFR1Xr2cvMP/b9rqyyKB9IO1ZhXrQqMH1MXZLNEg3rzunbFywWar
	Lc+Ny9/LHqLcrQW4Xl+ktJBMBzP5IdFoOlgZJm2uSG6RhIqDY5K7sci+jZtiGe7GTqHcHhXtZOi
	sLpsz9UN9gI4JNdWcniqc++9g0tp3dbHw3zvoJx3dIsemPFOhFf7fNy08JjLbkOiTUMIbukmTmm
	D86511hmmgPK95pukJY6+dkeWXo8Ni1YNDZ0Z/IV/vP0+Z9sbEmxurOm4PYKQbPsHzWwyAVkUPe
	l2OF/plnh4cI9nordgpkTvifn7xA/eRQcxhS2v7I9lpUA3c23ZM3LZSuGyGJjYrkl6RjFAG96uo
	Sf5XY=
X-Received: by 2002:a05:6820:5601:b0:704:4ad:9c5e with SMTP id 006d021491bc7-70b88a1cf2dmr160306eaf.26.1792695174166;
        Thu, 22 Oct 2026 11:52:54 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm536083a34.4.2026.10.22.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:52:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 12:52:51 -0600
Subject: [PATCH v2 4/4] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261022-submit-dw-dma-synchronize-v1-v2-4-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The controller tasklet can remove a descriptor from active_list and
invoke its callback outside the channel lock. Terminating the channel
does not wait for that callback, and there is no device_synchronize
hook. A client can therefore reuse callback state or release its buffers
after dmaengine_synchronize() while an old callback still uses them.

Disable and re-enable the controller tasklet from device_synchronize,
outside the channel lock. Disabling waits for an executing tasklet,
including descriptors it already removed from the channel lists. After
termination, a later tasklet run cannot acquire another descriptor from
the terminated channel. Clients must continue to exclude new submissions
on that channel until synchronization finishes.

The tasklet is shared, so other channels may schedule it while this wait
is in progress. Preserve those pending runs: tasklet_kill() temporarily
owns the scheduling bit and can consume a concurrent scheduling request,
leaving controller interrupts masked. The disable/enable pair leaves the
scheduling bit and pending tasklet queue intact. Other channels' hardware
transfers continue, though their callbacks may be briefly deferred.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 1df028970c4a..9e5e526f7672 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -942,6 +942,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void dwc_synchronize(struct dma_chan *chan)
+{
+	struct dw_dma *dw = to_dw_dma(chan->device);
+
+	/*
+	 * Termination removes the channel's descriptors from the lists, but a
+	 * running tasklet may still own a completed descriptor and its callback.
+	 * Wait for that run without losing schedules from the other channels.
+	 */
+	tasklet_disable(&dw->tasklet);
+	tasklet_enable(&dw->tasklet);
+}
+
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
 	struct dw_desc *desc;
@@ -1333,6 +1346,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

