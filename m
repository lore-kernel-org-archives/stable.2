Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94F470433
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583312; cv=none; b=juy0iuDBuSUUavFvzZUsRaKpSR20aElZ7mhCGHyNLX1dx0dcY4dkRlZ4bnHstgRM2DNjtfBEkmw9HMJWfuvNZPxG11djdrBuSh+Yopl4Kj0cg3es6kM+WFkjKD8va6aKVxrtlw4/MtSZYAviauF7U8NcubahaGJb3MmHrDlgjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583312; c=relaxed/simple;
	bh=eJiO/FYrLlV7xeZ+gg/DbqurbXD2F3ZS67N63yr/0pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rv/7b+/w0lnV9Igcah/DZbjAwBJVxN55lQAl2TkzYBcAlIYDrLGkIjUtE64AuJja20vWUkE3SnC9WztPmig0wljVaFH/h0wwrJPfsOoySUcmQenkmPKnCNfqBDExQ/Yxjwc2fT13tv+utd8OYBckEvVrqb55kuOr1IElVpvmI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=od4VucFb; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od4VucFb"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df90e859e8so8468885ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790583310; x=1791188110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3PGFMLkqPdnEjr3rj+p66S6V4/orGCF5/967SLXqniU=;
        b=od4VucFbma5nokHnVBuNU+YariaerHkpUckMjYGz3FGaUjGPuDM6SN9Vh93Trskr7V
         FPYQp2Yh1oBNZe6F11qBHK7In40aEIKwDZHhOI+rbDBt8q/5NE/v2r1i3ZcQkofGFvw2
         JGJuXr3dwf0wDst0kWdU4rDXFTcXp3Nq3BrcF3D5iIWCQk5c3TBjuzgakmRwjtXe9QbH
         9LwLdo7zCe0rRasWfNxPlrLBt0A8gcTelkRHUJ/uykjuV4w7iL+pq1QgcAphUSZieIst
         GMfYvLEyVkJhSDN14FIuZjBNG8QheNLma9921DtsurD6+HuCVyk+pY5C7+5NYR09T9EL
         vrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790583310; x=1791188110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PGFMLkqPdnEjr3rj+p66S6V4/orGCF5/967SLXqniU=;
        b=EhWxEqR3Ay8c8lVJYLvWEQljMAx1a1FUUxbVH8nTwBPUd0OPjDLvylQamkh2rTB8oV
         M7HrS+WUEdHGlVbYg1/q/42gqwKj1K30+DOtNpyuIjqOqeq/KZr6wws5WnBfW+PHs5Iv
         Z+d8nq1VeAgI740ZmL2aFS8L1XqG/s1EjaheqwSKAgq0HQCFWx4nqJOr1XFfNVIn/uRq
         tIiSQS5ZvC3KlJFEWIb12rcveo5LicVoKxTt7C7hRiBWx3kpchzDg5LuqwrMUJuIsQhC
         AvFeuJI+YUmKxwHWYKiq1JnG2nAB+P8cKN50Z53TxXIWoXdENvGoQLyngX41bwNivNp6
         lcdQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6dW5ysdxs+Qrf95+0v99oFl84BmM+NUGezum/LGfRan8um8e2fPCnC4IdQi+pW6ZqK95Iw4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3z7Sc4KACAeXPzkRimembMDUKpOIZ5njHui/HYDEOquQp1zUN
	29qVjMx4RlRW5AQ2TCVhPazRtvo39aAiA9lzIjoXGWMBcVSR5XQi7nMe
X-Gm-Gg: AYBFou3pRMkm/z8xtsrztURUAs5klk+zNu18ci/hNCNLgoN1OHhL18h1uCjS5b8409j
	2P9v4hoHgM+P81KlT48NUk04exc3mwrypEAO7u5AcEmOlgeStGXPEOQHAxFt2L8ZcS39UVt6pd4
	EViJ6dk1oe8N/IMX3A3zlsQ9vC7w8QYSxQsOcRb+oLFsH/Cu+04vkbpgfk4hZ8dEb31b9s/ElpH
	lohsy7WPxzhELAXNdP42hcf5arczpg/Zup5ra1rxagxK1QfL/eOI4KqFJw6/k42Oulh4YJ0K/Tl
	qUya1EH4ALiMDSlY0G4hzcBW9epGFXhQCD2Yf8ghJI/WbL/kt8M951MwRPbyh42RsYcIeWRbwGt
	ZnArEH1TPW9a3rHihS1y+OxpAZesJ5Tnca1ppsoBrcnkzK6lbFaXAKg0xUH1Eirnri3ukPOwLR2
	zWl5kqvD+wgCIfP2cSQXbrTu/ibJP5wwnTCSOE2ikljdugH39EGKSxyVDB//qg5mQtk7VhdRroy
	cfjtjpJolcCSWBfCXaPTsebaTKDLKvNn5LOB+A=
X-Received: by 2002:a17:902:fdae:b0:2df:67e8:4a39 with SMTP id d9443c01a7336-2df7dfef6ffmr74050975ad.10.1790583310497;
        Mon, 28 Sep 2026 01:15:10 -0700 (PDT)
Received: from DESKTOP-HOME ([2406:5900:111f:dc2a:3071:69c7:a4c4:6259])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fb675bsm37833275ad.10.2026.09.28.01.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:15:10 -0700 (PDT)
From: Beomseok Kim <dilddream31@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: lyude@redhat.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Beomseok Kim <dilddream31@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
Date: Mon, 28 Sep 2026 17:14:50 +0900
Message-ID: <20260928081450.19340-1-dilddream31@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nouveau_fence_signal() clears fence->channel before dropping its
reference.  nouveau_fence_no_signaling(), however, removes an already
signaled fence from fctx->pending without clearing the pointer.

The fence can remain attached to a BO reservation object and be used
later in nouveau_fence_sync() after channel teardown has freed the
channel.  This leaves a stale channel pointer that the sync path can
dereference.

A diagnostic build with concurrent short-lived Wayland GL clients
observed nouveau_fence_no_signaling() with a fence pointing to channel
C, nouveau_channel_del(C) returning, and then nouveau_fence_sync()
attempting to read C->cli.  A no-fault read failed after teardown.

Clear the pointer in nouveau_fence_no_signaling() to match
nouveau_fence_signal(), so the sync path uses the fence wait fallback.

Fixes: 29ba89b2371d ("drm/nouveau: rework to new fence interface")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Beomseok Kim <dilddream31@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08b..5b09cf134 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -488,6 +488,7 @@ static bool nouveau_fence_no_signaling(struct dma_fence *f)
 	 */
 	if (nouveau_fence_is_signaled(f)) {
 		list_del(&fence->head);
+		rcu_assign_pointer(fence->channel, NULL);
 
 		dma_fence_put(&fence->base);
 		return false;
-- 
2.55.0

