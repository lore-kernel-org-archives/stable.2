Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409381;
	b=T+Flz3qoRnSP48FqAf3Wk91qP0Rn4FMOkfPUrQ9Fu3gsx9rQ1MEg0A5ISbC0RkF1NJJu
	 v5Wga/8W0jVfyoiCb9u1VgqnTup6BfG6zbibrz/dSAUt+x8MBBeAOv/eJboEb/m/Ab6mT
	 MTbcQDK9/1Zq3sgYsZZcqCYhVeJk0FcsV0h3lV5d1vUSnq11SxMleqFHE2n3BFBsaicb9
	 AeyG4In0/UsgVWwlkjDeVEQKI7S3nTX9ES9eg+SOxz+JensMNfv5KfZBFVNGnaBRi+mYj
	 RjNSv9fV/TrFiClPGVbbRt71SnSYRZJ3fLWWo9iPtBwti3YgUxBdLfeS2x0z2ryX1dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409381;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bsuxjOlRfr0r7erVtjZZf75c6I+RS5ELnj3UkM1ZF94=;
	b=RComzNemWcAafOaudfdqtSFUpItUqMFjHZkj2+MVp73LLw+Zrt6QXxraHOXhbz+pHnT1
	 W/sLlt2JqflCoTnlXhrvKyeCx/aPHfiMaFuKSXF531CX5+bJ0F4QwHCckYpr8QdTcdLnZ
	 xtZFE05LtenXQQG+Sb+sVzpxfICvGN9NtsOTUsMj4tX2VPrWtC2ioCZ+lQ0X2cKiNAvDz
	 i4dwYOgaMJ5Sc74M2oUQZQHmq4fyQW/r+nZqpoEuuvv3j7qCV8Qiba3cOOxEu3vCxax8o
	 xxzWWiWVgFtmgmUyZvqq/rzFPzawnSItKYeWQUvIGDvoan09TYJLQUL1yhf7cP5LMsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXKhR1Rs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B7606A8A3
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXKhR1Rs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085E11F00A05;
	Wed, 11 Nov 2026 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409381;
	bh=bsuxjOlRfr0r7erVtjZZf75c6I+RS5ELnj3UkM1ZF94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXKhR1Rs/vvQDvpzh7L6OQoDbKD3QukgJM0bKxvcmcHZ1EH/E0FHyu6uYV5HgVKSp
	 wTrRMaj+NTjLqkcuZzZCgiN08MgjcGnYjis8c7R5HJVPl0+b0crB1QP8u6Omoi2ZvG
	 XBEesctw2E5dnsgTPo296ucUfRAP4BpvUuAFlQGlVt9lpE8b9Q7TFLA4EB60TgJ63B
	 KlFtJZkhaz9hcMxSOKxpcQhnGbWQzDei2Grg/5J0BJtyKC20R29W/TYIWMZjAic2u8
	 yTyNLfextbAifOU9/oZTD8ucSy/DD36ck8zZQDfx/UM/xfGrWFgWUmpyxH8dt5/S57
	 jaIvKoqk4sdEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: sti: delta: use unaligned accessors for MJPEG SOF fields
Date: Wed, 11 Nov 2026 10:02:59 -0500
Message-ID: <20261111150237.2481006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060139-failed-5.15-fdc5bf02aeae@kernel.org>
References: <20261107060139-failed-5.15-fdc5bf02aeae@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit fdc5bf02aeaef04e7d13895db9b6eaf8083953f9 ]

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
[ sashal: Changed the unaligned accessor include to the existing architecture header. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sti/delta/delta-mjpeg-hdr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/sti/delta/delta-mjpeg-hdr.c b/drivers/media/platform/sti/delta/delta-mjpeg-hdr.c
index 90e5b2f72c82b..6e156cd806bb5 100644
--- a/drivers/media/platform/sti/delta/delta-mjpeg-hdr.c
+++ b/drivers/media/platform/sti/delta/delta-mjpeg-hdr.c
@@ -4,6 +4,7 @@
  * Author: Hugues Fruchet <hugues.fruchet@st.com> for STMicroelectronics.
  */
 
+#include <asm/unaligned.h>
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

