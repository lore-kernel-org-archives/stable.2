Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177365;
	b=Qz9TgzKf7nzYicOkKAPKLwVIbc4bWz2cM5eU9wiRahtPdddn6dQPMRQ7V3+OnXHYlwOP
	 E++LYJK4Htpa8iHHEvp8cTGUK4riz7OXwW2nbbP18y7Bu8Pkz4hWyfvAq1h6SoqQ4NMeJ
	 kbBBKc1mDEuK24lgbFgpM2+PpvgDde969DgaK+M4EIm8GFIyeoL5swkby8s/Eu5iOnL/N
	 jqXxm6IAKxbvuNtb9AIgfibQ2x8g8rKOgPNhcsL314PKBF2ko/MgTFl/v5bioNpFarxB6
	 m5kKDmEtNbR5n36m9wu5dquIliHqOwHh5Rg9ngftS2Ytcm832yEPiDeyXYux4pzaO9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FbPoExABZjsxSOH96VExzW2VKSc6vBBXRW9rdJVDw3M=;
	b=pZvpHyuWaGh0GJaDTeZycq+UJD7kiPBwGApp4kLjNeGtlGTtsmHZ8oBdE3yGJXyHwYTz
	 rBYPY1YfM9UMtQne3apbT+atgfeaqLdO6PeUoAFSNk9itDKvx9l4AtV2QrkXPu6T1LkxN
	 hZvX4ClovEj0nrEiIyVrAmxVqajWrPmQ1uTrtdmXNDXnuhxp4KwkvMEgn6oKsSq75gxqe
	 T9Y+iamkMJ5GJB3UhoQNbHf9/aK+pIhxiF/09EIdsnu3zfYsTgH1FeYCPQGYOmJcDJEWY
	 FaKlBNRz15PlgHmvef5YX5c4c5u6uNAa1Slmy34H6VA/rKECooBGVU956kqYgvF4b7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uDo/U2rf";
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71D606A323
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C71D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDo/U2rf
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so398955a12.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177364; x=1794782164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FbPoExABZjsxSOH96VExzW2VKSc6vBBXRW9rdJVDw3M=;
        b=uDo/U2rf1e+6v5RgXFGgvxAc2iJROjXy/N980r9+UqjEUK2yjXUgiZ1U/msUrU0yDk
         NVrxWCwdywGVFgLM3lvgSwrzXWR2p4ujGCXgGSIblvpQTcPwWxLLKl/yZiHtB+UwX3kU
         h+bdb88YCT0vA0KJypYQtjN3TNEHwFnJ8yBIvBQG4pTwe3UC+Kdl6hQjnW963KPusMI9
         ozm7brn8MFWiaTQVscfKjRf4oTYOAHJsqcyXGFTP77f9PLIFhoUGbLQoT84TCNT7cc+i
         FrO868ThdVojhzNS2CJZEYyV+HYrZevx1StdK5bdStO4z12xLO81bbTgQ9lM5/ZUsZWr
         9F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177364; x=1794782164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FbPoExABZjsxSOH96VExzW2VKSc6vBBXRW9rdJVDw3M=;
        b=OakUgGihsWuvUQdXtLJ+2wKpYaYfeWgRtowgMruFGHIaN7PXSE5amcQCCs+H5RG8zD
         vbOfbDcqP0D+tMrjOX9oqKbaMorx09S1Zpw3CxrZPTAeAbqZEcUq8pYOk3Dyn38TCTK2
         S9O3s/neQ0ljS709Pnz8rUl3uXmEwOv2lrcmcspTqvrYCML6Kw6KF5tigLdBkXiyETN/
         ggMbGI+5DgrYqlNGcbJ9jTN9Gsj1VPpE/F2F34Z3GOeK5/RhbhIEqoJufjaXjsf5m0qS
         U3o3OCiRQ0734FfptAhnBuSo4VufTBPPjrWOvUb0z6DJbi5b/rht8nMXODhVuarIJE7a
         ifeg==
X-Forwarded-Encrypted: i=1; AL+hErF3/fGkJ0lrEHZXcwfVjHKCydrNyvs8hvKXIlq/+v5CiHLssPZ/1qyQ6IcVCsb53zMqhHdeCZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ehplQymXrGdUInhz/Uw32cxqr0A1PZ9JJj7hHikLLxNpZeIjP
	SkxS7Pjxzf3lcgSgTVHQL2ZnXfTXI/nJNKhECHvI5yLbz8beVKsF9Aq/
