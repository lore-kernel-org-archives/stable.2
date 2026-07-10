Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09F3F5BC5;
	Fri, 10 Jul 2026 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676005; cv=none; b=j4ap7a3aOgxUo5Oq/bBVm85In7oRW6uoNtk3R6kwH1+/HmXzMyE4F+3Dev274L0yFOhIPpC3A0YeHwkyiFA2N5cb6OVEAaebYgty+tRer+L7UA0OsOjn+jl3LUugkPbCSdVWAPkvwitXQkR2jBNAh0PUrndBkK6Xe9MialNV6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676005; c=relaxed/simple;
	bh=t8nER3lsjLzcjeJujucgoUoGrAUWFYH7V6NQav6UZeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtCLHJT+H/wjGiakU8B5T1E8X5I0ADb1132bdkKW0qsiSHh/Ddxv7S419yTPnszILuyqMVJtRwaHTW2fmURjhuoziADQnpGp2AF8jaSNYSK9kgoK1Kn3a9ualmOevKGoHLoEzL2CrXvNU/dH/NmkfKt0CyHxGqMHu/q4zOutWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ4mSzmi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ4mSzmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE23A1F00A3A;
	Fri, 10 Jul 2026 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676003;
	bh=dpRcp/2dJk6gV7eAG1xmqQEL3beSixOls/uDr77Rs8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CJ4mSzmilNfuTzVZJBZ5TTDTJcCkU1HRfdPz8EBM46cO1wmsyCbTNl5J2bnjs0M/X
	 m1KiAnTRY5R9jojRFi366yUKwEJCRjeYbhqbEYt8u+bfdaCuYM80w+BKeMY8YoiwYE
	 KZdchNouw1WOV3smuUXAp2Kko6CwCSHZ8REJKzD2UKjuiN12Cn6XG8OmvSZz/JSdUh
	 Iv3CTmVjkQM5rpxAE12S2pNgJdL/JHopTxXKQ7nwGyRAA18ey8PZVtmx58fKDh+FrD
	 UuFc2u6pZRJykGyLyt865qEPolEIsZEGsbjlZPy/h5MeYhCgvtXtSxaaoSLm/kHbYc
	 VJsfJMW/4iKcw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:02 +0200
Subject: [PATCH v3 01/24] binfmt_misc: restore write access when removing
 an entry
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-1-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t8nER3lsjLzcjeJujucgoUoGrAUWFYH7V6NQav6UZeY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Il9rPhM7Mnn4OPM/54IdO9eXLwiXyzG+8br4xb/3
 au81PxtO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCnsvI8G+j0rvIfVfkXyUp
 VCRvOfxBwqAqP9vqpKTmFP2r2XVG9xkZnh+dmrf3da760T+ZmVzXf12svX9KLuWeq+svllfCe1L
 LGAE=
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

