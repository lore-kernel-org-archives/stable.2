Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674028;
	b=yeTH9hhArGf7oN9EI3aJjnLC0yKsJUwCvTclVz5d5I5gXPwFN+LqwGlYT9NbXY+6GSM+
	 2Dhmj924QjMaCQuQmFeQoqtxx9OtrBfxVXQr0JQTgpbVNrbhuLvAFYflTFbQisd0a1Vom
	 sh5c3IP9HnUp2zRaWjQC6tbF7yZmpheX9tzz1u58wdTt4y7V++YEAej7YZNIox8fKBDNe
	 tbvbDidbOK5Khs6/F9YRbuLIhSsfSndTwBBFbL46/2dMMRqwEJct3xIt63FzPUL9oq74K
	 Qz0r9rtdRftV2T8gLIMoxdyEk6Eq3dWiPpzGgtz8MAl45xTuYhNIis9J586BSUVGOJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674028;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=W2zDL4geR378WvyhEn7GmGt0y2c7M9/zJ3AuickV6Jk=;
	b=5fDaGKwr40IJLkTym9ezT3Yvw/J5Gg3gPeZ6OqYxGRWzOCth2ipUW4XZmtlMBWFDo2p9
	 YshDoCGKdVIls8leixWBxMXCcQopBcEpOHDc17chKFq1Xfrkhhm0JhWZ3o5zDuLU+YjjQ
	 XvsrQ8AoSm4gMokTI40lU/iPBem0Ay2i2j2Rg1A7ezXvfbd/Yh+GxJg9NKkdC70cMhc6b
	 lyyyX0hcAwdyOBW54DZyLZCyUywGzS21dWABz+bEPzCcTgAaACAIf0g3Wp4izKz8+vsH3
	 B7Di8gA0VuTYMFHkb/AqC2Rf9aHMeAkR+iPm0fWqxGTzDpE3h6NoXuseclenIbhndzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="WJYvF/20";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57B606A333;
	Sat, 14 Nov 2026 16:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B57B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=WJYvF/20
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRfp30DSRz5BNS0;
	Sun, 15 Nov 2026 00:33:47 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674027;
	bh=H8JF3rYwEnZ84r8VypXxSWCtK5FCJxOn5Tz5inOK078=;
	h=Date:From:To:Cc:Subject;
	b=WJYvF/2025zfIXyCvBb6FUas+bEPVc6dqq4FHdd+pjlzUUtQGAcZDIq5KAZlNvdcm
	 T/lgUDuiCicbiu4WOpmeJoHHtNOnTI/aja0KXxzwP4No2EbGkGyd/rI/3qlGe3HOFO
	 upV1EQ07PEzWySWQBSS6qcu02/BXs/qrNHgRboBZgrqrTuORZJYRB3EDVg0Hb3b8kr
	 dR1LuYc+LbCAfdejnmFj0YbZLJ4YLtZxI7vrWDLl2JMCJgr7fcQn0cxLVJszoVLolA
	 qsJf1l++mXtKkpUOChVY7iVQVbg/4aOmaHpXMcMlOK1ghJdGCm/9AWMIJwqNoyCfsP
	 scoDSq8poOV/A==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AEGXdkg081495;
	Sun, 15 Nov 2026 00:33:39 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:43 +0800 (CST)
X-Zmail-TransId: 2afc6af88d6721a-251f5
X-Mailer: Zmail v1.0
Message-ID: <20261115003343115xWF0x9AV2qGdi-QiqbwhB@zte.com.cn>
Date: Sun, 15 Nov 2026 00:33:43 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBibG9jazogcmVqZWN0IHVudGVybWluYXRlZCBwYXJ0aXRpb24gbmFtZXMgaW4gYmxrZGV2cGFydHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AEGXdkg081495
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 15 Nov 2026 00:33:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D6B.000/4jRfp30DSRz5BNS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

When a blkdevparts entry contains an opening parenthesis without a
closing parenthesis, strsep() returns the remaining name and sets
partdef to NULL. Checking its return value therefore accepts the
malformed entry, and the subsequent strncmp() calls dereference NULL
while scanning the disk's partitions.

Check the updated cursor instead so that the parser releases the
partially allocated entry and returns -EINVAL for a missing delimiter.

Fixes: bc2e07dfd2c4 ("block: fix and simplify blkdevparts= cmdline parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Testing:
Tested on x86_64 Linux next-20261113 in QEMU/KVM with virtio-blk.
A blkdevparts entry with no closing parenthesis crashes the base kernel
in strncmp() during partition scanning. The fixed kernel rejects it and
boots normally. A well-formed named partition is parsed in both kernels.
Also built with W=1 for m68k and i386.

base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48

 block/partitions/cmdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 4fd52ed154b4e81984cdb7119669846263446623..454a4ce9c9f0ac0b7980f626a6a5fe2d479e4490 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -73,7 +73,7 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
 		partdef++;
 		char *next = strsep(&partdef, ")");
 
-		if (!next) {
+		if (!partdef) {
 			pr_warn("cmdline partition format is invalid.");
 			ret = -EINVAL;
 			goto fail;
-- 
2.43.0
