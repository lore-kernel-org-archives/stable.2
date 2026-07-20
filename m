Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31A2628D
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514957; cv=none; b=CXFwxVpLwUZMhulqAVglFtf4f1Yrc8D8nCbDi/DxwIg1Udsc22WBwLDsXEDlzkR+M+ibhe7xuSADOnA3hvdHNE3MyU4NgY89fI4dtjTCJ1ZjB1Yx+IP9/qFvqOyHvojy09RHj6PC1mZyQzIWxnvyNzox2iwumIC5M3dNaSwSj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514957; c=relaxed/simple;
	bh=5b37hgQ5qt+w3mDXvmBbnWu4PxA//xKBRMphNj4YNRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMoyV6bhaT9lT29gHt/XNI7Xt3sS4qfYjsQwugasHxG+1K2oL6OoTjVuG/5myt7axhxDF9/fDjFBZWb1VZJSTsXNOg2kURYa2WIuN9l/oMq/9cwBc4ROLBKrXMvGdPf5er7aaOQ5EHXFbEwu/NsFsUpoJa/lKStRi2IoM92M3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq5GdctX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq5GdctX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7CA1F00A3A;
	Mon, 20 Jul 2026 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514956;
	bh=J9PWB+t+CXqmPKbiKvwfRK91Asr8lSQTInb3Y2xeqAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nq5GdctXCUKRxdnopjV94oZ//oPgEFPlZOFfVgQk8xX7YDhcBdCWJE8xYmPNjkrGZ
	 AN4yfCjUrFSXFaCwxhJraOFQ0dCybabTnBQn+DZPm2BiArVkV2++2Kd3OcgtDg+6on
	 E0AAmh1ccqzsSq6jDzoqW0hjRm6bBSKzqV7/bv3YzjGnxUXEnbuzZCxfFBL0xf+cp2
	 WTqcRnMOBjMHorx+T8KAtsSHnymtTGx1y/80tdJPYlu3S/ADVcv13IDn0vZSKEm6un
	 yRv95TI5XTEVTPZBMFraEuBXPC7Z5FBupL6VlRUQhi1Pmo1huo2iKHBeo1CUItb8Ab
	 HQUdURNygp33Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] functionfs: don't abuse ffs_data_closed() on fs shutdown
Date: Sun, 19 Jul 2026 22:25:47 -0400
Message-ID: <20260720023553.2928009-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720023553.2928009-1-sashal@kernel.org>
References: <2026071455-cultural-frenzy-db69@gregkh>
 <20260720023553.2928009-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit fcb8985143540cbcb8e91c0ea8b7fb5d37c88177 ]

ffs_data_closed() has a seriously confusing logics in it: in addition
to the normal "decrement a counter and do some work if it hits zero"
there's "... and if it has somehow become negative, do that" bit.

It's not a race, despite smelling rather fishy.  What really happens
is that in addition to "call that on close of files there, to match
the increments of counter on opens" there's one call in ->kill_sb().
Counter starts at 0 and never goes negative over the lifetime of
filesystem (or we have much worse problems everywhere - ->release()
call of some file somehow unpaired with successful ->open() of the
same).  At the filesystem shutdown it will be 0 or, again, we have
much worse problems - filesystem instance destroyed with files on it
still open.  In other words, at that call and at that call alone
the decrement would go from 0 to -1, hitting that chunk (and not
hitting the "if it hits 0" part).

So that check is a weirdly spelled "called from ffs_kill_sb()".
Just expand the call in the latter and kill the misplaced chunk
in ffs_data_closed().

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 3137b243c939 ("usb: gadget: f_fs: initialize reset_work at allocation time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 5ef9a7a7f3bc30..d416ec8b8556a8 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2086,12 +2086,18 @@ static int ffs_fs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void ffs_data_reset(struct ffs_data *ffs);
+
 static void
 ffs_fs_kill_sb(struct super_block *sb)
 {
 	kill_litter_super(sb);
-	if (sb->s_fs_info)
-		ffs_data_closed(sb->s_fs_info);
+	if (sb->s_fs_info) {
+		struct ffs_data *ffs = sb->s_fs_info;
+		ffs->state = FFS_CLOSING;
+		ffs_data_reset(ffs);
+		ffs_data_put(ffs);
+	}
 }
 
 static struct file_system_type ffs_fs_type = {
@@ -2129,7 +2135,6 @@ static void functionfs_cleanup(void)
 /* ffs_data and ffs_function construction and destruction code **************/
 
 static void ffs_data_clear(struct ffs_data *ffs);
-static void ffs_data_reset(struct ffs_data *ffs);
 
 static void ffs_data_get(struct ffs_data *ffs)
 {
@@ -2186,11 +2191,6 @@ static void ffs_data_closed(struct ffs_data *ffs)
 			ffs_data_reset(ffs);
 		}
 	}
-	if (atomic_read(&ffs->opened) < 0) {
-		ffs->state = FFS_CLOSING;
-		ffs_data_reset(ffs);
-	}
-
 	ffs_data_put(ffs);
 }
 
-- 
2.53.0

