Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423271;
	b=YE7+BjuX6VHqn9dn2jziVg6viC3HW0LukNY6ekdi3QYrmX4ajYYvhbmwG6uC2IuSWpmC
	 SsJyVtFqYeoDJSJK/qVj6vy1oRGHmSrmHrXAEjli6KeaRsSsnEDDYnkppsT0+bL+1z3vm
	 E6r5J93x/Zt1j5V0g6pmp9nOW/J56GmniiDDNHI7cGTcafKChGh5Lw3e7WNQA6YpzpqyX
	 V9QZRweUH4uOubgXQMwZthI/om3UHlJSrlO8sDRQLRUymAr0Jnmka25uwG7oaZX5yo39r
	 QWKQtXuGthmEvvvsKNCyJKSAzzbdeRGVp+EBWJrb18FWQoZm64iYaAvDmg0ACCUSHWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Hw1nQeOT0hpBs8JWZrvFPeFAdyEee3Nf0Mrysl2Y1g=;
	b=TBIiNuAIsXKO2hkgj+xpPL627Eqt2Cz5PxnhbTf3Ucoi6Uj4CDMA/L4cxoPnpdQZBppl
	 k1+uwJmGQmvbTP16YJTYcb8JyTg+30/D9oT6rGDC/bHvSSfTTY/VWiu01eww1iVJ0AlkR
	 8+9IIs0Tx/gIwvKHwdOz2CGVsMdiMCwuML+y24CYXmFnsFmSEBZ50ISoqoGkj05v74z0F
	 ljkLSwWgwcl4cq2uOpL8c1wfXHpUKr012fEniZmaUMJvN383TkjVMMYYnt/p9CGfxVhG7
	 NjCV95fT+jZjsRCKp2oEKqyrcAGvmC4UJf8B6QX7E92AVMY7hRX7cNKZIGdwZz0qlwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="RLHu+X/Z";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125B60A7E79
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9125B60A7E79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RLHu+X/Z
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e96502e447so16231105ad.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792423270; x=1793028070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Hw1nQeOT0hpBs8JWZrvFPeFAdyEee3Nf0Mrysl2Y1g=;
        b=RLHu+X/ZCgfkGNAcpJZzmVb+NpRYJOKO905A5pUHlK/KmK96DG3K0O6Ciu65WDhi0h
         0HIUnI9Yq6Q2BZmh1Upu9kkyS3/Ds/m6PLJSuHyroGhFOFnLfUsCRSMJBZYR0SFALkGw
         IrxfV1LMUCqXSkE3YhB16pw61uIKY3bRE9N/yF8OZAQA1hSdZy4py2sHkw9Fy+LLBGYr
         TRxcE1HO8MgQNFjQ+BqHKxe3Kn5ANB88EmfT09SEcrNpJEkN5d/I1rYF0OloKr7g/a2K
         QuXNq9jvX+AsCPhx5SBmjIFR0gwINIIo3eTob5Ff5ap/JFNWTqANrFwdPtT9AZ2o5caQ
         h5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423270; x=1793028070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Hw1nQeOT0hpBs8JWZrvFPeFAdyEee3Nf0Mrysl2Y1g=;
        b=AOikNz4RrouGcHMyqxjGjC1IzScAuF7nIYsmrFGbLVmJhBy/bazPaDtdO+FrSUDNtA
         VBwM7EJxMXoa6WVVyHskQtvMLGXUPOy/TyRQJAw/q7h5sFAaJ1hUnMBAJhUwlHjViE1o
         LwuLB5UxByn169XXVVOA2Uj+QleFsff8q4Fchpb4gdjR/1Y2GQOxIv0xRHzt46tVeU8r
         KqYs8NL+bhMkT8hQ97oSNGfbpwcmGG05FIOVFJO8XOFMuXzF+Bey29delcxZ+/TLtOIb
         dXrAXjpMdEwbdh+TdbaB1Ga8HHWp2OxEBfKub5GVCBBQwOg/2Lou0SvzWwTnbm8zal9p
         Iqww==
