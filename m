Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137236;
	b=TCSdLwwkcZNjkrFgWI35LYNLQSEc4W6hFdfs0ft3V+SAAqAiYSvge8619PwFjyD2mnIF
	 StNFmOY5BDlkXdktUFsC0rxxJx3x9pn2YJhh7/InTdUR7d+MJIDlLIqEZJNBSbg/f3sHt
	 GvyqB/eNVk+W2rICwRtDI60b8ksAFT8nH3anjw8d8HPPPbWgpQEppvA6eKdTCIN/cv6z4
	 ilpRGX/w2cMgCHzoNtNsTmalTvX351cbJ9lOvUk9aRj9CTM4JD5sYTH9YndCNRiSRw/RD
	 vHggPc7GqUppKsLyS/XT1ZCNpzBvCTWVML1ZpcD4pxeiRqv4E/SqFt0Q7EJMoC4HzBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sxnt7oUMW0+LsC7UswLGsHASMXehJdFlGBqwnQyDf7A=;
	b=hhVFUmCSm6wVKdjH0twSIrasqlMycOhCwJq5X2bjyLFxeNSqrsA5H3J7j6SEaNG9wVwN
	 rLJtChkEfS4bya73GIbLir/mc95zi4zBB4lHBHlETPnQy5s5Ca88WrvCUnPOqkqbVdUZS
	 p7IJk41bSvpWTA/NZcD3CTze+ErYe2LRnJXg1ju3c24CGi3zuVzcXX60yInkQV3+w+KUp
	 mhkAiv+AQ/5PL435owuhRC2gTtWooeIxG93c8D72/mr0b/6Bg1DfPON20AuXpZH6dpzD4
	 5FWGgoM8ZZNxuzEJcY87qaqYrWRGiWC8f1H0HUfOS0XqO947NncLpuq5bbdu/0vhxaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CrxCU78e;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B992606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B992606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CrxCU78e
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2D0715A1;
	Sun,  8 Nov 2026 03:27:12 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5ECC3F632;
	Sun,  8 Nov 2026 03:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137235; bh=LBzLVBXDjHjMhLOsV/AIfiarH+okvkKjw5uJm98+1Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrxCU78e4j29DoFK/rSD6zhXvn9pC39gGQ7fKmK81Te/vHO/M0BbBlN1axL/305be
	 NBjkm4O3c8ME/6Hk+WGghf0KKR9P3cujDamQOAhpTUH519x6KsFAM19RBpocfCGUYy
	 w65lVqWAx3Q47JYQd+w9kkJyMOKC6zqSLYT1fkDg=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.6 2/3] ACPI: CPPC: Propagate errors from cross-CPU FFH calls
Date: Sun,  8 Nov 2026 11:26:47 +0000
Message-Id: <20261108112648.2565681-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108112648.2565681-1-christian.loehle@arm.com>
References: <20261108112648.2565681-1-christian.loehle@arm.com>
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

commit 36e96b469da24868f727b4cd168d7cf01cbd163d upstream.

The arm64 and RISC-V CPPC FFH accessors ignore the return value of
smp_call_function_single(). If the target CPU is offline, the call can
return -ENXIO without running the callback. The accessors then consume
callback output which was never initialized and may report success.

CPU offlining leaves the CPU's CPPC sysfs attributes present. On arm64,
the AMU feature mask does not exclude an offline CPU, so a paired counter
read can expose uninitialized stack values through feedback_ctrs. RISC-V
has the same problem in both SBI and CSR reads, and its write paths also
inspect an uninitialized callback status after a failed cross-CPU call.

Return the SMP call error before using callback output. The arm64 single
and paired counter readers already check the helper's return value. For
RISC-V, also check the callback status before copying a read value: an
unsupported CSR sets the error but does not initialize the value.

Fixes: 68c5debcc06d ("arm64: implement CPPC FFH support using AMUs")
Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://patch.msgid.link/20260916162805.1039247-18-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 arch/arm64/kernel/topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5feda5b55d45..a1f9053248df 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -303,9 +303,7 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
 
-	smp_call_function_single(cpu, func, val, 1);
-
-	return 0;
+	return smp_call_function_single(cpu, func, val, 1);
 }
 
 /*
