Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648063;
	b=2Fmm+N7wXFmMUxsaWdcvaZxBd7Q+HLwVmvgVmsA961IvPI4ykuQVN6Sd2MVzvP6ezFiS
	 pO+sAtHM5YnX11fcDZRKNBm5PUzWRoedMlZozNgvlvVyZ/TE6kWq68Dk6DPNp3Ub+LL9i
	 LRiezOAQgM0slf6xrn+ZDQihl5EWCqy13LhuErEEM1ZFnHlYmCAloNJx9f016IunF1tAB
	 V0xT838W6I0SXdUhYZtBHVqc8EA1h7A+Ewfde/+URhKPTnqB068NNsa6tHqMEWZuKRr4M
	 ttla6CosjbDhLJYfdkJEO/dgMJsybL38d6NLDyD3gbzTpk8DDbGD81EcKwMlWtq/U+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
	b=eehF9roQbhcL86FxZuCG1y+VuvSCFFf88pGxUymvyvjkrIYfees3xE3YNM+5QXirI1rl
	 0PwUG3CN3p7pcJGngTZ8NR1dL7SkZ8yknjc4j0YVyIpaUR/O5Nss3WuLIzg+l42p+cuog
	 S+sd2Ij8X26rP2XoAA7EAyzFKGfwQ4yitI3VHmv4ASun2ATgaZF3UoSrdhpLZA/2IYPPc
	 AAoZ4q79ObRHJJQDfyOlxoi9d3bDBo95z925S4pW1U95F0Lm9P1HWxJJVdsyqEke2HgUz
	 JVFfW1c6ionmuJqo9lAaJTassqIgv4iFpk6A5T002aeEsnyZ+lWGbQhyEE438q3lqUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uf0KrYoO;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4D606D820
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B4D606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uf0KrYoO
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b190cdc9feso2360018b6e.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648062; x=1794252862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=uf0KrYoOZIGx+PEW6J08xmJsV0DaUkL3TeViGjdoLyNBNJ3rOfiqa6+EEJwmjpA5aN
         ujFa8qwAYYAkVnazWyU4d6vPjmJ42rV41SJ24cWJRYyj++hxfHLg/NVwdNCY2NzRxUjX
         v4EmSAyHsLtgpiFvLgXlwOYq+s0pbvYhpP4OJaY+Ai9wZ1qyJaBTG8nfVkAxSPqz+49d
         EJPoK9m/5rpUHo89vkIfTPPk/LbH7mbGLRlClVCn1m0svzIOlzdVc6DLxwwPMEmSl0XQ
         i6moc5xZqMK0OqyZbpWB9ZG9Vo/W4mcsYmypv57fbCV1xmAsJaFG3c/pujNMIHZRkIak
         JFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648062; x=1794252862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=lGICI797QKPjcc8KqZlid0rAqsDmNzzvrYFIedbz2g2QFFiSYE75PgJdRXLY4G3y6u
         W2Szap7pDOzyVCFqU+25DPvbIcgIqdtTI8DSHXBxu9KFL/c6uvEqIZ6hJzjmP6u5Lucw
         8cK1p0H5acacK6pumfgMudVFiG3LdKYo2RH6/+mSR2Ko10WCC1kNg79pZGnEOT7tH6l9
         8lXPMUqMaZqKOLt0VurP5bBHAtcHCqSZdMAgAGRphBm8sf/JNm7d/kCx0FH6yB6CEZSa
         NIeAv2z5tYHEKFaCmx36OIK6EaQ5lZ4WwygT27flX2pHTtJdGuO49RZD0EQ1JiXncFvD
         7Kxw==
X-Forwarded-Encrypted: i=1; AKwUvBwxcn5TilTe8jQ3u0l/4DhmgL6wj9nyfQ8vIoM5wO2NoXqoEKClXsedS6ZhVqmVkjlda/Hp9EE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkqhuNzFij0mY7goGbwr9zq0OwbzMMH7zHM9rck/8Yxna5Mt7M
	7f1Qg+ibDhXOVXO5hNedSQhHxc1tnHtRgkW7ePYphl6ygOK1WZQL333H
