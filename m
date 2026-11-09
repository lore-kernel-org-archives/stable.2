Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187768;
	b=xZsTPhJVni4l3IdCfYW1YyTFMnbnS/9naTYkiduIya2hopGW+IpYHTjFWU+IpuZlG8th
	 qeqVitASYlqFVonjvf21dDITSxL18NwemtmCz02gk7XamUFYTBQA6l7Nnwu6ZnHx3TGDY
	 kWpTGslHFXKDcz/iD3vU7cQaJagOm+GOZv0NqwJgiRpVkn12NlpIIVIgF9Ng1r1TcpCo0
	 i0zrqoQn7qJk5pzS/iJj1yEGpr1EzDLv//K9wpKmPrYSzTi1jF+TlS6e/385Byc6IKCs3
	 PfypPGXgAJe8Y9WkotYAFuChNqJc7GNZ5af5CUzpaM9S5yJwDcqnDLQEkKCKRTmKZ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=3IT9ZF3wWg0/NDcCITM9rGC2ffWPOuz4O4zGIuPGi6Q=;
	b=v2oZ/Ge7HiJy2sIUtlRY5zTRftUCyjX2uCeIUKfDQWzej+0Ta28UyB9ELmUrflfZIcer
	 TQetSX+0xCnTC59AQ6nOCeUd6FEEUZkpp8uFSQivsDK5C1HI76CwpHv1ByhbMQ5Ria8UJ
	 SyD/M3whhyCMKeJjRAPEz00DwxF8utjEFQGez0s0gOlZXywITxYUZDXjIqgG2JO7nfhui
	 fQW4gMLLetMEwdy+GV8acZJUvncRmAgoECHtMvD89TJxhlfyavPyQI2y6OStsTM1YSXlh
	 ky1Ae9MOCECqx2iSSYt6/FD7xUtUW9XxErhjrlchK4huyYLaSyakusXW4UsDuuOGIcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T78GkiWr;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B1606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD1B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T78GkiWr
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4adea5b7a2fso180941fac.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 17:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794187767; x=1794792567; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3IT9ZF3wWg0/NDcCITM9rGC2ffWPOuz4O4zGIuPGi6Q=;
        b=T78GkiWrHNeT2swXbg6OyiFqCfiDi1+Hd1EeIZCwmMvJRZU/2YSstTMP/wMq50rbKv
         KawJrjWmcFeBRmTmEYiWEF6tj1savR34Bqw1V1f7205qRhXUWsEygxJ+tkw4wHy4rweP
         M1FqBjEaEpxz2JFDntWkZm18OgoR4iQPlBZx+mxuXj0GH+WreVOPwvtsMcRiQUwIWMNh
         bhSp3wP1XKZn4+MU5Fg19RwoCA2MgtA6UFzSpBhElgby0Qi2tp7AgKDZpln3D3eiJ9Qh
         Ru9mDhSdRnwIDfn5YmNlj9zq//WmJ2p68NfNp4UbZl5MZYniz9nu7McOl9MfrhkCwyDl
         XQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187767; x=1794792567;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3IT9ZF3wWg0/NDcCITM9rGC2ffWPOuz4O4zGIuPGi6Q=;
        b=w13T/p6aJDEpVD11D1oknhOb+bLz7l/w5oluhRRSsEfuo22d/ZuohI3zo+RzAqfBlf
         /1J3n1AyoBZxRnMgYzo6V6YzsIk9rBcKohPvr6iNQlVwVdP3PYQ3vEyqPpI7WAhJrhWW
         6dBU0XgmeP7t3hbmLMVWkjDokiAbzenUyFxErL2teKeUeuYH6nRVvBgIYnMKAshDf9Lq
         rbsecX9yvi/s7nbslyV9Bf40i3ZAhPph4YObuk0tChvN5/AJpJFcmIz41oV9dWhRGQ4s
         rB4IP8i5LYDiAhY4/PG7gmYrNP1H2+C3ytzyvreINYiisYXJKivhNkwCWI2kza1gH+ZT
         ny9A==
X-Forwarded-Encrypted: i=1; AL+hErGhgYkLPGsfpiRqaWk0GItyU0FpJryk2Y0STYhSu8H1Mwk1Ic6G2zNGeaFeDn1j4MLBZbJvTkA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VReDAO2bCuSA0YfyjXcSg7yZI3rpHd9bKxu2gqnV5YNfL/DFq
	Mikc/GdnagojeiJwqEUgFz0MaZEjmXVeO41amBZQJhyj/FjKFCm+3oDS
