Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518852;
	b=bSuHSBLdxzF7Z1AI8/sqr8vmccwu3SeIKfzszKmRNEFb13E84o+xhBS4IlWG1YfC8pJ2
	 Ia0/QC46054+3HM8S8POPP0O0+f1fNX+P1oZFsIjDaagm9KyWcMVynI2YOVC1O6i20zxq
	 BbvWqolAOWhhD3TEm0Ln/ilTmCpWjdp4VT5rR+Pnet6y+nzulVhLNolTc0nDzwqJBIh2/
	 JDAVsaGxjYl/RXwzwJRAttfmKworHB3CECKBo44POygiZudfvEP+jnAwik5JfETUTNhQx
	 oVOozu27z83AJuUv9SC+7l1nEmg70JqhiRr3p435tuXmHVzAc8GTwvNaKC8Gx0l26XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kSL5EzLD37Qg65laOgr6jbI6QqyJ4A+Vm3JJfD72qss=;
	b=nyTjPCGg5+EtnczjqGByw4SRdkQdlvBCrIE2zv+JzqVX4BH+jBV5BZ/wFRZXzNbuom+T
	 iAlDZ+av/TlVMibrcZHrVtdH4LJxb0XLycRVFQBc/Oy3VNlYQp9AGUmC4NB0n/WoXVeqf
	 R2P4CJKRCLUDOWTp41NYXfnuJSi5Fh4fWa15uQMgo8gisuvLPgJQ0P3Bc2GxnIKHbun3R
	 e+2TxldN/kTBn9n8BcpIsbtHw4a4XAByAn5Zl3Su+yHYbJY4bKyEY9/XuYOTNxPXOOgws
	 bcxCWUozWj0GNsW7pivd9GzngPZC2LrpjIvPVWu/59oX0EIMbE9EtNPj+/0WJrJ1mug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9qrqtOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6A606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9qrqtOt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5620F1F000C4;
	Thu, 12 Nov 2026 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518851;
	bh=kSL5EzLD37Qg65laOgr6jbI6QqyJ4A+Vm3JJfD72qss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H9qrqtOtTgaCpFeERwx3wSbSJ12RjFvkDVN3jL3+qI1kiTEKtUlTVohk/FVulHZEt
	 hqD+54NWlDU4yAKPHi6pfUmg+07UuJ+J71H8a5pzlVC0oklMpJhNXniDqf3DmB7P2a
	 WW1me2y5MTKHGM4GCzjD4gwZ039/rhfJtHAjuuhBJyGIyayUG4hxLEnoCgypGNsw9T
	 CTl4ZTKYIgL8VJHVJGNBnefXwmuASRyJXN9HGQI7/ly4Lsx7TN+bNh86lEeXEaBAyp
	 RG/M2Hwag6jH8kkI1henGCzKK2HU3/dGZtoLgZHym8qdFsHOoJlm40YZsRrSmiwgA3
	 9BpxUE2tHHQkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: do not read past the DACL in the access denied debug message
Date: Thu, 12 Nov 2026 16:27:29 -0500
Message-ID: <20261112212655.3643012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202055-failed-5.15-8296a64df544@kernel.org>
References: <20261109202055-failed-5.15-8296a64df544@kernel.org>
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

[ Upstream commit 8296a64df5448548f410fb246c1d88a93609602b ]

When smb_check_perm_dacl() falls back to the POSIX ACL and then denies
the request, its debug message prints the access mask of the ACE that
the second DACL walk stopped at. On that path the walk ran to the end
of the DACL, so the pointer is one past the last ACE. If the DACL is
the last part of the stored security descriptor, the message reads 4
bytes past the buffer, and KASAN reports a slab-out-of-bounds read in
smb_check_perm_dacl().

Print the requested and allowed masks instead. They are what the check
compares.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Adjusted file location and context around the older permission check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smbacl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index ed690767837fd..adf9d2d2e108e 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1417,8 +1417,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 check_access_bits:
 	if (granted &
 	    ~(access_bits | FILE_READ_ATTRIBUTES | READ_CONTROL | WRITE_DAC | DELETE)) {
-		ksmbd_debug(SMB, "Access denied with winACL, granted : %x, access_req : %x\n",
-			    granted, le32_to_cpu(ace->access_req));
+		ksmbd_debug(SMB, "Access denied with winACL, requested : %x, allowed : %x\n",
+			    granted, access_bits);
 		rc = -EACCES;
 		goto err_out;
 	}
-- 
2.53.0

