Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AC381EBE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944260; cv=none; b=cl2Tcmfba8qm8NeQ5r7ceuoyF67lZqk1p4JJQc4YoaXaRzCInBIoW24DV7Ac/P7PWRKFUYICaxN55d9mVvgHlO0wgPd5z1+HBZBotP2qYFurN95IJvj+352tPUkbMRIAu/Z5IHHomieiMDbAXNRcE3rrw71EHTGiEgfZtVjvEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944260; c=relaxed/simple;
	bh=vV1VhIAuONEmnbG4Bp5VF4zsUQEK2yLhV+oC4X2dBtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt8rVK1cfATFxP+3PHwNynKLUWRyCO0uSAS9hE9Alkj+pyTbIbvZ273ClgoFC1a3w2W09lLe/G+Azdjxk7LB8lVH1rD1jfYc6SOdfu19l1nr58o15Qq3dEiM7HJMQ94kMz1QO2zwcCNe8G1PKLyfa04pK8hzW2CD2JKnaoONYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWgPC3zO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWgPC3zO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso2384478a91.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944259; x=1784549059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbBLBFXxW/JBreBI2+xziQALRD5/GvPJ/LzRgunvQI0=;
        b=VWgPC3zOx4E3aE7XEowf+iWjq6l3HEyXwciNqSLMRUOJh0/cxBCPxspWeeMRb3ean6
         yQJk8YzHrs+FCDC2KAHsoSXwscJFNUmP7xsclCG1/+KVFBlaAX68HgaNINeUUBQa/Y3p
         5Zrbery222htoJ5Kb6HlhKW3rR0XBj1IW60W/nueUzBpwd7Q7qxQn9TqQn43NkqKHuOl
         0YgufI7CmWSw4vHF7pHlDp4AojN65MUaLZMaKPGMbmNzj7pG3TsRm6Ef8qvkKEztVtaf
         5STvKhmjYHU8Bpgllrxd0TnbeFkB6j2XBiWGDcgMc50t5p4j8IhHvVnci1IZbcWrM+dt
         zWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944259; x=1784549059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbBLBFXxW/JBreBI2+xziQALRD5/GvPJ/LzRgunvQI0=;
        b=qhwomH8D4F376zFv7L2FtCwOD7vP/YW1EJvc8Xsp3XKkazAJ8yKovgnFl6D5GfQac/
         N6Ys/c3V8Sx4OKJaZbOKoUJRxOrjUjVlHxCjpOLNVnCe1ObcjM+d38zorb6gnpYUrve8
         QVOU5paAW29sFwShosjtB+4UChjvpElLv+ETcYHbmmpcB0es4e/+htbNcOK9d+WWzg54
         Wzgr6vzF4JmYnzB66LzsGuUXW5QMs++pWyJpHsTUOjljOIasb2VLnyHkvL7+QE4lmaob
         k0UHNbuEaiEurxV8JBRmP1aB3RP3aJWJZhiaJWkXur4a1qCTXtZRI0AnaCha0anKWHkE
         ip1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqn491O1KyUO1h5Ki2zZcrYcnkpRt37/a5zZJ3n3IdnpvgHBzIc5BG2GDEvkknyaW1aV5jqnwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZBdd57SMZ9b9cmNcgMG0h0i4w0nTHk02tFn7hWYGvtgduSA8
	9hBF48bsJ5x4UjiZMQYs0SjjgtTKDQCQMlkdvq0MmDfPXfIw3HSgmMEw
X-Gm-Gg: AfdE7cnyNzOTUa9KM9S9DyWdbZEg1xvOVwtLYUUcnSOPqLwKm4KkIHwcDWGPW+1DJ2K
	v0N10URtvDUYKTuVOtnGHXVSluhkkiHt+NLqAbUKGoCibrfYpvR2mFWOG4bWcWUWzvwBtHbl77q
	hym7JlYo2VoZm/6Zx3zTSaiKoGFzjpZ4cepf+VeTaR9907VobU2RVzVK+ADRAu6cU0L0lep3USv
	ffN9FgytGvvhSXkuE1B/Ha9ZwqWJiGL9PscvwaM25Sdv1dWvz8dlDdJnutAetXfIsMyLOP6PSxe
	gMgb7WBI2eA2SCkjSNIpgEKKTdvwCttdqywIfAeq9hukS48aGyrujmJEMFyoAbE5J6mqBwv96As
	BKXkXfXH6PE3vIriECnyOC0toOUS/LFbJD/Iv8/cZ9i845MIsxXGgE4JhCmAehiMVq1ELI0ieN6
	hMHHr2Jw==
X-Received: by 2002:a17:90b:3d48:b0:380:7d9f:81f1 with SMTP id 98e67ed59e1d1-38dc74c49acmr8119797a91.3.1783944258918;
        Mon, 13 Jul 2026 05:04:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm6419887a91.1.2026.07.13.05.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:04:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] intel_th: Fix MSC output device reference leak
Date: Mon, 13 Jul 2026 20:02:05 +0800
Message-ID: <20260713120205.1003691-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_th_output_open() looks up the output device with
bus_find_device_by_devt(), which returns the device with a reference that
must be dropped after use.

The reference is currently intended to be dropped from
intel_th_output_release(). However, a successful open replaces
file->f_op with the output driver's file operations before returning, so
close runs the output driver's release method rather than
intel_th_output_release().

For MSC outputs, close runs intel_th_msc_release(). That release path
only removes the per-file iterator and does not drop the device
reference taken by intel_th_output_open(), so every successful MSC open
leaks one device reference.

Drop the device reference from intel_th_msc_release(), which is the
release path that is actually used for MSC output files.

Fixes: 95fc36a234da ("intel_th: fix device leak on output open()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Add Cc stable.
  - No code changes.

 drivers/hwtracing/intel_th/msu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index a82cf74f39ad..84d99d7b1d20 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1490,8 +1490,10 @@ static int intel_th_msc_release(struct inode *inode, struct file *file)
 {
 	struct msc_iter *iter = file->private_data;
 	struct msc *msc = iter->msc;
+	struct intel_th_device *thdev = msc->thdev;
 
 	msc_iter_remove(iter, msc);
+	put_device(&thdev->dev);
 
 	return 0;
 }
-- 
2.43.0

