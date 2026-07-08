Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37831F99D;
	Wed,  8 Jul 2026 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550370; cv=pass; b=mBEXux+VNaq8Ukr7uU3b+QZIPxuN/GIPDaTc4zPmtnBioos4tND3Cg0tcc9Lxc0DEiQfTskn/2IkZnHjNo3A0YyWASs7oPHiycx02usYBux1c0a7L/W+HWfd7Yjq0wOI3r49+atoh2faEkgQzxnqlOMVQUzT1jLy0AERuPNaGZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550370; c=relaxed/simple;
	bh=id2LVrgB3XdholmWTTMhQw8tjgBW2MwTGja3f0pHQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joiTKhGFAAQw5WBDpOYMucfMNy8+25f9XAea3FKARJCoNXPPPYgOD+ILFEFFyGVMjztH159c+HT1Fsuw30H//lVJ9oe91Hf3U5zDE3t1b4sFLMHytvtXrWtMzoY6reQRakSa7u5Vgrws+al4S4t6f17bI9yCV7g8sdUJmZ2R8dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=kOdI55fx; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="kOdI55fx"
ARC-Seal: i=1; a=rsa-sha256; t=1783550334; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Xpp7dn8rogtUf3NY3U8CqN6MNf/irzgh1unRn+KuBK1BQ3gzED/U5CgXyQIe/LVWjs1Nh4qeQa7Y678nArcMjVhE2mJbdAgS43S6rddXRxneMgqnJJ11rnkDwaQjum5EjoO8L3TztE3Gq+9wx0RLIjC068oe7jhp5vpT1KMD3Fw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783550334; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KD+78gqKitQWJexdyygyJauU64BB4Fr2VXjIRjjGnW8=; 
	b=f/Diar+WoSKuiW4XrjC4tYE97V8+3g6+PJKbjGvtxjWoqRBCx58Qlne7UKVPn0VGICSUhZUuJKJ4QW7Y+n9X232aATT1ZiPZvdogNrobVnD2FIqdLJhyd9OP5MsiO2tCFH3Qk1u79t9xoqhinHJaYjjGkLz9/A++QtMwID40+bc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783550334;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KD+78gqKitQWJexdyygyJauU64BB4Fr2VXjIRjjGnW8=;
	b=kOdI55fx6lR8T1hz5wNJyOjjXF+3jT5uxsxHzvVjnUR0iLZupf/hfmeYF9dFi5r5
	xC8BMM0JL+XFDqNNbW7ADmei7R65k6H7u5j9fU7hJWNXHLPuNXnyienVeD0MxgL4cUH
	5TcXqHiOge45t+Az5myKv7kZA4qAGma55LPTMIyo=
Received: by mx.zoho.eu with SMTPS id 1783550330792672.1750921891683;
	Thu, 9 Jul 2026 00:38:50 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/vkms: fix vertical stride miscalculation in get_block_step_bytes()
Date: Thu,  9 Jul 2026 00:38:40 +0200
Message-ID: <20260708223840.973-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

get_block_step_bytes() computes the byte distance between two
vertically adjacent pixel blocks for the READ_TOP_TO_BOTTOM and
READ_BOTTOM_TO_TOP directions as:

	pitch * drm_format_info_block_width(fb->format, plane_index)

This is wrong: the vertical distance between two rows of blocks is
the block *pitch*, i.e. pitch multiplied by the block *height*, not
the block width. This is exactly how packed_pixels_offset() computes
it a few lines above in the same file:

	int block_pitch = fb->pitches[plane_index] *
			   drm_format_info_block_height(format, plane_index);

For 1x1-block formats (block_width == block_height == 1) the two
expressions happen to coincide, which is why the bug went unnoticed
for regular formats. Packed sub-byte formats break the assumption:
DRM_FORMAT_R1 has block_width == 8 and block_height == 1, so the
vertical step computed by get_block_step_bytes() is 8x too large.

This over-large step is consumed verbatim by Rx_read_line(), which
advances src_pixels by `step` once per output row without ever
re-validating the result against the framebuffer object bounds
(those bounds were only checked assuming a correct, 1x, step):

	src_pixels += step;

so reading a plane in the vertical direction (READ_TOP_TO_BOTTOM /
READ_BOTTOM_TO_TOP, reached via a plane rotation of 90 or 270
degrees) walks off the end of the source buffer object after very
few rows and over-reads adjacent kernel memory (an
out-of-bounds read, not a write). With DRM_FORMAT_R1 and a
writeback connector attached, this is reachable by a local process
that holds DRM master on a loaded vkms device (composition happens
synchronously in vkms_composer_worker()).

Fix get_block_step_bytes() to use drm_format_info_block_height()
for the vertical directions, which matches packed_pixels_offset()
and restores the invariant that the vertical step is exactly one
row of blocks.

Runtime-verified on a v6.19 KASAN (KASAN_VMALLOC) stand: before
this fix, a writeback commit on a rotated DRM_FORMAT_R1 plane
reliably tripped a KASAN-attributed out-of-bounds-read page fault
in Rx_read_line() during vkms_composer_worker(); with this fix
applied, the identical reproducer completes cleanly with no fault
and no KASAN report.

Fixes: b52fd27356af ("drm/vkms: Introduce pixel_read_direction enum")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/gpu/drm/vkms/vkms_formats.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index dfb8e13cba87..1e3a6af9cea5 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -103,11 +103,11 @@ static int get_block_step_bytes(struct drm_framebuffer *fb, enum pixel_read_dire
 	case READ_RIGHT_TO_LEFT:
 		return -fb->format->char_per_block[plane_index];
 	case READ_TOP_TO_BOTTOM:
-		return (int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
-										   plane_index);
-	case READ_BOTTOM_TO_TOP:
-		return -(int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
+		return (int)fb->pitches[plane_index] * drm_format_info_block_height(fb->format,
 										    plane_index);
+	case READ_BOTTOM_TO_TOP:
+		return -(int)fb->pitches[plane_index] * drm_format_info_block_height(fb->format,
+										     plane_index);
 	}
 
 	return 0;
-- 
2.50.1 (Apple Git-155)

