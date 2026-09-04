Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D8381EB6;
	Fri,  4 Sep 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532337; cv=none; b=QFp15yWFKgfeEX4U/v31sA1TEgUFst4RKE9GiV+t4tNSB3wCb7AbW9l59SLJ4iQ6Afsbq2D4qcNExvha1Kh4/Gym33/7Spj8wF7no6i3OBRuEItM2cWSK/dzZgOv66/SyKsqpkgq53pHrkyvuFjEILm1IGsEgZ2E3NT70Rumr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532337; c=relaxed/simple;
	bh=dqsRKbAh8CMrEc3skpMZ5PokRpgWQyA/3UkUc8pn39U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TOVSGCwwG2CgRSGCc6zDJIdZPxgOrTKgil+D5GRKWgTyJj2Rx5EfMDFYiStP9tU4t2ccwFPW9oskELBHJ/TEiUYCItFfWsqP7tWGcHOh4Rf5cJOYp5dGb2BQ9McnIsJbPoDeHrWd6+CxVc5p0AgSWv8xufm0Mnlhtj9B7IOOZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmiBxtgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmiBxtgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EDA1F00A3D;
	Fri,  4 Sep 2026 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532336;
	bh=d+O012cIavAI0ujYW26k+aWCjKOSb9qbSR86lFvYnd8=;
	h=From:Date:Subject:To:Cc;
	b=UmiBxtgR/T5raT7CoumzmJ48BTwWw3sMkg6cNt4bB5zYgVpj5dRAHBqZWRh3v1gCl
	 rWTq5EdiUBYt19DdfvTfFvSHbkBqZ6rpIjVC+bPRfRetVndmYbleq7zRGCbAGtxVdH
	 qCEN/TudGyUPlNpBrH7VdxZSCqTsZFhEn5ILb4GtzH3bS1qFIwohbi4xbKMGJwQDbo
	 LK4kunEQAyBYgEflA8s1va6+nmBdXxNTd5GVH5qyb41UhTPcBYOLHVKoUEBIsSt1di
	 gS/Y032GIR1ez3J3ymUqgiQxa8yEEYAShWf1A3zo4nM6Ro5QKAosixsAuE+Z0U8BC/
	 8xSf8IYBs0Bfw==
From: "GUO Ren (XuanTie)" <guoren@kernel.org>
Date: Fri, 04 Sep 2026 14:31:38 +0000
Subject: [PATCH] irqchip/riscv-imsic: Fix MMIO regset lookup loop bound
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-nr_mmios-v1-1-3a19dc74fab8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEnWmmoC/yXM7QpAQBCF4VvR/La1FhtuRZKPwShLO0ht7t3i5
 1PvOQ4YLSFDETiweBLTajyiMIBuasyIgnpvUFJpmctEGFsvC60sMp1hrPMeVdqCzzeLA13fVVn
 95qOdsdvfPdz3A1ncUOVsAAAA
X-Change-ID: 20260904-nr_mmios-868e369de25b
To: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "GUO Ren (XuanTie)" <guoren@kernel.org>
X-Mailer: b4 0.16.0

The nr_mmios is the number of entries in the MMIO resource array, while
j is the index used to iterate over the array. Testing nr_mmios directly
makes the loop condition permanently true whenever at least one MMIO
region exists.

So, change
  for (j = 0; nr_mmios; j++) {
to
  for (j = 0; j < nr_mmios; j++) {

Fixes: 21a8f8a0eb35 ("irqchip: Add RISC-V incoming MSI controller early driver")
Cc: stable@vger.kernel.org
Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
---
This patch fixes an out-of-bounds access in the RISC-V IMSIC MMIO
resource lookup.
---
 drivers/irqchip/irq-riscv-imsic-state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b8d1bbbf42f7..008dfcf343e5 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -896,7 +896,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 		index = nr_mmios;
 		reloff = i * BIT(global->guest_index_bits) *
 			 IMSIC_MMIO_PAGE_SZ;
-		for (j = 0; nr_mmios; j++) {
+		for (j = 0; j < nr_mmios; j++) {
 			if (reloff < resource_size(&mmios[j])) {
 				index = j;
 				break;

---
base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
change-id: 20260904-nr_mmios-868e369de25b

Best regards,
--  
GUO Ren (XuanTie) <guoren@kernel.org>

