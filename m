Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047355;
	b=nKES/gSh2+zY1KV0XLYGKZf5SdwujCBddYuwhETrRDiE2OEemrVeoXrZyTGnVk+lMndD
	 qkwvFbEEPRUucPlLq0jqtVHwr9KSlhiZiaPTm0EflTp5rOVbR1fAOOsltxi596+LmMgSb
	 8116JK01SlebievI0i4dHsk5OxOSL2DJ0avv0aO92DJeeeM1C8/HvJniYbyqYvnLKZAfe
	 4GfwhAWiGJaxVjTHFdff637lM3O3rJfM7lmJPy8VklR/OZYE0NHuopFnyf5Fz4tZTkbUd
	 9r4Tnnh9Snf2n9iKM+igvOxur3icBdkBjkaBqKJtKkOv5jQxF/VbvRc8rwe42RLog6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+Fuyua6gU7Ej1bXzA7wnBYeq3YKNfCNgeqr0FVB93W4=;
	b=Msm4yxIqMDj0ndMJ/EqfW2OgE1npVXv6F8w3kdwFQl55qk/iT3KAvgwQrRNyne7t0I7l
	 QrtHT2zgkroYtebc9dxBbq/D156Ji4wVdD85ewForVoKBSAO//CKE4iEQgJPCs4cxsCHS
	 O/F3kdyqZCIUnFfoyi4X5m5fXyqV8YbHEjPP0jFm8A9xAmrJw0r4XrsCEzTRgPW4xF/KG
	 yriBO8yVZQ4TITWWd20YoO7xxlQckRszGWMTSQ3NFWlGf6rbnU/IOAPrt9exUuGeoZZLf
	 hceWgOpdYXli0X+x/KQlEPplm047u3HyaAVoxJMXx+y/pXzd7ofgfElcAvGx0FksURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YU3oZbMz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7721606D803
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YU3oZbMz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF911F0089F;
	Sat,  7 Nov 2026 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047354;
	bh=+Fuyua6gU7Ej1bXzA7wnBYeq3YKNfCNgeqr0FVB93W4=;
	h=From:To:Cc:Subject:Date;
	b=YU3oZbMzt9pieS+Wb2fG7u16qrJb6S82nPT+oKxXwunZP5kL8VORv+5Mgska9UH9B
	 sn27NxnDcwpZZJaxv5Sna4Ec8WfYceOEn58cTj6DR4hlmw9lnp21jQ9/yZaK7Xzy2S
	 qpXz/PKF2bMx4TyOL7eH4XJm+QMLjFR894y80IeHKddbekEPybsXSwFOlJ5xkGbSjW
	 6KeLFq9Dhc+V/4REFlIlxKkuOMIi/QEH2yzwKn1BbhQshJU2eVjos8vxrMLseRWMqt
	 REqQg6VeCLNXmqwyzWzAxtQeMl4F4aGFiyivgt24onN+zFXy7HBkyCIXY/BBamhtdM
	 QfpQB6w2ecaGg==
From: Sasha Levin <sashal@kernel.org>
To: jiucheng.xu@amlogic.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: force out-place update for all writes on compressed file" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:13 -0500
Message-ID: <20261107052913-failed-6.6-a64a3fec11e7@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052913-failed-6.6-a64a3fec11e7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4 Mon Sep 17 00:00:00 2001
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Date: Mon, 7 Sep 2026 19:35:42 +0800
Subject: [PATCH] f2fs: force out-place update for all writes on compressed
 file

For compressed file, compressed write may fail and fall back to raw
write.

-Thread A                                         - Thread B
  - f2fs_write_multi_pages                          - f2fs_down_write(&sbi->cp_rwsem);
   - f2fs_write_compressed_pages                    - ...
    - f2fs_trylock_op                               - ...
     - f2fs_down_read_trylock(&sbi->cp_rwsem);      - ...
   - f2fs_write_raw_pages                           - ...

Thread B acquires the lock first, which causes Thread A to fail lock
acquisition and fall back to raw-data write.
IPU_FORCE is enabled on small-capacity storage devices (< 16GB),
so f2fs_write_raw_pages() overwrites the original compressed data
in-place.

The in-memory node has been updated with raw-data addresses, while the
node metadata stored on eMMC still remains in compressed state.
If a power-cut occurs before the node is flushed to disk, on-disk
inconsistency arises: disk data is raw, yet metadata treats it as a
compressed cluster, leading to decompression failure.

To eliminate this risk completely, force out-place update for all
write operations on compressed file.

Cc: stable@kernel.org
Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bc53ac21efeee..22de00754678c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2914,10 +2914,12 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (f2fs_used_in_atomic_write(inode))
 		return true;
-	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
-	if (f2fs_compressed_file(inode) &&
-		F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER &&
-		is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
+	/*
+	 * rewrite low ratio compress data w/ OPU mode to avoid fragmentation.
+	 * If IO comes from compressed write path and fallback to raw write,
+	 * force out‑place to prevent metadata‑data inconsistency.
+	 */
+	if (f2fs_compressed_file(inode))
 		return true;
 
 	/* swap file is migrating in aligned write mode */
-- 
2.53.0




