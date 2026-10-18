Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817DD4C753A
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331377; cv=none; b=cE+T7pcFlY8razA/nSvHiN+DO/oFVg8wmN36jJJcfozobaeH74mFP5wu6v6PYAg4gbxY5aCFrkmXqxgKLUby6eTyguoX3efqQZmU1Qy1LzxrVpvbmRfG5DMQbhYVfJknByK87mP/KlgN3EGLrsuAXMq04v1k9XuRlrrIwUBtmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331377; c=relaxed/simple;
	bh=G1F+mYzfQRs8/KGGawcQwgU5uDFp2pGRLYCJ7R+lFk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el8js1UE7QgVdVkqmjIApRr2Id1Rdc/3QFpliG2+I9WRWfjRpQwZmaUmmpos14Z9R108hGic13twuV0J/FGKhqiJ7v+BSLh8pvXFTWcr56tFKSWEp1msrXcRwBPqdwDEJIaqG0JqdpHofC9h0o43GbUmKPES4a/eE0VCtaTAXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLSpp+ft; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLSpp+ft"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c413dea9ca6so195044566b.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331373; x=1792936173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=VLSpp+ftSBB82aGe0/Lkd/RfqraEpUZGje0VBXeLwN7SbzpCltXVlKdBkRLTLCdyvL
         hvesBKng28cvD2X+NrsYZBKvEM2bc82kR/cS+mBoy5SmuoAArXPoXMCiJXaqdf6liRof
         ARfk4vu/ldcOr4+7Z3Ap1N7UUiwKWVQUSd3KSQP9JpQp9N/c+YIOyFTU9QkYRqD4zad8
         yDo8Hc7v5+4UYyb9Xvlw0jpDtML9mSpWkX8O2lREWFYR8UuXMEh4WJKh06ZYZHVZzeB4
         z9wCOOjjPDF/Jk5y8qDaV5gZsnPp/5dphAanEI4L58Tteh5D1EOwvyUYUgYwi8r9kZmX
         nYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331373; x=1792936173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=oXnVRoc6CIa5IUFKgKS65LMp250/0ErmOgB+dzzlzz5t12r3YuJX0NqrNCtfz+O/Fo
         LFe6eWcax/KUTXNjxc7rRQMFGJWh7OcynQ2nzTJ0pzwPwd+6EdPJPTPY4F6HY0CmXceA
         l3fG7YbUpsY5reXt/E5i7NDX4eeKcYjpdefzcjgZaXccPTZOyC7s3RUx2XCCTNbJrkGp
         B7sL4JPdwKyPiQ520plBMtw/an4p9YNLclg+Ofop5UPXLlXOk53f5qamH8nDT5/+WLmI
         BP6T7haJ80PDzd/+c4AiagGvOQ1GMovP2fWQASiNDVU9kFl1+P+nHttzvnkZDjqRVny4
         nXSA==
X-Forwarded-Encrypted: i=1; AKwUvBwzkwaFA3E3GZqwL827ItLE9zCei3KeYTTo5y6riH5F9y9KTBli2z/F6FpsWQHTGyCsBSLYSOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5cy15gMnX1pPO7Vlr2fAyj3+7QKk9jnGhu7zUqkNNEogc/48i
	E0F2WX+Lj45E3V2kVoLIULX3RLRmrQ6NxShPrjLIljDMLFoZeKc0+jvJ
X-Gm-Gg: AYBFou2vGDeRGrO2Hj5y1tl4/gDtqiyfzuA1Nz7nTbNAgXHoRyl4nofavq+J/bVVLz8
	0t1+b4R+ge8PHg2dea7HRFET42kTrUOL/oZqOZxofmsXthoxanaxckQVT1gS3P8d7HqH/MxfKmI
	pexd59+3lKSQaDCEscA0Xw1eyRtxoavbzQtgIMAtnPspnfqVJ//wmLjN1FRgxd+X6oZzFo/uftP
	UrEb5nOVPbUyRSr2QtLH01e1YIK/Pzgbjnkpk4BPRaD9WeJp5e7o4kaW/qO24QOUpAWr+BBmZ4t
	93GMglvdUa+WIk8Gm6FJEb+NQnROLo8QEyUfiITYFfMvO241pSCkYbYl1YvC9O1AK1BDYkM/DNR
	zO0vQCRgEFxYfhSoh/bwHZZzppuELasp99PsJnbrv4CaL2L+8x5ndkdtqtRhyuhm9GBxox2Emj2
	g9YsAEBs9TLDeUduI1S8fQ41bqeNprnKpShmZlOLeEUiimgcXjfHw6a4pool2Lq7oqHoa7NGaoK
	07sKiKv7SmNT/MyxnhnX2wkG5klo+nxley6INBn
X-Received: by 2002:a17:907:60c8:b0:c43:a881:3f4b with SMTP id a640c23a62f3a-c43a8814361mr97331566b.47.1792331372603;
        Sun, 18 Oct 2026 06:49:32 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:30 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 02/10] sparc64: honor queued spinlock layout in secondary startup
Date: Sun, 18 Oct 2026 15:45:04 +0200
Message-ID: <20261018134738.1016106-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trampoline uses ldstub on byte zero of prom_entry_lock, which is a
queue-tail byte in the big-endian queued-spinlock layout. This writes
0xff000000; with NR_CPUS < 16384, a C locker can decode that tail as
CPU 16319 and access beyond the per-CPU table. Testing this byte also
fails to exclude a C holder of the locked byte at offset three.

Acquire the word with CASA, release byte three and poll while contended.
Retain explicit assembly ordering and the predicted branch for Spitfire
erratum 51; C unlock relies on TSO and compiler ordering.

See qspinlock_types.h and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 40 +++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..447334730122 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -106,9 +106,19 @@ startup_continue:
 	 * We lock 'num_kernel_image_mappings' consequetive entries.
 	 */
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* Get onto temporary stack which will be in the locked
 	 * kernel image.
@@ -212,7 +222,13 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +342,19 @@ after_lock_tlb:
 	wrpr		%g0, 0, %wstate
 
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* As a hack, put &init_thread_union into %g6.
 	 * prom_world() loads from here to restore the %asi
@@ -389,7 +415,13 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
-- 
2.43.0

