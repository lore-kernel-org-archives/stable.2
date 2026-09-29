Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351F2D0620
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664382; cv=none; b=gkZCYPIM2majRwm9QGFuPNSEZOzqwizDc+WTFVVWbp45oxbV7COInJ5FfBuRqENB7SKX/aM9SG6ifWMQBnrvB7ltjJJhT/HZ1zrUPKcbPRB+IwwfR42q95lgkLxzjtUWd5zP3hW+IVEknJ4EfRVXeoYaB6idnHeDENZpQNX63oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664382; c=relaxed/simple;
	bh=wEGmP0BGxkWmXo5qYc0VwfiQpdhwIIbiaEmFnBXcm08=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XyP0uhoWeOmVPrZwWakfXA5Nc47jQ8IWiHsD7nV5svu+uS26DTnSGgXJ9VXrjEsxcV+BoPyvSVMtoiNdK2VeIOfsB4fYvyz4o3knzESM3xfsyCY7zmuhMOEBujku4nAiYhSMsXjp6f/q8ehk3SzgUqVCpzryVpq2cinZ8b/nPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrHXtjrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrHXtjrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2241F000FF;
	Tue, 29 Sep 2026 06:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664381;
	bh=NH8ePewg2hrhgdiYhrK8F1+upeTDYoWUwxEwSDKbN1I=;
	h=Subject:To:Cc:From:Date;
	b=IrHXtjrUUUUAPmhCV2rkqRbef6n+6KGc9UlG0dhPWUrf2EmeGxnOZBP/JAcRfvMhW
	 bnd/aTsgQffoJRhQrVx1zonkHKGVe+cEMB6xgDEviuXHCGLSGtV6Eam8YEzg3e/bru
	 j7gnpVzvK0Hpf8Zi99US8zt8XfCgxgOhFJqKnNLg=
Subject: FAILED: patch "[PATCH] selftests/cgroup: account for zswap shrinker writeback" failed to apply to 6.18-stable tree
To: joshua.hahnjy@gmail.com,akpm@linux-foundation.org,krushchavan@outlook.com,nphamcs@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:46:10 +0200
Message-ID: <2026092910-overfull-choking-0f5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8c7fdc0b4c64d6583fff3e8f7696237a16ff7c29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092910-overfull-choking-0f5d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c7fdc0b4c64d6583fff3e8f7696237a16ff7c29 Mon Sep 17 00:00:00 2001
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Wed, 2 Sep 2026 12:45:20 -0700
Subject: [PATCH] selftests/cgroup: account for zswap shrinker writeback

The test_no_invasive_cgroup_shrink selftest checks that when a cgroup has
zswapped out more memory than memory.zswap.max, it does not trigger
writeback for other cgroups.  To do this, it compares the writeback count
in a control cgroup and makes sure that it is 0, and then checks the
writeback count in an aggressor cgroup who does expect to see writeback.

However, when the zswap shrinker is enabled, the victim cgroup can see
legitimate writebacks not triggered by the aggressor.  In some Meta CI
tests, we have seen this failure mode happen.

Instead of checking that the victim cgroup has 0 writeback, compare the
writeback values before and after the aggressor runs and check that the
victim cgroup did not perform any additional writeback.  Note that this
can still lead to probabilistic failures if writebacks take longer than
5 seconds, but this should fix the systematic failure case and make
"not ok test_no_invasive_cgroup_shrink" less likely.

Link: https://lore.kernel.org/20260902194521.3652178-1-joshua.hahnjy@gmail.com
Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Krush Chavan <krushchavan@outlook.com>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 609c48f38524..8df54b59513a 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -20,6 +20,7 @@ static int page_size;
 
 #define PATH_ZSWAP "/sys/module/zswap"
 #define PATH_ZSWAP_ENABLED "/sys/module/zswap/parameters/enabled"
+#define PATH_ZSWAP_SHRINKER_ENABLED "/sys/module/zswap/parameters/shrinker_enabled"
 #define PATH_ZSWAP_STORED_PAGES "/sys/kernel/debug/zswap/stored_pages"
 
 static int read_int(const char *path, size_t *value)
@@ -444,6 +445,16 @@ static int test_zswap_writeback_disabled(const char *root)
 	return test_zswap_writeback(root, false);
 }
 
+static bool zswap_shrinker_enabled(void)
+{
+	char value[2];
+
+	if (read_text(PATH_ZSWAP_SHRINKER_ENABLED, value, sizeof(value)) <= 0)
+		return 0;
+
+	return value[0] == 'Y';
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should affect only the zswapped pages of that
@@ -453,6 +464,7 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 {
 	int ret = KSFT_FAIL;
 	unsigned int off;
+	long zswpwb_before, zswpwb_after, zswpwb_target;
 	size_t allocation_size = page_size * 1024;
 	unsigned int nr_pages = allocation_size / page_size;
 	char zswap_max_buf[32], mem_max_buf[32];
@@ -488,6 +500,14 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 	if (cg_read_key_long(zw_group, "memory.stat", "zswapped") < 1)
 		goto out;
 
+	/* If the shrinker is enabled, try to let the writebacks finish first */
+	if (zswap_shrinker_enabled())
+		sleep(5);
+
+	zswpwb_before = get_cg_wb_count(zw_group);
+	if (zswpwb_before < 0)
+		goto out;
+
 	/* Push wb_group memory into zswap with hard-to-compress data to trigger wb */
 	if (cg_enter_current(wb_group))
 		goto out;
@@ -500,9 +520,13 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 		getrandom(&wb_allocation[off], page_size/4, 0);
 	}
 
-	/* Verify that only zswapped memory from gwb_group has been written back */
-	if (wait_for_writeback(wb_group, 5000) > 0 && get_cg_wb_count(zw_group) == 0)
+	/* Verify that only zswapped memory from wb_group has been written back */
+	zswpwb_target = wait_for_writeback(wb_group, 5000);
+	zswpwb_after = get_cg_wb_count(zw_group);
+
+	if (zswpwb_target > 0 && zswpwb_before == zswpwb_after)
 		ret = KSFT_PASS;
+
 out:
 	cg_enter_current(root);
 	if (zw_group) {

