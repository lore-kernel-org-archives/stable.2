Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88E41D219
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438012; cv=none; b=MfUcBrHQR7alw5MKtdyen5B2lALJvgiwx+MeeGdUUdkH/b8YIo9640tQG0oLmdDvadnSCK0DyT+S+YVmBPFK7CN6GPA/66HeUfnRg8aVEmM81HXxT19CJ8tP6EIfzvtSAUy3a0rAaEWyVYU3fS82Re6MH0v1/P4Lc6MHBMaEu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438012; c=relaxed/simple;
	bh=p2r9UCUH+IkCeVc0eIsmIJaqF16cFuYfb27Nri+KSQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RJ9sjrx3cx3iWYNLdfDFOEm22nxtUgsKyveQjO8fozfe/7v3tzGkLn3sH0izeLreJSEzKOJq+s+Qq+2VELfohcVPyyTfrdlDEoOz4GLfS2suTqjC0SpOfvibz/hxPHbi8Umkfoqd0zkjykSVC9mQOReeG96HsV0yeb4lWF2R1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpv0YG+g; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpv0YG+g"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2009364a91.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786438011; x=1787042811; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aRMZKmFxEexFiSBi+NXLZ4mOnz6FGsIj0DngbOrmNM0=;
        b=fpv0YG+gnN4zGFeUw1xIYPVrsZmNc4PhWZbmCU5dCNqwnN/85wXOQ4bA9JHFb41Ss3
         eUcfiGbBu6zQzWRXA0G5Ees+qTOSbNsx34qrzXCTYAJkXAn9LJ+u5mntpegJuC550MFv
         iS2p7QdpAbvJvtupOl0hZdZKcO8cTUYikcVvSDGs/qP3R94qqmADtLzoKN1+ar3VguTd
         ZlSaRd5/ps7+mz/JPOGHOL9icKPohsM5UV0SraHBiuOynIL7efgfVJuwDqCV+WThU0dY
         y0f4B6X5Vlz8HA6+GNA5JpOKvkZ3Xh5pH2G2X7xdV1VSquaZorzTYcvNK5TLwrK1Nlg/
         6TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438011; x=1787042811;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aRMZKmFxEexFiSBi+NXLZ4mOnz6FGsIj0DngbOrmNM0=;
        b=hKvyMfJrXit+YqxpdqPGJiaQcVdBGEyyzp5TcBx5AULPmchUUYztQMfJcuc4eT6cTD
         iFLGwPc2/8r+I/K3xB2mhsmBb3/iX10sLmO2sl4CK6xjnmNPBlRVE8esB+3myDNmSnT9
         eJunTv4TnPaOGovxxD4AWmjEHulYgVkO3kGhm7joKcwZ1FtpXizo+5zyJ4dFvJAVEcJH
         202vTKHAz0PMosXcPexyLxC1H4dyI9J/1z5b7KooxR+xWrA6pSrbhmvkGc5r90wyECsU
         vbVPxwZcFMWTvIhucvEJVwITuuu5QhJ0eClmcYljUpGdtJFG6wsXPo1Ob8J0mCzHeds3
         cccw==
X-Forwarded-Encrypted: i=1; AHgh+RoDEVKGBGUhrfMEZ8qmlvNKx52k4Y/anULuyCY8rTespru4ZQg21jwFDyTvTpfjFQGExOO24Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3fLM2CGYHWTnCRdpyncLN1jIv+RBOYgaaRo16ujJwoBjUX/2
	b67wwP9OnSM6EVoHA/Xn5cRdF6WD5EsMNltyeinT3yJSekm/IQprOxwM
X-Gm-Gg: AR+sD10k2QjCR/WUKW6WWR/V9sHu8rnGna8wC2AH3R/q3We5/OFiUesjXSQyu4vvdxa
	tQ7kW5YOVWVXwjGz0l9Bn2J0xt4nvLYDQ/4mn85pPIxZCrQ4A8H0zYrTGh6Ctr22xpAe+7qQzp2
	QDr9adV/ZoiSxSrreBp4IjxG8LHGrZDem8yug1q5CjKjCBXwa/qDKK/gSIHfN+aYa1go01REgsz
	IHiqmN830q0df2lYP3toep79WbGmpCoyRmcoCqpnE29WMCL0CcH9h6Kgc7ohfP9PIez8SP72Hum
	EfQR8yMb6SoD7Ja5UdQEZL3NIREhyrLRGNevTZTf6S49jDLBaDnara8fkecGqHMuDLMm/lBl4A5
	LqP0WLMezRGHRdYpOe6Nzak4eMyMFcNEo3Pk+JOus7cklqqaQV5uCbdD5IQeNgQ1JoGV5bv1Dwr
	U1PTJy2PCsYVJGFKn8WaV49VTWyAW592frgw+Wvmta5mOHtbonn/ElIZ0+jeTGSPgEhCt87A==
X-Received: by 2002:a17:90b:2750:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-392ec38eb9cmr1766448a91.7.1786438010922;
        Tue, 11 Aug 2026 01:46:50 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:46:50 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind
 error-path bugs
Date: Tue, 11 Aug 2026 16:46:27 +0800
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPhemoC/42NTQ7CIBSEr9Kw9hnA2lhX3sN0wW/7jICBQjRN7
 y6tF3D5ZeabWUgyEU0i12Yh0RRMGHwFfmiImoQfDaCuTDjlHb0wBj7kYkSGXJyD4iR6DRbfJoH
 i2gp5OvfaclL9VzR7UPX78OOU5cOoeRvcGhOmOcTPfl7Y1vvnpzCg0FJtmaJtJ9v+NjqBz6MKj
 gzrun4BvA9VU9QAAAA=
X-Change-ID: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=1359;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=p2r9UCUH+IkCeVc0eIsmIJaqF16cFuYfb27Nri+KSQE=;
 b=BPNGH7Rxw1u58EJuGxnCMfLg0hb9HrQMIWMovlH5lsn/WN39m5IfwwvHzxSAs8yLw6I7youtI
 RP78gf9O83LAQQaRsjG8AMkpQbpSpp7soUvsAfEfjPsTqXCNx5yQnQa
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Three bugs on the nouveau VM_BIND submit/unwind/cleanup error path, all
introduced by the original VM_BIND uAPI (Fixes: b88baab82871) and all
reachable by an unprivileged render-node client:

  1/3 NULL deref when the unwind loop frees a never-populated
      OP_MAP_SPARSE op's ops list.
  2/3 premature free of a region on a failed OP_UNMAP_SPARSE, because
      op->reg is left set on the failure paths.
  3/3 a sparse region left permanently marked dirty after unwind,
      wedging later binds over that range.

Each fix is minimal and self-contained; all are Cc: stable.

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Changes in v2:
- Add an Assisted-by: trailer to each patch; no code changes.
- Link to v1: https://patch.msgid.link/20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com

---
Zhenhao Wan (3):
      drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE

 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

