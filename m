Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9C3D7D6A
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364082; cv=none; b=IXWkiUEC1F2tAacoWeUISVFavmpeyZdAMdAXwyshP2n5SNo7zAYUgOvapvfxUJSrZ7Yg8IL4Yh2Ydt0/Niwz0jZVIY63u/j0dyqj7Vk3YpyCGYdJwi9b0tGDwJf3fjd/fjhfjclIAXwnS37fNktn1wWL4o5EcmcnLsNOfud55z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364082; c=relaxed/simple;
	bh=XYhSvFA7CBE5j2HCUixLblDFjVWyrOA3uBQKm7vadDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQyqSY/QqAv80p8OD8WqQmImAQoxmJ9ajHMk1/+fZ0ZhjkEwy7MpaWDWMpGgWznpp/YltETS4NLZJeP4jU/yQgKH0Q3Zh8DcwH1LhL2RP4XQzFvrDcvJapew2DH0THeyIOWcg2P/544S53l0ZDzB7NEWNu2i2l6R3TAh2XUN6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdnt1SQm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdnt1SQm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso777331f8f.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792364079; x=1792968879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X1kgUc2g/VLG79PKdhTxP86IrE7Gw22NMZrvrz31EMI=;
        b=cdnt1SQmdLpQdw4/vsPLYrjkdD8r6sYDy4++rdwleAx64mjKe/vn1eFlfkn5GBxr1B
         4JoQtVHNjqbtxqn3Z99sOf4E0MAkDbLLc2oDLmVZsQ+iw12SZsl9J5F4AzjXjrSJ7RhO
         hYnFjqZOV/qxag0gTy5W/M8QttJLXx9WFQEX+fdrwUSQxYHj+WsLMUHTxTO8kXsiUeoy
         gmnB5hVnuqRPxPOQDa4DeEEkhE4jNs1T+tUX/7rVa8dCsqaFgJok3nzsQm0twcbpl690
         gzi8XXk6//eLLOUdWlASm1q9AtIl4Q+Wxz3LJ+ieCcBAsrM44/CyeiipK0BB9sRKAMV/
         z5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364079; x=1792968879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X1kgUc2g/VLG79PKdhTxP86IrE7Gw22NMZrvrz31EMI=;
        b=hncI4q/+IM8JRy45uIVkb0qxga5ITfrjLPqji0SlcDXFumibjKLvX6SmrLumnmF8gS
         inCDXeiWsHV2Qfld5KcWQPjhCpYsZBqimpO5/HyJcWUoU6l00BzxshulWuOxBV/7Aks/
         N5nl6U5HmXG3YFk9FbU0d5/gq+g0jAxSl9KSsOyNEuSEAK8053Hkb1IluShzSoSppRYZ
         3KcOfWrrUePCj3Ew9vLBS4qUmBeuV1cfCa2qEGYil6mr3FPx8VSLtg6Y8vGhLh6q8JFX
         wpZoytlId0ZR3z4KK0QxCdqCvdwMT0BYO7ZsIBLWYQhCMg+8roGNJy/1U3Kl+Xbvqrxt
         8Drw==
X-Forwarded-Encrypted: i=1; AKwUvByCMaLnZJoSMa72a2EkSYyYxIUzu8dE6sVXrz/U7M02dMElHhKkdOngf4tAWv+WyGK/wF1ncAY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOvZ7zX5JATeUf1SXAmQGxntMRqhKIQm1v9Fnp7JlT6WXn23vt
	3vbhpHEUk3IR7sfQMNKLtWumHH4DY2GAXcD0iSet/NNGWnH1hBvmG8+cchlP
X-Gm-Gg: AYBFou1auUIFYPs35gaI9O+I+ie9KUTwlEO0BfXuv4EsaOdmDqWtnp2AmYQ2y5coik0
	/H6dqAba/FTYm2NbCN+z3GTfxTou8rizBsUDSUbJNukGP7b2falkLarF24UQZAsK7h9gZhgABe+
	nF7GUJfllpLrGc/I1UzHiEjbzf2DbDuMFfiOm9hswkaRYVRshDGQrZhETXsYL2xnp0OWfDqjhYy
	UGTJlQqquPe4ju2Jm8w94iA+7vgNcGqMZfVeonMCm7LKkMwMiI98uSCQnpu/H07DwgYVK12r3os
	2mHW3rWZxCmXfiMtnrdw5M0VPFyY2oaOTiAlMcNxdx5RSzn4hmZtGPAxv0CXJPX0YkAjtw/c4Hw
	idG5eco+4DZy6yDKA+ghx+9Dk00QSXXYy5VRuAJVSaeZzLqeGcnYoVpyXWUjRh8sleoa1gi4DdK
	ezXuccJ9v0hOxizoFQudcwQt38urDSapCh48ducGQ=
X-Received: by 2002:a05:600c:548c:b0:49f:dc71:e609 with SMTP id 5b1f17b1804b1-4a1d7610f2dmr127399005e9.20.1792364079193;
        Sun, 18 Oct 2026 15:54:39 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e19ad17esm42257355e9.3.2026.10.18.15.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:54:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 0/3] media: USB: validate transfer lengths in URB callbacks
Date: Sun, 18 Oct 2026 22:54:34 +0000
Message-ID: <20261018225437.2655311-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Several media USB drivers process URB transfer buffers at fixed
offsets without checking actual_length or iso_frame_desc
actual_length.  When a device delivers a short transfer, the
arithmetic on the length value wraps and the driver reads or copies
from an unintended memory offset.

This series adds minimum length checks to three drivers:

 - cx231xx video: isoc and bulk handlers need buffer_size >= 4
   before computing p_buffer + buffer_size - 4
 - cx231xx VBI: same pattern, raise threshold from > 0 to >= 4
 - au0828: isoc handler subtracts 4-byte header, raise threshold
   from > 0 to >= 5

Tristan Madani (3):
  media: cx231xx: validate minimum transfer length in video handlers
  media: cx231xx: require minimum VBI transfer length
  media: au0828: require minimum isochronous packet length

 drivers/media/usb/au0828/au0828-video.c     | 2 +-
 drivers/media/usb/cx231xx/cx231xx-vbi.c     | 2 +-
 drivers/media/usb/cx231xx/cx231xx-video.c   | 6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.39.5
