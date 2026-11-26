Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665654;
	b=AmViPxQaVdCSKydDpuUnWlhp9eWMKBax8jUaBfibxF71SmWd/3UMJsCUCufB/e/a2jOV
	 iAlwH6bTXKB178liHrNuN3yYeUSoIW0SBxXWBtpHRfSmzBDWArK3lNByrZyhLGbOf20Oy
	 YFksM0Ast3UuMY43g5JISmHTDRMzjKyvKwkbD5WAlevKULu+AowJDwWGYOSwZZdgA2yQy
	 Xkn5UiXzS72hwFsFLQnsw7B8rkjL9HORKipF6z/QnUhpKjpdCfHT3P/iIMZtbCauwql12
	 qujVldfyQcgXExcbH9SDg5QDsvg3NzFtVhk3iUIOlOOkUinJzZ/zIjY0TtSGHfCTUng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mEQGVuGWvCLhrgykgf9B2S9Nah1Pj1/wtoIYR2RWYjI=;
	b=cTlcAZv1sLBMzpGILlG9Ry5sJ3zRKRPGCOESHUUwmKoO7Szvdnuu65yDkLB9ApyBoFX2
	 o8S7lLAuqIgb91cddIQhx5Rw3uF6/InyYTS8MH9IjGVwdKEbXZAJwLBr2NN/ecvQ1psIt
	 6888YgUzvkBPXjxKvLPGA8kCs1Sv0Mqwh63sKqQ2/dLA70HrmD8xk8HdZPGH8eD6f3xvA
	 xgfGC8J6U9lK7ULfoovcYmQ0/mCHp6WlWBI9aaIKkvp34m/qLQA4JpX6zG/Weudb+SIIU
	 wGGVq4M90my1JxeFoCdDaLGfG6Vn7sH03E+4heGD8I8Vsdac8fO7DjJjS/Ayd39ckxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVA5p9lf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A1606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVA5p9lf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34031F000CA;
	Thu, 26 Nov 2026 04:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665654;
	bh=mEQGVuGWvCLhrgykgf9B2S9Nah1Pj1/wtoIYR2RWYjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVA5p9lfADbJSTBCytaYQZxOthsh4m/llsEi6RktEbszU2CJ42tHYqlHAXcV90FZM
	 T6mBj2bWHQo+4/SOrsj/9QKF8QXOmwriXeX2lgYTxbDcLlc6stUkRca2EirJrJsklj
	 sIUfBspOSZlUP9bkcx9vEPhVUtSdWrby4gywlq0AaF5fBAvPAQ0uLTHU/mcI90nYyu
	 kBEKmQaX/6gPNIMMvHHV0ZIkDNvnutydksla4OIbgOkdZGkYKG4W98QaKfbjUDkZWw
	 ggVizlIhZHPQMjXT6qtExwKWmXa19sAYu3H5m7T5dmnIe93sMUkvUeDgwFZboHXFvx
	 URsmaVpRyncAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifan Zhang <yfzhang23@stu.pku.edu.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: bound invalid NTLMSSP signature diagnostic
Date: Wed, 25 Nov 2026 23:00:52 -0500
Message-ID: <20261126040040.1869924-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-natural-provolone-2579@gregkh>
References: <2026112511-natural-provolone-2579@gregkh>
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

From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

[ Upstream commit 0584b02669c3e76188097174b4f25ed13723e94c ]

The NTLMSSP Signature field is an eight-byte binary value and need not be
NUL-terminated. decode_ntlmssp_challenge() prints it with %s on the
signature-mismatch path, so the diagnostic can continue beyond the received
blob until it encounters a zero byte.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in string
  Read of size 1
  string
  vsnprintf
  _printk
  decode_ntlmssp_challenge

Print the fixed-width field with the bounded hexadecimal format.

The patched kernel reaches the invalid-signature path and returns -EINVAL
without a KASAN report.

Fixes: 0b3cc858003b ("[CIFS] NTLMSSP reenabled after move from connect.c to sess.c")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: changed the file path from fs/smb/client/sess.c to fs/cifs/sess.c, with the same one-hunk format-string change applied to the older location. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/sess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 0fbd0f78f361b..44392d88f83e8 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -591,8 +591,8 @@ int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 	}
 
 	if (memcmp(pblob->Signature, "NTLMSSP", 8)) {
-		cifs_dbg(VFS, "blob signature incorrect %s\n",
-			 pblob->Signature);
+		cifs_dbg(VFS, "%s: blob signature incorrect: %8phN\n",
+			 __func__, pblob->Signature);
 		return -EINVAL;
 	}
 	if (pblob->MessageType != NtLmChallenge) {
-- 
2.53.0

