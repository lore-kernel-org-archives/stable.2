Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822444E652
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026210; cv=none; b=pAwZxAkSnpwfp/A75OqskkM4wvzBmdEs36t2bAjJBCZZib/1yUTSm0zcBqRZgSWc2YwS7Mlc6SAc9POWycCvHP01ahUH0JFSQWTvX0LhqV8W47p+9QdPd41/lm5ru6VFmLxG5AY48aMN+oVp9+9Yxp8IN6PzgFCUjexUYFHAg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026210; c=relaxed/simple;
	bh=k6Nbpz+tkyn8G2OUgeBANjIKnd+uEj0n5Dn9A2bSHRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jyn7DYt+NSKiczHwMHt5shzUkvQzEORdHU6ZPnMT81cmKtACqTQ6tYEfxyGPJwHTY6yxROazlTC95tHYjG0mHZph4dURsZadc80LAD72hWqgw6s5p21rISn6luJeT0wbRtc8FnIR1OstIPj3WgzNXsPQXTyhgpMrdjqg7VDLA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E50r/nVx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E50r/nVx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf49dc28ccso3190435ad.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786026209; x=1786631009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWMhwyAXz7pGiBpWWssd19qM5EphdkdSgXA6cinir5w=;
        b=E50r/nVxHXU6hdqtB/PVj2l1ta//QqYgxzW6QTQLbPr6+KoJUkMmi4xMNxaQi3s9ST
         3dy0eOFu1fRka1j/hvFKa5auxFs0RF6tqBNgE+tdTu5QJ2Fsm94wgcohIfIvkrMC2aDm
         NonVBMpYO9iXE1YS4LZzU0WAh97Ax/lDwyTr7X4SId7zIr7rLJuXtlDJBR4r7Aq2LhgQ
         CabgJY7mMDBkoUiPo8l1XEk7J8hhwTetjrJfPc8LUcskSR1PyTofcN8fH3DgF5ny/cMn
         FSbsg2yqa0u7H+YfTrY0fBMdhbe5ShOsDlQDqSTP3dNKbvNyraH/oW/HbJSHBhlt2Gfa
         Jv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786026209; x=1786631009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWMhwyAXz7pGiBpWWssd19qM5EphdkdSgXA6cinir5w=;
        b=UleM9b/uP8t3O0yw8Q+XfUTPhzdGkuNG+EPUV4DNUl9fiKHPzJ9GVNmqw/YIBiY1Re
         OespycD+od5zoIav/mHumE34zdS+s0oQa1KVlXfLdtxkWeW4FGj345c+ekqeGGXJv4Sa
         6ujWKnP7rSOEPSXViGEAIl7HsTzGaEGQob5ycn+vwcNOdJmFNt5bzJ/hGlbOgkRwEFqS
         uLrMMkVjLKq7UQ3VVTH84UrNMGPPf/2FVqWa0Ff7+xWp/Kgun148hRbwoiv9of9O2eww
         HwORPzemZU/RW+c6RhxdR/tCjmLlEUO3XXyD91/fr1SRhM+r6+xDgLb4f9TK3QTnMQ/R
         YT8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrpUPFpMIP5R8aNYBQepx/ESuzxDrTtWmYSwfoVwVySUzOxZdxa+QJeLe5egJpCToT3WtJlnpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEabf/kjG0181q5+JY0B/ZBLho/XbXqsJwDM2l2x+uzUw2s9S
	LvIMN00mF0/JJY2Hey0fqqggKU6UlTaphB2Aviugcq2g4jPeq4n3i7fW
X-Gm-Gg: AR+sD127D3W8cXi5+XPgNYv8TkqmoZiJ+CngJgdK0mMbe/YwCQzO+6HOQs2Oi8cxeB+
	mvQsgE236ReRVmcoTunmhNOygVhxHHVeRep2mgK8Wr+L7t68AF2kp4rRu/I4LtzYqWYbOq91Sz2
	BX2Y+n2w/z0JePNcr6Wft8gcAep5vgNI+SsYYjroFiSDE0WGEdhGoUVXXrlS1iaBgiPwRcbLo7V
	lqI8ygD0SLTFSEXQjHvz+7zgYGbqjzKZ0H7782MZJnJYIlzpNaBJz7v9/2dBGbABRZXl0UD52wH
	UlWhrVkHplPuW1uFPErOPMhTJjeHautG32h58pBGLK9bMjRP+eodkZ9n1Fk4/q8gQrGqmLwHGsK
	xtkILmOyIIuUdEFb4sclgBgIIE/5DzlJo8LOfbAOE8QY8yE2GrJfEqwRL3cdWmMYaIwmK/ggBIi
	Tq30yAGwDgV1q0q9a9h3cpn1aPN1DrRwgUd4xCjBMsV8cQ4sfzRyyUYIY=
X-Received: by 2002:a17:903:26cb:b0:2ca:de3:15eb with SMTP id d9443c01a7336-2d0ca35c5a9mr123845245ad.0.1786026209216;
        Thu, 06 Aug 2026 07:23:29 -0700 (PDT)
Received: from archlinux ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f936edsm32685745ad.3.2026.08.06.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:23:28 -0700 (PDT)
From: Chen Xiaokun <shinnkka1@gmail.com>
To: axboe@kernel.dk,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chen Xiaokun <shinnkka1@gmail.com>
Subject: [PATCH 6.1.y] Fix memory leak in io_wq_create() on success path
Date: Thu,  6 Aug 2026 22:23:14 +0800
Message-ID: <20260806142314.557312-1-shinnkka1@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 657ca82526d0 introduced a temporary allowed_mask cpumask in
io_wq_create(), which was freed only on the error path.  This caused a
memory leak of cpumask_size() bytes on every successful io_wq_create().

Fixes: 657ca82526d0 ("io_uring/io-wq: inherit cpuset of cgroup in io worker")
Signed-off-by: Chen Xiaokun <shinnkka1@gmail.com>
---
 io_uring/io-wq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 66fdd69fd6cb..34a1a9067cc2 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1218,6 +1218,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	wq->task = get_task_struct(data->task);
 	atomic_set(&wq->worker_refs, 1);
 	init_completion(&wq->worker_done);
+	free_cpumask_var(allowed_mask);
 	return wq;
 err:
 	io_wq_put_hash(data->hash);
-- 
2.55.0

