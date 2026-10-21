Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594219;
	b=j9ybYGcAW/9NIvA7WZ4XOOAK6CTsYPQgmsqFR51edWVSDUWVsvFNS9oagOn6hSuRIyLh
	 xc4gZK+KrgiyP6HUaNyzJjnVvTahATVfoCqYnkrHnml1wPeFOJD68jjxPsHMZ9aRBEvPX
	 AyCoptaTr4yrU5JC286ly+vtU1vNwzLeCjgIa2bJMj4ueKmHA8Yxm69wZ2OGiKQQ4pCQN
	 Ax9wDKxXSVc3kVSotV/jKa9IUlt5oWcRl3xhGSv+jm7WahitC+xG9V+sO/DRjeWoyW6iT
	 jdcsuXhudEh/org6h5tZ1hdHXyeJjIaz7KKJYeqi7zlPMOHB9jNN+L3+hH6K663O69Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594219;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PhfNxUJiIzq+fdR0lvD4Fv6kgRiMk8qlf7U4xT57Q4E=;
	b=SQCC+qDcxtooOev5mPyRdiCu6CdSVEojNR7K/lmlG8m2jvDMHaQkOSwUcaEJOWwBgInS
	 F/sYFflFs3Cab6l6udXltjD8vjDLo/vf9Hdnfg4xhV09Ni307S1+hvtxENb12rSz0IoPR
	 tAEx9J1EUt3XUSfRtUGwvVDg2IHHL8iM2FG2gPLpNsr2QQoz9p/N4GYuGm+8MLlzt6IxS
	 J/vv5zobRMvJREm9Uw1/qhzxCOTGAoUn7UYcECzSz0r38BFr365WMVSY+ZVFI9zleKcUx
	 bXsNq8DYdjruEt5EEY8ElmpSh0ujIyd7RLCkvUdVzra9VCt2QIlIscsikYxRbJ9ixbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="o/rT5Xl7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7F606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=o/rT5Xl7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668411F000C1;
	Wed, 21 Oct 2026 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594218;
	bh=PhfNxUJiIzq+fdR0lvD4Fv6kgRiMk8qlf7U4xT57Q4E=;
	h=Subject:To:Cc:From:Date;
	b=o/rT5Xl7ARXsRf9bmicg0LQ331d08FnIdetmcooXcRnC6DqmXyMYkyEGHBvQZzMv8
	 +aY8yWGuVTkLgKOGDoeXMTr8xvd0EEUgAE5F9NhV3C9CrTGrABkC2r1iJ8gLudC9Kf
	 XlkhwLYnP5QMbADargvGoQWzt5pWKv+L9d2rjvRM=
Subject: FAILED: patch "[PATCH] lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON" failed to apply to 5.10-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,Jason@zx2c4.com,ebiggers@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:40:40 +0200
Message-ID: <2026102140-define-freeing-ccc5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 24f07e8c07a0c0dd275331cbb41c79a78741eef9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102140-define-freeing-ccc5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24f07e8c07a0c0dd275331cbb41c79a78741eef9 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Fri, 9 Oct 2026 14:53:53 +0200
Subject: [PATCH] lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON
 state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When poly1305_blocks_neon() resumes from a base 2^26 accumulator and the
next update contains an odd number of full 16-byte blocks, it processes
one leading block through poly1305_mult() so that the remaining NEON
work has an even block count.  That requires converting the accumulator
to the base 2^64 form used by poly1305_mult().  The final ADC of that
conversion stores the carry into d2, but the following accumulation and
poly1305_mult() use h2.  If the conversion carries across bit 128, the
carry is dropped and the emitted tag is wrong.

This was introduced by Cryptogams commit 03dc4adf91c8
("arm/poly1305-armv*.pl: optimize branches."), which removed the
reduction that consumed d2 shortly before Linux imported the code.
OpenSSL's copy did not take that change.

The carry is possible because the NEON code stores the accumulator [h0,
h1, h2, h3, h4] in a lazily reduced, redundant base 2^26 form: its final
carry chain leaves h0, h2, h3 < 2^26, but h1 and h4 may slightly exceed
2^26 - 1.  For example, the reachable state

  h0 = 4
  h1 = 2^26
  h2 = 2^26 - 1
  h3 = 2^26 - 1
  h4 = 2^24 - 1

represents 4 + 2^26*2^26 + (2^26-1)*2^52 + (2^26-1)*2^78 +
(2^24-1)*2^104 = 2^128 + 4, despite the bit representing the 2^128 term
(bit 24 of h4) not being set; the extra comes from the h1 limb being
above the normal base 2^26 range.  When this value is converted into the
non-redundant base 2^64 form, a carry into the new 2^128 bit (in bit 0
of h2) is necessary to preserve the value.

Given the above bounds, a carry into bit 128 happens exactly when
h1 >= 2^26, h2 = h3 = 2^26 - 1, and h4 mod 2^24 = 2^24 - 1.

Store the carry into h2, matching the other base 2^26 to base 2^64
conversions in poly1305_blocks() and poly1305_emit().

This bug causes an incorrect tag to be emitted.  However, this is
unlikely to happen in practice where Poly1305 is used with a random key,
since the random key tends to distribute the accumulator values
throughout their valid range.  There isn't an obvious way for an
attacker without knowledge of the r_key to cause [h0, h1, h2, h3, h4] to
land on the precise values where this bug occurs.

[EB: Rewrote the commit message to more clearly describe the bug and
 its impact, and simplified explanation about why there's a carry bit.]

Fixes: f569ca164751 ("crypto: arm64/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Link: https://patch.msgid.link/20261009125354.315476-2-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/arm64/poly1305-armv8.pl b/lib/crypto/arm64/poly1305-armv8.pl
index f1930c6b55ce..234398ff6b60 100644
--- a/lib/crypto/arm64/poly1305-armv8.pl
+++ b/lib/crypto/arm64/poly1305-armv8.pl
@@ -375,7 +375,7 @@ poly1305_blocks_neon:
 	adc	$h1,$h1,xzr
 	lsr	$h2,x14,#24
 	adds	$h1,$h1,x14,lsl#40
-	adc	$d2,$h2,xzr		// can be partially reduced...
+	adc	$h2,$h2,xzr		// preserve carry into top limb
 
 	ldp	$d0,$d1,[$inp],#16	// load input
 	sub	$len,$len,#16

