Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B53E6DC9
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651665; cv=none; b=ArF1SB+Ra/KqIOJNcJkDMq7+P5wJNTAeUatBN06AxliGUE7hHKGr7Hcc0MQz6O7T3uprm1Tms29dVOF7IROx9Z6de3gjN3zP8/9zEeY/kItdOxeEkp5bP/zVDGlUydOwlupqMAw8llZC1vFA8HKrlnygvDp735zV/Pn3fsdshmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651665; c=relaxed/simple;
	bh=hdFpiNOF8xN757dPJ+Yfq6HUQHHWO1N2bbqB6MalM1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0DkVaPpaIVXWPOknTFYX4DtgYBc5rnritg2lbVlXE2prZ51CXwjcfGCByk6srgLCQgYeTcXlLCHyqyWRiqm/k65JLhK/n8LZTwTJV36CrKoYhCPWU5oQFU2etHz6MtaAi4iVthVmqrvA1K4M3Il1jiI0Wcbl4Rh8ZCw4SAGW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=jiPpwOIB; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="jiPpwOIB"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b590a5b5eso159911eec.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790651659; x=1791256459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XEoH4g84gk9XFCZN7uYIcwGzkc00ec8qVmnXddCOcQw=;
        b=jiPpwOIBlg1FPxW/1lUwd/gp5nJSqgYRg6d44xMYGLIdvA+LPHHkRKPkwACvGwGeAN
         u74eWwFUzRrTbDN7pbFoxO/BRmsXouBnpAuDKy9MvyMZsZjIlSn3XVrIKIV8q8cbJGsE
         S9qWkMXJW9y/KEy+LM+IV4LSoYJ919voRd6Liqdql9pyl4FAYXGdATujS2WNGmtz6w8i
         Ns9llpjNmgmYe0GYFSxJBE3aQ2mvutwqRVmzeoaGajuhyz1zKlaYMqv9AAEF8sqE5inA
         w7n/eZKCISAawaWUbubarUu9xgcUD9kKMgr2ekUCA97ZPzKhOmZRPH9IK1i20Gel6oKl
         hDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651659; x=1791256459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEoH4g84gk9XFCZN7uYIcwGzkc00ec8qVmnXddCOcQw=;
        b=mRpuSSf5/ptPuVmLjpjDpRsnJ4aonLF161k3dEEqbvlANy/eBGyoF5vepFeJM8+7Er
         L4kHPM9x7bXlogyjD58kQWDg60XLORDLElrIT4T1yfZoUhvg4Y3GE2oxWKMfATvlprNd
         RJgxdGpsD0NqXyFPgyO4cs5IPf43qLiekVU2FaAZYTQPy//6oE69FMVS09fOe1cb7Jgx
         2Nazlq/ish2IIdG7E8v2wC5HoC8GLEKPvv3+CZ07rP3CfJqQsyN+r6XcWB4rX7ziua2q
         z3/vcuucdnOjBekfbo/4dJ6MNrw4xNEizgH5qk4K0kMXcCC1QgzfXxJZObdDzaYxASko
         WnqQ==
X-Gm-Message-State: AFuF++kZX37Zytd7/HvzMnDz1zO8gpIkJ2wzGXMzthbs7jkay/hqdC3b
	mNuszWIRPHyfMj6zeZpEKeybvjnO1R9yjt1SvfI6TKI8lODGwWBhTIzno+fgPtkF/WH95ZZzGSM
	jul2in9c=
X-Gm-Gg: AYBFou0vUajivnGIJ9+BbbdnTfjmFWTGCTXYwC2/tlh6iOSw5jzyJPBcMqcVC+7kEnV
	uZuX1jKYb6+qBtPUhkXE8hxXmfQoBr1Fbx1kmV6lCPBIWXXnAPNxd9IIF7Wcx+4uiO3Y5f8ECPs
	3tbsQ7x8T8Oy6hE1dhoJyz7kKoZKBIYtHyfcWKB5A3c+LOOUa9ICkuiHWYCSzAozWhfO9JC4TAf
	YQFZddfWPYmK1Mxq3X3np5Qm8Y2ivb3e0BYT3euuDoeOUrN3B4c+bFXdgQcWHVIQFT8gMsBEWe3
	VGip14HJ50LSsIIFWM+jOVs5vmKs6+t7/Mvc8CAhLOxLirPa8v5MvQD6gmkR5jJF3X0b/DaUlfg
	v4QtgY5zryJYux1FWU+NF29rqCdqorPPukt9KEw6tyQP4Mb93+Y+iKmfUULq/3gi59o5hU5wnpH
	e6y0qMkR0NYFkxMHhM9vxWtQHVzYfgiTQVOUYDROmtLc4U8X6zN/m+8bgVfV/Cmw6HJHFo5mfF3
	A8+h5qAeYiIOPXpkTSZpEJ+JinAD5zSbY9spe9vWpvBy1w4y1fUZaB+HGjw9KmTpZuThtQ=
X-Received: by 2002:a05:701b:42d1:10b0:143:4710:a84e with SMTP id a92af1059eb24-146cec4be1fmr12051694c88.15.1790651659361;
        Mon, 28 Sep 2026 20:14:19 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14a719057e1sm7529563c88.2.2026.09.28.20.14.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 20:14:18 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Check null pointers before using them
Date: Mon, 28 Sep 2026 23:14:14 -0400
Message-ID: <20260929031415.87382-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 1ff12bcd7deaeed25efb5120433c6a45dd5504a8 ]

[WHAT & HOW]
These pointers are null checked previously in the same function,
indicating they might be null as reported by Coverity. As a result,
they need to be checked when used again.

This fixes 3 FORWARD_NULL issue reported by Coverity.

[ Backport to 6.6.y: kept the applicable dm_state and dc_link guards; the
  vulnerable acrtc loop shape is absent. ]

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-49922. It prevents the applicable HDCP path
from dereferencing a NULL dc_link.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-49922
Upstream: 1ff12bcd7deaeed25efb5120433c6a45dd5504a8

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7c72caac7b4d71..702c9f5c3d006e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6630,6 +6630,9 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state)
+		return NULL;
+
 	do {
 		stream = create_stream_for_sink(aconnector, drm_mode,
 						dm_state, old_stream,
@@ -8859,9 +8862,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
 
-			hdcp_update_display(
-				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type, enable_encryption);
+			if (aconnector->dc_link)
+				hdcp_update_display(
+					adev->dm.hdcp_workqueue,
+					aconnector->dc_link->link_index,
+					aconnector,
+					new_con_state->hdcp_content_type,
+					enable_encryption);
 		}
 	}
 
-- 
2.39.5

