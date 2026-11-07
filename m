Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794028843;
	b=nQ69ngnRhBCP1MZyQ8JG0PkDOpODWtUBngOs67ebjpmJ4+27jlmR5L3soBsu6ScINWbQ
	 rUvaZ08o/ll2171xJhfpO6l2/zDcq0xbDA09JwET+787mUvVRXSCRqGecy9+jqaV4Xyx9
	 psYkHEvoYuHo17smfAV5VD8ut7wS03O5dnNoqUV3bd9avwVQMSWSHFxMrEoB8WsTytAGu
	 Ci1RAdBYCW+KZeOX5dF/pbyKzxu+bhl2iVModD4ysmHFtoFq3JBThygItGFU6SF8YL2DR
	 IsbSvrH3DUuexx9VGngyP3nj9TofD5jUcNTjEDBtK2ZXgULbsd0218b4Lt5vcMzrf+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794028843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=v9Tdiy9REOY1qeQxFjltXsTnBPcqZlFKUcohy8cjEnM=;
	b=PikeplOMBu0RZlnCOcK1UfNl1BOGtEDrGgQ0o3dudGc9Zbbl3BaLmTxh+KjxnzndEw5Y
	 avSjXoqcnQre7hWRq3rXLSpJaJbmJzddtKR/4eKe1elILBIDRPS2p/qXQ/+dOK/1+tEyd
	 ZZCAFlmHUkQca4iRS+h4BXSsvhul/3cAn2bX0AXSU8P8U+PcUtysdAzPnxV8cXmOQ9oas
	 Vsfvyj1eyei1V50t9+yhZJKdK5Dh/oJt2Bz4ToBH94rWUVE6gWhbkSuL/CV3vv8z3MwqO
	 oMd6rnOy89sLR9/PZwgyqmJRq9p1FqYwkRXzuYAjjhwaWxK6KVSxLsuo/Iy7p6V9gFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RYqPScO4;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 05:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 773D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RYqPScO4
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-563a0462094so643229b6e.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 21:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794028842; x=1794633642; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v9Tdiy9REOY1qeQxFjltXsTnBPcqZlFKUcohy8cjEnM=;
        b=RYqPScO4cPEx58XXCs4YMXEPGQK7K8qQCGw7XZ4hIAPE0vYmKl92KnhNEpUcjjpbW7
         ZkcOiBMpMJIA4VaXLIz2W+WxEd6DMYzcakRcTCNvNv48Ew0SXSUJuHheAPaZneAT2SGL
         Neu5xBe8h/vDWgH5l9jtvg+WDYHg60WICe+/pc8soaicovEiTsfL9xw4BwTDch3J7n6W
         dEcGKk0xMsO4oS3LoE/rKPhARjU5MDGwL2uzd0sfjISfZD+k6CrovN3VkVJdgP57YJij
         tKHRCow3DEtoO07ilW57X8US4swAPkbAjzUWfq3dReQaN0aMu8RbtWNHhncKSkVkIvz8
         dygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794028842; x=1794633642;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v9Tdiy9REOY1qeQxFjltXsTnBPcqZlFKUcohy8cjEnM=;
        b=Yf6QEdaK7+xF+Cg7j4mX16OfGhtIvvHne3XimjUZPaNrjd/gGQF7aNfwwgVj7hmvYb
         RX5lqhtChb/dc9xHhuvzLY6CHhmzGoBp21f2vnCjmADo46+vhPUcQRHnRLDmlao32fNs
         gd24qRz46BK0Z01QaozZaPVqxhhFB+iGn0fpFj5aj3+W4PvGO22Oy/8Xv5WpuXsDcve/
         FhHsHbV0BiAzNeS9Q62fTunrrYDERJQQg5FxWeHuSOhppjthfVzIMBTF89/hoifMM+Fo
         mSarUtYt7xOeEnbbhjxi02PrW2Twm0ziAxORif/Kn5IELv0Ks3oaoVlIn0JbNQOAs3yP
         gdpg==
X-Forwarded-Encrypted: i=1; AKwUvBwSlDcLy4HEfQjNek+UP5YAu2vIMkaNRWwfsFd652u6vOZy3FRnlrZy/FJkaCwHgRhF0lL8Wag=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ct9DSQoWhtcyZIIhA19xO2+wlUZH5efNi09OQhZHHQtEWxp0z
	QbnPULPXKQ7uwUby2mnAfvMH7zyHreGSfly04bYGBS305S5h+cOESi95iiok3w==
