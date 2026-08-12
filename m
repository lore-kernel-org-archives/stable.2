Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028E231827
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493391; cv=none; b=YnOOI46BOsxO5kVwyz98jkwhfJFaMZbXi61uy1nnIPqN4tthdfRTQkrBti5/DGMWtxNJj2kqdle5cU0HpLkfJfjEGZqI0/QV8Cbi/OZQv5Y/BqJxyzidW0pVsSKXAl0qIOj0oIqboviluogB7m1y1lY0Qwp3e/CzUILGGBbfxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493391; c=relaxed/simple;
	bh=al+LR5irlil20CuiUNEnzoLt9sfnXyU5LJaFze82YyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSwqczTDP6NlrD74sbP/Mw0xZ2tLT0i0FBnJwMyKGWB2M9ebwiS+BGYxhMuV0bQgbxUGAUr+ZX7fN6b5b1GoeO/Vx6qjW0is/Y3TZLllW9nZq1PV61FQ2CHQ86m2zU9LneoBSiK1SnghEHtAQ+1F3GU7exULZ3CsWc9GtFumkqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSQ9yE0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSQ9yE0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC21F00A3A;
	Wed, 12 Aug 2026 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493390;
	bh=/baoxN6dsZeRfjJZTLp9ted5vsSXVZRPYZNcJWnViUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OSQ9yE0FNFf5ygkbyxTzOBskdvJdAaupznYF+2ycRlp5h+VH/m9anvoPH6FWy2aQt
	 QrH3N0AAXl2Hgb3I4OodhsZIxnrZjkThXfxiwcjWEwZ09AbiSbOWqHF73RPNMcWd+n
	 TnZKATA4PW1JiMRLj61QCBgRnley0bsBToIfidTMwTxvSEHU1Hf5ZR2N1dv1lLKAon
	 J/vDomM4VwXuNpcQwGTZ0DUcZ5V8yTuvjcveFtlMmmdtTzc9RXj7S7tH9qCkO0vXDe
	 hJ8StjrorqHQ8GL8P/HZRLmeHKVoEthTCSA2CaEaTGHh4U9kSlOlNSWOLkhRn/LTu7
	 MOPlv9brMYJmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] binfmt_misc: restore write access when removing an entry
Date: Tue, 11 Aug 2026 20:09:47 -0400
Message-ID: <20260812000947.4159385-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812000947.4159385-1-sashal@kernel.org>
References: <2026080511-errant-musky-ca70@gregkh>
 <20260812000947.4159385-1-sashal@kernel.org>
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
index 3b96c7ca7cfcd..5f6e354cb565c 100644
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

