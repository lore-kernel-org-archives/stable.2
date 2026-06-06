Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF11D9A5F;
	Sat,  6 Jun 2026 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737476; cv=none; b=V43vjMHDhFSk+IY+NeraI3AhH/GjQovL7/vLQgKeKTujEwBmawH7ccCoD+pudSjW2orE8pEGKq8ZfdMmpsZK8AO/n837yGgtT3n5kvcZgmfcOvCEZ5/GY8swpFq0giAHFZwhaf2bFwFqFe7ojf1fAnvg01dA2hMohEEBZU5ClLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737476; c=relaxed/simple;
	bh=BNiORI5tGyOuEi7m6vWOKCl+0B9ThFr+vkm2eHWrGnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsxtDNvdXwkllqNbCh2prU32tpcdDvBIiluVth+LJbn0iKcO8g0GUVTwdLVrVu0FeyvH35J/MRzQESK3ifqNX3sVDTPiBtwWqnxVFvGyZAzF7mBi+z8rTtLZyAH+r/WukQRAXVbFeRUQ9PM6pC9wavUKKfDBwekfOP9+wUPbf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABnus205SNq3sp+Eg--.15631S2;
	Sat, 06 Jun 2026 17:17:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: pierre-eric.pelloux-prayer@amd.com,
	lijo.lazar@amd.com,
	felix.kuehling@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix refcount leak in detect_link_and_local_sink()
Date: Sat,  6 Jun 2026 09:17:31 +0000
Message-Id: <20260606091731.21183-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnus205SNq3sp+Eg--.15631S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw43Cw4UGw4fZw47uw43trb_yoW8XFy3pr
	W5KryjgrykAF10qa1DAay5uFWUZ3W8tF4Sk3s3Gwn3Aw45ZrsrKF48Zr42gry5Cr98C3Wa
	qFn8KrW3ZF1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUG_M-UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgKA2ojcefVuQAAs+

In detect_link_and_local_sink(), prev_sink is retained via
dc_sink_retain() to keep it alive while probing for a new sink.
When the link type is DisplayPort and the USB-C alt mode
transition times out (i.e. wait_for_entering_dp_alt_mode()
returns false), the function returns false without releasing
the prev_sink reference acquired earlier.  All other error paths
after the retain properly release the reference.

Fix this by calling dc_sink_release(prev_sink) before returning
on the DP alt mode timeout path.

Cc: stable@vger.kernel.org
Fixes: 54618888d1ea ("drm/amd/display: break down dc_link.c")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 794dd6a95918..4473d93b783a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1069,8 +1069,10 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			    link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
 
 				/* if alt mode times out, return false */
-				if (!wait_for_entering_dp_alt_mode(link))
+				if (!wait_for_entering_dp_alt_mode(link)) {
+					dc_sink_release(prev_sink);
 					return false;
+				}
 			}
 
 			if (!detect_dp(link, &sink_caps, reason)) {
-- 
2.34.1

