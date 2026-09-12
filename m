Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB8301486
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254430; cv=none; b=kSlASU3Eo3GoYh027DHlTtbg9j+3vZOzM6mDZEp00rDWdeyLUc/PSdphnpq4kwRfMhkYlNdUbC/VTTv4D/1nKFh51nY6twI+akfQ4q+oxn21cZnSCiHIblrFjSzn1JR45EExgKACf9UZ75FBcZngZezyZ/tXbGYS6MxlWcBXyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254430; c=relaxed/simple;
	bh=TdzRwhjQNVmDU9bqekeCy1JbqM5euo3ldm/AuhuZlxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoXTMu02mSW9W2A2GwKxrbzdFURWGug4INTEj6zuOzAvD9MSnaatWIRAf4oMREOVR6naNQst3N2kFztvHgYx9/HRPXot1DvCkO5H8s1N2DkE4L8YJBfykrozc9HFGM9OjH2STRRMrFWdq1g91CXhbvbHT6wm+sPxbCtZf0LamAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=WRPWUoEq; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="WRPWUoEq"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-86ffc11abc1so253997b3.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789254427; x=1789859227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjEDdvlxexIZGgyTpilEkHXXYYzPdhgUTGEAelW9epE=;
        b=WRPWUoEq8KqClE3UBRwuvBMiCQ1Yq/riEo4iFkHHqoPjYiuF2qPYqn8R4LbZ/PQPFx
         for0uxHxxirVasytUbdHoo5HfIv4S7EOjOvjov1d5ev20bUcoWKO/fYaWdVZ24QtYKLl
         De39KH0EyP2hZyXM2TQVxrGwlDiMLaJ4nQ53Fv7lOzsCjkAd2JNu7IaW7qivM0KfuqWo
         GA1VFOQ25S6yBXUy6AS5oFixnLpMqv2xB/37rct/f9G8nVElOLT/tGQKTDMp1r5DRpbA
         rGepIRFNifI1OtUQt5n/pSVotDsbNcuskeb6/gUJxdUBlViXC8K7ZrSeP1r4GEArI64i
         PK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254427; x=1789859227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjEDdvlxexIZGgyTpilEkHXXYYzPdhgUTGEAelW9epE=;
        b=XlbW4t0tp1h9oVMc3MJR6Jtgttv9NB+TGuqEehH9WT1IncEpmgTEbyZvqPugO5x8sN
         49mHQeFoXoZ3yXbVb0+mYLR1MUly3OL/1PAg5OsuDmNbeczA9LI13Mr6ae6omLWa0HM4
         8mUnlu4I1uQeH9aJSxQ1JDdCuDp3Qnq24us+ZJDChSr+UlTHqRsvWhpXVfV1ofrWlkfM
         RyVLjKJkL4pJJS7O2MT2d56gZZmDPOAV0YErTVrHRRtepl2M+QT8Au6wKWoFiyBk3q3a
         MxoZZDBJiJC6tSMlsDlFq78SPLdu17NGLZDq3RzXTu/NaLvDhjEe9Yyj8071aHHaMvVz
         Z05Q==
X-Forwarded-Encrypted: i=1; AKwUvBziIJgEtJf7iNyLWi29JoFFanCszFgE54f3kEjtrtHKKTpnFyFBu+h7cv93wOKoRvfzh2ezEWU=@vger.kernel.org
X-Gm-Message-State: AFuF++lez95QsNzwfIt9ZliNWmdjGgNKilF8mZCYcc57tACR2N6NQofv
	aBfGZFQlkpQXrw43lD/KOtpgla5eHBOb+JtDJAcFBirQJEMeS5yOybOGLoes2BgFnTLR
