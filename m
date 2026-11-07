Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047480;
	b=mnm+n0WfDaBONHPY2s+rA1lYF1oYeFCd7cUzAU46MVIIHMb2r9lwQP/6TX/BmOCtCC1o
	 R7Am2cImBT/Rb8AHmYO0m56aMaBcbrKVcSVPxqkraGePQbk3YYBmiv8DmR9VTjB/h44/j
	 Zvl4wACKqfCTR92DreySeqYRt/J8Bli29we5FyKUmMSn9H061MeVaCF1OvvX3Kg07M78u
	 ccAJa/a6XswyrW1MXkZ1Rj4oMz5usaZcy4hWbmXThQ83PubxcCmpfL140oEsgQ9EUoJqU
	 nx0Y7scQnpU7VihjnL8YF7/IeBF9lygWVfXpiWKQTMB5Mj9v0NViPrEHWbzSV4TN9+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YKmg1NcHoQGNwKI0Hg+UrpYDALdr36DASXUitGa3E94=;
	b=eqU5I3D03I1k2byq9Dnm3YLQUWy6YUqZ4BLdC/BQOBA716AXaEbqmY/VogEPR4zlWjGU
	 lANh8S4d/kJWe43W8nk2ZS4kn315jKQhhbOvqaoHkh4lx0gVVgXemGRfXQyy3c3AIMQVt
	 D0EGM9ZGlk9IPDFL9wW7T+c6+oRyJb2gnbMkvodJPaOmaIUIuC7BRu7SFJlLYSLnoyfnU
	 /Krg2FE0SQudIIOtbizT6/iEhfn5iBh9An2g6D3K6fGtIMNmy8PHG7KjmKLFZOewCuIpP
	 KvTaui3bLBuHexjQlvllgMQqzhkSNLuzvLRyhyhvASCIMTRAwOajzP9KHtucP0xUnzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0u4ZCGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD7606D824
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0u4ZCGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969111F008A3;
	Sat,  7 Nov 2026 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047480;
	bh=YKmg1NcHoQGNwKI0Hg+UrpYDALdr36DASXUitGa3E94=;
	h=From:To:Cc:Subject:Date;
	b=e0u4ZCGb5D1dK4n43uEbO8JH9AFfIVUvCVC2zU6dp0bSFesg9C/WSRAAfvPVIeoDG
	 TL2RtBHzJ0WkZnIhqw9Ns9Rt3ewm6pisJYxhnB8ZLoWVTPVWwBcXXmVmaP+oC/lHV7
	 UuBl6vpVEvrNn/nRWqK8pjffqMgRBxcgb4BKgvV1AD/iv29UIOqnp4yN4+g4ezAjA0
	 FxXGEIPTV+XcbsrxlOmi8LaORsIsPfIin2YbvHh0vBbq/fQMhXDGwr3E9hAOZpR63+
	 vHUzk6+XrWAo/X6C0/3BzimKFGYnQGklIqZ9KIbLrvYgcwI7aLirwhCPdv5AE8oHvd
	 hxUmTnVoWh4tA==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: sti: delta: use unaligned accessors for MJPEG SOF fields" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:18 -0500
Message-ID: <20261107053118-failed-6.6-fdc5bf02aeae@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fdc5bf02aeaef04e7d13895db9b6eaf8083953f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053118-failed-6.6-fdc5bf02aeae@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




