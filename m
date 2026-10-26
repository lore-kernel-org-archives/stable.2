Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003935;
	b=lZqqPyU6Ftq54T6e1kRzjk24PoAO1A86ij46IVrUsMjb/fEPWjBye/3pEJgeldh4A6OA
	 GbDMpgFDjRLsyZeQjzJ98/xrjszzZ/iyhKB0r4woXrCQPzHGiNTGIhqC3rn+hjzYIZ23k
	 NUkZLa+D/yBk4TzPZ9zFnYn6FOds0BUCNHf6tK9vyACsHONjgRajQrH2SsL7BEyou01CU
	 yrsIb3dm55xfTRLl0nh3ETIlIbXvUSyy8M1XKLGbAndOSfSl1Iv0Qw0ACZCDJ5lpBJxyt
	 P+jmuDA9F2esqWPyICs/5bMwov3a74gdyhtU+cKphmYgqZjQfFWPjFjY/rJpV1XikTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+MsbjmZXyQIGIrMSZDLm0szNexGnhEGpcLnezb5K85A=;
	b=tFDCJF1q3wChs+l+lkGwPjWMQZzn1NumjPiDMRYAKb1kVup7SNJ9KmaR2tB+9zaq0wdL
	 bQUthbA3bzQFJaG9COg7bvqkYFkKMFD0rbACCs/lIjmCNyjx9A1EMCQy2ZsgKqC9YFcHT
	 DqZptDFLo4ZXspRLzuZQjV4iNz+2GxtremJzGadNWTrO5mG+mdg+TrdYmvVwqPxLrkWma
	 xJt+Z5FHxuw6Nf95pQ1NO7R3hB/iXColf2NDAluZIv4I02MvfbJLiUaTl6lIU6o9XjecB
	 AmljAE5h7DqG5O5lW8aRORIeQZDYtmvGjEufe9PXgCk/MDwdSBjfmzIzBuChljV/tBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gBpdk1S6;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A8606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 437A8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gBpdk1S6
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c247f6687dcso398532466b.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003934; x=1793608734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MsbjmZXyQIGIrMSZDLm0szNexGnhEGpcLnezb5K85A=;
        b=gBpdk1S6DRVeuljO+Stc1a2ikSJw13AEqo9tYqvDT/LkyFs1i+CQJsKk2w2Cc75aex
         3TLHt+aC3mlD5r0S4UP+7jv6CsSo8AVrAjFS4XZnG2d9lJJZF1qw5Cax2PnLcGP+TBys
         Om3WkPcl4r5gadbR23eeWSivdSHpB3wQooIk3EFWqjWX8O6L+kXvW5csbYqTxkSf/qHn
         PaCESo6On67Gjeklhp+jOMq5S2ppGo11ZhUA7hSDDp3IcO6njPNDPxlyEG8bz3tVvT5R
         kvoexajBLBOLqif5O9P+vFrCqst9g6dLzIjaAaBhGDHcI3Bv0YSgGhzujnspGQNQaAbx
         Ms9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003934; x=1793608734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MsbjmZXyQIGIrMSZDLm0szNexGnhEGpcLnezb5K85A=;
        b=RQstBng2i1/iHfZ5k4eAKY0JHIv3j7AEtImc8QKFaAjUfxxtqZKurvld1Z9kE4Vb6E
         gLDVHX/25osWc73E9mP7m7lw6/OLcUuo18/VL3WbeC0KaMUOpQkD923QV6gQ9DQNh9N6
         XkC6Yxaz/Xoa5ZFqKQHur7V5bboayUiR9diKNyH443Q2Ei/7z4QE4W+txJ7wPY10hVz7
         rIqUOBqW1mm+8iN8lOCcxxz4pXHliiQLTdGdBGbaNchc3k9zQXaXANsA4BXsVOVlJcCE
         z5RQeu/eQkbHr70V/2qRI0mgQF6c7y5kBGecsOscLzdjMlx29IjdYTWCxyEM+KjmaHa6
         5RMw==
X-Forwarded-Encrypted: i=1; AKwUvBxEJx+Zp340JKxUUz1rd5wPoQ08Xc3urBL4XNvRnP8ZHCaoNtj9+Uey5ZuPixifO1ACTnNObnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJC0IVR3pE5bz7EA3D01BE7cfa2uyFCRC8d0hXkIAP2vm8qBDXh
	sZ6XE4z5E4+lc5mtnCNra1LpzU5rV5hg9iji0O05si9WypsYMasi2Uc4