X-Gm-Gg: AYBFou2GvdRcD1yCs2B5nO204FXWjMfyKUUbfcDwRuemiaJZpVPhT7TTz6rFTWVCbHd
	mAP2eGmilMsejnAt+q4UKtzgkvDNMTdD9iI/QNLweSRZSvRUbhfXiOljLqN1HyLE5a1fYIPi80N
	2mv6dIH80ccVE7HYZ+RoWiJaAnfHL/D/GBofWCEH1xukbmzx1hU5DwL4bwNqO+QvmuhVLCV7PVT
	xa6USn3DLiWitKJJtHFYZLiTR99wcyOQ3cR7823kzSk+hMGU6aQlvviL+8IrnjZNxfObcVp68Om
	FQCNSFWn2yF4vkBoMZjgpuBddVJ4huW2LKnpiGrHKqsYVsQwnse+LiXA0WlAV1f4PiRcjtj1kfT
	F4pwU0J9ngXFnBx+nqyDF+PmBu+I8G0eK4rdKSnDIQzn9OU8qPwnMSF/vIEz/texDckQFSlwLX8
	L+p8Mc/vHKhuqe3Qcd40D99jjlvtkzZxzCxtWsCJpCGa5a24cvd7X3kkd/Xnr7shbQjcONcVE+F
	ajMpyCuZVLGU0Pjosau65pIRVK/dhfd4XHirwPUx0EGnX3t/XnhB00HQhnKfUh6Qgz1ShjoH+kT
	BCquIq0AQNgYn/TkwgzYxN/iuh77yFOTOEZPwjDam4j7qSspxI3gEpcPf1dvhJikbENWrcXOYGM
	r77iAOjvsKdcSVQHxMuxQspC3J2m7eaQ4BKhzyHvk7TkycmhV/w2JIcEAKwXY9b40MdWJ1dx7kv
	uiChbig5Edt/45suj838hN3vyzmNVceX5UlAg6z9px7kPPal784Ec7
X-Received: by 2002:a05:6808:10d3:b0:4f5:d873:aaaf with SMTP id 5614622812f47-567e1440dfbmr4090440b6e.14.1794028842361;
        Fri, 06 Nov 2026 21:20:42 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7ebf4edsm3059846b6e.13.2026.11.06.21.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:20:41 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/3] mtdchar: keep data and OOB aligned across ioctl chunks
Date: Fri, 06 Nov 2026 22:20:38 -0700
Message-Id: <20261106-submit-mtdchar-page-chunking-v1-v1-0-2973a03531bc@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QrCMAxFf2Xk2WA7IYi/Ij60XVyjrI62G8LYv
 5u6hzyc5ObcDQpn4QK3boPMqxT5JAV76iBEl0ZGGZShNz1ZawjL4iepONVB7xlnp5EQl/SWNOJ
 qkehKF/LGcxhALXPmp3z/DffHwap4cahN2xLeFUafXQqxrdR8bnN87fsPjK4B3KMAAAA=
X-Change-ID: 20261106-submit-mtdchar-page-chunking-v1-668636b0becd
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

MEMREAD and MEMWRITE split requests into bounded data and OOB buffers.
Their chunk lengths and flash-address updates must keep both streams
associated with the same pages.

An intermediate read can consume OOB from pages beyond its data chunk.
OOB-only requests do not advance the flash address between chunks, while
a buffer ending within a page's OOB can leave the next operation starting
at the wrong page. When the OOB buffer is the limiting factor, the data
chunk must stop at the same page boundary.

The OOB-limited case was found while testing a proposed BootROM-format
MTD view with 1024 data bytes and 1152 OOB bytes per page. A 64-page
request has 65536 data bytes and 73728 OOB bytes, but the original
65536-byte buffer limit lets the first operation consume all the data
while transferring only part of the OOB.

First simplify the page-capacity calculation, then bound OOB in
intermediate reads to their data pages. Finally keep non-final OOB chunks
page-aligned, limit their accompanying data and advance OOB-only requests
by the pages transferred.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
James Hilliard (3):
      mtdchar: calculate OOB capacity from the starting column
      mtdchar: bound OOB reads to the data in intermediate chunks
      mtdchar: keep OOB chunks aligned with their data pages

 drivers/mtd/mtdchar.c | 65 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 11 deletions(-)
---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261106-submit-mtdchar-page-chunking-v1-668636b0becd

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

