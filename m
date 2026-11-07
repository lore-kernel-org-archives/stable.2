Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048181;
	b=lrpQwikcnmAyiDFGNM7177aii28pw6DeMnPSWovJWLnoJxNEzY+YmSFOnJxeXifIc5ur
	 25v0CAJOF7isBwdHnw0tTQuCWo2UseB4CkaAOfdVuNAfgAvQyhinDKTLPFn173v57094N
	 fxYQ3CwKRr/UHd42PxKkK9HU/RMdT2HZbojgbNQiWBca08xhL9RetLCblgmLhdKtaEu+G
	 +6QhDG5arZP5vap+QeTnFOKzwXvAeTxhAT6yX2A2tFLGiKOyNZ4iXm2fuSPWyZJXt5nJF
	 JGbHQ4q++IH0Oy4h2TmSP9MhfmQlBL6/tNAHgROLLvsjlDjNrg1rTKBTDlNS6hX2YSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dOQdaIgJHb4w0hSjn3oQWJi4dJauFAOUPVWhWAzhV8Q=;
	b=1tqAKnSYUVOA4TKnlp0caLvNuUhS6DbZnlJYZDpeQzjH4SBRj+L0ecx7me9Cj9SMwRQt
	 TUlG12ka55IGyN7lsE7OZpXhM4phbGWdJmTF0Mxe4LgWv8t/Gd7i34sicn3UrEuZIXIbm
	 EFwEfscNHuWjCJfICpF4YoSfmcKHCj7jnspPx6ugoSO6Mf3NzWcRug53A+5ciTCR8nptS
	 Ikc0Q0XpcmQ56+mJdNRNSyr6cneiO+MTEg5bW2BKEBk+yslNmQd3V7RelEf3df7SAr42w
	 G/TJboET38F7iakv7pzNgUpfTYCvKuEd/ZxppKavEj1eNWDIGuOhS71dQDVaNci48jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOR+tnj0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D75606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOR+tnj0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC331F0089F;
	Sat,  7 Nov 2026 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048181;
	bh=dOQdaIgJHb4w0hSjn3oQWJi4dJauFAOUPVWhWAzhV8Q=;
	h=From:To:Cc:Subject:Date;
	b=mOR+tnj0z0O7b/fAVjfM7Ya9ZMjVxMjmEGhKMPy9WJnCbOJtzZ581DWQRjT+CbVCf
	 U/xNOmbgA74zZt4eS19HvVg4MhCrIon3MheHoYoWfuOsGnzLeocfwifCh+Lvdgp1VS
	 PI1xRIwH/rMRouuA3mvjVPPfsbeDBQ96eyzO2fG5C1t2uNRTesrkdK3y3/BTEeYqqL
	 Upe5A9vSU/gtNV2/iiGC/GyVhXz1ddo283bp2YGhV2Ttd/eFNq9k6Gy6tZANShKWs/
	 XboQu3/yL1GXqldYbBc73Ob/0THTyBnhWtykfiOBx9lPVirsJwTM7wqSSJbnQYIXdb
	 yx+IT3G9MCNCQ==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:59 -0500
Message-ID: <20261107054259-failed-6.1-62ee3da38f41@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 62ee3da38f41bef83c1cf250f6816a0ee187674b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054259-failed-6.1-62ee3da38f41@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 62ee3da38f41bef83c1cf250f6816a0ee187674b Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 10:25:50 +0000
Subject: [PATCH] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()

mtd_get_sb() is called with a reference to the MTD device already
taken by the caller.  When sget_dev() fails, the function returns the
error without dropping that reference, so the device is never released
and its refcount never reaches zero.  Every mount attempt on an MTD
device whose superblock cannot be set up leaks a reference.

Restore the put_mtd_device() that the fs_context conversion dropped on
this path.

Fixes: 0f071004109d ("mtd: Provide fs_context-aware mount_mtd() replacement")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/mtdsuper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index c709ff7aa6b57..02eede3fe582e 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -31,8 +31,10 @@ static int mtd_get_sb(struct fs_context *fc,
 	int ret;
 
 	sb = sget_dev(fc, MKDEV(MTD_BLOCK_MAJOR, mtd->index));
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		put_mtd_device(mtd);
 		return PTR_ERR(sb);
+	}
 
 	if (sb->s_root) {
 		/* new mountpoint for an already mounted superblock */
-- 
2.53.0




