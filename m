Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723507;
	b=W8/toc/SKOGURDuuwrlpm2JZvgrox58UAwz2bILoZMF2LwRkwbanjL6WsFNWy5Kg3geE
	 M36TcRo/R/iiUfGUa9CnptW2Zj1LLnjVDzcXDuQEHKdNF3zzt3vNDLUFTDazsQn7hECTQ
	 dZ1yc0+65C6fRDUnQte/KMa7XAjTPkMKlpDMqggvu1SLE3hsDHDwQtIIeHMPJ/u86frv9
	 7qaTD9ChxJSpqoenCviL3gdL2W7ZL7yaZ/F30PWe2KmDOk+CNAvclfXjjKUjlbRw6mpLd
	 LHerGuVp4hcKWTvDBzLEBGUF1lWO2HwVS8IJiDfnwwLQOoPcjLDWdORlku5p6JHYOVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=tjcnLeVYykQLpngMcaexUPjWqyhAHn6eUqbyAQMUfmo=;
	b=mf2aYa7x8nOwu/Q3ffiHFsOAS1/Fsmb4L4kZM4iCwN/L3jMAQOJOVum+FshMUqfn19G7
	 cLJQRxxZoWwSyoyKuyL3bIIEMebPRZYE4pk29/XAw/OgVs2v7T8JgFiyNoXnPUwxoFXPQ
	 PQohHA4Wi9YfDtnUDp8Dwbk2ztDPz24FjOILuxxWvLPHo4aaFr3wOMYXGeqCWEPDNaiHU
	 0wn4n0+9xnDFoOgkM0k5fVTF7xJseAtjZZpC7dnJMrpcLK9W0j5KiUcgJ3LOXGrDuz5EX
	 32K+oRPE/Fc6uS4d98nfwSzM60Weqgtm79RnTqYFg6kdD3poV75IixHqqOy41v+OYKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiF7zBf7;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2F606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1C2F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiF7zBf7
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-483c607ccb4so3777119fac.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795723506; x=1796328306; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tjcnLeVYykQLpngMcaexUPjWqyhAHn6eUqbyAQMUfmo=;
        b=LiF7zBf7RXZhbX+O39hs7k94WvgClY0TLPmMG6CgrPmBUMHz5LCPro/F1HNhtOY7pO
         qY1BmpL8txQx7QiWJ8iavuu2nwVB5A7UOgqQVbWVFJ6wd+KoXy05h0+CiKa5K9OPb5xb
         SxXrAv0wBZnQi4kuVGPfXYYrxgtVxxjM78Op/9zcbBXaSYJwSom76jz1YTO0H1ttcPgR
         02eSktLCLbWOwnqV9B0XaOtGpbFvBElSbU//d4F4MCTOirxB0tDdZstJP3HU1voUreUx
         Epjt8UotG6Rwyk0rkeHW6tojj4Z2Vj2oIFhpxjpCZ2GlXz7YkiYQIh+LtfRqIyj2Dm4h
         67dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723506; x=1796328306;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tjcnLeVYykQLpngMcaexUPjWqyhAHn6eUqbyAQMUfmo=;
        b=R7xYrZDeUOTXfjloUWSIZX/DGbjQJrvf4cZmyEza4u2Fu6r2qe5agd5sR9alEiSLJE
         8PyV27ufy5NxKWUjPw7q9UQVlnTPznBP53ewnSc+/Xdgxr4Vwfxy4CEElrP+pxJxpfVG
         1uSH9tEoCJIUY0sMpWCnUQxWzwwzsnRVnKM30WYF29NnK++/c0Htav8BFxjsDP/RYsjQ
         /30Y8tQOSh6wdYC5KJlp2AlBAOJSXxzydLeEWFH3RUJFSpGIHIsIFU/HdpBWz7iR0U14
         BtKvvi2wEx26BPkokrr6tAQdoZ1a1vTLwzHSocLvGyrJOEhEb9O+eHqAj1HxGRhnu06o
         yMjw==
X-Forwarded-Encrypted: i=1; AL+hErEUxuLurUdkC6kSzMIBXHOcKv+yjx9zsy+zd18x+2nyAPOmCSgRhfBUdr/+Us8ZnojDtbtlrf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5MhwEvfv4YcZkefU5vJnmXLdpXaGgHSemqtZ4Ot2Mu0simacq
	AYdTZfpiJbk0XQJvc97MXj9S4Sd5ZWfEufk1URq7L/F5aXDXmgcRp532
