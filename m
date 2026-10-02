Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042C40B6E0
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970040; cv=none; b=S6PLwI3lzCRdM1CcvVCux99B5Pi6T84tzHOINxVZ+S5uRsumzRqdxvN+rqHhBpYltzaWDBC61ACys9t+T2Kx17YZTQlbEpF3oKkjlxMdVqr4h0Uw8cDO8kqcV+NTrPhTw+IyFhbLXWZi/MJdClGl+i7+7kSzzoVavEd56rY3AzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970040; c=relaxed/simple;
	bh=82DzLhvJU5FuixkPwwzwEC1hK5czNAOvAAbd7Nh5BDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2MJFSg+tZZXGuVB0rma6LrzKxc4XKycUlv1uVof7Pv3BGJZS79pHM8iN4fais3IrB3up/odLvk0MZyZqqSVFiuE9rCeOIDxIzf3va+baSeX3KIfjn7LrAI02f2udLsmVhvAimfXElLpaIdorZQxiyOW4U2hI2IOgN4FqYH52SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kMeP3hN+; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kMeP3hN+"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so7822153c88.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790970038; x=1791574838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cik4OmGCLcSffV9aIni80ba9p8veycKB8eAV/ioP5eU=;
        b=kMeP3hN+AbxnZMot1hqDzgP0N6AWACtQzCDGtMDbIEJY+7H2+ZA2CrVjOWyx2Aecvh
         ItBgPJqg9HbtCxuN2sdOoduimV0c3hdM+oghYR3y3OxRbBS4RiOBTcwj/Yv4ma6e35VQ
         XuxY7Ur8fc66/LxDtjSPXVksNB7pGZbgxNpE6unNwAbze/CK9izqQViWR0QdKY4wiMk9
         90V3D1jUqM/qqc3v7/V7E9yApdPZWlnK7Dz4CkQw1fPrrLHZebElSLpYZ22aVTNnB0Bk
         pomro4731sS/WCUqmXFSvSyrryierKdqx7Y0L9wyJQCxttObO4BrLEyfjoQL0UTelvFT
         qHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970038; x=1791574838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cik4OmGCLcSffV9aIni80ba9p8veycKB8eAV/ioP5eU=;
        b=ygAsIGF7xM0xsj3Ta2xBQtTT6FprcYh5QF9hjpHWSW1Md19H4SbykIPbtA9oS/7wDw
         FHnEzRnSOHRQIHE4z7bbVVp/L9WyILBGmC06ShNm5xTs4+p6j+mrpIouKcUvXeM9vaQ/
         pAV/XOSzIN7EyXIvEZX/FPSpb6DFsvhYir7ReG1GXMHfd3WRC6JWGeXDqSqgjOF9r47+
         kcj1eAbo3xbO6NpvIXr7xwi4vK2RK78i1jhtpxDJtMHe7DoTGvS/h6bcxP+LoCVQzHbg
         yKBGBibndjhS0nmTETzhIp/wKaHbBkiBj3bLc0zCRODWZH0GGI5jVUM13TZybHsYU9DR
         gaeg==
X-Gm-Message-State: AFuF++nTkTygF7l6mlOKx34woLjMFXrutyX690UCwrEJr6Fe/HwK4EMb
	ll1iv1nzt+3IyAWGzdkmkxF9xcugBdiQeD63XFBhIQzLvVfg63a9J+e4wbVEVa61utlDZQ9Wkhr
	FzU58E+QthA==
X-Gm-Gg: AYBFou2i9KF02DhiDvA7E3O4suNp+Qcs4X2c2JNL10T1/dvq0jVNZ0Qbxj18hk9apKH
	WEsJ/08EMjbJbRhDgaQRvX9wTpRwE906DvL0LZDf147rSVF6//e5Krcp2HOuW9NPsbFOtvWVBJR
	+V5LcQ6Dg1POm1YKrxYT2m2a7St8LQLzilCiyVZWfW+H3BvaCmz3u0vBiPIcmaOW/PURkQHT4/R
	DuiaYGqSX2AyE+SxDjhrlbDC9YgP7edOEiQcD83AdLmjZhO2gy8nAXhRP/wXdOBnCyUKpqboIbs
	lpBmHYK8uuJ6yhmQxqpUiiwkO2n/VS5ZNk9g+gL5lUsCKZZSOEuBJtstIyp6KPJmv7anxigeEyH
	r66oGJpCtv1Oga166qItv7RJusDJ3D6FPfNSkGZFU7wmrUr4MvfvwHdbNd+rlnJE7Svgr6n9j/W
	AxWYjVHZ++iNzktkLwSC0/HOB1/Cs2k8u9simySNTncrwQkbaj3vD9v+7QuIUaqbLDjpcYvDAGi
	zszfA0JZ9TTSTL+cu/eCyFitRPssCswEv2pCIq7rq1YlW3OWybk9Px8a6VnlkYUw4fCQFyMy7Xl
	AFRkfA==
X-Received: by 2002:a05:701b:2096:10b0:143:2719:566e with SMTP id a92af1059eb24-14f5d3b9a1fmr3905150c88.42.1790970037645;
        Fri, 02 Oct 2026 12:40:37 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f47a57592sm7450113c88.17.2026.10.02.12.40.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:40:37 -0700 (PDT)
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
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 6.1.y 2/2] drm/i915/hdcp: Add encoder check in hdcp2_get_capability
Date: Fri,  2 Oct 2026 15:40:27 -0400
Message-ID: <20261002194030.20489-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002194030.20489-1-artem@trailofbits.com>
References: <20261002194030.20489-1-artem@trailofbits.com>
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

[ Backport to 6.1.y: upstream adds the check in the DP shim's
  intel_dp_hdcp2_get_capability(), which does not exist here. This tree
  predates the intel_connector conversion of the shims: its
  intel_dp_hdcp2_capable() takes a digital port, and the
  intel_attached_dig_port() lookup is still done in the common
  intel_hdcp2_capable() helper. Put the same encoder guard there, before
  that lookup, and return false through the bool API when no encoder is
  attached. ]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-3-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm i915 maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-53050. It adds the same encoder check to the
HDCP2.2 capability query, which the debugfs path calls right after the
HDCP1.4 one.

The 6.6.y backport went out as the same 2-patch series and has been
picked up for 6.6.y. The fix is already present in 6.12.y, 6.18.y, and
7.2.y, but not in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-53050
Upstream: d34f4f058edf1235c103ca9c921dc54820d14d40

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 507721c94f2fdd..d31c1f1f0e5074 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -208,11 +208,16 @@ bool intel_hdcp_capable(struct intel_connector *connector)
 /* Is HDCP2.2 capable on Platform and Sink */
 bool intel_hdcp2_capable(struct intel_connector *connector)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
+	struct intel_digital_port *dig_port;
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
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

