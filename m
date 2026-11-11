Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422594;
	b=BQpPT3tWUH5ahmjxZ1hsAWqG1+dPy6N4APwbxruBJ5Lz47EM7QpT2c7gUk4g8AzpPBjQ
	 De80wDu7RAp7s39O/CNc2YBEpYBpOEw7qrgOzpF1QFFPNy/cMvOQD+EYuuygCeQt5zRJT
	 xt5KpJc//kGELOpglB+6tBy1I/iRKpdmDktaOl+Ie0BwNV9j29NW4IUaVgko0s8rlvZlF
	 MX/aIGRIfoe1nCPAd+4UnBd0YWZGomssv/7dlqy7dYW6vuVU7RvqdSyirq9BeCZmGb5f5
	 Ub3RA8hwyHPyYhQxZ0EVpvIMV64AHYnI9A43yb5fMymf4Whhs/pJoYd6LhpkXLOyh/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422594;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i5WvGBu9YbPP2PLFvNOki0y/qqWEioLHLW821Ks5DD4=;
	b=u0I9dyESK75tQo7FU4KjdrJRZkv8xS7xhh3HLvx+V1Ha5qC4/uLGw/wqzj++1GNWtRXq
	 GiogGGhWSaOPGK4QRkDST4oy72aa8zUmRKhOKbyni0FjkYhmyD5oXtPUzoIt1gZKO5vP6
	 FOffq2RBwV/pCKiwHS/bvrqlmInhU2ZEMvK8lLQZlxfDzXc5DNdow5/90Omdbgzj9I4Fx
	 jNCT65WvRvfoGf3PdoSb7qjiG88shsacpILnV27wCrzQiA4Wjm4YG2kaUB2um76McHjBd
	 4CXVvuhKswhS23QhzHjRp2FxDYWtawjpzoaUXABfZUUhxJHJ93Nicw9U6zEWpofFZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X+7ebLu/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD9606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+7ebLu/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE3F1F00A06;
	Wed, 11 Nov 2026 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422593;
	bh=i5WvGBu9YbPP2PLFvNOki0y/qqWEioLHLW821Ks5DD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+7ebLu/wdApbXFomIlslnp4f8Ckqe4o69v6R3BAO/AJVCYTgRok3WkTaV05Vmaf8
	 9PQ0FUZzh5YatIvCWYZgLatRBrHxP2S/0+CQIZXS4fBanJzc8oTz+oxTx8Qu3t+IB9
	 VCeelHBLs2Q+heSxmy9yUxw8Xl1qWySs+9CV5P0q5LjidYjNltnoHBJgbNzBBrI2Ca
	 HMjMvTNI1i84mWrvQh3xVrk4lep2Ze0eXgWUkjmJNU4I/JLy1eh6Ad5Xo+fL9+XWGL
	 iVGCdUdJddXB1obyfVFlFP8dQuZLt04CPMJ9fZzkWn9JXQJ4YOhBTP5+hw+FmLdxQc
	 phv3dLQJUo6mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <x-professor@outlook.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: handle out-of-range SG_SET_TIMEOUT values
Date: Wed, 11 Nov 2026 13:43:11 -0500
Message-ID: <20261111184254.3724978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062825-failed-5.10-9a6cb1da4f3b@kernel.org>
References: <20261107062825-failed-5.10-9a6cb1da4f3b@kernel.org>
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

From: Yingjie Wang <x-professor@outlook.com>

[ Upstream commit 9a6cb1da4f3bc4633bf6669faed25a361834b1b9 ]

SG_SET_TIMEOUT accepts a signed int in USER_HZ units. The sg character
device rejects negative values and limits positive values so the converted
timeout fits its destination field. The block SCSI and BSG paths instead
pass the value to clock_t_to_jiffies(), which accepts an unsigned long, and
store the result in an unsigned int.

Negative values are converted into large unsigned timeouts. On 64-bit
systems, large positive values can also exceed UINT_MAX after conversion
and are truncated on assignment. With HZ=1000 and USER_HZ=100, for example,
429496730 clock ticks become 4294967300 jiffies and are stored as 4
jiffies. On 32-bit systems, an overflowing conversion becomes ULONG_MAX,
which is an unsafe relative interval for the block timer comparisons.

Reject negative values with -EIO, matching drivers/scsi/sg.c. Saturate the
converted value at the smaller of the destination field limit and
MAX_JIFFY_OFFSET. This preserves successful ioctl behavior while avoiding
both narrowing wraparound and an unsafe 32-bit timer interval.

The block SCSI behavior predates Git history. BSG has exposed the same
behavior since it was introduced.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 3d6392cfbd7d ("bsg: support for full generic block layer SG v3")
Cc: stable@vger.kernel.org
Reported-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/9321a59c-c560-4742-8b71-5b0ec1f30c2f@acm.org
Signed-off-by: Yingjie Wang <x-professor@outlook.com>
Link: https://patch.msgid.link/20261022025508.294713-1-x-professor@outlook.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: adapted separate SCSI and BSG timeout changes to the shared sg_set_timeout() helper using q->sg_timeout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/scsi_ioctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index c9f009cc04460..1039b0dc81d00 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -5,6 +5,7 @@
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
@@ -62,10 +63,14 @@ static int sg_set_timeout(struct request_queue *q, int __user *p)
 {
 	int timeout, err = get_user(timeout, p);
 
-	if (!err)
-		q->sg_timeout = clock_t_to_jiffies(timeout);
+	if (err)
+		return err;
+	if (timeout < 0)
+		return -EIO;
 
-	return err;
+	q->sg_timeout = min(clock_t_to_jiffies(timeout),
+			    min(UINT_MAX, MAX_JIFFY_OFFSET));
+	return 0;
 }
 
 static int max_sectors_bytes(struct request_queue *q)
-- 
2.53.0

