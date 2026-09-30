Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337534F24E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730224; cv=none; b=ObF5DYQQOJkmvKpQ/shvPRcQMmVJpCN5mpTWs8+NCKflnUwod4HqR3lCrpPKpS3Bj5yrvmETzElnKRC1dKioQKXHG7P1apo4/BMzBHp4hZhnGtssO+B9rmW/9PSVZJX3FuMagDjxBYeM4T5S6StzZKN5v3CVz+JiEdNJjj7jX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730224; c=relaxed/simple;
	bh=ZEC2U06TJD4tOdmJMt8cSCAl78bFLKVRDOpBZAVz0aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0EMB5CIq2ElrONJbERMMSZWAk7Dt7uPQmPlpExNcOgV8zuT+/gmsbbQcBJeDp2v6PfTXt253BMJTgHQlMRc4Bi6UzwrtSZFIkSr7FGFI1HELtWSNau/xu9ZRc2VEK59DDaJq1yOwYzmOr3oO1S8l6Xzn4E2F42dZfB9ntySfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=O1t38vVR; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="O1t38vVR"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342773d94a7so2964827eec.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790730220; x=1791335020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFwFCHroA09S10Beb/3mqXg3PAfAFcLcaaVX6WAqpVQ=;
        b=O1t38vVRg/OP7ypsbSwMfLpK/7I2f+wv2aY/mZmjjsOkZgIzIwSB3ybxrv/BxiDoV8
         naq8OjfvuuRb1/jdRUDA2l3jA+OPSnu9oqkXg/fO/uL9hBcIBuevqu+qBxv6V4JgTozS
         eGU+ye2f3Ui7aOxOURuF2hDkw398thLlj6XDs7ExmYX1elpd8QSB/5j7oX/WzXvJtSVJ
         VLup0Xtzmgug6bQTqCNO6T66tEX7KXVmGw79RmXrks9kLwulT2cjb1b9nkAYIoAraLWO
         lfvD1OGzCxcw0ed2VzW0uEt79PhzqVjISP1ioiV2S9qwiUB4I1rYN036Bd/jUXrdf3Te
         GMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730220; x=1791335020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PFwFCHroA09S10Beb/3mqXg3PAfAFcLcaaVX6WAqpVQ=;
        b=ii8/Uwl2MeqaHRfKKqpUIBwDZKZCXOVCUgGJscxnrE68xmyAiTsuaVREeKHch+ZHgO
         8KGnssBHVJiO4JH09b3iofMZlwjHmOfogXyqxR5huxikFhxgYSoajmguYCDne7rAjEfY
         wwHrqjswJ/tvrxvFAopg0xYrepGNv3/SK1UhjOiYPrcco8777Mt1PgVTM+kaRthty+5j
         9+IG8sX325snVXxE4vx5ce01nUIa2GyKaIz2MzSIefCb0r+VuKG1Lhhs6EXTWNCZuhmu
         KavutAJf35cki21EpnaKo6FyU3La9vYvtaWpndSv4HAouqqhwDU/xYSFmTfLDXJ3SziP
         CRPQ==
X-Gm-Message-State: AFuF++n8DdcmpFdrgi05Zysy44+XaQHv6itQbLdCuKkq7P3lbJJAVKBQ
	KdZ4V9JKsoFDQlNH8g5kMqxhPX83fQc5eIB0dNvA380pqwK/jwBOgaL12axHlsAwfd9+ZSb8fsB
	iqeuqaeQ=
X-Gm-Gg: AYBFou3lJScoLYT0+kIXyx23F5d52G9CciV6TI/F9mdX2EgOqK4eqmezry/8IDCysLf
	QNgCr5Q9peGrrYUqTR+MO+lNolXcuk8NCKy1W/MFbvyOIKd5oCU50zF/OT7iFFzDXo5v3iSGqPF
	pOq+t1ozdcD2Hv8+T2sxUq/6rYwrJphFKUgqBzBn0DtxkLDUWM7mwZKVvV4Dn96ReZMBpYrPHSi
	1cDDAEDh2NCgr/5AkpFp7tAb3IRxBHh8aZfoU+iinHOu5BUYWJpPJeBFrQA09LnjkXQ1V7A6X+R
	UObwjDgd8IptCqR+smAPcC3R5HB0tTRYL7Y706azbNnQlwpmaXPt6P717BW0pmJexeTvzc6KYaa
	84HzYCoDcu4nyDzLFXBfBqfDrHR95XIxMcPmJDbASam6ty5VN2Dujtt907+J5TtRvwI1oj/dolt
	dbiU0ZQ9T5+yHQs1Thg71bxCD0r0uXPIBTj73SBOl78RIWDm84VJEm90qkLlgB4C9z6FXFeWvdK
	LPI+ERs/rOoWAITR8TPiWY6ss0w7fCSCB+4O3a1ztb6aKaFwCB9dIpP509ynoMbc1994FA=
X-Received: by 2002:a05:7301:701:b0:341:b570:8d75 with SMTP id 5a478bee46e88-34c6605302dmr1125938eec.14.1790730219815;
        Tue, 29 Sep 2026 18:03:39 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386c2723sm2179993eec.18.2026.09.29.18.03.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 18:03:38 -0700 (PDT)
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
Subject: [PATCH 6.6.y v2 1/2] drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
Date: Tue, 29 Sep 2026 21:03:20 -0400
Message-ID: <20260930010323.93999-2-artem@trailofbits.com>
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

[ Upstream commit 31b42af516afa1e184d1a9f9dd4096c54044269a ]

Sometimes during hotplug scenario or suspend/resume scenario encoder is
not always initialized when intel_hdcp_get_capability add
a check to avoid kernel null pointer dereference.

[ Backport to 6.6.y: this tree uses the older intel_hdcp_capable()
  helper name. Apply the same guard there; the code change is otherwise
  unchanged. ]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-2-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
CVE: CVE-2024-53051
Upstream: 31b42af516afa1e184d1a9f9dd4096c54044269a
Code change unchanged from v1; only the retained backport note was added.
v1: https://lore.kernel.org/r/20260929031728.88004-1-artem@trailofbits.com

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index f377c4484e18..f7987fb90bb1 100644
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
