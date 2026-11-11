Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392524;
	b=h9Q/Cd6aumecHTKeGa/Ymobj4sTkYNjy9uf/Tf4BTLUdjnl7huutIJF6rWcfiB4bzOo7
	 dcUmHtkZS/7c14pvyWftcUacEc5NbSLFJu1ZOAKLBvL07fkhUXgNQ/+pw5jCZkPmEFjr8
	 K7wD2w29cGmcdTDQVc0o4nJpPjkAerYzaDkukrx3zPPFvz+ebeIgO8SOXn0KCgU45i8it
	 GmR1d19y0s1pYKtf9OQkSBVxC/hEo5+YGlX9Uk1MxjsDHxpPYjFWPbhU2V4Uqk4FjDRHq
	 /u3eGqGl3PLx76px0v5/PD1kFqztL0A1po+J2pHpEm/mGxjUksxHB/AhU6SIE9FmibA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392524;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=91huyCcTavUDJeVfh0LX1U5W1Qr112tZcjQ5xYiPFgE=;
	b=W2rrBWbeRP8sPHX5dnKdWp/mCOZ/sqz42xljdz8b8aSX6Ot5rQu4QMPl/yoQo7ssba9c
	 BODgSCyC01TKytoTZXrb78lgCMwXn78YSm8OuNHkpx5F4xXM9niIcfbl2AsHg7WIHJg5n
	 XJHKKceUXLatZOFUcYOgTAo3Y4P27NmvahW9eD2gcWUYfcO/k6HiwM3STxN0LkbVLQn7M
	 MSN/EZojOQSGp1OW8OVyLNxGJsCjGWnuOhIDp6NXRGvqbLmtj6vRvlCF1LH7y7LFXdCsX
	 np/sw7+wUkrxPReIIkmeaCIViByZ7P9wfvcnLGcm93nMnRT07MrJmcmavxBFxhQaZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZWh2FAO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D8606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZWh2FAO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671561F00A05;
	Wed, 11 Nov 2026 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392523;
	bh=91huyCcTavUDJeVfh0LX1U5W1Qr112tZcjQ5xYiPFgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iZWh2FAOmMcSPbi7Y8CoQEGHpJveehai5Upr0FmoCVvJy54V6uEYF+rJtcatkGNYQ
	 MgT9/tXDlBKtgxaWAadUX0hqubqE7C8krE9u+PRTRAhU3qLhqYkS0oyljuM1SwKsnv
	 V1cKLYa+V0kieZJYZzbihhG/7Bk+fl0QCgWWK1cl5oiw0IjZH0n+UD3Lkj+bCvkzGS
	 lnwtcDaO0sGjyHIlBkfwku1Rxxh9URMu4yqVFA3zx+J7+A1E4EDXA4F+YBVgb/x3/e
	 artQrnEucoN58TRGBUhH5qfdHqGYm8TT6jKFnE5MA83MwgV75/wKOSwBpkP8GyOsrP
	 36ijbVlldeM6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominik Maier <dmnk@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()
Date: Wed, 11 Nov 2026 05:22:02 -0500
Message-ID: <20261111102145.1563470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055527-failed-6.1-87409eedc543@kernel.org>
References: <20261107055527-failed-6.1-87409eedc543@kernel.org>
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
index 20ecd689c2e63..8d3b016398a48 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1717,8 +1717,10 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
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

