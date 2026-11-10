Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313449;
	b=upyNJRUozEe3Bvf6h5cMR9k8UplDFONfGxClyMtOzcLKWSbDPdRGd0u4v+SKaEdp6G6Q
	 3ASlpe77T2fvbxNJhLZtTynGhq/0jC7IVTRu9zu2/39qniR/QkQ5RwAPvzr4s6tW6i4M/
	 +AEoeyj2s9Z1XupQocyTF0mv2t9gsLGqJV1laotbU+o+cIZT4HVLEOCgX0j4TUB/Up3l9
	 hg49iaI4mhR7otCP3GqvlFfThl5YbLElHIW7sQnWJuoLJPcSAZl0ZP8EmCZPcwyrtZb/i
	 EumkVQ28jdIGH6R3yHZ2OxhQd9EzjP+m6mRX+nr6rfiYVp+3C8EpEnUM6AFiktJ0jIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ueGEe4TwazTSL/ZoC9F9OCnBd7itZvVcFRt4ftVTW7o=;
	b=2TnJAdkteFnKNmfuzVxZckCUOgIxOV6828YFQaXuaqaZ+dO7BNcUueJaMpVSm2bwZ/mR
	 oXAWQl2dyJePuTLxqnyFskU51naMQpJiNnzhzPeSkE4XnYIJW4fhQb28J4d/C+UkzaFPI
	 P6RxgpvnPBhoCCwMng9VHlDoSjR9jbuJ0tqcSHYH9ULy1UEGIdORD57YAS9D/wyNKjXfV
	 dzXBbIwed1KdPuDhO/E9dnHjYXRFVZHYmD8NzgKVhfapIbl511wE0fVJ/S4Ump+05RhH6
	 AK2J+7ORjxj/CBUti6r+WW4S8BWV3wtFrm+eL/uidbOYHcZ5F+aMlmOFqgMIVpPkD7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX6SINxr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC78606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX6SINxr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1551F008A2;
	Tue, 10 Nov 2026 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313449;
	bh=ueGEe4TwazTSL/ZoC9F9OCnBd7itZvVcFRt4ftVTW7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dX6SINxro0XsqBlb3z1JG4UCkxvsQTH5aA5rJWiDcuMsUJ6ZPZ+s7EeNuqquUh2dj
	 6vW7Zp7U58wKA+dk0oQfHEjnHJ6F75q3/MOZeDxdyGnPht8dj1b75+EnNl6+9RsYt7
	 ctV9qvDYLSmwiD97tmZW+bQLIxI9R1cqwMwNCVOR9EhYh9V9A8Akd06+FkyG5Tf9/G
	 nuGagZJEPMJHW7iyKroDoR8HhIFzNyw+vfilXDYUJbP61b5hDMKTfHfmbZnIyyHoyB
	 hyIJP+q/56tcevKbraN0CJZjUZyD/FSvwFGnAD9KqBkBlJK+lMJi5CyoD2UwC7eYay
	 zbzxVBrWfK55g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()
Date: Tue, 10 Nov 2026 07:24:07 -0500
Message-ID: <20261110122346.1177048-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061708-failed-5.10-62ee3da38f41@kernel.org>
References: <20261107061708-failed-5.10-62ee3da38f41@kernel.org>
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
[ sashal: adjusted context for the existing sget_fc() call instead of sget_dev() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdsuper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index c3e2098372f2e..1bc23028f400f 100644
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

