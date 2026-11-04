Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807888;
	b=QYhEXHpPRj382VZ7HDAKllx8GP7Rb9ch3360VmlNp7EdEdE4L+s74QgYOAbRqE/fSFG6
	 wje9Z7OpycI7DMYJdQb4CBil3eVe5F8cWDB8/iD9bnvokYlUVYSr1gd2XjzPAqx0jA1ja
	 9vyrQMTse8onv5+8dlCbhGf2PDuTGE4RM0gYAr/jI54hAVSFztotiN5wPcm7ILmCM0vqm
	 9OH9QK3qqWsQi/aMIw1ntu5nPiv/eSxv8K2KMOXFqz+1LgOmSxqDg/4LOrBPdNyYYl472
	 638IGi4izD6zM204FkpJ8lgbjLnFDbLREdvO0dgY2XOpjJbZcvzyEQgW+bJkT/yybEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807888;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CobIDIgBpZYtO1bIvi1qP1oCrjRP4ucdUu/eXRQ04v4=;
	b=o3UXxaHLEW32h8YVmTOFz/vjduV1duGuUdRjxTWcNPMTl8w6eX2Me12h2h2ZfTb15YGd
	 236PboEs/a5tja7gAToCMZDzlWSCSKyxvRTxokHjoEM1wqZfkgiCXcGUBn60Z2kkGfMJM
	 judL/w4/xuVP+GdYTMZfTeDdrq9ijdm00kRB633pUlBFcEOTHzghz503YBCvnuTiSKmEA
	 prTpGWWlCYQzlQlvszPtaGzZws0kFxjBVAXoqfiFbdx2xlrs08FIS5VkjCJROaZ/cTvIh
	 uIekQYPnv0pxIciFKIg32W+lhAfFaJntMZmixha+2KAL4NXx+ztlfkNzIQB/wYTohMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTlnoSDv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E3606A9DD
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTlnoSDv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3FF1F0093A;
	Wed,  4 Nov 2026 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807887;
	bh=CobIDIgBpZYtO1bIvi1qP1oCrjRP4ucdUu/eXRQ04v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTlnoSDv9hq+BvBKJxNVPR3KVb8hqFKYrthJ07HnyLHfcsLyyngxdKxR/lwjWiyZm
	 5vU1e6cVVJ3mufxebhLX6gIfB9TWLBT7NejV2PoaqyTxiH/YT5SvLe7tYzJBIr/FpU
	 Oq9ZJd5AFFw7iNpzuvpn5eBM0yA699m11tkP8duTQgQiCXvga9Ex+wv5PzKCgyOVSh
	 9ITKQempBfw2WDCRsXNNkZ2BZtMuYdm1ssy0IKLSTNSr2T9YMnLRuVyah3aAkB44mR
	 TgE6577v5EJ7cYvyVer/uYypEsdo8BF2yZv6EOoA8yC/WUEHEtzxvXizKVJT3oBLax
	 SVTwhBZ1q9efQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] s390/cpum_cf: Check session mask before cpu offline
Date: Wed,  4 Nov 2026 10:58:05 -0500
Message-ID: <20261104155732.3921147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110414-reliable-bonded-7e4b@gregkh>
References: <2026110414-reliable-bonded-7e4b@gregkh>
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

From: Sumanth Korikkar <sumanthk@linux.ibm.com>

[ Upstream commit 99a95985dfc85eecad97f0991a2401d2fcef294c ]

cfset_offline_cpu() stops counter sets for every active session without
checking whether the outgoing cpu belongs to the session mask.

For example, run an hwctr session on cpu0 and a cpu bound perf event on
cpu1:

lshwc -l 9999 -i 5 0:b
perf stat -C 1 -e cpum_cf/CPU_CYCLES/ sleep 120
chcpu -d 1
chcpu -e 1

Although the hwctr session does not include cpu1, cfset_offline_cpu()
decrements its counter set reference count. The subsequent perf teardown
decrements it again, causing it to underflow.

The perf event keeps the percpu state alive across hotplug. When cpu1
comes online, the hwctr session is started there and the reference count
moves from -1 to 0. Stopping the hwctr session then decrements it to -1
again, so the zero triggered counter set disable path is skipped.

Check the session mask before stopping counter sets on the outgoing cpu.
This prevents the unmatched decrement and the resulting reference count
underflow.

Fixes: a029a4eab39e ("s390/cpumf: Allow concurrent access for CPU Measurement Counter Facility")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
[ sashal: adapted the per-session CPU-mask check to the existing if condition for the single global cfset_request. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index d2a2a18b55808..f7b270d2404cc 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1223,7 +1223,8 @@ int cfset_offline_cpu(unsigned int cpu)
 	struct cfset_call_on_cpu_parm p;
 
 	mutex_lock(&cfset_ctrset_mutex);
-	if (cfset_request.ctrset) {
+	if (cfset_request.ctrset &&
+	    cpumask_test_cpu(cpu, &cfset_request.mask)) {
 		p.sets = cfset_request.ctrset;
 		cfset_ioctl_off(&p);
 		cpumask_clear_cpu(cpu, &cfset_request.mask);
-- 
2.53.0

