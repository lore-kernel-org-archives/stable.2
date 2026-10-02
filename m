Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D0415F3E
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970039; cv=none; b=WQLEqqqWf2rfvqiTqS+aGZACIPe+sZaXvkk94YdN0LiZVMuNaA95oLcr6zkjlD9gtysY7Ti3XGWZSnSAUlnuhHe/CkCIhWkxNvJeApo3p1cWhusrmB9Lgz8wdw4BNsyTYZNCHMX6KVTO0BU3kx+aek9XEC5OaZwhW7H0l/oAoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970039; c=relaxed/simple;
	bh=sqEsjQJsK/gVrocotISyA6K7tQvW70gwSYwBLKEnthk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGgnRHfJG2g7wXagSRnfzXoGEfbmiDW2lHK6zsY7ZZNSp7pJCNgn8zAyKkOLCImRGaGmFzNUXGAI6Q7eGG0zu8HIKB4XVhwhaqkt5lw9VC02r6YKYAQP5D81fcpQnyG9LkJ0ztWLYggsMsH7oOFoYXxgw3UaAHtSqLzpOsujbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=TkabbgAt; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="TkabbgAt"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1460bcc512eso4951873c88.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790970036; x=1791574836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsIJDrrqVrbyQzUJcQTVkyHK/0UNIS8D9cN3PD9t/4o=;
        b=TkabbgAtPzOjQuRiUP2Ii28CPckYKGFNi82AqoAPtrpd4PyxXXq798K1KDN7QHOlOc
         5pXPdAPhr/PpOrv34lYIt2DCxOl058xiirfc2XjeL8stLt8avzg94AYMeHYDKzJpbzBq
         7xtwuBn2X35PkbunPZFe0OoORQi7aZ0z30hoi2V2hMfM9yLH4D6OjMGlnSAoEhOQCttv
         TbRd1553aGjSkQOu5c7L695teyue6WIBLngOj0KrHw8te57khWxV16bm+kE2rz6E1LUb
         52PnSQafvzZy+g7MrLKrX5mdC5pK1KnPtuAs3Wpo5N0pj6Pg5UM/Dpy6ZnpM7N3Yzx1M
         18mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970036; x=1791574836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gsIJDrrqVrbyQzUJcQTVkyHK/0UNIS8D9cN3PD9t/4o=;
        b=iQqFkNvq6L03FcWYz2+7pru1bUbuP70WaxfeUrZVqxnJwpZo79cKJugQVk5m5FOgEz
         pWiylPsyA09DSmaALTqVYaGQ+JJZD+Y7RDM1qgcEuSsEcwpDIihHkPtOHdFRlNvCglQa
         7s/WD5gKg2mFSWiFf5mB9u1YCWVH0+hEDc8FzzUJJDgKyJ1Hb2awfixpPgvmiz8OBvjd
         aIef8sWzZbALMVocp7ny1OXeK2LCOcezSQGjlCdpXR3R7J5wedRlxo3Xolg4LfBqNPFM
         0H7T71tLU7nmuuEGiUbnK6dXIGt49c5wXwW4iDbHOw2cfBWrCAL6d8GF8eENo87JsOaq
         SLTg==
X-Gm-Message-State: AFuF++nkSy94YcyJ/ZmY51arCzQd1Hw7lJi6b/25+qEEaKZyz0m4WgYy
	HubIZE709cOy6lIHxq2F04Wy1cblivSmlqNB6hA7oQWnXvQuZd9Hr14KCvMw8/9BrotLBtezwSe
	L9i6Oqcsiqg==
X-Gm-Gg: AYBFou3jUFAb98FC3A586jkvjgRgSstX10EfYSKziBt88UccwX86N+dIkassmDFttF6
	n/AMpmIDZPdE8SCcRcBWadrFfCgXbe1gx7kV0UrfaqGU0p6eevTfj+cPDe97dQIAgVvSTT3vYKf
	N5Oh9Z7SxtC5VyFtYi/p+C+csQu58qHk1mPxsdGOz0OLgDB+6Ebsh4k2V/3WrH5V+AerLktVmw0
	Gt7aYZHmlMCYx1ZWRo+yMouzpq0HvN2Erh0aTrj1OTQg3H9ezEAWjZ+y30g3Jrp85dKLhZk3kKV
	f5WxVb71hqNI2VFcbUAnkETSyjj7Om5uZnsPrbtjKPT+aB50M7OaGPDnER8ttIzHt+84NBsO8Xl
	dNkUXRygfQx3wHvs2zQlpkUVrLj0WXIk/HbFqSvkJnlbgoHwBn5GNUCica5SemI8DJn1EQkXPIW
	1ZrMI1Q9rC5iZ31+zsOkRVyBx5IbuSJeqw2K6BUk89CRP+LMvRxXgurcttMT73iaU4dG43kQlov
	L89BA3Pq53kndZ/cJlNE1IE3nr6ycyb8rdlCANKdZ6uncJu63pHSZxNAAGU4fpJVH1pWMg=
X-Received: by 2002:a05:701b:241c:b0:14f:99a2:1715 with SMTP id a92af1059eb24-14f99a217ebmr3412492c88.39.1790970036327;
        Fri, 02 Oct 2026 12:40:36 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f47a57592sm7450113c88.17.2026.10.02.12.40.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:40:35 -0700 (PDT)
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
Subject: [PATCH 6.1.y 1/2] drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
Date: Fri,  2 Oct 2026 15:40:26 -0400
Message-ID: <20261002194030.20489-2-artem@trailofbits.com>
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

[ Upstream commit 31b42af516afa1e184d1a9f9dd4096c54044269a ]

Sometimes during hotplug scenario or suspend/resume scenario encoder is
not always initialized when intel_hdcp_get_capability add
a check to avoid kernel null pointer dereference.

[ Backport to 6.1.y: this tree uses the older intel_hdcp_capable()
  helper name. Apply the same guard there; the code change is otherwise
  unchanged. ]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-2-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm i915 maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-53051. It rejects the HDCP capability query
when hotplug or resume left the encoder unset.

The 6.6.y backport went out as the same 2-patch series and has been
picked up for 6.6.y. The fix is already present in 6.12.y, 6.18.y, and
7.2.y, but not in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-53051
Upstream: 31b42af516afa1e184d1a9f9dd4096c54044269a

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index cb7f86de967a88..507721c94f2fdd 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -182,11 +182,16 @@ int intel_hdcp_read_valid_bksv(struct intel_digital_port *dig_port,
 /* Is HDCP1.4 capable on Platform and Sink */
 bool intel_hdcp_capable(struct intel_connector *connector)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
+	struct intel_digital_port *dig_port;
 	const struct intel_hdcp_shim *shim = connector->hdcp.shim;
 	bool capable = false;
 	u8 bksv[5];
 
+	if (!intel_attached_encoder(connector))
+		return capable;
+
+	dig_port = intel_attached_dig_port(connector);
+
 	if (!shim)
 		return capable;
 
-- 
2.39.5

