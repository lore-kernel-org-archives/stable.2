Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272575;
	b=sYJx8eeakmZeOiYzUPbbAMjeiDHy2ato7IQ+FJJ+60FkVCI5bqn9EGRvDWSWy1kJbL6L
	 ffKhzXyN3nMHagD+GDgtVUNIWH/LflMDjocOImrZWfQxX1TNumrGf5a1CL6THpRmmIpzc
	 vKRTKoBm8zh+IgC4gibM8mj9rtgSLGuASzS1I9iwT6e+geE5/LuWq/ICcJ9Crx6Mq/YLe
	 1VszWAtmj2Ml9CXIXae1eM6eE7nXzrdDxhmpDn3GxJtZYIIAU/93bQnlvTliF8omTO0K+
	 WupRn5fnaDs7jP87FlBCL3Ox0MVGMu/v6eiYTwGcxrtZ6p5kG+p8rV7AOr+Yf4UoP/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0/tS1LTPjbI8XMmCsJSJGPc5iBqLz0JSjZP1Ob8gdyQ=;
	b=xe/E4RhhmabrKabt4Is9+CvngD3rIFlrqWOTv5foHV5zBsiv2D5j5ozxsYHYgCE9aJbz
	 RtWzcd+7z6pUAGAawXH99tqv2ln/6jPe0IFerNhor/aKgw97tUKS2hfLBENcuAi8axgyL
	 Knn2JTvbjAeyCRaKamN3mBwbJXM3ihWnSRYBQqIvPYMyp73owG87ulOcV3X1/v/x0QzdZ
	 8cKT5bjPnMMtbi9A1CHXljJj4OoD41TUFFsActwVlZK8Ioe6PMeIStNrFii4hiCpn1FL+
	 hh8Mhgi5BUcyPJKnxasYXwgbAW88uvwwb16tH7Z9SV/mtpioVc25jL13zPVGSE3m4dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWXU7NG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F0606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWXU7NG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205801F0089F;
	Tue, 10 Nov 2026 01:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272574;
	bh=0/tS1LTPjbI8XMmCsJSJGPc5iBqLz0JSjZP1Ob8gdyQ=;
	h=From:To:Cc:Subject:Date;
	b=oWXU7NG5JhDTcOZwKVKCkT+a8yLYPhZci56tyhpLxE/Df44bUglcvloU6xoyWLjSJ
	 22FUEwVAs8VeR85QvqUYf21V7qi3kmibjiokJtpRrRoBXv+cTlHjO9q8YyodNrXapP
	 x1F+in0eAM+a7ODLJ4bMPxIRPuoYyfRLGni1T0rPI9dg1lwugAoYl9fP0H4WtLmNao
	 AQEc2W+yWea+AKZEHPVWA1kHx2jJAvGmpB/ZYQ3LQ4kfQb8GIijnrFoRk/f3jpxvlc
	 twCmrLq9KdQWh/XrfkTY3d4pMgEl9HE+P2rvXtTUG3douhtgdIZmqg7KIce1wtzY0h
	 VJ+mTkomSB1Kg==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: do not read past the DACL in the access denied debug message" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:52 -0500
Message-ID: <20261109200252-failed-6.18-8296a64df544@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8296a64df5448548f410fb246c1d88a93609602b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200252-failed-6.18-8296a64df544@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




