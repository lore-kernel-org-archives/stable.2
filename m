Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A151CAAC
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789305494; cv=none; b=LJZDk4yk/XRsB3MwB0CbP4jMRJwXyFFZiIBGJcuKuMTtAxyRN+lypTlgpjd2/gk2l/3FtjE6PYd8B+XzB1Io5i4EFvOlkBGQb7V5M+j4iGeUNcALrMzISw+H2o5W5ijyUtt+9Wd+yuwsGrdNz3RQ1C22nCD+RTZKQp5owWAE+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789305494; c=relaxed/simple;
	bh=4PBfJSsN7kfeIgqBGeuu+hMW/kpXMUAKD5X6y3N1qrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WygSsQJ6l9lU89l0MG1OYjtyLmZePXNqPKDRrB5KWC+X5YTu2p4xkQ+Ngi098GSMs8JvzVmBO1S7n4NhmSSZ/AkkAZr4eZYshYW0o08B8Vl5SeleLcqYaHcEzfieYXM4iCdqd3lZnQMzkpj/DImmAtRATW3KadHNTWY7kHrSEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=uwI2thGO; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="uwI2thGO"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-858facc86fdso715827b3.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789305491; x=1789910291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LSb+qxGlYbynh0pp1CPDDM0oB9qczgGLF2ehmN4RM+4=;
        b=uwI2thGODyouTNLNKuvdqOaTUrTfyCv308eDUvk2GA2LYHRVQTucfNrSmlub5bdM3q
         gT8lSuDfyjieTRKY1ST/W8mzbtRWJmMF++mmp/riLcsmrOctEsb4IOyoz0GydsMJK9PV
         eAzVPignTDacljuf747q4tJ9QSUpfQPx1o/lbLrt/rf6Mvnz7HxAcMvrycUGJzO+S9NL
         yWzGvBkYqdAFUFEN4RDXOf2yAtsAjyPXFVuf1mTx266lHCcf0jfJg8Vhx75jos1mXmZT
         B91ehDThZS7MWobTILEmvGM2kh3aapfujD5MJKjAtQeUBAVvzS8x67Fa0W7ujDwULIF5
         pDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789305491; x=1789910291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LSb+qxGlYbynh0pp1CPDDM0oB9qczgGLF2ehmN4RM+4=;
        b=WGsQNTIxsYRC5MK3KU8ytFLwoxq4FX21Xtd4NCKUXiXZNDcuDyNWm5y8ucO6cNk/Bt
         73fmXXz1KwB2L6uTcSbDCXUZtTAoH7j7nwlgF+ZY/zRqZIP+CNPOAPSXeR9erqwauZzN
         i8E3AbbWnAPya3XGyt8luhxottmOSelkiCxYKUAN9r4oSrkD2w/a3G8dQqaj1RytFZsx
         jb65UF+FUnCAEMJYZtNBcBtWKbxs3WrssKzpJsQk+OXrLVNes/pUAvdwT7sYeICv/vCe
         NY3ehu3iRf8KdPluyge55mj7azhVguw68ZJn8Q4X8wOKPGFUgMSVPixVa9BwUXhCKwX4
         Ogjw==
X-Forwarded-Encrypted: i=1; AKwUvBw7r57mqvkKSDw1Mt8h9y47TZuP4x21HKZ1Kmw2ga9NHFSSlXOMM5QyubfDa8m5prAublGSoas=@vger.kernel.org
X-Gm-Message-State: AFuF++nI3cqXuRGdFr/6qtP/YRCrbz5RNGFZN//OcDJtsbDImPw85kiL
	IVMnuawr5g7xzsLhD4Q5oQn3pelQ7sqQMOFAT9BEOsaj7ICvjfS1UgZuxWRHdXVDQrTc
