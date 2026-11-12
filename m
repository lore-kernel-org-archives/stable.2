Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441890;
	b=QfTWu+aCbTVZQ3zn8HNYMSgwJYiRSVMDgrX3hW9KGK1egVQVsOzFHItIHMgW43aduGt+
	 8IzhURIyNJs/A8EEnuSbcR05CywkB3fgq5+jSp/DEgNL6e5jfmMe5CTlaplMyT1Fbx9VB
	 AxR/9DyuNLv1JM+XyFvZnYSun9GdX9rk+2DD8DKoDDZej6tB9AtUQrWgpfd8LS2W7a0Td
	 0+tZLSSxYBZZu9AEmZ9OBwO2KUPH/5kNwo9GvCDZSWfnrPkgQjtcKKyjRm+ANFYqzKtNd
	 oSwLwE1mpzW5FWn81DZnAXRTRjsifyesHZzLka7ZIHZGqU7fO3IliuGl+i4DU4VFdlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441890;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0k14GfAa78023BgV9Z4IX0AGDOXAjO2uFSw8trmjyvQ=;
	b=1jcrSps7rYeOBstSTGyEyIVlVAzccJwWGemUXWilSa/5QzsqZmbIHi8bUIoACYy0CC1d
	 +owAnj+15GijjUphXY2keiuNwXFX5WdFqWjTIajS82ITgOptbcHw8WIF+AsPRv1yRkHGA
	 rrkbGNFYZgBEYItA4eZ+iyU2kvykaGrLqw72nLNWeukZVj+RFeorwZ5JFwK/btKTW3CqP
	 2QgsMXl5BiBqwKWk4EBMffI4C1bJUtOfv8WDnUtTNdZMDWu3tl7jD8aDGNI67c9KMd1Tj
	 9FNVoZhs/Yc0CaMT2/UUjcU0XXwllC4vaStFQCZerHZw0aKvmMkLAKejEFpjDGOQe7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zx6MloLG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF87606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zx6MloLG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4B11F00A05;
	Thu, 12 Nov 2026 00:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441890;
	bh=0k14GfAa78023BgV9Z4IX0AGDOXAjO2uFSw8trmjyvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zx6MloLGpo20dH6n9ATN7aSevkeHszVl7fFxSTfveU7PSjk4wm3vgzUiB9zKT2jYS
	 30d5XVd41yRi/4Gp400p7aJ09duSayf9Xe2g89rz++2LG3Wkpy5M7vOdQg6x/Mitll
	 xhKWWkPMv9GaGd9v80/v9s7aoRhNxvhX+xtXF9z1AVD1w8G2+F1CRVBQD2uMRFv3MR
	 6tozvYC1bUUPUOnWYjSZrn2YYkT1bxXdPTTNgoRgdUNUUgmayFtXDfvnNseU6ZJ+gh
	 gb/uKC59kdZ2/oVXxC0ICH3TgEaXPLs4cSzTlQMWOg4ZaDAT9rjw/zTxFNgFvfOZfi
	 nE2PDWU2KzU0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: revert fsids on durable reconnect and replay failure
Date: Wed, 11 Nov 2026 19:04:48 -0500
Message-ID: <20261112000438.903424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200639-failed-6.12-539223f18026@kernel.org>
References: <20261109200639-failed-6.12-539223f18026@kernel.org>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 539223f18026448f67d33d09719c355b91db7fd0 ]

On a durable handle reconnect or a request replay, smb2_open() switches
to the SMB user's fsids before calling ksmbd_vfs_getattr(). If that call
fails, the code jumps to err_out2 and skips ksmbd_revert_fsids() at
err_out1. The user's credentials then stay installed on the shared ksmbd
worker. Later work on that worker, including other users' requests, runs
with the first user's fsuid, fsgid and supplementary groups.
ksmbd_free_work_struct() also warns, because work->saved_cred is still
set.

Jump to err_out1 instead. No path is held at this point, so skipping the
path_put() at err_out is correct.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Fixes: bb8bf7eb13b5 ("ksmbd: add SMB3 request replay support")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: omitted the durable reconnect error-path hunk in smb2_open() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f7e3d7986c4ca..1af013ae66f94 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3129,7 +3129,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
 			if (rc)
-				goto err_out2;
+				goto err_out1;
 
 			goto reconnected_fp;
 		}
-- 
2.53.0

