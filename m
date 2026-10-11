Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96433290F;
	Sun, 11 Oct 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734181; cv=none; b=qM6SZz/rjQP/0/h1FKkZm5HZgcApSsGy0JPNkRQweAZ0x9Y68Yl9rCYw+lZ0kO2K5MRTPyWxr8lGtQulcR+6r7sfCDoeHjOtMI8k8FgIUgn4emSuuN3n6j26JJID9IhMovJ7YxGojklf66uPlbg/9cGVvUDjbTU89EzVWcP4+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734181; c=relaxed/simple;
	bh=ixYbEBng1Z/vJcMjdWn8zuVoMh7w4ZMAYwqxVmLBn3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCkfZMWjdQw//FSHRCQ5dew4vVa2j6lFKXeJOQdntwsZRdl0QJkJAf6CPkIK+E6C4DCZcbE+iRZOdm9IrJV7m6Mu3OT0Hd5eLEyZOijV9owh2dRKkj21Mhx04zmHwtn4b/8OTGiJjaYUwlsxpzEFe9d+uuNmejZnmHsYMCRxZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8n04Ncl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8n04Ncl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E07E1F0089D;
	Sun, 11 Oct 2026 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734179;
	bh=AF4WkHnj45u55Z0xiBw3Yh4Qk5pJa18weW/2YZS3R5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W8n04NclglOPHg8BhFnzWSNk3CLnl+aCpaEwVSqYTtI4+iNqL4NPRaBVG/NkfzB2A
	 wp4LxGWescBaSt7hvrrhjvCSCEQBCoIwivEZtcCHdhp65rIg0jkhZbxZIC/ctZvGjb
	 Ybvl3aQaGUQyqpfVGQMGxm4pLX0dH6oaLVp4p2JyfSFTxIBpPZUI1kShn8l4CUzCAT
	 VQKNGVZILK6QnerwLXYQEoGpKzlSodR3bVig8XPuxyDQowDVdbADDLeDKOTKiwLGRA
	 9UL+kuGeLAH87Foxm5pLLNcH2xfyv7keUdFXST7mbseRhehK6aQRGVNFI1N2HykNeZ
	 o9c2HhJqSryIw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:02 +0200
Subject: [PATCH 02/15] super: don't warn when resume thaws a userspace
 freeze
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-2-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ixYbEBng1Z/vJcMjdWn8zuVoMh7w4ZMAYwqxVmLBn3g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jh705KtPwr9S+O2Jb86eOp+wpw5vJwpXZErNCItv
 pieb4tU7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI8Y0M/0yClPWK35VMXJ8k
 Mnnhu+sl/LZWe6oOOXtWtRjPvn1bPIzhf26R04nlq+9Xvpr67a+HTp7etJjP6c9e190u6a5ybzw
 UxQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

filesystems_thaw() is called on every resume from suspend or hibernation
no matter whether filesystem freezing was enabled. It walks all
superblocks that have freeze methods and calls thaw_super() with
FREEZE_EXCL | FREEZE_HOLDER_KERNEL and its owner token. It relies on
may_unfreeze() to refuse every superblock it didn't freeze itself.

But may_unfreeze() checks the kernel freeze count before it checks
whether the superblock is exclusively frozen at all. A superblock that
userspace froze via FIFREEZE or that got frozen through its block device
has freeze_kcount == 0. So every resume while such a filesystem is
frozen triggers:

  WARNING: fs/super.c:2165 at thaw_super_locked+0x85f/0xbf0
  ...
   filesystems_thaw_callback+0x196/0x220

and with panic_on_warn the resume panics.

Check the owner first. If the superblock isn't exclusively frozen, or
not by the caller, there's nothing for the caller to undo and that isn't
a bug. An exclusive freeze always holds a kernel reference so keep
warning if that's not the case.

Reproducer, needs CONFIG_PM_DEBUG:

  mount /dev/sda /mnt
  fsfreeze --freeze /mnt
  echo freezer > /sys/power/pm_test
  echo freeze > /sys/power/state
  # WARNING in thaw_super_locked() from filesystems_thaw_callback()

It fires on every run. Not a selftest because it suspends the machine
and the only symptom is the warning in the kernel log.

Fixes: 1af3331764b9 ("super: add filesystem freezing helpers for suspend and hibernate")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 15ecfbeb92ab..4e8f7f48540c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2165,14 +2165,15 @@ static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
 			return false;
 		if (WARN_ON_ONCE(!freeze_owner))
 			return false;
-		if (WARN_ON_ONCE(sb->s_writers.freeze_kcount == 0))
-			return false;
 		/* This isn't exclusively frozen. */
 		if (!sb->s_writers.freeze_owner)
 			return false;
 		/* This isn't exclusively frozen by us. */
 		if (sb->s_writers.freeze_owner != freeze_owner)
 			return false;
+		/* An exclusive freeze always holds a kernel reference. */
+		if (WARN_ON_ONCE(sb->s_writers.freeze_kcount == 0))
+			return false;
 		/*
 		 * This is still frozen multiple times so we're just
 		 * going to drop our reference count and undo our

-- 
2.53.0

