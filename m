Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312911;
	b=l+AVHv4/CP/sohu7tA501+1PTNgBOY0287AhZXDkBG/V/b0el0xm2B3FfemNQ5J4CYeS
	 k0ijQNHM3IWleqUOqHrVfBYcdM/ZMRY0v3SG1SnLJW9NBneiC1MuIMNU0Mww7s+224NC3
	 5BUNWKiDYcp/oOjroYruJYm6PgXzs4F/AePDETW+rTKs9iX2YR3LJ1EPatdWfHyxBrI1B
	 sifIDfRDMn7ow7wVy/7puhcIQv5mfjGLbGMqVvr3qRs4/onLIZFQwHy1LWEaspOV7fw2b
	 tDjHwwKjHfgnZEID7br/1gEN62oLusQbinGKJPSQp1C+NJuLU6eFO04j6Dj0SP4+jTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v7yl1n21ACReAMKJKH/uMluRb+RJeSDOvbh7oCq/RMA=;
	b=Yx69wsC4zPXUrfIKnTEpm474qeBUdY5jfdrYCjsbgoBmIkqCvc8+5puR2nP3is5lMW0f
	 sw6drKmAzSxO9wLwRHc7fjfyf+6RKNXsrniA9jEydcwhzUNBM+11iOm72YeklN2y+0i4N
	 0VzN1CdEdvxD/CIQGnxYcBJS26sHmBTZ3NuO15daJhakDqoosT+Uicy2YdAKNOhNwsje0
	 nvhLLZ0dN/SOjjASGvCpGX/iJ/35jDmWarnpaEPX/Ulw3Tlrdo5ExvNU1H/ZYvVbAZqkn
	 FeqaGAzVHF+QLYYO/qOua+D7+8MQvvCokZXt5SAQNsz5sd5DsE8SQRBSDQnD+NSVU5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yj3In3hS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14420606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yj3In3hS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153001F008A5;
	Tue, 10 Nov 2026 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312910;
	bh=v7yl1n21ACReAMKJKH/uMluRb+RJeSDOvbh7oCq/RMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yj3In3hS6faEhPIx4T5/3MYQVgSgqojfKBP3DZ8BypnbWbf2F2SRQkR/5WM18xf6U
	 AzO0vqtIqcqLBnjXXylWd9ZgoV24508QqYrDJMI7tQ7OI14HydASNYPoOsTMj8gvk9
	 3qq4IRUcbBeTtYQT/PuF74KP2iPgxwW978ZlGKemSTZKkXKXROqv6KMCZYgi/CNaof
	 7oahJFeZPt6ZYh8XrDnqE03uJ87TSiUwGyX8I0f8y3cm1RRozrFng943T5bck2OFfT
	 A8Ob/4r5lG/HJqGuzsQv3JpSoQRoPRwX9hOPcrcf6PkjHQRVCfPqatlXzpKzOO+ywY
	 eFnWTlRnnLnCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()
Date: Tue, 10 Nov 2026 07:15:08 -0500
Message-ID: <20261110121426.970220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054259-failed-6.1-62ee3da38f41@kernel.org>
References: <20261107054259-failed-6.1-62ee3da38f41@kernel.org>
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
[ sashal: Adjusted context to retain sget_fc() with MTD callbacks instead of sget_dev(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdsuper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 5ff001140ef4a..2b1fc3fc5fb25 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -64,8 +64,10 @@ static int mtd_get_sb(struct fs_context *fc,
 
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

