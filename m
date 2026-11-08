Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181786;
	b=oFxvxgqMXoy6hx5VROp9cmdzO2NEEUQHcfh8x5T0uqMP38YarlotS1vCi8DBI5rTiJfv
	 TQQNqE1l0fuXNLGBiffkztd7Yg7tJSLHZnj0u9DW083Y0CKSkeJ2kKCZ15Vy0cSyZDnbr
	 kkZ9vcN+RRM1xjYNCIV3/ccdB7vKglmjIVwHtlRfDopjJ70uA1HyWj5mfwyou/FCyU1ql
	 hglJa/EZz+ujv/i32qSLaheypqB9aUofFhIKLTIWQJUf0F5yMVNtDwyAstfEzGySbqxKy
	 JQEcY+8xJqunr1Z2crinMwo5g/rTwklpQIFbRQoK0xAKDzipNZFU54grEjb6MNz+bHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=r4f2V9+bqMcBY5LtQhLJ3jd3DFlm4gkj1qoIPg+cYCY=;
	b=a5LDWiwq3qo+1LyRjaaLYTtuZFM8LziOcNwK9ShFLg+0v1DCma36l26+oDYvzgmmkEY4
	 FP5yttGlV4omM73RG6o2Q3iT809cfCqU9Uv98qv4mcVVvIuSa36A+cri0LO+kbTmtmeNL
	 3gwyt02wPqxtqDGphHrd27VCMtmQ3028VmhRB0QbM2JsUL5ltZ4L7pg6j8C4xhUZs0HyO
	 B/V+LcmyEUFAWOFY+GWldFX6SSme9FbytdznQNyOyMb7m3JAivBWTbU6G1JNyB3Gn3+by
	 3ez2M9eoCvoeyOglU26K+AW/TpVFbXI/aA6vC8vxzuaN09UsvNN3tb1bV7KNV1Ur6dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlLKAp8H;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3D606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA3D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlLKAp8H
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-843a4ca671eso107160a34.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 15:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794181784; x=1794786584; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r4f2V9+bqMcBY5LtQhLJ3jd3DFlm4gkj1qoIPg+cYCY=;
        b=XlLKAp8HpCKak7hPhl/CidyJ2ie8n+3ETG5E7d1AGblktewV48v5X888+U/+DckjS0
         7swldUPz2MZQ8WJoguMPB62HzcMdFLpRU3lOnzfhjrea7IcVRY1WX/3EHF9ERiPRnDBB
         7MilAXgDcEJWpGl6HTcvAUCvtIP8zgSGbCuogNsHP90S4VMnYvtDC9N2qssgG+UjxbN8
         EAeEwKaqSFybEBBFucszbzIKiNhSDctzr3ccGjjqKXGVf5jGx+HTBfAl2oV7cWXulhIM
         Cib53bKbBEgT5UFwfzU/fokf/a6dvE9h7PWRXjR7Df1jVxh80pB2JlbJ8YouyoGimR1x
         NVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181784; x=1794786584;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r4f2V9+bqMcBY5LtQhLJ3jd3DFlm4gkj1qoIPg+cYCY=;
        b=lEmi7YZIf5cJZ5Tq26PRGn4zMUacLis5tEhvP/us6asMP7AWd/0MLnO1xQgMYr9Oyi
         /Vk7ENufDBrv4AK7/zzZ3bU/RmO3mOpT0IyAdNffH4HNWjcKJHRN0p3gr8Mug3p7hO7h
         dcfjlc4garz7dG/+qSM6u4kivqBQNEJarzTIgxPRFOIiPJKIpEt7mlwQURj3ulHhUSzY
         7I7wN1oRtkUkusPsezyfq3g6f7x95qWs82BWwbSGdJtMOa3PGI52zx/aaT2qNLLxRBnH
         Z+jOFjsgX3Z5XPttJuj+Tu5DInls70vxh5SGRS71hlEiVpYOsmd4fUCyDlpKiq/fce06
         3UUg==
X-Forwarded-Encrypted: i=1; AL+hErFvKYDnjCRtW3L4CYyiRskXDq5nlZNPwIIN7eXVJOWgtpknxHJnfl0QfzrDv2ZiRsIPdTV8wWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NSH2GAPxvs5A6SY8Eb95BPgrGopjVqkMsbCMqLnZkyCkltSlA
	HqE6ZTZdmnGxyCbvvaQgIyybU7dks7fNpWXGhlnt0c2NX5JxZPALtGm4O0738Q==
