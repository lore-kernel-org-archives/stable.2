Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B03224AF2;
	Tue,  6 Oct 2026 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246961; cv=none; b=kqiwPtyNCeqV4VAT6sjACydoR9WMuDRMvL9UE+FY9EmkXDDBKKTdMTaOtoPMZiPneZ8umN53YwTln/GdB4LAZT8TS5HDo1B9ZQR8ft+MELhhkvE01VLflsoUx8Z0QrU3MumjR7xkPYAinToY32zGvvZVhmp9O7urneUnXuzg9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246961; c=relaxed/simple;
	bh=sovAdjmYwAdtERjn39xMbEnLkhTGEG+s/wYQiGGWIL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gv6PN7PSDdYSZMuU3TLYMr+XmS+Wa/hCzoamJbTstpvqoKHMLytggqSxqmlEufQSUPUA39aNnkHmsAO5AoEyqrmCNgS32HL4WH0ByrRjLPYnNo31CSka+Fr1rcEjsOY0D31B0n/xJyn3/bcMwLWvyNVqorofhtc68dBQvxaRAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q33qdWeg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q33qdWeg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8812C4AF60;
	Tue,  6 Oct 2026 00:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791246960;
	bh=sovAdjmYwAdtERjn39xMbEnLkhTGEG+s/wYQiGGWIL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q33qdWegiow0Rch234hRz64CQfQok78pbR6ZYQr482dOISw9uFB2h2tSmaOiZ+qSa
	 gBsvntFJcMSqZjk4bAHXbuanRz0W1vLzBMW6tJzpUw/pGl9f//vr/IOB1bLL2dMK92
	 pU72Z9MYiVyROJh8JUrUdhHxyapk9bhMVCpfQ92NitYtL6dG3OVDPVajEz5VOA89j7
	 A1yRdyXmzmVvXqHhQ3oPo4ggSKMqByjf0xtJ/ZlOLIETO5KtVDFa5whwIbopl2cZQx
	 0jCbIdXXyZ9YJ8tNcjtNcTBHFWdzBxszwj4a4RO5MQv0GCXGm7FKlKD//g6e82R3ls
	 oMVbZWamXtYVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6444CA5FF0;
	Tue,  6 Oct 2026 00:36:00 +0000 (UTC)
From: Gleb Pesin via B4 Relay <devnull+dormancygrace.gmail.com@kernel.org>
Date: Tue, 06 Oct 2026 03:35:54 +0300
Subject: [PATCH 1/3] riscv: vector: Check the xtheadvector status field in
 riscv_v_is_on()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-riscv-xtheadvector-vs-v1-1-b00e5abc9f7a@gmail.com>
References: <20261006-riscv-xtheadvector-vs-v1-0-b00e5abc9f7a@gmail.com>
In-Reply-To: <20261006-riscv-xtheadvector-vs-v1-0-b00e5abc9f7a@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Chiu <tchiu@tenstorrent.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, stable@vger.kernel.org, 
 Gleb Pesin <dormancygrace@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791246959; l=1590;
 i=dormancygrace@gmail.com; s=20261006; h=from:subject:message-id;
 bh=WbIFXRUyFkHtN9RwI0mQ1+iF69lCdC2VEx0eUHFoGCs=;
 b=yk3lp8q7evGbvckSl50Aw/aQCB+qoIGwkGRubmwV8cu24M8wRDDTPR6PMBtV/kgRrOrxTWTlZ
 wq/OYhlnzB/CkuJfbWiF4GDTJnpSObYye5a7UL4gDbNaclA3nn4y9Wf
X-Developer-Key: i=dormancygrace@gmail.com; a=ed25519;
 pk=Ha8pk6XE0bhPh/mNtu1MKWgYqiX+CxZdhLyDR1rgD/M=
X-Endpoint-Received: by B4 Relay for dormancygrace@gmail.com/20261006 with
 auth_id=1121
X-Original-From: Gleb Pesin <dormancygrace@gmail.com>
Reply-To: dormancygrace@gmail.com

From: Gleb Pesin <dormancygrace@gmail.com>

riscv_v_is_on() tests only the standard sstatus.VS field. Since commit
d863910eabaf ("riscv: vector: Support xtheadvector save/restore"),
riscv_v_enable() and riscv_v_disable() set and clear SR_VS_THEAD instead
on cores with xtheadvector, so riscv_v_is_on() returns false there even
while the vector unit is enabled.

__switch_to_vector() relies on riscv_v_is_on() to recognise a task that
is switched out inside a preemptible kernel-mode vector section. On
xtheadvector cores that check never succeeds: the outgoing task neither
disables the vector unit nor sets RISCV_PREEMPT_V_IN_SCHEDULE, and
riscv_v_enable() is skipped when the task is switched back in.

Test the status field that the running core actually uses.

Fixes: d863910eabaf ("riscv: vector: Support xtheadvector save/restore")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gleb Pesin <dormancygrace@gmail.com>
---
 arch/riscv/include/asm/vector.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index fffe72a77..910313dd0 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -128,7 +128,9 @@ static __always_inline void riscv_v_disable(void)
 
 static __always_inline bool riscv_v_is_on(void)
 {
-	return !!(csr_read(CSR_SSTATUS) & SR_VS);
+	unsigned long mask = has_xtheadvector() ? SR_VS_THEAD : SR_VS;
+
+	return !!(csr_read(CSR_SSTATUS) & mask);
 }
 
 static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)

-- 
2.53.0