X-Gm-Gg: AYBFou1HHrpJnDB++MfeyWKu99NToScdkoVr0GlVU0JnnwsHc3KCoSzf/RQ9JNzVmsW
	EpD3fOWhoyMtmgGWJ8xZfFkvppKcNl4589T0E2VuDhB+mHqaLai3zNN8wFBXi5TPjjpOnRrs/UG
	B8aere+ZCDpKP2eKIaxnkMA9fy+UcB0KYqXgrbDsntb2xtK6YkmFNqdEbIu7zm1xQ7gdKIVpk21
	t5HnRnYabePhAK99Fzaj6TBaZ7MNjTsG1XCgQsZWa7jCLoSHy51W/FI68t8xEx301PTbnRkJYZC
	FKy2ujky1Gmiqp2WMzPoR0Z6K70da0rt1SnBxMkEQKPLaaEItCNzG/YcJZlVqH2Z41M8/eorBNe
	VncgWjrP43jwMsduPOykhc6EPxqJ1of9KoKIHKneEunWQx/p5XhJJ+xdWBFEfs30xld65x0zTtl
	kFE2pjYwAeQcbd9Vb7a53no2p/oiYOwfJo8xa6uJKT6/6Ue32cJ36bJEESlHKyFEf9FL4ARBTeE
	iHPjCf72GuURdFyA/UUlsdLTEceFbITu3sZR3Yk
X-Received: by 2002:a05:690c:b06:b0:862:1f26:d489 with SMTP id 00721157ae682-884b1a2f84bmr50752127b3.3.1789305491416;
        Sun, 13 Sep 2026 06:18:11 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488c3ab26sm27731697b3.40.2026.09.13.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:18:10 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Will Drewry <wad@chromium.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] m68k: Fix seccomp filtering on ColdFire and 68000
Date: Sun, 13 Sep 2026 09:17:53 -0400
Message-ID: <20260913131753.605893-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912230651.461269-1-clusk@northecho.dev>
References: <20260912230651.461269-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m68k selects HAVE_ARCH_SECCOMP_FILTER for all configurations, but the
ColdFire and 68000 syscall entry paths only branch to
syscall_trace_enter() for TIF_SYSCALL_TRACE. TIF_SECCOMP alone falls
through to syscall dispatch, leaving installed filters ineffective.

Test the combined TIF_SYSCALL_TRACE and TIF_SECCOMP mask in both paths
and route either flag through the existing slow path. Leave the classic
MMU syscall entry implementation unchanged.

Validated the combined test under QEMU mcf5208evb (ColdFire): filters
denying getpid, openat, unlinkat, and reboot each returned -EPERM. A
classic-MMU control (q800) denied the filtered getpid syscall both before
and after this change. The 68000 path shares the same source-level
omission and receives the identical masked test but was not separately
emulated. Compile-tested W=1 with CONFIG_SECCOMP_FILTER=y on both
m5208evb_defconfig and a custom no-MMU UCSIMM configuration; the latter
built arch/m68k/68000/entry.o and vmlinux.

Fixes: 6baaade15594 ("m68k: Add kernel seccomp support")
Cc: stable@vger.kernel.org # v6.3+
Suggested-by: Andreas Schwab <schwab@linux-m68k.org>
Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---

Notes:
    Changes in v2:
    - Combine the TRACE/SECCOMP tests into a single masked branch per Andreas
      Schwab; scoped to the ColdFire/68000 paths, classic MMU unchanged.
    
    No in-tree m68k defconfig selects the pure-68000/DragonBall path.
    Compile-tested W=1 with a custom no-MMU UCSIMM configuration and
    CONFIG_SECCOMP_FILTER=y; arch/m68k/68000/entry.o and vmlinux both built
    successfully. The combined gate uses the same flags byte as the classic-MMU
    entry path.

 arch/m68k/68000/entry.S    | 3 ++-
 arch/m68k/coldfire/entry.S | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index c257cc415..0d3cbeded 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -79,7 +79,8 @@ ENTRY(system_call)
 
 	/* Doing a trace ? */
 	getthreadinfo
-	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
+	moveb	%a2@(TINFO_FLAGS+2),%d1
+	andl	#((_TIF_SYSCALL_TRACE + _TIF_SECCOMP) >> 8),%d1
 	jne	do_trace
 	cmpl	#NR_syscalls,%d0
 	jcc	badsys
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index 4ea08336e..d658abdc5 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -72,7 +72,8 @@ ENTRY(system_call)
 	movel	%d2,%a0
 	movel	%a0@,%a1		/* save top of frame */
 	movel	%sp,%a1@(TASK_THREAD+THREAD_ESP0)
-	btst	#(TIF_SYSCALL_TRACE%8),%a0@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
+	moveb	%a0@(TINFO_FLAGS+2),%d2
+	andl	#((_TIF_SYSCALL_TRACE + _TIF_SECCOMP) >> 8),%d2
 	bnes	1f
 
 	movel	%d3,%a0
-- 
2.55.0

