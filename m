Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761B40963A
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528261; cv=none; b=K+oBD+aihYGueh1Vn4cXci9mkOc42TcxuwVkuxx9hxvW5WR8FNR/43WJ6p66hEXhCLu3qDdO5qN6D3DDNDGtwXdBFgzzObXmP2gakoyxWdna7hU9prn1D8li30nS6XZ0+f3nO3TDqt9PFF0AVTCPrK4VCb8zTtoKYE90WAbQwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528261; c=relaxed/simple;
	bh=JikqhJGROCV8kR72DztDiiosUhEgnlcIOAeiPST6xbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pspk3wIwjNwMcmwbqK4/p3KmgT3kR6bXZFhXsmTSaqS3N17p7I7MxbLBqZ9NlwTweHQuv6AEZ2eDF5KDw6iXXjbEZ1GQIQ+zri2LKwjfXPAX152NU+6AT93K6mqssCn/brWypvaoBcFEsuZDTNzLJ2y8zqVL6TdFa8hRwlN6Zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKZO446R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKZO446R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAF01F000E9;
	Wed, 12 Aug 2026 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528260;
	bh=2t2uEOOfn1DM+4MYuioht9/xIUmUCsM00p/ihGU+eP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKZO446RJ8sqqtAVzw8lFjC/nqMRHG7eXS3hdUk/OuEaI6AkY4xR6RXKPtMXa+pS/
	 7sj9biEubGlCGn++FpoxedyJe1YjZ4+77L/IgsLpq6P5zxvmlNmADDmNYhq+i0MzIu
	 L4A4Kql+Y9mNIIDWgIpEhBBEZPoP/J2hbLP6qt6D93nQGcxTLlKr8br4DLVTO8FVK9
	 XBRYIE5w8nmP7GAhILj2DUgaY87SPc6iLxsZ+td5ppVp5H6NJFDuaMaG69RWfuVidt
	 Jp7i4V7VQEkEHDbbPbVy4sAVyLdIALkOY7uNnkIFJlnSO3510xB4CbaO5mOLXtUYtC
	 2lUa1u/WE/6jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] fsnotify: opt-in for permission events at file open time
Date: Wed, 12 Aug 2026 05:50:55 -0400
Message-ID: <20260812095057.1573629-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080512-motto-postwar-7c00@gregkh>
References: <2026080512-motto-postwar-7c00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit a94204f4d48e28a711b7ed10399f749286c433e3 ]

Legacy inotify/fanotify listeners can add watches for events on inode,
parent or mount and expect to get events (e.g. FS_MODIFY) on files that
were already open at the time of setting up the watches.

fanotify permission events are typically used by Anti-malware sofware,
that is watching the entire mount and it is not common to have more that
one Anti-malware engine installed on a system.

To reduce the overhead of the fsnotify_file_perm() hooks on every file
access, relax the semantics of the legacy FAN_ACCESS_PERM event to generate
events only if there were *any* permission event listeners on the
filesystem at the time that the file was opened.

The new semantic is implemented by extending the FMODE_NONOTIFY bit into
two FMODE_NONOTIFY_* bits, that are used to store a mode for which of the
events types to report.

This is going to apply to the new fanotify pre-content events in order
to reduce the cost of the new pre-content event vfs hooks.

[Thanks to Bert Karwatzki <spasswolf@web.de> for reporting a bug in this
code with CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled]

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com
Stable-dep-of: db1856ea9196 ("binfmt_misc: restore write access when removing an entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 72a956d243c2e..3df19401beb61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -180,6 +180,12 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
 
+/*
+ * fsnotify pre-content events do not exist in this kernel, so a file is never
+ * watched by a pre-content event listener.
+ */
+#define FMODE_FSNOTIFY_HSM(mode)	0
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
-- 
2.53.0

