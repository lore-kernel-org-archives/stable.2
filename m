Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACC368D45
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380479; cv=pass; b=oftw2r5KsdTeY4LTI+/FVJ30z1yH7Hu2M+ca4LejEB2lp2Ifd3LiovRkZ5jkr09gu8W6pur3uH8Rj5B8lA7ltKaoR2QW8C7oD0ifc3hvt727s4CddLmMZEz9wpQIDVD7Ax4/3mbQ/TxEYjs+XhRCQo8n540+AZk2VDZINLgOKpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380479; c=relaxed/simple;
	bh=QeOqBCNxAOK+n4t/DmBTbWaTehojT2n5Ail+thTmoHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXsVQTumwJbXDPLP24BWEXYkpSpzJZQM6Bjo8ASHU1TLmmfbLz+UP4g5xzAS5nAFrgrgxy4qmAXnFE+bhKQ2q/FLMDPbkL6S+fn4jnUAWDQGPtQz8ankXifNSPSWrl5LDCTc6O2DDY6qysBOmA91RzzCOb4oLLMJiPK9067BTxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=ZLCGqVy1; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="ZLCGqVy1"
ARC-Seal: i=1; a=rsa-sha256; t=1785380444; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NqpRAVxG+FtCxSCZARrvBTg6ptK5l2y/FiP8O8K9I0GURhObuipGUdjwlPlI+URWIjhdzoGIpAOSO6D1kCUM5+88NaMgUBLqwNQL+GT4lJAgQSPfIWwJDFrRFCtqyh18AFXqtOzq7R2G3aJPJOGMPqwebFlvRA63pgiF/sBlVqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785380444; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zlE4YGKAm0cmJs59qDCAcEJvFaom5KfZb9PiKkB8O58=; 
	b=FvhV5gIia/RUtr5riV9HHgwQa9kEt567NUIHlP33F6ZwGArM45FrPpTkjXlnHY/+rgozpDWdl9KRT7ot+KQLM3QI4n3VDKth1BTHNSs9AYN5p1c5NvdQSbu+nn2pXrm0G4uCNhgFYWupxbPl/sOyJ8y4fTIcUBfS5eT6dpeJofU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785380444;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zlE4YGKAm0cmJs59qDCAcEJvFaom5KfZb9PiKkB8O58=;
	b=ZLCGqVy1p7X8G4S8CjOVo6/Z5nIITd150uILrz7g0qpZnWSUA6d2P/r/nXixF0Tq
	1YOe6ACuqLCtRoclVUPBg6gzvm29iJavjpVK2/AfTWVpBtQYrX9mRfmugIaKAHSzBha
	nbupNdAoWSKFk2FriFld30iLloiH9NXTfW6wwyhA=
Received: by mx.zoho.eu with SMTPS id 1785380442638594.3961943698703;
	Thu, 30 Jul 2026 05:00:42 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Read complete CPU lists
Date: Thu, 30 Jul 2026 06:00:31 +0300
Message-ID: <20260730030031.28678-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

CPU_SUBSET_MAXCPUS accepts CPU IDs through 8191, but the sysfs and
cgroup CPU-list readers stop at 1024 bytes. A fragmented cpuset or
hybrid PMU CPU list can exceed that size and be truncated.
initialize_cpu_set_from_sysfs() can also pass a full, non-NUL-terminated
buffer to parse_cpu_str(), causing an out-of-bounds read.

Additionally, initialize_cpu_set_from_sysfs() returns with the file
still open on success. It is now called once per CPU for
thread_siblings_list, so large systems can leak thousands of descriptors
during topology discovery.

Use getline() so both readers receive a complete, NUL-terminated line.
Close and free the sysfs CPU-list resources on every path, and report
malformed input from the correct buffer.

Fixes: eb187540d13a ("tools/power turbostat: Increase CPU_SUBSET_MAXCPUS to 8192")
Fixes: 58839fdbd441 ("tools/power turbostat: Process HT siblings in CPU order")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 tools/power/x86/turbostat/turbostat.c | 44 +++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 920694c3c..cec3f2fbb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6311,33 +6311,35 @@ int for_all_proc_cpus(int (func) (int))
 
 #define PATH_EFFECTIVE_CPUS	"/sys/fs/cgroup/cpuset.cpus.effective"
 
-static char cpu_effective_str[1024];
+static char *cpu_effective_str;
 
 static int update_effective_str(bool startup)
 {
 	FILE *fp;
-	char *pos;
-	char buf[1024];
+	char *buf = NULL;
+	size_t size = 0;
 	int ret;
 
-	if (cpu_effective_str[0] == '\0' && !startup)
+	if (!cpu_effective_str && !startup)
 		return 0;
 
 	fp = fopen(PATH_EFFECTIVE_CPUS, "r");
 	if (!fp)
 		return 0;
 
-	pos = fgets(buf, 1024, fp);
-	if (!pos)
+	if (getline(&buf, &size, fp) < 0)
 		err(1, "%s: file read failed", PATH_EFFECTIVE_CPUS);
 
 	fclose(fp);
 
-	ret = strncmp(cpu_effective_str, buf, 1024);
-	if (!ret)
+	ret = cpu_effective_str ? strcmp(cpu_effective_str, buf) : 1;
+	if (!ret) {
+		free(buf);
 		return 0;
+	}
 
-	strncpy(cpu_effective_str, buf, 1024);
+	free(cpu_effective_str);
+	cpu_effective_str = buf;
 	return 1;
 }
 
@@ -8529,13 +8531,16 @@ int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct
 	return ret;
 }
 
-char cpuset_buf[1024];
-int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, char *sysfs_path, char *sysfs_file)
+int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, const char *sysfs_path,
+				  const char *sysfs_file)
 {
 	FILE *fp;
+	char *cpuset_buf = NULL;
+	size_t size = 0;
 	char path[128];
+	int ret = -1;
 
-	if (snprintf(path, 128, "%s/%s", sysfs_path, sysfs_file) > 128)
+	if (snprintf(path, sizeof(path), "%s/%s", sysfs_path, sysfs_file) >= (int)sizeof(path))
 		err(-1, "%s %s", sysfs_path, sysfs_file);
 
 	fp = fopen(path, "r");
@@ -8543,19 +8548,20 @@ int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, char *sysfs_path, char *sy
 		warn("open %s", path);
 		return -1;
 	}
-	if (fread(cpuset_buf, sizeof(char), 1024, fp) == 0) {
+	if (getline(&cpuset_buf, &size, fp) < 0) {
 		warn("read %s", sysfs_path);
-		goto err;
+		goto out;
 	}
 	if (parse_cpu_str(cpuset_buf, cpu_set, cpu_possible_setsize)) {
-		warnx("%s: cpu str malformat %s\n", sysfs_path, cpu_effective_str);
-		goto err;
+		warnx("%s: cpu str malformat %s\n", sysfs_path, cpuset_buf);
+		goto out;
 	}
-	return 0;
+	ret = 0;
 
-err:
+out:
 	fclose(fp);
-	return -1;
+	free(cpuset_buf);
+	return ret;
 }
 
 void print_cpu_set(char *s, cpu_set_t *set)
-- 
2.54.0

