Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046813;
	b=e1sW0mccO3MKGBYO1YzgvgaQ3hkufe4KvTzuOpo1y+Bpi0iHKi9BUqwmb5YXBQHbdsUu
	 XPwEgYOjlm8ryokAKQ9hz71yiVHrLZJna5MLX93ELSYpTCmlGJ0mbH2OpbVPGBhmp+dnd
	 u833DtDvXLbus157rmnn6ZxS3EF+jRMibtwUET+LTuuylzrGggpmmz2SONGrjubrhiC6J
	 yJN99vr4ZRmSDcbOats4uXxR6ej8PO4jBhJuSiQ/8xfW95dP6pGgwHlb5zWafosPPnhW1
	 qvaWWcJ5ub+RfT+LEL+nKaaIDdq/rRhkHIQoeHaN6IOMKxnfBzT0MA0FhODkp2RoRiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R4xg4rjHOCHyFh0v7WeWH8gk3M2YGR4jSpOaJIaA21U=;
	b=wNEClSBvK2GkAE9lYfj0SIcF1qM4bp/B5hQp+jWNxiijjxwEOwxel91VQKYSw5l7bNxa
	 6TXDBvAMzm32ugHHxg312LHHvwaib1WyIZ5X8ZEe0Iq5GjXwr9sDnWSfdFP/tSVeb19cB
	 t4JGScmLscTaKEw5gsyWregoTqRt6x8pSFW7zj7tYjEdc3XAE+X59km9MamIzsjZ54kAw
	 aVyEEahWqgqRogUVfos9/J+byKBCXywvoFGMK25EhugJHzW2ufUxZv58tn4nufxjcEzxF
	 +ufFVryweFiJWnNF63O0Odhhws+ZyvSgwvd94qwQnxfr/qSUcI2geGccDC7eRocQxiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzSSMrDq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75D606A8C0
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzSSMrDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8DC1F008A1;
	Sat,  7 Nov 2026 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046813;
	bh=R4xg4rjHOCHyFh0v7WeWH8gk3M2YGR4jSpOaJIaA21U=;
	h=From:To:Cc:Subject:Date;
	b=BzSSMrDqaAsL2Ge4sfTxCiXpfWmawDji2dr7cWy5W8nfsW6Tj4RkkahnpL5lVqxIx
	 X9D0zQP2oZIz8MhoqmWsWYcOdYmttbgdRP0MMy932CfSwLz0+dBPq2XJwaTywjX7Hv
	 MPMpZbTj+lqiY0QoGD1+fgLLkoBiZl0OdKtAYo/TWs3wNf3+CHBbQLYjelxy//zem6
	 45uK2jBmwEoSMKr3X8Ksr8p6y2EY+6XC6pCnfZqIJPL9CPzWwcLrY9yYMAU7fVrp+l
	 ieU2nzvuntQKpmsE4fulzEc4miKV41pgh4StMJRuB6NZfVXGMiC/KmS2I1nbXCgcfw
	 X812qppBozEDg==
From: Sasha Levin <sashal@kernel.org>
To: qwe.aldo@gmail.com,
	almaz.alexandrovich@paragon-software.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs/ntfs3: validate that EA entry size covers its name and value" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:11 -0500
Message-ID: <20261107052011-failed-6.12-60bd50014cc9@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 60bd50014cc9a97c5e34a8bddd2bad4d2dc5acb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052011-failed-6.12-60bd50014cc9@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




