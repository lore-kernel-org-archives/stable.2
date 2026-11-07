Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046717;
	b=KCxXruyXajljHsynoOcU2SnqqO4RDIPbsuQ2fmkkSSsIktsNkI2brLQer1AuR8mxNtAi
	 fxmE/U4JsT1vzEeHtNMy7+qgHHnNyPF8HvlFt/ujm0PAiYQhuCqGYFfcHEAD2iAQHrqF7
	 Q0aUefVYWiYm/T9p7ShgZf+YUJTRTGTuKnje+hDcQVtudTNKgoBGknmC1uj9F3dZNVgp1
	 pk7DkSlZLLzW5ChHNnoOsETmwJ6bY16tdrtx5eVKOdvJDu/cVUzrr+Dpbp06T0Qa1qgiM
	 gSrj7vq5ndDMbd/NWf6TTtNp/N3DEgM6I89xwUFizBjYNvXfYTkUBbwqjxRdW/wC0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046717;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C5mmZHt2nTzpfGy9SW7AIaXPPVDGOA8NieM/J8C5NOA=;
	b=Z+bBmlHL9vzVQDzOAdzEG6ev34MTVxBMGvtkM0kG9Qfi+OIqd+xzyFHGQ89m8YXMBfTp
	 dN+MvTq5CHMRW2BNteTEaUeOA7SHilRDnlKz/CPPLDW7q/d4sYabIFmtJi9pD5iR1zQON
	 299EjC5PLlRPdFxGFpQSlWpnC7pf+8LSmn2mFoMide3OfNhsMnJlnPr4Z5IUVuObQLIAq
	 wnI1vEImYqk/TA6TeD9PzzOy5lgTC5Jc7Rt39ohuGjaaFZyH0Wwd7R5J6T/Da3ieUFUhB
	 89epQ3jN5+fFvO5uVI7Y1GkIq5dF0xPo8OCxmHoV2qvmBo/jRTqtsXRMpdE66wWWP1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W14VaMHa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C3606EE8D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W14VaMHa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AEC1F0089F;
	Sat,  7 Nov 2026 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046717;
	bh=C5mmZHt2nTzpfGy9SW7AIaXPPVDGOA8NieM/J8C5NOA=;
	h=From:To:Cc:Subject:Date;
	b=W14VaMHaSOckFcrMENHfNI6BcyRMMQtVuXlTR0ZJyET9njPHAECGb94nGPLEKgktE
	 OORysusxeTpDAG8/u6mRJuDQ3zDBcvQUHQVUBZmtgprDenlBd7BDfxdFN8I5DwmPix
	 q5Jrw4w4OjWA5shiuZWyOrSXEHBSFmDuuJgMHshh+42W7CN/Jn/hj00lyyAs6ZWx/N
	 FUb4wWXwRRguOj/iTRiIuJXelkC4x5kEU2j7E4rkHtzDRWRPMa5hdcuP8holuTddFY
	 R0OBFuj0ZifEsROoiOrMMldZzznaKUmAsXQeKO4o0fBMiN1G2b5J7KhjpFNm93NaIP
	 hG4dgYXX3etGQ==
From: Sasha Levin <sashal@kernel.org>
To: vdonnefort@google.com,
	fuad.tabba@linux.dev,
	tabba@google.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:35 -0500
Message-ID: <20261107051835-failed-6.12-6c29285e78b5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6c29285e78b5e4811145ebda382ac0ba732ce56a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051835-failed-6.12-6c29285e78b5@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6c29285e78b5e4811145ebda382ac0ba732ce56a Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Mon, 28 Sep 2026 10:54:50 +0100
Subject: [PATCH] KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs

Protected VM ID register emulation leaves unlisted fields at 0. This
creates two issues for TGRAN:

  * TGRAN16: 0 means non-implemented. It prevents 16KB protected VMs
    from booting even when the hardware supports it.

  * TGRAN4|TGRAN64: 0 means implemented. This may falsely advertise the
    feature even when the hardware does not support it.

Advertise all the TGRAN fields in pvmid_aa64mmfr0 so that the hardware
support is properly propagated.

Cc: stable@vger.kernel.org
Fixes: 6c30bfb18d0b ("KVM: arm64: Add handlers for protected VM System Registers")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260928095454.3255918-2-vdonnefort@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 8758c68017765..ec469d96516a5 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -121,6 +121,9 @@ static const struct pvm_ftr_bits pvmid_aa64mmfr0[] = {
 	MAX_FEAT(ID_AA64MMFR0_EL1, SNSMEM, IMP),
 	MAX_FEAT(ID_AA64MMFR0_EL1, BIGENDEL0, IMP),
 	MAX_FEAT(ID_AA64MMFR0_EL1, EXS, IMP),
+	MAX_FEAT(ID_AA64MMFR0_EL1, TGRAN4, IMP),
+	MAX_FEAT(ID_AA64MMFR0_EL1, TGRAN16, IMP),
+	MAX_FEAT(ID_AA64MMFR0_EL1, TGRAN64, IMP),
 	FEAT_END
 };
 
-- 
2.53.0




