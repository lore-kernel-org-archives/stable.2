Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674493;
	b=pshxYCi9E27DqMvN0fgdWm1ZPTZ6mGGo1UbevJnUCpMyGq7p0wau3AcTdORyRqqqaxoI
	 44aIwMI2kmFqegO/smzp+ieyLgc9DS707HQWT/WN9oJcQcVdL+NCoURzVxMI6o+VuSeaI
	 nTTfjEZ87EEg+TOnKWcsAUZ+fBJxwYUWdQMJDkPpNtV7yMKS5LYnYjRNPLQrrfRMxjb0m
	 SwlEe4BCL1rDpHXKa0cxvGp4WwJ6gvxTDvHqVKmQ+v4wsrVYtSQbpQUyYqxl3zphS1kll
	 CXBi6nTquQdLj7K82xXtP3Hsna6vPkoosIUD44PMKEIevDvh06EZdHt3ezgNaARm+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qjmg1SjTs3atT2nn9WnBytEIpIW9LchwdehIjStPp4Y=;
	b=N4apCWpM09mQgb6M08yDaI0NZ8+2Jpu9XL7Tc6B52P6QhWGDnAFgmfWYyVutvIDb0jkg
	 E3sd18+NDq3699M6GIH58xs6u/Twdh9bGaU6UxT8NMkAq1Wzaew1z2K8DbueBkJIeR762
	 BGlAtWAgaw43VhG/I+9CYPHnOhwFZjEXL85dBhGWsc+NwMq1nGl2IrahZMa7TnaTLy1nW
	 oyK3Z8vrrgTDbChog9TVqivlmG5TuL4tEEuMThqMK0Z14eMwqTVhdCU7MOBPIvUyeVNb9
	 3gnD6bpPhAlTylUgOGfbGrsviJZJzIxU/V+yKcsDOlRLVgRHNYRKGz7n36iW9dnjXJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dtntFBIf;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0A606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 02:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F0A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dtntFBIf
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so3687426c88.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674492; x=1794279292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjmg1SjTs3atT2nn9WnBytEIpIW9LchwdehIjStPp4Y=;
        b=dtntFBIf+tvdIzW2rQriPPXnejCyrXyTE40uuzXpf0MErWx+C5J2xWWCI5kBNtwFt8
         6wAom3dDcPOLDG5jfdAlCp/1c0kv5RbrIvpDtMXFlzjEf2niDYxT5uiGgpA/MLZaPuIV
         4ySvi6uNzQGHEV2xi0ed2ahn9f3vUYSZ7ViIs3TDKBQM5XasEVbWcQIY/ZUFsDgrYmJn
         oYw/NO20JgDPK3B5M27f5ZLNiS21Ui3qwS68OENF0vhyOazEo/Do/kSO18J6PFhHVrzT
         UMbawFaqlExBCydfH1uPsIWGO2ycR3OVLl1kA9wGf1t73e7EFSxyRdD+P53zTdtnrf2E
         taAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674492; x=1794279292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjmg1SjTs3atT2nn9WnBytEIpIW9LchwdehIjStPp4Y=;
        b=dEyF/nvgeaZg6Ufs2xy5a80TLiBp3tlQ1uJSS0ib5B086JMUMMhAVCk5c/78i9oRXu
         AzusLSs2cx62hjnr5RJC6DzmA2XQEM1/reGTuxg0L/I6wbIbeZ+mjbQRgcAn/ZkjrnIm
         8TkH08iMOzdbmE6bysg8JU1xljk3Gfs9wrEvgGIriYA0tRb8SluhByhtjLmmxyl2eYKN
         3nC8Aap8Ghqz0N+BWPXbITyPwvqhHxI3+ucZsKQBm4LzwMRgI5AlUaaZas30F6kCuAU3
         Kx+V1DSxCSXVXeSRrFAgKvMHxDrC22kTwY0zD0ZNYfFnfS9EX3QkMxcc60gFiNn2TGUP
         DYmQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3n5D9j/Pis/pGeYDgAzKmf/MdJM+f7niuoNoxqDs6EWlDJfEd9t5m4o+FFKUOgY+iA0TLKK4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5A7Q4cpxgLc+KmtP5LVvXSPDOpqaCYIF9yhJe070h/0D3ZlND
	5hZaXifNeZ3ENWE+bf8rQlKT/DHZDGdIG3QBhcdw4ESQNpSJ29UlDQdlAHOk/g==
