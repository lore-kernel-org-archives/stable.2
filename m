Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408323;
	b=kGncBU3EJjLMIgb6zESzC20RzAo0isMOOvqiy/tqlpDr9T6Wldy09ADvAbpASbv1HBrS
	 l67IKM2QEXW3D96Vvv+Ndbv9slSWNlYfH5NvvnQzWU0yuQg8dLWy89AtiiBjo/1QdyCE7
	 Dy2DM+gaUmzh4UqjuU6RqINoD8FMhyseDvxJJiNtSvvFTdOsZRBEayLu4Sg93JphlFxYm
	 Hz/4WX5HpQDbpnzuwzkTYYcTHKIO8ktktFqmJ47K0+phI8ivizChGQhkomL1IPMiMhDx1
	 zQG59/NEC/mCweFA6QjJn+i3Sk9rMaOXK/n57pGvV42HDgk5EuLgtgE7eaYWN2cmymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408323;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rTiVOnY8HgSOulFoi0YIAWmyA8fU+hSpntGW97c/Kqs=;
	b=JgsDauhZR7W91y2n/7qqSG3TzQdIzdlvhAH80JQ64Pvk3FN44O7wlPRdCU/5vMyy6u1p
	 x1sUv88QryChSKT61XYPccqk6+qmfbP26hiEFE3y6Pq7Sc6SV6h4Tg4OA03GreZvVClDz
	 hk33br8U1TDhTPRlr/7muGyNw+tGJ8E5grrl3qdoUL9AQxa5CT1iICm55raCwpXDA1NuF
	 uVJ3Fu9TmBnMIHpbiAgOnHmCHlcuF0Ycu7WAQYJf0K2ByWHFqPED1BOxDFD0VHfPcWKWW
	 VDfzWorHgEIpqMrL+Fng50F1Bxi32ID7n12fvpDIR2YmID2G7xoP5aExzRdzmE2/thA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBsh7RbD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C18606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBsh7RbD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F71F00A05;
	Wed, 11 Nov 2026 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408322;
	bh=rTiVOnY8HgSOulFoi0YIAWmyA8fU+hSpntGW97c/Kqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GBsh7RbDQiUBZDZNFkvY/spbc5G7MWICrsoWvwfUd/xu01qIynL1KsNfCq3/ZhCXw
	 rSb3+iNS+KG8LTu0/+ThhIlNexy+8YNQxGvlsjM3D26r1WrAw0hQIeBdeMLc5xNSrw
	 E73ingNdaBEsarpb0qvAeOuCy3umBPqtdS1pw6hmb+U4j98ZpjmsUfzU+7n3WwvTEo
	 noos7J9y/FMOhcfY5bwj8/ELqsGn0ZVDiTpbbK7O90PDaOMN4BAAzOXUlgiki6Fa5I
	 KiRG9b3yQWyUpn9L97mOzLZGkKzuhX7MvxmoA4tx6WnYD6+25HAWTBhi54laufxPg5
	 eQ/wwoZyWnhOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominik Maier <dmnk@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()
Date: Wed, 11 Nov 2026 09:45:20 -0500
Message-ID: <20261111143400.1667764-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062925-failed-5.10-87409eedc543@kernel.org>
References: <20261107062925-failed-5.10-87409eedc543@kernel.org>
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

From: Dominik Maier <dmnk@google.com>

[ Upstream commit 87409eedc543d288cdd49c2174f7d61eca7b8db5 ]

lo_ioctl() checks for (mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN)
before allowing LOOP_SET_STATUS or LOOP_SET_STATUS64, but not
lo_compat_ioctl(), the handler used by 32-bit user space on 64-bit
kernels.

As a result, on 64-bit kernels with CONFIG_COMPAT=y, a 32-bit
unprivileged user-space process holding a read-only (O_RDONLY) file
descriptor to an active /dev/loopN device can issue a compat
LOOP_SET_STATUS ioctl to modify lo_offset, clear lo_sizelimit to 0
(exposing backing-file data past the configured limit), or alter
lo_flags.

Enforce the same (mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN) check
on LOOP_SET_STATUS in lo_compat_ioctl().

Cc: stable@vger.kernel.org
Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
Reviewed-by: Bart Van Assche bvanassche@acm.org
Link: https://patch.msgid.link/20261025200740.2064379-1-dmnk@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ sashal: Replaced BLK_OPEN_WRITE with FMODE_WRITE to match the existing fmode_t interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index dab31049bd4fa..a25467bb1cc74 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1850,8 +1850,10 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = loop_set_status_compat(lo,
-			     (const struct compat_loop_info __user *)arg);
+		err = -EPERM;
+		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
+			err = loop_set_status_compat(lo,
+				(const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,
-- 
2.53.0

