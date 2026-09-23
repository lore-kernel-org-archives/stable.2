Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DE496D4E;
	Wed, 23 Sep 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180078; cv=none; b=ZnKgvTOCliVs+/05kXLmcRFk+8kGPn5rBrz5zIKNfm7cMgms6XmNnyrBAwmq4sKy6dJQwlAgHCGcchLQZDp2DEDYVWVemSVF9y8f6tqst5fsh9o67ntGs1hTj1ClCB9FeYTnFcU4uM9YARS4/JZPLFJ6H3ie3soatfXT3xuBvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180078; c=relaxed/simple;
	bh=o+lnkeQINKOx1FMGfJoPJvIdUjvWx2rDpqbnJIYqQB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krf5MRyfV7dDR1F94O3gvzKamMBu8lsOwm9KHLVDJnoasuh2Yd9dArEjJwsY0wTmDZ0VIGk6rG7D5oEN7RWqf277HNV7z9AKhr9KFxOW4heIPjzPOfPyBxPWdZ3OYFKIo67WCbT7uf8Udno9gP14hpYo8iBEUwFgV/EHAPx5FW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G7uQOJwh; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G7uQOJwh"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hqhqm0h4nzF7w;
	Wed, 23 Sep 2026 18:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1790180067;
	bh=Zz5S3FJbOhv3TWXlUV7w7svivks5vbTStg1jsi/EPOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7uQOJwh9oPRJ7cyksfAHd88TFlDoSMK2UYPt0/hoAcdOf+Ltsqp3+fCHOFblC7Fi
	 P4wxSMx209og0ySqX0P+92Ek0cv4wVLxcUiweDJvFG2exAso1pY6j8PHLrGNGb05y7
	 V14k57CNGURWq6/WsBBKLohR4712Q7mCXTRTbJLM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hqhqh0w3pzl4W;
	Wed, 23 Sep 2026 18:14:24 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jann Horn <jannh@google.com>,
	Kees Cook <keescook@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5.15.y v2] selftests/landlock: Add tests for whiteout object creation
Date: Wed, 23 Sep 2026 18:14:15 +0200
Message-ID: <aee05236ad5600be7fc35c089b345eadf6bcaba8.1790169454.git.mic@digikod.net>
In-Reply-To: <2026-09-18-daily-reply-0003-re-landlock-whiteout-5-15@kernel.org>
References: <2026-09-18-daily-reply-0003-re-landlock-whiteout-5-15@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Günther Noack <gnoack@google.com>

[ Upstream commit ee890889b30b22f9a21636061def7a04e4f89380 ]

Add tests to check that whiteout object creation is guarded by
LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
userspace:

* Conventional creation with mknod()
* Linking or renaming an existing whiteout object
* renameat2() with RENAME_WHITEOUT,
  which creates a new whiteout object in the source location
* renameat2() with RENAME_EXCHANGE,
  with one of the renamed objects being a whiteout object

