Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408458;
	b=HOA/1porqkIiKhHdTC67LjHlUKmNV0vmJAZB0gWSwSsuoOpBz7W1rIeksHl4UJbNTqw4
	 05T/mvjMs3YXAHYE+ELTc9wTOCgmZ/1ybBk5JMT398tPySjfR+/iPSmYDZS2zINfbLQk2
	 UiDgm+7JgJJYeXwJGzr+4mw/ViQFUhpF8x/11cKwCF1XNrKjpZurPpNixoWf34zAGzXdj
	 CXKGFTs3e56wS3cpDqzjKso6ZBmovUqIOAe7hWpxzFEdxidK7nFhwE+UIKhtk6rGFjB6l
	 xRpJ9kEkO0PTs9d2K/Z6i95CvyPOd7KS2zabmKq+nT1Nrrg9Rlg+4M/mpM56yuK6sLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408458;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xt7YBHsRUOO/GbbxIjE4kXFrozFvU3CMPvWj9oEr/tM=;
	b=aifXpEBrmN02RETObK5jp+xxrkKXSmdQXBphM5s0ZKpL6hYtucDJK1N1vR5HGXZqBbOL
	 k9PxnlctJWG3F1AzHKHxZ/Uv8lYEiuTA3B/0edyz/eNoURmuDKx0h3od1LHgP9eyoqLIj
	 SURX900c5dMIs9W2fiBmvvo87M0S9YjFKStwf7BB5JkpDDlwZTJGNRKStBD0d6blIcxCA
	 IOjAnMMLt8/G9eYJ7/YS/pzC+C5jHKL0tjtejISTtc1JcOFK4Jb+1RUbzV6umXUkGwrRx
	 qsvnXrzyFFGn3doxXo22uvSCr/FmAKZBIntXBj8yO2DCkq1NLO4viv5xzE+6BBhd/UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mG8uxaQq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986C606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mG8uxaQq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5051F00A05;
	Wed, 11 Nov 2026 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408457;
	bh=xt7YBHsRUOO/GbbxIjE4kXFrozFvU3CMPvWj9oEr/tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mG8uxaQquQh9rjiKAknG8mY1HdelcyqhoKsPaoMAqVc/E8TWGtRQZwimZFJlPghxB
	 RaO289lYPAg3AenvRaVrpEop+tWR/6aMcatqXYedUteqm7wtIIyQseczXvNf4m5jGq
	 Su0Jiimq2/F5s4sqPPLYHNZKITGrywHCu4NR9QsQ47gIYObMkiCkmYEQUeUlg+F35l
	 aB8VQLKQ5QvJ3P6VEd8ljH5lP0NtJhyWoDDXu05SdkwoM3ki0Q9IJaE98qvuu7Ydab
	 r+8Dp9YejVpM0x7zapOJOZXakHMcfp0et0V/hEF8MqOxhX+N9Fl/xanvZofIfV5GC2
	 IAvTS7Bof6YXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: sti: delta: use unaligned accessors for MJPEG SOF fields
Date: Wed, 11 Nov 2026 09:47:35 -0500
Message-ID: <20261111144544.2395168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053118-failed-6.6-fdc5bf02aeae@kernel.org>
References: <20261107053118-failed-6.6-fdc5bf02aeae@kernel.org>
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
[ sashal: Replaced the unavailable Linux unaligned header with the architecture unaligned header. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c b/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
index 90e5b2f72c82b..6e156cd806bb5 100644
--- a/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
+++ b/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
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