X-Gm-Gg: AYBFou0PNTBCxjHQEETnI9C5dtWyxJ0Q5yuo9syovfYs3sXCLe4ByMVgGbGO7Ghlp/B
	ADzYaGHEWXHFOrsIXcK5pVpS12ZE4arIMfvKIRH+MWkGCLjXGdZ9EH/qLQr4rLcZbndGma4QSf9
	Aui2iFYCls4w1XrYeo5SWpcyQic2rnckex2W/o7lpkki2UrvLhY5Xj3STcJjn7aLmKlRj740f4I
	imo84mLn8o8qfLao3M5yYz1E2q9PM1FHvQUzpza0Lfb3TJZAv1yyc7b3PS28kjo6xG/kRIEQtx7
	3fYE7DjiZ8F3mr0PfW8M/DW+oCEM/GwRpLBq+DoWZKM0xgc9nlK0u+YwjkLB0et2MyIGCoXIH7/
	u+NO5Y7mu0JHBV72fSakKIjuHAb5GXUvauJLzSVuf9ztEfhKUKX+tm8/dcNc9ERbrFUrSWE7oEW
	DXrolQm6+dvSQc69aRrtpQqStYYOaHj+5HqA4tczJ/uwI1AhHOFfp9SEskp1kxNu0S2t0u53hNt
	0X1K78/ejThDJ6c6gAJ7H1/vsL8sErLcGPCVU4pfvOyT/IbulEdwKIJaqRcL5XxP9cVXUOmAiLe
	XPVNtnDruYHiyA30UhAUVQ==
X-Received: by 2002:a17:907:9611:b0:c46:2a05:b257 with SMTP id a640c23a62f3a-c46bdc0f3b4mr739291766b.23.1793003933589;
        Mon, 26 Oct 2026 01:38:53 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46c59c063csm249655166b.34.2026.10.26.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:38:53 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/1] sparc32: do not write back unchanged values in emulated atomics
Date: Mon, 26 Oct 2026 09:36:56 +0100
Message-ID: <20261026083837.1055953-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026083837.1055953-1-linmag7@gmail.com>
References: <20261026083837.1055953-1-linmag7@gmail.com>
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

A failed bit-lock acquisition can restore an unlinked hlist_bl head and
leave pathname lookup retrying a dead dentry indefinitely. The owner
updates the pointer bits with a plain store while holding the bit lock.
SPARC32's hashed atomic lock does not exclude that store: an unconditional
fetch-or can write back a stale pointer even when the lock bit was set.

Skip unchanged stores in the emulated atomic fetch operations and legacy
set/clear bit helpers. This covers current test_and_set_bit()-based locks
and older generic bit-lock implementations. Keep the hash lock and IRQ
exclusion on every path, preserving ordering, return values and
changed-value updates.

This fixes the bit-lock owner/waiter protocol, not arbitrary races between
plain stores and changed-value emulated atomic operations.

Fixes: 26333576fd0d ("bitops: introduce lock ops")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
Validation: forced-interleaving host regression; SMP/UP builds and QEMU
smoke boots. A native GDB 18.1 build also passed on dual-CPU HyperSPARC
as part of the combined integration; see the cover letter for scope.

 arch/sparc/lib/atomic32.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 8ae880ebf07a..30b4e0c12c07 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -28,15 +28,19 @@ static DEFINE_SPINLOCK(dummy);
 
 #endif /* SMP */
 
+/* Failed bit-lock acquisition must not overwrite an owner's plain store. */
 #define ATOMIC_FETCH_OP(op, c_op)					\
 int arch_atomic_fetch_##op(int i, atomic_t *v)				\
 {									\
-	int ret;							\
+	int ret, new;							\
 	unsigned long flags;						\
 	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
 									\
-	ret = v->counter;						\
-	v->counter c_op i;						\
+	ret = READ_ONCE(v->counter);					\
+	new = ret;							\
+	new c_op i;							\
+	if (new != ret)							\
+		WRITE_ONCE(v->counter, new);				\
 									\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
@@ -125,8 +129,9 @@ unsigned long sp32___set_bit(unsigned long *addr, unsigned long mask)
 	unsigned long old, flags;
 
 	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
-	old = *addr;
-	*addr = old | mask;
+	old = READ_ONCE(*addr);
+	if (!(old & mask))
+		WRITE_ONCE(*addr, old | mask);
 	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
 
 	return old & mask;
@@ -138,8 +143,9 @@ unsigned long sp32___clear_bit(unsigned long *addr, unsigned long mask)
 	unsigned long old, flags;
 
 	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
-	old = *addr;
-	*addr = old & ~mask;
+	old = READ_ONCE(*addr);
+	if (old & mask)
+		WRITE_ONCE(*addr, old & ~mask);
 	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
 
 	return old & mask;
-- 
2.43.0

