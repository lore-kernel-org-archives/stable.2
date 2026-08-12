Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03C322C73
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536146; cv=none; b=s2ENg+dGPjdeGYTfPCegk+83xmQ66EFuyTanZg/eFPCb6WyUjjc55D5oP1aINzLv3Em2aTio+sFoU5KebYVnq5t2DsnYGHkq7ia54hmQ4utaphBsGsGRTAm4QPTyb03ViMNaR5sgFVrokHZ5j5Rzj8uLw5MhyT5GlETltfw9h6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536146; c=relaxed/simple;
	bh=lhzsMhN4aSYoW9B092DS7kz8rBUWlt8Y9fznzqrYx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei6vtilQg29nb6ucwA2u/+IG3sX+UxFHpU2cwoJVTviweS+ehyWwWxNFo4XbL6Wus52xakq0m+x576jJmGUX4l41OaZrgCwnAVD9rEVtACSOvJ6rLxOdocFYO6hbA6NupU/y14/Ow6kiwBeK0b+V7H1UZK5ezRVzu3TIpNwsHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9nade6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9nade6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4251B1F000E9;
	Wed, 12 Aug 2026 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536144;
	bh=+vWIZ8ItRt4duU42BoaPG1m2ZDGt9itRCS+hUP5NFCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S9nade6hBDFbszrHPAOUA94lfvfbZaXgP6qkJRh/G9Gv6Q7ydTD8KFUC6ChkVHWHI
	 oG7Drc8ha0w8Z7ObxknXPR+K4FLx/RLXDbJosM7YycgfULDjXnw24Va9lQrP/EqpIM
	 LZ55lqthzoTFHlhIoxbCuwKgngrxbU4i3ai+JtBTSpgJmm4GPvrtoDE8MbjpZUMw7M
	 iFADrUVUY1IQV5F1bgX/gRrOjeWdiAPQNDuICa8X9c2BxY24ORPXZEHkDWd7WKQwuV
	 rV3d4b20qN03eUNu9cQgeAQGhSDfUNiKperHVIFfUyeX4EuOTHMq12O5U4EJAP8WGD
	 /Xd/ji2ZhhpgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] fsnotify: opt-in for permission events at file open time
Date: Wed, 12 Aug 2026 08:02:20 -0400
Message-ID: <20260812120222.1989615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080513-stubbed-clear-8ac9@gregkh>
References: <2026080513-stubbed-clear-8ac9@gregkh>
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
index 11294a89a53bd..3134c21d8bab0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -178,6 +178,12 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
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

