Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273067;
	b=R5E9gdVrMVUOJ7M9BbYHd7FcjuURDR2a1OtLVLKoCNUERV0Lvb4GY5sRxbO7xXpBDBGG
	 BKPeAwYMnR9ZkvDPYCSPPQ/TtT71SBzPc3TfywWQ8uCyg2+ffxs9CWhix1VTJMGuiCNYW
	 5uGGepQKzpRPU09PDaj3MSt6VmNypTzgon3l3e8LRBEGFZwGyikhsGcRg81PAvoS5fwEg
	 5/hi/Kz5Usx8IbdV0MV2+6T5Lp/guAmcEylM+QHoZcrtTJCuC5FANkDGr1XkydDXjQcXB
	 Z45kFyPPrOGRL1qVJk+Vw9eBKRqPII9ghUeXRCTs8p1axveyG8QFV5MyfQ92n8962AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=evCbkc2hvJaGVHp3IVvlUZA3nMk9qtT7otfoogeI46w=;
	b=ZqXwhbjWY1z1Z6mAnXjgMEqaf5yVdBZmO4CpMw1xxE7X2tlu+ZEKH1++hxnFO0Ml3AsP
	 9ny8PzZw6wWSnmOwkOF4gDrmpZoMjtO9S8SBjf8LMFqqK5NXJtgelHZo5X4ZU8DC1uaJa
	 VtyjFnSh7KQ3RnmW5Aq3W9pRimvyPO7ThCGWpiMyH6OBLRhBpXp2dP6QrkeFEWRImjKYk
	 /TO9V8PXZq1FVTIZhLgTjvqdHUG61M+0WDTCN1yAJDUIkXyAPDU+LU0u8UdNzua0d+hvd
	 JcFQSU4JRLkepHSesEPKPARYMOy1vfu+kc0D9GA+jrjLcj0TVgL79hFmzZ9VaD+K8Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXdfK+ns;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F57606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXdfK+ns
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0511F0089F;
	Tue, 10 Nov 2026 01:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273066;
	bh=evCbkc2hvJaGVHp3IVvlUZA3nMk9qtT7otfoogeI46w=;
	h=From:To:Cc:Subject:Date;
	b=mXdfK+ns/3qTxPEUw+01gb9+U9WvfelDSShnYubroM7297/jJrltVoK0nWmABl7my
	 fpWiySIoxrGt3hvZ7StfKiZ+Z6VY3g7w/DNwhkyxvE6KjvzPIDnAShiVKzSv17q7kU
	 yvIwGR9IveS96TOv2wrux8UDF9rWlRjeJYJ2ey8tsfvM2m/4cz+rncHJw17mkdEFil
	 u8Wb+Dy+8vzK25JT2Cqxhe/J1V/yzsZcV4217S2SoFSLCQyONnDWB6Xh3YxfzwWtTR
	 DWPsqkzBlAsd6KLPMbyKtdEz2xvA3y8jtHNXnOaDDXpca6NTtwqd0V9AtKf7c4HuZJ
	 9vK7BwjII/csQ==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: do not read past the DACL in the access denied debug message" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:05 -0500
Message-ID: <20261109201105-failed-6.6-8296a64df544@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8296a64df5448548f410fb246c1d88a93609602b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201105-failed-6.6-8296a64df544@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




