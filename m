Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB634CFC2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730217; cv=none; b=j+q6Gp0QA3zMfLhvKd4tq1Lk9QqYolXqaZUBK+Foo6+WvuRnohlzI5Jp2RNve0QwVj/k/iE1zGEEeLqpq/ev1iC/iGUjVX29FgGlnVPTSM9YfXIScdiRQEoQeqlMzxfxRoKZfvUgbYseuoDBxa9yfMvGrm2U85GjpGgU8A9ySs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730217; c=relaxed/simple;
	bh=SDpHHWh5CqXcS161Dm4ogLxatxdOjgWnT3fVKEyB58A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Crml0XmbXGcrOlZMuRbThL624Wft7d+2FjeAnHZOcZOZeH36kBTJK0zYG6kyFjMbIEu1/ZhIFP7Mw+uxttrShRo4how7bHZeWO4pq/EC3Mbn0sWre/ghR5LKvLg5btLYopOZYnAfvXm7UNI2nW3yL6pMnc9Adc2Y3hKd3MpoKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HY1wDJ7V; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HY1wDJ7V"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so2733171eec.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790730214; x=1791335014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k02DnUfueq2SXs3UXLyiifb3Iga2OW/KGZeFQEVs3F0=;
        b=HY1wDJ7VyRMmDpE94RaT3VKiDNIzYjyFr23nUYE8S96j6xFQPWuROP6t9dspKJTFxf
         /WdeI2B7fHQIozbeFG3j0llSaLyu2DnlUDXsERbI5+B4I8ObOcmrI7bYJyk8xh2vzn/F
         la6dHTeXLM3u9v2QDOH3V0dep8fPrvZlVVIz1gKUbnEXzsKwk6l09QppxlLDXO4y53sM
         BdtOVXdn0hhKqFb9S0i2ggaNcibxz8pgOjuVu72olouuKyte8oi3FGlVWP05xPpJ1Q+/
         jadtER7Vaw1E3HsxHKDDsmRiTiijsY0VRZjL8oTemEPYgicSGOVyhMEjS6ZBOVnwXms1
         CJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730214; x=1791335014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k02DnUfueq2SXs3UXLyiifb3Iga2OW/KGZeFQEVs3F0=;
        b=0XGfJwHIqbIJvxvJx2X1hmnyewDALFlZ3qIbVDwvXbNV0YGBQFUpLCvUZ0v0PAUHav
         ngZiiZtvYZcn9xdi7+shsS/3/HNyMIi1thbvdH4N8757BFHXRehLuKgt+I2snxxqwHi3
         sA6UBdl+m1UvlwJxCn+mFDqR1PZ5Ya0J1630VGAaFyYyFAI/0MkMmJVPM1mIcFGrRUv7
         /5/8gj/QEg1M19mTb/qmTCUZKeU0cgEGnHtJdxFfbtLJ0MxUpR55ThBDVj0X2aSgs6RA
         5oujN2/7sLVpCEhlJ79UGXI2tdALf44yN3i+8IVugzSL0Kp9NxCZjnuzn2Sw/LNkYwlv
         qs5Q==
X-Gm-Message-State: AFuF++niwkBbiQRwcAR58SelZKq/CBnRBzYHKKrzQA+/TyPpPjRPdNbH
	cMyvajW9yfTAUErODMRzyYv3M73gCVxbKptRT4gYQ2f1HHwMQXrhQPJFWmQ++Gv8R4DpvPy9ftG
	U6DlFgig=
X-Gm-Gg: AYBFou3H2iF5hdyPPj/ZXhsJlxOK2NdWHdUEz2HNJMsX4ACLbscu/R7QzuYD6DkSuUx
	z5SdkEIOWpHAIyFUTMqWkvv7cCMFd0lshaWivO+8lNLMmLfkMptBYW124p5fKNgQTXMDD2qpmfo
	REGym1Ic9Jsx20OJX5FEe/xIxgjnsuhTsl6qcARNHFcOT2kNWNcGyDEUwhpFpxo8Yz0XtwMOYL/
	fxxOv71LxIvxOyOWOyN9X5AZ+xtLXu0OsRJht5abz8O8+3gSwzAi1WO9k2cQG3ilSAMX+BcaMd6
	B7miM8pkGgCrDssqrgD8C8LGMcOe7SL4yS5HK9RwPGLcEiifk/2o26FzTb8NN8TmAxl3Kp/D5+D
	reXfWAb3QCjo7q3Jp567MDg92kp9C8Tfz+NFQ380k+Tbfokr+mdBfN3ICP4eA3dDOrTKsOi01wf
	iLnuxCxox+PR6G4l0E0HNuN24d3UOM7YIqE/iYyUf/vd5j/KnfsDQqvA7x+AN3qHzsLmDhGpctq
	Wdd4MHrphxMbklgBxAX267Egp4DBRWVpUNgxQggXumrDW+8P7kAhaM6E43Vt+eT4rslImU=
X-Received: by 2002:a05:7301:4e46:b0:33b:f5b7:f4b3 with SMTP id 5a478bee46e88-34c646ce08emr1028241eec.27.1790730213667;
        Tue, 29 Sep 2026 18:03:33 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386c2723sm2179993eec.18.2026.09.29.18.03.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 18:03:28 -0700 (PDT)
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
Subject: [PATCH 6.6.y v2 0/2] drm/i915/hdcp: guard both capability checks
Date: Tue, 29 Sep 2026 21:03:19 -0400
Message-ID: <20260930010323.93999-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and i915 maintainers,

Thanks for catching the second dereference.

The code in patch 1 is unchanged from v1.
As Sasha pointed out, on 6.6.y, however, intel_hdcp_info()
calls intel_hdcp_capable() and then intel_hdcp2_capable(). Guarding only
the first helper therefore moves the debugfs NULL dereference to the next
call.

Patch 2 adapts upstream commit d34f4f058edf ("drm/i915/hdcp: Add encoder
check in hdcp2_get_capability") to the older layout. The 6.6.y tree
predates commit 130849f8ec14 ("drm/i915/hdcp: Use intel_connector as
argument for hdcp_2_2_capable"), so its dereference is still in the common
intel_hdcp2_capable() helper rather than the DP and HDMI shims. The
adaptation puts the encoder guard before that dereference and returns
false through the older bool interface.

The CNA record for CVE-2024-53050 starts its affected range at 6.7, but
that range follows the later shim layout. The same unsafe conversion is
already present in the common helper in 6.6.y.

Together, the two patches make both debugfs capability checks return
false before converting the missing encoder to a digital port. Both fixes
entered mainline before v6.12, so every newer supported stable tree
already contains them. The same common HDCP2 dereference is present in
6.1.y and needs separate handling; this series is only for 6.6.y.

Could you please queue both patches for 6.6.y?

An LLM helped adapt and validate both patches; I reviewed the resulting code
and validation evidence.

Changes in v2:
- add the adapted HDCP2 guard identified during review;
- send the two guards as one series because both are required for the
  debugfs path.

v1: https://lore.kernel.org/r/20260929031728.88004-1-artem@trailofbits.com
Review: https://lore.kernel.org/r/2026-09-29-daily-reply-0012-re-i915-hdcp-encoder-check-v2-6-6@kernel.org

Thanks,
Artem Dinaburg

Suraj Kandpal (2):
  drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
  drm/i915/hdcp: Add encoder check in hdcp2_get_capability

 drivers/gpu/drm/i915/display/intel_hdcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)


base-commit: 79643295eba17affbd16ca97f3ef04c90266b28c
-- 
2.39.5
