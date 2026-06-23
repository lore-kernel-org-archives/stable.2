Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EF2F8E84
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229906; cv=none; b=qq0NIc0+UIyljt0oU9uCQX5rsYo+6NUkYl49dRWQQrwo7nBwNoJTJqg3IqKVNNO2tosZxKd/2MBcfYjCYghoHETna3n7+KXr37XrfsplxO5PhKW5K1JmoFYpJ6ADym+sRE0XQ19KfPBlNcjXPelSC/24TR0SSaXPc55IfNgeK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229906; c=relaxed/simple;
	bh=t8mXf1KWzBFFHZItSaMJ1BAc0QXxY+Opyx4omfe868o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U5kbGjy3f7MRshcR0oNtAftbIXqL2NuU2KqlKJwx1ZTb8ysbBdNGBq8T8GBznZClbs5BoFOontNbnl7u6whLCr09c6GN0BwL4x4sfAcvbGOXbeH0G6nLwCZwrsnKvwnFWQzR5KCIXc7mv7RsbqsOBnlax+mpXNoqzrg8Zywvthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UglRfJhW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UglRfJhW"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so68606b3a.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229904; x=1782834704; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9NNaAQXxA7tp5h7ZzpX9ErwD3n1HZRKdmhW285xKfA=;
        b=UglRfJhWKHlLdsoCguVvp3apAqNTjg9nHv/v7C2EWUpqoBywT4r8r9ViQsJcdT0+Z2
         Pml48DzI5qBkzNhKgdrpvbdVvcEa5ktojS/nfgYhrpt3jpKdfRSh4lVsuW02R3zfsml0
         fy6I6jxN8G6YHDBOeASoUrro+q6dMNYJx76ijnaNfiew+j0TQP/+imhf5gl+NQM4MJA6
         bzOJRXv+VX7NAd2he1F6L0opJGk94MDJs9HGUWLWgXXIjXPmM9KGO+G6nlwihzCA/vgs
         r+9ijCSe+wMvQuGPBpbbLsWxB3f5PyXqt4PXsNTOQmE3Hwzw5IIEbea4XTaA+tn9C6gt
         xzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229904; x=1782834704;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9NNaAQXxA7tp5h7ZzpX9ErwD3n1HZRKdmhW285xKfA=;
        b=awb5oh/DUzWxGjkDj0UKDVBMEdA0neg+vxVR3DQ6Q7eQhEP3bwprq3byZEftmL4XGy
         dFZWvhpYUMrVn2ZWXzf6Yx08Knov0ak+8becQCYNJ8WF43+sLmc4eSuMh1j5403R/B3V
         G1UqfiU6EFj5PwsD6XtszCZmWXPH/vQ6HBWpx9UrnTa8yY+E5IvUtlUNop9m76W5JUR+
         fpRv8NvZty7xGsLkHWFBkQof8IhBXUZJt7UlJTSBO7gXYo/0/AGLFjIB7WkLX3rdgdvX
         a9ZQ7O08D4Gu00cWSOeGJwFsrjec27YuZ4y4FMxVU8NCDA8OF1JAvd1FNGToXwSDOLL4
         sVXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MXpFsdgIFW08lT6OiuW/yTSfl5MxgZQQORHExh7rO1nPfBxTmNykz2S6dY/LPLGhRvbQH0I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/qPpavUY5P6lSXWMMCmVIzCw91FU4XATleOwzW1OXmBHwLpM
	DRDn7qZOH18LWR0uAyMEc3uaWrIfrm+zE0xqGFAb+U7db98ghTCfCuqC
X-Gm-Gg: AfdE7cmR38UKEzbQ5Tpiq4c6yXDjwAP/FXgtzZ2aUnmOJUP10z09lGNbbJO2zhj23e6
	UTlj8EAuYOgeIZ+sExAm+1OKnFNmddIrKOB6Wctg2V9Fnnz4Q1xnyHFT2rTmdKwGWEyEpKz2hlD
	pRBWnpu6UMLs4Uz0C6TjYUYXQNA8Y2PIzA7DiZvXV69sHKwyR1zl9rQTb/sZrTEA4Wr4Nn8s1VH
	hY6oGi672hfuzcDvLHHTNclDGMFKAkKGqPqVoMB5WNYC7lfJzhqekFY9ktcXDz7KqMwHfJPUvKO
	x+/i1HTwZMnAaj3ZMvPdJ2mL8OjPTemHJ9cIKuHwHKBTR/mOEIO5LgAGV5fThJcb2Y1U7oUkykQ
	L9ePDG2lNcXm2CqLeFnyVt1MhvlxSkEj2yM2eIoUSTwQ+eqItlu3t0STPRucor6wbfF/kMkUCLx
	SfmBEKeN9TFxwTYKSxY2wlf5BTflsJ/C/X0KqF2A==
X-Received: by 2002:a05:6a00:4004:b0:845:4c76:e46a with SMTP id d2e1a72fcca58-845952108a1mr4322078b3a.3.1782229904262;
        Tue, 23 Jun 2026 08:51:44 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ebcf45sm10418471b3a.48.2026.06.23.08.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:51:43 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kaixuan Li <kaixuan.li@ntu.edu.sg>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH] i3c: master: svc: bound IBI payload to the requested max_payload_len
Date: Tue, 23 Jun 2026 23:51:40 +0800
Message-ID: <178222990006.2767135.12462569914183698733@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

svc_i3c_master_handle_ibi() reads the IBI payload from the RX FIFO into
the IBI slot. The loop is bounded by the hardware FIFO size
(SVC_I3C_FIFO_SIZE), not by the slot size.

slot->data points into the IBI pool, which i3c_generic_ibi_alloc_pool()
sizes at max_payload_len per slot. svc_i3c_master_request_ibi() only
rejects a max_payload_len larger than SVC_I3C_FIFO_SIZE, so a driver can
request a smaller one. mctp-i3c requests 1. Each readsb() then copies the
controller RXCOUNT bytes (up to 31) with no check against the slot size.
A device that sends more bytes than the slot holds writes past
slot->data, an out-of-bounds write into the IBI pool.

Bound the loop by dev->ibi->max_payload_len and clamp each read to the
space left in the slot, the same way dw-i3c does.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/i3c/master/svc-i3c-master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e2d99a3ac07d..7420bfbdd259 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -465,9 +465,11 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	buf = slot->data;
 
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
-	       slot->len < SVC_I3C_FIFO_SIZE) {
+	       slot->len < dev->ibi->max_payload_len) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
+		count = min_t(unsigned int, count,
+			      dev->ibi->max_payload_len - slot->len);
 		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
 		slot->len += count;
 		buf += count;
