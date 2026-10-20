Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792489777;
	b=HIIzUBrH1n++fjgGysmapDHAYq2JKwDQNv5cR3stx7YGgZpUiPULUekAGTN+oWUzcyzz
	 kLOv+W1Y52o0e7ejx9vIjqjFG6aRhKl2EvFjGp48P5/0YrmKHeF83oIjwocQAlfmL27ET
	 D5ywMN0V/0DQPis4x8VIJw65o0nqoCrBrQR7CCByx/iEDfHLLblgfIdggEENiPcYQ0B8z
	 Q4FV8aturpcoeEfznibA7lONrFRKF/QOFf0CktkEmtS4DWcCk0vpfEwtsGFbyEAf3UBr+
	 jhtIQjkYvCtev27ITs1+Rgd3zerJSOTtgIJ3O+uvybAMsS7Xtz6BKnmknabYlNfxHTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489777;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IfSJq1/PyxShuzD0nZHkfoeb7cptaF9xj+oqRRR0cTM=;
	b=j5iShMEzKh5yJ4hpWjhC7OX6Cpt6HAE2YYlHg0gXpq0XXu+KCRItEUH8drfATuHooMxE
	 rr58+LhPqsdSRW1MM1eJeBWWut6ptILdFzmaQPp+8bk5BHAuZCP8YBFKpGDmcdyLY8qKG
	 sSAab+gOqizVTFZlj4ZWPbTi4BEhv4YyF75ttuaLWQlrnPiBoQy8qVgoBm2W0+m0xdW1v
	 W/gK+H94JbOnemzUTPZz7iQV0g9RUb2GFXxpcpq8+AAF4gK9tLp5dPum1kFaKQ9j7zAIc
	 /np25e9+hiV3yQvsq3BNR6Gc07SBWb14ZbMVnd/l73rUOmxizSSAOCHA5FKsp+DOqmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8b88lmI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D54606A321;
	Tue, 20 Oct 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8b88lmI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792489776;
	b=vogI7b1Rb0eslPc3b89rIonYut266P0j11bWq7HbInZ1jgrizPNhoUydp1ofFMEqqDmV
	 iWO7339335j7+REgNBFcDYYDHJKSMuhULYYxoAmIw0OylReazRgHDTvYHdSsPODcLUUuk
	 hr5WuryIn9o6OzaO15UIDCV4lKZn6V3ReiL74WY0nD6POU4EkJx2cEcVDwzIX3q6+VJ+d
	 RWaUrNADSGNxMrca4bYsFBe2iXmqQBsI8cmj0oSFt7phq+5v5uA3EJvX7/Yc2xKUsnZnS
	 NZef8wzWWOfbHel4L0r5cu8YzCUHEm/+CdhUniGDiJwRxnJD+pTXjZkS6tPmaIgjZeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792489776;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IfSJq1/PyxShuzD0nZHkfoeb7cptaF9xj+oqRRR0cTM=;
	b=EjLVH7b9SgSPmmRF1VIUo1Qc19HlNOshJOd1m69DhF5VqS693V7ZOceJpaKVXUBJjJmo
	 BaXV5wVBKpwfVmzudibH+hXgG47OHUKL6M4Liv/3ar+G4BLuNeFAwSaYFcZOVg977KMsw
	 YJ8snbPDOAPPLtzqW+DFlt8sD2weJDnoaj7T/YED9ijD70hyjDWXc6c9n5dcZ9N0Vcgcp
	 WPk+15KB6iiR1Sm0mbDZv0PAYoRTXLU5jtd8vQTDGMLovgY85Pxjkrxx5jN3voXnwp/nf
	 NBgVbELN1WogmDq66iGNyLiO5r3T0+wk7yf4qYpU+H/A5HL6YTKKVjIJhjWF+RTtJiw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ABBCD1F000C4;
	Tue, 20 Oct 2026 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792489776;
	bh=IfSJq1/PyxShuzD0nZHkfoeb7cptaF9xj+oqRRR0cTM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=f8b88lmIFJxvQbVGsi6Xn3LkSymdm6FaCCLPXiwjgZ75TUBbDRAMo/ktfHsuON+e6
	 lMerZ/WwSLltlQVRtEaJlJDHKVokO20Iec4Y6IIyCjljANYXlNy20bwL8/aFreGx4e
	 3VAKMr77TAQujnSaIKRfXCFiqstHVUXVGAYbCR3sPseFEol8OqtN2G9ZMwQQvyPUa7
	 VyQRTbqLdRn23fTai+7ALPemuky9nQg0ZFhF6CV/Xg1N0ncsfw8akRrJJnMBDpBGNy
	 fzaOK3730Y9XqNDQ+eOkQ5/Qr2sdvsSIParVJW57oFfRYnIWVZqThX5yzoQzzOl8im
	 nZFgYCVZYDfzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B452406D4;
	Tue, 20 Oct 2026 09:49:35 +0000 (UTC)
