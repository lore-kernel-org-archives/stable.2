Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74551C34C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555542; cv=none; b=IOEjy+8ejk2NsAFDTLTJH3Q+tka3dW9yk2GoldBL/iH6tSf8ZjX+mhCjpp5lZQ1MtKZlSdadXI8VQ4k51vSosnWwxKA1GGVZOdJCi04CDRP7O6jJZYNG5kQwZM+OD7wjLHFwqZs7RD/Nc7z+dgqcmN+d4C4RYQMeZbgNwi7q3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555542; c=relaxed/simple;
	bh=mYlsgrDQw0VP89f1tdnzaO8DqqEdv28FwA5WFWNhrC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myCsnYdbbid3De5SbEc/fNY0kNmCuKoKfRG7JNmlY1iQWB2KUWcwnRcokLAKnnfXV2dZR57EcK4sw8mdtFp3MH7HBQMBBpfXXb6ZBGcWapWLtjtyijqJo8OR8CZA9YRf03brig57/+qzLfNjaj2vzmk6VDzVB3CJm84OkK4z6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEvoXsBU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEvoXsBU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso11117625e9.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788555532; x=1789160332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GiCJMpso1xWAYxd1379kkeROa3TRTeuMW+d9bTg3hU=;
        b=UEvoXsBUmeXCU+P+1p+ppbdPrtqpOCEGBRxLqIBm9qvmZP3AoY7HhIA+qwmouy3pFr
         uFLuBzN1kCAHh8LxQZ/KMeHxt5/PuwTnurBeS+xoLLp68qG/PTSH4Ivn8RhEwa6p4wEY
         R/U/Bmw9SVd04gzb0tpHw4qA7Q+4u/4jdhavXwu7WM+vKNDEfy7Fo+xUVq7XDo0KZkut
         T1LZ2mgpAJSCfOljHOUA1kDdsxjrou7qS/T/v61woMKacAzsDNfqvBG4bT/4EXb4bWm9
         9JWbCYraDbGWzvJA4VucHe6M1QTg7qE29Di2g9kUFqiwd0C68jCpKqUWK+SvtDpBCGwO
         2YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788555532; x=1789160332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+GiCJMpso1xWAYxd1379kkeROa3TRTeuMW+d9bTg3hU=;
        b=lYulooNkWUxi6cf4M/GA7L4EnNYH0iLUrhYO/SY13XuHwG5Uc728vIXgLmLuLdwwht
         v+zA/z+SA33C5YlKvL6OulXcsn1LkJOViJ6wf71KzcqnIQ4gEWa2x/jr/Wco9uzojEC2
         eWj4yvkAOhYxZktuqWniQJX7pCd99lHs/iZpdXJX0C081osHflXI4knrhdH6QeB47E+h
         obpGEZK0FjK21ICYqCDIRhWJX+pK8btIBXushewdpsbofwGdPFn2wUJHsn8/5aoKyUxJ
         L6xrwwQXfriAkmrPrm4h3plJTdiPdpY7aMRKru7SmlXOZvhJDZdqIK2hQnVCp2LTP3OE
         lTRw==
X-Forwarded-Encrypted: i=1; AKwUvBxod4pxbl2RVM+vNqUNM2aYcy3zRXuezMMgEYyEzBKrr/u47LExnOmJnnGf3E3mGZywHP6Akxk=@vger.kernel.org
X-Gm-Message-State: AFuF++loJwfvSGiBC29tyMHIV05aO7iTwG0sLpPRGf/97IX0e0o1/slu
	iwuY44l735fh2/gF3r2b4L+usnpDuWVNiye703c5q+kPsM6DbCPOxdY=
X-Gm-Gg: AYBFou395XamioGIGZvPp6GI3bQ+Jkn39wxRkZHslCz4Teyq96XHVzzJJUu4ASkacbe
	AANU02ip+RnCYwTRH3BEqJCT2aJaDlyTj1TSYzN8dqGINfixWOavkH0S1te/gIlfn+g4yHU2qVV
	y48ooN/7cDgdfJqfa/J5ti24iq46BmzgkIV90Or9WOT12tzBZdb9vOMZMDX9l+ZHQskEnzaRNwd
	fFBqm2qco9pKbx/ke1sfKkn02WU3Eg/Hby0rHsLQcwnKgEKkW5xfjsAGIlHc7hXGTjZbAKTR55m
	576d/BzJByt7XiBxnziSYgGFMOqhP3Un6gC9oxNZ55lX42o/Eq2eNpSbUVyGA1Kx2IcEBoCQcs5
	Lldp2VJBYXFxgmURRFEVFPFMqlorH1/6DXCG1O9ESi34Mu7LzLG3lFXrQKA4DOq1UtaIplCBJpU
	D1G9S4xblME9EiigdwM5MvKn/JlvQeww==
X-Received: by 2002:a05:600c:83c4:b0:499:db6d:bc97 with SMTP id 5b1f17b1804b1-49cf7f5058emr97223535e9.0.1788555531716;
        Fri, 04 Sep 2026 13:58:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4761dd1sm153781665e9.0.2026.09.04.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 13:58:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 2/2] ALSA: usbusx2y: validate URB actual_length in interrupt callback
Date: Fri,  4 Sep 2026 20:58:26 +0000
Message-ID: <20260904205826.4071119-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904205826.4071119-1-tristmd@gmail.com>
References: <20260904205826.4071119-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

i_usx2y_in04_int() processes the interrupt URB data without checking
urb->actual_length.  A short transfer from a malfunctioning device
would cause the handler to process uninitialized heap data from the
kmalloc-allocated in04_buf, which is then copied to the mmap-accessible
ctl_snapshot[] array.

Fix by using kzalloc() for in04_buf to zero-initialize the buffer,
and adding an actual_length check to skip processing on short
transfers while still resubmitting the URB.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2: Use USX2Y_IN04_SIZE constant instead of bare literal
 sound/usb/usx2y/usbusx2y.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 200b708aacd6d..108f9bddf9aa3 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -189,6 +189,9 @@ static void i_usx2y_in04_int(struct urb *urb)
 		return;
 	}
 
+	if (urb->actual_length < USX2Y_IN04_SIZE)
+		goto resubmit;
+
 	if (us428ctls) {
 		diff = -1;
 		if (us428ctls->ctl_snapshot_last == -2) {
@@ -253,6 +256,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 	if (err)
 		dev_err(&urb->dev->dev, "in04_int() usb_submit_urb err=%i\n", err);
 
+resubmit:
 	urb->dev = usx2y->dev;
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
@@ -305,7 +309,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
+	usx2y->in04_buf = kzalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;
-- 
2.47.3

