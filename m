Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273657;
	b=XvNH9fFVglbGZBZgA98zvxoQSwJ+Z61jaKS77EKxYGhINtTfW4/eCRQ59sbk3llh9GdE
	 sPA2PQjm2hwA6FEpJFtCP6+GDsiBcjeNSjFZszSyhiZtBQMIPPlh/mm1DadJBS4RycSRi
	 B4oCYPuUKh/V727u+JqTrwErCSC3U7UOiIJ9DDBjr2dwrt/ev36ZJFeBAiT2S7gkKbjs+
	 /OYqm/MJrKVNk6u73RPuBVDI5hY5txxFcUeNgwtduEfylD3iydFoNpdXd7rMVk2ltAgWD
	 F2Gh1ts446dFyQBKTwveSsU9n0bp6UH0l5dK61edmaRN8MN9ODVZqbaGeGWdPP2MdOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HGi3GRh9W3JwRyUQkn6/6J+pj0CbVREkE2nFgF/7eJ4=;
	b=dAL5oyR9J+UcqZdBXalaEwTAkj7SvdZgsFrB4qmkxyBCZ0SgcNMLpQrpmDXd/fokb+1z
	 a2ZTES3kAfgZ/fwZwSCirfgCkwfGuc+qq+WVsSok+v8urhmqBqxaPcxdxwPYmkuAqsjaj
	 mMyLUDd4Hp36/qdVe5E+yglXzm46JYTck3meJuWsgscjvdYFz8ELYYz410XWrF2NVVvq7
	 VcSy+rv7yWWAnxpA+FuVAig6wkFw7oFyrMRGG/MI7stKljMxPkXcG/plgTtfZbU6ai0G1
	 u6D3UY3aaPMHDauCI/sKuotQqSX7LS1Uu83LTGGC39jBV/vvCPa+4AaAyv7xrVAbZnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRoUWpL0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DD606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRoUWpL0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B231F0089F;
	Tue, 10 Nov 2026 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273656;
	bh=HGi3GRh9W3JwRyUQkn6/6J+pj0CbVREkE2nFgF/7eJ4=;
	h=From:To:Cc:Subject:Date;
	b=QRoUWpL0BodGfHGvKYeRDaOBU7phxtARPMVa4W8qPhnuqRNNcl3nrayQk5cRnC7i/
	 aZml7eadjokDwOp7a2MBL/MNYj1tLenMRQ/UTv8DALcOqdRU35zKKdagvQu5R+rOmw
	 zcrxG42TddWb+6MdyWLt3wLH74Q6w2PUgBsgj0qBhepHHo1OjqqZR68BqXs2maKdFF
	 5Axx5rZven2xpJyc1E46rA70CySt4a8dzdEWhsrzu7F8+Cm7swxSuIlbw5CdP+bX9m
	 YNd7M3VrPZgQqevZG8VzKVVOInE8jZ9uVqCzu37PfQeqNsk5Nvc7WRp9bIt5LZXSn0
	 PkLriV2zvrHAg==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: do not read past the DACL in the access denied debug message" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:55 -0500
Message-ID: <20261109202055-failed-5.15-8296a64df544@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8296a64df5448548f410fb246c1d88a93609602b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202055-failed-5.15-8296a64df544@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




