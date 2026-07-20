Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A84192FD;
	Mon, 20 Jul 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551047; cv=none; b=AZep5cp4s4G6CeQegQC5prapmSLMIHFgMHIUfYFSg+ncZLm1Y3wOUx3wI3MsPdyi3L0zWvpsV7vrNieIGx7XakvWMkAsI8foavvmyEkZsgdwqLzbVEJfT/R/ZjApSz5HTgl1eN2TQGDZnfjgT56Grym66RhgkLX1nb9isLmXtkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551047; c=relaxed/simple;
	bh=kj0AZ5A6Jop+KqbA2yhJS4V30yHrTSQgJ33ZorM7qxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVxIqE3BIDhkABOFCAwg8OUhRiPm0I7t8SWxTDHA51Izc+nmEsfXkHMrNBG4wsApjkInYsoYmleOx1TomclfCzoup+0lW4dI3XLffqI+k+RBQReDokEt+9R9SOvU5pgqE7xaufn6ToeJLv8QtzvHsu3/eKJdzpwL4qT1q6lRPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY7bQ3bN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY7bQ3bN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487B21F00A3A;
	Mon, 20 Jul 2026 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551046;
	bh=K5qltyN+MfU8aQCuenvbMxWg7poDhOA/J+jqlFW5yPc=;
	h=From:To:Cc:Subject:Date;
	b=GY7bQ3bNSoNb1of3AfVAdlHJ9ktb8mfCWC9IazeVyU+pGlqJ0c5td2EXlAWQJgcWx
	 Glqj0qYMMPMZVPOvHvIFSRVyOaETXSBGgBmMRrD7HXZuQFcu0HCb+3IU504UHEX04V
	 3Q1lQ5JxV3lsPBE6iIJnU62ilAY2BgBSWYDrto+JKpJNFAKqK/TfnyVjTpA6TnkGHP
	 UCxjLC/vxD4mcSQ3WONPqjncQ3keEU9JLbLexlsu05rKuSczIQe/7fCTmgOmRDqAcU
	 wHd2Dc4Q1VS3J6uOdVaCyPE4A8UU+GFZ4kbtYelxOdfascgaZyU83cGuRO42y0YVWB
	 EbmX2zLAg5TMA==
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
Subject: [PATCH] binfmt_misc: set have_execfd only once the interpreter is opened
Date: Mon, 20 Jul 2026 14:36:49 +0200
Message-ID: <20260720-beglichen-kognitiv-organismus-5e1e55326c56@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=brauner@kernel.org; h=from:subject:message-id; bh=kj0AZ5A6Jop+KqbA2yhJS4V30yHrTSQgJ33ZorM7qxg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFiVWs5Dt2bv61zvhvq3ayPlU//fbNo8386xXu6AiYT c1hSJjg2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR35uMDC9NZtew1vfVX9+x VaVEuqRRsUI4Tz9hkdxeY+3ffCF+kxgZdh9wCJn9qsjQISlJfMPProP2Imra74+ziJildO1cnx7 ECwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

load_misc_binary() raises bprm->have_execfd as soon as it sees the 'O'
(or 'C') flag. This happens well before it opens the interpreter. If
that open fails the flag stays set on the bprm. binfmt_misc is at the
head of the format list so an interpreter open failure that returns
-ENOEXEC lets the search fall through to a later format. This means it
runs the matched binary directly having never staged an interpreter. So
bprm->executable is NULL while have_execfd falsely claims a descriptor
is present.

Consequently, begin_new_exec() dereferences the missing executable:

  would_dump(bprm, bprm->executable);

and NULL derefs. Had it not, the hand-off later in the same function
would have failed anyway. FD_ADD(0, bprm->executable) rejects a NULL
file with -ENOMEM. Both sites are past the point of no return so the
exec cannot be unwound either way.

This can be reached by unprivileged users as binfmt_misc can be mounted
in user namespaces. So a user can register an 'O' entry whose
interpreter lives on a FUSE mount, have the FUSE server fail the open
with -ENOEXEC and execute a native ELF file that matches the entry.

have_execfd only means anything alongside the executable it describes
which is not set until the interpreter has been opened and staged.
So lets raise it there, next to execfd_creds, which is already set at
that point. An open failure now leaves it clear, so the fallback format
derives credentials from the binary and emits no AT_EXECFD, as it would
for any native exec. The argv rewrite load_misc_binary() performs before
the open is still not undone. This means the binary sees the interpreter
path in argv[0] and its own path in argv[1] but that predates this
change and only became observable once the exec stopped faulting.

Fixes: bc2bf338d54b ("exec: Remove recursion from search_binary_handler")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 84349fcb93f1..5de615ca7a75 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -228,9 +228,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
 			goto ret;
 	}
 
-	if (fmt->flags & MISC_FMT_OPEN_BINARY)
-		bprm->have_execfd = 1;
-
 	/* make argv[1] be the path to the binary */
 	retval = copy_string_kernel(bprm->interp, bprm);
 	if (retval < 0)
@@ -260,6 +257,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		goto ret;
 
 	bprm->interpreter = interp_file;
+	if (fmt->flags & MISC_FMT_OPEN_BINARY)
+		bprm->have_execfd = 1;
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
 		bprm->execfd_creds = 1;
 
-- 
2.53.0

