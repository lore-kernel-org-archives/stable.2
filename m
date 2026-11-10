Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313194;
	b=HFbpVhHGDUKOjPoEIJMOZXFUBNMKSSYdC+bfJnlVEwKpxXSALri/D44sg6eJ72x+A9+G
	 HlJvN0Nl78oDFbj8t6GQ+ng8PmrD/s6yqUrb81ziLOe+H/SRyA9NMsHgw1r1a96ydiI6f
	 FRjYFB+KN0G8NP9G0LYJQ5jdGQkAgB8bU0PIPVnMdpEILvbPOa21AmFq2hi/NH4C5DPoo
	 /uxBvwRaS3p4HtgDySfBLhMZKGSxslMBIYXMaPrzE+YgnxjsYt/oERCSsjQz/75eV8Qe2
	 grVokVXLJXXBLJxZbTaGALEmEqecXfOQVhDu5B75sF3bSVAvP8bEUTAXdp0+AiSz7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gMtivmaeocc8JXf5jXFKUuZNktWZqer+YH/ElacFTps=;
	b=KPvqmc842S+wkgeuc9YCldZGS/nYGF/RSA4fDf6aw4dgzWQ3t6Jwx78bYEBFjAOfnj9E
	 Q7TrKButqp8q1OrSs51ddQQxsibDTBXPHzFXFwGSxsEa/SjycScDFCBedXZyvvbQ+qEFK
	 rJU1gKh5GgcxEjkNodyv+59egszpXkmhKMWGYHC+mDzzT4C9PN+JOZXkgGA1/YaVFwnMD
	 Si47kXW7FEN+qN7ptxLPm7ZeqJWEC+gv4Z9i8V3CztxvFo1xnOI/ONggiAw/qMiw92/1n
	 48mTggTARJR2qXoPG7kIumgPw+6c0n7h5g5qeT2E4CyU+QMKTUS1CHLBfQaU3oOCm8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDmxrjos;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDmxrjos
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8A21F0089F;
	Tue, 10 Nov 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313194;
	bh=gMtivmaeocc8JXf5jXFKUuZNktWZqer+YH/ElacFTps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KDmxrjoszVUsPj6RbclxVq9K+rodUx1jM2ODJjbyR/r7+WvrsHx19hM0oIZYjODp6
	 Xm3smW7JhLC1qw1aGLa/hgdYw4C23Gd9Ieh8XSPGHJBhJgusB4cVtjRdrwKHWCaYj4
	 fyY5YTJTU9GWUB4DRLHRyVYl+jmsyYXq6EXE+sPV8vPBqqstzs8cYBG7NfZD29KThZ
	 9+9IQIY7q6nbLzjpn02YQh8diNqFiofid9E1gaBzHRWozASLF5NJqgVNXCOyLh/pCy
	 X4dYo9RKsGPkn1QG5osozTSdIlrtrZG+S/c7yMJlO9C8M/TN0WAg1QzVIJWJvluwpA
	 JJaLL3sANX/aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()
Date: Tue, 10 Nov 2026 07:19:52 -0500
Message-ID: <20261110121929.1131175-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060019-failed-5.15-62ee3da38f41@kernel.org>
References: <20261107060019-failed-5.15-62ee3da38f41@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 62ee3da38f41bef83c1cf250f6816a0ee187674b ]

mtd_get_sb() is called with a reference to the MTD device already
taken by the caller.  When sget_dev() fails, the function returns the
error without dropping that reference, so the device is never released
and its refcount never reaches zero.  Every mount attempt on an MTD
device whose superblock cannot be set up leaks a reference.

Restore the put_mtd_device() that the fs_context conversion dropped on
this path.

Fixes: 0f071004109d ("mtd: Provide fs_context-aware mount_mtd() replacement")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ sashal: adjusted context around the existing sget_fc() call instead of sget_dev() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdsuper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 38b6aa849c638..24d6e3540f345 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -63,8 +63,10 @@ static int mtd_get_sb(struct fs_context *fc,
 
 	fc->sget_key = mtd;
 	sb = sget_fc(fc, mtd_test_super, mtd_set_super);
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		put_mtd_device(mtd);
 		return PTR_ERR(sb);
+	}
 
 	if (sb->s_root) {
 		/* new mountpoint for an already mounted superblock */
-- 
2.53.0

