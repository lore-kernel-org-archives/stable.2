Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F33D9023
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474587; cv=none; b=tA/C+1bipl+Pl0xmMdmmO4gsgIPC3RFwku/GgZ0zQtON7EOHdmD441IPyTDQRit3ARk+Il5eRE5tQrcS/dYLuZLtSmMncPIJ2isHJU3WU7oLvxF2SRvhfXsAOawi9wT1FIJ687aSz0CooFXu3Y9AOAA8ctr5/XuXeG04Z1OapdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474587; c=relaxed/simple;
	bh=T5olpGdFjMJ2LX6GYp+r+peq3B4oeC98PTZkzUDCY1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S06R5cjCtmBUJ/9+8NYxPVPNrC0IQWtFjrMDQeLW58x5/yT6W0M7u3rJrK+RJCbgp+ZcnPXAoqsCGpYXzrywNgwnCfrrJs8yo53PaLzYJwn9nhhW4b0kBZwEpswtscqK+CVtyJ02yn8cTXGqQAKdAON6BnmpQZywF9pc8kHf3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D71uRq5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D71uRq5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C03C1F000E9;
	Tue, 11 Aug 2026 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474585;
	bh=vl4fa/90i4vDt0SDivVwwRRbW69r3HToTImCvZgk6bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D71uRq5dcKq6+fiLIhEsIn3tGH50o4/03aoCDWx8SA6+4VWe/NTpSMbhEb6S2lP4N
	 oo6lx/Wf5qUeZtnYJRXZJWOw8fEZG0iiQXxhf0IFI8IKe0THit3ir/D/4lT0Qb/fyd
	 VVkr74baPvdGOc8oiKhrjIaoZWYKI8Qg8mnCh2wmILhupim7cMJF8Ts45FPhlaU1gR
	 mL5363m7qYgC5jwQOr89ihsGkWaodzO2MmgqXqEeqMcfega0w1R1hvYeg6Aip5TblG
	 LuqXuqlWrbpKOx++idstJAkwPURutHnNDxkE5l3F5AzrXw0WwS//2d1baa4BwMlW1C
	 Ou3NbY0pomRyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] binfmt_misc: restore write access when removing an entry
Date: Tue, 11 Aug 2026 14:56:19 -0400
Message-ID: <20260811185619.3386946-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811185619.3386946-1-sashal@kernel.org>
References: <2026080511-putdown-richly-6ef6@gregkh>
 <20260811185619.3386946-1-sashal@kernel.org>
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
index f85ee577c34d6..e2599f80ccde8 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -161,8 +161,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
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