X-Gm-Gg: AYBFou3zflJAwwrI4wOxCUTCRisxVD1dGrgOSjc1TsZ3Zml2MrPu8WiiDY+dZ9FU4Pd
	irLPVbep35/eaKfwauBvY57WNAoQ5/YBoqS05Qpw+K8fN7Q4utwUTXXrxyPxyaR1skkpA8m6d4J
	+2OFV5EMZJKBwYg06YKIllfk2sBiFy6PQcKiSmboipszaboBWvyJC9IuICY5TXqYP0DNZIPa0Yr
	hDImwIsFO2hlOaoMqe6uObqwiYqg09BIz7dEY/CxBPChJmEu4e16bQQIkijiWi1DOQZY9IA1baU
	CqZN6R7GnzbftY7cSb6tin5qkKE5ntq3hFIdguD+PRk8RSgF9KSMI6VX4kD0+thMi6Ks2zSkG3z
	7p2ppWfQ/P1NEQRkmnGgS5x+0znIeN1/wUYvRBjniqEYAk/o4gFH+xc4gtwLMUQw61Usz9c8nO7
	da5AvKlrsPabZvxEgj9G1pBLDqOA46KNz6qU1OMK8mDpgfOduNmp9V4ql3Xvne5OQw5QcLswgz5
	0OQGjRuw7laHgtNNh9yUBREavt6sqIbl6qtB/2FIw6CtcLiO6ZmQaRSOzwoNVNBXreJJbgaHIr8
	QfDAtwVnn49OUCPcct21fryvSMFIClETd3k3ZrZEZjuR8zY10PX4ekq2s8l3WVqd/kBEYiJ1jMR
	HVWzucy/ymxvoEe+Vh00LOT3Qg0cwd20xBdj/o1id4r4NT4y6f9g232BC3n15H2CocgPhP8ilho
	vs5VCQeHcK2x+HCBF/WiRYZ2/GuGgJGNhgL31Vy71WyCuTavjRbmQ=
X-Received: by 2002:a05:6808:1798:b0:561:fa43:1b17 with SMTP id 5614622812f47-5640de03ce9mr7895795b6e.42.1793648062116;
        Mon, 02 Nov 2026 11:34:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:15 -0700
Subject: [PATCH v5 03/10] dmaengine: dw: complete cookies before releasing
 the channel lock
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-3-d3207758fbf9@gmail.com>
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

Completion detaches a descriptor from the active list under the channel
lock, but updates its cookie later when freeing it. Termination can take
the lock in between and complete newer descriptors. Completing the older
cookie afterwards moves completed_cookie backwards and makes an already
terminated transfer appear outstanding again.

Complete cookies while detaching descriptors in the completion, error
recovery and termination paths. Keep the active-before-queued ordering
when terminating so completed_cookie advances in submission order.
Descriptor freeing and client notification no longer update cookies.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index f7ca9da5af90..2d69fab06601 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -231,18 +231,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 /*----------------------------------------------------------------------*/
 
 static void
-dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
-		bool callback_required)
+dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
+		    bool callback_required)
 {
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
 	struct dw_desc			*child;
 	unsigned long			flags;
 	struct dmaengine_desc_callback	cb;
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "freeing descriptor %p\n", desc);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
 	else
@@ -329,12 +328,14 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 		/* Detach the completed transfer before starting queued work. */
 		list_splice_init(&dwc->active_list, &list);
+		list_for_each_entry(desc, &list, desc_node)
+			dma_cookie_complete(&desc->txd);
 		dwc_dostart_first_queued(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
 		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
 			list_del_init(&desc->desc_node);
-			dwc_descriptor_complete(dwc, desc, true);
+			dwc_descriptor_free(dwc, desc, true);
 		}
 		return;
 	}
@@ -436,10 +437,11 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		dwc_dump_lli(dwc, child);
 
+	/* Pretend the descriptor completed successfully */
+	dma_cookie_complete(&bad_desc->txd);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc, true);
+	dwc_descriptor_free(dwc, bad_desc, true);
 	return;
 
 unlock:
@@ -940,12 +942,16 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	/* active_list entries will end up before queued entries */
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
+	list_for_each_entry(desc, &list, desc_node)
+		dma_cookie_complete(&desc->txd);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/* Flush all pending and queued descriptors */
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, false);
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, false);
+	}
 
 	return 0;
 }

-- 
2.53.0

