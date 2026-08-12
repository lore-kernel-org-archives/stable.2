Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57F40927F
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525923; cv=none; b=h9zZStYaFHHYlbeWujyCvIBvnKFM44XM6WlbhPJbMa1yubBbGRoPXzYVyLl9UDf0vaLYU4VK+AuVS5b4/Eu3AoudEYQknFU9+A4la6pGn0CU+J8N89P31ooYHaX0u+wMdsFGoRAXR3Dzhy9c+CtULfQRH7tlxVemxW7u2fQdzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525923; c=relaxed/simple;
	bh=uTE1pwh4VD6WQFiNM3/MH7p9YEYKefoZ9mtg14+jePQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDMrvQ6iKKJQSiF2XAC/h+GCakk9hYYRCBsU9BS5wcSfT7c0NG5XnKBXluC0Oyy/QcYr0JSZyFNHxDHv5GFvgSH9kYNDUM2S3BmXY+DPknncayPVJ2fvV8ZBjnSp3396IpWVFpr9Z+WzkrL3y1IUvH5mC8FXcPaveKzJE5UmgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1HY0RnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1HY0RnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE8B1F00A3E;
	Wed, 12 Aug 2026 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525922;
	bh=F0KI4/l6tFjZpykxavbIEmeCQUpDDA29j0ZHslfC6MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1HY0RnLciAugFdza81I6lN70kMAwBYRMe+o2Pxc9cTS+hUQBxA2I+bvXvVPZeJKe
	 NtHNXGZcLd+vj/XxLWTDhK2jisv5fsuTTdAkooShGxYdjcLwANFKPzv/m6NDsbNrDa
	 g4hleF5/Z8OVgjT9QPjw7scf9qtrUHbJz9xhme2A8SrD47H2gxg54APu8+YYuMBRXe
	 69Rlh4VFzLiho1q/X21b22xQ46yBN/M4phOBKa53l2Ny5G+15nroVjK0no0dXW7R/y
	 DT1C9oUhNnG7KhmcRU/XAhA11nBP4JW+8Aqvs57YGhc0LoCkSvsNVre7Mj4qDCGPCA
	 OBeZnEY/HtVwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] binfmt_misc: restore write access when removing an entry
Date: Wed, 12 Aug 2026 05:11:58 -0400
Message-ID: <20260812091158.1359537-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812091158.1359537-1-sashal@kernel.org>
References: <2026080512-populace-barterer-83d7@gregkh>
 <20260812091158.1359537-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit db1856ea9196cf6e015d12199a34c0b9313c7bfa ]

Registering an entry with the MISC_FMT_OPEN_FILE flag opens the
interpreter via open_exec() which denies write access to it for as
long as the entry exists. Removing the entry closes the interpreter
file via filp_close() but never restores write access, leaving the
inode's i_writecount permanently negative. Opening the interpreter
for writing keeps failing with ETXTBSY long after the entry is gone
until the inode is evicted from the inode cache.

Commit 90f601b497d7 ("binfmt_misc: restore write access before
closing files opened by open_exec()") fixed the same imbalance in the
error path of bm_register_write() but the actual removal path has
been leaking the write denial since the introduction of the flag.

Restore write access in put_binfmt_handler() before closing the
interpreter file.

Link: https://patch.msgid.link/20260710-work-binfmt_misc-locking-v3-1-a162f7cb58d6@kernel.org
Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 05c2353094217..26ab9e5e15aa2 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -163,8 +163,10 @@ static Node *get_binfmt_handler(struct linux_binprm *bprm)
 static void put_binfmt_handler(Node *e)
 {
 	if (refcount_dec_and_test(&e->users)) {
-		if (e->flags & MISC_FMT_OPEN_FILE)
+		if (e->flags & MISC_FMT_OPEN_FILE) {
+			exe_file_allow_write_access(e->interp_file);
 			filp_close(e->interp_file, NULL);
+		}
 		kfree(e);
 	}
 }
-- 
2.53.0