Signed-off-by: Günther Noack <gnoack@google.com>
Link: https://patch.msgid.link/20260813093157.1436894-4-gnoack@google.com
[mic: Update commit message as requested]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
[mic: Backport: add enforce_fs() and the missing s3 fixture paths, and
adapt tests to ABI 1 without REFER]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/88432dfe86f2aaa9ae499587fd7acff9d34a338b.1789655723.git.mic@digikod.net
- Add a guarded RENAME_WHITEOUT fallback for glibc versions before 2.28.
---
 tools/testing/selftests/landlock/fs_test.c | 154 +++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 47fc4392f412..c33f00c499d3 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -36,6 +36,10 @@ int renameat2(int olddirfd, const char *oldpath, int newdirfd,
 #define RENAME_EXCHANGE (1 << 1)
 #endif
 
+#ifndef RENAME_WHITEOUT
+#define RENAME_WHITEOUT (1 << 2)
+#endif
+
 #define TMP_DIR "tmp"
 #define BINARY_PATH "./true"
 
@@ -62,6 +66,8 @@ static const char dir_s3d1[] = TMP_DIR "/s3d1";
 /* dir_s3d2 is a mount point. */
 static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
+static const char file1_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3/f1";
+static const char file2_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3/f2";
 
 /*
  * layout1 hierarchy:
@@ -249,6 +255,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	ASSERT_EQ(0, mkdir(dir_s3d3, 0700));
+	create_file(_metadata, file1_s3d3);
 }
 
 static void remove_layout1(struct __test_metadata *const _metadata)
@@ -265,6 +272,8 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(file1_s2d2));
 	EXPECT_EQ(0, remove_path(file1_s2d1));
 
+	EXPECT_EQ(0, remove_path(file2_s3d3));
+	EXPECT_EQ(0, remove_path(file1_s3d3));
 	EXPECT_EQ(0, remove_path(dir_s3d3));
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	umount(dir_s3d2);
@@ -595,6 +604,27 @@ static void enforce_ruleset(struct __test_metadata *const _metadata,
 	}
 }
 
+static void enforce_fs(struct __test_metadata *const _metadata,
+		       const __u64 access_fs, const struct rule rules[])
+{
+	int ruleset_fd;
+
+	if (rules) {
+		ruleset_fd = create_ruleset(_metadata, access_fs, rules);
+	} else {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = access_fs,
+		};
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+	}
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST_F_FORK(layout1, proc_nsfs)
 {
 	const struct rule rules[] = {
@@ -1941,6 +1971,118 @@ TEST_F_FORK(layout1, rename_file)
 			       RENAME_EXCHANGE));
 }
 
+TEST_F_FORK(layout1, rename_whiteout_denied)
+{
+	/* The affected file is a FIFO. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+
+	/* Deny MAKE_REG, but allow MAKE_FIFO. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
+
+	/*
+	 * Try to rename a file with RENAME_WHITEOUT.
+	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
+	 * Denied, because whiteout creation is guarded with MAKE_REG.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD, file2_s3d3,
+				RENAME_WHITEOUT));
+	EXPECT_EQ(EACCES, errno);
+}
+
+static bool is_whiteout(const char *const path)
+{
+	struct stat st;
+
+	if (stat(path, &st) == -1)
+		return false;
+
+	return S_ISCHR(st.st_mode) && st.st_rdev == makedev(0, 0);
+}
+
+static bool is_fifo(const char *const path)
+{
+	struct stat st;
+
+	return stat(path, &st) == 0 && S_ISFIFO(st.st_mode);
+}
+
+TEST_F_FORK(layout1, rename_whiteout_allowed)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s3d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* The affected file is a FIFO. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+
+	/* Allow MAKE_REG below dir_s3d3. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, rules);
+
+	/*
+	 * Rename a file with RENAME_WHITEOUT within the same directory.
+	 * Allowed, because MAKE_REG is granted for the whiteout object which
+	 * gets created in the source location.
+	 */
+	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD, file2_s3d3,
+			       RENAME_WHITEOUT));
+
+	/* A whiteout object took the place of the moved FIFO. */
+	EXPECT_TRUE(is_whiteout(file1_s3d3));
+	EXPECT_TRUE(is_fifo(file2_s3d3));
+}
+
+TEST_F_FORK(layout1, rename_whiteout_exchange_denied)
+{
+	const char *const whiteout_s3d3 = file2_s3d3;
+
+	/* The exchanged files are a FIFO and an existing whiteout object. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+	ASSERT_EQ(0, mknod(whiteout_s3d3, S_IFCHR | 0600, makedev(0, 0)));
+
+	/* Deny MAKE_REG, but allow MAKE_FIFO. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
+
+	/* Exchanging the whiteout object is denied without MAKE_REG. */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD, whiteout_s3d3,
+				RENAME_EXCHANGE));
+	EXPECT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, rename_whiteout_exchange_allowed)
+{
+	const char *const whiteout_s3d3 = file2_s3d3;
+	const struct rule rules[] = {
+		{
+			.path = dir_s3d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* The exchanged files are a FIFO and an existing whiteout object. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+	ASSERT_EQ(0, mknod(whiteout_s3d3, S_IFCHR | 0600, makedev(0, 0)));
+
+	/* Allow MAKE_REG below dir_s3d3. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, rules);
+
+	/* Exchanging the whiteout object is allowed with MAKE_REG. */
+	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD, whiteout_s3d3,
+			       RENAME_EXCHANGE));
+
+	/* The FIFO and the whiteout object swapped places. */
+	EXPECT_TRUE(is_whiteout(file1_s3d3));
+	EXPECT_TRUE(is_fifo(whiteout_s3d3));
+}
+
 TEST_F_FORK(layout1, rename_dir)
 {
 	const struct rule rules[] = {
@@ -2128,6 +2270,18 @@ TEST_F_FORK(layout1, make_char)
 		       makedev(1, 3));
 }
 
+TEST_F_FORK(layout1, make_whiteout)
+{
+	/*
+	 * Creates a whiteout object (creation guarded by MAKE_REG).
+	 *
+	 * Contrary to the other character devices, this does not require
+	 * CAP_MKNOD, cf. vfs_mknod().
+	 */
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
+		       makedev(0, 0));
+}
+
 TEST_F_FORK(layout1, make_block)
 {
 	/* Creates a /dev/loop0 device. */
