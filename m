Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482353546F9;
	Fri, 19 Jun 2026 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856350; cv=none; b=dcwRb04KtDhPgUFjhqrqdFrM490hecyz1Plg78l4xDwk5cAlip5ObOdyTX1rM8Ic5o/BUpTZ7tDYvomE8MQI3O0Nk4zmxq41HODkmUcEojF4vNADazePiH10XrZeTQXs2cEPICrJs5lRk71vWrJOSJCd5rIobXGcE3BREJPOVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856350; c=relaxed/simple;
	bh=qc/Zmvdp9ZihxbRsNrCtnoq3BPwBD76YtEMceAgFFVw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MtDHK+G0/5UdaRy+gO+qgrYMjHV+m8RBt9/QiPeasvHe1jylW471tWW69dbgV/DgaY95G3Gp0pVPU8gG8j7BHe/rZ5S2A6FXVqFf3ehfNaJ+nCsKGPi1Yp+t/ZCnntWgZhPgOzT4V6lC1Y4NJ13mnaGolCSzmTLH+i0LPa8enlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kUkYHOEK; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kUkYHOEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781856335; x=1782115535;
	bh=qc/Zmvdp9ZihxbRsNrCtnoq3BPwBD76YtEMceAgFFVw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kUkYHOEKzNCzwK17i1f2d2dOxlkFVfxyDCeH9AzVmt2IPfPelOG9s8HUv61yLJVGn
	 X963f3/An4UG2HQ/dJEL9RbPFfldtBsPnwhWNlN71EipDBv/9aIIc2wWHXg9FqySnD
	 qjhLnN4kVLLmzh1F9HpACT1cU6yRcd2hq5yH2MIgQGA/KyCmqGUPcxBYg0DE8X1mBG
	 UwwN4uloMA9SVps5Bvmo67yGw2eOFPiREguT8A1McJ/SZsIum8HcW1Xy7EDyY73lMP
	 AJKUaek7BLzxWkX+PfgJDvaLMHjrKs4OfZWwPWTG6x4iyKzGVYqYAKKGBls/thvskD
	 WtqOUl8d+ihAg==
Date: Fri, 19 Jun 2026 08:05:32 +0000
To: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [BUG] io_uring: possible CQE32 overflow flush inconsistency in __io_cqring_overflow_flush()
Message-ID: <6oAi5ghNgkCrElyHzHJrE8l3g7Dg7Uc9PpeZmbGD93Xic5x5MI54B1pehHhjiGrb5VB0icQvFaemtH-Pvb8bJkivv6qxD_NZUEvwyFkk62k=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: 71b7ab01b41d409f4960291f8680256f59800d3a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 04:49:32AM +0000, Greg KH wrote:> Please turn this =
into a real patch that you have gregkh@linuxfoundation.org to verify it
> resolves the issue so you get full credit for the fix.

Hi Greg,

Apologies for the previous mail's format. The patch compiles cleanly
on arm64. My current environment does not support io_uring (ENOSYS)
so I was unable to run the liburing suite, but the fix itself is
straightforward.

From 522b70bdd3ac64c64dd21842cb5901e59a1fb058 Mon Sep 17 00:00:00 2001
From: Eneshan Erdogan Karaca <cyberblackk@proton.me>
Date: Fri, 19 Jun 2026 07:59:58 +0000
Subject: [PATCH] io_uring: fix cqe_size/is_cqe32 inconsistency in overflow
=C2=A0flush

When IORING_SETUP_CQE32 is set, Block A doubles cqe_size to handle
32-byte CQEs. Block B then resets is_cqe32 to false so that
io_get_cqe_overflow() uses its own ctx flag check internally, but
fails to reset cqe_size. This leaves cqe_size=3D32 while a 16-byte
slot is allocated, causing memcpy() to write beyond the allocated
CQE slot.

Fix this by also resetting cqe_size when is_cqe32 is cleared.

Signed-off-by: Eneshan Erdogan Karaca <cyberblackk@proton.me>
---
=C2=A0io_uring/io_uring.c | 4 +++-
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1ea2fca34a36..f9690291633a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -543,8 +543,10 @@ static void __io_cqring_overflow_flush(struct io_ring_=
ctx *ctx, bool dying)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 is_cqe32 =3D true;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 cqe_size <<=3D 1;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctx->flags & IORING_=
SETUP_CQE32)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctx->flags & IORING_=
SETUP_CQE32) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 is_cqe32 =3D false;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cqe_size =3D sizeof(struct io_uring_cqe);
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dying) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (!io_get_cqe_overflow(ctx, &cqe, true, is_cqe32))
--
2.34.1

Thanks,
Eneshan Erdogan Karaca
