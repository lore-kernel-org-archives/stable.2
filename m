Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03F3D45CB;
	Mon, 20 Jul 2026 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540043; cv=none; b=Qa8IT6y4+EBI5p/nuysouMLDAwJZCflg9LMsqPsWflynWh4UanzAxM75KpQivM/SrzH1uj2mxkoicYoO8a0yuG2jQLuDowgt+XlFm/8kA1DFgrWSEBXNzeFt96jJeOHXKqAStT7YhJbYfR/MSRGiALpKLRskdIKDDQjdjP3dynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540043; c=relaxed/simple;
	bh=CoHLaRoM2mplRsL5iN7kCgByR53yCKHvwoveSm2vgWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrTpwR0h/RxsxSRETaMiyTeaIFHhDowv7U5+HXySvIvZmiKKOHxi+CKe3KmY/t+jxQ+3FtZNq3bVID9cCAWyfeNmKrQqaVJwht1GbXo+jvH5a+d7Af57o8g3vv8f5/rIoiiOZsa8dBf5AcfjrxMp3BYJqNZ21WCC7QsigrayR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXwp4/sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXwp4/sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065CB1F00A3A;
	Mon, 20 Jul 2026 09:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540042;
	bh=5WU8HHfi0XRjF1MtN9eV9/bX8KhXCEqYvsKnAtQltP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CXwp4/sgl9RgFVehfnAi8KQkdRTrXCDJ6bzcipcJgybnMg5i6pa/kjodZV0GoDRhM
	 35yVkpXr2iBxRdMuxZBo1J69wbvBHVvHWShvf+wnq0GbjXb48+hYaMHtQZtMK1oYy3
	 4pAN93UKhWpbLunj65CwXuM545UgXzE6fQ1pGk8YmKEiivctVs4QEle7huVLxC7MlH
	 DDuttxZh55gT0AraSxsAqmhC8iZPvqIpUwWG7ubY+JKK9tTU38dAojHWu5WSHwNinD
	 GN2P0+Pk7Zg4oM/mDIWMO45nTD8OsNMZLnsLCBrntnPKNajTmUno8F29/YGmrKLEfM
	 ThmaLEUyAf8EQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:24 +0200
Subject: [PATCH 01/21] exec: do not act on a stale execfd request without
 an executable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-1-ddb76c9a508e@kernel.org>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
In-Reply-To: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CoHLaRoM2mplRsL5iN7kCgByR53yCKHvwoveSm2vgWs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm6c1/Cq9wWzWdFRUwNPL4+fz5cL3Cuzju644L+qL
 OzM5SsTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS+Izhv/fHhpSZpdIbTknN
 nbPHff27N0WMi1V/8HuXvF4hW/Cwz4bhF7NT1GvRIzZLzSsTleK3TRGdm5QRv/aLVdgB5ZakDlU
 NBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

binfmt_misc sets bprm->have_execfd (and, for a 'C' entry, execfd_creds)
before it opens the interpreter. When that open fails the entry returns
-ENOEXEC, but the two flags stay set on the bprm. As binfmt_misc is
inserted at the head of the format list, the search then continues to a
later format which never staged an interpreter, so bprm->executable is
NULL while the flags falsely claim an execfd is present.

begin_new_exec() then dereferences the missing executable:

  - bprm_creds_from_file() computes credentials from
    execfd_creds ? bprm->executable : bprm->file and faults on the NULL;
  - would_dump(bprm, bprm->executable) faults the same way; and
  - create_elf_tables() would emit AT_EXECFD from the zero-initialised
    bprm->execfd, handing the program descriptor 0.

An unprivileged user can reach this. Mount binfmt_misc in a user
namespace, register an 'O' or 'C' entry whose interpreter lives on a
FUSE mount, have the FUSE server fail the open with -ENOEXEC (which
fuse_dev_do_write() relays verbatim), and execute a native ELF file
matching the entry. The result is a NULL pointer dereference in
begin_new_exec().

have_execfd and execfd_creds only mean anything alongside the
bprm->executable they describe. Clear them when no executable was
staged, before the first dereference, so the exec proceeds as the plain
execution of the binary it has become.

Fixes: bc2bf338d54b ("exec: Remove recursion from search_binary_handler")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index c698aabe9abd..2f50aa039827 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1112,6 +1112,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 	struct task_struct *me = current;
 	int retval;
 
+	/* A declined execfd request has no executable for a later format. */
+	if (!bprm->executable) {
+		bprm->have_execfd = 0;
+		bprm->execfd_creds = 0;
+	}
+
 	/* Once we are committed compute the creds */
 	retval = bprm_creds_from_file(bprm);
 	if (retval)

-- 
2.53.0

