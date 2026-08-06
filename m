Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6338DC69;
	Thu,  6 Aug 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038779; cv=pass; b=tl11bw2UalUZf3B+MscOAFLUKw62tV7d9Dfu1iu03boI5kcqfP9toQAWYrjMwgsG/RzMD/IYuPMlM99yI2NW7/LGSvqmG1Gp/N7qha1x2INdYDJQqsh3I8LUo4QHiZT5J5vjtXf00LLwIqDzo1W5fc3RniKP1qf3lWjwf0Qz9Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038779; c=relaxed/simple;
	bh=nw6Hg7YLELQ9BdIxMV3qE+di7YybAX0C91Rr1B4Lha0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOaMjBwKsjlRBhZL8ByRX1hryQCkgZesoW24ZU7GtIp88GZazKu5zxi2LpVg+934pCkrIA4mT/NuoaP8IOMhT0jsV4O7JMftp9Fv1mBiAhvr/cDC1tXwFoklwlFB7E67AzFKmT1vjXBgTbtfeeO5BpXkPruycVNcZcVkqPOWG6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=h+k08SQ7; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="h+k08SQ7"
ARC-Seal: i=1; a=rsa-sha256; t=1786038768; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=O85gvEdHLrAzOtM9VcIytxO58imrW0fDLEXMNkH8MDfUyaznxQCnzjM/8wwmKhFA0zaiAb5JISCcZKSvbYRl/yNWsPY/PZzKBS6RET+Gjq1DKsC3sYQbZOORI3Jeo56qT+w9Cy+QeAZG1DEzoI/o0PdDiuh+IbKyJzcF98AntsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786038768; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EVG1GxC4aa6YBkLqzvOOLf4wW5wZ9yRHp3Zmvrwa79U=; 
	b=eS6qbn2RDfi47nyVvfTI4ALS9+aVybfB6U4c8ROweuMDwOM5lF6unw/TFQBFbUMXJZxZ6HNGqmSCRVazP87tBaKh83/nj9qeqVuF5a093Rn9HVkaqg3kwyVoKfXShEZeHF/4qSy/GEPbCiuntuALqJQYzwzzWS/KgYatSlEcijY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786038768;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EVG1GxC4aa6YBkLqzvOOLf4wW5wZ9yRHp3Zmvrwa79U=;
	b=h+k08SQ7BAuqau91tI5feKauhYdI+DTbRdEXfoDHlJ0KD37E1XCoxwCFDb2YljQ8
	AZ4i+DTOoQynfGdPmEpJUiy2lxcaup/GV1HA8jQgNwXfJejxjtKTx6StZYrnJgpiy1Q
	vH0mvDpV/9uS7y16QGTnUjv4OaRLwTIcCkL+ex6o=
Received: by mx.zoho.eu with SMTPS id 1786038765266733.2332016240437;
	Thu, 6 Aug 2026 19:52:45 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] cpupower: zero the topology array to avoid uninitialized reads
Date: Thu,  6 Aug 2026 17:51:38 +0000
Message-ID: <20260806175140.270935-2-ali@iusegentoo.com>
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

