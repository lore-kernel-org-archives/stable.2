Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B443D1A8F
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287840; cv=none; b=m473+fZqyd7/F+fw8WrHpxHWH+lRI4HV7j+zDM3MA8zDQ8IX5C01xS/Z+o8krK66B5cet/Iy7VdCB/9VDbb1qKergZu72UEJUmhJTcCsGfPNno0/JWtspMHOGv5PDF3yMsqKM8yHJ10n9kEraD4NGOQs3XvRa3mME3Ods8+15VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287840; c=relaxed/simple;
	bh=Dy2iXH6Zk+vgX4QnOnm8aP/uMiBxLeTmuJ775yU/hiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=areWM6hAKWnfYKtuVz4ON/7gArSh4zhfCxtDy/CvzlH0DQw+4lJqNgNUQw8NTtijFRIN8BSLDashhX2KSDibseBRdfaTh+OjFfKsmfA8P7TskOmWysdFiKdO45CXhly9BkeGeHLtfCHAQv8arUVb2poB5oH/KY7oGSl85MOEfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF3XTVPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF3XTVPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D291F00A3A;
	Sun,  9 Aug 2026 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786287838;
	bh=jGcZ5D34SX9uk0cvVfc5iy1AtWh9jTLl/4bNccPvcSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RF3XTVPW3irEZRkZBiBVCGcFUWyJ4QirW1jWmC/8QZsGq/F5VV56IpVeLbZRKIkz5
	 X5oOO8F0TxLja7cbTPGnybB0g79Wz3JdftYfYex2NR+8TzOalDYUh3PraTgpFuhkz3
	 ncF3fR6pTfXusJnXEYw1RrWjrzM8o4Tl8gH6vgytoZy0AjTlIITirBapZYps9oOkRb
	 LU3qNrS4RzLWfeaCx8RoIRAzmGStL9Y7sJ2Hhl9e2oSbMxFcjIhxsMyt/SZu70hAfX
	 h2Se+mPoW1MZidBPlugZ9RO0WWqQtWzqkr57e/8q4QmZryoF2HAS7BHPpK9UvSY71v
	 mb7aNhGu/f6XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] btrfs: add debug build only WARN
Date: Sun,  9 Aug 2026 11:03:53 -0400
Message-ID: <20260809150356.1872210-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080520-wikipedia-kindness-ddd8@gregkh>
References: <2026080520-wikipedia-kindness-ddd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 3db15c6ca6feb2c5000a1cbb39c33866e0349abd ]

Add conditional WARN() wrapper that's enabled only in debug build. It
should be used for unexpected conditions that should be noisy.  Use it
instead of ASSERT(0). As it will not lead to BUG() make sure that
continuing is still possible, e.g. the error is handled anyway.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8bc4d7209611 ("btrfs: zoned: fix missing chunk metadata reservation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/messages.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 1ae6f8e23e071..dd3647f5530ac 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -181,6 +181,13 @@ do {								\
 #define ASSERT(expr)	(void)(expr)
 #endif
 
+#ifdef CONFIG_BTRFS_DEBUG
+/* Verbose warning only under debug build. */
+#define DEBUG_WARN(args...)			WARN(1, KERN_ERR args)
+#else
+#define DEBUG_WARN(...)				do {} while(0)
+#endif
+
 __printf(5, 6)
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
-- 
2.53.0

