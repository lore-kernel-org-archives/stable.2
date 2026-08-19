Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4054078D3
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166537; cv=none; b=CVtG48aQz07GpR1taX3eQexGHchg7Ns1QYi6lCcPt3Xeeb0LiDEmXKyMTh2UrRHXYPTjzRmpdFc6bM6YHo0S2QEEAfpsalXJwQw8p0k9Ap/2x8evNAKoEvt2bTEsAxt5KGddDqLI4dsRvL6pzE+Bqq35t/nBU5tH2cSpvVEYuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166537; c=relaxed/simple;
	bh=Djw/N3csbhtn1Ha79p8OFMXYSEIjHbr13J2yf0KlGu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGn2vs1Q4gmwPMGZrsEBDYQepixDXG/uc535BXozKYdhO6QpJPmUasSI5oVXSIe0EggIwgw6JYWOW0nwMI5BL03ibmRNXqFuUh4gQyn3bRNJt+tYjeFGfmX3Mx7RK0LQ5Nancwz7JuxdNhZEjeGcPUzAerOvlJkS8OkB2C3jAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9EiXJiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9EiXJiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED661F00A3D;
	Wed, 19 Aug 2026 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166536;
	bh=0aVeahzdGk7lxwlFXh5ZSVbLQzluw0hBzrP3u0cRqoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9EiXJiZn7xklwpToyHTwdWtGykUpzvohgOH8AdMTEN1xnkTPxOV01YpRKkwpNjiM
	 bOmnykMYh7TfpaOkv+LhmWwlWrOamuY/VZto7SxPyPXbpDMDHmHYmfD/pzBTMGHvHP
	 tsZGVvDEKkFD4EUl8SMHFX6ejdL/Tc3AwjN28VOqezG0A/URmBYNcEvmMOb5r4qNEh
	 K22Q9Y40qkg3D0CQN5K9AHHoJs1VK2wjZHBe05DzdlE4rr0x3rvZjs9LgnsIT0d0A+
	 G6idoNv6XjLJV2G4wrN+mhivS6lGpkIp6HykIOxOhZmDHYyn1rtX9qz8VWmdi2YdXY
	 0DwgZY5WNh0kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] x86/mce: Set CR4.MCE last during init
Date: Wed, 19 Aug 2026 15:08:50 -0400
Message-ID: <20260819190851.563607-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819190851.563607-1-sashal@kernel.org>
References: <2026081738-avert-freebie-72be@gregkh>
 <20260819190851.563607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit cfffcf97997bd35f4a59e035523d1762568bdbad ]

Set the CR4.MCE bit as the last step during init. This brings the MCA
init order closer to what is described in the x86 docs.

x86 docs:
  AMD		Intel
  		MCG_CTL
  MCA_CONFIG	MCG_EXT_CTL
  MCi_CTL	MCi_CTL
  MCG_CTL
  CR4.MCE	CR4.MCE

Current Linux:
  AMD		Intel
  CR4.MCE	CR4.MCE
  MCG_CTL	MCG_CTL
  MCA_CONFIG	MCG_EXT_CTL
  MCi_CTL	MCi_CTL

Updated Linux:
  AMD		Intel
  MCG_CTL	MCG_CTL
  MCA_CONFIG	MCG_EXT_CTL
  MCi_CTL	MCi_CTL
  CR4.MCE	CR4.MCE

The new init flow will match Intel's docs, but there will still be a
mismatch for AMD regarding MCG_CTL. However, there is no known issue with this
ordering, so leave it for now.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com
Stable-dep-of: a213dfaa2596 ("x86/mce: Set up the polling timer before CMCI discovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ba28988c575cf..c95698dd648ac 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1836,8 +1836,6 @@ static void __mcheck_cpu_init_generic(void)
 	bitmap_fill(all_banks, MAX_NR_BANKS);
 	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
 
-	cr4_set_bits(X86_CR4_MCE);
-
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 	if (cap & MCG_CTL_P)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
@@ -2258,6 +2256,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_clear_banks();
 	__mcheck_cpu_check_banks();
 	__mcheck_cpu_setup_timer();
+	cr4_set_bits(X86_CR4_MCE);
 }
 
 /*
@@ -2425,6 +2424,7 @@ static void mce_syscore_resume(void)
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_clear_banks();
+	cr4_set_bits(X86_CR4_MCE);
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2444,6 +2444,7 @@ static void mce_cpu_restart(void *data)
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_clear_banks();
 	__mcheck_cpu_init_timer();
+	cr4_set_bits(X86_CR4_MCE);
 }
 
 /* Reinit MCEs after user configuration changes */
-- 
2.53.0

