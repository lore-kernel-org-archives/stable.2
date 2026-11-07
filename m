Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048332;
	b=KkGrkDDwFH/ta1esMVmrZ9YR4wHFaTiEtKUtlClNRU3Dn1omcegxD+cUUl96mAd/zmdf
	 flS5FmCojW+Gv0YOllF8slTof8iFOCW81fcVwINCpPTjCCETin/yb3WETn4wA/Dn+KuAd
	 ezp7Trg8vDkDEkdMqjiyfRLaLHxk26V+DzOoWAOu5X/OKMiqzXdQf8hjRuaUkgxd2BEA/
	 PqyGmYOKeb33YmO0ruK08N3puQ9QPjazNLgg5SggSD8BZqbxD9A0wwJttpQnwZGm8bxry
	 ok0KFb5R93KxEAABg0+HabvWpyPfn94pYHB8FO5K1EFDBQZ2wd5CJwfJVcxQOV9brkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048332;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wvV5pCQ3JIjBWmfRsdN+Ate/X8v9DDJF+qiD3K10whY=;
	b=F+8MAU7n27FnzQCAF/VNvSHLISB1Ug2PUnQmfIYihBfw94X/IAk/7wuXcqIdcNFB2Kyr
	 /bDaGbBOD8aFj4Jpngxv5bWQAMh9ke6Nix7YOT8wd+8rxj7wHVyR4O4Us65uIhgIQNRd8
	 h3VBs5hz77qFgnYgmpJjJfAqROI9H2Mm8h8cDjGo+ipPRnIMDyK2j+mq8uLBdtP5UQqpY
	 RojVTzZjynnsPuHazzA3h20sfRazGEwaFsc2UK2UFSTz4UmBIJAF/cUuGUuH2oZWMayWs
	 3DDKoTnuThGhs4mgeu7x4nsROe/mzp70bhanQS+SPq0a8NSgsBfXYADOyF1vIp5cWzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGliyQzQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGliyQzQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD831F0089F;
	Sat,  7 Nov 2026 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048331;
	bh=wvV5pCQ3JIjBWmfRsdN+Ate/X8v9DDJF+qiD3K10whY=;
	h=From:To:Cc:Subject:Date;
	b=lGliyQzQn6bnhGx5BOVt78SGhBCuxDqocYsJ2oaJ3nKoLN+dDfCH1em43fkj2DAAL
	 PeunPMWUECoPJNL4aXiIfm7QdcE3NDKwmrdHgWr6wOd6VkNU/vkploeVjZTNmgpd3q
	 Gpo8gmJ2CWKstdTfy+7m3O51IeEQvWulmrqwcxbd6fUNTabMp/u6otGEdIeg0BX209
	 tZXOaJJ/pjg4AlLvVTnmnalGKapD9uFH+k8ymsIamE7qPCs38Lu750JDNwks1HK5KW
	 8e50WVOwwsrIiF3tHHfv5U4TbZB39gARlLAVjXMc7MZTsmhWXtvttVs3mr9aVELFxG
	 esVRK5OnEP56g==
From: Sasha Levin <sashal@kernel.org>
To: qwe.aldo@gmail.com,
	almaz.alexandrovich@paragon-software.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs/ntfs3: validate that EA entry size covers its name and value" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:30 -0500
Message-ID: <20261107054530-failed-6.1-60bd50014cc9@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 60bd50014cc9a97c5e34a8bddd2bad4d2dc5acb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054530-failed-6.1-60bd50014cc9@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




