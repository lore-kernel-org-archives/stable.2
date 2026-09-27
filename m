Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073E1632E7;
	Sun, 27 Sep 2026 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470682; cv=none; b=WHqLHQBfWZ00zoXKEjPjQW7yeoScJpzEh25UasKFW6JVeV/belf03uFgcdGgv3MHlNXwlOKzcjxzOGTOthy8jNO3TzSWIgH3LxDHSoH5Wnd6rQU9mD59qFjQJtNBRG2lkUKmNmzX7/unG0eAhv9EX1CG7LpWyznbXFaHGV7oUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470682; c=relaxed/simple;
	bh=B/dCDIXofkUA0sLZzEUAUXewUIa6WRL7cXH/VcggPGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJAVBpZAgDUaFL/rWAlYioEtEtVeg/ee+62tNBmZqZMtK7KH96nAJgj/6/3ZT7VH/CYcs2/V65aXLWJGBmRC5Y0ZbdNJFx/JRL3V3TYT3btpq2m1zjMz828pj+ag9K6iYOxEcbQpaOiTemnjLMdx94eclnsmCa6BRjD5kpzTJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsuJSXBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsuJSXBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C98D1F000FF;
	Sun, 27 Sep 2026 00:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470680;
	bh=rysu1Nki0mrN2amDt/FIu9FKJWr7ZYhqPIKS0Ecy2zw=;
	h=From:To:Cc:Subject:Date;
	b=bsuJSXBzLpzSbE5SHTK3XfvNKsQ1atmDanVH8f2cLss7EuNaCuZb93pvGyEWnLjmp
	 h8CcjAiIA3JdEYlPUZbOjbhN00mdJUEBUSwxhO26Hdp4u0PTv1XIiAFgckyAzm9cxW
	 N4kR4PHxvw0na+xq0BTdiANJ/qtV+GI+SAKNNiQ4EgOI/yfI0e+LwobMJBthBJ5zAY
	 V6mLgZRmwyn+9Yq8LawGUjGxtkhxm/j/Io7SznQB2sRx442DhobvKZuTKxTMs7RO48
	 NSjF+Odb8lxS9JTIEA9ZpQjrkix6fS2UR9lkcTiTvqL/D9FZdgMePJxJ0PtM8S4zDQ
	 D/9DfJdi9JqtA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH] sparc32: keep PIL raised on the SMP ticker and LEON IPI exit paths
Date: Sun, 27 Sep 2026 02:56:58 +0200
Message-ID: <20260927005658.8242-1-kaloz@kernel.org>
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
RESTORE_ALL. A level 14 tick pending again at that point is taken on
top of the current trap frame, so back-to-back ticks nest one frame per
tick until the 8K kernel stack runs into thread_info. Keep PIL at 15
until rett restores the interrupted %psr, as real_irq_continue does.

smp4d_ticker and smpleon_ipi exit the same way and get the same change.

Broken since 2.1.36 (sun4m), 2.1.97 (sun4d) and 2.6.33 (LEON).

Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    No Fixes: tag: this has been broken since 2.1.36 on sun4m (as
    smp_ticker) and since 2.1.97 on sun4d, before the git history. The
    LEON exit came with smpleon_ticker in 8401707ff645 ("sparc,leon:
    Sparc-Leon SMP support") in 2.6.33 and moved to smpleon_ipi in 3.0; a
    Fixes: tag naming one commit would date all three sites to it.

 arch/sparc/kernel/entry.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..7288da5f6727 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -252,7 +252,8 @@ smp4m_ticker:
 	WRITE_PAUSE
 	call	smp4m_percpu_timer_interrupt
 	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett, or a
+	wr	%g2, PSR_ET, %psr	! re-asserted tick nests on this frame
 	WRITE_PAUSE
 	RESTORE_ALL
 
@@ -353,7 +354,8 @@ smp4d_ticker:
 	WRITE_PAUSE
 	call	smp4d_percpu_timer_interrupt
 	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett, or a
+	wr	%g2, PSR_ET, %psr	! re-asserted tick nests on this frame
 	WRITE_PAUSE
 	RESTORE_ALL
 
@@ -407,7 +409,8 @@ smpleon_ipi:
 	WRITE_PAUSE
 	call	leonsmp_ipi_interrupt
 	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett, or a
+	wr	%g2, PSR_ET, %psr	! re-asserted IPI nests on this frame
 	WRITE_PAUSE
 	RESTORE_ALL
 

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.47.3

