Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F8361969
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651385; cv=none; b=QkyEokIJRDbdmWiy0j/vEXjx0AArrKnnvnCGVhitOFfJliz8IZH2LLkWfDYQhGVzlOQdLVylsyHaKdc4XUo+WN15QiKsixZ9ThdZs6emSTKySZeU2l6ie5Fygq3HjWvPy+8+BU8bEOnAa2L9hl/e3hgUqh1QErhwQDjq6iEYhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651385; c=relaxed/simple;
	bh=KmIJNsUoesY5atydphD48c8Zsg7xImCdjEbRvBc8dlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBU2WsRWZAZgYMTJ4FmKGb7/rsUM+6eo4nsyVrGwOI5KG1gfDQPpEOZFMIVBs0euGCl4NoQnU+MoO5WyKonkAV0GO/dT+aSrf4Cg7JBrFmAKkF8iE9EK2by3VybjV0YilwYDBbD6x3mEuAmITnpVhGTscbTS7gVrjUp6EuAdmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QLyaUJT6; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="QLyaUJT6"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so5008493eec.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790651380; x=1791256180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ovbpo2QnHvH7arny/3o7azxV9+me2emF/sy5+OVOXY4=;
        b=QLyaUJT6TzcwpTmyg/ztAf2aRAyCd4kmkt/Q/hDXGmpIX2pKtzpguqMUNzImpkV0Aw
         x4kxDApgCHjnqDXnFjekHp/zcUMh+gvNyJAIsrPHh+424Fum+xukyeLuJRVW/yYbCCN7
         V58xRdHNcrr9i/+fXbDfn/DhdlcJ1yVWi/k77VyJnJhhwdeb9ep/WFf0TfoUT/ytk9kL
         cWdr7ZgSqAZRo+TjM5rzV1HSGjE6h1vvj83NdmSKB+heaoVBZMpOGXbzZuPBGW1bi5N5
         axh0Sor9BFvd/TCeYsOqUFPL9KOeVaMwYr92OhJhplaFS5GyHfBVH4B6hpOxFl+10Wlh
         GhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651380; x=1791256180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ovbpo2QnHvH7arny/3o7azxV9+me2emF/sy5+OVOXY4=;
        b=bAPfxTIUYHvVkgUuPLjtnHbns6/6jp/GnLgojhMUa2mhPeTBzpwb0AWXOeDHUZ9dzA
         luldPf2E64kqavv21J9XzOhLflWZZq7s6WtAS3btF1EXecTekQzzgGIh+77PGaJHIXx1
         vOal7mel7M5yfixGIUf4X1p8QtQP1tzgc61bLs3lYAd6Nf7BPQtM+zyx4QLpECqUP0RK
         Yresk/zuc/r9dtCoDNx39vmrgOV31CE8Ia8G2w/Dt/hzeBhPe3sUac7L6AApRFme3wff
         fRwl4AWRnq6np/gLqggMypIoeynV1KKqAZRVVFtzWedAleaaAwTtCCXRjw75k7Dsnc4N
         8IWQ==
X-Gm-Message-State: AFq9FYIi9akZMJdbLV6u+3h+eUIeG+TcXyqctQfSnHLiiRjH5kpnHY0e
	TfLoeDEC/mK4zdkOjfuoPfllDKDu9GTTwdK6S6BTlQC9gznHVUIoaGh1KdOoG0AnwW+rdizPIJ2
	7r3uOaIg=
X-Gm-Gg: AYBFou2FwkGLBAb5BwJAwjr1iR5NqBOKo1ySh5qiMJ8j9rSukI3Ivvr7sVkCvo5TFs0
	RWGwSguM1fpZYi6xH3cYT+wT+gI2KDKo5TJ7HPkcl4+wZYSZQMSm27KPVUQBtL1HMdCfeVn+UGL
	0EbTYPSK47tbY9HSuydodqjZJ2Mwvu0jGiZvfiOLXGB7ZfmippPg6QtuTadzKnm1zuV3vqKew/D
	pozdC37DVnLuUEMiXXoJclj5L6PuBrwOJQQCN9YPnbhnq39G57Lgcn9dynq0nLxECPJ87ByEduL
	01VONh55Pw4SOYsFXOsVLaXfSF2lGk4aPIOm8X/XSBKC4oNjYJKe5lapZ0jauApOotuwvBJpb0c
	bGNwJrho3/5XTnU4txllaiPLUrQkzOlTK079TLuI5birmqg/YqH4rgO8yF2D3fn1eHx5K4FyBsw
	1HNaoFpKksFB/m6eom67EqWOTjKMRF4FVFpJ1y7XS2qo+XHP4rmoyMzgdKH0Pxb4YL32pULIUhI
	6zUAfUNTSRIZEITa6CiTnzwYmS5mEC7TF6dxEFH1pYnxgdwdfNkwZP798N1TA2ERmnweC1dN+UU
	TB4OZQ==
X-Received: by 2002:a05:693c:8955:20b0:341:225b:d6f with SMTP id 5a478bee46e88-34739c07f1emr6241228eec.19.1790651380153;
        Mon, 28 Sep 2026 20:09:40 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34b580fc50asm927881eec.14.2026.09.28.20.09.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 20:09:39 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Allen Pan <allen.pan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Add a dc_state NULL check in dc_state_release
Date: Mon, 28 Sep 2026 23:09:34 -0400
Message-ID: <20260929030936.86941-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allen Pan <allen.pan@amd.com>

[ Upstream commit 334b56cea5d9df5989be6cf1a5898114fa70ad98 ]

[How]
Check wheather state is NULL before releasing it.

[ Backport to 6.6.y: implemented the same guard in older
  dc_release_state() in dc.c rather than dc_state_release() in
  dc_state.c. ]

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-26948. It adds upstream's NULL guard to the
older display-state release helper.

The helper is used by display-state cleanup paths and currently
dereferences its argument unconditionally. The patch makes the helper
NULL-safe.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-26948
Upstream: 334b56cea5d9df5989be6cf1a5898114fa70ad98

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bea18f450ac9c7..6ba67a20eb4846 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2302,7 +2302,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_release_state(struct dc_state *context)
 {
-	kref_put(&context->refcount, dc_state_free);
+	if (context != NULL)
+		kref_put(&context->refcount, dc_state_free);
 }
 
 bool dc_set_generic_gpio_for_stereo(bool enable,
-- 
2.39.5
