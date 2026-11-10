Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273350;
	b=bQ91nkWGiEYAAn3a94/HRgBSNnIz98KYFLeENUKHKn8bAVOQ4neI3fB7x9KWrf820gTL
	 N3/BNdef1nOtP4hVLwLO3VpK06CVe4wRhSQp8b3wt9iDR6KtNyK6yULMxHcp008zDCc14
	 +3ZeLye1oGuIQh6CfQBZ7Acazh7QjWYc0RCvNZyBXp+T15cpTWNl6JGVfB0fHMV6+jq9J
	 PE02rTGCW0yZ0qE3Fppqg5J7MgqraqYzyPTNhaRqI2s6j3TxcEUgWkpcawuu5uw6PQfIL
	 1il9XqlCGou66G1yvVJzKFX6SxUqhxaUBFyROc3QSk7M2LkMYpUh2mia5pJ5UYLDV5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HKy3qfAqGz3zEa8WBkFnx64/J617vJp5fCpiq8f/q3E=;
	b=HggShPFYkPXzrdRJiU3r70v+1C/IqsGQWkr5FJJ+71IqURqJwI3au8oZQzqq5anBNcVX
	 LsTFN4j0mh6zVZ6U3FDE+9gkYfo03Z95IiNR39AUTDs/iTR0aD+cFWyee5ZGPa4MXZgCF
	 lQcx/ZMvcklFfJQAKRQ81NVvhrGUJiAxK5dDn5xyryp88nC6S4BA/o1GPx37EBCy6fgFo
	 3CA6xuwZDThQpGLe5QRH4/w0olJWKJEGuuv3+zGuJyOczyNrxLvOyvXWg4BiYnKpI7m3q
	 sIUv6uou5e7CaSXTgP8pWCNqinCsfEuxO2MixItbp85vJlh6w+GWQB118N3/OuATPdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WoO37zJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WoO37zJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B101F0089F;
	Tue, 10 Nov 2026 01:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273349;
	bh=HKy3qfAqGz3zEa8WBkFnx64/J617vJp5fCpiq8f/q3E=;
	h=From:To:Cc:Subject:Date;
	b=WoO37zJETLWI4eiEGQjJlfulTAhlw7GGSZquRVNIqmQxiuRmsCQJOBBdlmwH5acay
	 PZRXj+rrK5i5Sn7VASdQwd2i8/nHEHQ/RhBGqfCToBxDLH3MN+EnJiEPFzdwYysO9/
	 DeaWLCrx5fDahcARK2CnIPisgqhW4o712tHKJsdnICjO6BTZHMcOcZ2sUu0HRmVxAC
	 cRx5OqGlsj2uDyZZMuz20OHyq8AEKsqRa5Kici3DvEEEdjGliEDL8UTxrHCWY5NT1o
	 uSUM5FrkRM9vEJfWeirWNYfeT0YnkUBcL6BFf6teSfJnOJi0KlpzY20hdAUI5mW/un
	 fRuckWAebaTVg==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: do not read past the DACL in the access denied debug message" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:48 -0500
Message-ID: <20261109201548-failed-6.1-8296a64df544@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8296a64df5448548f410fb246c1d88a93609602b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201548-failed-6.1-8296a64df544@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




