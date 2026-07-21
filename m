Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385E3BBFAB
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622093; cv=none; b=BrqPFNKquBPQlpp/2D/bd3C1IR3JStYGEFQOFjFOYF7Cg8in2GPStZwCO8ewsYn2rrsD6CEBi1xWY95E0MeAxLkttniHY7sJCV1FzzuGk9mhkU2YXStoC1OBUzYiQDOgH8DZWa4rRv/VegE3uUM2G/Wnv8ptgMG9EzpulYqVUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622093; c=relaxed/simple;
	bh=KZj+fDIuFaU9gdUwXy3nlirKop4MnO/B/UbdnQ/htno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lc/8XXrDSUKeXjrGYZOV/WVZP/g8ztu0w2dkcaHgfZXeAXTJTpEI/mJXE0DdGOxAzdyUFb/91DZzvHem4tLbrorfItmmA3P4hot6vkGCzeBi6vmQIAGVkZkzBTdq4nopDRgwLQyV1MVxYg00/zRz5mXV+OwNnNMUFb748Kw4rik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eB1lqxOg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eB1lqxOg"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15f360851aso1174767066b.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784622090; x=1785226890; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9+ia3WLYSRNd9xkwqotEf8gwl8oDgEsTaLE4rh2ip0U=;
        b=eB1lqxOgJITL9DYow2Rth62xUgCWdoiBtKlQPaoDEyNxhul8u0cHj7mXrFMThSsUKN
         LKBywFU0wXEHKghWPz/bqYmNzLw4XM//vgt1fnPiI+8b4FuGmTk0DmhpXBW5bywK0eJM
         jcO6J/6D+u/agpZl2ZQMpaQ5k6veD0wqqeFNdkPMkl8bIZAZR7X7mH+acou04luNT2zm
         r81wZBM4i836qzPHn6v/gkecwYqsfLgFJa7+TDFuHMQpo/CT3sqBxWZJ+61OW2sGye1W
         U0ouX0nHDfHpzfQNdXp1RNI+3L+XKj2sWpTrATgHy1TGosdjUbpJmfOKKeged5eAVk4G
         ASDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622090; x=1785226890;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9+ia3WLYSRNd9xkwqotEf8gwl8oDgEsTaLE4rh2ip0U=;
        b=CGTIwXqoEgsmEve3Fa4FdcQHbzQYg/kEjJhiPLUx+bqqZYWBnc0G8K6YLtZOgS7we8
         7SlP1E+M1XEKEK60R+GI8+K3W/SACeTahqrx/d9ezuTHI13EH9nxjsM9F3CNm2HULnqh
         /GqvfLznwtSRNjMkoz87YYQnYNsJaMQMpJiyYVAqe2Xg5d+a45AHYlMrl2Y/Ew38Mp1Z
         dfQhVxnDFTpIWBon/2M6sGGO211zIcbYnI7uNnVI8lMzemPTtNU1gDxbYviFebvJPejW
         cSptA68EvoEvGWSNuYhpjPTzld0oeX+L7Vb/D9gjmrKzfbG+bn0miTuh5NoNRyJ9Jjle
         SPlg==
X-Forwarded-Encrypted: i=1; AHgh+RqtJnQ9vQJG4sOVm+X2M95JiINSscRkywn80ydiCOURbBPs3uVMIdg9sYzLrzXqr/9vLYls21I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShoD8U/8ZATfrwiZ7gE8T9zvdD2AvNtYyF8DVhIupPGBzXeoV
	sYm5fAbLyWkmhjMB2kJN84NM3hxJwaWxp8l2YtHFXbG33sG0dayisU1ymujkNiI2WPGZOZ8geMQ
	QyZMIz8M=
X-Gm-Gg: AfdE7cm77VdJfGbj/YOwYEtJGxMKHTxiEE7yRXWjvK0ir0hzVCAMlgVkPrAkjU0cqKe
	cOWYpjNYHL0MXaEFLPAO1Sur1FRSGKhZejCq+B8jLDyNegStUI/M1fF3AHLFpWKQHRimtPRAa8r
	Ykaeq1CSnb9TxsgTo/mssWega02c8upOupOVHLQXtvA3EcMcvV+VFmpSljlJ/uGAdPOg6nopiwZ
	dwAN6Apn2grsPiweoj+36TVvS+wyRFjA1o/HROL9RTQYSYTlQsXEB9dBro6eFpMk/+1ZYfS96FL
	Cr6vPf4qcGCyFXuzBS8DkdpFmw9ikf9mAGCfL9w8h4lNt9iEp39ZQpxUknYtCydVgsB4g5JzlNr
	Qe0nF6B/HywxuGUbrh8QYocoFM6WwFOvylerJ4TEhUVS9WF6zfv1LJe/ENGGmzuMwok3F5cDNHM
	3zNlw9QpQYFq/rSDQeFk0z0gffaAv/+5ujwLOdrtvtf4UCGiyKWpg9JxSRajAsnvG6Qg==
X-Received: by 2002:a17:906:eece:b0:c0d:cd71:6463 with SMTP id a640c23a62f3a-c16b46b6474mr753086366b.16.1784622090194;
        Tue, 21 Jul 2026 01:21:30 -0700 (PDT)
Received: from puffmais2.c.googlers.com (185.155.90.34.bc.googleusercontent.com. [34.90.155.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1724f50b72sm564725066b.48.2026.07.21.01.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:21:29 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 0/2] drm/drm_crtc: dma_fence_ops fixes
Date: Tue, 21 Jul 2026 09:21:25 +0100
Message-Id: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAUsX2oC/33NQQ6CMBAF0KuQrh3TToEaV97DGFJKgSZKyRQbD
 OHuFjbGhS7/z/w3CwuWnA3snC2MbHTB+SEFeciY6fXQWXBNygw5lrwUJ7i74TlDQ4/K0GSq1s0
 IKLUyssh1LpCl5Ug29bt6vaXcuzB5eu1Potja/14UIMBwaZWqZdnK/JKuNPmjp45tYMQPovgPB
 IGDaRXWVhWNKvQXsq7rG/mUxaj8AAAA
X-Change-ID: 20260618-linux-drm_crtc_fix2-23a7c354a412
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Sean Paul <seanpaul@chromium.org>, 
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Hi,

These patches fix two issues in the drm/drm_crtc driver. Initially I
was hitting the BUG_ON() in a scenario as explained in the commit
message of what is now the second patch in this series.

After posting, sashiko.dev noticed another issue, that was previously
masked by the now-removed BUG_ON(). Since we can't have a loud BUG() be
replaced with silent data corruption or worse, I've also added a patch
to address this issue highlighted by sashiko.dev. I believe its
observation and analysis to be correct.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- Philipp:
  - patch 1: update kerneldoc, add Fixes:
  - patch 2: shorten commit message
  - explicitly Cc: stable
  - collect tag
- Link to v2: https://lore.kernel.org/r/20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org

Changes in v2:
- add new patch 1 to address sashiko observation
- original patch 1 becomes patch 2
- patch 2:
  - don't turn fence_to_crtc() into macro (Jani, Philipp)
  - update commit message to include reference to deprecated use of BUG
- Link to v1: https://lore.kernel.org/r/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org

---
André Draszik (2):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      drm/drm_crtc: fix race with dma_fence_signal() in ::get_driver_name()

 drivers/gpu/drm/drm_crtc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
---
base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
change-id: 20260618-linux-drm_crtc_fix2-23a7c354a412

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

