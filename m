Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAF3976BC;
	Thu,  9 Jul 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636219; cv=none; b=IBRktZWIfeG48x71dJfqVtITRxu1qGUcffqEvgq7C7MZLIvZMFFXMA9/kxhimnhf200nb4tUhXVEeKugF00VVv9yzXKZ2XjROEOsTHWlP0rScrh8t+i4kND5+Y5vNypoCtDidsdL613RI77R6WHuDf3Sm2KZP31PHsei8Ai6QEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636219; c=relaxed/simple;
	bh=t8nER3lsjLzcjeJujucgoUoGrAUWFYH7V6NQav6UZeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KzHM6n6He9avis+vt9VrAKpH4+IFfqVXY6pA283b1dmPLV71qSYBotpbSETkQZWbkiwS9wp8/8fvNbBh8DUDIMY/JjQuCc5QI17efaiLPQV+u9E6XY89Z6rF2S9YH+z8BFc5FO55KBLAsKuq4KkX/1XMDbDFbaFfnZKrC+heH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/2udjMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/2udjMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E911F00A3A;
	Thu,  9 Jul 2026 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636218;
	bh=dpRcp/2dJk6gV7eAG1xmqQEL3beSixOls/uDr77Rs8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H/2udjMJKhsRxr1MvEvq4eUPt+vKw9iK589MD1x2J7dTv4kCE+oEFU2IcfkPxCjuP
	 YkPzKqZemTAGZwKoIg7WFYiyjx/Ni1q57XqOcWkoX0bpmgtsEH2gibYZzRRL3IKbt0
	 Yb/kXjj2mNlpWrdZM653UCHCCenx8Cw3buKcFS4jcfKhiJJw1mT7Dhk3z2XNd9EGuC
	 kHAnuRw5NX8X5eFHLLLkPuWd4FskhVHLILyDT1ke2L+ezRUvUCa5MGzGlOxhKv/TtS
	 xIe55GnToFdt5tUzy2Jz8pEzl1A2gFqhvDDCRR2Xl1ODDiwkE9fRDqwxLPo/GNKK56
	 UY57bq5ggIXjg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:29:56 +0200
Subject: [PATCH v2 01/23] binfmt_misc: restore write access when removing
 an entry
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-1-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t8nER3lsjLzcjeJujucgoUoGrAUWFYH7V6NQav6UZeY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHzNfVZ7rshjEgfT2v9loRPYj9RdS9xe+fjUw1kPW
 WcYuVaad5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykRoGRYcoKtfvZnEX5xtq8
 KtwpynF8d88c5F4jtuPxFfX1f9hypzL8Zj1oW7eLw/LtpmkXVbhPPHzw//sZmfUZtwQFJZgb5n/
 awQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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

Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 84349fcb93f1..de50a7468b07 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -162,8 +162,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
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

