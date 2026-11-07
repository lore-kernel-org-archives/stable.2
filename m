Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049948;
	b=C2Opj8BgaT0zFzCHHAsrJa0eiF51BwaHBvvYevilga6qKz+dZBvDNlkjkBJs+gdYGSrZ
	 41U7ijf8u6QdZ151L//VYddddVyODlTZZjoDVwR5dGu7EEnte+wrbRMgJk6G8BJYK3i5l
	 djIkrZwpkmh+7BaRzWkylurFXFOohVGJxnTh/p42ciMfck7p2LFs5ZWEFcr+3YeWdEQTR
	 tTCf/kz9y39I8rlVVrD4Xdhn/10r0Av5yQg4ewVMoCxM+cdCPeP6LFRwXt5F4SumBsGZ6
	 Tu/66VN7Ud+klMW6l63sEfU628yQ6cql6p6i1jV59gwLoJlU+x3tSEjYVEeGGI+uKdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Gnl3SX7mnwqMR1ZSzkhYRCcPItvu5bu6bwhKHhHiqLk=;
	b=YyMFN+rMylN1f9jdMOLb/RTa2sjmc9bH+ly6His8tJ7eFst6uu1tH5Lt8r4pBA/15ijS
	 Gv2ZCtXTBO9XTAk4RRUiiPqKWWfiNgK99dmkKdVaDBYc53vyw/nmd/D2NWLJ2uhwt1+xG
	 3rkSN0a1I4tBzuPsh1+r0dhWMr1krPZUoChmS287mM4N/XquQKtw1TYWSWWWozFovBeef
	 Wv8XkhVRLygmAbhJlUi0B6Oa6rnp62Bu68+jz535bACtTvS16jAB2X+bnUbsCuEWemLD9
	 fQmGnHB9pPu8QkxtiOn3Lu0VwXObMZWi5Vs8qop7X3F6Ez6H3lUqJjXsc35uCaovNpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EMQ/rdsi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B0606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMQ/rdsi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE511F0089F;
	Sat,  7 Nov 2026 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049948;
	bh=Gnl3SX7mnwqMR1ZSzkhYRCcPItvu5bu6bwhKHhHiqLk=;
	h=From:To:Cc:Subject:Date;
	b=EMQ/rdsiQqRCHzZaK4rO6EP6r8FEqSyz5yMEN0rKMspDrNrwvy4JcdVrrSKEoiWeb
	 oE09CKECs7vI0rxvYnqWN8V39I7RyGGcWcnQP0+AjFE/UC3GQitf9Q8vR7VSfZSxFn
	 8SKTp9j03x7UD9nZOblL91vMqyVTeEr8qZGsr85SlpK6A+qCHAe8RKgnb7WtbbG4lH
	 ocifUGS+0pv0V6hc68xd+6muy8eRXDIJs1GzOeJ+9yJVLZ5X76I/qx2Rf9I1+GGotr
	 uN2UrtpcM9pKTl5iaPkp2cSEy7KIwckVDpQ34UB3vs1hwW5DRn1B7dK+2Sx9PPKaZf
	 +isaDpVQiia6g==
From: Sasha Levin <sashal@kernel.org>
To: dmnk@google.com,
	bvanassche@acm.org,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:26 -0500
Message-ID: <20261107061226-failed-5.15-87409eedc543@kernel.org>
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
git cherry-pick -x 87409eedc543d288cdd49c2174f7d61eca7b8db5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061226-failed-5.15-87409eedc543@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 87409eedc543d288cdd49c2174f7d61eca7b8db5 Mon Sep 17 00:00:00 2001
From: Dominik Maier <dmnk@google.com>
Date: Sun, 25 Oct 2026 21:07:40 +0100
Subject: [PATCH] loop: check for read-write open mode on LOOP_SET_STATUS in
 lo_compat_ioctl()

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
---
 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index aabaaacdb4fab..a3325ceab484a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1604,8 +1604,10 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = loop_set_status_compat(lo,
-			     (const struct compat_loop_info __user *)arg);
+		err = -EPERM;
+		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
+			err = loop_set_status_compat(lo,
+				(const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,
-- 
2.53.0




