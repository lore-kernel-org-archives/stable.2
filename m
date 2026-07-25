Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E239EB7C
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976879; cv=none; b=SHTVO0PRz9JFekleHuF7KCJD+jm6GND0NJrrApPKrb92lcFoVev5r8Da3ZN93t5calExNKN6+sivBAt3Qensg8yW165/ausfGShyv6MKNzXK9wQX4AY1bQlPK5y/l5JogEVgSA552x77yH9bR8CRLtKLtGniSnB2V7uCEIg9Pec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976879; c=relaxed/simple;
	bh=zB3EDSUc6qCPYJDn5dRT0oUaV787FdKXoEM+tqEEDEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD5aAl2OPx5blLSjsFdoBPSE1E66XxCm2bQ3/p1xcWej1PVpDq6eu1s0lZLD9dFrGl/dIyIzwsgun8oY3uo1Xi2FA3ntoh90Fp03UDS7JTxjB4Zc/opjPoc2ZtE+PbknxUxAUbha3mS4sIt0ndtvePcFNsKNrTH0Lz+iwdclxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI5+oOdY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI5+oOdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540381F00A3D;
	Sat, 25 Jul 2026 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976878;
	bh=7GAyvD2ZZx8m1ITsxqJkVSvKkCz7XJcsX/oJrou1Qyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OI5+oOdYuT4L3I5SfLeIbxKWOEfsma8HAeohtURugmQB1gNZFl0dGD23seVoA7Mv0
	 r6eOmFda3cUQjxU2OFJolw57Axj1N2MIWbcODwl1Weg1nFpcfqRAC0AhF9PJAn4A1t
	 r/Ft0tnytwCYb0U2V7h6V9zWpLL73nz7K1oWSfIC2003PUAM6HrAgQobb/Fmnq0Vr2
	 jb2GqbTtwIMgRwvZmTdgdJeM0NJdE3BY5CZCBikgLNtMftCalWscgfyfyVOqxXDq9c
	 shcdKp3heNLAoByHoHe5MclINYBaKfK5/lOBT+quLBHcJQ1ZcfXShHxpQ4aBYp67d1
	 chQBw3ZZogegQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Pratyush Yadav (Google)" <pratyush@kernel.org>,
	stable@kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES
Date: Sat, 25 Jul 2026 06:54:33 -0400
Message-ID: <20260725105433.1853930-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725105433.1853930-1-sashal@kernel.org>
References: <2026072031-lapping-tubby-5b19@gregkh>
 <20260725105433.1853930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

[ Upstream commit 0e39380a7316122e1b00012b3f3cd3e318b3e7d3 ]

When using scratch_scale, the scratch sizes are rounded up to
CMA_MIN_ALIGNMENT_BYTES since they will be released as MIGRATE_CMA. This
is not done when using fixed scratch sizes via command line. This can
result in user specifying a size which is not aligned, and thus kernel
releasing a pageblock that is only partially scratch.

Do the rounding up for both cases in scratch_size_update().

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Cc: stable@kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Link: https://patch.msgid.link/20260519160554.2713361-1-pratyush@kernel.org
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_handover.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 37e6048118e8b7..bd10660db469a2 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -569,20 +569,30 @@ early_param("kho_scratch", kho_parse_scratch_size);
 
 static void __init scratch_size_update(void)
 {
-	phys_addr_t size;
+	/*
+	 * If fixed sizes are not provided via command line, calculate them
+	 * now.
+	 */
+	if (scratch_scale) {
+		phys_addr_t size;
 
-	if (!scratch_scale)
-		return;
+		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
+						   NUMA_NO_NODE);
+		size = size * scratch_scale / 100;
+		scratch_size_lowmem = size;
 
-	size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
-					   NUMA_NO_NODE);
-	size = size * scratch_scale / 100;
-	scratch_size_lowmem = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+						   NUMA_NO_NODE);
+		size = size * scratch_scale / 100 - scratch_size_lowmem;
+		scratch_size_global = size;
+	}
 
-	size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
-					   NUMA_NO_NODE);
-	size = size * scratch_scale / 100 - scratch_size_lowmem;
-	scratch_size_global = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+	/*
+	 * Scratch areas are released as MIGRATE_CMA. Round them up to the right
+	 * size.
+	 */
+	scratch_size_lowmem = round_up(scratch_size_lowmem, CMA_MIN_ALIGNMENT_BYTES);
+	scratch_size_global = round_up(scratch_size_global, CMA_MIN_ALIGNMENT_BYTES);
 }
 
 static phys_addr_t __init scratch_size_node(int nid)
-- 
2.53.0

