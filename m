Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917F2FF15B
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844589; cv=none; b=Sum9d/4P8udWvNcPNPu4aZqhiCrTjXA7k8cVIneEOYg7gGMNyf152vXboW6DNqfCeX7eDE9jmZj5Adw6v8w5/YmpLCeOaz8gEqsVyVmde1HCGd8E40/NlyBCc2ZoWpjs5ctaXf17s7mfWSIxNPlW8MkRenaoRCGOfGwIXwyg+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844589; c=relaxed/simple;
	bh=XOhN/dkzUFC8iyTkzVJokobmMiKOQ750un/kaUB1WQU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gUHr+V9QyEsuRv+VCtqkhUL5WsvPjrSbKDUXNmxo9c7OP6Y8IVAsuoauy3actRal90zZGtvJL5DFKE3DOi3FYC26pe+cR/vNGzx0f7JB7pjiiMsaNxIHSZkvkGAkmlXiOni0v2GIK0qMtUZ3iugR+vdfvlVcGwgliXx4aSOwskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QfWET3Ne; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QfWET3Ne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781844577; x=1782103777;
	bh=XOhN/dkzUFC8iyTkzVJokobmMiKOQ750un/kaUB1WQU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QfWET3Ne+FbNzsYhR1vFiALJ0tw9SydlAb18cCAeD+jbWKKpth3Z7XTeJkvceECtR
	 uF5rl/yF0eBBAWsp0pG+9uYSyiR48SH7Tu/ahoPs0CezKRgIi0szxvGaunqN/lo0jD
	 PC/CfOYGhCMZmuTv/5sx8Jy5SaXQ14GzjTQYA8oCpoTOAputsVqaGPgAhVYMHWldTS
	 TZKSoQmK7QwfW6i2iSz8xZz1LkSyX1rzG3iBfXR5LrCvpDeJcgkROD6mqSyEkk/FQR
	 yOlcdI+fYYeybtlr5GZboRVwMa16u4sFXn4//Or0ilSpVS/gEMHZne5NJLnNTku1Gn
	 e3MztLLHzr+Tw==
Date: Fri, 19 Jun 2026 04:49:32 +0000
To: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [BUG] io_uring: possible CQE32 overflow flush inconsistency in __io_cqring_overflow_flush()
Message-ID: <wK6w40HQFWE32Zzw_hyI9ctCQpBgXgOxWsfBFc2ptY-VZFPHBE5_wzDIu4AT-8ZX2wdr-C3-T6g3mUblIqOMqjCvBhTyMRg0BvOCwmh7E-E=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: e8a1d8f424541267f1d28a035f43c643d920d2c5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

I believe there is a bug in __io_cqring_overflow_flush() in io_uring/io_uri=
ng.c
where `is_cqe32` and `cqe_size` are left in an inconsistent state when
IORING_SETUP_CQE32 is set, potentially leading to an out-of-bounds write in=
to
the CQ ring.

AFFECTED FILE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
io_uring/io_uring.c
Function: __io_cqring_overflow_flush()

KERNEL VERSION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Observed in current upstream (v6.8+). Please confirm against your tree.


Found File
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://github.com/torvalds/linux/blob/master/io_uring/io_uring.c



DESCRIPTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Inside the flush loop, `cqe_size` and `is_cqe32` are both initialized and t=
hen
conditionally updated:

=C2=A0 =C2=A0 size_t cqe_size =3D sizeof(struct io_uring_cqe); /* 16 bytes =
/
=C2=A0 =C2=A0 bool is_cqe32 =3D false;

=C2=A0 =C2=A0 / Block A */
=C2=A0 =C2=A0 if (ocqe->cqe.flags & IORING_CQE_F_32 ||

ctx->flags & IORING_SETUP_CQE32) {

is_cqe32 =3D true;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cqe_size <<=3D 1; /* cqe_size =3D 32 bytes /
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 / Block B */
=C2=A0 =C2=A0 if (ctx->flags & IORING_SETUP_CQE32)

is_cqe32 =3D false; /* only is_cqe32 reset, cqe_size NOT reset */

=C2=A0 =C2=A0 if (!dying) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!io_get_cqe_overflow(ctx, &cqe, true, is_cq=
e32))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(cqe, &ocqe->cqe, cqe_size);

}