X-Gm-Gg: AYBFou2fuKy+CB+HcgNJUyEyXZnkJZiR4E7UZhCNdN+YZQL9TljJx4uxuX3krc4ssrn
	fSUyUJrO52wckbl62FTtaxPp7ocXBYHTlBmIWvh85HRWhexroWiOl4d9HqXWlHJ74kn767NY0G4
	E9HYLLJtpBTdz369dvfjo9W+HLy1k+ZXZTUL9QiKoGweA6k1LJvCGCk3LrU/87ERjl8xIIN5xn+
	aVXomvuiGbYU/FWZBkIN1LH4OX67qlfvwgDEpo6okXDEIRIy34iiNjKfDfQrytd6icYDOfbELHF
	kI5LF0J47Bng1ynZulWUi3+u+GNanrFdSpWE4LiLEjyhMTJPSR/tt/Br9QBaF3MzYc35BqUWpE5
	BdF/JOaD4LIJcN54AJ2yPID82KxRFQnwvcvkX4LpINrCU40yEPJ8R1r+IVGemzQlhzM5S1z0rdR
	G0uSQEXK8croZKPFXIxJEqb6vynyZmHmHcn8dp6llq8smEnaagL6b312deyLd72xIYLKIGl8Ng0
	jeqcGOhwJFWEH448LErMYJdf400BHtfGI1sqpV7rs1PSngrYp+MmbVrEPWWa2SvzEFzphUQEeRM
	/MLFiGL6cjg+kl9J7vES1tssTtJQiZPOjYGTwdqwhik/06ULe+xgg1s+gkS2nKNft8aW3Merx3F
	7C+U30hJJKiTeMrVyOk75G6JMbBINnNjbcbvOmmHZrYckzgIJfHmfaJvVVrGAFJptKjr9cQslwp
	eEMofaakb/U7ZVxIUwG96UDZmfDadxD6qM4TgfUEN1GcaSjdXNGWQ=
X-Received: by 2002:a05:6808:11c9:b0:4b9:a88b:8884 with SMTP id 5614622812f47-568144741e2mr1314581b6e.26.1794181784299;
        Sun, 08 Nov 2026 15:49:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac6352sm3019435b6e.1.2026.11.08.15.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:49:43 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/4] mtdchar: keep data and OOB aligned across ioctl
 chunks
Date: Sun, 08 Nov 2026 16:49:11 -0700
Message-Id: <20261108-submit-mtdchar-page-chunking-v1-v2-0-838cf8934ba6@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OSw7CMAxEr1JlTSAfET4r7oG6SNLQGkhaJWkFq
 np3nPYCSPZiPONnzyS5CC6RazWT6CZI0AcUYlcR2+nQOgoNaiKYUJwzRdNoPGTqc4N+pIPGiO3
 G8ILQ0olTpc5KKsOMsw1ByhDdAz7rhXu9aUQ8nc0FWxJGJ0dN1MF2ZYTkQ+ltC/0OUu7jd31x4
 oXz/zdYjIrLSWomj5Ibe2u9hvfe9p7Uy7L8ABcSfA0AAQAA
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
intermediate reads to their data pages. Keep non-final OOB chunks
page-aligned and limit their accompanying data. Finish any remaining OOB
as OOB-only operations once the data is exhausted, including when the
last data fragment ends partway through a page. Advance by the pages
consumed by either stream and limit OOB-only writes to one page per call
for raw NAND.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v2:
- Add a fourth patch to finish requests whose OOB extends past the data,
  following Sashiko's review of patch 3.
- Switch to OOB-only operations once the data runs out, including when
  the original non-NULL data buffer has zero remaining length.
- Advance beyond the final data page when OOB was consumed there, and
  keep raw-NAND OOB-only writes to one page per backend operation.
- Link to v1: https://patch.msgid.link/20261106-submit-mtdchar-page-chunking-v1-v1-0-2973a03531bc@gmail.com

To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Michał Kępień <kernel@kempniu.pl>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (4):
      mtdchar: calculate OOB capacity from the starting column
      mtdchar: bound OOB reads to the data in intermediate chunks
      mtdchar: keep OOB chunks aligned with their data pages
      mtdchar: finish OOB transfers after the data runs out

 drivers/mtd/mtdchar.c | 82 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 15 deletions(-)
---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261106-submit-mtdchar-page-chunking-v1-668636b0becd

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

