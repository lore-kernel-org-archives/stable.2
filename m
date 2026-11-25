Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623895;
	b=wYguBg46e9ITqUekgY3mRBvAIyTujNnLvIQpmmym7fLsKLEKJXPR5tPFJ63LPLZ85L4o
	 xn8bl1BCUL29r80mHqJGjohyxsZlLTqBbtuqWfcZo3WEKWb5UaQnj2rDpX5VKIed7DNl2
	 iTsM5HCFF2pKGMmV0RbTC/MxwH5vxzflGnopQSOBOzztK6CjTTFpORKz2+5sifNJFdtex
	 0USyfXO8oThRY7fXY/lTn+GPBYlwMUAnizkf2+v0k1J6QGoGWrdl+8ot2RtmAQHzr04+9
	 cTFC/F8CgpZ6MWptDt+WATxNRR1FedIh5MI8rq069m2ainKxaZlyTxIracAj2R8O9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZIIenobj4d7WEdDkV7f2PJUMRE7z6TUmcc/EBjd5338=;
	b=EW9qsJTHS2qELx6zsqcpcqTgkkMignRPJJmJTEy76x5Pd0M2wkLFiuAyTXIPYKQ7h6/g
	 1+YodgcBoYjoqKzicSULXrMnHqiWp1oE8GqcggkKc9k2mqVk+SR917TFST6Ax635RwGJC
	 8Tk1w30WU1KsfVnjh4eFiqjYCRJ9Tl2EpL/2Q5qy1ppoJOD4yWl1lExL6sqLK3POgTCzZ
	 j61faO85wIQH/lAr6rL9R+Q/yMsAoJz86e0UR5/63gYW3HJVdLgKdjVRWl10RFDqIV8MS
	 J3X5QPO2fkndtgHebfmAa2kcf8zobvIPyKUr3Rk13Yi5eCJdAuQltbm/5RRvt7FQM6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FueaRxE7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF2A606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FueaRxE7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04BC1F000C4;
	Wed, 25 Nov 2026 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623894;
	bh=ZIIenobj4d7WEdDkV7f2PJUMRE7z6TUmcc/EBjd5338=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FueaRxE7zjYXDHDTNOeu60kYS0pIcWOZy5Ph2OXanrVTdX0P7uYaDo7CUZocThJwY
	 FtQ6wZVHO3UJkVK2pzeJIaoiHqcerk+/+ddYxtEWTbFnmM9YQeua+OCEmCe22hu1zW
	 tOK07Imv7EnLn6haLWTGcY+vnBc/H+T3hztpwVxwJxPsGO+voDBXHXGZDYZbpxH1Wd
	 fIqRbwA4bk7KlgQ11DNcxUEOqbNAaYIFw0/NETZHOuAXS8HSZqMa15DXosGKTrvmq7
	 VAGnVEzp5Ue4A9uV7B76JG/fC6YVxpW8nf7JMPhwa2lhh0AV/y0twdN4X5w7mXoGH4
	 XzDSlslwbdSYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	Doug Smythies <dsmythies@telus.net>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] cpufreq: intel_pstate: Clear last written P-state value on suspend
Date: Wed, 25 Nov 2026 11:24:51 -0500
Message-ID: <20261125162445.772981-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125162445.772981-1-sashal@kernel.org>
References: <2026112549-wobble-pastor-7c26@gregkh>
 <20261125162445.772981-1-sashal@kernel.org>
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

[ Upstream commit 02e77af824d5be3a94fdd885835a352f90d24c5c ]

Preserving cpu->pstate.current_pstate across system suspend-resume
cycles, when running in the passive mode with HWP disabled, is a mistake
because its value from before system suspend may become stale after the
subsequent system resume and in some cases it prevents MSR_IA32_PERF_CTL
from being updated properly after system resume [1].

Address this by clearing cpu->pstate.current_pstate after the governor
has been stopped during system suspend.

Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online callbacks")
Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org> # 342d3a73c5db cpufreq: Force passing target frequency to driver during resume
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/14150222.uLZWGnKmhe@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fd8c1192c57dd..e5add2d2f17ac 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2732,10 +2732,11 @@ static int intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
 	intel_pstate_suspend(policy);
 
 	if (hwp_active) {
-		struct cpudata *cpu = all_cpu_data[policy->cpu];
 		u64 value = READ_ONCE(cpu->hwp_req_cached);
 
 		/*
@@ -2746,6 +2747,17 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 		value &= ~HWP_DESIRED_PERF(~0L);
 		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
+	} else {
+		/*
+		 * Invalidate the cached P-state value that may be stale when
+		 * the governor is started again during resume and may prevent
+		 * MSR_IA32_PERF_CTL from being updated.
+		 *
+		 * This does not require synchronization because the core
+		 * prevents frequency updates for suspended policies from
+		 * occurring.
+		 */
+		cpu->pstate.current_pstate = 0;
 	}
 
 	return 0;
-- 
2.53.0

