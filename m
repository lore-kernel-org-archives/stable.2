Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C624B44D9
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659298; cv=none; b=FLAsyVO4OC8e/g7XI29jV5GkEnFrM00fIU16DaTOyLR+xSl/0iKfRZHP3r4Ov20TCqey4Prhf3YOp33zBOp/suJOKf7+L8YIGBz2P05HeQMFW+Gg2kKEsioCHpwqY7x4aLAeTro65DQab1Bv1dg/ohgKJPiXqsmEoFMXlQSBV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659298; c=relaxed/simple;
	bh=HROO3ddNnvB1UaNFrx0Lzsg3wI7ity07MvwTeQ88t6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dry876FJmMIwhgjpFUvtfEUsgBebN9ncM2BSf4gJS5lMtUn1tOifhQT7HNYh6hIKQmihX10pTdCobksAEGUPfQwxYePfjc+svY04Cw/ag0793/FeyABZJ0EBYl8RQ/8/3AQtpT+Vp1ipcMq4QgwGRDt1dZ/t8zr8YJkyBAI5MR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BlNQDDek; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BlNQDDek"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm05r46wXz2fh;
	Thu, 17 Sep 2026 17:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789658928;
	bh=pMzPf4uRowJntCLKTZhE2aYHxQueNsM5Ic4UkQkZb8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlNQDDekC711roMcprmQlXH2fn32lUCLJRPlMwl+3DzsA6lLvEBG7f/GCzrQ5wAs/
	 aBjrx5CgZwx81N6W9SrEtpbpdHCDim8sjf5kH7OPqjgMbAxH1uUa6E08ys/8qcpnV/
	 Z/P7/6spP9qY7WmEY6syQdVR2fZ0hWMdg/QtCsbY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm05q5s94z5fQ;
	Thu, 17 Sep 2026 17:28:47 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Subject: [PATCH 6.6.y] selftests/landlock: Add tests for whiteout object creation
Date: Thu, 17 Sep 2026 17:28:43 +0200
Message-ID: <520a1a9a0c6f14c19f1b962ea33adcf672bf6fdb.1789655724.git.mic@digikod.net>
In-Reply-To: <2026-09-05-daily-reply-0019-landlock-whiteout-6-6@kernel.org>
References: <2026-09-05-daily-reply-0019-landlock-whiteout-6-6@kernel.org>
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
[mic: Backport: adapt the tests to the older filesystem fixture and
ruleset helper]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 205 ++++++++++++++++++++-
 1 file changed, 203 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 9082ee10256a..f235552407af 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -73,6 +73,8 @@ static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
 /* dir_s3d2 is a mount point. */
 static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
+static const char file1_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3/f1";
+static const char file1_s3d4[] = TMP_DIR "/s3d1/s3d2/s3d4/f1";
 
 /*
  * layout1 hierarchy:
@@ -348,7 +350,8 @@ static void create_layout1(struct __test_metadata *const _metadata)
 	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	ASSERT_EQ(0, mkdir(dir_s3d3, 0700));
+	create_file(_metadata, file1_s3d3);
+	create_file(_metadata, file1_s3d4);
 }
 
 static void remove_layout1(struct __test_metadata *const _metadata)
@@ -368,7 +371,8 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(dir_s2d2));
 
 	EXPECT_EQ(0, remove_path(file1_s3d1));
-	EXPECT_EQ(0, remove_path(dir_s3d3));
+	EXPECT_EQ(0, remove_path(file1_s3d3));
+	EXPECT_EQ(0, remove_path(file1_s3d4));
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	umount(dir_s3d2);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
@@ -710,6 +714,27 @@ static void enforce_ruleset(struct __test_metadata *const _metadata,
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
 TEST_F_FORK(layout0, proc_nsfs)
 {
 	const struct rule rules[] = {
@@ -2086,6 +2111,170 @@ TEST_F_FORK(layout1, rename_file)
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
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
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
+	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+			       TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+
+	/* A whiteout object took the place of the moved FIFO. */
+	EXPECT_TRUE(is_whiteout(file1_s3d3));
+	EXPECT_TRUE(is_fifo(TMP_DIR "/s3d1/s3d2/s3d3/f2"));
+}
+
+TEST_F_FORK(layout1, rename_whiteout_reparenting)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s3d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s3d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* The moved files are FIFOs. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+	ASSERT_EQ(0, unlink(file1_s3d4));
+	ASSERT_EQ(0, mknod(file1_s3d4, S_IFIFO | 0600, 0));
+
+	/* Allow REFER below dir_s3d2, but MAKE_REG only below dir_s3d3. */
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   rules);
+
+	/*
+	 * The whiteout object is created in the source directory: Moving the
+	 * FIFO out of dir_s3d4 is denied because MAKE_REG is not granted
+	 * there, even though it is granted in the destination directory
+	 * dir_s3d3.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD,
+				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+	EXPECT_EQ(EACCES, errno);
+
+	/*
+	 * Moving the FIFO out of dir_s3d3 is allowed, because MAKE_REG is
+	 * granted there for the created whiteout object.
+	 */
+	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+			       TMP_DIR "/s3d1/s3d2/s3d4/f2", RENAME_WHITEOUT));
+
+	/* A whiteout object took the place of the moved FIFO. */
+	EXPECT_TRUE(is_whiteout(file1_s3d3));
+	EXPECT_TRUE(is_fifo(TMP_DIR "/s3d1/s3d2/s3d4/f2"));
+}
+
+TEST_F_FORK(layout1, rename_whiteout_exchange)
+{
+	const char *const whiteout_s3d3 = TMP_DIR "/s3d1/s3d2/s3d3/f2";
+	const struct rule rules[] = {
+		{
+			.path = dir_s3d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s3d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* The exchanged files are FIFOs and an existing whiteout object. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+	ASSERT_EQ(0, mknod(whiteout_s3d3, S_IFCHR | 0600, makedev(0, 0)));
+	ASSERT_EQ(0, unlink(file1_s3d4));
+	ASSERT_EQ(0, mknod(file1_s3d4, S_IFIFO | 0600, 0));
+
+	/* Allow REFER below dir_s3d2, but MAKE_REG only below dir_s3d3. */
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   rules);
+
+	/*
+	 * With RENAME_EXCHANGE, the whiteout object moves into the source
+	 * directory of the rename: Exchanging the FIFO in dir_s3d4 with the
+	 * whiteout object is denied because MAKE_REG is not granted in
+	 * dir_s3d4, even though it is granted in the whiteout object's own
+	 * directory dir_s3d3.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD, whiteout_s3d3,
+				RENAME_EXCHANGE));
+	EXPECT_EQ(EACCES, errno);
+
+	/*
+	 * Exchanging the FIFO in dir_s3d3 with the whiteout object is
+	 * allowed, because MAKE_REG is granted in the directory into which
+	 * the whiteout object moves.
+	 */
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
@@ -3139,6 +3328,18 @@ TEST_F_FORK(layout1, make_char)
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
