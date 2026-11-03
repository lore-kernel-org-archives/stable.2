Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688667;
	b=tALsSZxPPcxgDTrU8SZGdgDopn/Z6UMLoC5iYM5NTdB3bwGwyM23lrB9c3/1/XIqrDUP
	 +GAiD06fVENnHPGXunqCvtZ+Jxadslla7nXrgsmYHKkwkR6CF1qJgngGom04i6Z5nF9aI
	 TVqaBYZ/n7tmbAXf73KudqxHP27/+iXgkJs7BNSNeVEALxEbE8CoMeo9HYNjNnbRNh/9k
	 WjTIEpRuhwXVGBXRxZLYHN8ebCkzPhjzublBL3F/PDQ+jwNXWqVUyAFGjTsFjESvwcJnk
	 PupC9ivnWdGqUjJWACYkGJQycGS3giv0aZGbB+isTVV+AHZWPMpnLJrx95jRD0lJxVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688667;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=8M7QRNti8O00A3boEKNVxg+4K/hm6l5RaNq95DuHpfA=;
	b=L3Glpf5ELrgayDxnIq/jIwbqVhqjobpIddbw2vgFnjJp5yZFOKvjDfKWxMkOZiW24s6Q
	 fUsnT5JIaFFplS9H5MhlSqDRYGtGrUAkAgqKmoFN4VBl+tTZKaozW5SoaGxY57fx1UvnS
	 HvLsInbRLp1+Zp5+Ei6qqyl4Fz0ZFL4ZiMq9lqzucZmUYBjlcEr4iGhYfFwB0hmrUoZm1
	 Z7U/+tGa5lLf1tRiRUg0P5dyEAlJJg+DC6J0NhaHr5SNZhTrZNQuukMHNeulBAmaFnOF/
	 c5UxhfQsnc89D6Wv0FiVzK/4aBZ/aUEnttLaHsQtGe3S02Mj4SaVQCpXY5EwKN3adqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A11606A324;
	Tue,  3 Nov 2026 06:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A11606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QZJRhOlqNIg5AA--.252S2;
	Tue, 03 Nov 2026 14:50:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dianders@chromium.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Put the host node if DSI attachment fails
Date: Tue,  3 Nov 2026 06:51:06 +0000
Message-Id: <20261103065106.1063659-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAA3QZJRhOlqNIg5AA--.252S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWfAF1DCFyUAw18WFWktFb_yoWkZrX_Ca
	4rX3s2qrZ8ArsFgFsrAw47A3srt3WqgFZ7G3WUKFZ3J3yavFy7Za4S9Fy5Xr97Crs7Awnr
	Aa1DWF4UXw47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1P
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpWwqKAAAAsU

ti_sn_bridge_parse_dsi_host() takes a reference to the remote DSI host
node. If ti_sn_attach_host() fails, ti_sn_bridge_probe() removes the
bridge but leaves the node reference held. The remove callback is not
called after failed probe, so a deferred probe can leak another reference
on each attempt.

Drop the host node reference in the existing attachment failure path.

Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 48b83df9aed6..f4cf3b4af876 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1465,6 +1465,7 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 
 err_remove_bridge:
 	drm_bridge_remove(&pdata->bridge);
+	of_node_put(pdata->host_node);
 	return ret;
 }
 
-- 
2.34.1

