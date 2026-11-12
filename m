Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457486;
	b=Ir+Pj7wBftr2eBpwMoW9UPaaD5aNIilCneQY8Mwe6xoGjm2bGy7guv2Fvjq/I7upRdvF
	 tR1RIDZ+nRTnZdvJaOCXXLKKwsceLibImEhqY3rM1QUEkszenSVc1GzJ2I7NXPvUiT3Sj
	 NdkOYMs6O4W5KkOfEz1thX2A+iYQbphTjXj76LG4DuXd3gMFQWdMm2pKvzkoW+sIIkPM4
	 nt6Kg0GxXCJTxkYO9znFCUTya4PEptKJ0iyfG3CKCSXZMC0Ouls0zrtrGT+6SCyiSimo3
	 37zFfb1lKesf2MCizl65wW06WmxVVYd5sH0WtlGt1b5neFZfE+iVflJt+h3JG8d07Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ke7aOP6V0aZe+jGmwFbUPKc8c2Hnu4gyh3+StXw/fWM=;
	b=aNWvOPfkWhdlChHRC9GrUE7Yc+On01w+UqpbgMvDZK9W/PJb2jsFlFQddgEodqeqecWA
	 8osjwiD98ioDwSkZZDL0WMe3DMKTXgA6iH3ix23We0E3DGqQotJAmcvBEfyjQhqfqrWww
	 hb/fQAtFzInuu+gCk7Hihhglyh1mK+bwHZ9XuH2tEjTURRbb/syBTbOJigsgg8xuIyWl8
	 VNT/ufHMKUj6aCWWiNivG21WVJNgGVPCL8c3hCWoPbwQbzaO4GNmvL71nddEF7SsYmD6w
	 J13d0XUUUryTtXqWZ7SCnG5vYz0ggH3dt1+NXHD7BPG6dls4PKR8PRiA4FYwhQvDWeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egbc8noq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC19606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egbc8noq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1301F00A06;
	Thu, 12 Nov 2026 04:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457485;
	bh=ke7aOP6V0aZe+jGmwFbUPKc8c2Hnu4gyh3+StXw/fWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=egbc8noqk3f1Qaq2mhmMq9MxTJU9Mo6eobGSGEm8frVfFxEIVBWsSSWKs6PtmE/GO
	 I77Srt/hau1c9sXJAZ49Fa3Yog3DDWJ2irmgHUB/rzsmXesa0CCC3Ql2PPdKhBvwFi
	 +oqfECX1+nyeHSjXI/DmyEQ8rywZQv7XXs9AjubQcX4qE9QnGnObPmA83vzqmZHwe7
	 i0jvLY53ci52KSO+V1ZhU+1mxNHVIvmyILXSp3hmVY0KvX+BY102bu4cpZN0PiW5+y
	 7B9lRcRzFZmjtuv8iWdfTJrGuB0ivsSk3V0sOgg6TLcURmgUZ4m/UQnmUCXjWccSEF
	 YZCo5lqOfixag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: do not read past the DACL in the access denied debug message
Date: Wed, 11 Nov 2026 23:24:44 -0500
Message-ID: <20261112042434.1868190-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200252-failed-6.18-8296a64df544@kernel.org>
References: <20261109200252-failed-6.18-8296a64df544@kernel.org>
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
[ sashal: Adjusted context to preserve the existing permission check with inline implicit permissions because strict mode is absent. ]
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

