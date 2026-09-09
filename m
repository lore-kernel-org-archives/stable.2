Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39522568526
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967616; cv=none; b=Pyj514P7N8Pt7fKenf3aLeUpH4O+NhPQLgYtuTllFEHssrSmHRuwwG/3INeiibwYd52JRqkdXdX4oM2pz/U/svtWtSu2SRQL6VQWPNuFjvF8LRueYcDU80/g/YRNIJ8VEg6Wou1QdK4UaEWKDxOFondUT7h7ixBJxaIknnG6ovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967616; c=relaxed/simple;
	bh=ChBZpmStwf6IuXYTtNp5FiyThij9tzb5gxPf5NvkmJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPED3bAOEYqBwTAmgBam7Fqfa+gC4BeifRMcN2OBg6aGrVW1S9gKtXbilOs7q8Sh+jcdj/nT79EGnwtFBWtPdKMlv1xexCs/y9bRviyImHtZqRQpdeRZbEthZXkCLFz4/i1SyXWbJaFHilvW/h2LF3/OkA/qOEhAvYB87jdRtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3LpnLnN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3LpnLnN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso73761275e9.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788967613; x=1789572413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDqKyN1Qu4PwlUilcbpQmi5YyCZFJcuz2STw1EswGQ0=;
        b=G3LpnLnNYG98TOAL+PRk9mdu7TBVDVe+yPmE8aNdRiB0yf13dwa/WJbzcKQoEvcii3
         3OUrBN0Y54UV4d3YSZUB5Nn9m0ysAU74cgx4rbx6MxY/B3Gi5nWN+WrZH1+GNfVZ1xb5
         fzpFAlTVFhydJLJPprWZ2Sogval4ZnfprzCccskDtgyEYbI6Ms0Shove/B7/YtHF1oXG
         Kbx57l1xrSgie0y/aqwJfThVUcm6mG7Lfq2mYkR0IjrMvWmcCMP0PjbRVZb54MAufqIm
         qm8awlcEvtvRsuLnh2DSuNZfjk5aaiEPpG/F5IlCHgTjooxjK4yUhcqoUufK41s4xpzh
         zXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967613; x=1789572413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDqKyN1Qu4PwlUilcbpQmi5YyCZFJcuz2STw1EswGQ0=;
        b=m1YdUNqvoVHn3igEkwu39YDv+gszKLz5t5NR4MlycbpN0Den8p+1GTsTQ8DyiVn+aC
         Kt1pq5MJWQuve/JLbVnuNScI1zIxDjxltpHoP91APYGcE3lEGlympVXw+lu5/JWb3QmL
         GAcJlQMpdQeJNkMvr/OWuc/WSdvlKDxYbhZAsLoxiyMtrwjzK/wDd0zgMI38erOI2OQR
         OjEhhDXyt+nBALUZQliYdRPjHQLedMAIDPmih2ZlQezQgr8MqW+PSMYoepZo5HxZ6vxq
         oC/CO9aXJQrE2Cswa+Sk2z+kgYKDLGlmtlTy+gpTnkIyNdT3tl8QzeY94IfQk4s4OAAe
         +1nQ==
X-Gm-Message-State: AFuF++m2orOkqsmmSN28S1UDtZ2IEKXfDZ6yb+AWkyMqSzY1yomWXY4j
	fKOJ/4s2JzxiRphepNl39bfe4yNRN2QinZ5Mdw1MouEvIKh7al4nNhKCBwCnhF2M
X-Gm-Gg: AYBFou2gRxMbkJvPfYcu5DsOemdCP+1g0g4KDh5yXYaFXa8JPHxTVSbQF7APRVxbVSL
	8FHstj7TDfoiK8GafGgIDGEvWS1y9JjC4QrjCbVpPJ/AksZWZvfId62GWr+Acxq7k2hYNmSiRo+
	bc1Rtk64txFp7Skr1SoKnbdIQYpMJ20wTCQAdblsomN95R2Vpylke5HiXKrGCu7I1bC+TUKiWUx
	s+7JUs/i6iLT2t6fiTKFzCslOxJ8qhYl/kWpOQpWtoWoHSD3ysksxEeY81YhjXAsiR7xtVJ/cra
	uL+ZJBP2E7uUS5uAPMWb+RaWSOV3VXzKT0gNaxNqbyIr5oCM87I3hAlG2FyQoM90WwccT3F3IHX
	DQaAkjpJkURJCAKq+Kxb8osb+TnuvwlLcpeu74a9Mht4VUnVap/0mKBN1G4go3v1n/5rsT9vv+e
	+SY9W9cghOnAgImpRKbK9bbCOBH7W2kRLVQrfUmxnUYy58yTjKJhI8ACWRgudEAybj7fq2GGJ2p
	l2bEHsXXvCkf5VSlYQbAtKXoELbb+RK+MtcWdLH219PW8g+hdGNpkLKhip8eg==
X-Received: by 2002:a05:600c:6298:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-49d17d4d6e7mr132352845e9.23.1788967613286;
        Wed, 09 Sep 2026 08:26:53 -0700 (PDT)
Received: from cachyos-x8664 (h37-122-44-64.dyn.bashtel.ru. [37.122.44.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485aa2c9acasm8901719f8f.36.2026.09.09.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:26:52 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: stable@vger.kernel.org
Cc: alexander.deucher@amd.com,
	mario.limonciello@amd.com,
	superm1@kernel.org,
	Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: [PATCH 6.18.y 0/2] drm/amd/display: Fix full-range custom brightness handling
Date: Wed,  9 Sep 2026 20:26:33 +0500
Message-ID: <20260909152635.83860-1-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090900-lip-ribbon-1726@gregkh>
References: <2026090900-lip-ribbon-1726@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series backports the two changes required to make full-range
backlight handling safe on 6.18.y.

Patch 1 restores the userspace [0..max] brightness range.
Patch 2 fixes custom brightness curve normalization for that range.

These patches must be applied together:
- patch 1 without patch 2 can reproduce the existing high-brightness
  regression on panels with a non-zero minimum PWM level;
- patch 2 without patch 1 does not match the current 6.18.y userspace ABI.

The larger power-module refactor is not required for the brightness
arithmetic itself.

Validation:
- make olddefconfig
- CONFIG_DRM_AMDGPU=y
- CONFIG_DRM_AMD_DC=y
- make -j$(nproc) drivers/gpu/drm/amd/amdgpu/
- git diff --check

Akhmed Zhitaev (1):
  drm/amd/display: Scale custom brightness curve from full range

Mario Limonciello (1):
  drm/amd/display: Fix backlight max_brightness to match exported range

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.55.0
