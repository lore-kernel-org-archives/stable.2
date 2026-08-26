Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A97472532
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767905; cv=none; b=IJW+ys9fP97vhWoF8F8s2r33iWhDIQAD5sirKCTx3zkTYilrgFWkDeqPUE3Nk1/YKCrMAk5oHJyJw4TnoUfYL8/FxAAF2NH+JqUHjuI+7GZa1+fSSRN7idTQO99UaskS9dyFias6uDeFHq9OIXPQvdYZYZWfluQ01VbI4fTo7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767905; c=relaxed/simple;
	bh=zW/jWEywlJnLpPn3iSmZGT+bzd3gQc7ctNw4LFiA03I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJz1G3ZYPzWrT/6AaOftz8nD3VXG/mCNQzMjjvxlyZzUnhOCrn5fB0RHUsGTYv6I22g1sjsOH3ws/xpwq7CbiLWpqzCr8M1SD1OwfVrOSVIgUV27ZZ06s0eWh/Mj2XwL0WZUeqTLhq1Y9mzMMxHPe1C9PO4mupSW1LpsiFl+7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz9pm1Tq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz9pm1Tq"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedf318752so1058162a12.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787767886; x=1788372686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=70l+pktXnkTFw9cxbeR6NIJIADP4PanSEbbcQ2ECs8I=;
        b=gz9pm1TqJOTSncpKxrHtHR+gKXIiKaMsZl7ID8N3qnZxQ6Xv7ZGTBBTHLTHLFMMNgV
         criaun6l6F7vfYRZX+3SvzedIPUC7uK1gLdQCE4GciVKtPtjp3R2iuPfoxTCpSRy1ivB
         73WfmekmKQ2SgM+Poqz1aHJJ0UtjQZWDfS+4sYpHqyjNVo/dwFD8oYyZizmDGgKlNZTK
         Ylq6dDTaq1QU3/hu5oYuqfk+GcnJEJMrspdfeuvsLP+HQIATLWEOAuPCbOEivVp1WddA
         toUAmxBLWrPFOibEOza3iqDxEjDBA+P/c0sfhjMDv6Zc8VeUOKs/3PCg3VxZBZKV+Aqa
         6qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767886; x=1788372686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70l+pktXnkTFw9cxbeR6NIJIADP4PanSEbbcQ2ECs8I=;
        b=Z8/IQCSTo3RikOt4s8y/rO0tPPNW66U6YOozV0opKZAoYoRyhlJEK+uGVrlpnJn2sm
         9Cook4NgYONQvZ3/d0WI7/xUs8qzga/PNLoXS0dU26lyF6Tn7mujRMEPbQSlUPjeD37x
         6pv4WABGKtwRBVFYCe8HcEgsHMi1puRNczbWtIJmuXDyTY26t4q9KB4O2ZekCL7gx72k
         ifJ4RBmzWiSRfIazmje1jm4okmrn91Kgt/3ffpswv+aVp5vgwWvijArWuUVnoIFQEdxN
         6FbELa7HWR3HWfCHfNsGP4cP+r/Je8JQ05mU6Mqf6lSxL1q3XuK6WQk86HRkuQ85cbs8
         oq/A==
X-Forwarded-Encrypted: i=1; AHgh+RoTA0iRP4R9qi276PKnUWL7ilhzX+lW25NZTVMDBXc4f4uuwDqHhqy8x9d1CuQfzG5k2snaMP4=@vger.kernel.org
X-Gm-Message-State: AFuF++mYwSxGZRvvMM9p+FGutKEdY9Sr+lHIkNdBax1RUBEo+Bwo5WE6
	owbj7r8qNm/p1OC00fSHqj6YY5iMBdlHEA8NIUoaryz3QBHGNnlfZPJe
X-Gm-Gg: AR+sD13bUY6uyUEjrjKH9FjE9BOKINpfmFi7ogOSgH7OrHSNNo/QIEwdBZJwVKcyBt/
	xzHMe9oF3hMDF0wl55ORuFBPJblfox13d+aMwzT6eRcBdJTbvESRaG2cMJbYJOHF/d40Ma4L7gs
	h369d7WpFj16Jo8rH2wzmAib+EP/mLfX7kR5QkJ3Xfx/1rsZaw6muUwjHEejvUMiUvRlxj7zDuR
	n551TNpOzQVEakzJPz8s26sxAae6ZJBDD8GcqUnI60W8Eat5cGEeqHYHKSPqnDmoAunyfHmLsTq
	+9V48thmIoGCqyh6RDWRA1xm7b7gh9uEV5UfkR0lHSeejj094RA4Phcef0235SfLQtfSNhEB/Cd
	cuotVMpy4XU9DZejXA0wz4tzvZ/ORERYnAr0YKeLJrVW+io4gzHBFJxJrMI3WIFDzK4OJ2NomAO
	1036d45yJHnx77PAJ1PPaU9QRBlORFtZYLTBbAW9rnKzQseXImlXyYWGUC+ZCoZ7V0hkmyf/hEM
	n1n19swSXwIPLLFYdPc+CAExiihN7yh4Y9At7kOpLZE+paXC5Pkr8JSH9EcjS+I2m2WcM+lE38w
	NZZ3cyMh9flM
