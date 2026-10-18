Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4D38B133
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362839; cv=none; b=cq78/TDxCyAXiy7e9QvMrnvCFqjt5vWDr/a2HGXVU9rtOHI0aiBkeUhz9iRLWUrXFw4LTV7K6oOo9YGqa1Tq5ctoydyFw6VvqcaZ1sCpGLSxNVZ1ynTaiy4WfyWtLOs5zg8Wan9mxbbNL8coU+9mtRiuol04e2/pj43O9TTDt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362839; c=relaxed/simple;
	bh=NgHHSA7vGYxQapF/98NDvmot1QWdaK+fbvCUOkKE4rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PR8kaXj708MVp44qJ5N/pNbqkORG48bnJE2FL4s58y1rFkHmwjT6aI+/LgC1kbdmH19goHKpFuP9SpnF8rskUUGWNWeZMvm5CNrQZUeIKQcoBCMoStMHZyHymFYas0SSO/Wo8BEI3ewB2m7ffh2hTAiReMl+G5q8qFDgFlhtXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDxEvR+L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDxEvR+L"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e0d1da913so905894f8f.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792362837; x=1792967637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uPFvsWTFV+hyF+D4UYXzl4VkLEfqeGLRcfL+8XHsGFQ=;
        b=cDxEvR+Lw7uq5doS3nWqjJZ9RBl+Fiai/Bpx4KdKNsaByaxiABp79VH5h9WKYxlWFn
         nsoi+DrJay1pGjmC3gaJIqfhddjB40bnXaLF+36Ln4evGQ3hMjmNrvevQ9lYkg2CrIT5
         0xcsHoGzWLfJKnl4O56gsF+SWuXEAyTVKuNbYYabrZjkGXHmEGINnXpAxqGXEBHPyi8W
         s3DmcPaoBeuzquxfoCt5vvre6EU/wcFZrvqT0jLxYAe9K8xygBPnSLyCtBrAb1tcWzJS
         a2Q5I5LheBTGDBhP1jdUTNNnj6HKoxLs0WkI3oNNyN5d5YzDSjRJPtsEjAC+RpiSfVwQ
         PP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792362837; x=1792967637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uPFvsWTFV+hyF+D4UYXzl4VkLEfqeGLRcfL+8XHsGFQ=;
        b=y0vYIjrL1+drGe2Q2t0JUg8F2HEKqNznK9gwVtGPrSPx7fh257ol7rxxkm6Wxmte3d
         ZQMkzRy1F8si2/rT2Bptbo/LIiBONZION/ohLGabczyPYzfHSlBXSRuqtGSaWCtot/33
         tHbkI/AadK4KWwW6f6fHrzNarpdb4jsn4evTBnX3tpvKvMQDjmzZ9t1OozS0WBCmuW/6
         L4Jl5DANqYk/Kvq5XDFnFzv5F3zYqo/5gF6IEfsz5UZ+lMhEQOSBc0p/dNlU8p8T+WWA
         MVcGOqlG5juBwM7pcz9EKbEoNtx1UYuYPSaVxDKbyR51GEwRjmCs1YOOxkC7VqsxTv4z
         N6UA==
X-Forwarded-Encrypted: i=1; AKwUvBxMRzuTCDL+9eX5YnChSEVY1lALJVaF4H4vHfxJculNZQo9JmbgDS9Tq54Z1SnvUR88GwwSxy0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwY6J1zUdznujnpPFiKFsJE1jsxWggnuly3zWFycqn45thycu/
	k+hZKxBU92RlxN3XkxA6SjkMvQ8215UN0UwFufZH6S3C/ANvpFTsdfc=
X-Gm-Gg: AYBFou2ThV5Vx7qkZk4NNLvfrvrHFPsoWdT+zv4eBs09PL0WMT8rmWR98+D5yzCeKwO
	6VVwkxzQODhI/1IJM4Ypg+E4UnoBZuGzrL0hU6c2sAkhrCYsY1svXdrAn04sdTA5P/txVkUaGAh
	l9JJeWGVCqMlXvpp5bk9m452Lc1i6g0Z3QMJC32uNzL6d4FwD7LC6X5yGwm6OoxEqd0SsI3dJqy
	Pw7E+wC2Hyjc7c6vd/hvQYs0YKcqLQB2ChSTtxbPFrjZ9k7LDzkAS9YhwLtMQzrAxPF4fbleU8E
	zPZLjQ5+4PxdRn1XKOXwGRu4SeO/Xa4R1kDatNsr9XmjtdJ5PEiBEmmOfo/AwoW41J2T4HHsvma
	bkbzgzeuDW8nqMLUUZDpYPr/+lhLsNF0pCnab8CTDSV5Ly3w3tRr/rxwtKr1KTHiANfolorOJtm
	3meDF4/ug6Pe1BfUnq8MXsKhPFPTDK7sLgRO4sgwE=
X-Received: by 2002:a05:6000:4b1d:b0:48b:437:8fbb with SMTP id ffacd0b85a97d-48dfae72117mr20868108f8f.19.1792362836691;
        Sun, 18 Oct 2026 15:33:56 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510ba3sm19060806f8f.56.2026.10.18.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:33:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Lloyd <linux@sierrawireless.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] USB: serial: sierra: validate URB length in instat callback
Date: Sun, 18 Oct 2026 22:33:52 +0000
Message-ID: <20261018223352.2021650-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

sierra_instat_callback() reads one byte past the usb_ctrlrequest
header at offset sizeof(struct usb_ctrlrequest) without first
checking that urb->actual_length is large enough to contain it.
A short USB interrupt transfer could cause an out-of-bounds read.

Add a length check matching the pattern already present in the
option driver (option_instat_callback), which validates the same
field access.

Fixes: 033a3fb980b041 ("USB: Sierra Wireless driver update")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/usb/serial/sierra.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 6e443aacae07d..8f800cde25229 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -575,6 +575,11 @@ static void sierra_instat_callback(struct urb *urb)
 				__func__);
 			return;
 		}
+		if (urb->actual_length < sizeof(*req_pkt) + 1) {
+			dev_dbg(&port->dev, "%s: short interrupt transfer\n",
+				__func__);
+			return;
+		}
 		if ((req_pkt->bRequestType == 0xA1) &&
 				(req_pkt->bRequest == 0x20)) {
 			int old_dcd_state;
-- 
2.47.3