From: Marco Peereboom via B4 Relay <devnull+marco.peereboom.amd.com@kernel.org>
Date: Tue, 20 Oct 2026 15:19:27 +0530
Subject: [PATCH] x86/mm: Use a WB source mapping for early enc/dec when PAT
 has no WP
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-x86-mm-pat-wp-v1-1-a3e604a77e95@amd.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyMD3QoLM93cXN2CxBLd8gJds+RkU0sTgxSLxBQjJaCegqLUtMwKsHn
 RsbW1AKJnoOdfAAAA
X-Change-ID: 20261020-x86-mm-pat-wp-6cc5940d8ad2
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
 stable@vger.kernel.org, Marco Peereboom <marco.peereboom@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792489774; l=5930;
 i=marco.peereboom@amd.com; h=from:subject:message-id;
 bh=PW798LdOY8CgdZ6XlCmQBOUoKatJ/5Tou6dw1/LkBlk=;
 b=iAIrq+qkaMhdNM0BHpr4HNG70miZpVv6nihFLoi0xBaEbFt95ylj34AnmNx5TPtOdRyOlthSp
 2pMeOIVI3kPBEAdmfWV6IbW+9Nt5pmrD1vKX0ex3Oy3hTWBWnboMZ3B
X-Developer-Key: i=marco.peereboom@amd.com; a=ed25519;
 pk=AXq71lLcEgQ4k5+wem4vJwVM7l9WTUkxZZz88KrUcNw=
X-Endpoint-Received: by B4 Relay for marco.peereboom@amd.com/default with
 auth_id=1179
X-Original-From: Marco Peereboom <marco.peereboom@amd.com>
Reply-To: marco.peereboom@amd.com
Content-Transfer-Encoding: 7bit

From: Marco Peereboom <marco.peereboom@amd.com>

__sme_early_enc_dec() maps the source of the in-place copy with
early_memremap_{en,de}crypted_wp(). These helpers return NULL when the
PAT has no WP entry, and the BUG_ON(!src || !dst) then fires.

The PAT has no WP entry when PAT is disabled: with CONFIG_X86_PAT=n,
with the "nopat" boot option, with a CPU that has no PAT, or with a PAT
MSR of 0 from the firmware. The kernel then does not write its own PAT
value. It uses the firmware PAT value or the default WB, WT, UC-, UC
layout. These normally have no WP entry, so the WP cache mode falls
back to UC- and x86_has_pat_wp() returns false.

An SEV, SEV-ES, or SEV-SNP guest in this state stops in start_kernel()
when kvm_smp_prepare_boot_cpu() decrypts the per-CPU data through
sev_map_percpu_data(), __set_percpu_decrypted() and
early_set_memory_decrypted():

  kernel BUG at arch/x86/mm/mem_encrypt_amd.c:124!
  PANIC: early exception 0x06 IP 10:ffffffffa34f7368 error 0
  RIP: 0010:__sme_early_enc_dec+0x78/0x110
  Call Trace:
   ? __set_clr_pte_enc+0x51/0xb0
   ? early_set_memory_enc_dec+0x7c/0x150
   ? kvm_smp_prepare_boot_cpu+0x67/0xb0
   ? start_kernel+0x1ee/0x670

With CONFIG_KVM_GUEST=n, an SEV-ES or SEV-SNP guest hits the same
BUG_ON later in start_kernel(), when init_ghcb() decrypts the GHCB
pages.

Both paths run before the console is registered, so the guest stops
with no output unless earlyprintk or earlycon is enabled. The BUG fires
before trap_init() sets up the exception handlers, so
early_fixup_exception() halts the CPU. The guest does not panic, and
"panic=" does not reboot it.