When IORING_SETUP_CQE32 is set, Block A correctly doubles cqe_size to 32 an=
d
sets is_cqe32 =3D true. Block B then resets is_cqe32 back to false, but lea=
ves
cqe_size at 32.

This means:
=C2=A0 - io_get_cqe_overflow() is called with is_cqe32 =3D false
=C2=A0 =C2=A0 =E2=86=92 it returns a pointer to a 16-byte CQE slot in the r=
ing
=C2=A0 - memcpy() then copies cqe_size =3D 32 bytes into that 16-byte slot
=C2=A0 =C2=A0 =E2=86=92 16 bytes past the end of the allocated CQE slot are=
 overwritten

The destination `cqe` points directly into the shared CQ ring memory
(ctx->rings->cqes[]), so the excess bytes corrupt the adjacent CQE entry.

If the corrupted slot is the last one in the ring, the overflow writes past
the array and corrupts other fields in struct io_rings (e.g., sq_flags, cq_=
flags).

IMPACT
=3D=3D=3D=3D=3D=3D
On a ring configured with IORING_SETUP_CQE32, flushing the overflow list
causes silent corruption of adjacent CQE entries (or adjacent ring metadata=
).
This can manifest as:

=C2=A0 - Userspace receiving garbled CQE data (wrong user_data, res, flags)
=C2=A0 - Link chains or multishot requests making decisions based on corrup=
t
=C2=A0 =C2=A0 completions
=C2=A0 - Unpredictable kernel behavior if ring metadata is overwritten
=C2=A0 - Potential data integrity issues in applications relying on io_urin=
g with CQE32

STEPS TO REPRODUCE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Create an io_uring instance with IORING_SETUP_CQE32.
2. Submit enough requests to fill the CQ ring and trigger overflow
=C2=A0 =C2=A0(i.e., force entries onto ctx->cq_overflow_list).

3. Call io_uring_enter() or close the ring to trigger
=C2=A0 =C2=A0__io_cqring_overflow_flush().
4. Observe that the CQE following the flushed entry (or ring metadata) is
=C2=A0 =C2=A0silently overwritten. This can be verified by reading the CQ r=
ing from
=C2=A0 =C2=A0userspace.

SUSPECTED ROOT CAUSE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Block B appears to have been added to handle IORING_SETUP_CQE_MIXED, where =
the
ctx-level CQE32 flag should not be passed down to io_get_cqe_overflow() (si=
nce
in mixed mode the slot size is determined per-entry by the flag, not global=
ly).
However, Block B resets only is_cqe32 and not cqe_size, creating the
inconsistency.

PROPOSED FIX
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
If Block B is intentional (i.e. io_get_cqe_overflow already handles CQE32 s=
lot
sizing internally when IORING_SETUP_CQE32 is set), then cqe_size must also =
be
reset:

=C2=A0 =C2=A0 if (ctx->flags & IORING_SETUP_CQE32) {

is_cqe32 =3D false;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cqe_size =3D sizeof(struct io_uring_cqe); /* un=
do Block A */
=C2=A0 =C2=A0 }

Alternatively, if Block B is dead/incorrect code, it should be removed enti=
rely
and io_get_cqe_overflow() called with is_cqe32 =3D true when appropriate.

The correct fix depends on the intended semantics of is_cqe32 vs ctx flag
inside io_get_cqe_overflow(), which the maintainer is best placed to confir=
m.

RELEVANT CODE (verbatim)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/io_uring/io_uring.c (v6.8)
=C2=A0 =C2=A0 __io_cqring_overflow_flush(), lines ~541-552:

=C2=A0 =C2=A0 if (ocqe->cqe.flags & IORING_CQE_F_32 ||

ctx->flags & IORING_SETUP_CQE32) {

is_cqe32 =3D true;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cqe_size <<=3D 1;
=C2=A0 =C2=A0 }
=C2=A0 =C2=A0 if (ctx->flags & IORING_SETUP_CQE32)

is_cqe32 =3D false; /* BUG: cqe_size not restored /

=C2=A0 =C2=A0 if (!dying) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!io_get_cqe_overflow(ctx, &cqe, true, is_cq=
e32))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(cqe, &ocqe->cqe, cqe_size); / OOB if slo=
t < cqe_size */

}

Thanks for looking into this.

Best Regards
Eneshan Erdo=C4=9Fan Karaca.
