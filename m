Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443006;
	b=aHykDSwR78Kid6vY5CscgdBFsauLvyeAfkfDHypmVZ4WXH/wyQ+4fTOmt01haabBy0gz
	 CVw3PKfqGOZO9MZB2FvUfyICVL+UikCF1J3mU00cVx6mM9ACY7suskDKydUK6wAVVv+uh
	 FA4DGV2uRqx+bsgyHxX9zqM3ukGPrxAK01rMUDDu/emw1YHXClDloJJ3DugLcoduKHFeQ
	 REzwIWNiimkWtghy67BzBAE/BwQSO5NSIQ3KN1QSz1AOTfpqM0+NElQLtxBnnmj1+e5dQ
	 MjEGkuajoeiZvF+rmZFV/A//j7bglhouu1r42pnOIdwonUfCZoLNnK9yZMf4t37kp5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X9RnF7Xeo7TN1lmHL+PWw6xzRRgbjJnrK7eLwvGQc2M=;
	b=Fy7PfHS6z2j95Z6SdxbNNqzav6+1N5woSUAcjGblFCebF7FrY/b2Jmy/NAQvq3Y6P3uK
	 fkpUdrNrJyXbq1AwfS8rp6Y/k6i+JC/TaDPjJpvkyktqeJ7L/OkgRpoaSpF9aTiYlYigC
	 2GHtLrMDx8rKn217MTMv4VE7D8ChJYmPoqRj7lj9X7anBB+5m/7Np3ehzRL/LGzlYmTg6
	 Jcl3ceQRL6ZXJ1FDkt1QEi3rKmNCWQ2DhfX4bAJRePEM4WK5IrmEp1ensRtywvylW1jil
	 hhH3QM6F9u9wBc+hnDYKgroi3KwQduB9+AYIyZ3vTijTqI3F/KgDNBNRRAUgENitK+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IMl8Jh/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC91606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMl8Jh/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2D01F00A06;
	Thu, 12 Nov 2026 00:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443006;
	bh=X9RnF7Xeo7TN1lmHL+PWw6xzRRgbjJnrK7eLwvGQc2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IMl8Jh/ZpLJ6CnSxO71PdUi30/UkTQBjNreNwZe7jO5eT4rAGwEC4XWrTVZkMjK9l
	 mPBpPKqPYuroih60gKLGJWV9qgSusY8tqn6ai6nuF7HUb6YRG0FfZ+DIVbEXocx7AV
	 jtFveONGu1US4sEGaeXyuIbVfiEOQFV2pPQyxYThbj0w59dwtuGAqQIrpAg3WumosO
	 8bbnYaGx/0h5jaTLYVNU+lCnaMqAQ0eKqI4GvSs1LeWbSeRRYW8y1nS1EBdrFriP0B
	 hJFeqkZv15xYV3LVRS12EYMKtYtwkRUJpUGLTSDYM4YLO/so0j8k9ghyUYz6YmOCwj
	 kQWUSQMwaod8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: revert fsids on durable reconnect and replay failure
Date: Wed, 11 Nov 2026 19:23:24 -0500
Message-ID: <20261112002313.1062424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201057-failed-6.6-539223f18026@kernel.org>
References: <20261109201057-failed-6.6-539223f18026@kernel.org>
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
index b05774050e096..984e194d83f85 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3101,7 +3101,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
 			if (rc)
-				goto err_out2;
+				goto err_out1;
 
 			goto reconnected_fp;
 		}
-- 
2.53.0

