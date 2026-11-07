Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045857;
	b=QB3pmRKCQYFEjsXpzxe2qDUCa20h19ECmxZMxbRC+pBELCRQMOh0ImQN2kCb4s5lraAp
	 AlaOTq2XhJYUJDLCceN7a02OiM9GUt8rcXo8NqvDprVQJrXVCen/6YCkSJMFMAVR1sk2e
	 vK1jvngktumxdU80snRscg6iD1SAx+haJgJe1rY6+urlJyZeyWIlKd/6yM9v5B4XDQW7e
	 nZ6/JxJYlJyRCpsDbuzn+rJ84X4S8I8ITCpiTtRvuIJddGVW1baIoo39RlW1Ysbo7XCMk
	 qGP605BBDmPTpAVYZrAVcjgcicEorB+XdnDdj7FtC1p2+ipwn5C1IuqGsUZX/OHrfLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dLCRYXStTEYXwIr9ZxlRcAIipABN9VKz5Mul+sgbAPo=;
	b=ThyTeYE8JcLspQRwm/LhtS/wDSHNmSOqePqrZDJ6bvxxMNNjPJXsbYbnKfxUg0KOIzFE
	 Zcx+ql/kmrq2+AY2xGRWplwav1Bvricnuaa0LwwQFq2BqfKTrAohj7EZVKtAZsPqE5iOz
	 bXBfkV5Q32NHWDoJl8fGEebivXIOfns3iSOUmzMxJ95JT/KVv8rp1GiyN6+6EjNFHmj8c
	 OJudLgN4TxELSvlo2ftaip2iNKfHhz3jy9hb5xc+Ywfp7l187djwmSGfLRWYYKYyjh6Zc
	 ShQFiJCDccwdObM8gAt3d8eJxAdccBCZ1Hd+ZHbPH1VfFuc97Pl15As0cg3ynZ/CPaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNZKrInZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNZKrInZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E421F0089F;
	Sat,  7 Nov 2026 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045856;
	bh=dLCRYXStTEYXwIr9ZxlRcAIipABN9VKz5Mul+sgbAPo=;
	h=From:To:Cc:Subject:Date;
	b=SNZKrInZN2RC8OfYt5e5HYvSY1e2jmFGrGTTQeFc1LEGliK1bR8gS7huBj7nRoRGf
	 TXgtcRdfS7O47PoxNmwVqX+hteycwEwqGkdIxHnnvZ9+Y5DRjGy8EUPbrMOQ9SUwoN
	 AvaDsfZ1Vg3fVEA1/24b6THrt/ITHFMv85m/TCC8GEb8BrFzNywo0HOHVdNZ8E+NLu
	 y8R8BymWfkPbJ7gJkEUkJP81n1dllD/J/KuZEcLzLH/4/1bEKaOn3EGnwS8hqBhtTD
	 xi3K8xnDD52HZU22YeXE4D8DEkBRbMyBi4N3Svglo/OooJf3/URaBpCpPDJiWgUG6+
	 ghS6EoqVLNPFw==
From: Sasha Levin <sashal@kernel.org>
To: qwe.aldo@gmail.com,
	almaz.alexandrovich@paragon-software.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs/ntfs3: validate that EA entry size covers its name and value" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:14 -0500
Message-ID: <20261107050414-failed-7.3-60bd50014cc9@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 60bd50014cc9a97c5e34a8bddd2bad4d2dc5acb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050414-failed-7.3-60bd50014cc9@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




