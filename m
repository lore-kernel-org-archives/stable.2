Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92940963A
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528262; cv=none; b=Z/ExomweWJNUNfr4aZLeQ10OB+QF/avmNjshyJSWRo8LA5BKVYNmdo4sgt+rxbv+QxhodGRp2CG96bLCCW0SGS7Nh0BFhCQhljolGPkvYBFfFIFk8XhThL6loMHbxsQyBhIm+pVINecvU/q9N5C6J9zdReqemyXmwd2PoeOjV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528262; c=relaxed/simple;
	bh=uTE1pwh4VD6WQFiNM3/MH7p9YEYKefoZ9mtg14+jePQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN476LSot5qiZPc05BGEDnXnzBsz0UmxU/6CbEgu7cLHp1+yB+jd68beifKcDKdST/m+tQ5LEWk6YM7GDGTlOcXeQBwyDGq/jD+S2A7utVw0ibZiExAGYsgHSw1jV7u8xpUy3Pgw8tIGYuPNplaHGtAdraZZWbOqYg8FNK8VLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOUChmxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOUChmxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C521F00AC4;
	Wed, 12 Aug 2026 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528261;
	bh=F0KI4/l6tFjZpykxavbIEmeCQUpDDA29j0ZHslfC6MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOUChmxri6rGygV15kKtSW/GO6K4qlF1x5RsCMFa8EfQLFvQ3rjyZV5YRBldWRwQK
	 twpnWD8ktGqolnGjWsuBOOVtMMa+Wx9IcvEtcNPHbFOI99O2SgnOEXwvuRmSG36WhW
	 mRUePpmAf+sLUYL7rlL7PGLheL9JD495sTwtojnDYb7VhcTPwKXaC5r8VhZ3XhXjUZ
	 pIaKAKKZ9Y0bIFvntmCalvIYBHHFQ/9kdK6J6C0ZYSfQcBcQ7OwduFQY2yqtFpIi88
	 58lFUgLjoEzG05pakNVvssSOaG7wwCsHrgBzQj7pF2aX/ljT2lOIIQlORthGlN0ZfA
	 2D1tSz63MDKnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] binfmt_misc: restore write access when removing an entry
Date: Wed, 12 Aug 2026 05:50:57 -0400
Message-ID: <20260812095057.1573629-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812095057.1573629-1-sashal@kernel.org>
References: <2026080512-motto-postwar-7c00@gregkh>
 <20260812095057.1573629-1-sashal@kernel.org>
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

