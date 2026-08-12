Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2B2E738D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536147; cv=none; b=WPUOAygqSwK9idqajrOWWOtKum80zPLXGgHVblJiemvLAZEb86eOHl3jBdZ4aULl4sF4Cshg9AHh4MdRfnKvegBNl4zvS+qrlYELvjtAZnT5dJzdJUwiq718lnRAAhI5nWvM1a89T3q+6O2ets4qkyFbBy6y9iChlGcBSmwHRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536147; c=relaxed/simple;
	bh=93jAo7McLB2C6bXlxg4/eIMUzElFtrlRIEzNHPk/UqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCXEUcCv2upbrBgIhVod48zG/apqcUUDw2KnGlpdWbMcP+nzrfUKsz8BrI0fg990a560xOC4ppNQh51jh2bzt2SUIkbtOWqdXs11qSnggllDypWc15LGdncEvlgJXzpCMIe5d1ZEdJdPM8c7n/cjce+s4Dbr/TRZ0vLDUgR6ejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8/Df2Cf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8/Df2Cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C4B1F00A3E;
	Wed, 12 Aug 2026 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536146;
	bh=CMEaiAWeasqFmQRSPaJWrKmfv9rjsQVyCJaV4+cfSi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8/Df2Cfm2mYSwqGGc9l2Y3FxDIn3faVLURtdHFD0CHEwBw65HNr+DJJ3jb4mt/Mz
	 d4NBQxIekqOMXzCHS8mK1AHVwR2/1RBVg3oLbVbufOtAfpKPzf50z5sOUI0h4zytJX
	 +BgsRo3kt6+5+e9ZlvXqJDcNf6Die3Q/+kXNL76xBtNfNW4LBxOVHwiAiWLwWeL4yu
	 lU5toTLEH2wA7h6jNJEjgvxQAP9JTCWY3ic6nXfwp6g+2XqcfRsCxrzRDRfpF009Pr
	 ijGGaJqb9K4f+DU32RWfpV6i98g3odhPjvk388QHZy3PZRzk/K3ouNtYKUMvM26mfx
	 CNcOYR02Qq0zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] binfmt_misc: restore write access when removing an entry
Date: Wed, 12 Aug 2026 08:02:22 -0400
Message-ID: <20260812120222.1989615-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812120222.1989615-1-sashal@kernel.org>
References: <2026080513-stubbed-clear-8ac9@gregkh>
 <20260812120222.1989615-1-sashal@kernel.org>
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
index 740dac1012ae8..c039209032b2f 100644
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

