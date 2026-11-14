Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615266;
	b=Ggn5euPPujwNhyqX/7asXEDdwyod3Mvqj9UXqCYd1sDdiMCuXRlFf2x51+UKSt/tVQfO
	 bCwQkLhnqQuhAkWJSklmaj9kqOaRoapHa8kUEFXUAv2qoKLG5cEihfg1r36ODbpOzjdg8
	 YBRHCwLj54rYgaPmIBkI4hpZVOJNiGdSGbsC1VTDvs8KTjIBKRUh5IPSkBWLX8fZ0lbFr
	 r25krd4KPgkZwfcon2EybQngiiHmhBxdEeI3v8W7NTVDCKHV2qLzhZBe1UN5r5N8d/M5K
	 J5pu6IsNLdQF9057Z+dWw8IsfRDQ/xgjssmtN2YOpqQO36uIVTdJ1owvI09zJ49Ja4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615266;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=jw5lEpYCv/obOp69+BfkL2KjLFUrThiGP2VsyKzWfWw=;
	b=BuvzR8exDgkt0ZkJEyA1kwl/SA7RUbFnoJvZQr8TK4aM9axGG6jB0fY96cwpxVa8DZV4
	 8I3iMIYpmEeUXfP+g6CvapwG61vf/gDAdpx1VKva3UmSTsDVjnHzTp8xXJWzobZA1Zjh3
	 ivDBFEZ/rGuDKenUpD9oHVBAkb1ZR7zfpu4zAB8t/o35jh1VJzy9ySkioXq4xdRAUMkEn
	 lTABkeL0+LXpnOKO0bCBZ+CFEXA0G3Y0JXQ5UDHDd4GbZNqIj+vUHdMt2BhuBN3jTGeYU
	 MDoSqIB/LRM63H5JzKurk0TCiOOpHo7BZRmkADtMoAkTNZdCG9tfHaQSh5D7F6ObDqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlF5vUvC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B497606A885;
	Sat, 14 Nov 2026 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlF5vUvC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615266;
	b=M0ZUIjUx7QXe+8QSfuzkpgH88brU9O4Ffgo3Amj0FcJhqYKX5noiHnR5Y1G4PfyRNq3o
	 kkZNaTjASUpv0qXsYa/ziTmvISpNWATvQA5l67YXpw9TkPJe+Z0wph92gXMC/RrB0vEvv
	 Z6feRmLrR6D1jv9icjgu/Bj43ExgLhl4yL7Je3zRQvwJixxGmK2bTuS0CIjUc4eIJjXU+
	 3pwRLdaO8uTXWXcs40afUx3FskAA58Ey3lhns0Rjrjl6E4ALA7i8Y8sCpUS9j3CDZGWu8
	 PXJDK1UW4/uShczlZzgXhL0xciVCeqDM3yc8z80p3XG1twTwiw/SzelLU6BI67TOGfw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615266;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=jw5lEpYCv/obOp69+BfkL2KjLFUrThiGP2VsyKzWfWw=;
	b=d20XonEEPyHiAPFRwjWqTZ1e3cBkDPaO+HZR8P3BnMvxaC7reeVSGHayq8Q671ClET9G
	 1bpukjRRItA/iO3wBZGA4C+uTlThcdMbk/doE8Wlsf8MrBV9gYTx9FY0ZIKcbY8RddvzF
	 w66xbECrU036aA/8SISRvsVavODv1QIVqcV2vYQmJ/LAlWU/l+adwKcnSV7UIHOvQonKv
	 Nl4dKjO8sleRhl3OKvoA5j8wA65l+4ZGdo0Cdbv+3dKm89KYTWCJHh6EisqguE3icuiGB
	 mhiCREtFdO89cFBSnf6hc5+/EhPBDFv9EWvXOxJW7CJF6FtRCvUOSRwZpKIF0ytHFuw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AA59E1F000D4;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615266;
	bh=jw5lEpYCv/obOp69+BfkL2KjLFUrThiGP2VsyKzWfWw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KlF5vUvCVEhLdI3khUHLznEfLf06451Frtv9VXaAU6WhbUuX6LL56FnzjllIw1EbT
	 +Hj9Q3ZAN9omIJLnrMCwxQQx0XfInu+ArghQeYDYQouSEtXza8efo5Hi8GS9DXLHC8
	 ytSh406EWocezJiu7E/xEJ0VYoRPKG2fcMIMsthU3nrNPXNmWQUp/frfp7rreg++aX
	 yxpPIJ++8s6AOUO5ATllScU0gZd2/HsFUVbNo+qLjKT26U9iUtX/PtkiJ09ZP3tf2U
	 Zcy65ESxNmMyqSTP3RQuoTZW+N1txqu2uPcPue/qyf1NQIM4ioYLD1Pj24kHSovC3i
	 EkdFV1QJKQ8IQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C2E749BAF;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/3] iommu/vsi: Fix the domain locking and a probe leak
