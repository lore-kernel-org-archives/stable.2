Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050306;
	b=LxdzOxgKKtpKOGEmVm9RsIIGDNUSb1ITA4ClNQmqSvOR1HIzwZ6pryPTvibPrYf7jN4g
	 hO78D7p42mRM/PeVXO71ZoGv3cYWy3HyqFeD78eRREiCi0ez88mOKr0Zcw9F1XMUrlEAt
	 ZrJRoQAXcm0MFRpTIfcxuKWi7wB6OID/hMGRyqalqdzU+/RHjgnidyqC6hc0iWNPGCs3j
	 EI8IPhq4NCmX91gRdm3zFXplwe1W7X48P46SBU8keeZSywPDr8MrWcVaFwnc4Cnj6eDS6
	 kEZs6WQNmkesnW5SgzJ5sqyOIC6GIh771wZzRStD6KjYdIBfB+un8UsPO/jFKn+g87A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050306;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5peJii3adYSuyUI9FCgqRi57wSteKY8XgV9BTCamEpg=;
	b=wvq5g37D8KDAUBy7v+J8xAopjzRp9C1zLu+5WJNrBb5Q24pgjvxffpEB6sDjeWpEVUj9
	 4mFdPKDRWfw04XgV/7ULcL9q1i3r3PrRyo7dA/mIhJfenEa0TBwUeMB/szeGcis7bfHoQ
	 1XHjHmCGXI8t8b66MHbcsw4U+UnhtFZbAn8w+qKtpr0hs93AafiCXuFQjTWE642lZoDix
	 oWK6VVMNsxuaiARuOtLcyRyEEXkbLCdYTt4+4mlPRU1OlR5v/RBt7YCd4mH3pD4L+18xt
	 w7jjEM7JnXRLxFN2Y9Onk5QQSUK0mf94i+K3Zop0pF5/TWKjdGLiqes0U+dP9pE+RbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4l9WJhp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4l9WJhp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABE81F0089F;
	Sat,  7 Nov 2026 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050305;
	bh=5peJii3adYSuyUI9FCgqRi57wSteKY8XgV9BTCamEpg=;
	h=From:To:Cc:Subject:Date;
	b=m4l9WJhpiiJgSNPIUZZvS3I2uZvIBMzuhNAwD+RvKw/5yUQStyjCeK0RuU56XpJ9W
	 6qvaYa9UHNZccN3iTBtIIu+1g2ua+w2xjjoSR1cCHd+Be9MGhf6/bdRsFj4T6CRhOS
	 QyO4nJhCaPJ/BZBEXRMemC4yyeQBl94GQRAal8x9Jrep8s3R0xs8UlqlFeaBirslh3
	 XHz0Uy9ywigIFHCDuQIuZ0PhGpfZLtjaRpnYHyDmr7oTwkacPYaK3dQUqsLPPrgLsg
	 6SFh1SFlLwuwlAGyg5x4O+rWm0UObR0VZ02oJ8sWpK+0zXG1C15i2jxOEACGl/Jo3w
	 2GQuTgKXswSzw==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: sti: delta: use unaligned accessors for MJPEG SOF fields" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:24 -0500
Message-ID: <20261107061823-failed-5.10-fdc5bf02aeae@kernel.org>
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
git cherry-pick -x fdc5bf02aeaef04e7d13895db9b6eaf8083953f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061823-failed-5.10-fdc5bf02aeae@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