X-Gm-Gg: AYBFou2sO1J8vrw2iirEgKfWjaR9KjJ4slwlSFHKyO7aLhoyBnzKv8kNZDe3upNwa95
	8H+nSLdssPxkz1uh6Zi6/vDzZ/hBxV+nGbNU75arrp+Xaub1fxTe+8hFbylrcHpjEdD52S4ZzqX
	Mfe5Zy81M/dUurmefD36LVpzBzSaZI+auWHQVeuxyyBvHThCwq5vGb6P4qbYtGiUHhpb9VhTuOl
	gN1PxBBw6iKMjodWWt+q9Y8YbPqK28Z5Z1P1u6C8okymkjR54QpWbJSZ9vaeEs5fYzsBo9kw8d8
	7PIBTZa/TPjw8Wza3VKSB63btt9N5Ax5IwZ2xHarw+C0SmZG0GicqDBxPVjMkpcIV0v04UsSGeP
	Wiv6q++3/yXe1Y0hXTiL2tH/ue5V34bak+lkoYxFzwyjsDXJFdqAzX5NbjMz6F+eASk2JXRqHQR
	yxlfqj8tPg6J6n0HnNSkmDmLBV3Uf6urYrWBuc1dCARPx8Yu01R4BVAg3o9UTpqdDYyNxZtm5+p
	b8qV1DF7HsM2NhnV1uCMNd6hDjc4JQ98d2KUxyDQY/Ys+Fb5Ocf5z1kgOL0SW+f58SspXtKtrSb
	Zpa+P45X9fQVZ5zG8ziUT+6lUfT2osoprAAPQpAYw8CH834V7kCJxnfy4hi2wtshKOhxe+Q3cYG
	t0/lsAe0Plvh2WZFhiGnJRVjt9wVB+Oml5Svb8dEijklCMQ69kVZTYkB8PLgVo3zp+Kf1N7noxV
	BXMfGRK6wrdOotOxtb4eeJMzDzXO77Bg7xtgEd+VL5fzJATWDGwRc1
X-Received: by 2002:a05:6871:825:b0:491:6c73:817e with SMTP id 586e51a60fabf-4adeb44512cmr1457682fac.5.1794187766772;
        Sun, 08 Nov 2026 17:29:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade695a5a6sm4225818fac.10.2026.11.08.17.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:29:26 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/4] mtd: rawnand: restore SmartMedia setup in r852
Date: Sun, 08 Nov 2026 18:29:19 -0700
Message-Id: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQrCMBBEf6Xs2cUkoLT+injYJKtZIVGStRRK/
 91ULwNvGN6s0LgKN7gMK1SepcmrdLCHAUKi8mCU2BmccWdrzYjt47Mo1vHksGWqmjkKIalSSDh
 bdJOZJkvEhgi65l35Lsvv4nr7c3c8Oeju3ReeGqOvVELaq6zxWKj04EVh277+bkYYpAAAAA==
X-Change-ID: 20261108-submit-r852-smartmedia-attach-v1-290991aae0aa
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

r852 installs its own NAND controller, but the shared SmartMedia setup is
still attached to the unused legacy dummy controller. Run that setup from
r852's attach_chip callback so the media-specific OOB layout, bad-block
handling and page-size checks take effect. Restore the hardware-ECC
default during probe so the PCI path selects a valid engine without a
NAND device-tree node.

Before restoring the shared setup, correct the first ECC region's offset,
remove recursive NAND locking from the bad-block marking path, and select
the standard OOB writer for r852's contiguous spare area. These keep ECC
bytes away from the metadata and bad-block writes within the spare area.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
James Hilliard (4):
      mtd: rawnand: sm_common: restore the first ECC region offset
      mtd: rawnand: sm_common: avoid recursive locking when marking bad blocks
      mtd: rawnand: r852: use the standard OOB write operation
      mtd: rawnand: r852: restore SmartMedia and ECC initialization

 drivers/mtd/nand/raw/r852.c      |  9 +++++++
 drivers/mtd/nand/raw/sm_common.c | 55 ++++++++++++++++++++++------------------
 drivers/mtd/nand/raw/sm_common.h |  3 +++
 3 files changed, 42 insertions(+), 25 deletions(-)
---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-r852-smartmedia-attach-v1-290991aae0aa

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

