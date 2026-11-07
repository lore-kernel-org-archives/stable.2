Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050227;
	b=larocVgAreBY8YJVxfUDkzPnT5BFKWRe5zkbqHGx4vuwoaT/rAb09U8gLCcRQnNbCZfP
	 U2TcDom0x/D2pCfvZnq3QYjob/H/R8qgVl3c7AfTgMTGINfy2+Q2ILcKZN6YPfKjS7tfs
	 +/WP9o6x1WhC7PpWzhzOmdhZRyMS4oYUc9QWOwdx/7y5YqZQ589tXEB7p7rzIfJhIVeqm
	 DRpvKZ78OWV04hFk0miu4MfwgBK6guIZoM6Ul2IFMcW9b+nFdiw3Lg66zfmSCsdtaALXj
	 WHEM7zVZY77gvoXbJVsuhLXiMLhX9HzEFElIFIgbavlC3I0/x4A/yByP5ybYW7KuvRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XCGt6M3Neb+N85re83b5dBnDYDveDEsVVLdRhY/ynw4=;
	b=ivlDpW7UkuWjO+edRPHFWq8WmoE97GNoqvMynY16cqfEz7GzW3uvpfnwSbn/w2gekBUq
	 xgbCz3WYlvVrswN4pjRwMGgM0W4MYATZgjobkCS3NHMtB4gAgEZBTcAap8x/0xPH2cqRs
	 iM3nTXUa7y+bsqtN64cfrbJ5Tc6Xc+3FjjW5A/IbdPuW3yiZo2uNG2UocUn7J7TLTvwpn
	 Lk06nf3M/7E1RgSnwyzrly3yfTzifEgZeTuNbm8Z8nP/UYl1BU041EB6guUnIDYLqRnU4
	 gKJj3rwN8lQe4/AhKsfFWTseS1MCeL9f4HjKV6OSHc7Ga+ja9wX4boypXNdcEIQD/+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OTqVz/F4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTqVz/F4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7920F1F0089F;
	Sat,  7 Nov 2026 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050226;
	bh=XCGt6M3Neb+N85re83b5dBnDYDveDEsVVLdRhY/ynw4=;
	h=From:To:Cc:Subject:Date;
	b=OTqVz/F4S8MHJihAasTZHAJaAZLwv/9d8ZvLLlfsxl8B86WoEyE7/mO+I0HwhEK7c
	 OzMBh+p7ZjsnGMydlVSmMfN066alTOT1bLHiFi33EekTZn24EQvrp9TYe3/6sDHk/n
	 p1fv/kvPaMD+sqHEteNxp9gN1xEF5uzeAdL1EDwsQO+FP2jBanKGLkM10XnzE8r6lW
	 LP0dlbYlZOqL8I8QrZR3O5PPEK5wrV7Yr6kxI1IJZ2EFrCRsDAVmNfsNLYaR1EZH0V
	 ZUK9RTn5c4CdBSILd10pfUi2u5YdgOCYXFPbR046ui9yjzvIVCfy9j3wYMZZHj6vEV
	 +/6IeSAPJy5nw==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fuse: don't drop destination page cache on a zero byte copy reply" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:05 -0500
Message-ID: <20261107061705-failed-5.10-f7585e1ce341@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f7585e1ce3418ec282485854b3d8d31c6a961e37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061705-failed-5.10-f7585e1ce341@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f7585e1ce3418ec282485854b3d8d31c6a961e37 Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 15 Sep 2026 16:53:41 -0700
Subject: [PATCH] fuse: don't drop destination page cache on a zero byte copy
 reply

__fuse_copy_file_range() clears the destination page cache after the
server replies:

	truncate_inode_pages_range(inode_out->i_mapping,
				   ALIGN_DOWN(pos_out, PAGE_SIZE),
				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);

A server may legitimately reply that it copied nothing, eg if the source
file turns out to be shorter than the size the kernel has cached for it.

If pos_out is 0 as well, the end of the range is ALIGN(0, PAGE_SIZE) - 1,
which is -1. lend is a uoff_t and truncate_inode_pages_range() takes -1
as its end of file sentinel, so rather than clearing nothing it drops
every folio in the destination mapping.

That is not only a cache drop. truncate_cleanup_folio() calls
folio_cancel_dirty(), and fuse_writeback_range() only wrote back
[pos_out, pos_out + len - 1], so dirty data elsewhere in the destination
file is discarded without ever reaching the server.

Skip the call when the server copied nothing, since there is nothing
stale to clear in that case.

Fixes: 9b46418c40fe ("fuse: copy_file_range should truncate cache")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bf7cb5905385..2aa575a02e054 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3062,9 +3062,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
-	truncate_inode_pages_range(inode_out->i_mapping,
-				   ALIGN_DOWN(pos_out, PAGE_SIZE),
-				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
+	if (bytes_copied)
+		truncate_inode_pages_range(inode_out->i_mapping,
+					   ALIGN_DOWN(pos_out, PAGE_SIZE),
+					   ALIGN(pos_out + bytes_copied,
+						 PAGE_SIZE) - 1);
 
 	file_update_time(file_out);
 	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
-- 
2.53.0




