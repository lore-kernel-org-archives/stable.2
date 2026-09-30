Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21134E774
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730226; cv=none; b=OfTJcLO1uImnsWAUl13J9mMdiQQIKAhz0pG/ajrCeOwHrZJq11WqiyJWAI5IlGvFk91FBeiTXG3rHSJP0lI8tVVgLqzVzwYg9VDlFU5jXwslRFNkS+4p2Qkz+AeOFt80KNuNxYvZSSZhg9UgTNkR1j9vtbnHFLM6qPFgiNpzdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730226; c=relaxed/simple;
	bh=ouiBEWCppQpfMCPF+WHPpje4212PjHDS9dbw4C/lhfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNl4o86pH8Q4sRJOjQLTmptUK22fI2hpjrcXsufgOHbdin6GX8uCSaixwNAmRYr+2yrN+40m39kwPLPeVNVwbMeuCXCEZYkFa8neWVY8Gds9IJ8jdUxdDXFbUS5lilwqnym4xxzdC57qSfeZ8BZu2nz5tHHW44gKXU71CZL7hrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=OJjYGquR; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="OJjYGquR"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b590a5b5eso1476021eec.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790730222; x=1791335022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqnoWOKNgk3yU/myXUZ7ovtM9FCChQAXvuNXrnvE3KI=;
        b=OJjYGquRzuVurQmpAz6A+uFigznrtN/x8NZ/pvXYq3RmUDthQeS1NqTmbY+Gzs2QLp
         boNunnawwZYM0874MDJQdL7uwlvN2fZwpirnNEOiAaxiCYs2grIjC92IFR3m0Y8j4/Yw
         UAxvxec9rt9BVj2fq5qJUovTRz9t5d1FKHjFFUtwL5W9us2F1QPi8Nu69YRIP1BNHqQs
         bShPtNAMqguWEkUQnJVSbOT51Hzrk9zygF81SpgkOyxWYsb2FlnglCOYy8MuUkSSzQAd
         koMCeOTUgY8VLxeq0qjJV468PLMAxoUu5BB5i6HL1HgMK2FW3E/G48FjNKpfPrjs+QpR
         pkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730222; x=1791335022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqnoWOKNgk3yU/myXUZ7ovtM9FCChQAXvuNXrnvE3KI=;
        b=qjABqktW+zeXmZD47eLAZ1l1UajKxDN2vSLqijEZ3jwiygbb2ZuHem1ZdagouKjpl7
         MGmjIYssFdinoemuI3nRPAkkQXJT8pOpjeSeOnJomGGNrsAmZO39JhOxB4X20sJBCyMi
         VNmZFGRKwS3Bg5oMEfiTkqcOlQSpRDWsHFhtw33RjIfpNDa+jaAAEAhqDH+sBUjB55Xl
         ICHD5cb5fXrZckyLCblu+XlIsk1K9GzjdzBqqrAbnyiMVBePZxM1W6BeRSfIkYekVVA1
         mHvfZJNuZBXBrAur3gwo2+KosSRo4yncIvQvL4bPY7n9QPZFA7XZec378miEodrxqXpz
         N9Nw==
X-Gm-Message-State: AFq9FYKr6U8gYkTyiZfZ6k4Tr2qzTY0b7X3D6ILPRlA+JDpm6nLeUy8M
	WeuDKj0R4ragThGpZgBVuwwiXnYkyS0AHLuDESceCqIjfpUkpp4mbIHQZ8Fbzgq9M9Kz+cd4a+C
	XZ5SpJsk=
X-Gm-Gg: AYBFou3sURDQPaYOtPrjLAZMs8rGf6Lzu2tcoP1xdufwtk/p9uXO194C5Wj07oPuaPS
	wtmlgqq2IcUPOf3DSkXa/r3WGXW/iRupkjDk0axEN0vzO8hH4k4HCghmpZE/JzyT1btqWyFyIs3
	WuQbDh64oTmIr3uOkqkvoc4grnvQwWtpOMZKYipwxqIunS5gk6RHeF3eJTpzqeC+Wso8dfS620u
	IYHA85SRj1V8R6ZJgnKR7wpN7HG+qQWKUkZS7rNtSYA4oqQZ15YpEGJ85iBRBHB8R/P7/qP00Dl
	xvCz99VUH7KacbR54Ms/fd/64Gwv/27UbksytWS/CFygSql24dkflykHZSVgsLYdXf349v2aZqs
	iMePfuVO0i9hf5BAYxQsnGEnTV80k5GMOTubtvG+pTw+8wjF6ktCgmRU+Ur1tTl33GlXghLaF6f
	VnhrC3ZVGzdGsgND9oqxBHrQ2BBiHN56N0vXc1RyMPHYBqgiEOxtPKgkPyVZ4ba6CAEZq6R7irb
	LTOZIz/vJHWGm1VHQVjULkGGr4x3lYqn4suzHLHgZozarVJo+rAbucg2v9K5mNFOB3tXgC/Njwc
	6Ejefg==
X-Received: by 2002:a05:7301:a24:b0:33b:bfb7:31cc with SMTP id 5a478bee46e88-34c66c0725bmr997520eec.16.1790730221429;
        Tue, 29 Sep 2026 18:03:41 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386c2723sm2179993eec.18.2026.09.29.18.03.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 18:03:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y v2 2/2] drm/i915/hdcp: Add encoder check in hdcp2_get_capability
Date: Tue, 29 Sep 2026 21:03:21 -0400
Message-ID: <20260930010323.93999-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930010323.93999-1-artem@trailofbits.com>
References: <20260930010323.93999-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

[ Upstream commit d34f4f058edf1235c103ca9c921dc54820d14d40 ]

Add encoder check in intel_hdcp2_get_capability to avoid
null pointer error.

[ Backport to 6.6.y: this tree predates the later intel_connector
  conversion, so the unsafe intel_attached_dig_port() call is still in
  intel_hdcp2_capable() rather than the DP and HDMI shims.
  Put the same encoder guard before that common dereference and return
  false through the bool API when no encoder is attached. ]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-3-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
CVE: CVE-2024-53050
Upstream: d34f4f058edf1235c103ca9c921dc54820d14d40
Backport: guard the common 6.6.y bool helper because the later DP/HDMI
split is not present in this tree.
Review: https://lore.kernel.org/r/2026-09-29-daily-reply-0012-re-i915-hdcp-encoder-check-v2-6-6@kernel.org

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index f7987fb90bb1..89e378f71d67 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -168,11 +168,16 @@ bool intel_hdcp_capable(struct intel_connector *connector)
 /* Is HDCP2.2 capable on Platform and Sink */
 bool intel_hdcp2_capable(struct intel_connector *connector)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
+	struct intel_digital_port *dig_port;
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_hdcp *hdcp = &connector->hdcp;
 	bool capable = false;
 
+	if (!intel_attached_encoder(connector))
+		return capable;
+
+	dig_port = intel_attached_dig_port(connector);
+
 	/* I915 support for HDCP2.2 */
 	if (!hdcp->hdcp2_supported)
 		return false;
-- 
2.39.5
