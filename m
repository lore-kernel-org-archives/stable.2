Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047819;
	b=i7lZnxuBqyTdeEi2hxZJQG+A1eiKe2Hc6czQUXjGSnY1SrYTL100WpDJWLwMPAtFh/cE
	 mFyCd3CqgWk7/9+A8LUMjysvPQpk5S6PqSbTLtDrGL4+iH57AGZYa3sn9M9OBKm5NydKT
	 X7hNElY+yZl05ekTZtucNObKASwc4bAaK2QSnPI9kj5YWrCwKrePJBe+uy+G0TOxX6frt
	 5EdqESm67kWh6s4wz/jMqi9h8C6VDgfCAJUyajKU16tShCRH+lu6waAKL7vZSCg3Vdzw/
	 LO5Iq4K5qCOXatMoev4SvHo95sYPXoopg/ZRJUOfRE5PessWBXaUhzVZbroH9b3ejkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047819;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3vums1pucQ0/lhb7z2mBrrvyPROhJIL/mHbASTKjTJ0=;
	b=uoSY/YjWXycBWAP4bHakgqe0ZYx5yKfoOwDeA6rboHk21DC28CWU7IYeds7pq9PpBf1F
	 4toJpPUWoAeIvX/v771WmlxpWIwumKfP8qAcZ0AqvAKonJyKTLrKa9GYlLReE2wkrZ+Uc
	 MeGl4DpEAqvyyfziXUOnkqUweUEml5+tWT0fAvM8Rr9OYnzi9l4gJ69P6SNgWWmYy5EyL
	 3bDlKBxd9YKBpQ5cLsNdHlCPcpICtrcbrX8S1BmBvko1rPX7bjiLKHVqyCywIorDkIS0s
	 1V6Dxh+eNVtLdcKKlQDDdePZoZ/FHe5PGWnCKKmZv3wna2sKyNdnK5giEvEmq31sm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEMPSW5v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B10606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEMPSW5v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85A11F0089F;
	Sat,  7 Nov 2026 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047819;
	bh=3vums1pucQ0/lhb7z2mBrrvyPROhJIL/mHbASTKjTJ0=;
	h=From:To:Cc:Subject:Date;
	b=DEMPSW5vssC/we2+logNAZV1eC6POSym8tc+I7IdwEn1u3k25dLhDymw8BxcS9fml
	 2OPPBpkRmhCwfe6aSLQtvl7hQYHe641W04BzGiWSsWL6BGtQOk4sWsh2xWmjov/Kp2
	 oDekMrmujznJW2fCRwzDooBycttranbQe06AKuxYTs7DdfzGjj6xl5gPDmNd/toQG/
	 ays2boQYUxfBoK9jU7UA27XyS1BUrxWTgZ8yvEBlfIzpcHWJjjfRzQAbRtSBVMJ+f8
	 E+p4rkPZo2lSsEDYgQgsO6SxfbDv/odMJMwrbZON5cpFmGpBUAtoEURNvLhlVlvslC
	 L4G1FHeolZ3kw==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: NULL vol->vol_ino in the load_system_files() error teardown" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:57 -0500
Message-ID: <20261107053657-failed-6.6-a0c022c1da5b@kernel.org>
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
git cherry-pick -x a0c022c1da5b0fa30c61bd5b28db9f639ace5bf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053657-failed-6.6-a0c022c1da5b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