X-Received: by 2002:a05:6a20:94ce:b0:3c3:9df0:2d66 with SMTP id adf61e73a8af0-3cf7607a0ebmr19577158637.6.1787767886004;
        Wed, 26 Aug 2026 11:11:26 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:d10e:986a:5a1c:babc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9036c85sm9334737c88.9.2026.08.26.11.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:11:25 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] mkfs.f2fs: enforce alias_filename to match device name
Date: Wed, 26 Aug 2026 11:11:21 -0700
Message-ID: <20260826181121.3825702-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

The kernel expects the device alias file in the root directory to match
the device basename (strrchr(path, '/') + 1) to identify the target device
both during mount in f2fs_restore_device_alias() and during reserve in
f2fs_ioc_reserve_dev_alias().

If a custom alias filename that differs from the device name is used,
the kernel fails to match the alias file at mount time (leaving
FDEV(i).has_alias unset and allowing pinned files to allocate in that
range) and subsequently fails to reserve the device range when requested.

Enforce that if an alias filename is specified, it must match the device
name. Also allow specifying just '-c <device>@' as a shorthand so users
do not have to redundantly type the device basename twice.

Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
Fixes: 8cc4e257ec20 ("mkfs.f2fs: add device aliasing feature")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 man/mkfs.f2fs.8         |  4 +++-
 mkfs/f2fs_format_main.c | 27 +++++++++++++++------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 9096646..430d180 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -121,10 +121,12 @@ Currently, the kernel is only able to mount f2fs filesystems where the
 block size matches the page size.
 The default value is 4096.
 .TP
-.BI \-c " device-list"
+.BI \-c " device_name[@alias_filename]"
 Build f2fs with these additional devices, so that the user can
 see all the devices as one big volume.
 Supports up to 7 devices except meta device.
+If '@' or '@alias_filename' is given, the device is configured as a device alias.
+Note that alias_filename must match the device name.
 .TP
 .BI \-d " debug-level"
 Specify the level of debugging options.
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 8d44a9b..99d92c5 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -191,6 +191,7 @@ static void f2fs_parse_options(int argc, char *argv[])
 	int32_t option=0;
 	int val;
 	char *token;
+	bool is_alias;
 	int dev_num;
 
 	while ((option = getopt_long(argc,argv,option_string,long_opts,NULL)) != EOF) {
@@ -218,6 +219,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 				mkfs_usage();
 			}
 
+			is_alias = (strchr(optarg, '@') != NULL);
+
 			token = strtok(optarg, "@");
 			if (strlen(token) > MAX_PATH_LEN) {
 				MSG(0, "Error: device path should be equal or "
@@ -226,21 +229,21 @@ static void f2fs_parse_options(int argc, char *argv[])
 				mkfs_usage();
 			}
 			c.devices[dev_num].path = strdup(token);
-			token = strtok(NULL, "");
-			if (token) {
-				if (strlen(token) > MAX_PATH_LEN) {
-					MSG(0, "Error: alias_filename should "
-						"be equal or less than %d "
-						"characters\n", MAX_PATH_LEN);
-					mkfs_usage();
-				}
-				if (strchr(token, '/')) {
-					MSG(0, "Error: alias_filename has "
-						"invalid '/' character\n");
+
+			if (is_alias) {
+				char *dev_name = strrchr(token, '/');
+
+				dev_name = dev_name ? dev_name + 1 : token;
+
+				token = strtok(NULL, "");
+				if (token && strcmp(token, dev_name)) {
+					MSG(0,
+						"Error: alias_filename (\"%s\") must match device name (\"%s\")\n",
+						token, dev_name);
 					mkfs_usage();
 				}
 				c.devices[dev_num].alias_filename =
-					strdup(token);
+					strdup(dev_name);
 				if (!c.aliased_devices)
 					c.feature |= F2FS_FEATURE_DEVICE_ALIAS;
 				c.aliased_devices++;
-- 
2.55.0.887.g758fc8c411-goog

