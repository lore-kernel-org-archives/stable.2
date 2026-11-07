Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049302;
	b=mtzpuawZtd3LIDV992dZm+B0vkvwacMtpwtRkEVmvhJHoqzUcPLR3VmqQSgFw5Eqcec+
	 Nw6qwAtIcysT1FOfShrs18ddweBZ4Gm1KGASHMQqYb122YnxF6feiBVObVYWGq7zbEfKF
	 YnuzBU89YZGAoljWnEnbmH6vne2MiUeDcfPqhgra2nwPvsFf5anVdRztzOb12cF2tZyji
	 ge7KnlMhE5CfpAghpZfzH2t9NamwX516vP6q5fqPtPVRU8CzhmCnzSMg/wB3PHCOXBFHX
	 ECH9g9ktwmCtDRD4LwxvBhCL5v6myEHSQSBjLPFUtpvqvxia7ZVoCyNVNJ8KDy1JcEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bcPtZ0L3BHwtxEkuL9ceLv59/+Ko5k/5aj2EuyKDgEs=;
	b=Tpvy3k4JriyyAzbg/suy225Nz4Os4fVLihBC4btfxBdj2LVYBI4yhiTy18RrVS1WdRwp
	 Q+bHtzRVsD3dpug+yj15AGM2RZJkK+uH1YNShqctxBJS2hUNOhETjz0HKk7Xrr6GUZ5VF
	 JVl96tSKNwJaJ5nHIFqrVJWiZHRTbTuUk5kuOreiS7S9Rsk4AVNqup5vQNnjCt/+GU4S6
	 eIX3T14902GCyTmeZ1eHGwrA2BvEYTaL3/8FxGHeBwepMFXG6R8SFQOM1FQTtm/9vLZ7o
	 naf9C1C7Ty02I8zBiyYG1Fa4/DDHuthYpybs3bixWdSmPKZrlIUXrJ46T53PyeKtKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ila+ql6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0805606A338
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ila+ql6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C631F0089F;
	Sat,  7 Nov 2026 11:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049301;
	bh=bcPtZ0L3BHwtxEkuL9ceLv59/+Ko5k/5aj2EuyKDgEs=;
	h=From:To:Cc:Subject:Date;
	b=ila+ql6XRpIi5vg4azqEzI30e/CMNDDPyn85JgRllm2BkVrI34Vo/YnEFAQQj9iHx
	 K1id8hSpkcm3uwbU12kJNpKXEhfwpD4tHb49CYQ5rSEsuLYCBMP4d24xKk6k/j4TZg
	 3HYgafh+WxtsqU/sLcEuUCBw+L/kXHSJ+lwQsCilY4i5jdZHnEq1stegnu97t8sUtN
	 tf65+KaHwrwbiFE82Y+B91F4Uhc1UtPedxn2jB2UZRnpg/sDed+HRLmDPbfLdHiWSe
	 ofL03Er9LF/+9c8dXJjmNxBWJknXWXHGlVXY1E2Ey3yPI5g0/UNfP11qVk625uIdnA
	 cU1UU3zjVA4eg==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: sti: delta: use unaligned accessors for MJPEG SOF fields" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:39 -0500
Message-ID: <20261107060139-failed-5.15-fdc5bf02aeae@kernel.org>
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
git cherry-pick -x fdc5bf02aeaef04e7d13895db9b6eaf8083953f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060139-failed-5.15-fdc5bf02aeae@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fdc5bf02aeaef04e7d13895db9b6eaf8083953f9 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 1 Jul 2026 23:06:10 +0800
Subject: [PATCH] media: sti: delta: use unaligned accessors for MJPEG SOF
 fields

delta_mjpeg_read_header() scans a compressed MJPEG access unit byte by
byte and passes the bytes after an SOF marker to delta_mjpeg_read_sof().
The SOF parser then reads 16-bit big-endian fields directly from that
byte stream.

The SOF payload is not an aligned object. The marker scan can find the
payload at any byte position, and the SOF layout also puts frame_height
and frame_width after a one-byte sample_precision field. Those fields
therefore sit at odd offsets within the payload even when the payload
base happens to be 2-byte aligned.

Avoid casting the byte stream to __be16 pointers and use
get_unaligned_be16() for the SOF length, height, and width fields.

This issue was detected by our static analysis tool and confirmed by
manual audit. A focused UBSAN alignment validation of the same typed
load shape reported a misaligned __be16 access in delta_mjpeg_read_sof().

Fixes: 433ff5b4a29b ("[media] st-delta: add mjpeg support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c b/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
index 90e5b2f72c82b..849a5e118aec4 100644
--- a/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
+++ b/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
@@ -4,6 +4,7 @@
  * Author: Hugues Fruchet <hugues.fruchet@st.com> for STMicroelectronics.
  */
 
+#include <linux/unaligned.h>
 #include "delta.h"
 #include "delta-mjpeg.h"
 
@@ -48,13 +49,13 @@ static int delta_mjpeg_read_sof(struct delta_ctx *pctx,
 		goto err_no_more;
 
 	memset(header, 0, sizeof(*header));
-	header->length           = be16_to_cpu(*(__be16 *)(data + offset));
+	header->length           = get_unaligned_be16(data + offset);
 	offset += sizeof(u16);
 	header->sample_precision = *(u8 *)(data + offset);
 	offset += sizeof(u8);
-	header->frame_height     = be16_to_cpu(*(__be16 *)(data + offset));
+	header->frame_height     = get_unaligned_be16(data + offset);
 	offset += sizeof(u16);
-	header->frame_width      = be16_to_cpu(*(__be16 *)(data + offset));
+	header->frame_width      = get_unaligned_be16(data + offset);
 	offset += sizeof(u16);
 	header->nb_of_components = *(u8 *)(data + offset);
 	offset += sizeof(u8);
-- 
2.53.0




