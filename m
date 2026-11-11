Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403052;
	b=ndgdQzL8d10bi6K6ww5szfzv+yJSGAaveJ97ky16T8ZLG6GBmVHh2RmQlCBVvQA5LR/P
	 ximNErCsG1jxvyItH5pSaudwVt/5hBYPkyp4x29xlGGADHsGFTqrt8hwzCs3MBqvL4evl
	 bfhr+El55XUcbgl605lBMYJquJovE6E7H4F0UKbG9og63Wa8JsckhPcZrxZpiB3tQ2XKO
	 sl9T+n4xCU9HEorf0UEFx+SP7FHp9AxCmlzt+T3dKVu9xTY4rJdVNB6ZrKVtx5C9BxDmo
	 6HZ5qhTKcZZY3qYGZOujnFXrwnPu3OxI63oLbEbg6cR8iY3pF3/v9m4vipCXBC0I+gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mDIvEFooe/t5rmVBm5jYTkMldCxFAEAacdty0nyZwuk=;
	b=cqOQ1VAUxZql+9Ihkq0YXFsbb1WVwEWmQI1mfK3vg/HMMao69AMvaqj1qnlgVgDK4gfq
	 QCztPWKbmRksoivVDVEA5PGgx5VAY0sIDZg7AyiLFgBIVUK1rPRrriFCBgNYSSG8V1MuH
	 R+VlA9eI1nD1vBPBml1Yt6+Gjng5c53dDkt9kGIc/KdDSxYg9G5LHsSJJS2hn00dDC0dl
	 FoHMj99ZQxx1YJiwnMAFdERq/djukIA6AMj+GKlGx6Ur72WiHMz76j5HRsmQE3TJPuG3c
	 Wxg/eKOXb6qes1PRlxaVTWa8AerCMZiEKJDXXdhYH/P7/iN22lnkBslP1f4T4KJA2eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y+h5/TqD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C9606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+h5/TqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A531F00A05;
	Wed, 11 Nov 2026 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403052;
	bh=mDIvEFooe/t5rmVBm5jYTkMldCxFAEAacdty0nyZwuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+h5/TqDFJsmal7eGLmgUB6ZjwL3qPTq/mU6eqKD89QafIRYPb7jlUu5/2x1Yp67b
	 sP6ZPWU8igITqK/v7LlD05JO6tcPDE0Pef59vTUpYNq6caetRpb025egx3wDP2bZBG
	 0GuHA5SosfBBf7XO8T5lwh9p7sMAtZlSCVmIbUnwuZeUj1C/TYhr//OY4pAjgXm7qa
	 5Kxs6yIMyXaAEgwxYK0PZgKr0TJREp/4QYtBr/vlqupIwt+y8pfQSjiIESLPjhqzw6
	 NaqLKGdWsuKoWvRPimoUwT9rtD/b+wZzu73Tbewyi0RcIwjbEMT1mRXjLY3ZykP8sb
	 QU/MGd93lhloQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominik Maier <dmnk@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()
Date: Wed, 11 Nov 2026 08:17:30 -0500
Message-ID: <20261111131503.1579531-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061226-failed-5.15-87409eedc543@kernel.org>
References: <20261107061226-failed-5.15-87409eedc543@kernel.org>
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
[ sashal: Replaced BLK_OPEN_WRITE with FMODE_WRITE to match the existing fmode_t API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 45684136e8376..f130024ffd5f5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2020,8 +2020,10 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
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

