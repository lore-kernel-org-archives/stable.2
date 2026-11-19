Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113272;
	b=yh14kscar+P8L6fISXn/zm8OaI4lSwSKLckGts/+kMtyl1BuOudAmQ9BiUNgD8NuPIG8
	 eJOHp79/8/YzRTUkHmd1b3dDhZe7As+fZWb9V06RLuzCobjVMIkatKjFs6nAeFp6cynCo
	 PulI+SJZ2DMfuMtpP5NkuvnpN87/WNbdmCAIv+XLVHGXhXLzripOcFgYCpCXTiZaJHipj
	 z/2ehTbCP0SX4cTevmMWhweBuCGXcrFzZPPg1E42J69MUZrl7tYlbbPlDMZDY2WjQG7/z
	 KWLIuViateXP3RJDcWZT0pkHclEFRUalUhWb1lyqD5XXNwELdKNiPqYnNaCx/oDG3Og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113272;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9C0R1zG9R3KGeBNZdWacOw6zD9W9DL6aPU4uR+4N8Oc=;
	b=ZJQy09AI9o35IkYMQ953WEJC0b8V2vEl3kSUjXvsM8LYvI6oghfErzmFPsl6Bd0iL4jo
	 bIZvNZx5B+hy0ETJU9u9RZUXLp5VoDdKwmvp//ix+EESEg5LNeJDPkKxxdC5CYdfkrB0D
	 +ARff7fFTD3WcWKvlODyQJBs5v+s0Sdh52SJS6/9a8WkbkG8aqVA2JIJfYtTT4h+KJGEN
	 l63U2ayS0iyWFszCJLf+zRqPAPLU8Wg10yQy4TcVOvueeH5HCgTeQYfkgGwMsKN5dMJPD
	 OUGDdmV/9HUUHKOMb6O4+5ySenmO7ZD4G5ArkWmBBT2JWIaqcmoUQyieR9OQrKy4bxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeKbqjo1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF070606A32A;
	Thu, 19 Nov 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeKbqjo1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795113271;
	b=XWt8v+6UjnYlLcFwOzmkPdub1Rp/BmP3hVsUo3fSBprL2rs8H2/14Gqg46aBUwcxKA0/
	 eIOOcbJ7Nc7TjqETK9muR6hNHm2poqaDjTCzBQQgCR1jP4DNI+X9+CCacUBqKB3VOidRk
	 4SbQh16rRVJGx1HKnXp0lO4h4+233XGqjZhuhRc9Kv18amdkD1IFr4b2RVo1TsG56N/Dp
	 xKwSLqVD88vXLc2mXjfqB4fniNgUvgGx9Un+PxjrCGisE2fV9lJac6Yuv6ZP1WHJ4+3N9
	 /XRJU3JRk2PzYD91OtTg1K3lyLGwDseg/GHYhQKCEgUDb7CH5sGuy2Rg5HpeWwPi3OQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113271;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9C0R1zG9R3KGeBNZdWacOw6zD9W9DL6aPU4uR+4N8Oc=;
	b=qd9+Wf3wK+tvjaI1pabwXToEYf67gA8vN3BfPbXbG6L6Oe8Tnel+5KjC5K4TECDd4gol
	 x3W+S/hf5NdKygqyJzGZb8GDaxS5LZEOVGPYNK0S9vjWvDis4XKTQGrm1gHOED0Uxbe7F
	 KdKDNOz5gxsxF9j4mu8sPn0x+OcfOgRuNgcZ9cpHSuGhynJG+TQFlCysP5cDNYOiBjopH
	 oH+Ydp4AXEmBClNgXjINz+V7Mw6SinzuZdz+ti7ipcIyFAYKCn1m/ccsvh6T6mPe+EFMZ
	 nTdh3YTxa8DXwFmHbuBllDyv84gCop527JxdhotUiX2wZSLgkuc1iiIjcCNhuf6pTpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 027571F000C5;
	Thu, 19 Nov 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113271;
	bh=9C0R1zG9R3KGeBNZdWacOw6zD9W9DL6aPU4uR+4N8Oc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OeKbqjo14KQTdhGfXYFzGTia79SIsOV4t2K7Zix/tV3vToEwpNNAsD1eWyI9Ts8Zn
	 VcJLC7qj8y0IV0DNIf/ZzFTyiFqOVhNQTs68CkvrsP2ACQE/BK6yYQlfMEgB9AkTqt
	 r+Ak5/PAXPcskaWYLU3ss/lJSL17aPEbJhiHZ6d66XAIiBWmizmMqOO8rK8qdDFVWo
	 mVQ8SafchbqOdVkE5Qv74UemaQ8kNaXtYpGmmBk3yPx/B3k6AWOgfh1Q8/rjpEXIR3
	 26zPWKo4FySMSzdAeuzOMFOWdbrvFZrKRHYxhLw9aRDQjD09t55NQOpG07DImvRYWo
	 lMNdGBkzoj84Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 88EDB4B3C4;
	Thu, 19 Nov 2026 18:34:30 +0000 (UTC)
