Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E59408611
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525922; cv=none; b=AXoYZh8f+W7VxzfU34VaB4pRNAKRGObP5YyWHnsY2cx1LLcdbdWzN2xF6FbJ9brg2lhaH2r+3itxllMhPvcdxKj8yGn9mYaXD+OEImV2MVC6AOcIAqqVxFS/S6iMO4EMHgWgqW3TWi0YgaSZ4YjnaduN8+ArCwJDgHf9oMa6jic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525922; c=relaxed/simple;
	bh=q/emhaSTF0sE0YMeLnKowoJffg/DUC4+TR4pN/1mryY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnFvxmvxN4uNMepCDPD1f0yIoGZVugiYDQxcVTzb44/3EkuGcjEaXFfhYhzz6e+3Hdm+t3psTu8kgmLnt82/I+MSn43L6zrJ6r9KtEBtxOC5G9T66GvdDgQ4eeBJ/5fZCxj+CJDvXo4X+FgFBLQorJcLZcWhDgDS9do+8AgZCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK3DeiY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK3DeiY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E691F00A3A;
	Wed, 12 Aug 2026 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525920;
	bh=29JnB9AwVO/NgsaW653k5/255h6ocbrZRHHswEwzyt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iK3DeiY8nRCW+k/3/JA2fQlN/+ANiPSbB9narazyERVWO8XdFh+v64yUVsmse2Mgw
	 JjCclv5W65UuHujL2qKEwkIzAICcWyxLvATi4V+C1I3QhIKm9EEW/12Tr69DWnQNXD
	 Fws/H15uQZr63aMAyJx4W67UHsEIf5tA8ViB0MR7KGeuqn3bfPqkdo4wj9QRp2ohx5
	 592KVSgXC68VoGkTLZN6u80fo1zprbcX3jSlCla2zRmblrx5dHCTsqyWWY9wDV7AGG
	 pRQt26oKXgbIP+gkuqCtAgLM+KmExud/Xthqco+dEA8scP34oo8s1GLRdtVt4fmTn6
	 ERkSummIQNpPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] fsnotify: opt-in for permission events at file open time
Date: Wed, 12 Aug 2026 05:11:56 -0400
Message-ID: <20260812091158.1359537-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080512-populace-barterer-83d7@gregkh>
References: <2026080512-populace-barterer-83d7@gregkh>
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
index 02c83cd07d4f2..c1bd804b86153 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -184,6 +184,12 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async nowait buffered writes */
 #define FMODE_BUF_WASYNC	((__force fmode_t)0x80000000)
 
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

