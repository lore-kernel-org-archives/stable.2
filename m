Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513472;
	b=5CjIxYi7NFczSHkENa7rVlBhDZzdejWaiii7/EHaVgtjacN642Wc93t5WH6Y8wksqOtb
	 larSBbjkb0djdHR3Xm/bq9oMvcPqlQIoYTP/r7YpOpjZsknpv2Tr2R4nNGxlCQkLfdyqw
	 2i2a1MZRoW7TcvhhQtziEboHnARjuU2WAeFyiVKNRCzgepq7n7ow4EDRjwPif6v5yh+Wz
	 H4XKcIEVez8u+kbYLG/d4EGxnqukLcvgaXO7ndRafYzRIp3g4TY7g//bZBfgMOQ/IbYw9
	 z+j27tj3WBg12BUS869bPki0YX4RSq7zThSK2RDVONmf7f8D9Lijbqsgrtpxxh0C1nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513472;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lr67G7nulEcq+QJgQ2z3Hh+YrHLac/msigmeMmT0ycY=;
	b=ZZ0Bz4eBgNWvE10gpCpYmm8XeLTmto68PQVDj2TtTepUXZJUBmEJKYqaEC2zgNegkb30
	 NCV6XiryYxu8TIn1xNHhmbUeL3ECjNnisOiSXcgNmYkrynmTWLfmWBN8hbe1NROgDsGZ+
	 lQeI1+MuZGTz2mxN1dqrkXBgopk/I3Vp2Yb8K+WcCe8/ktp9iP2BjDN56n/RQXh9J0qyj
	 vQWINaqLxSeNMkGky/zKCI2nFPlIgyZqkJJmBgtRfzSyiKLai3g/Jgbn7Rpfc81L7PQgH
	 fZ2kk9YV+76nZVKKfa5IcC3Fnp17HtCy4Whbgx9H0Fg8oIuH1tfrU2pgCFA3UKpsZYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gw909o8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797E606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gw909o8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE86D1F000C4;
	Thu, 12 Nov 2026 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513472;
	bh=Lr67G7nulEcq+QJgQ2z3Hh+YrHLac/msigmeMmT0ycY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gw909o8KN+63lpmfdpwv+GJN1GFElEFvnFTqop0zwu8woYORx7vwYa1SZ149Wf1Is
	 ktVadKKgWPf06crJWXqO70SZPWCeehgZ9GilWxRU89eFunrOS7r6bRBFNBndbR2bj+
	 YaoAX7ZZf600RwK6aDDZO7GJfncIM9CAkRapzcXC6MxZBLwLZjJ6oR6omIiGEe8quo
	 itFGAnct0fKYo8taBbnlON3CkkPnnjB7+oyWTHgsaRR3uqkmQQ2G6xrzWGYboJB+67
	 qKLgJshgKwuz0LvNXa4NDPweBAEm6PseSSrVSxg/ePf6AU3HgM0lk07RZcamoESI11
	 zJE6iQ7PlUdwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: do not read past the DACL in the access denied debug message
Date: Thu, 12 Nov 2026 14:57:50 -0500
Message-ID: <20261112195715.3372535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201105-failed-6.6-8296a64df544@kernel.org>
References: <20261109201105-failed-6.6-8296a64df544@kernel.org>
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
[ sashal: Adjusted context for the broader access mask check at the check_access_bits label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 40b2e6b499457..6147322bb4b0d 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1640,8 +1640,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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

