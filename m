Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D944DAF85
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659770; cv=none; b=LQpn0X3o31I4/wydp1cIpR4K6MBhWxoqaAHYAtZmvcgcC96UlVCqFxXnY45XqKW09hDbSIwJltmfeoOI2TfO/dS3m22saORbAmiJEjyymQ7CoD6To0z72FOISBPRqYea/H+rTiXEQVsHGV4AEgdl5AXMzcxegcsiJi1/rCnzAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659770; c=relaxed/simple;
	bh=rBWHZVt07iCao/se4SzzTB3JeHcyeF875x0Gimxyu2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpLuDslffdgZnsX7yqV9lzjU4ONJGehyp27dKI3k2F4Mqyn1zIILkwTGJ50vt7uc79BRPshu8FodnLgCJIH8KkXjBkOOp9WaX1YRX6iIlFhX14Qc1/uDZ9kM4mKj1d048Soh4HTRDPzH3o3iXIudvLOYUPVTNLYhkpUjUXJCfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dvjIfha5; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dvjIfha5"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm0Pl52ZPzYgT;
	Thu, 17 Sep 2026 17:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789659755;
	bh=wdRHrEmuk8uHyfuM/dwFgQ/pNplF++A3V+k66JXKBFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvjIfha5vC/dPobghz2eyUufF3rFQWi5Thib8TwLYedqPA5gc8lAQsTRAMAI6H8nX
	 3o94mIZlbTgsBLXGdG8Ko/cpWWSujDr6dho3iw3mKP8LDf4yBfKu4puZSvT1JTLTwa
	 ioeDFKBlLzEYAaW9VMptFCQ9i/DYzvHqotj/ryo4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm0Pk6lmrzLxh;
	Thu, 17 Sep 2026 17:42:34 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Subject: [PATCH 7.2.y 3/3] selftests/landlock: Add audit test for whiteout object creation
Date: Thu, 17 Sep 2026 17:42:29 +0200
Message-ID: <dfff8631e1bbfcc8c0a91fa9d46267743039d44a.1789655724.git.mic@digikod.net>
In-Reply-To: <20260904045811.854612571@linuxfoundation.org>
References: <20260904045811.854612571@linuxfoundation.org>
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

[ Upstream commit 8c46c6acbebe0d8544fd1b55e5ddf36828d7b9ea ]

Add audit_layout1.make_whiteout: This test looks similar to
audit_layout1.make_char, but creates a whiteout object through mknod().
Since whiteout object creation is now guarded with
LANDLOCK_ACCESS_FS_MAKE_REG rather than LANDLOCK_ACCESS_FS_MAKE_CHAR, it
also needs to log the matching denial to audit.

Signed-off-by: Günther Noack <gnoack@google.com>
Link: https://patch.msgid.link/20260813093157.1436894-5-gnoack@google.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 871a5b819b98..a9130ed70af5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7622,6 +7622,25 @@ TEST_F(audit_layout1, make_char)
 	EXPECT_EQ(1, records.domain);
 }
 
+TEST_F(audit_layout1, make_whiteout)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	enforce_fs(_metadata, ACCESS_ALL, NULL);
+
+	/* Whiteout creation is denied and logged as fs.make_reg. */
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(0, 0)));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
 TEST_F(audit_layout1, make_dir)
 {
 	struct audit_records records;
