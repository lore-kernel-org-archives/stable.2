Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047056;
	b=vXiIsJ6IHif645ehrpBTW4CsE7XgKoWgFdosOxLgObrOya1/rGwJFXIjRodFThHFw0Ws
	 s/MOvph9aOl1w/6Et9W1WnhbdR6btTAz/WbB6xxq7ZxbgS8fEpW40eH2r65qSuF1ZJadN
	 rUcBtqe/FpwUEUVLdF19X0pJpEf1XqqDBZTz4aMl6YgAu7BfkUkij8cmB5EJT6BkXZkUT
	 1pJebEqV62CR0bV2e7GpZgrYpEyHQhZWFMcEiZz70cSZJYWerElLbbghqkB8EcZRkDXtm
	 AenJpJ0KY10yphunbCyoXuzvpJ7SrTEbC5Cw4cvq3NmbBdeMatZiq6B4I2kUOXZhYlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ygzLvzEustB1t+HakwY8vXFUGilZH9hA5lb20YnfNJ4=;
	b=JFg+u4Ns3KlQ1U1MYjSZupYWxOH75Wq4meGM+4Tf2ImFZJO7j+EMgoVUx3+hrIQfh5oB
	 zPzSY0+LcGza6yjFUwpB5lsauqkVPSHUc4jlbeT1+5cwyyBU2jGvuaYgsVIuMKr+3ZDD4
	 xoIC80gUX03X/0jnZPNM+7cnNB5csQ5zKc4Yoh71qya4cOiphDzh2t/Gs3r/UD2vNcRW0
	 9RNII7ioMPLY9C+DiQJtf3Xz1WxOufO1uxOL986QQjT5DZUVXIEJxKGOwZsEYRTIKnvvR
	 gzVCwVEPs5hRsMoM+5aznZ6k8QZwUb9rmBbTjnhOdYFTk1N/g7VqSsxSGJk/dYRabjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqMNqxGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqMNqxGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A99B1F0089F;
	Sat,  7 Nov 2026 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047055;
	bh=ygzLvzEustB1t+HakwY8vXFUGilZH9hA5lb20YnfNJ4=;
	h=From:To:Cc:Subject:Date;
	b=IqMNqxGDsvQLKaPU+LwhcLY/Vk433pVA4YAA+qj3COcHev+SXX6xiEDwJEs3SqVQl
	 ikRJplnW9n3Oz94+Quu8RUrrCG3u1WY6O+zjaIvebuoPkX6TpLMOVA8QJZgXFk4OCY
	 7NBqC4z67xATCW6Yls9b0Kjert2dsAOIir7LyH47lJevXQ7H3kFbS/6eqf5Pq4QPOZ
	 EyORvOMo8KScs83LsnAsk2iiHdsoaVWbY7O18wUkhRX8QbrlevVH9yd51R+2D9vdBL
	 nNstPEwhu+Aq+0Iv1XUX++pjpW4LShDxVILmQWQrtKksE55w5f9IZlNzsSRCD95uKE
	 HKl0eA77rtbWg==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: NULL vol->vol_ino in the load_system_files() error teardown" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:14 -0500
Message-ID: <20261107052414-failed-6.12-a0c022c1da5b@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a0c022c1da5b0fa30c61bd5b28db9f639ace5bf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052414-failed-6.12-a0c022c1da5b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a0c022c1da5b0fa30c61bd5b28db9f639ace5bf5 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 7 Sep 2026 15:08:52 +0800
Subject: [PATCH] ntfs: NULL vol->vol_ino in the load_system_files() error
 teardown

The error unwind of load_system_files() drops vol->vol_ino on two
paths but leaves the stale pointer in place while it keeps iput()ing
the remaining system inodes ($Bitmap, $MFT bitmap, $MFTMirr; $MFT
itself is dropped by the caller, ntfs_fill_super()).  A third path
carried an iput() that can never execute: it sits inside the
IS_ERR(vol->vol_ino) branch guarded by !IS_ERR(vol->vol_ino), and is
removed along with the stale pointers.  Nothing in the teardown
dereferences vol_ino today, so this is pure hygiene, but a stale
pointer to a freed inode surviving the unwind is a trap for any
future code walking the volume during teardown.

ntfs_put_super() and the ntfs_fill_super() error path already NULL it
after their iput(); do the same here.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 49ec1eb1520c1..9f5cf65fd3a55 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1536,8 +1536,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	 */
 	vol->vol_ino = ntfs_iget(sb, FILE_Volume);
 	if (IS_ERR(vol->vol_ino)) {
-		if (!IS_ERR(vol->vol_ino))
-			iput(vol->vol_ino);
+		vol->vol_ino = NULL;
 volume_failed:
 		ntfs_error(sb, "Failed to load $Volume.");
 		goto iput_lcnbmp_err_out;
@@ -1546,6 +1545,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	if (IS_ERR(m)) {
 iput_volume_failed:
 		iput(vol->vol_ino);
+		vol->vol_ino = NULL;
 		goto volume_failed;
 	}
 
@@ -1706,6 +1706,8 @@ static bool load_system_files(struct ntfs_volume *vol)
 	if (vol->logfile_ino)
 		iput(vol->logfile_ino);
 	iput(vol->vol_ino);
+	/* Do not leave a stale pointer behind for the rest of the teardown. */
+	vol->vol_ino = NULL;
 iput_lcnbmp_err_out:
 	iput(vol->lcnbmp_ino);
 iput_attrdef_err_out:
-- 
2.53.0




