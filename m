Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177742;
	b=DZDKc7Tdpn69ckEtPzXV41HCH23IQeGgWDl+wP2T8Rcm9kcKtZewSpXuSEyreftnIx6y
	 dfL0QCqfIsgCqPRBZeT15/h0lKpypoj1fSarV0vQ0Xozm3o7+hOqrnFKeFSjEq46q04z4
	 y82T2SigUluK74lciGZ40d+5vzjzU3cJEEA9+hea4q2UGMvN92RdbEBkr2KJSGC4VL396
	 uJI/YKqXSQfH7efgnq7pfxieq5UYe1jhfNfaFh022YuEw5DrD8igE8urDXMfzn/EpH3Be
	 Chc7x3Cxq4HalLyTWeqMbnIWVy210ZMaktFKorVRD/oNSXqNRcNbhSsprtdp/gcLaqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=lbe9BNDMr49UztD1Swhygj7sG/vajGHKtETS4f+BRsc=;
	b=kRQ36RYjYgjwGMejHwWI39WtVN6ArLpoh0qZer7UtunkFxvvW2BNonLY89XMOayGCgsY
	 XcVhSDr/sRhOKe1tEQgi/ubGbePueMOx2OKfes5pxIAajDqu023KiI49ZLtPkuZWW/Qyt
	 qn+9yboO0UEeATZGZjsm8KXsG5xAter30G/dibdNWHdoCrSDPE5ThgoIroKnBKytDtNMf
	 NX1EPGdrQoZvgp6Wp83ZLLTcfahdVPEpZDxmrZF5z8poMeuYvwnU3xWPp+Em+ShaQNQBz
	 PVCcgIINC9ZzI/ujRLdfxkbnZ//JB8xLgGUMEoGEMfr1WwzZjm21FtW5YSKZ5wsAufA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xJT1q/n9";
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E145606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E145606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJT1q/n9
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b28d9537bcso210368b6e.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177741; x=1794782541; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lbe9BNDMr49UztD1Swhygj7sG/vajGHKtETS4f+BRsc=;
        b=xJT1q/n9GOguRU28bqvGuRagX2zSp26ZTA51clxFlNZK2ZPQwAqkPBuNiiZer5WA+M
         Updkfe1W5t6vuT3k+dnzacyHK1cJ2LP5H+0/fUOdwpeRs4WGo2p8PpmjPVd7/3FIVPXN
         vPET8tp1/BrLYN7pEhlEXIbxKnmCGoCXQG2nxDmIGrDtTu33h3HXdqsDrtJQQlPkywBI
         vD2UVuW98P/NNZG1qoksgn7M+kLLXxVqQx8ZWKyTYkKewfa28vQxqmHKM7+xr+QKqEdd
         Xzn8S2kQiIonEejA8cKwCe3z4/bD0a9vu/m9jSsdJMd13aujGPBnLrRawAsP/y1pflNm
         h5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177741; x=1794782541;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lbe9BNDMr49UztD1Swhygj7sG/vajGHKtETS4f+BRsc=;
        b=LPY+5aH5vosWy1MMTPpCrtzDfIBPVCvjvRDldE3xd6l+wO03UYXEXfJ6jcB507pAEE
         urh8CiWn9VtJXQ/7zXavQSNVSlHX8g4Jkdu0t+Qq25jmB5Q5a90ZQw1sJtEkPhLoYk+m
         7sV5GzVRBZVKED37ifI+EinpupM/uWejfDPX+V3GqeWGlPhU7rcDyD9cXqR1moDt2n3c
         d6iQjX4751gwoWswwzG2/kOeULa9cQ4EAKxca1hi+fCzPp4oMOh9ZcWU+8xDIU13BKs0
         Fpc03qaZDR6IQgvxOf88PiO/+Wta9GXjbutyVA0s6E9/aZveBP4+Vh9J6WmAbLOFU5MQ
         QF7g==
X-Forwarded-Encrypted: i=1; AL+hErHa76/eaSYUXxgFhjuefRSrPuqpDvWEfePQ4X3dlLSYvaVM41O9pR/C0YLOODwbDHmVoE3WgMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NUXdPDYAg79LPY1rrJMT1v12/auNBSG8ualkU+EcwR1+8bpef
	uYkLT+3wSLQ4cbpzZNMlxXkJWyl4YQx2ypzQ/TczZ2qINNDTpOahnfjV
