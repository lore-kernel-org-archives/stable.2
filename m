Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638634;
	b=rY5UVC8AjJJpDEuaB0tRDvp9vpZSCHVVw07NCdQ+6E6hXQFwx1W8LO1+nRQpNTId+KJe
	 9NPQADaCUuvblIcVr1KCBjzBazwhcD3qjxPWcupcfnZacoWcVstVoA0kewcXfXyGzdJGO
	 N5FIMzQWrfPqji8I67AcT1CCo079er30wqSubtJucgHrDl2TsiC80wEAUkFKiUNr8cn0a
	 u5hHj/QQOOelbCk3TwPb3J8o81v5JKn79xC3NOk65yrrytoiTbHV1pBgRJMqkS/Web9XX
	 UpBB/2wx46VKlXCax8npsyudiqoh50lLUN0hZXBBBuudmqNoAN2K0PXTairOfbcDuTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jeb3e/S863yyKCvz2KfE2Ydd74t5eqXn4o1HTrz4Vnk=;
	b=EXiA/jDRCEQbqilrpUxzMtl5mIgU/bUybc/7IS2647i6h/3gsSpcJGR8Gl5UyJ+7hpI+
	 75bRmCoAo4xXrT8iijVl6aFOox4/bUnxN7caTo3yrxi2Ap4wq/XsNOmzJsSXQvmt8w7uZ
	 eY5pEOwRw5Rb/Oyq9lkp4BSi+PMHgtZeaxAOiIPbOVXUZXQIeJfPRtardQeaw4t5D+FgL
	 VKxX/bmEYsRKr/7x2r7rDvYoBcWnsdaArixum/IPLeQS7rn3uSV6uYYIXy/+CGCAPynuv
	 czfaAIKy+pFRAWvdPIQiG/fygLd1dXqWt0uwE2R/YQG+LsNya3ZHGdItebgRQ1CjUWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L+Mzh0i/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F333606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+Mzh0i/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB45A1F000C0;
	Wed, 25 Nov 2026 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795638634;
	bh=Jeb3e/S863yyKCvz2KfE2Ydd74t5eqXn4o1HTrz4Vnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+Mzh0i/VHPFsmUhtCNMmJEkg+Regha5Ypd/p4g1nBsUSAouUs9NqgRe5vGnjoMIA
	 VfuLXLQYSAhjMhcVYEmvDna2/SoEfXI0PINdLiQDEDGaA1tcNYLQKPLy6kQdLlFlg6
	 lzJ7JSoPkAjAPHp0a+H0sb3TkI/Q/g50e1a+DebufBl7DBYuhp/eZm+CGzLnHDoeKd
	 QzAB9iIx/NwSW0Iuu78IhtNn0lX0b1n820d5qSIQuSQUQLJHMBQhYlHSRwQaz8HPgf
	 n5md+6GmPuGRwS2coqdt8CRVlxjZpvQLVZiwmewmoyjRpWsu+RZBLkjpkNXa9wAFUJ
	 yczigPBORcTHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ksmbd: skip metadata-only stream opens in the delete check
Date: Wed, 25 Nov 2026 15:30:32 -0500
Message-ID: <20261125203027.1420028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-uncivil-cesarean-e13f@gregkh>
References: <2026112507-uncivil-cesarean-e13f@gregkh>
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

[ Upstream commit 2f14fe2d589583ce649b2bf1b449cc9839abda8b ]

A metadata-only named-stream open without FILE_SHARE_DELETE blocks a
later DELETE open of the file. It also blocks setting the file delete
pending.

Ignore a stream open unless its effective access includes data, execute
or delete access. Reuse the sharing-access helper so overwriting a
stream, or creating one on an existing file, still counts as
FILE_WRITE_DATA. The Time Machine AFP_AfpInfo synthesis keeps only its
requested access.

Fixes: 19043971c947 ("ksmbd: honor stream delete sharing for base file")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261125195014.1296732-1-sashal@kernel.org>

 fs/smb/server/vfs_cache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index c6999ed4e6d67..e0b78623d7b62 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -344,7 +344,12 @@ bool ksmbd_has_stream_without_delete_share(struct ksmbd_file *fp)
 		if (file_inode(fp->filp) != file_inode(prev_fp->filp))
 			continue;
 
-		if (!(prev_fp->saccess & FILE_SHARE_DELETE_LE)) {
+		/*
+		 * A stream open with no right in FILE_SHARE_CHECKED_ACCESS_LE,
+		 * implied writes included, never conflicts.
+		 */
+		if (!(prev_fp->saccess & FILE_SHARE_DELETE_LE) &&
+		    ksmbd_sharing_daccess(prev_fp) & FILE_SHARE_CHECKED_ACCESS_LE) {
 			ret = true;
 			break;
 		}
-- 
2.53.0