X-Gm-Gg: AZFdTZc30H03aV5Uk8fEnjzSwLpaVC7mgh/9EpGuijwFs3cbZXl+hF39sBdO76Reoiz
	PGcpmAa8k60pNAP08/l/SrCKs9pUOUC0MfPyWfoX3zt8DQwp7dXyALE725eD1lu1BmYmMRAQ+SU
	rixE+SmO/T1VQH2Q1uwx31qWQwMSOUuBlb2cFiEiR39YMASETvA/XWcFzqDFG3Ia5JFASe5FNfI
	x0wZYd9ubZ2xI/WQS5iGPX17O7YanyhmE+9BwMk10MtiMG+CNHKoCHczzr8EMulWZWxRQC+oJpf
	8m0LOyooxG4pPJ/gkwUMsfeFouh5sT3NdkakYVQODAJGhku3eDr6nCdjGYOnNpeAbm20hgn5CVF
	yAlqttNOE0qZgK96pvAjySRSHEIWGwd5TYqf/Wifi/SRCxr7PqjJJzwfZhLpYTLZlkZriFu9P4Y
	+ivxBjaIYH6kUHKtRp1c7RUT4U30pOxcmDL5gRNDblOBM5hmW/B+BZ+FeUV7fLepRUKh09iBJEc
	xIMfoP/N1eQTl31s/yZO70B96CboSZurilsqd0UaxNtBgFC59yTHzqQ6CN4waHFR4aIy0dQYI92
	e5NQtAizbNqWRddLr+iVjtcytprVgw6mlTrzPpv/RYuxLpnw6nixECqH+ZfHPqfoCmw7YsZ03d2
	ipEdzKNW2MCgXz+P+prZVwHIrROGZrQFuZM85JPEllwzH/QUoP64ytemismKF5njz3VrV3msaUX
	YJun0Wwq0U1WbdiSULhpWtd57QuayC27ciDvJAlYvOKaj3g5vCTd3j
X-Received: by 2002:a05:6870:f61e:b0:4a8:1837:bc27 with SMTP id 586e51a60fabf-4bc7d272a48mr21046401fac.3.1795723505731;
        Thu, 26 Nov 2026 12:05:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5fc97bb2sm19548249fac.9.2026.11.26.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:05:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 0/2] mtd: rawnand: serialize OTP and BBT recovery
 operations
Date: Thu, 26 Nov 2026 13:04:50 -0700
Message-Id: <20261126-submit-rawnand-operation-locking-v1-v3-0-cd3794332f23@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WQ0U6EMBBFf4X02ZppgVKIMf6H8WFaBra6UGxZX
 LPZf7eAiRufNOnLTWfOvXcuLFJwFFmTXVigxUXnxyTyu4zZA449cdcmzSRIJQRoHk9mcDMP+DH
 i2HI/UcA5LfGjt29u7PkiuEAwuqNKq7ZgiTQF6tx5c3l+2XXCvJKdV/Q6cXBx9uFzi7GIde5/j
 ukBL1UJAjpbdto89QO64731A1sdF3nDlPJvTJmYkIOxWlUd2OqWed1rBHo/pZvNezdmMBJP/4n
 dZGQF6aIwdaFVDhILrdFYyAlroVujoIK6UorW/gPFiNuxm+zhd/MBbfCjO3M/T5xC8CF+dxZcd
 6pAiW2JAn7yPaaA1y/XtZlU3AEAAA==
X-Change-ID: 20261108-submit-rawnand-operation-locking-v1-1a0b8fe786d4
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Kyle Roeschley <kyle.roeschley@ni.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

Route raw NAND OTP callbacks through core wrappers that hold the chip
and controller locks, and protect marker writes performed by BBT
failure recovery. Both paths issue NAND commands outside the ordinary
MTD read/write wrappers, so they need the same serialization and
suspend handling as normal operations.

The first patch registers manufacturer OTP operations with the raw NAND
core, which invokes them under the normal locks. The second uses those
locks around BBT recovery marker writes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v3:
- Run raw NAND OTP callbacks under core-managed chip/controller locking
  and resume handling; keep target selection in the device-specific
  callbacks.
- Keep helper visibility changes with the BBT recovery patch that uses
  them.
- Link to v2: https://patch.msgid.link/20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com

Changes in v2:
- Rebase on nand/next after the BBT logging change.
- Apply the Macronix locking change on top of the posted OTP error
  propagation fix; both touch the OTP cleanup path.
- Link to v1: https://patch.msgid.link/20261108-submit-rawnand-operation-locking-v1-v1-0-565010fc5f8b@gmail.com

---
James Hilliard (2):
      mtd: rawnand: serialize OTP operations in the core
      mtd: rawnand: serialize bad-block marker writes during BBT recovery

 drivers/mtd/nand/raw/internals.h     |   2 +
 drivers/mtd/nand/raw/nand_base.c     | 110 ++++++++++++++++++++++++++++++++++-
 drivers/mtd/nand/raw/nand_bbt.c      |   2 +
 drivers/mtd/nand/raw/nand_macronix.c |  32 +++++-----
 include/linux/mtd/rawnand.h          |  24 ++++++++
 5 files changed, 151 insertions(+), 19 deletions(-)
---
base-commit: ec1e844b9486302a488abc03ea918db60709766e
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
change-id: 20261108-submit-rawnand-operation-locking-v1-1a0b8fe786d4
prerequisite-message-id: <20261108-submit-macronix-otp-errors-v1-v1-1-8f64a2ad5a10@gmail.com>
prerequisite-patch-id: a542c9cd698d2d4c090932b8d74dc6f520a71166

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

