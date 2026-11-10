Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272811;
	b=QZ78eJ08AfuH8RjFXZhtqB8p4IazyF/ResiEAZyB41qGwspTImcbnpo2ToBzr1Abj2N2
	 bDa6DAv2EFhl6ePrid0SbwJ/7t2tiirFA7v4hzojmioLzvPrUvs0RisPa3eG1WCSXqQFm
	 xpjDVcrGp4+ZE0DAQLWx340t2C5FM6DiM5J6YEHDzz21dpN7WF5hH5JauV1VqYDK9AzJy
	 sr6PJtudhLQ1M38o3TlNVLGq9TfIQULV4O9bbwX+V/wL6DkNoc+AhyJBgeEU4G87ZcpMy
	 YNMuC5gHBMZfuss7MDVaDkix3zrIhgY/NI48GGaCUy+KHajtkUsHf614+CRe4Xv9wYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8ENEkDE1cFjLgcoO0+srNxnzXL+/rvzqGdsEKh3ZgUc=;
	b=wglNyQXdb8qwFK4Q/yWgWh6HgKaTyNq3xTItTHu2d9EPz7dDNjaAW9U4LdZH8OvS/oE3
	 TTRYNNesY9ALKFaTfhTiFlmlOgByotW+SpDJ6tvVCATzAz5vXXZBorLn8vFqU6N7ZFeV9
	 hrVRBdNGzPwW7wFtlTMdBjpwFNTKQ12sLnJ11KUuXqt15eYPDmXLFlAtiz3pzIbK0+Jn7
	 +B2t+T1mTwJJhkUmCsS2k6Xx7YqYeVJjWB5Vgk4ZAItZr3KeWOool4CQR2rKpIJFXc0b+
	 C15HY9W0L/KrhG0KLj1tHhXRhcn2A+NqttoE7sIDWgxfgNos5RPnuI+4R7EasIs/5Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGdNVib1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482D606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGdNVib1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BE91F0089F;
	Tue, 10 Nov 2026 01:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272810;
	bh=8ENEkDE1cFjLgcoO0+srNxnzXL+/rvzqGdsEKh3ZgUc=;
	h=From:To:Cc:Subject:Date;
	b=oGdNVib1ecemmvzzyLO+rRw+sdi8ABGF0d1c45DEhfXZygdm003r5uaQp2RztlS4I
	 /s7EhBOI4XZXT4EXSquny7vDkVe9cK7hvQ4w/ijyuxYp9AP/j7AC5vkOyXVaaO8gjP
	 pztM7Z+tSJWSJZEwkKgxHAOugx8qwp9miJDDtergOlkCd4iBpAbWeoR00anahs3QQ7
	 fVus3uvv5STxvVwYSBeccUx1mfwFwBtAWB8jIrDP3t1wEblMtPUASz229Q7jgjHucR
	 VGR1tTKKiPxdwLCpSdj9N7QwU2NYpBAGu8Lp2/NA3nu3mBuecoY4YPcuvHAV6oxWEv
	 p59vbTvJNRhfw==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: do not read past the DACL in the access denied debug message" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:48 -0500
Message-ID: <20261109200648-failed-6.12-8296a64df544@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8296a64df5448548f410fb246c1d88a93609602b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200648-failed-6.12-8296a64df544@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8296a64df5448548f410fb246c1d88a93609602b Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Sun, 1 Nov 2026 23:09:15 -0600
Subject: [PATCH] ksmbd: do not read past the DACL in the access denied debug
 message

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
---
 fs/smb/server/smbacl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 664f012636116..cdb04d29ed093 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1672,8 +1672,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	}
 
 	if (granted & ~access_bits) {
-		ksmbd_debug(SMB, "Access denied with winACL, granted : %x, access_req : %x\n",
-			    granted, le32_to_cpu(ace->access_req));
+		ksmbd_debug(SMB, "Access denied with winACL, requested : %x, allowed : %x\n",
+			    granted, access_bits);
 		rc = -EACCES;
 		goto err_out;
 	}
-- 
2.53.0




