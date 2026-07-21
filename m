Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391F171BB;
	Tue, 21 Jul 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632864; cv=none; b=EqikpyO9kyg+wl4cg8icqwDHbccsbo4OBaf4LlNU5sAoWnhuzFwh0EpaCVLRyt8KTbDjDCEIbO4TtbKT3xmntB1SK+a8Tg6ZtnsS0J8UqsFEtPiczMAoYAyTVPDjw9tGlGnVwYYZiLwD/XkaAcGTYYPOzS5rZ2swXzsf4uCIAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632864; c=relaxed/simple;
	bh=+cJkpeap/KFYrggTqEpe4nk3HWVb6K6EfACXBz+YXGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGuAybzdY1VDW2zjMjTjkj8Yl3yiQ710xowmgkNI+hEgFJZffmox8Fb768oxqUSSfzw+U4NRUeD6HjxifkZt3ej9HaN5giU+hd9oHpjGHmOZDP5XYAvhedMH+0UwByTzwk+0rarVhoBJkdVXjFtalp+7OJkLqlUaQYm8ABEy27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpoJ0Xrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpoJ0Xrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91BB1F000E9;
	Tue, 21 Jul 2026 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784632862;
	bh=2QCIGWwPwoyvoMjnJWSMriHvqcGHG1Gj+h1JEnla2yE=;
	h=From:To:Cc:Subject:Date;
	b=cpoJ0XrvNyOBs0sYpHabs3pSxWkh5ZyP4hOPNJTumhP9A3+5yNiE8L5lAXdhOZVcF
	 SCsnAKkfIHJBgsoc6AiUrF3k9QCBUCrPQEOrCsKS0IApnhACYBCUMSg2GnvhD4/ja1
	 wJ7erJP8p/NUXN1V54aMicRA8wl2JkkxFUR75dKHFFl3KVwSlQn0EE6xQC80oW3h6w
	 mdDTkNFgTVKlJFKyvXE4t52HP5ou3QJUsfIrVBcXFWHp4eXBVEQ2jP9vUBUs5zivo2
	 Ff8OjW4I1FDkVxUR5me4VwLLKTnEfUVBoID52nJ2oThtCsuHBgrSn91uxMnOCV41QQ
	 xS9yHg/KgQNPw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	jannh@google.com,
	mail@johnericson.me,
	stable@vger.kernel.org
Subject: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
Date: Tue, 21 Jul 2026 13:20:45 +0200
Message-ID: <20260721-gezittert-medium-kreide-b41fc1f0277e@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=brauner@kernel.org; h=from:subject:message-id; bh=+cJkpeap/KFYrggTqEpe4nk3HWVb6K6EfACXBz+YXGw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFh4k154eeNb993lBn4lqZiOWct+XOaF9teCzbb8+Q3 +QZIL27o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ2XYwMB+5PtfosrlMQsYA3 waej1EphxQGt34rS/7ZNqxNxWvy0kOGvtHDrjQ4HBtZjykoGfkcdLXOvX39iep+R6dh2Ka31Wxs 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The program header scan handles PT_INTERP from a switch nested in the
scan loop, so its break leaves the switch and not the loop. A binary
carrying more than one PT_INTERP runs the case again and overwrites both
interpreter_name and interpreter. The previous name allocation leaks and
so does the previous interpreter reference, along with the write denial
open_exec() took on it. The denial is never released, so the file stays
unwritable for as long as the system runs.

An unprivileged caller reaches this with a crafted binary and repeats it
at will. binfmt_elf stops at the first PT_INTERP. Do the same here.

The flaw dates back to the driver's introduction in the pre-git history
tree introduced in v2.6.11 by 91808d6ebe39 ("[PATCH] FRV: Add FDPIC ELF
binary format driver").

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf_fdpic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 7e3108489c83..fe0b5c5ed2bc 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -231,6 +231,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	for (i = 0; i < exec_params.hdr.e_phnum; i++, phdr++) {
 		switch (phdr->p_type) {
 		case PT_INTERP:
+			/* elf ABI allows only one interpreter */
+			if (interpreter_name)
+				continue;
+
 			retval = -ENOMEM;
 			if (phdr->p_filesz > PATH_MAX)
 				goto error;
-- 
2.53.0

