Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238915;
	b=mRvErrtnxRdFXGHbhi7LUDSaF9KBg1cV/BP4E267hTUEAErq/ZBpCGRM4uyZYoSFa14W
	 vYhFYNTwyOp6I8fAuPLgUwY/94LZBZx65LVGVPUWzCipP6gTiz1VByY1si1Vc1QzZRhWk
	 l5dU+t7ONWr7blxzk4Ya72KYXNNiVLWGCWwRscG8EtcCYGwf4MnBdPXN5wNxE4xTRNfln
	 A4uam7Osr3p1WjLQtfyS7U+/Zquh2rJL8BHx0RWJV8Qu7IwUHm6ZFHXvU9snqMwR8FscS
	 IxWVEZp2QG00JlFgs40zNYtBnVwDgldRhPVMWmlUSIahX8xFLZGTZHKiGTbhFh3QDbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238915;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=iZ7RGkJZGB3OsYc4Mu3IJuBDaR5q/e7n/p8eX+iu+LM=;
	b=48uPsKYFV3NBojynk/IOXEMKgCDcxi+YbmRh2nDNq9QRsGK7ChDVWxGfWq35dXJgOgpT
	 gZE1/bgT3mBLcK40bcb6L1QqMcZHkMDvlxui/mQ/7Nd3I8U+qgtQwXru/4avGV6XR1vT9
	 IJIfSsy3UCQQqKhJ3BSSGzoOstRiQHzmDwR04MOssFRIjpUCbJafyjr+U4KC0aT2Pzqh1
	 7pi+kmP6ve5+P+tsVKsBFidjOiyicLfTpflzAWx223q61SiMAunT3fKMiO6Of+X64oZAb
	 MDMZXZ5T6I4cvx+XQzotDK4Iure4hB7HyNFNLkEHrjzgNw2cFZo1Oss/AIq43aX5YAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Cfo+IaTG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JctXTiZA;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7403606A32A;
	Mon,  9 Nov 2026 15:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7403606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Cfo+IaTG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JctXTiZA
Date: Mon, 09 Nov 2026 15:41:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794238913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZ7RGkJZGB3OsYc4Mu3IJuBDaR5q/e7n/p8eX+iu+LM=;
	b=Cfo+IaTGJ9Fe4AFNTG5Tw/JrDUJluhx5IwBvrnJkiQu8bLW+4TMuxV9+wl/AhOr3rgAo7n
	tSMH+GSR72CS6f2ZVl/7SNKStlZfvUzTHrdaK7eDKs5kzCb0B5pPX0YXRZCoNGQyplXZGC
	MHP91clHFwjbVYOaiO+WZuUb3+S+99EfWmWw5mjUe/TEZ8yABgR9rzTbq0dVhaIZFxDZsI
	F4xPVXzVBwBA1hMB5k/NM3kr4cri+YYWA0SQIDYCzimi9jfd1LRmDTrvobSOW+XVCB71VO
	ifqzgA15xx5QgF/8VntQ7noh9kT+JH27be4/oj9WkTxhr/Ko+972UD0hwplimQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794238913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZ7RGkJZGB3OsYc4Mu3IJuBDaR5q/e7n/p8eX+iu+LM=;
	b=JctXTiZA1CoUYeizbRYN43hNj4INXhZ8EPaheUxRI/zpJOW5PiyhwKOHvBwxn3OuTjGL88
	4CaPNHjUFiDaSzDw==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] vdso: Add VDSO_UNALIGNED_PACKED config option
Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>,
 Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261020163210.742728-1-irogers@google.com>
References: <20261020163210.742728-1-irogers@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179423891136.2093942.13129678709622655290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     2727aca4439ee4b9085141a3babadc8de580397f
Gitweb:        https://git.kernel.org/tip/2727aca4439ee4b9085141a3babadc8de58=
0397f
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 20 Oct 2026 09:32:09 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 16:34:51 +01:00

vdso: Add VDSO_UNALIGNED_PACKED config option

Commit a339671db64b ("vdso: Switch get/put_unaligned() from packed struct
to memcpy()") switched __get_unaligned_t() and __put_unaligned_t() from
using a __packed struct to __builtin_memcpy() to avoid strict aliasing
undefined behavior.

On targets without efficient unaligned memory accesses (such as ARMv5),
GCC may not inline __builtin_memcpy() into byte shifts and instead emit
stack spills or much slower out-of-line memcpy() calls. Add
CONFIG_VDSO_UNALIGNED_PACKED, defaulting to
!HAVE_EFFICIENT_UNALIGNED_ACCESS, to use the __packed struct
implementation on strict-alignment targets while keeping
__builtin_memcpy() elsewhere and in tools/.

Fixes: a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to =
memcpy()")
Reported-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020163210.742728-1-irogers@google.com
Closes: https://lore.kernel.org/lkml/47f8c30b-e326-4ff0-a2bc-5683209a9e2d@pen=
gutronix.de/
---
 include/vdso/unaligned.h | 16 ++++++++++++++++
 lib/vdso/Kconfig         | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index 9076483..726fd15 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -4,6 +4,20 @@
=20
 #include <linux/compiler_types.h>
=20
+#ifdef CONFIG_VDSO_UNALIGNED_PACKED
+
+#define __get_unaligned_t(type, ptr) ({							\
+	const struct { type x; } __packed * __get_pptr =3D (typeof(__get_pptr))(ptr=
);	\
+	__get_pptr->x;									\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {						\
+	struct { type x; } __packed * __put_pptr =3D (typeof(__put_pptr))(ptr);		\
+	__put_pptr->x =3D (val);								\
+} while (0)
+
+#else /* !CONFIG_VDSO_UNALIGNED_PACKED */
+
 /**
  * __get_unaligned_t - read an unaligned value from memory.
  * @type:	the type to load from the pointer.
@@ -41,4 +55,6 @@
 			 sizeof(__put_unaligned_val));			\
 } while (0)
=20
+#endif /* CONFIG_VDSO_UNALIGNED_PACKED */
+
 #endif /* __VDSO_UNALIGNED_H */
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 597f5f0..2436c20 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -23,3 +23,13 @@ config VDSO_GETRANDOM
 	select VDSO_DATASTORE
 	help
 	  Selected by architectures that support vDSO getrandom().
+
+config VDSO_UNALIGNED_PACKED
+	bool
+	default !HAVE_EFFICIENT_UNALIGNED_ACCESS
+	help
+	  Use packed structs rather than memcpy() in include/vdso/unaligned.h
+	  for unaligned memory accesses. Enabled by default when the
+	  architecture does not have efficient unaligned accesses, as GCC may
+	  emit stack spills or out-of-line memcpy() calls instead of inlining
+	  byte shifts.
