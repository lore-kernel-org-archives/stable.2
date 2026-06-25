Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A73D9688
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410172; cv=none; b=RuQXfv1TqFf1DJdde9SOF8mqw1KBDbrXpot0VPBRRQQsirwYK8OuGdUkloFV/cT3pdTpMTlhYLhiLMVDyIvkqyQYGj+8zf5iNX3o3zTE/VloS+s74Wmu9TGl7q8zTi1kpL45QkjiM+8PC0Z9NnTo7CGkb7b0u0rEXde9NXwOrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410172; c=relaxed/simple;
	bh=c1JovLtNMIL8kiSbfL85fembU3MkagrZ6hsCffMFG/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fskIr5BISTBgpbR/MVW2JZR0nSSSdc0U5EcHmBPqAePBp6U0Fs5Wf6G5KAWs3uD8zhVkU1wpYzZGuxljV0U1oy2YXlEDrHgx1vU8EQPfXTjhgSDWsW8ZjWOS1Sz5FCa9rWYJxu6CHHEqC8ODEV4lpB/6Djb1x3yelPZTTyGuljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2jxmSrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2jxmSrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD41F00A3A;
	Thu, 25 Jun 2026 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410171;
	bh=kbRZmQgyFT5qaUe7Qtpvk+Su5KAJ1RI/2oxuTzmOPSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2jxmSrqeBpJoXT/S8nDdwu9vCzQmHWN7IjEH5pJ6bgyejtnJBIbvO6nnnSBt8oU1
	 B3xTBODZn0NiaISydZeRMQcx4rumCK/n6codLyYXAqsoB5BT042enSPe+p4bWKxTFv
	 5nTX01puPR7leo+rkpIz2DTA1qwhdqmdvDm9UizKC/BL7BG1Ieg03RirR9MvKPj5SF
	 HSB4eNYtrSVBTFXXVj+P0KzF2WoRdX4kWskd6xOxSWON+X6TL68BZRoGBIBCBP+eAD
	 MkVu3hcYKrwB/O5o/ZrhKB2upsGb4TrLMpfz1kXvgtwo30G5vLsczVTanS6dZT7NkT
	 43tKsiDYVaanw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Bombo?= <abombo@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Greg Kurz <gkurz@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] virtiofs: fix UAF on submount umount
Date: Thu, 25 Jun 2026 13:56:09 -0400
Message-ID: <20260625175609.2544109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062516-legroom-wrongdoer-ad3f@gregkh>
References: <2026062516-legroom-wrongdoer-ad3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 06b41351779e9289e8785694ade9042ae85e41ea ]

iput() called from fuse_release_end() can Oops if the super block has
already been destroyed.  Normally this is prevented by waiting for
num_waiting to go down to zero before commencing with super block shutdown.

This only works, however, for the last submount instance, as the wait
counter is per connection, not per superblock.

Revert to using synchronous release requests for the auto_submounts case,
which is virtiofs only at this time.

Reported-by: Aurélien Bombo <abombo@microsoft.com>
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Greg Kurz <gkurz@redhat.com>
Closes: https://github.com/kata-containers/kata-containers/issues/12589
Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kurz <gkurz@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 23bc96887abcb7..a8c080b485d036 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -330,8 +330,14 @@ void fuse_release_common(struct file *file, bool isdir)
 	 * aio and closes the fd before the aio completes.  Since aio takes its
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
+	 *
+	 * Exception is virtio-fs, which is not affected by the above (server is
+	 * on host, cannot close open files in guest).  Virtio-fs needs sync
+	 * release, because the num_waiting mechanism to wait for all requests
+	 * before commencing with fs shutdown doesn't work if submounts are
+	 * used.
 	 */
-	fuse_file_put(ff, false, isdir);
+	fuse_file_put(ff, ff->fm->fc->auto_submounts, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
-- 
2.53.0

