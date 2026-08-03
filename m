Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A2423E81;
	Mon,  3 Aug 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779585; cv=pass; b=snKu0dUi4BEOPA1OsjBT94hElCEFO7Ayt3cwCMPTXa4XfLpkdvoiUo55sxiNBpnEUYQZz9D3qDyfdnRtPALIy7e0MRrPsuta8IAIvRKhsJsd6BiZTv2j8fb5f9tj8x6bHYBvErDUTuLJPA/tsDg4btH90muPVfLIiMgYxFokuIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779585; c=relaxed/simple;
	bh=nw6Hg7YLELQ9BdIxMV3qE+di7YybAX0C91Rr1B4Lha0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6oiAL1N+IJ9lCiYd3xpSV9GH1pl69fTJpkTu3z/2ehaJB0PI+0VvPvh5sc9gti97FCUE+cx1UtLtknDtZaZphSTeFunrTEdTgiwq3lQOtmsy9mehskY9WugYx5FjL7iSts9tbSvNQecUIl8lsgYCODbJjp5MI7kM5Lffux8N9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=l+OTMB6r; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="l+OTMB6r"
ARC-Seal: i=1; a=rsa-sha256; t=1785779572; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=A/bM7nm5zYyHs7a/28X1Yczn6mBnYnFq8tshaNnY3QlDx796KAslw4KJUXkY0mRmT13g/Ov5nEN3mM/p0nVjlQBs+58dPo9Ff4At8aH3gfm1kB7oz3+6XUM0H8PS/5Kpl1wc3Lq9ahFQN+JUKjvn+dzXmB0EkdgCcY0KdCo+tzw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785779572; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EVG1GxC4aa6YBkLqzvOOLf4wW5wZ9yRHp3Zmvrwa79U=; 
	b=FBNG443fppOQ51iUoBX7wNqg11cksbd7SQ3Brl3G60IbLctDDs3cmWCyehjcQACFptUDkx1pt4Lzw7VrdXwSWEhtxojA4/S7kz35o/AU4ZAYEyJOlBcRuEFAezB4ZeoVyA2KBELRGFuzVPkoZNQbZAOgl76K9WuRUjTdaBYLRLY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785779572;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EVG1GxC4aa6YBkLqzvOOLf4wW5wZ9yRHp3Zmvrwa79U=;
	b=l+OTMB6rEhU36iM7FvBO8mcQ/kF95lEQCHtLzNf++ROlUtpA3SecYDuM75KWVe0s
	1ouJJnzSSRiOaaSfzIipDdmdwnuMlBX0sJDyhPb85M0vEUSomJ9Q2ziNDqPEOKjjwlA
	jo+0Vgky1jjyVSz2HzQuDHrJvca8oiTwFNBN28DY=
Received: by mx.zoho.eu with SMTPS id 1785779569212974.6282702602255;
	Mon, 3 Aug 2026 19:52:49 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] cpupower: zero the topology array to avoid uninitialized reads
Date: Mon,  3 Aug 2026 17:52:07 +0000
Message-ID: <20260803175215.117518-2-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803175215.117518-1-ali@iusegentoo.com>
References: <20260803175215.117518-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

get_cpu_topology() allocates core_info with malloc() and then fills it in
per CPU. Three paths leave core_cpu_list untouched: a failed
physical_package_id read, a failed core_id read, and a core_cpus_list read
that comes back empty, which only prints a warning.

The array is then sorted with __compare_core_cpu_list(), which passes
core_cpu_list to strcmp(). For the entries above that buffer still holds
whatever malloc() returned, so strcmp() reads uninitialized memory, and if
the buffer happens to contain no NUL byte it reads past the end of it.

Allocate with calloc() so an entry that is never filled in compares as an
empty string.

Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 tools/power/cpupower/lib/cpupower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index d7f7ec6f151c..559b04f4387e 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -171,7 +171,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	char path[SYSFS_PATH_MAX];
 	char *last_cpu_list;
 
-	cpu_top->core_info = malloc(sizeof(struct cpuid_core_info) * cpus);
+	cpu_top->core_info = calloc(cpus, sizeof(struct cpuid_core_info));
 	if (cpu_top->core_info == NULL)
 		return -ENOMEM;
 	cpu_top->pkgs = cpu_top->cores = 0;
-- 
2.55.0

