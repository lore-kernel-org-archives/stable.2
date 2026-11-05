Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907763;
	b=1ikAKhE2JmufCAsP09N4QhgA/xPKzEYrcIyLOBLuNiTp/WfvROBGmoeSJ06gPM88M2In
	 6aoJlfr5rUKsiv4XJwtaKQlQwHs2alUxTmal2YNBa9ANtyKIDWl7589WeZaOk6acBnFGM
	 I2KH5FgJz6wHVwFmTpGsyHefwQRjc2QCZAsDa78E2rMM5u74XPs17SresPdzme1zYnGPP
	 ZKY4i1naLHQOgHt9f4I3viq8iMp5NKe7MTVCjE8hhI7oEA1W2heb1tDDgqOhQBcKb6a/c
	 lGdKQbGGAJKmiYJ6DVgZuGoD9Vga6mTbn/69vS79ZbmZeHj0vdJs21v8MVbyiBWNKoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PWm6vf/ymT7/ctxOoAv3DVxfgR9bNkbX3NAccpGDFDE=;
	b=FzV6i9ZHcEGXjHS1tNYlajJe6YF9hTZSz4e0XnxPphHnmL/olc7fBDa/hvAKByl3IbyZ
	 9gieaPY9O/nAZpCj5OoZQSTaTWNhf2ERqx1wOYFJPsw5HGx2/MDlo7K/hk7KpuhFdhe5r
	 OOLKnQJEFYziUfuACzJrJC0eAAlmySZylKCSCq27muuXO1zIlWvgfmPtzdOiazd3dc4yO
	 sQ64E+datr5c0sL4+vBW/rIjHHg0ajVpb4+UBOkH+9BGCr97o6PD6hjspax8duvxFR2sJ
	 G75k+YCO8aFOG/Es5xTM5PkiysAfMLHpa1ZIk0qnu6OjWRnBAHEtLcVs6aZ7UTfvGfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bPZsa99/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A9607857B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPZsa99/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B101D1F008A1;
	Thu,  5 Nov 2026 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907763;
	bh=PWm6vf/ymT7/ctxOoAv3DVxfgR9bNkbX3NAccpGDFDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bPZsa99/1EFfiljFgmJvie4IoVlZUOuFBkjF6Jk4zCmDYRSBiM41Z35bEfEez/uS4
	 GUJPeDKvmszvXR9/K/Rz47cXUlaEwyBRjoX6fvpFj5Glza8tYabzRFqHOTbe4DCvZM
	 9Mxl6IohCot5qPv2EjGgQHBPObb4EvRr/3yuGjuIlBF2oaAtKNOd8yNCzZLr7XEFLu
	 w+01XCgPNMJvdxx1wThiLuj0XgYH8hpZLovcuLXpI3rwDrbxZtEz98EVlp6uaY6RHL
	 5XnsE5yEivATqAdMcAFMFSDnpI4neVL1m9gjMBt20AJN1U9V8K1UL7pOpk6LhoGIZt
	 QT/vximpSxhdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: bound POSIX lock data area by response length
Date: Thu,  5 Nov 2026 14:42:41 -0500
Message-ID: <20261105193924.2633468-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-purchase-culminate-fc4e@gregkh>
References: <2026110407-purchase-culminate-fc4e@gregkh>
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

From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>

[ Upstream commit 8fc9af68c57156ff64769f30e831553cd03b3000 ]

CIFSSMBPosixLock() receives a TRANS2 response whose server-provided
DataOffset and DataCount are not required by validate_t2() to describe an
interval inside the response. A server can therefore make the client read a
cifs_posix_lock beyond the response buffer and return those kernel bytes
through F_GETLK.

Use smbCalcSize() to obtain the full response length after any multipart
TRANS2 reassembly, then reject data areas that extend past it before
dereferencing them.

Fixes: fc94cdb94462 ("[CIFS] Fix new POSIX Locking for setting lock_type correctly on unlock")
Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Cc: stable@vger.kernel.org
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Subtracted the four-byte transport prefix from smbCalcSize() to match protocol-relative offsets. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 11a400663b9f2..c792de4c706c1 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2481,6 +2481,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "Send error in Posix Lock = %d\n", rc);
 	} else if (pLockData) {
 		/* lock structure can be returned on get */
+		unsigned int rsp_len;
 		__u16 data_offset;
 		__u16 data_count;
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
@@ -2491,10 +2492,16 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		}
 		data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
 		data_count  = le16_to_cpu(pSMBr->t2.DataCount);
+		rsp_len = smbCalcSize(&pSMBr->hdr) - 4;
 		if (data_count < sizeof(struct cifs_posix_lock)) {
 			rc = -EIO;
 			goto plk_err_exit;
 		}
+		if (data_offset > rsp_len ||
+		    data_count > rsp_len - data_offset) {
+			rc = -EIO;
+			goto plk_err_exit;
+		}
 		parm_data = (struct cifs_posix_lock *)
 			((char *)&pSMBr->hdr.Protocol + data_offset);
 		if (parm_data->lock_type == cpu_to_le16(CIFS_UNLCK))
-- 
2.53.0