From: Ahmed Abdelfattah via B4 Relay <devnull+me.ahmedabdelfattah.dev@kernel.org>
Date: Thu, 19 Nov 2026 20:34:29 +0200
Subject: [PATCH] x86/mce/intel: Skip storm tracking on CPUs without CMCI
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
Message-Id: <20261119-x86-mce-storm-no-cmci-v1-1-bc593e90abaf@ahmedabdelfattah.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrm0yJfyIVzEspBSsycyYKRASw
 t0ddfkt3jvAJKkY3IoDkmxqGkMGXQrg5yPMgjpmQ+nKhog63K8Neha0JSaPISJ7VhTnuqGitq2
 4hty+k0y6/773/m9bh5fw8p3BeX4AXuIeqHkAAAA=
X-Change-ID: 20261119-x86-mce-storm-no-cmci-e009b41774c5
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795113270; l=4058;
 i=me@ahmedabdelfattah.dev; s=20261106; h=from:subject:message-id;
 bh=+IGv9ts+tUHChssTiMksbwVuf1yvkKjDV1B4cog6MXU=;
 b=tvOaJa26EnpVx7ufzXx/144eaBj0/zWiKkd2RXNYvphoyQrC99jznM5mQq7eL2EofhemWNUb+
 IuUVEU2vbY1BVLsAQms74aipDi3B6BN5zWSE7b/sbMa2c8E4oGocn8u
X-Developer-Key: i=me@ahmedabdelfattah.dev; a=ed25519;
 pk=DHEHKU4PddrkJ/iYMZpwyyXsFyIQ6ySjTttKLrt9YqI=
X-Endpoint-Received: by B4 Relay for me@ahmedabdelfattah.dev/20261106 with
 auth_id=1438
X-Original-From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
Reply-To: me@ahmedabdelfattah.dev
Content-Transfer-Encoding: 7bit

From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>

On an Intel CPU without CMCI (MCG_CAP[10] clear) the MCE timer polls
every bank, and machine_check_poll() hands each of them to
mce_track_storm(). That skips a bank only when its poll_only flag is
set, and only cmci_claim_bank() sets the flag, which never runs when
cmci_supported() is false.

So a bank that has a corrected error on five polls in a row is taken
for a CMCI storm, and then:

 - mce_intel_handle_storm() reads and writes IA32_MCi_CTL2, which does
   not exist without CMCI, and both accesses fault ("unchecked MSR
   access error: RDMSR from 0x289" and "WRMSR to 0x289").

 - When the storm subsides, cmci_storm_end() clears the bank's bit in
   mce_poll_banks. On a CPU with CMCI this hands the bank back to the
   interrupt. Without CMCI nothing sets the bit again, so the CPU never
   polls that bank again and later errors in it are not reported.

KVM guests run into this easily, as QEMU does not offer CMCI.

Mark every bank poll_only when CMCI is not supported. Clear the flag
in cmci_claim_bank() when CMCI does get enabled on a bank, so that it
stays right if CMCI is switched on through sysfs after booting with
mce=no_cmci.

Fixes: 1f68ce2a0272 ("x86/mce: Handle Intel threshold interrupt storms")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
---
This showed up in a KVM guest on QEMU, whose vCPUs don't set
MCG_CAP.CMCI_P: five corrected errors in one bank on successive polls
are enough to start a "CMCI storm".

Tested on v7.4-rc3+ (4405c18c95d2) in that guest, with check_interval
set to 1 s and corrected errors injected into bank 9 through QEMU's
monitor. Without the patch the fifth error logs "CPU0 BANK9 CMCI storm
detected" and two unchecked MSR access errors, a read and a write of
0x289. After the storm ends, CPU 0 polls with a mask of
0xfffffffffffffdff, and a sixth error in bank 9 is never logged; it is
still in MC9_STATUS after three polls. With the patch there is no
storm and no MSR error, the mask stays at all ones and the sixth error
is logged by the next poll.

I also ran the CMCI side of the same tests with a QEMU carrying a local
patch that sets CMCI_P and delivers CMCI to the vCPUs: a storm on a
CMCI bank is still detected and ends after 30 quiet polls, and
thresholds, cmci_disabled, check_interval and CPU offline/online behave
the same with and without the patch.

The reset in cmci_claim_bank() is for booting with mce=no_cmci and then
writing 0 to cmci_disabled. I could not exercise it: that write sets
MCi_CTL2.EN on every bank, but APIC_LVTCMCI is only programmed in
intel_init_cmci() at boot, so it stays masked, no CMCI arrives, and the
claimed banks are not polled either. That looks like a separate
problem, which this patch does not change.
---
 arch/x86/kernel/cpu/mce/intel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 4655223ba560..556fb70b9918 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -244,6 +244,7 @@ static void cmci_claim_bank(int bank, u64 val, int bios_zero_thresh, int *bios_w
 
 	/* This CPU successfully set the enable bit. */
 	set_bit(bank, (void *)this_cpu_ptr(&mce_banks_owned));
+	storm->banks[bank].poll_only = false;
 
 	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {
 		pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), bank);
@@ -407,6 +408,13 @@ void intel_init_cmci(void)
 	int banks;
 
 	if (!cmci_supported(&banks)) {
+		struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+		int i;
+
+		/* Without CMCI there is no storm to mitigate. */
+		for (i = 0; i < MAX_NR_BANKS; i++)
+			storm->banks[i].poll_only = true;
+
 		mc_poll_banks = cmci_mc_poll_banks;
 		return;
 	}

---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-x86-mce-storm-no-cmci-e009b41774c5

Best regards,
--  
Ahmed Abdelfattah <me@ahmedabdelfattah.dev>