X-Forwarded-Encrypted: i=1; AKwUvBwR60nmFczXr+3mXyBcL/6AlUI5Btob9mvn2M8KTHN2KnUJvU6Uj00Eotdwveev/RBJFoNKqYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0j46xKqlU2rYTp7yZlQecZztOIPILqPjTRgxsPAc6aoavgHOz
	Q2PasoCxrjmkF/2R8Y00Il+/rs1jCfB75Bp6kY55Mh634+SX9/DDijScLdZ9L9Bt
X-Gm-Gg: AYBFou0VxPJBUO6OmzXje2VGlTrcUlUEEJjhz66S8JX5XA+ETJzXuLuzhBPeib5Sk6m
	g87BLVE5PL0NHBJwMRBg63GhjkR8tYJXbLliPveMbaPJYmd0g35qfXcl6UQua4CJvD6u8pxAAIY
	2GiKtrukDjv7I+3drh8QeXVjBfSZT5B2xh4yhOn/ljpAZWLyAmtf65bvGF8pUC/Ua6vbmxk3HlL
	kea4zq/B9Ed0FCNDNoSdi4teCCZWG/SWlPtWWNwIRJlMfvG24FXpAJS3882NqhDwkg/SzOh7o6x
	1/4cmcTgkKb8vLpzuhfJeCorsloaHjcyxT77SFkr1rDTEdU7QWbni/IUfJCatE9tut9dQt6qoKu
	1U08dV4+8SZiABvxeh5lPrta2pcomtKYmsLDUxwvmSDequVqAl0Wr44uaQupyIkOqOKJ3OquvOi
	4aOIAMaplxavt7Mz/dzF2/OKJ3mupaT3tAlvhumtwBZufR4DlNKBYsShsYcw15HwBtw+LxuMvjs
	xO06lR4NzqRcbuXEvw8adFjmlYKn2+rcwgqXntA
X-Received: by 2002:a17:902:f607:b0:2e9:69b1:1b9b with SMTP id d9443c01a7336-2e9a6846dd7mr72903765ad.8.1792423269844;
        Mon, 19 Oct 2026 08:21:09 -0700 (PDT)
Received: from localhost.localdomain ([122.43.72.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1501e269sm2798115ad.46.2026.10.19.08.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 08:21:09 -0700 (PDT)
From: Junyeong Lee <jylee5498@gmail.com>
To: io-uring@vger.kernel.org
Cc: axboe@kernel.dk,
	greg@kroah.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/waitid: prevent cancel reference wrap
Date: Tue, 20 Oct 2026 00:21:00 +0900
Message-ID: <20261019152100.63565-1-jylee5498@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_waitid packs the cancellation state into bit 31 of ->refs and
uses bits 30:0 as a 31-bit reference counter:

  #define IO_WAITID_CANCEL_FLAG BIT(31)
  #define IO_WAITID_REF_MASK    GENMASK(30, 0)

__io_waitid_cancel() marks a request canceled, then increments the low
bits of ->refs to claim completion ownership. When another path owns the
request, the increment remains even though cancellation returns false.
The request remains discoverable by cancellation, so repeated failed
attempts can wrap the 31-bit reference field to zero. A later cancellation
can claim ownership and complete the request a second time.

Use atomic_fetch_or() when setting the cancel flag and inspect the old flag
value. The first cancel attempt continues to the existing ownership
increment, preserving its wake and issuer handoff semantics. Later attempts
see the cancel flag and return without incrementing the reference field.

This makes repeated failed cancellation attempts idempotent while leaving
the first-cancel state transitions unchanged.

Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Junyeong Lee <jylee5498@gmail.com>
---
 io_uring/waitid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 2b756017423f..9ad8eadc5b8f 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -154,9 +154,12 @@ static bool __io_waitid_cancel(struct io_kiocb *req, bool copy_si)
 
 	/*
 	 * Mark us canceled regardless of ownership. This will prevent a
-	 * potential retry from a spurious wakeup.
+	 * potential retry from a spurious wakeup. Only the first cancel
+	 * attempt should take a reference for the ownership handoff.
 	 */
-	atomic_or(IO_WAITID_CANCEL_FLAG, &iw->refs);
+	if (atomic_fetch_or(IO_WAITID_CANCEL_FLAG, &iw->refs) &
+	    IO_WAITID_CANCEL_FLAG)
+		return false;
 
 	/* claim ownership */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
-- 
2.54.0 (Apple Git-157)

