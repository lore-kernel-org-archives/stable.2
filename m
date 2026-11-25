Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623893;
	b=bsQ8oHYsQqs0WUauC6XPS+APjGyu3dRQ5NAx/2gmd1r/ZhPw5eeYb+3QzO0Q2H4IF9kJ
	 9xTrYetoBBVcOJIx7IqTd/r2zxRedYYfRmw0ReEZqs2qot54/Pu7hYgiQTDwzJZnKWF2W
	 PvKF0ARZUstCXfFXRfltT1ZfvrMcjzBsH8u8HmhQ9ht9uRUcz0sjsr6ZfQs5zTgQIW8UY
	 PLNEq/mAr7mqvEgQxqotushmVpvmdUPbD4GkHmVnd7Ss1I/0CIBY3jyX8vyhEdBg2lCuN
	 l3J5x4HuCuRkXEWFXyqoZl+qB978Edtil+fRc+LxQgph4C0j41HTiUbL35VTpCK9mwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EKwhLGSrPM6ieQodp5aYXMn7gIDTiCt6yJFgzHne0go=;
	b=jD1YInZEFDPHQkaNRX0mD7NSKVNOhx3VZ2uwRKQBkbqLjN/szbWojsytbxuGuCC/+Kh5
	 Lt4622YxHGbo7lZ7aYo/yvkITYA6i0OBYTcRM0uV3ZfILzz4QbzU9SGMCcka/0sTnm/SO
	 5p4FrmvHJkt+wfzNofL5+8zDmovDf5EAT0MPBFyBYvXOR8ciTRCrAjzpqzHnc6gKKtVFo
	 LlX9ELU/E1RtDbe7vuuKiLLAccR4Ccv6P3ZGipt2NRejQiYMCn1dFqB7BE7Q0ingvetdD
	 rPMLx9ozNeGf5FiVJS8LHOWORTfer9dC6OvErgu6s0tl3EpSNghvdbwcZdBv7kb7NYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVsTINRB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVsTINRB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2561F000C0;
	Wed, 25 Nov 2026 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623893;
	bh=EKwhLGSrPM6ieQodp5aYXMn7gIDTiCt6yJFgzHne0go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVsTINRBSeEHu9Sz+jlVQXMSLCgvyLBVGBLU2+qIHphHPqehWTXc/lGQkCx7XI5y0
	 POg+6GNXN9iWTbbXbDcT+Ebz43xnkYTXCT16xUduAJ6DiTYxx2AySQ/nMiQeKG6xQq
	 IFiMxTb7UY5rfREN4OSnUW4NUwUFtjFnL6fR5NGeHfUlzp37M9u2BwLY7BZhW2qGD1
	 0QOaF5PFjxKQhW5qVumXmEZoC1IBOu2nxKMmBTdUBFfDo6nbt4ANO4ySIVrU37hWGu
	 w7+11oHaHV06iLEhDEDpWdvNIUCs6tiSTYJZW+umahUGKqBOMu6I5WT/lhw4csB7nN
	 wPV/dcWs3tLFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] cpufreq: intel_pstate: Clear HWP desired on suspend/shutdown and offline
Date: Wed, 25 Nov 2026 11:24:50 -0500
Message-ID: <20261125162445.772981-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112549-wobble-pastor-7c26@gregkh>
References: <2026112549-wobble-pastor-7c26@gregkh>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit dbea75fe18f60e364de6d994fc938a24ba249d81 ]

Commit a365ab6b9dfb ("cpufreq: intel_pstate: Implement the
->adjust_perf() callback") caused intel_pstate to use nonzero HWP
desired values in certain usage scenarios, but it did not prevent
them from being leaked into the confugirations in which HWP desired
is expected to be 0.

The failing scenarios are switching the driver from the passive
mode to the active mode and starting a new kernel via kexec() while
intel_pstate is running in the passive mode.

To address this issue, ensure that HWP desired will be cleared on
offline and suspend/shutdown.

Fixes: a365ab6b9dfb ("cpufreq: intel_pstate: Implement the ->adjust_perf() callback")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Tested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 02e77af824d5 ("cpufreq: intel_pstate: Clear last written P-state value on suspend")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 546c582787f21..fd8c1192c57dd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -908,9 +908,16 @@ static void intel_pstate_hwp_offline(struct cpudata *cpu)
 		 */
 		value &= ~GENMASK_ULL(31, 24);
 		value |= HWP_ENERGY_PERF_PREFERENCE(cpu->epp_cached);
-		WRITE_ONCE(cpu->hwp_req_cached, value);
 	}
 
+	/*
+	 * Clear the desired perf field in the cached HWP request value to
+	 * prevent nonzero desired values from being leaked into the active
+	 * mode.
+	 */
+	value &= ~HWP_DESIRED_PERF(~0L);
+	WRITE_ONCE(cpu->hwp_req_cached, value);
+
 	value &= ~GENMASK_ULL(31, 0);
 	min_perf = HWP_LOWEST_PERF(cpu->hwp_cap_cached);
 
@@ -2723,6 +2730,27 @@ static int intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	return intel_pstate_cpu_exit(policy);
 }
 
+static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
+{
+	intel_pstate_suspend(policy);
+
+	if (hwp_active) {
+		struct cpudata *cpu = all_cpu_data[policy->cpu];
+		u64 value = READ_ONCE(cpu->hwp_req_cached);
+
+		/*
+		 * Clear the desired perf field in MSR_HWP_REQUEST in case
+		 * intel_cpufreq_adjust_perf() is in use and the last value
+		 * written by it may not be suitable.
+		 */
+		value &= ~HWP_DESIRED_PERF(~0L);
+		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+		WRITE_ONCE(cpu->hwp_req_cached, value);
+	}
+
+	return 0;
+}
+
 static struct cpufreq_driver intel_cpufreq = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_cpufreq_verify_policy,
@@ -2732,7 +2760,7 @@ static struct cpufreq_driver intel_cpufreq = {
 	.exit		= intel_cpufreq_cpu_exit,
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
-	.suspend	= intel_pstate_suspend,
+	.suspend	= intel_cpufreq_suspend,
 	.resume		= intel_pstate_resume,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
-- 
2.53.0

