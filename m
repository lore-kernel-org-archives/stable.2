Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222532ED34
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311728; cv=none; b=jz3Len2U6BQlr9HIEo9/8CjYFczquj2FTaCsq/paz6tRPfjAleioqsrOL4Rc1CtQpNPFKHc20yu3XrKqttB7iraQamTiGAUBf+Q0xnkvFCwIeS5g4ydUvPiKqvC7JtdT38N+tmB0n1lcbmlBXWqH3jYOrbsWHQZDjaqcVTxCeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311728; c=relaxed/simple;
	bh=XhR6oTkoKWqIqxVxPcVjY6ziMQAuF1oDMdwXHIeeroc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhh3DVTXd2VnOBEt0hZkKxe804G8bBU+dz1y9L7xA/AwnCUoiyGz2VTcN5atWQaJ+OReWwFScyCsmOhJCVAEBGlIhwPDjlqPwpbkl5q4yW5pQ6h4x9ybDZ//iWK6gtbPSaGpVS005LQBdZPl42XvUIZFJBBupF06b32U3Xr3EdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayvnsapa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayvnsapa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C021F00893;
	Mon,  1 Jun 2026 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311726;
	bh=0og8ay/3mP3D01K0aHSHgRqjzAkle1o5LnrNjGQ2Dxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AyvnsapasQFY08C8bX55wpzFj2BygxQSx+KkBvU3CFxOckIV3JjPbCBI+rQsHBZLV
	 s3hB4POjmXKTHmLTvUhtuTlJOGJUvSmq6CRq+JGf9TuU02aNDuhAqkz675X95Hbd8b
	 0d6tPC3DmQqD59t9ENY9sMfFa7vTqsqKML4u+MV1pLPiIwcfrfPZjSiTwgIGNKY2rg
	 ry2fRPYdUBGtvGvf5ipXgYedh223kDOqV+j+XN02xhZbnR0exL8bSc5XwGN4HZOi96
	 Pb0fGUqHAdOUGxMONO1d8bhaRTb2oQ0X1Hde1viqd/rwDZOBEgQesnXh5yT49qBSAN
	 CqvVUlLnE0llQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] cpufreq: intel_pstate: Add and use hybrid_get_cpu_type()
Date: Mon,  1 Jun 2026 07:02:03 -0400
Message-ID: <20260601110204.439565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052846-jasmine-recess-d8cc@gregkh>
References: <2026052846-jasmine-recess-d8cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 528dde6619677ac6dc26d9dda1e3c9014b4a08c8 ]

Introduce a function for identifying the type of a given CPU in a
hybrid system, called hybrid_get_cpu_type(), and use if for hybrid
scaling factor determination in hwp_get_cpu_scaling().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/1954386.tdWV9SEqCh@rafael.j.wysocki
Stable-dep-of: 0e7c710478b3 ("cpufreq: intel_pstate: Use correct scaling factor on Raptor Lake-E")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eb7fb25dfbefc..6e1a793408dee 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -909,6 +909,11 @@ static struct freq_attr *hwp_cpufreq_attrs[] = {
 	[HWP_CPUFREQ_ATTR_COUNT] = NULL,
 };
 
+static u8 hybrid_get_cpu_type(unsigned int cpu)
+{
+	return cpu_data(cpu).topo.intel_type;
+}
+
 static bool no_cas __ro_after_init;
 
 static struct cpudata *hybrid_max_perf_cpu __read_mostly;
@@ -2299,18 +2304,14 @@ static int knl_get_turbo_pstate(int cpu)
 static int hwp_get_cpu_scaling(int cpu)
 {
 	if (hybrid_scaling_factor) {
-		struct cpuinfo_x86 *c = &cpu_data(cpu);
-		u8 cpu_type = c->topo.intel_type;
-
 		/*
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (cpu_type == INTEL_CPU_TYPE_CORE)
+		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE)
 			return hybrid_scaling_factor;
 
-		if (cpu_type == INTEL_CPU_TYPE_ATOM)
-			return core_get_scaling();
+		return core_get_scaling();
 	}
 
 	/* Use core scaling on non-hybrid systems. */
-- 
2.53.0

