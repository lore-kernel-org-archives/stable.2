Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886343;
	b=rXfSHj4JJ9UMxoEpdG4M2KrWw6BVFW4ejmNrzHCu6kwMfXxdI8xn/MfVoHAehHUo3U77
	 +L4MW4TGnv+68i7mRYM+3+f8p7Gz//iVlXwYzpAQS2DBjsIIkl9ngDn1JboC6l57bnQb/
	 dyWBn28knF8KNKXhdzmv1yd5h7BuELXOEqijYvitjzDTNYtk/ViEWWLXeNq3SOcYvKP7B
	 r6FPMq61UxpaPncoGqtmyacYsZValO3tBMUP/JHKBoUnmySmmkjFWE9VDqHFOq/uEbXPb
	 nq/dArvvhdmKWP+EL3TRUqu+EtS3135eNOEVes3MkTyNHmbjFwkGyukHpb2wu3iNCsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JBalqB0TL8XclNERINIw3LBJBg7jgmpQsD9i6TTPrOU=;
	b=lVDTh7mBmJoChaU8g1uAIt3PRbBSd41llNkYf/g/rFTlsspplTBMPRBk7dxLepM2zrOW
	 azj9v1gUs6cBsmrCOKHRKI/ej0xRv9/1c3P//L9zB5/zRcYz1az0B+mixUnIgOoJS5ih6
	 +6msKXdInG1yUNOYVwX0UM1p9A3bn1/6EepgVu5sYtBUdK+DQbd9GciUwRjQNJZe/eW3z
	 sWsj7ckXIRGmhDdgts01xhbacWvPEU7VlbfnqUGcxNiAGXu8jEES97E/bZz/qevQ2UBMf
	 q5ZeeH188nXf1JOzfzDRBdQYdhn3EBiPiYP67FGA8q85NvNsAGLs5Peg1C9mbAUXUjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nX8maf/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FA606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nX8maf/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D461F000C1;
	Thu,  5 Nov 2026 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886343;
	bh=JBalqB0TL8XclNERINIw3LBJBg7jgmpQsD9i6TTPrOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nX8maf/e+L3arew88jdG6wbw4rXlXzTdGKOgPomx99buJqLO582EEOI3fx27pvo7V
	 BfBj7QzRVXVJ4baV7IZaEuekJEQL0yBnflrGyplyNzJgqQgapPZM4AUU1NaMHYfGtg
	 Fia2oRQ/3LSdNr8LgLZZhzQkq/9KjRRaAUJl//Gq+TlOg8ulp3jMfV0oeNIY8zbr1L
	 vMD6WHW/DVszofDTKSxXtxZCpFJhAcG7Zpb+8wLhiio5atdojSiXHYUlDSqBctzlyu
	 LJHHh4YiKnQZdcxLe4q9VCiaNN82dCnMiP0LMhrWydnEw0qpRhJg2WqyZ4tebOOsZJ
	 LLb+EWoYkqAkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Fahad Alharbi <fahad@codepure.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: do not copy up an xattr value that was never read
Date: Thu,  5 Nov 2026 08:45:41 -0500
Message-ID: <20261105134508.1391302-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110420-outage-visor-9527@gregkh>
References: <2026110420-outage-visor-9527@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

[ Upstream commit 755b5c5c9277be251a51623d6065abab948c61bc ]

Copy-up stores uninitialized kernel memory in an xattr of the upper
file, where the user can read it.

ovl_copy_xattr() may only pass bytes to ovl_do_setxattr() that
ovl_do_getxattr() has read. When the read fails with -ERANGE the
function asks for the size again, and if the new size fits the buffer
it stores the buffer although nothing was read into it. The buffer
comes from kvmalloc(), or it still holds the value of the previous
xattr.

A FUSE lower layer that answers every sized GETXATTR with -ERANGE made
copy-up store 4096 bytes that the server never sent, with a kernel
pointer in them, as an xattr of the upper file.

Fix this by failing the copy-up with -EIO when the size that follows
-ERANGE fits the buffer.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: Adjusted context to retain vfs_getxattr(old, ...) calls instead of upstream ovl_do_getxattr(oldpath, ...). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 018867303a93a..cb89a96561da4 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -94,8 +94,12 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 		}
 retry:
 		size = vfs_getxattr(old, name, value, value_size);
-		if (size == -ERANGE)
+		if (size == -ERANGE) {
 			size = vfs_getxattr(old, name, NULL, 0);
+			/* Nothing was read into value, so it must not be used */
+			if (size >= 0 && size <= value_size)
+				size = -EIO;
+		}
 
 		if (size < 0) {
 			error = size;
-- 
2.53.0

