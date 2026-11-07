Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050967;
	b=VG3rDesQSQhNPZLlZyZeD0Mf1hf5ucu+PQeK2ZetSCS+5o+qBnIYUP7DOfIizo+JVIRS
	 ZuKVXgwxvrkbRytHtCFcky2lKgJKxjAlvqmVSvHm0D2K87Dlew5Uio5NqkwIj29IDHcr+
	 itQG6aL17WfUOMv/14fHRQw2X83wzxId+FJHBGGGkaaaW1f9p777muYTUL8xDbuaujqyh
	 fM+1iY84iSbiWsLAVeAusRu7tvtboRZavCPinV8eDfaes8mWxRW3eRKG+DlzTRT0xBmsE
	 foiiPm0sUEIUq7RJv66jCH4dEmorv+RbIQ/6KHiw5YABNuevs+5Se7+CjghlatrsS7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=l8qRgV/MlDVVJaXFVAyfQsOg/XbV30BbI8ti6efPkRA=;
	b=mHNpJuD29mALSS43DobQg7J+h7o/uy0LOuEnSyXA5/+fZox1e969Eii3+S8JtDG2S13I
	 u2QVRHvfNCqxuMOgS+RYxEKjXalFn3PUTw4ZfN3KLG1ScLmjvmgT5EwQE2P4EQHYNuQuA
	 YxTo+43LG9qFIp2qA/Td9YZMcIAMgCLajnc8RA2JFXPK6l1khwT149mKGhzSWSm6Hmre3
	 S2PpOJ1tr85Po4dN0g5MXewTW2TmVlOZz+lu50fvWQO/d2zOJNg7lTZyMrUpqNpILtJ5+
	 vxCeMCU7Nvb9xQKOJFi5ZEYPTAn6bSBWvjTiQgVdU50EsgHoAZantF7UzTapTb7p/0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoJUJnAg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C64606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoJUJnAg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D291F0089F;
	Sat,  7 Nov 2026 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050966;
	bh=l8qRgV/MlDVVJaXFVAyfQsOg/XbV30BbI8ti6efPkRA=;
	h=From:To:Cc:Subject:Date;
	b=IoJUJnAgd0gXrMjPKxmdhTMq2kJ3eLW+dw2KOWoK3wL6o66+BHNrVxmbZYzqiZrkT
	 X5ykVNc9wkb7Dnnm0nehpAMUmCyHGEppZCcAxTW0xT2Pi5XvNYSrclApW9ogtg7b1W
	 bs0Ct1Oq03NkTghvK17UOHkcQAjElCtCb0XsjUE97VMTc/bUOmjuqMTx0Nqv2ACbT/
	 wkUG8hQxPcGtnvQqUzRfJGh55TKK61TTKsxCvDQuKQyf0WaEIkT7a3xqQTGEULorXf
	 GVn99WYFAVpc2yAv6ZFSWM/lKbVlv795KQPm08fDlbY63YPJpw0rM1kNXXoc+rFlfd
	 eUWgLeGanJVLA==
From: Sasha Levin <sashal@kernel.org>
To: dmnk@google.com,
	bvanassche@acm.org,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:25 -0500
Message-ID: <20261107062925-failed-5.10-87409eedc543@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 87409eedc543d288cdd49c2174f7d61eca7b8db5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062925-failed-5.10-87409eedc543@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




