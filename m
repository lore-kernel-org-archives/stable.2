Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933823B0AF3
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830931; cv=none; b=c6yZCIdrpnar4Ef5/0GHzEeEdZnP3p85XrGfZRMI8g6oK2DdUrXeISFcG1B2UfvUb0ESUwF1Jp+RWObBArbka1PQ6VL4Fb68TdOpTimUrP29A1HSLUE5gCOHmi8RHnXRuO9PokZM991GzpVEuIb44u3ZkILL2etL8oL6+XPxy5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830931; c=relaxed/simple;
	bh=GJ+zpiKWWrr5gcwckmi0KaPm/Le64ewG91EClvJYRqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBuWPzGP3Ff4bVP6ce3hD2T+OLgc1PCjZsuU2Cp5UBz/pSZd8pS9knOr6MLuywyUCyZsYUW5C06VZ3DFpdipIAmGJoA9ZuH+m77NEV/wZg+1CP2HAgWJC/ed2M/aZNVftXmMvc/hjDEbEAlFVqAW3qGG6Z8gyP3GKhRvpCCqmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2keFtow; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2keFtow"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2acc1e170cso357234866b.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830928; x=1792435728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18ailoawq69tzoMJxp6THyIWAF8hC7cZD05rxXZegPs=;
        b=A2keFtowjHZkmaH0KA66X7pQz8augvo2WwaY7+ykNZDak6Nd+x2AoSxpEYWQCqPOSe
         M7FFj6Jv2zq090o3J1Ah7fPJhP14voT1WYxVyfHv09DzpsTd7ElT1A+B2A44Pp18UnGP
         1StOmsL1xh83KHoEeaXQnC0DvXELJOsi/m8c9koc6+XL7IpNphhMpDCWn4m3wgAoFa9r
         zJOAcbVjJT839tpzO0pekGLzC0cy6Y3bLpgXn6uZX+JLQG1nT4asDtDQzTbdeAXAXF3I
         G9e1N21WQM0WH2NWRM+MulQtkvOU0y/HQDXqxrRE18xNHWKIS0LOXufssQ/9Ln4qYCMN
         bPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830928; x=1792435728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18ailoawq69tzoMJxp6THyIWAF8hC7cZD05rxXZegPs=;
        b=DDXwoPi5HTxRbYmWRdgNn1GFMZw7cgziSOJX6cPwFALvcfjgtBYBvchJyc/wOtYxX/
         TlJb3DBhYfmjNj85c6oPrXdEQxx6j9yi6Ubxts1Vx+eBK3dUggaZXlRfz/+v3NM6D7X/
         JBz2kh6vHju0Ps/ZojrgcjyNHaqlnvTNoVoxVYLYuHnhhZ48dCSVMeFdWy2PuICF3jMB
         bNQBOocztk+BkikDuN0x0uyrHFVi6t3Pgekv217GufKAHdG/MPt/QURr7iWtd/uG9bqj
         JWrEyU58V6BIR0i7cH9dcIXlzG+BBxOtSZTvwsS+Bsd1FyFD1v/75XtPbXwx7sLSfrN7
         Rvzw==
X-Forwarded-Encrypted: i=1; AKwUvBxUrZOUjLJ/FMolPhYhCKhVbfLgKNocXhbLVlWse3VUyGJ6i8ybR36k8ZKh9ll05VwUx8YDSXs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqdZab8x3pl7h8kf1LCDW3Ko69A1z8gROZpaI6vJG0nWYanFLy
	ZZiOcc+orI6DckrbSnGGzbWG44OWgTOXYfRDW5a4xdMQKBS8r2w4Fpra
X-Gm-Gg: AYBFou24A8PpwYXk0+zK+4kjxG1AhgojefM/4lytjY6MgUTamLSGQr4XGa0J9IVtJ59
	vLhsDJl8w8nKDaKUguw7OYn7+kVpq5iU+Y0+t6Cg7ciIJ7ddlC9R2ipiJvHHG+tY2Lwfwv9GAd8
	DHIPQl+L6N3lZUtiSMJ4HvUBN8lhrNAntFj+ZTYaY+1n3yNlo30Pv07d6a01IbMxiORwY0vYcKY
	Cumyrbm1HpKvHcLtHER6LKvTuYbh0Z+4NgU6dFSXH1CnEQTGaP2U7LDtlmW3+EUU30y3hVkR819
	9A4JU8+MIaGQN94V7e2R59ICfyMqiBWwnrr2wkC+8pX/DGVB1ZUpo5RTMzsux6F7aXCc4Hb0eWW
	PE20lk7HJzQnXTrxeGfymBE9xupu5K1PoX6DxsbvqsjX+Vktb3Y5DES1evgvjrqF0rNGPviSou0
	VLBWTFz/GTwIxUNR4c7DoEGs8z/HVN5riiI0dkFWDxp6vr9eMxoQ3lZlYATy/M5hNrlYvUMfuPx
	Phhgwf1Q+9oCfnNYyKjpnp6QRwzSq9sfbLl038G
X-Received: by 2002:a17:907:3e1d:b0:c31:70a5:4c3b with SMTP id a640c23a62f3a-c31a9a2fcccmr1093246466b.3.1791830927588;
        Mon, 12 Oct 2026 11:48:47 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:47 -0700 (PDT)
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
Subject: [PATCH v3 2/8] sparc64: honor queued spinlock layout in secondary startup
Date: Mon, 12 Oct 2026 20:48:03 +0200
Message-ID: <20261012184826.986050-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
not its locked byte, because SPARC64 uses big-endian queued spinlocks.
Acquire the word with CASA, release byte three and poll while contended.
Retain the predicted-branch barriers for Spitfire erratum 51.

See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..62f404b3079a 100644
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
@@ -212,7 +222,10 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +339,19 @@ after_lock_tlb:
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
@@ -389,7 +412,10 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
