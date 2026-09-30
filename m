Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002084E3225
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775364; cv=none; b=b9Z5Lfxo/B+KW0uKJ8LTc1OwB693iKXeY75b1eXz0DepQvYDY8KtM5+U/g13fi5pjSFLomFjmUEo9lqR3nUCggVDPLH1lquJmgpYewU95uYk5Ns9+/rkbKyFLE+rZ0ZKbISBfK/MBEr/YeQnoxsBDPOAyUg427MlUSoxUfSPceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775364; c=relaxed/simple;
	bh=pNJEPPwNB1oH1MIT1cvPvN7SYZoEfA8L1F+MCSra+bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPfk4rto9HopJ9lfYrrfG0bwtjkSWwfBzz2vRsisAxkB8dson0TN7rmOWwILZyT8ebpLYr9PxNEl0s5bHPmgD+uWwmVKmF06Pqkby7XcIPxXSQsqCcvZk0YXOn44ThHkaGquUa54CLUfpDJ1ELesUN/KHX3C/YBoy+Foy5AYKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=defXQk9w; arc=none smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="defXQk9w"
Received: by mail-oo2-f35.google.com with SMTP id 46e09a7af769-820f53e2748so38046a34.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790775352; x=1791380152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LZSex1/2Q5tq8sLSC9bzCA/iZj8NShqdC54kCNghxQ=;
        b=defXQk9w4nvxZpB4pKnLL3W4oGBkKEMWvy3knPihRT+d1S3QIow2WG0TpjGMyrk6DD
         RUQDjTz1oknc0riAGo8vUxzkB/nqdG2tGy5l5ilBWPP3gpB/nhJpnp1PYm5pCvwtM8QZ
         c/niLJ+DpCpG+QqUqRKfbbG1g0LUVHxmjKmb1fhiod+Zyq11FulL3tQWZVzJ40kemhLz
         rJYAtTJX+o11tXMEIBTSYNhUlODRBvK1eOSXVEHP2WO1tdhO6i3GQRHmczE7eewBAnwb
         CUEi/rFRB0zAogYtWICrPpQnz9/S99DCgqHwc0EpcFQJ7X/giBiNaTWSqufyZr98CM8e
         WxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775352; x=1791380152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LZSex1/2Q5tq8sLSC9bzCA/iZj8NShqdC54kCNghxQ=;
        b=cQsoDcSrHs0HwAeiQcEaePCNnIoYINe4w+xRUnTqD+yT79dNy3B7UVg6o0OJWpAH2m
         Ed6DQFgGTP5Sg00cVGEKAdNw83NCeJb3TaNFniNaU/vNfjYijVPLQzkv3IK7LwwrC/p9
         FCcTopH8NzWPg3ZMhcpm12pA3IKHNUSCud+i0JOehiAwarKHu1TGbjA7Cdur2f05hCV+
         A21GfLzArdtkbJa1dmoltIluAYxtuJmmWnS70ej7jBij9sWSSWr6bIJRf765ZmhlfLWp
         HQasn52O7aTTihy7e7Kng7dW3BrTLZSmUFL1biP0vJykDIfxBIYViY9owk0q6Rqvj8kS
         J4fQ==
X-Gm-Message-State: AFuF++loIGkgT+6vPSZtwYZdPIgfz1/uZ6NF+6UTjFeVVKttwpQfPE6m
	9rc8SVnQga1yYygYteo66JrhGc7T7eDZviG2zWdBcGqYvrnjSy826tfdzHAihXMe
X-Gm-Gg: AYBFou3c7iccWtrILq8k3huc/Tvwumv0s7v5koo9DRqiC7duXbx0rZurbWtV3YtunTD
	dQ4QeHpQRG+jIMPoJOyBY7/IQNDYnVTKlgNGtYiNqn5M9ylT9xdnjzTV6wMt4lPsqVeq19UKiSX
	NZsPBZ9I6+lQD6OVV5ySGkfzfKAJMdeuXvxv4G7byGkCii3rGRb5+cxp4QOV3D7T1r4byvo75qz
	xIy+Gm/e+x4vcnAnz8IAn+CFYn3U/7qklPGAxB9DpWJdPARnETi/hueTGuNc+FQ8nNaehzriaeJ
	KShv1vj3PoOY+n7aenQA1taljpBjJEpWCOp4Z7HKjraZXEHQ86dvJ/OX+LGiNDytidsrusQyni+
	S82VaGzQeWzOS3YkOFisdDk7T12AFAkTx4hlphSZGQJMA0J4nPhU8gfjNzSVd+4gcuRqjVCL51m
	J0GBz1Gr45n9uyKCvoogZ/8O0fZ0AM4yY1zI97AwA4baPKAJnaDYFvKkfnEfrZUawFTyh/nKiWZ
	YR6/I2cI/ZpXTJEw5uWDf9knFyuLA==
X-Received: by 2002:a05:6830:6686:b0:7f8:4b8d:d93f with SMTP id 46e09a7af769-82049219a4fmr1686545a34.13.1790775352011;
        Wed, 30 Sep 2026 06:35:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:17::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82062ccb77fsm861820a34.7.2026.09.30.06.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:35:51 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: stable@vger.kernel.org
Cc: Krush Chavan <krushchavan@outlook.com>,
	Nhat Pham <nphamcs@gmail.com>
Subject: [PATCH 7.2.y] selftests/cgroup: account for zswap shrinker writeback
Date: Wed, 30 Sep 2026 06:35:50 -0700
Message-ID: <20260930133550.2071552-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092910-trash-gossip-19f6@gregkh>
References: <2026092910-trash-gossip-19f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 8c7fdc0b4c64d6583fff3e8f7696237a16ff7c29)
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 28 +++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 6e7b89315bbf3..eb0933ace4aca 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -20,6 +20,7 @@ static int page_size;
 
 #define PATH_ZSWAP "/sys/module/zswap"
 #define PATH_ZSWAP_ENABLED "/sys/module/zswap/parameters/enabled"
+#define PATH_ZSWAP_SHRINKER_ENABLED "/sys/module/zswap/parameters/shrinker_enabled"
 
 static int read_int(const char *path, size_t *value)
 {
@@ -443,6 +444,16 @@ static int test_zswap_writeback_disabled(const char *root)
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
@@ -452,6 +463,7 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 {
 	int ret = KSFT_FAIL;
 	unsigned int off;
+	long zswpwb_before, zswpwb_after, zswpwb_target;
 	size_t allocation_size = page_size * 1024;
 	unsigned int nr_pages = allocation_size / page_size;
 	char zswap_max_buf[32], mem_max_buf[32];
@@ -487,6 +499,14 @@ static int test_no_invasive_cgroup_shrink(const char *root)
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
@@ -499,9 +519,13 @@ static int test_no_invasive_cgroup_shrink(const char *root)
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
-- 
2.53.0-Meta