X-Gm-Gg: AYBFou3iBZRi4mcTgLWLNPPbzlkGIEVEM9lva0f/Yj4nAZKSSauLJGgkOHuOMpuiPDh
	G7mCAZP6+/7iyiJEoR6fCQE59353NA3aVCSHOLkxm0Itr/7coMnB2j6i5UnPFg/WZiEvyy8/laW
	oKR09fzgwmcjh8pVQa+rBdHzFKeGsblPLi/uUdqQ94JUdXlatL6MluczeFM6K3CDavLnuMKt/XC
	MxP/y+lgQQ1lJ6dFMsNQSHGUT3A+JgWBDnaKBp4C2BaDu3025c7fcfrc2ooaTPYyu/T7W6+DLjA
	2Pikuc7ceyO3jI7qX37/V/vGImSb9h7oCl65Kjxc1WZ/FmDq4tXkdEVx3KiCIwS3TSasimANSPD
	cdETlOnEOLn7YlDoVofqELCIREAtStlUKbBzzcBJ3cBPdjNLgD1IzNAPzmCrsIywPpGb2T9pLGJ
	Pl4xog7Lhswh4i7Z5ZsV6tjo3XvWLy2TGusuEsm5RUPYGae7qjNxUl3ffmTFs89zVp9fNFbUgKH
	LwGT0cl4p2+1K6hR7ou4A63qWaWuE8WYroQKjo=
X-Received: by 2002:a05:690c:2602:b0:820:18ab:ff72 with SMTP id 00721157ae682-884b6c2e93emr41536317b3.3.1789254427333;
        Sat, 12 Sep 2026 16:07:07 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488856486sm23622947b3.37.2026.09.12.16.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 16:07:06 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Will Drewry <wad@chromium.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] m68k: Fix seccomp filtering on ColdFire and 68000
Date: Sat, 12 Sep 2026 19:06:51 -0400
Message-ID: <20260912230651.461269-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
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

Test TIF_SECCOMP in both paths and route it through the existing slow
path, matching the classic MMU syscall entry implementation.

Validated under QEMU mcf5208evb (ColdFire): a task installing a seccomp
filter denying getpid() still executed the syscall before this change and
returns -EPERM with it; likewise for a filter denying
openat/unlinkat/reboot. A classic-MMU control (q800) denied the filtered
syscall both before and after, confirming the gap is specific to the
ColdFire/68000 entry paths. The 68000 path shares the same source-level
omission and receives the identical fix but was not separately emulated.
Compile-tested W=1 with CONFIG_SECCOMP_FILTER=y on m5208evb_defconfig.

Fixes: 6baaade15594 ("m68k: Add kernel seccomp support")
Cc: stable@vger.kernel.org # v6.3+
Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---

Notes:
    No in-tree m68k defconfig selects the pure-68000/DragonBall path.
    Compile-tested W=1 with a custom no-MMU UCSIMM configuration and
    CONFIG_SECCOMP_FILTER=y; arch/m68k/68000/entry.o and vmlinux both built
    successfully. The added gate is form-identical to the ColdFire and
    classic-MMU gates.

 arch/m68k/68000/entry.S    | 2 ++
 arch/m68k/coldfire/entry.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index c257cc415..093be0a66 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -81,6 +81,8 @@ ENTRY(system_call)
 	getthreadinfo
 	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
 	jne	do_trace
+	btst	#(TIF_SECCOMP%8),%a2@(TINFO_FLAGS+(31-TIF_SECCOMP)/8)
+	jne	do_trace
 	cmpl	#NR_syscalls,%d0
 	jcc	badsys
 	lsl	#2,%d0
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index 4ea08336e..b73de9585 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -74,6 +74,8 @@ ENTRY(system_call)
 	movel	%sp,%a1@(TASK_THREAD+THREAD_ESP0)
 	btst	#(TIF_SYSCALL_TRACE%8),%a0@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
 	bnes	1f
+	btst	#(TIF_SECCOMP%8),%a0@(TINFO_FLAGS+(31-TIF_SECCOMP)/8)
+	bnes	1f
 
 	movel	%d3,%a0
 	jbsr	%a0@
-- 
2.55.0

