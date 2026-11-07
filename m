Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049081;
	b=ZzHbj/9SajDwpyJPyAmwWWb+UFKfPliuWNP0vhN93RIqg1MC+DFjG9VA571BLBUpWS52
	 yErhu1XqKSZaqaINqF9T1Q6JleKJz2dhDW2UHeI23gDW4r4/BAXasJ9tbCzbdHqVQ9oMJ
	 s6vYxeR/IXi4laGydDOUpUr9iIkT4dqV3CeSbAy7UZzwugUv85asyfxoMlVJZFiUe2LvV
	 +yNpwnJes1JKnOj0poghjpTeiu6bTqFegNkply7K50j1tD9CVu/W633ctelHTHaGNVZRF
	 WQzLMLz/o0IBFkx1cl+QkXm7BS1kisuuSVFUHHeGcU2jivmoFA1sCmTgC2XabXAsN8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=67PxVWbFW+mbDBniDK5CmSf08PxKk40KqK0ypYTsrzA=;
	b=e51lfplAThhBBU+q8uwvUW/ebeadPFAc9F5gDqecKqZHegttrgfk+DpmE0rbAhlVvt9h
	 WnMA5BvBLbqX2Pb/BtQsnLtKN8YJP7ilaa84nzXiJeq2wOxsm+UsCpn+YLe/1xXGEAm+c
	 PjdJDfhSIr1pMQsAZ4LMUPG+LGd4AttAYmC6F/i2vKs4IRjeGjCirGEjAB55CyDctUTXe
	 YE+/BIXSeLkQCIrTE06zExuXlxKW++zjVGr/9sejk5yz577yNCQoGziwWmOlxVzXmX1US
	 IK3LQjHXCx4bWxefFKSJWJwaoRnU4/b/RVhBPKs9WtUNeqQtNhD4NXCsZdFc0K0BqfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIDrc6j+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48412606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIDrc6j+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F28D1F0089F;
	Sat,  7 Nov 2026 10:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049081;
	bh=67PxVWbFW+mbDBniDK5CmSf08PxKk40KqK0ypYTsrzA=;
	h=From:To:Cc:Subject:Date;
	b=LIDrc6j+tKsp2a6QJIDWq4W0hEvq5vy+GZnXlh4L8CSH2ojCn+E7UD8Usm+6YaW3p
	 PitjHWb8FrDccSqjNMja9lEhzAlr3EVrEdRPzc6vqIfjhwr6XdsOCkS6NTvEMUizXo
	 mvCHINaaQQk2MimDvxF4zTmUDjzHK7RMMliPwbILWAXjZ2OaUw5piRGyv5TmzodMhD
	 V74IWeuk2anF9QbSNS2tXuvyYOZ8AO2fNBrWoBkTURs1mC4kqmt6hFbhFOlyHYmao4
	 OrnBWHuphbOyFlgTeSs42gyjI6rWJGokpJezLKdDFyRh/6EFZRuhMV9X9JAz2Z/8IH
	 bXOBYWBZnHOag==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: do not touch WB registers when not streaming" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:59 -0500
Message-ID: <20261107055759-failed-5.15-d8983c47d4d9@kernel.org>
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
git cherry-pick -x d8983c47d4d95eb1ed889dbb7516d3738fa854d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055759-failed-5.15-d8983c47d4d9@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d8983c47d4d95eb1ed889dbb7516d3738fa854d8 Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:02 +0530
Subject: [PATCH] media: microchip-isc: do not touch WB registers when not
 streaming

isc_s_awb_ctrl() called isc_update_awb_ctrls() unconditionally, writing
the white balance registers even when the device is runtime suspended;
on many ARM platforms accessing the unclocked registers is an external
abort. The write was also done without awb_lock, racing isc_awb_work(),
which holds it so the DMA done IRQ cannot latch a half-updated pipeline.

Write the registers only while streaming and not stopping, under
awb_lock, and update the profile there. The isc->stop check covers the
window where isc_stop_streaming() has gated the clocks but vb2 still
reports streaming. Otherwise the new values stay cached and
isc_configure() programs them at the next stream start.

Fixes: 4e52889f48fe ("media: atmel: atmel-isc-base: expose white balance as v4l2 controls")
Cc: stable@vger.kernel.org
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../platform/microchip/microchip-isc-base.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 0f486dd5bd82c..cf4611443fd13 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1511,20 +1511,24 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctrl->cluster[ISC_CTRL_GB_OFF]->is_new)
 			ctrls->offset[ISC_HIS_CFG_MODE_GB] = isc->gb_off_ctrl->val;
 
-		isc_update_awb_ctrls(isc);
-
 		mutex_lock(&isc->awb_mutex);
-		if (vb2_is_streaming(&isc->vb2_vidq)) {
+		if (vb2_is_streaming(&isc->vb2_vidq) && !isc->stop) {
+			unsigned long flags;
+
 			/*
-			 * If we are streaming, we can update profile to
-			 * have the new settings in place.
+			 * awb_lock keeps the DMA done IRQ from latching a
+			 * partially written WB pipeline.
 			 */
+			spin_lock_irqsave(&isc->awb_lock, flags);
+			isc_update_awb_ctrls(isc);
+			spin_unlock_irqrestore(&isc->awb_lock, flags);
+
 			isc_update_profile(isc);
 		} else {
 			/*
-			 * The auto cluster will activate automatically this
-			 * control. This has to be deactivated when not
-			 * streaming.
+			 * Not streaming: keep the cached values for the next
+			 * stream start and deactivate the cluster-activated
+			 * do_white_balance button.
 			 */
 			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
 		}
-- 
2.53.0




