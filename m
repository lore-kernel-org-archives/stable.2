Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A591442FA0
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394328; cv=none; b=DEV8EAHwT2utwtIgFzYLHGL+L1P/5kQNgqWJCUYP0Mb1rY+uDIVO7N+UmZjfMd0WBhujUtnSP0XeYT0dOOyjydEuB1Ig1Tzm244Gk9ppq0VOh4IdgZBO1iJt2nkbPIBu5h3e9bZR6SqkzB1Y87/6h3FotmVuPvBgKBOC7w48Pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394328; c=relaxed/simple;
	bh=jqjdQ4ytk0+wTeBw8PTbYYR3zs6526Vfg9ko20PQNAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MSpkAgCkfpvpDrXhHp0h4V7EDUec5R7gqka1K2902skhPIngPBEN57/K8S6nlHddYAjoceKhRe0Zt9WrTBuRiQtDxTXyv92r5GL76ckBASITi+qnYWqwp1mhLESLZn2ab4gu8+GTqzqA1sDJ8qLC5kUg3PNcxAX4YivbjqapeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUOVxrAE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUOVxrAE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2356595b3a.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786394325; x=1786999125; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V4aYm6FYSeErtwvuAXuGnJHyrhkVQge6WQL6UnOG+zg=;
        b=JUOVxrAEDDUarQwaD1ICu0uriU0SP5hkR3+rfOi5MAUDXYh2raT3QJFr/6z14KAj3L
         mT3DcrOduzYKndphpRIV1kBiRxZBpdRlgtvDQUux0my4mAzgtJdPryrLbURUH21ExYW9
         bsev3Jg3rrdl8S8ELe+zBLxxiAuwUcE89LGMqa3SCFAg3sFnlsFtiQPi7ANOenS+IUgl
         e3JHMlf9DOuv9P1VwPyM680ZYwG3X9tADIWeksT6ZR+xnI9agZ1WCUpCFJF4zDMpEKu4
         X6SmhqKi8Er5gBdNr3R2C4DkEFuSZjfwZt9VdxrfSatm3qDmCX8GSCZ6E3KTuLuHA9IS
         dg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394325; x=1786999125;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V4aYm6FYSeErtwvuAXuGnJHyrhkVQge6WQL6UnOG+zg=;
        b=VbXOM2FdF13e4acul99BI2eA6FwfJiX50MXffTeZiPAkZ1PixHyHpjAs0+PfJtlspS
         qjzqj0g7piiLsEFHkzzaHJahCvJStDGxWdjODj7bQR9kwxStljK0dCA+HLafrnj7a5Ob
         MLbFVVEjwi4W0jQPXvvp612h+56q4+Hmxa5VwvCDJwQG6kGDEgZvetgVW91HBmn6TuXO
         adjvB/rTOjE7P3uTmMJ5RmBN30Tz83+QWGXHMrgVYUA1MTyifQ+60DLbBnTwfN9I4/TA
         3ZSkP/JBBP9mdnmJeg9NDUteMS3tjEQyJEn+jfESBysbZYAh8f72QYliUU2u0QAq+3Uf
         9E0g==
X-Forwarded-Encrypted: i=1; AHgh+RpL9T+L5KUiIIZJBvewLvAOx1huzZf1kkkuPkAnfknjFMTo26aEq4FI6NCDWj4stIoTV5DUysw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VfVzAGIbYl1fmcLhpDLg8W+BzTzIWaaHMHrCXvp5Y+5hI4aZ
	ojO/pu5OCed+pyeeF+IeSLKApcHO+fwYHvaeCIWPIfuJEwNXTqVUbSv2
X-Gm-Gg: AR+sD11w1x/CNWve+qT7y0If7daEY4ULtEkJr1dmEJ7jVGs6Jpkk31xssQyYreu4mzx
	LJ+fqd3s8Y+0AIyqyqHKSNsVR6pH0/GCGPKc8f8O42QToKLUoaXQTClIqknkMjLO1fUDq5Ghaxz
	EMjphOOOryeroYXa2fVXXc3FNg+ofZwMOhxriNejoC1Cyrttmw7EaTDuX/MVtwHsqX3WzDfb59+
	vCO4lmiX30nJWMBZLVLw8LWGaO2R0cNnyRQNCmN5mQD0EAk8S05XJN7umZM/k2pBecsVWW8m8Qz
	sy/bediwaWqd3BUqRrP027Tg4wY/CWb+Sb8jyJ0A4lnuR1hkMDzOvTswxBwKXvMMTWhxQo0LdaX
	AosDBD+KVsbQl+IxE4rc/bagAm9/55AJeNpR8oIMPYXlSZZS9Q8pAXuC8UDAE0Wcw4ugb2VusDj
	bVBb1YT4abHlFP5pefqzlxqOrwDEWldxH+EErU/TPx85z049bducI6KvWEFaM=
X-Received: by 2002:a05:6a00:1883:b0:84e:b7ed:7d50 with SMTP id d2e1a72fcca58-84f9c8bf09fmr4538374b3a.16.1786394324672;
        Mon, 10 Aug 2026 13:38:44 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:38:43 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind error-path
 bugs
Date: Tue, 11 Aug 2026 04:38:18 +0800
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALo2emoC/yXMywrCMBCF4Vcps3agiVisryIucpnUKSSVTBOE0
 nc3tsuPw382EMpMAo9ug0yVhZfUoC4duLdJEyH7ZtC9Hvq7UpiWUskULDVGrNFy8hj4S4JO+2D
 s9Tb6oKH1n0zH0PLn67QUO5Nb/4ew7z+EJKiefQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=1170;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=jqjdQ4ytk0+wTeBw8PTbYYR3zs6526Vfg9ko20PQNAY=;
 b=Gm20mEIHRxSyNqIwseVbLPncJya+jfBeFQW1zRIDALtssFI5jN1ElKIgYE7rkA2kCvoqn4Kde
 ehO8EMs8rL4A5Em4KpyLCtT019GMGdAlef3kWJE23++u3iVAGXDWvTI
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