The WP mapping makes sure that the source leaves no modified cache line
with the old encryption attribute. The copy only reads the source, and
for reads WP and WB are the same: both allocate clean cache lines.
Before the copy, prepare_pte_enc() flushes the whole range through the
old mapping with clflush_cache_range(). Also, the direct map already
maps the same page as WB with the old encryption attribute. So a WB
source mapping adds no new hazard: no modified line with the old
encryption attribute can later overwrite the destination.

The hypervisor can make an SEV guest take the WB path, for example
when it hides the PAT CPUID bit. This adds no exposure, because nothing
writes through the source mapping. Before this change, the hypervisor
could use the same condition only to stop the guest.

Use a WB mapping for the source when x86_has_pat_wp() is false. Keep
the WP mapping when the PAT has a WP entry. That is the Encrypt-in-Place
procedure in APM Volume 2, Section 7.10.8. Also, with WP an accidental
write through the source mapping goes to memory and leaves no modified
cache line. Only the path that hit the BUG_ON changes.

A Kconfig dependency of AMD_MEM_ENCRYPT on X86_PAT is not sufficient.
It does not cover "nopat", a CPU without PAT, or a PAT MSR of 0 from
the firmware. Also, "select X86_PAT" would bypass the dependency of
X86_PAT on MTRR.

Fixes: 7f8b7e7f4ccb ("x86/mm: Add support for early encryption/decryption of memory")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marco Peereboom <marco.peereboom@amd.com>
---
- Tested on tip/master c803a3f00 (2026-10-19) with SEV-SNP guests on
  AMD EPYC 9755 (Turin), QEMU 10.2.2, OVMF edk2-ovmf-20260812
  (OVMF.amdsev.fd). Without the fix, CONFIG_X86_PAT=n and "nopat" hit
  the BUG_ON. With the fix, both boot to user space. CONFIG_X86_PAT=y
  without "nopat" boots with and without the fix, and the PAT is
  unchanged.
- Also tested with plain SEV guests on the same host and kernels. The
  guest reports "SEV: Status: SEV", so the memcpy() branch runs.
  Without the fix, CONFIG_X86_PAT=n and "nopat" hit the BUG_ON. With
  the fix, the guest boots to user space. CONFIG_X86_PAT=y without
  "nopat" boots without the fix.
- Not tested: SEV-ES. With SEV-SNP initialized, this SEV firmware
  rejects SEV-ES guests (AMD-SB-3023): LAUNCH_START fails with
  SEV_RET_UNSUPPORTED. SEV-ES takes the same memcpy() branch as SEV.
- The test host has SME_COHERENT. Tom, please confirm the WB argument
  for CPUs without it.
- Reproduce: boot any SEV-SNP guest kernel with "nopat".
---
 arch/x86/mm/mem_encrypt_amd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2f8c32173..3ba2af176 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -28,6 +28,7 @@
 #include <asm/cacheflush.h>
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
+#include <asm/memtype.h>
 #include <asm/cmdline.h>
 #include <asm/sev.h>
 #include <asm/ia32.h>
@@ -108,10 +109,19 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
 
 		/*
 		 * Create mappings for the current and desired format of
-		 * the memory. Use a write-protected mapping for the source.
+		 * the memory. Use a write-protected mapping for the source
+		 * if the PAT has a WP entry, else a write-back mapping. The
+		 * source is only read, so neither mapping creates modified
+		 * cache lines. Modified lines with the old attribute were
+		 * flushed before this call (see prepare_pte_enc()).
 		 */
-		src = enc ? early_memremap_decrypted_wp(paddr, len) :
-			    early_memremap_encrypted_wp(paddr, len);
+		if (x86_has_pat_wp()) {
+			src = enc ? early_memremap_decrypted_wp(paddr, len) :
+				    early_memremap_encrypted_wp(paddr, len);
+		} else {
+			src = enc ? early_memremap_decrypted(paddr, len) :
+				    early_memremap_encrypted(paddr, len);
+		}
 
 		dst = enc ? early_memremap_encrypted(paddr, len) :
 			    early_memremap_decrypted(paddr, len);

---
base-commit: c803a3f002ec36285d15c462ac3519198207bb3a
change-id: 20261020-x86-mm-pat-wp-6cc5940d8ad2

Best regards,
-- 
Marco Peereboom <marco.peereboom@amd.com>


