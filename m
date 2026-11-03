Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692955;
	b=xwuPxdCu9BayRlXXz1UGLYors6g6SPkclKwK8ktlzaqG+scBQywIyyQOj3o58o3z+qsp
	 Fxz1VA+xbtsq8C/beiOWTGC3S/jsnkkajUoS9WacwyxSj62TJQw6M066oqp/v6X4qiYsC
	 jaGZY1P3mf9qPqPG312qrDC9W5wySyzgzqcWRuY4Vw+RoFMcB7qJI7XVJaNAcCyUEw2BW
	 rAelLgp59Rhfa+X4eDt1If0jA1pHfectEqr7uH8tyi5IbNkj8nfnbswOKFtubn3KelkGK
	 O+eQmNFCn8WGmRq9f4p8PNqzsmXjelZMGKJ+FwSB9u9X/nomn5NkSvdE68yQIsaDj1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692955;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=tqzJqx7u5SCZcQHueTKYFlg7trFiE63QgRoY83jP0gA=;
	b=s0MhfyiELIwXx7kbD01e4mMlrBIQJR9ctMU2/OQoz3U3eJ3lSOznppEXkK+pe8vObJ+X
	 qK3+HFcSTmtJvAZ55XeiKIJ39n3WJV2Yrejni0cK7TAaZoRyy0Alq1LYeWeVuxgtqhVbU
	 fRzYn8OqYGRA1d78+HZp5k96BY6sEhEh0RE17ZdsiLt74kJxm4aaqLsd+Lk9YYkgbton5
	 DhFSe/5O4Ie2Ja/5jC/NUKmzwOewfTrAih6Ro5nugLCxi2GBYixUGz7WQOT5xvwvA756C
	 oWWe5mEP1lDOiEIBcPbiDOghh8M3VZpSRWXrdDqH9oBfXdzj/lvImEDlOCjiVPEq6VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE6606A338;
	Tue,  3 Nov 2026 08:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1EE6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpMUlelqojE6AA--.1416S2;
	Tue, 03 Nov 2026 16:02:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: tursulin@ursulin.net,
	umesh.nerlige.ramappa@intel.com,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/perf: Unpin the context if reading its GuC ID fails
Date: Tue,  3 Nov 2026 08:02:37 +0000
Message-Id: <20261103080237.1126027-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAA3QpMUlelqojE6AA--.1416S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15uF4UWFWrKF1xtF1UZFb_yoW8CrWrpr
	40k3WYyFW7XF1jya9Fya1qvF1aga1fJayxGr1vkwn3Zr43XFn0q3WSyrWFgryvkr40vryY
	vrsxta4xu34jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQAA2rpWfXboAAAsK

oa_get_render_ctx_id() pins the context before obtaining its hardware ID.
With GuC submission, gen12_get_render_context_id() can fail while
allocating or accessing the scratch buffer used to read that ID. The
error is returned without releasing the context pin.

i915_oa_stream_init() immediately returns this error, and its caller
frees the stream without invoking the stream destroy callback. There is
therefore no later opportunity to release the pin.

Unpin and clear pinned_ctx before returning this error. Also clear the
pointer on the existing context-control-offset error path, so failed
initialization consistently leaves no pinned context in the stream.

Fixes: 682aa4373f15 ("drm/i915/perf: Fix OA filtering logic for GuC mode")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/i915_perf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 19b82427aa41..73040da7fd16 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -1541,6 +1541,7 @@ static int oa_get_render_ctx_id(struct i915_perf_stream *stream)
 		ret = set_oa_ctx_ctrl_offset(ce);
 		if (ret) {
 			intel_context_unpin(ce);
+			stream->pinned_ctx = NULL;
 			drm_err(&stream->perf->i915->drm,
 				"Enabling perf query failed for %s\n",
 				stream->engine->name);
@@ -1596,6 +1597,12 @@ static int oa_get_render_ctx_id(struct i915_perf_stream *stream)
 		MISSING_CASE(GRAPHICS_VER(ce->engine->i915));
 	}
 
+	if (ret) {
+		intel_context_unpin(ce);
+		stream->pinned_ctx = NULL;
+		return ret;
+	}
+
 	ce->tag = stream->specific_ctx_id;
 
 	drm_dbg(&stream->perf->i915->drm,
-- 
2.34.1