X-Gm-Gg: AYBFou0bW7H9AVA20M74o6fMAyddkvRiCBU2gkDnTU299m8Uaujv9+kwky97mgf3wnJ
	G7dylCVgeCrMZsZd09Mev8Y/R6c0eblLsPpwENRnIAYutYpQGYbM6RmReNqJaVcu1GNZFiwBEAj
	L9mMq+ruv/IAM5hz8PQMejFF+QUcS/45GsHXbRFPGcVYH1BFLPiEuLqEtQ8g7ywZSPgZgTuY0lI
	BoR/eD8WsWaso2vJnWKnXKDCNNPxMWYgdutCzB5lT8GEqWkZT3EkwBg5wpSw6lwiMAYLj1kSOKp
	IdGNS1SCXVpPZWv/Fm3m3KQNEGA44NJPCPgPnjsAOFCFDoiVap5cEWQRs2Zs1/9XW8mylaTHvJN
	MWe6T6dEelAL3843x5oDwr9X7e47fon0AqtP42egbhGAWuAiD/pvRPwA0LUeqK2Y939NQp9HXgA
	KB3ZzHqNP1MteDBk1hZs/pFwjvWXcPcwg9TEXCWMBf1Hym3XIo+VOTtWNMe2IHNXdAb6ucYrHp6
	70q/eNBlZ0bjIsse+K08f8dd5M6uEIJU7/M80FRjAXqA0rUx41CIbo60k/VAiN3W7/n35SVb2oP
	s7+XqiP03e/qL/3RSPLv7ceayOcuiIyNOg==
X-Received: by 2002:a05:7022:5f02:b0:19a:51da:f54f with SMTP id a92af1059eb24-1ac5d88c584mr16916727c88.14.1793674492234;
        Mon, 02 Nov 2026 18:54:52 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm49882356c88.6.2026.11.02.18.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:54:51 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org,
	Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: [PATCH] powerpc/code-patching: Flush the patch area TLB entry locally
Date: Tue,  3 Nov 2026 08:24:43 +0530
Message-Id: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

patching functions like patch_mem() and patch_instructions(), maps the
target page at the per-cpu text_poke_area, write it, clear the PTE and
then flushes the tlb using flush_tlb_kernel_range(), with interrupts
disabled. flush_tlb_kernel_range() on SMP nohash (e500) does an IPI
based TLB invalidation i.e -

	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);

...which will wait for other CPUs but with interrupts off. This can be
caught by lockdep with the following warning:

  WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
  CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
  Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
  Call Trace:
  [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
  [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
  [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
  [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
  [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
  ...
  [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
  [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
  ...
  hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318

Josef confirmed that this was causing a hang (deadlock):
    I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
    CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
    fine 9 of 9 times with jump labels off. The hang comes while static
    keys are patched and modules are loaded, nothing is printed and the
    watchdog resets the board. OpenWrt keeps jump labels off on these
    boards for now.

...which is possible if both cpus are doing similar operations with interrupts
off and doing TLB invalidation using IPI.

Broadcast TLB invalidation is not needed here since text_poke_area is
a per-cpu area. It is mapped and unmapped with interrupts disabled by
it's own cpu. The only reason I think, if we would need a broadcast tlb
invalidate is, when we want to prevent a stray or malicious write to
this cpu text_poke_area by another CPU. This generally gets solved with
temporary-mm path like how Radix and even x86 implements. However, booke
doesn't implement that, so for now let's ensure we use local tlb
flushing for correctness.

Fixes: 49e3d8ea6248 ("powerpc/fsl_booke: Enable STRICT_KERNEL_RWX")
Cc: stable@vger.kernel.org
Reported-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Closes: https://lore.kernel.org/all/20261026195644.16384-1-pepe.schlehofer@gmail.com/
Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/lib/code-patching.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 44ff9f684bef..6351342fa5c3 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
 	return err;
 }

+/*
+ * The patch area is per-CPU and only used by its own CPU, with IRQs
+ * disabled, so only the local TLB can hold an entry for it.
+ *
+ * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
+ * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
+ * flush just the local kernel (PID 0) entry.
+ * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
+ */
+static void flush_patch_area(unsigned long addr)
+{
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	else
+		local_flush_tlb_page(NULL, addr);
+}
+
 static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
 {
 	int err;
@@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
 	err = __patch_mem(addr, val, patch_addr, is_dword);

 	pte_clear(&init_mm, text_poke_addr, pte);
-	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+	flush_patch_area(text_poke_addr);

 	return err;
 }
@@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
 	err = __patch_instructions(patch_addr, code, len, repeat_instr);

 	pte_clear(&init_mm, text_poke_addr, pte);
-	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+	flush_patch_area(text_poke_addr);

 	return err;
 }
--
2.39.5

