Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458445;
	b=HI8wQSgunZSoqKiCozeSKVT++g/eOkg1QVEgoAHNPqyEOIp6z3F+EhjkKDvuKb4OOt+u
	 YSH6Ak+g7ji+Ntny05MhEpUDMbfzUH/LjNGnWzckKK5N/+4sTPnxH20FZjUYS1FEoWZ1e
	 nUgstbd/g0tK4g+Vdotp+yZ/Bv8pZLywelZyK+E9L68Qy98In5DkmZWBjpum7WVDmgQwH
	 yLxl9SKAV7I4syiJQ1o38cu07waQ7zisJTna5NSwxN7WkOTx0LaDNsEtVOMyD5ky2ctHQ
	 L9gh6yLKRuMSJXiZ9Tvo74uZCLxmzp32AyDm6zQPpYJttDdcXzP1kb4DHagnEX08CKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458445;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xtSr1ae7kuqpPYndQ385xpSs2QYn5uuT2hB9d9tJ9Vs=;
	b=cAcSLzSddu2yRfduMs1yUZNxoNmZwm61sGsFN8j2uAmj78nQLv94xhAhqv7WhLib+BXD
	 mXC3k6C6E4gAOXPFrCSWQsL4H5p5cbGcAQZIUx9jnMbCBUuRaTrxgsOAwO0IMA0uKoxz+
	 fhg1TlIn18vpvLCR4l0LwHbWJM66Q6XyAqQUIznwiUIHq4gZOmwEtm0zavXi/7jbREmpw
	 4DWSDLsV5peMBKLvcwSWMKbu7z4/n/+TOdsiw6Oxj0DuiasuJ1xOwdyNuNzK8InCD+Vbg
	 S2kwujyJACi5j3efV76L6TmtqF2eKepUH6MhQ0eg+O8JCMs++Gk2FRM8B2vJa912d9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HU9/nwOv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEDF606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HU9/nwOv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AC91F00A05;
	Thu, 12 Nov 2026 04:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458444;
	bh=xtSr1ae7kuqpPYndQ385xpSs2QYn5uuT2hB9d9tJ9Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HU9/nwOvzcfoqiFo/XPYOvhPHHCNoiGP9fwu8TIYdk/knmXwW0yOAb/bZpUimqcch
	 vHH6L8pYGfy6f0DoVQpt7PCQdEiGFTk3i9uOcVIPG8AfW2NagDGlBBB+XBE9ypwp6m
	 alDtJdJ7TlVobL3HmgpBG4hOJu1hHckxCdj2r0ix0sV8vONfSgu6gj854SnS8W4mC9
	 EuD20eywjARcmC/lThzvguxk558bXo2s+nNCi7Evota6qdbfzvhLu1ySgJ3TVV8O4W
	 wUVsJC5Qlc0Hpv+AOkCuocHhm6Aatd3ymIeeqPpZPA4L0TDmBd2AqKLv7vMOWK5eno
	 8+5ZAN88hYAfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: do not read past the DACL in the access denied debug message
Date: Wed, 11 Nov 2026 23:40:43 -0500
Message-ID: <20261112044029.2159669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200648-failed-6.12-8296a64df544@kernel.org>
References: <20261109200648-failed-6.12-8296a64df544@kernel.org>
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
[ sashal: adjusted context for the check_access_bits label and expanded access mask ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 63f7bccb4d9af..d8c01e775d941 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1650,8 +1650,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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

