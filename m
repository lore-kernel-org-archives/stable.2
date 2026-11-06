Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960648;
	b=F6jdvA0icBm4NJj3UPPgDwwxeQA0ez46MmBKmLOnfrgLRUyePj0hpL4X6E0XOICTMqx1
	 eDPplhGDP+KazxxxLBPKsYhBrC8+WNYxpNtffkTjxKh1v4ElKsDBkf/ngpKAaPBSDvH2K
	 pFcfsWSDXKBEoEQgX2/fbRM1xMr2wDvJEMkSGUT5EO9QaU3Qrc2muOMsHb+aTnmCOV31R
	 xtHMCEFRDhnhROkz3e3PjGt4ub7eOJaMZ1Y00GzY8Cg9FLvECfJIsRtKpLyIpl6VUVF4v
	 iyp+HwNwdnqu8kyyEvDdLs6bUSYfCK4+8q0U9p6ESVzGZRf0jf3Jsw2CIhBa51gjxRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960648;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9AfE/cfKfBtCctU1Gai/X++88Iu6z+gq2zm4ryifuSg=;
	b=WvZDuW/5p+ykxgooFiGqnTaJK4sQWPHrOjkRDevOrQ9whh4CE8XTymcHcA8fl66Liix8
	 Mosmgh/zXGzhlwvI4w+Rm5W/24i3oK2Q0Qxv/lLwWlF/n3qfkz2bJnZGgvUyYwcvF2CLX
	 KlKCYzkrrcvfgbiT38E01CQjGsuT7r1yyrl8d6LamVB8ZdoPcnNpQn6TM9EBpLU1m+kmB
	 fYY3bAC/xxulBACWomup6+98LnFgIJZMvd8ryU4uvAZ+D5Y77blWyupZFdeoHiWqtaZQN
	 ShuZ22Rh4xSBpmmK8VJI+0L2I1J4IFS/rabad00idQ30bozy8Pr0E5/cDkOKv8UyINQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ugreen.com;
	spf=pass smtp.mailfrom=ugreen.com;
	dkim=pass header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=WK0uuDtx;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5E606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 10:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B5E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=WK0uuDtx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1793960612;
	bh=9AfE/cfKfBtCctU1Gai/X++88Iu6z+gq2zm4ryifuSg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WK0uuDtxaPPzmKOUMwakGUNc990TLe4iy0Ajf8hsFR7OJEVfXWcEM5a3CI0Izd9n7
	 nHKkLKLSzmbcwxsrXYpfzZG8jMXZXzz7ZLzGyagB7t5DG9wNbrLsDj5WES9sq8tsZB
	 GG4X+UgWh07ob3vJHkm/KQM6FqoFbVg2Np8kPDn4=
