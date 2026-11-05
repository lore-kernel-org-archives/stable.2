Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881242;
	b=wmCD5mPPiAlG7tqbCgWZZHpYJOC5COf6vdaih5ssd3zNR30KbKgHi4xHDAaeZfOLR9be
	 9KICqfLQTG7W7pKZD/fLqNFtu1n0GKOOOhLLfZgJpBml5crv0Mfv0krzmglgMKyavcuQL
	 LthoiFW2oe7QAZp3IMKJYhCW+qFdUKVhGaigb9unwvgcDhscK3/steoqXdnpeWREdusmf
	 g09yGdFfFHlPyAQzbe8IohN0WlORc6Zk9440rUMVReG9i7xCq2CYUBOYOG/0Q+buIaLYp
	 1E77LMzuUk6KdGD/8j17DWCgAk73VDLFFaGKWuUmhRp4/tz/POjb5e+0gjzLrOZchBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S7ODuYCpeY3/fIyreE1si0m03iAqTDnRKxEfZoSMcWU=;
	b=S+KDJBvPgkzILGJV32yljLT9vtnpo64U3O4i4cbzrekRj/fxr1XFDYmx+sCfmMzBrqrA
	 j3zxLKFtXYUgjI/Xx0cjKVM2gbTKEVW7GqEAlh+woezffks35hq0A3bHz4fGUdOoklgY9
	 PhiQgB2AAx+mLVsxSU6mZ0HRGSdNRMNcfGI1C7m7CBoixjTuxF0NuqlszxWkRRv9Gl5vF
	 gSYpFW9dbnueILcHfexyCBRWDS1Ri0j2SPHRJA8PQJ9nQe8Xpx+4QHd8pfhaZYpV5e+Tp
	 dAJgAC/sTs7wUwbwzPyr/A0FsuwRL6FMfXxMPBxLYqlKHqrMcYNLEogg6X/BMYZU/ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b59KxKbs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9E606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b59KxKbs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD301F00A02;
	Thu,  5 Nov 2026 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881241;
	bh=S7ODuYCpeY3/fIyreE1si0m03iAqTDnRKxEfZoSMcWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b59KxKbs/pV8dZ5Boj2ooa1eoJw9E5jFgo5oPrfGxN9LM1C87H68hGGyDM+R/oqPx
	 p2JILN3Dz8OMtjKqKDvgv7PEf48U9+xB/fZG6GTbDentvd5c/1QlrE7Sb65atqOxNk
	 db8czDYn8jhdDlzzVoBH8FsfiIFZZ9aQb4qF4pqVYq1RBv9DzNljarprDhIULxsHj4
	 RDn+MOUEOFXcLw26Gg1llWV7e8AxQQYJ2+BRfaMZq9mpjaccRanOCHYQvxdeZNPXmg
	 +Snv9tH3qIbuXikDvSA7Tk3WyyASkRXLLe8dDFPXUynKpI7/npQV71iAn7n7kPMTR6
	 qjZGKQFIL4mtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Fahad Alharbi <fahad@codepure.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] ovl: do not copy up an xattr value that was never read
Date: Thu,  5 Nov 2026 07:20:36 -0500
Message-ID: <20261105121919.1276067-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105121919.1276067-1-sashal@kernel.org>
References: <2026110419-skeptic-dictation-d90e@gregkh>
 <20261105121919.1276067-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 3c2672fcb8eb1..1f59470782452 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -95,8 +95,12 @@ int ovl_copy_xattr(struct super_block *sb, struct path *oldpath, struct dentry *
 		}
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE)
+		if (size == -ERANGE) {
 			size = ovl_do_getxattr(oldpath, name, NULL, 0);
+			/* Nothing was read into value, so it must not be used */
+			if (size >= 0 && size <= value_size)
+				size = -EIO;
+		}
 
 		if (size < 0) {
 			error = size;
-- 
2.53.0

