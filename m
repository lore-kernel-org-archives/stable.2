Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408562;
	b=RVwnCDZcZ95TUWjNvPwBLDkz1Oha2Kw3k4lyQ3ZFXP+Odjbei9YdSjJFmhtKAhWWv4JW
	 IFrvs6oGZKpzVcCsH6CyxQlVLDk5JVEqxrg4cIVPtIMDinSykmSk6/zn9CEDey8ZdRCmp
	 zln2YTvhI1jcfRHJTZBmTMnIbfbfWVHthFC7qAi4+G+eGGVZMmV2K0r4vTMYg87oYhySr
	 YQdEFtTtXId/Tli/epsSHNwQ0E+9Q1KrdC1UEySbeh9sK9Jqq9rI7WZcDmNm5pCsQYqBP
	 B3mQ+JH9JZphVdamFnE8KpgyRzl4/KrHUmacrnZe7b31iyWkbdDtoX1YSTfQj8x0Eog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408562;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V5nqB0BaS6NIRcldSaj2hdtO7Blf9m07O40VbW5C6zo=;
	b=DF7p62YwCS8YI7Q+RnYbRAc341rlWyXpjuaqKmqBaNXHono3Mo4JuAXBkCXXr84XB63h
	 DxWLH6hv/khhrwWvweXcJGg1YR/Se+6gy8S3KkEV+mrMvEAhp+f9ATNnhhmkMZ4s6MRmI
	 PToBIbM9zrOdbNSO+fdHy5jRJptX+sFFMwIS9DfwmqR6RqzVQEczrHDRjtMcorYQMRldE
	 qJk3ghQogUJtKNTPS1+pTv2OkRicS5ePKcJr4iqp0Sue9lbIXq48huyHKKwrB0G4MCDn+
	 Faw7PjeYV+hWNFYFAQDYIRNw8trW87R9Wiax4rC6UUC+PtB1TJt/tTbcUjCIIHPH1Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LE4Xws3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9C606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LE4Xws3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1E61F00A05;
	Wed, 11 Nov 2026 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408562;
	bh=V5nqB0BaS6NIRcldSaj2hdtO7Blf9m07O40VbW5C6zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LE4Xws3eN9+sPzhJf2BcB5v+fa7hhv0msjiqIPAhHKh+7PzliY063ny0sG5KnWRGL
	 YgTmfQNTUYfKMYcvDsc9dJSpMRXj072IuWr0muN+7zsxTW6BqGBMolkxoReYOk0B54
	 uzv7Kfz9pkkhqvdYuQ3TZ1r9uc1c7Yaj2+/65D0IxJ/xabyE03xXE0NvKQbQwbZMpG
	 4Da/dCEoNtHq2u4eP4nZuQC7hFg0OX0DhAFdxlF3hbhWwWMOS4A94Z1vR8fqaJB7xU
	 QqDKyi+N7OeNWwXvk+jzbBM5uEr5RrF05EPGQ3gSBAdjyCLWY55BP2CjZ85wNEnHV1
	 1zsGEnSD0Vsig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: sti: delta: use unaligned accessors for MJPEG SOF fields
Date: Wed, 11 Nov 2026 09:49:20 -0500
Message-ID: <20261111144847.2404657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054356-failed-6.1-fdc5bf02aeae@kernel.org>
References: <20261107054356-failed-6.1-fdc5bf02aeae@kernel.org>
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
[ sashal: Replaced the unaligned header include with its older architecture-provided equivalent. ]
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

