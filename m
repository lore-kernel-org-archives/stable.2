Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAB64BD79E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651860; cv=none; b=fx6zCElOj/wsPWrGqyHzSr66j8AoC5TMc7vyzotre+NSZ//V5kiHrSlZ64+LWDiUzQ8jFIwrNQP8HZN31JocmfrbK/ZHSrqs8ZqFbfp7ExCQyY/mPVPeGQ7z0g+8O2Sl+HLdjk9hakIfAI2E8gtUjgmahcH9vCJX7+5EOltnOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651860; c=relaxed/simple;
	bh=LHHCtf0dNurf9idze4IY9jf7pEvLps72QXqveJnsnYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyYGhzBPmcrABsHLCKU55wBKyvb8RDyG2y3co5zZ4ewmJsMFH9lf0dfTfzfYZDiQcOtGNWUMNekr1Xlo/uXgWAB4giyocBBYEW6TcMmF2lhwodkRxLrJRorM3GPkQqgERaVMiLl07naGGrVLoU73r8QjDGMSd9qsGRN/NH5qwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CoqhZOxO; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="CoqhZOxO"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so2133465c88.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790651853; x=1791256653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FsP2Z39yDHYgidPq7LJCuoklm/2VErUU9c6HnTD+Pa0=;
        b=CoqhZOxOVl+tRaN0GR4kieFz8maMrHQOSv+rWNdItAU0XQHzbAXDbhHrvVziKyFgj5
         TQhKbP3jlFxWXx1klqBFTk/NQl85a31cdpAX8I+rE0gx7zq5wcsGAoSUqwodqnGMaWNm
         04e9i5jQptuROrTB7c+Xpi+vNJB5v6oSIudldeD2+79dzMkPgSMckoXB3egGysvE7K5d
         0C/F9fjUFqJEcG451ek37PIwrshZuBEbYJV5a9yBBNys/91yEZc7X8Wy1+777o5x3OBQ
         2Dzihp2gxq5S/qqjWwjLsGpXhe5KpiFsCakDkXJqKlRbP2KVpnq2jNOgSoCjsaA2vvz0
         AtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651853; x=1791256653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsP2Z39yDHYgidPq7LJCuoklm/2VErUU9c6HnTD+Pa0=;
        b=ARp5fadOrKuBRoe9ICNXtdgNsvOSshwlsjJgYoXuOAqcgzEvrmH/iaEx5lItLHOcYm
         Vt9LHnMQ/VtRxYCuCIifUZA4RlRDr8tpUxAHaopaavXUwXogPibS/N/UFn0gLRonugys
         CtnCzCj+qxuO/bsbCT8GHcxCNP0imu76qjh/M4V0OmLgS2BvbuWPhTDT5Vylr1kgVugF
         wuEuyX6Xn+Tdf6wTHenXIGMbb1kNQWbg8dtFBuFLTR6cCqqpaMs4Ah670uzXK6TAypBc
         icq/P4fIEI7iT2Tcmld5esTIpUhHyNqMZij0IICw/0wdhkVZWSrdlzwjO0K84OPvFI/A
         pKYA==
X-Gm-Message-State: AFuF++neCqoYaiRmMfLJmEVHZGr9wcseJbJfZ3rA/ztvG8FVulccVBE+
	JqEr8/wzuXRmqQhf6nqB4HRUcvibHiIpted2FFhY7Qg2FzU/z8EwQp+0Fc90ERAfEFUNRmJoLkQ
	+op2CYFk=
X-Gm-Gg: AYBFou2Skweb0izcEt7yiIyuzDrkSOBYx2dPD3/JjC4vTTfGG9nRpn6mwFTFRWFKSVM
	3Mj4kc7cUU8RttGUktOLMKZNn1rl6al03TpR4STyF+JZa9iSMurmJmM9axY7PL1mVnbTaDVwC6g
	SUO1SD7Fsn/7wOhSHJn5WgGujN1zNfTTZ1QJW6yS9eGhA6YcwaJdwwWLUtpEQ3Z+3zFJAonmoL8
	moqGKkgAekGWqEwv5ptxwVUXLAUHb25vVcIcPrJOw/RO54wWbM0SNys7OMtVOIzGIFFe+jVD4Ll
	YFONpTt/HNKTWI4UyZYBHbPaqtvMQXRH1nlyXxfvG4B70THVrDzVIFw7ZJeT5TXxGeXfncyo3gQ
	YNjLuOZr5O2z9mQXLS/kAbPi9v38V2ty1pDVyA1CTi+sPN9pVeL6gL+C+m93y1mZPslFx3IEELO
	/hRMhFYZzTO5mJeO4kbqjg5N3eUktMXwo0sV3GkyvlcedwXMujIEyt9oh6fjXlOc1dk2DoMVUiB
	QhPrk5A57kRbSTuazVFGikoL1WraDpMGnBOJJfZ4aW4Yi6mbAGqgEmAt348su3G5NdtD8kTghv8
	LBSD+w==
X-Received: by 2002:a05:701b:21c7:b0:143:46a6:b01f with SMTP id a92af1059eb24-146cfec8e21mr13180519c88.31.1790651852851;
        Mon, 28 Sep 2026 20:17:32 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm31321186c88.13.2026.09.28.20.17.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 20:17:32 -0700 (PDT)
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
Subject: [PATCH 6.6.y] drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
Date: Mon, 28 Sep 2026 23:17:26 -0400
Message-ID: <20260929031728.88004-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-2-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm i915 maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-53051. It rejects the HDCP capability query
when hotplug or resume left the encoder unset.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The code change is identical to upstream.

Could you please queue it for 6.6.y?

CVE: CVE-2024-53051
Upstream: 31b42af516afa1e184d1a9f9dd4096c54044269a

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index f377c4484e1857..f7987fb90bb1ac 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -142,11 +142,16 @@ int intel_hdcp_read_valid_bksv(struct intel_digital_port *dig_port,
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

