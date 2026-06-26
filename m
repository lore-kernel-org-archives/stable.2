Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD101DB95E;
	Fri, 26 Jun 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477969; cv=none; b=qs5rSbmfBoq21qC9XY/0X2DbgtupTRXuobUUpp3mA0tuZL6HrReBxUDKe4LZwehQS3WvQ29o3RiGGZU8WMeMJV7q+O7qzlsvFzL8waaezGXHprkGZ6UdNT0vPdoBaNXV3zIxzwsaQdcbCAnoW1ZNgdt//Ajw556ezFJ7CvnwKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477969; c=relaxed/simple;
	bh=V8X/kxjp/O8CdmBhh2GGTeC1Urldkgy7NlqSwyg5LX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZzFmJjM0zhK+JPhypoNMS5agaNz+0j2KJl0g+nLYiKsvt9hggNXOn8ipEiUXYTe9FdmYEtJoz/8Y1K3wNtISYdSXVzzr1IUqu5SNfr5zXh5HNUu06pmTeNX4EfrE11qxZfTBSjrqmd85J5cVZQa0asLtd+GSsmBvCHLRTrI/29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAD3bfGFdD5qbstoFQ--.22865S2;
	Fri, 26 Jun 2026 20:45:58 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: siqueira@igalia.com,
	alex.hung@amd.com,
	timur.kristof@gmail.com,
	wenjing.liu@amd.com,
	Relja.Vojvodic@amd.com,
	superm1@kernel.org,
	Derek.Lai@amd.com,
	srinivasan.shanmugam@amd.com,
	clayking@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drm/amd/display: detect_link_and_local_sink: DP alt mode timeout   path leaks prev_sink reference
Date: Fri, 26 Jun 2026 20:45:55 +0800
Message-Id: <20260626124555.36910-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3bfGFdD5qbstoFQ--.22865S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4fWFy3Aw18KF17Cw18Grg_yoW8Gry8pr
	WjgFy8uw1kAF1IqFZrAa1ruF47Za18JF4Skry3Gw1fZwn8Zr4DKFW8uw42g34UCF98C3Wa
	qFn8Kw43ZFWqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRZDGYDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgKA2o+ThJycgAAsF

prev_sink is unconditionally retained via dc_sink_retain at function
  entry, but the DP alt mode timeout path inside SIGNAL_TYPE_DISPLAY_PORT
  returns false without releasing prev_sink. All other return paths in the
  function correctly call dc_sink_release(prev_sink), making this the only
  missing cleanup.

Cc: stable@vger.kernel.org
Fixes: 54618888d1ea ("drm/amd/display: break down dc_link.c")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 794dd6a95918..03bb210ebab8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1069,8 +1069,11 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			    link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
 
 				/* if alt mode times out, return false */
-				if (!wait_for_entering_dp_alt_mode(link))
+				if (!wait_for_entering_dp_alt_mode(link)) {
+					if (prev_sink)
+						dc_sink_release(prev_sink);
 					return false;
+				}
 			}
 
 			if (!detect_dp(link, &sink_caps, reason)) {
-- 
2.39.5 (Apple Git-154)