Date: Sat, 14 Nov 2026 00:14:24 +0000
Message-Id: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2PS24DIRBErzJiHSRoYABfJfKChiImkn/DjBXJ8
 t2D7SjLUterp76LjqWhi910FwturbfzaQT9MYl8SKcvyFZGFqRo1lob2c7H4yZvvcnaftBlyTQ
 H0hRdLmJQlwWvw4A+9+/cN/5GXp8zf40F122o1ndNXNKaD0O0mwJ7nqFTTJxtjAHVGXjOMVLxJ
 nLW7EyO9rXzT5FPQDBOkWPNs43KJ4KChSUY1KpJIcz8pDh1yDyeaOsAc7UM59kojTIUqQaCV7l
 WV2qJc4i2hAKxfzx+AVT7cNArAQAA
X-Change-ID: 20261113-iommu-vsi-fixes-dc26821295cd
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615264; l=1685;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=QCr9/CiYUT/P+xObKaTblByhOKT6mvGWS3DUxF3ulxs=;
 b=BWssBIrKSvt+ne8BkBa9CvR6q8qQ7hutK/7Mw612AOm7zCNzvuY4g2Fia6psAK8sX4X2QCMZP
 72f005echsCDxTL31pkjDdmPD1AeGzR925Xkt6N1n1ETej08PFk2k3t
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Patch 1 stops identity attach and resume from locking memory past the
static identity domain. Patch 2 takes the old domain's lock to unlink
the IOMMU from its list. Patch 3 fixes a clock prepare leak in probe.
Patches 1 and 2 were found by Sashiko on my vsi-iommu-pm-ref v1 [1] and
hantro-robust v1.

Based on [1]. No conflict with vsi-iommu-disable v1 [2].

Tested on an Orange Pi 5 (RK3588S) with a v7.3-based kernel: the AV1
decoder's IOMMU group switched to identity and back to DMA, then an AV1
decode; 5 unbind/bind cycles of the decoder; VP8 and AV1 fluster with no
new failures; no splats. Patch 2's race and patch 3's error path were
not reproduced.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/r/20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com
[2] https://lore.kernel.org/r/20261113-vsi-iommu-disable-v1-1-94f7f44540b3@gmail.com

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (3):
      iommu/vsi: Don't use the identity domain as a paging domain
      iommu/vsi: Unlink the IOMMU from its old domain under that domain's lock
      iommu/vsi: Unprepare the clocks when getting the IRQ fails

 drivers/iommu/vsi-iommu.c | 54 ++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 22 deletions(-)
---
base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
change-id: 20261113-iommu-vsi-fixes-dc26821295cd
prerequisite-patch-id: 8b7b6e1a9abc4998ef53e7bc992d739bc1b53c94
prerequisite-patch-id: 27aee835025b1b64907a2e0e4e42e3eff120e86b

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


