Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049047;
	b=BLVHlUbuEgh9ZaE78KhOL6XHyYl7+AdSUbskBqm8MDzoyqffB8c+ak6pHBUzKdVzoBcF
	 Z0hOarha0xpzlbPcrdJFZW7AOmRwN2Qidd/BGTxlsy+9kpHyHPsKNbZah4g2W4KloV4qh
	 S4ke+aitY58f7yvuii++g+amqHtu/C90hvy1fHOWXZEOnjSmzvrmNMtdUvcbW1p6DnOlc
	 n5qi7r9K32hlOiFeyDP9JlkzaJYzC9mwQe8cCGGxLWoR2xU4oC8Jz63tdytIoC/ThWcEW
	 uOVjEVxuKuT/iFC5H2GNlNW+0IQRpeLCpzgwm9XZKGJbg5BZm4jhHvoYBFRd54wvAHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S2LxkjCkxdBFNKaB/QCuatHIhQfYUCdRBlCtQXaTsmk=;
	b=HuusoOcgv2fFQXKvNQz390uMriMCbpR1ky7W7jTzqzXhZtZyfU/creC4WXE/uqJLuLY8
	 ZTYWeRh/Z/oj3a//5xAzntdplOLdLOnr/ZCB1bVlkZh6niY8U4S5iKMLnYW4xaNrAK2gS
	 3ABJGBK+yfl3zdBtWA4sAfc1RA5Nmh52W4gBR94NgbTnzNqEhdWyhZ04ICcxWU/QSIkhs
	 sDqWMfJPeGY3UvgU57IjLgy++DsCQgFVnXPWZ99DKC+ET7Y1zd7NSqoBdrwGlhLQaCIBL
	 oMdOKwVFpC9uGyX0nnj94uMUwvUiLbPNcjgXQKQRqybZj/GmHMefGOy8H39zdgh7wMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8UHVzsv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35208606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8UHVzsv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6520B1F0089F;
	Sat,  7 Nov 2026 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049047;
	bh=S2LxkjCkxdBFNKaB/QCuatHIhQfYUCdRBlCtQXaTsmk=;
	h=From:To:Cc:Subject:Date;
	b=D8UHVzsvRQ3vV/eMMacTszJgaQ6TyymeXCaQGlZSKuxdjZY8eiXD2D7KQF/QvMvlq
	 y/DmVlixLXDiRoGNgRSh3scSvFKoGH4xlo1Q5ZUXjeoU4L1uBFl5qQws1PN48Ia5/C
	 H7+Pv0RKGODQuFd6VwrLd1uuRoID2YFV1/IR8fsoNCNpr2a01kEM5q+x7bQUWTIfHO
	 T2Gq6yhlBioPXIDuk/PQGIUhZCve2/Oqh3r72i9UGM5dndRld6gUUaOg0rmlQd7yYi
	 U0iSaLl2AL51XU0VZLavJzL1Pix4IcGRt5UPTijG1IZOZR5TihVmatbk9yvOKCb4c8
	 ISq/FLsbpqSvA==
From: Sasha Levin <sashal@kernel.org>
To: jack@suse.cz,
	shionthanatos@gmail.com,
	gmwgg05@gmail.com,
	npczmd@qq.com,
	jupmouse@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: Make sure there's enough space for LVID implementation use field" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:25 -0500
Message-ID: <20261107055724-failed-5.15-a61fb39759d7@kernel.org>
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
git cherry-pick -x a61fb39759d719a4f4966742b4d28387e33d81c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055724-failed-5.15-a61fb39759d7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a61fb39759d719a4f4966742b4d28387e33d81c4 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 31 Aug 2026 11:17:14 +0200
Subject: [PATCH] udf: Make sure there's enough space for LVID implementation
 use field

udf_lvid_valid() verifies that the LVID has enough space for all the
tables and the reported length of ImplementationUse field. However it
doesn't make sure the reported length is large enough to contain
logicalVolIntegrityDescImpUse structure which OSTA specification
requires. This can thus lead to accesses beyond the end of LVID buffer
for suitably corrupted UDF filesystem. Add the length check.

Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
Reported-by: Gongming Wang <gmwgg05@gmail.com>
Reported-by: Mingda Zhang <npczmd@qq.com>
Reported-by: Qinrun Dai <jupmouse@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 781d2a9a2fc7 ("udf: Check LVID earlier")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2ba5973ef4dd4..5351755aca3ec 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1617,7 +1617,10 @@ static bool udf_lvid_valid(struct super_block *sb,
 
 	parts = le32_to_cpu(lvid->numOfPartitions);
 	impuselen = le32_to_cpu(lvid->lengthOfImpUse);
-	if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
+	if (sizeof(struct logicalVolIntegrityDescImpUse) > impuselen ||
+	    impuselen >= sb->s_blocksize)
+		return false;
+	if (parts >= sb->s_blocksize ||
 	    sizeof(struct logicalVolIntegrityDesc) + impuselen +
 	    2 * parts * sizeof(u32) > sb->s_blocksize)
 		return false;
-- 
2.53.0




