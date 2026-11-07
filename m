Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047562;
	b=mvIstAHdXyJOpEISt3BEocy+LtGZVg5UJiEwhzLamplJnadwzcLpgqlhZETd1+rvs9uU
	 KElV9U3RhNwX19YjuUTz+stRPJ/j1Lfo89eS8M4R2wlciFc+KExG8ZPDsCGjVMkjXSRjY
	 FoVuup4pGpl3V3bOShea9YeZmjMhTGGRFz0TiP+TSzBmcqEnAJZU5D+lX4P9AJ6IZMXVw
	 ky/SR2fzsnIRHzRFKewRCY0qrcEqSiYIV5xCJVMfUXfluKUq/FQhujMkhd9vB/I/N7F58
	 l5vgACKBky6Ieui20ZyBcT5OFjORAXx+EWXKxhEWcJBAUIcyVpl2SHS0Mpz422RJ9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047562;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cuJpuDny+opWrndvugD1UiSp3IVdUYSZr5ic3XkVISU=;
	b=ZWRNbxcBOHLA4YstFHRjIpS32sF+ElaosUC5ZJ5b3mlgm9P+2bQQrdQ/P9ZXfuUUd25w
	 gGglv6yqxoi0OhfcW44cd6uq6BgxW5pBDj/FO+7JgQYAR25MycN738xCu2/ugcpIbOiIi
	 7eQYDjsigRQcU0aMSlJSoQYYWXeXpRMd0fXWxyD9PZvGIQSQQbz0L8IkREKVy5x+DKzRw
	 EA+KduSfXArCuNveexxCWtpgANei577BSi0xn7q3v1J03hSY0tPnbCGDTvuv8p6bKPLUU
	 qfjxl1bXGJUIP65lAsyrZS147ZhvZ8Vp9EVA1Ruav+7MPf9H+uF3ek4JWe5P8S7o9YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+Qs5NsW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3155606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+Qs5NsW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFA01F0089F;
	Sat,  7 Nov 2026 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047561;
	bh=cuJpuDny+opWrndvugD1UiSp3IVdUYSZr5ic3XkVISU=;
	h=From:To:Cc:Subject:Date;
	b=m+Qs5NsWxa+LSVN/p3f3syrw0vmwbK6jQPLOKY7VQUleMEUrFYOYgF413fmtV8CHU
	 eMUNUiPpJVmbJuCDPXY9JKIkbbkH5q77rQ1IZeOBekoZ7rawNeKH0DjCTz6AabTFuF
	 UJmuUrnXYVf9rc5gklQ3O6Gk4lMrja99GXE0ma6Gl3j6MQdVt4t5AdZnYu8pWbHUnv
	 DuZedBynmDePDL87rpNI2PTEUim+LCOc2wzQJZma9EonDJvc0BbRip25ylbrtfbutU
	 EeUx510Ko7pH0fvyRzIbXDHEqsv1OCaRA+ekdjHXEoY32zwxo4x7MBdo1K+RziQj0e
	 Rjnpw21Ciq7dQ==
From: Sasha Levin <sashal@kernel.org>
To: qwe.aldo@gmail.com,
	almaz.alexandrovich@paragon-software.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs/ntfs3: validate that EA entry size covers its name and value" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:40 -0500
Message-ID: <20261107053240-failed-6.6-60bd50014cc9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 60bd50014cc9a97c5e34a8bddd2bad4d2dc5acb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053240-failed-6.6-60bd50014cc9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 60bd50014cc9a97c5e34a8bddd2bad4d2dc5acb7 Mon Sep 17 00:00:00 2001
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Date: Thu, 23 Jul 2026 19:10:45 -0300
Subject: [PATCH] fs/ntfs3: validate that EA entry size covers its name and
 value

ntfs_read_ea() walks the on-disk $EA attribute and checks each EA_FULL
entry for consistency.  For an entry with a non-zero ef->size (the
offset to the next entry) the loop only verifies that this stride fits
in the remaining buffer, and then continues:

	if (ef->size) {
		ea_size = le32_to_cpu(ef->size);
		if (ea_size > bytes)
			goto out1;
		continue;
	}

It never verifies that the entry's own name (ef->name_len) and value
(ef->elength) actually fit inside ef->size.  A later reader trusts
ef->elength unconditionally; ntfs_get_ea() does:

	len = le16_to_cpu(ea->elength);		/* up to 0xffff */
	...
	if (len > size)				/* size is the user buffer */
		return -ERANGE;
	memcpy(buffer, ea->name + ea->name_len + 1, len);

A crafted image with a small but valid ef->size (e.g. 24) and
ef->elength == 0xffff therefore passes validation, and a getxattr()
with a large enough user buffer copies up to 64 KiB starting just past
the short entry -- an out-of-bounds read of the ea_all allocation that
leaks adjacent kernel heap memory to userspace.

  BUG: KASAN: slab-out-of-bounds in ntfs_get_ea+0x2b8/0x3f0
  Read of size 65535 ...
   ntfs_get_ea -> ntfs_getxattr -> vfs_getxattr -> do_getxattr

The zero-ef->size branch already computes the same struct_size() to
derive the stride; mirror that in the non-zero branch and reject the
entry when its declared size cannot hold the name and value.

Fixes: 0e8235d28f3a ("fs/ntfs3: Check fields while reading")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 7f77df9c46f85..2cf45bdd93d54 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -167,6 +167,24 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 				goto out1;
 			if (bytes < offsetof(struct EA_FULL, name))
 				goto out1;
+
+			/* Check if we can use fields ef->name_len and ef->elength. */
+			if (bytes < offsetof(struct EA_FULL, name))
+				goto out1;
+
+			/*
+			 * The declared entry size (ef->size) must be large
+			 * enough to hold the name and value.  Otherwise a later
+			 * reader such as ntfs_get_ea() copies ef->elength bytes
+			 * starting past the entry, reading out of bounds of the
+			 * ea buffer and leaking adjacent heap memory to
+			 * userspace via getxattr().
+			 */
+			if (struct_size(ef, name,
+					1 + ef->name_len +
+						le16_to_cpu(ef->elength)) >
+			    ea_size)
+				goto out1;
 			continue;
 		}
 
-- 
2.53.0




