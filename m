Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048238;
	b=Z+/xX+USqTQEDSxs0TWQoCGiJvkug5eXNLfojjhfQPngG6HQU3VCBMSaIOCH9jc0s2cE
	 tFq2ROeINxRINgnoQe/Z/9E4bZAGiV7CF3GYEaVqubw34fx43gyZ1dVtEjtyd+xyzbXx6
	 18r3RHpXLF7GmKLccka7kEqPic26ghW35oGccg6sYqFvQ2x6wxpsBkkxQSSaVyqpk4lP/
	 ZFgJwBfzHbotB/LF82JeHWblR6MccSqbHyyLAWCULxUR5DuEehXX9uSeyzbQYaaa+sNU1
	 JPVrVg9D+RvvCzj9x+5K7hWtHKOzvmTCvbLXe0qHjS76yIfB0wJq+Ak+KGmAbLylQqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P2CIi45GLfkqnPBXZIvQWLGMh9OD1A6Jsq/CLTRZr7I=;
	b=HffYHMDggekAEuDqysrRaA1Hr/N00pl82xQAdVlA7z9tMn3ZyK1qq5EO7N2Uj5RwQMn9
	 EQl4gVzk4F2MxF4DlvS4bfTaB2US2Tg7EbGoCrF2LGS2AgI+mV70+F3X2f3mAo3jcBpOT
	 fJPg90vKLk24HTlWl82o5bL5crqTy8XqD6ynUcuMoHlKTv9ussrap59K5uGzR9+BB/NKW
	 bUSJcZOrZc3E+JaKmXaxrKh2wSDfupiocayMNCVRKvH0GxsNRFv+2DPEradDYmuEkDp7G
	 OgdkqU6GDjifwAfHXXMqEogkrbbzxzO0BgLAtBTyky1+L4ZbXnGUj+dL4WALElXm18Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duxqWdVF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duxqWdVF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B288D1F0089F;
	Sat,  7 Nov 2026 10:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048238;
	bh=P2CIi45GLfkqnPBXZIvQWLGMh9OD1A6Jsq/CLTRZr7I=;
	h=From:To:Cc:Subject:Date;
	b=duxqWdVF2BQw9aHRlVLhZWtHRNcsCSp3vzwCjR4o0O2Y40PM3YKOJsnMQ0NEAOSsO
	 ZaOJY1QqEWuR9GTEuTOlR6RmhvQsQ/eZBlsVG71/bnBezVU4hDt6GoI6HQ0Lm9WX/m
	 IfUYdiCLeVjI8YNPPvZEs/0XVX+hD7P+WQDKgDauVQz3aCgxNNC9GNewtqwiJrUFPt
	 j7KnPVNPQzfmY2qqJp2Pfg+NjzDMqADC1DHzIE3hMZBDD57RRIFA12iqNMGrM7YRrn
	 kQiUMQcse9D5rPgFDRslq42DS1egcRp6u1ESNVCHfLlhxEml7zDHRTPpLKNHwlfhif
	 pFUAF2E8gpx2w==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: sti: delta: use unaligned accessors for MJPEG SOF fields" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:56 -0500
Message-ID: <20261107054356-failed-6.1-fdc5bf02aeae@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fdc5bf02aeaef04e7d13895db9b6eaf8083953f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054356-failed-6.1-fdc5bf02aeae@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