X-Gm-Gg: AYBFou3L4bDcojfZVlwZz/KkNtN10Iw/f0XXSj2rEMbQquNzCwm7V+T4IlDVirY8UWG
	FBfNgD9wqbqf0CNyp4jvq1xqFcupC6RDiAquTqiGaXZxgzsF25JnJxF/zfLWZXQi12oksOWg/r1
	21wNmUi856OjEIFNhiv2LKxcj+aiz2Q2kHc/qYZN4h9Qi/q4g2mCMIxn0bNFh12JMkbdy8YM1Zn
	j7NlXZoIhargjYuzTtlFqwXQJqEtCo+4X1Qj8yrlB5+hY47EIx99uORn7F3XPxs26v4BJJbHQJV
	4lUyKKVr7vm3quiVjMwQ+DHwiVIf5y5GomWEetnmUWcKeS/YRzgTf/X9Qv/Y5Fo12rgKLj4QvIn
	4FQCV2DBf/XQ1LQAxDumXPBiF7zv0ya+vScsG7Q/rJ54sH2dTMLCHeMeyovNgCGuffgooTup2oW
	3pJhNATcLEX9Coe0TG2hnn6TgpHMsA18HGPbfO5BK6/j/mI5rp5JFInDtdFwHxyv5GHkoNthcsj
	E4h2iNgzFkrEgiJXDr/N54h3fRnEQhQt0WWWygzvV4rpVFxxFIwIOb2V7JTaCzidBphWqXiFtgG
	+/9SS0Wi+6BGEDxiz6zX8ZXiRgQXhmgMf5XK5gJob18g+JBwdPvfZBdjUQenyjNOtgUmRukm2tK
	ng6s2gtSZXnvt4M7EuJcumlP0hSYcMH/bMZEmNlexIll/yNzJPtaBzoL4boh8oHMQ1RKqih0cxz
	KcyCT/bG1JOqTB5hJRHLVZzOXs4koTLOn4d8HNSvAxDrnMfmUNHOvbvQ==
X-Received: by 2002:a05:6808:50a1:b0:55b:f88d:6e84 with SMTP id 5614622812f47-567fd57f184mr2789475b6e.37.1794177741024;
        Sun, 08 Nov 2026 14:42:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54e39sm2859944b6e.15.2026.11.08.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:42:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/4] mtd: rawnand: qcom: unwind failed child
 initialization
Date: Sun, 08 Nov 2026 15:42:07 -0700
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OPQ7CMAxGr4IyY0haSikT90AMaeJSI5qAE6oi1
 LuTgNiRvDz/PH8vEZAJg9gvXoJxpEDeJSiWC2F67c4IZBOLQhZbpWQN4dEOFOFu/ABOOwump6u
 FG/sWAZk9BxgVdBUWtSy1qnUlkuzG2NH0eXQ8fTmZLmhitueNVgeElrUzfW4N0a6zf+1winneU
 4ien5+ko8qeX6jdv6FSSahk05VSN6g29nAeNF1X6Uyc5nl+AwsHQcIOAQAA
X-Change-ID: 20261107-submit-qcom-nand-child-probe-errors-v1-f5e2703a17a5
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

Keep the shared BAM transaction usable when resizing it fails, validate
the boot-partition layout before publishing a chip, and propagate child
probe failures after unregistering any previously published chips.

The first three patches fix layout validation, allocation failure and
controller-wide probe unwind. The fourth scans every chip before
publishing any MTD devices, so initialization cannot race with I/O
on an earlier chip using the shared controller state.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v2:
- Add a patch separating initialization of all chips from MTD
  registration, addressing the concurrent BAM replacement report.
- Track which scanned chips are registered for probe-error cleanup.
- Link to v1: https://patch.msgid.link/20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com

To: Manivannan Sadhasivam <mani@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Christian Marangi <ansuelsmth@gmail.com>
To: Sricharan R <quic_srichara@quicinc.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (4):
      mtd: rawnand: qcom: parse boot partitions before registering MTD
      mtd: rawnand: qcom: retain the BAM transaction if replacement fails
      mtd: rawnand: qcom: unwind registered chips on child probe failure
      mtd: rawnand: qcom: scan all chips before registering MTD devices

 drivers/mtd/nand/raw/qcom_nandc.c | 72 ++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 28 deletions(-)
---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-qcom-nand-child-probe-errors-v1-f5e2703a17a5

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

