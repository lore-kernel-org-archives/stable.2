Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D065371CF9
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700732; cv=none; b=u6qtXgG1++9pZwXHsFNYc0LfiUo2r4pRR8x8qNfuGJhVuPnMPkVGHzkPc75ZSL6pIbNM69Ksy9vfxGvhPz6HrP4kX1pOwNS6XfA+zqiOhyd5IGJpZ+Bkacs/urNawQev1ht3BsjCQh8gnrUKgnf9psPGOdPEnSxKzU4JNS72j3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700732; c=relaxed/simple;
	bh=2XanIgMQF7FbF77eiEwNF8U6Cy3OAoH2Y2kGqFdSdBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjyWO11RUO4vYYbsdWl+WeEnl/OFwoWqp8aFoKFHtos0vjzyfeS//HZr9O2mVmdYowM/eLFKA0K6TefINja/sp7p89y9hXhfy+v9/8y0DgkJFkA+j0FlKvsWQoMVcMFB6n/SEcGEXxGONRFqOAg+ANNN/KEYNSku6XkHOr/jJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb7K0fzV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb7K0fzV"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423f236418so1221322b3a.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782700730; x=1783305530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tbxicf9cOISRpJE96mgO+H/y2TlKZ0WdbLHi50c/C7k=;
        b=mb7K0fzV+Jq2s7LAwbQWN5KGInfo85iFhwRjJuj/AbYAC+sC9EZ/j9d5gob5ac2wjn
         EbID/8tSvXzuF2IFPlLu32k23l7Q+2SqrtwwWaCSjHE/OsbMVTLF86cWXRnR8qqz00se
         vWDPTuoQbAC3W73jxGL7giNQJSNt81SBpaWR5xYca5WD7rLiHaYNDNteW5ZjtVA2Jq9l
         QyMe33CQ3MmApTU4DywQ7pl28X98P2oAn+nKX1fstvdrczxgarfEYdcW2cTU5znlnxEv
         GREuz39OqEcNAkve9umyy2Sk8MmX5FjAmz7t5IJPMIWztjekCCtZMq+Sdpy/p9mIJuQZ
         CYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782700730; x=1783305530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tbxicf9cOISRpJE96mgO+H/y2TlKZ0WdbLHi50c/C7k=;
        b=Y0jYXP10Z0z4sxs8pSBJBNPb9P2Hz5IdduCG49vhfkWgcS2XoBQY8PbZ/9+BiERZ8a
         2RC+P4BsBkUyz1DMNwIn1g1qlehR4PsPkA0QxJZ9rEeNzGn63GgChzpb09ADBPn86qkF
         7UdpiFEwWw/ptCpSh7ZP7Swfs7VTTBWN+6ifwT5D+Btv5MrzY4oxMnJv06qdMcVmi7Id
         oGQbgfA8CMWkxbO+etB8sCuYUqhLcu+zwebRYwh/wAnlh5R/J/Dwo7Dj8ARYTe+fEJ9a
         hsgZR/T/zB68yReAYHUFF2uNJh2m9x5tWLQ4c++eijIRz3BG/EM9aONq+mrWYufbchkr
         tVng==
X-Forwarded-Encrypted: i=1; AFNElJ9H34Oo2Kdp3MYu+VA+abb+/2gU+ySEVoW2Fvltr5chsiyTh4hkSS9Y5NAmnATo7UVAwkFF4aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/eYbaPE8Nhz3ijmyi5xiXosZTb6JwSjuWGTU65UL+a/7+nQE
	K8dFWkAXoWsOq3aFBcGlbKKDaFxlJrl/srd/YL4wPhs6CbBV6Hh1g5A4
X-Gm-Gg: AfdE7cnAar9ivDtiH0ds4fMXFcGVqCovFM1PHrvuhEyKf987BRZZCTX8MPxxGgx19bT
	dXWQTJs8dnVRH42ihO9lAyHOiMpV1nIVyT2VTDDV5Q9kHqX4c/qcmQoWXsDt/33LyknOKUb3Rnw
	pF56PE4SrPbkK1ZyOrsDKAGax2koGw5E1id1sXzXuUBy7jRXTRjNNYJAFq/B+CMfT7SbM+9+I5x
	imn9EgaPsRNBhBMGoWqV0LNBg7V8muTrd/gK/HFsZJ96NcFpY69rGfPVSFApUF2llN4xpyEQzpn
	zictCYYhipFtlFHUQ9tdecld1MG21jNbEzCTPnnMsHOtbyE41mIn/OG9D56iGP7moUkPNWC/+44
	wkJMw/gwTy5yDrrzTHlb/ntvVII5gmDFrQ04YA6JrH7ru1o+NLvlcKlrJ2KoHpB3glE04DjIFy3
	Yn4booBQ5i5d0mBOK9NBb02Q==
X-Received: by 2002:a05:6a00:9493:b0:845:e4d6:bd2b with SMTP id d2e1a72fcca58-845e4d6bfaamr3829675b3a.48.1782700730418;
        Sun, 28 Jun 2026 19:38:50 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm6914869a12.9.2026.06.28.19.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 19:38:49 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: carlos.song@oss.nxp.com
Cc: andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	frank.li@nxp.com,
	frank.li@oss.nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org
Subject: [PATCH v4 1/2] i2c: imx: Fix slave registration race and error handling
Date: Mon, 29 Jun 2026 10:38:28 +0800
Message-Id: <20260629023829.152651-2-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629023829.152651-1-liem16213@gmail.com>
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <20260629023829.152651-1-liem16213@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In i2c_imx_reg_slave(), the slave pointer was assigned before
pm_runtime_resume_and_get().  If pm_runtime_resume_and_get() failed,
the error path returned without clearing i2c_imx->slave, leaving it
non-NULL and causing all subsequent registration attempts to fail
with -EBUSY.

Additionally, because this driver uses a shared IRQ, the interrupt
handler i2c_imx_isr() can execute concurrently and, after acquiring
slave_lock, dereference i2c_imx->slave.  The previous fix attempt
added a lockless i2c_imx->slave = NULL on the error path, but that
could race with the ISR under the lock and still cause a NULL pointer
dereference.

Fix both issues by deferring the assignment of i2c_imx->slave and
i2c_imx->last_slave_event to after a successful resume, and by
performing the assignment inside the slave_lock critical section.
This guarantees that the slave pointer is never left stale on the
error path and is always valid when observed by the interrupt handler.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Liem <liem16213@gmail.com>
---
v3 -> v4:
  - Instead of clearing the slave pointer on error, defer the
    assignment until after pm_runtime_resume_and_get() succeeds,
    and take slave_lock to avoid racing with the shared IRQ handler.
    Suggested by Sashiko and Carlos Song
---
 drivers/i2c/busses/i2c-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..2398c406e913 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -930,9 +930,6 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 	if (i2c_imx->slave)
 		return -EBUSY;
 
-	i2c_imx->slave = client;
-	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
-
 	/* Resume */
 	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
@@ -940,6 +937,11 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 		return ret;
 	}
 
+	scoped_guard(spinlock_irqsave, &i2c_imx->slave_lock) {
+		i2c_imx->slave = client;
+		i2c_imx->last_slave_event = I2C_SLAVE_STOP;
+	}
+
 	i2c_imx_slave_init(i2c_imx);
 
 	return 0;
-- 
2.34.1

