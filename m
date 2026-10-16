Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3E3C8C52;
	Fri, 16 Oct 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138248; cv=none; b=CCgcbQzezCh8Y923MOuTQwY5a1HrWhprNwpj3UH+UF7mYwdausqOkHiXGUtzzlZ8cqqfnjG3UUuKlFd5j1hxrzHMLCz2Jx439FWotrrlz6pK18yDuWN7J+TaoQdj4KzPlKJYwc5rKy19a4Ew6S2syYSzKc7KMztof8uy2vSMpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138248; c=relaxed/simple;
	bh=M1PHa19Nj9XSV8oZ60dYG7NowpzaYgqsVJb1rfM3TVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3+G3a/M4ZGatOGlPiQhzYl9DErgiX+FsUhR0eiM7Z2/D4ZGAyTXOSw7KsK11ujRQbRc3bs9PvW8COmYXUoiYDAJe2c07g2Ajp5Lh+DmURSzgeNlGF8ul2XytVb/qfgkXFo1FmU83sHe9n5fO3zBCBp9a0/jwwSwNX4d//hRkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogIDzbLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogIDzbLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2875F1F000C4;
	Fri, 16 Oct 2026 08:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138247;
	bh=M5OElhu89qumPt2CjYsURijqL6J/gi49Ix/Iha37J54=;
	h=From:To:Cc:Subject:Date;
	b=ogIDzbLIBxrlIFMa6dguTiAHhNLmHN1blL2afxoSmTHLnxrjg2jGYZv1I1ue7oaUA
	 xUOJ+ta3XDmlPMsfmzWunfPbPejSVq4gi2m6PbFjZptBAEXT15a9ZkqNoCOJSTgp1i
	 /7Iz2A9gIZTeQ/DBtbMWXSbWxdK3Mr6drGcYcT27pB3Vir0v6RwPQncVFwdUfnE48W
	 Imc7+MYbLLZlxi5me1lyWXgI/0Ksr3u2sKwSkET1bRfEOdiLtTg0ekeltADkgnPJyl
	 51ffDalwT+JQVUaq1rDOGlrUFHXq1YMX+TlkcQMGMM71v7c8IO0yIUMf8HHegiKp2z
	 brJkWZeLirbRA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	stable@vger.kernel.org,
	Ramin Moussavi <ramin.moussavi@yacoub.de>,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [PATCH v2] sparc32: keep PIL raised on the SMP ticker and LEON IPI exit paths
Date: Fri, 16 Oct 2026 10:09:42 +0200
Message-ID: <20261016080942.13167-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smp4m_ticker returns from smp4m_percpu_timer_interrupt() by writing the
interrupted %psr back with traps enabled, which drops PIL before
RESTORE_ALL. A level 14 tick pending again at that point can be taken
on top of the current trap frame, and back-to-back ticks can nest until
the 8K kernel stack runs into thread_info. Keep PIL at 15 until rett
restores the interrupted %psr, as real_irq_continue does.

smp4d_ticker and smpleon_ipi exit the same way and get the same change.

Broken since 2.1.36 (sun4m), 2.1.97 (sun4d) and 2.6.33 (LEON).

Cc: stable@vger.kernel.org
Tested-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
Tested-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    No Fixes: tag: this has been broken since 2.1.36 on sun4m (as
    smp_ticker) and since 2.1.97 on sun4d, before the git history. The
    LEON exit came with smpleon_ticker in 8401707ff645 ("sparc,leon:
    Sparc-Leon SMP support") in 2.6.33 and moved to smpleon_ipi in 3.0; a
    Fixes: tag naming one commit would date all three sites to it.

Changes in v2:
- Shorten the exit-path comments (Andreas Larsson)

v1: https://lore.kernel.org/r/20260927005658.8242-1-kaloz@kernel.org

 arch/sparc/kernel/entry.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..7ceaa328a9e3 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -252,7 +252,8 @@ smp4m_ticker:
 	WRITE_PAUSE
 	call	smp4m_percpu_timer_interrupt
 	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett
+	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
 
@@ -353,7 +354,8 @@ smp4d_ticker:
 	WRITE_PAUSE
 	call	smp4d_percpu_timer_interrupt
 	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett
+	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
 
@@ -407,7 +409,8 @@ smpleon_ipi:
 	WRITE_PAUSE
 	call	leonsmp_ipi_interrupt
 	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett
+	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
 

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

