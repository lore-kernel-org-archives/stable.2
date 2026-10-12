Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255B4D0CF5;
	Mon, 12 Oct 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830109; cv=none; b=MjydYaAQ1msWXfwSULdxjWQ0QZTGXrz5nM90lPkw9VPMlIekrFGyPekoHdpqILy1mdS5DQUB6sEUYO06vqL93y0MbTiQSfrTTidDMH/2VGPS1NzsEPRvjWOWEw1jog5EEUnnk9VJdFswRWeF8eh+FpSdZNyII0JjY22j7Nbr4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830109; c=relaxed/simple;
	bh=vf5JylsYTStv7RSDoruMfG7bxf5zsMLqkqTKIoJ+ZOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAoUzWcqG+hEEqEI/KetBlM7ROeKiIs3RCWiXp+TjAnPoNjw3ac7E6elUBPxNZVeLthfODd5bB1X7nWn/UU4FjlSNqgY4ntQK6hRwO/8pF9EOlzHAI51oS4wDbYtQIV0hobWAhDH2qGvfCxbtA13bdcSwENyfgf44iXw5ADA6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7HW4JUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7HW4JUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A641F008A1;
	Mon, 12 Oct 2026 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830108;
	bh=WxttROjiPvBoFTLT7MKASk0lgKHbSPdi4h7blxJxoqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=j7HW4JUAbMUbgbeBORocjFUrbIjmzvpYVG6IWe4gpdm2JHXZounGg5LgfRWl5XKca
	 ngLZkk45UWBWZAJz4L8ayqWqOnAiCfqEfYEB3hCpJzqCWKQk+pfPRLdZh81a+r31Wa
	 9HjsHx0pt5rEh3FG7KQbDkOnb5gAm1L5xgWxVn6tdqJOColQvLkKVzlA2xcvRWpCwF
	 JFAMDhQ2oxYgiAR5c9XVbtK+ordJ4J/sgF9WhO5ZT1MnhazxYS53sAkFpj0JeMiJOu
	 qYHQ02Xbd5ZuB067C9zhmSZ3UhmgqMofpvJsW5ma9CqJyTPYP/cWVKAgyFjoLpHg/v
	 GSs+/3XwUJaxw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Ali Ahmet Memis <ali@iusegentoo.com>,
	stable@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/9] tools/power turbostat: Read complete CPU lists
Date: Mon, 12 Oct 2026 14:32:26 -0400
Message-ID: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261012183457.92243-1-lenb@kernel.org>
References: <20261012183457.92243-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Ali Ahmet Memis <ali@iusegentoo.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 44 +++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 920694c3c1ec..cec3f2fbba45 100644
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
2.45.2