X-QQ-mid: zesmtpsz3t1793960606t071e06aa
X-QQ-Originating-IP: S3UmKB0bvoMHHcYgWAGxlLQXFmqsu4Zb9qoHPz9nc7A=
Received: from exmail.qq.com ( [183.16.164.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 18:23:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8634473018609808824
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Uma Shankar <uma.shankar@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/dsb: Realign GOSUB only for QW slots 6 and 7
Date: Fri,  6 Nov 2026 18:23:15 +0800
Message-Id: <20261106102315.1361645-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105134658.3724628-1-hanson.wang@ugreen.com>
References: <20261105134658.3724628-1-hanson.wang@ugreen.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MpvVxjO9l39xd6tLpiMIVI1u2Nmd3/JrG0kWbNZAaKMafAJgdk5O34BZ
	b8LlY20ubhQwNuUMI+yJbNXTXCnDYaJyKEV4bsg0/xyjoVrg6ZbqnhLOp0u3m0bsDrhT657
	odl25FSZIPdg7Rtzur0qQAleJL08gtUXd0Cgeef7cW1ewMyVV4ojDV8IfcDRAGEBx5Zt5+s
	fsgiQv+eYlrnB4pYPRJZO94uO94CdDvFKw2m/buImn6+qrstPEa3dCRebIeyOSEQOxCgNxk
	VYdCz9SGvM1P1uaKMgNV8fqoZfS+1Z2abbeq9lyBYSjkl4vnwVR/jo6yfvH69nSe0nSwwZ7
	e+bsj1D4ruuyZGs2+VNQx+4LCgesHK9xLI4/DIZnf+cC4H8kGRGVH0aADkaHgrOX9eDmzwb
	TFAj4lXCZjJwy8yMfDt+87blroD73jgsI71LbQrHaOfAK7aeMvzbLpGzZpV7J6K4J5n0eIh
	6IH5QcSGa/M/35GdPX6rTw2wXJW9PaAsUJMA2z8a2q6B/rkoHuh6NX1hqMj9jKU1vFvsBm1
	eRDwBGBuTGTCGvz5dw9X0PUrdeFeEV3xe8aNBW5PGRmi7o6sfP0rWElMTudTKDdkLWhrKTi
	5d8wZ1S8Rg9rJCKzUaDWzBctr8Al/asIxaKggaL1jv4CquBINKgTiYVDLfH7fs0784pleP9
	sleqcpxZPu3xU4zc0Ja38MTMzSWxHouCdvaBqYPHfysZJhaSHL/Q0kNdCpjMCrCPLGKoWLG
	tf9DIUosiggNCM3sWVT0qO5eZZVtjHbvqIclgsEEWn9LasnvjjvgRSHmYYpjlDgjSrMTkxm
	kywdjBi6F+vxBIncWM/9Xs9FY7PJ3ttbLUVd5WyNm+xzwdTbNfan1E1ksjVQR+MwqC4HRNC
	eISgIp7lT5DXv7SmNKh9Uon8IAPeE4g0QjDa/rsySQG49apeA/zoK/s0dztSR9HybXflqPM
	F9DMcMBHSTd9GEGuLuf96TnBLqZa7MeLEQtJRPmNvYYW6q1rayCmN3sG8JOVdkiDHj0+RP/
	rVoz0DeJj7hzQVJMdoABSEzz2PFNyCjou2JcniFgHSPB7WF8Pp
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

intel_dsb_gosub_align() moves free_pos to the next cacheline
unconditionally, but only clears the skipped bytes when at most two
QW slots remain. Wa_16024917128 forbids GOSUB in slots 6 and 7 only.
A larger gap is still executed. A Panther Lake DSB dump showed
nonzero data in that gap, with the tail at 0x58 and GOSUB at 0x80.

Advance free_pos only when the instruction would land in slot 6 or 7,
and fill that gap with NOPs. Emit GOSUB in place for every other slot.
intel_dsb_align_tail() still clears the rest of the cacheline.

Update free_pos inside the existing gap check in intel_dsb_align_tail()
as well, so the two helpers keep the same shape.

Fixes: 2c41d62f6fb1 ("drm/i915/dsb: Implement intel_dsb_gosub()")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
v2:
- Advance free_pos only for QW slots 6 and 7, and NOP-fill that gap
  (Ville)
- Update free_pos inside the existing check in intel_dsb_align_tail()
  so the two helpers stay in the same shape

Hardware: Intel Core Ultra 5 336H (Panther Lake), 6.18-based kernel
Build:    6.18 backport; both xe and i915 intel_dsb.o
Upstream: not built or booted
Reboots:  7/100 DSB idle timeouts before either fix
          v1 (always align): 0/200
          v2 (this patch):   0/200

 drivers/gpu/drm/i915/display/intel_dsb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index d9a270362a82..07d864039e82 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -589,10 +589,10 @@ static void intel_dsb_align_tail(struct intel_dsb *dsb)
 	tail = dsb->free_pos * 4;
 	aligned_tail = ALIGN(tail, CACHELINE_BYTES);
 
-	if (aligned_tail > tail)
+	if (aligned_tail > tail) {
 		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
-
-	dsb->free_pos = aligned_tail / 4;
+		dsb->free_pos = aligned_tail / 4;
+	}
 }
 
 static void intel_dsb_gosub_align(struct intel_dsb *dsb)
@@ -607,11 +607,15 @@ static void intel_dsb_gosub_align(struct intel_dsb *dsb)
 	/*
 	 * Wa_16024917128
 	 * "Ensure GOSUB is not placed in cacheline QW slot 6 or 7 (numbered 0-7)"
+	 *
+	 * Move to the next cacheline only for those two slots. The skipped
+	 * bytes stay in the programmed range, so fill them with NOPs. Any
+	 * other slot can take the GOSUB directly.
 	 */
-	if (aligned_tail - tail <= 2 * 8)
+	if (aligned_tail - tail <= 2 * 8) {
 		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
-
-	dsb->free_pos = aligned_tail / 4;
+		dsb->free_pos = aligned_tail / 4;
+	}
 }
 
 void intel_dsb_gosub(struct intel_dsb *dsb,
-- 
2.34.1