X-Gm-Gg: AYBFou1c47SEPgaYByrCFXDve+58wqye/sKA5uFBkVDOkvdnfaVx33dTRIIRCvhE5Xg
	fZVz+RF5aUnc0UuYWN5uB6MNBMx/OOJypq6RJqQ96l4uzb0ywfVOVQq6+cO1/HQSHSKudFiWzAf
	GSE1pMHm6xnKkGy/0Y4QZEoJhZU+3Ge51xYu0r1S46T+xqbMu30VQRPgkA1mUSHWmbma/zm9yoK
	tj53qxLsA1qV7R+SDgq64rrijZ3PjdYYO2hbL6i6N1j+Mycb7GhV9GIHGsaPez7G3VB1M6s6iBj
	KDllm7dzkOq0FudENfPpmaDQdSautFUeG1/MqKHRXVfRK1waz+R0tTMg//tTVIw8D+XPTwYS/zp
	743at/qv1M4rA2JC7V9LwhIFfTiMRMr5Oa9yBQIFSOt6B9t3JyLQQ7Wc3hmORi14ZaeEpbUuB1T
	meSbsnAcb8u1+wFPhPKWTQLz230HZ2X94aW7C9jH92GqwQ3GxJ1/ORyYMYBzc/Wsm634Zb0GNvl
	wU+zXDBjJZel9WCUxMcZ9tVdSLRsq5hN6jj1ZqTappneSBgYvSh3VENNomP3bu0/Zuiq6TkuqeQ
	6gvF8gFRLvL6tm8N2wAcLVekDhurjhIpvfsPs7oRh0aS3rS6BlzQbFsPR35mKBv5HHLKwX8=
X-Received: by 2002:aa7:d788:0:b0:6b3:f05e:fd5e with SMTP id 4fb4d7f45d1cf-6b722483d5dmr1158730a12.33.1794177363626;
        Sun, 08 Nov 2026 14:36:03 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:03 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6/9] sparc32: colour-align private file mappings
Date: Sun,  8 Nov 2026 23:34:16 +0100
Message-ID: <20261108223516.1125534-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
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

arch_get_unmapped_area() aligns MAP_SHARED so a file page is mapped at the
colour its page offset implies, but gives MAP_PRIVATE an align_mask of
zero. A private file mapping therefore lands at an arbitrary colour, and
on a virtually indexed cache it aliases any other mapping of the same
page.

Measured on an SS-20 with a 512 KB VAC: every page of a private file
mapping sat at the wrong colour, 64 of 64, at three different offsets.

Align them as sparc64 does, whenever there is a file rather than only when
the mapping is shared. MAP_FIXED is left alone: the ELF loader places
segments with MAP_PRIVATE|MAP_FIXED at addresses that need not preserve
colour, so rejecting those makes execve() fail.

Reference: MBus Interface Specification, SPARC International, 1997, signal
VA[19:12] (MAD[53:46]).

This changes alignment on HyperSPARC, where SHMLBA follows the VAC size.
Each private file mapping can consume up to SHMLBA of extra virtual space.

Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/sys_sparc_32.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index fb31bc0c5b48..e1530cee15b2 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -40,6 +40,15 @@ SYSCALL_DEFINE0(getpagesize)
 	return PAGE_SIZE; /* Possibly older binaries want 8192 on sun4's? */
 }
 
+/*
+ * A file page reached at two colours is two cache lines, so a kernel-chosen
+ * mapping of one sits at the colour its page offset implies - private too.
+ */
+static bool sparc_needs_colour_align(struct file *filp, unsigned long flags)
+{
+	return filp || (flags & MAP_SHARED);
+}
+
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	struct vm_unmapped_area_info info = {};
@@ -50,7 +59,11 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
-		 * cache aliasing constraints.
+		 * cache aliasing constraints.  Private file mappings are not
+		 * rejected here: the ELF loader places segments with
+		 * MAP_FIXED at offsets that need not preserve colour, and
+		 * refusing them makes execve() fail.  sparc64 draws the line
+		 * in the same place.
 		 */
 		if (!file_hugepage && (flags & MAP_SHARED) &&
 		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
@@ -68,7 +81,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	info.low_limit = addr;
 	info.high_limit = TASK_SIZE;
 	if (!file_hugepage) {
-		info.align_mask = (flags & MAP_SHARED) ?
+		info.align_mask = sparc_needs_colour_align(filp, flags) ?
 			(PAGE_MASK & (SHMLBA - 1)) : 0;
 		info.align_offset = pgoff << PAGE_SHIFT;
 	} else {
-- 
2.43.0

