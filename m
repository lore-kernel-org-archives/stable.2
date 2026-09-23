Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99303E1CE5
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196130; cv=none; b=rOOqfCeb6BRf6uY7eleLh+iLNH2xMCeGh2o9eToprEEQqDZ0A/am+fSQ25eGcNy25PaDRQu4rtVIQ6DajYfyEPhzrYJsJ6G3e7cAIi3eAZ0rhY+eLFKXWxWsF2ri/jB5TPGaiy1gXwQuAD+IDizhj7fEHcU59oa1eZ0lRjp0udc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196130; c=relaxed/simple;
	bh=X7R9IrSos6cqCrnKYU8/u9DylC5NgZsXQ/kcQyXen2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iV6ytMHB020wLrrQrYw63NZsrkcc9u8DF+hNWNByuR8LNFQyBjFmdXb+z8DDdkA/ct6A03Cl5gTl7RUNOzcXct+0Pkok6IozgDXDRaduJMn8QcmRgOz5yKG9c4bT9QZAryB7axCq+4fZ4Oy4qRxcpqT5CPHa+tUokD+fbfiJlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdnHsKRQ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdnHsKRQ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so10393975e9.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790196127; x=1790800927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7R9IrSos6cqCrnKYU8/u9DylC5NgZsXQ/kcQyXen2w=;
        b=ZdnHsKRQFIJhj1AEGpYszi7k8Uf4lld0bDL74qTtUKdhx55BqgK+frQ03JYYQ2oAdb
         ULKyY50Y7ipZWcYZdV6RxZ7Hb6D0wTSHS/Vpnffx389NSaUl5zHJZIP0NXnHT24It/yQ
         7I01qMv71mIKe/Nb5637G5oSaSGL55XT0UKo8WLOggPgqPDxYxgkdFVKz16vZPfaheCx
         nTahfC7V5IpJAwHyKNAmk4nNOnzSRzuF9CT2o9MwmkETQo+UVWjJU/Yq02RwraR3IxO/
         jTkGw6YQlNxc7kDIxACLFG/t0yOxBz/SMzFWY1vg+PWBkx17EbFe9yQAV4g3zLNbix3b
         9vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196127; x=1790800927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7R9IrSos6cqCrnKYU8/u9DylC5NgZsXQ/kcQyXen2w=;
        b=QaVdsxvj3kmuD+hfRbhrl/uyIfNJdYe+QTo6jWUIYt2Z96JETrVVV0LkYd5+JX/eeE
         V23l+ennoq1wQRBx4tC3/yoFCteLHBjb8Lx9ZYifGM/T3f3SwjxHSMqNndsma0NknaAa
         SxtGM/kqKkOl38+mGevgHud05p8FlJFevgY+5OHHT2c2n2wBnCo4LGZ/wqrKbbdACqsq
         CxLc/kmNect8mT2ThTJieiHL3hA2DIVokMggPtRKhq4hBQM5GeSX/xbnpfMlaalSlU/g
         PJVZ+ltF04vZuhPZk3bh8+Oen2zuby8L5iy0RO6HXwt/sUJuzOPxwtrvBiI6v86l33UI
         BHCg==
X-Forwarded-Encrypted: i=1; AKwUvByl+gFexSOxCf6aysb7MYxartNSdD1ydCHrn6vKHMg+eD6hN6No4UiCo7U6a4PMdaqeZ/Y37JE=@vger.kernel.org
X-Gm-Message-State: AFuF++k7QWN8qHczR3/EawLaElmJSaPP8ynZBQetxW1WDjBJY9eEi6FX
	x7DknAud6a2prybFEzvNhK7Z9ekkKu9KK0e+nW9GkCvV2h7Tv1ly0yUT
X-Gm-Gg: AYBFou29zs24shVFsHis2bPiQeMUjk3i8vFw/Q3wBzUzZ3YXaixFV/26AR+QlrWnCXc
	e5KJblEUOS1wnMcG/cm/B1y0xov5z5wEbgOAWKokMKzeKWXoXzLemI5/OSk531uZlQ2NaV56ny1
	2gyXFMUrlltRzjl4fWr8JnWufnb3tEq5j3BuEqC82eAm9M+ohGkfbpuMcYcv2DjUtFSb4rXyLRl
	YDbfZxrj9JfWRt1OYnofkmbP+aCDacnGu5sRDFp+DHkHOPmzBBG7sssWfNqcaps1eMyj6R0M48s
	jyJqGtryINg1RTUzCtsQqv55Fl3jNdAe1QDL6vm3RRtvfyJ5aJu4vo8Tzwc+OBWHQi/eIRI1U25
	UcdZmCI6syM48OaCX37Rje3vj3XkBjiusFdGlgDcuC3TAVJK/UM0RQV2ZyJBU/BMDS86Gr49wHq
	NUGkvxc88o4ue74x8Ll/nZE/Jj0LX/le8T7Q2JK1kfLGHxtf4GSj0gBjqczUcXRRNG2SQiIVjGu
	ikH2/1NaDZH1NWRX6xC9/4SCr8fyMjihFAclmY5JOK7KA1qCH0H0aGEW9xd2DUXeloJkmNZ2VNX
	Duu3s1IMwjc34Ate/Esk5Rc3G2YOt+mdEIpz4HwX7Qn93+yzos4CLWqEVqYarLoVvTL8jrSdOzl
	0nsBzj012RWBs
X-Received: by 2002:a05:600c:6207:b0:49c:fc6c:be13 with SMTP id 5b1f17b1804b1-49fe66ff146mr5620535e9.25.1790196126952;
        Wed, 23 Sep 2026 13:42:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4a2-9601-c082-2dcb-3f3b-92b8.310.pool.telefonica.de. [2a02:3100:a4a2:9601:c082:2dcb:3f3b:92b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4b51bsm67169645e9.4.2026.09.23.13.42.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 13:42:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 7.2 104/438] dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kernels
Date: Wed, 23 Sep 2026 22:41:46 +0200
Message-Id: <20260923204146.6699-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260923140647.476063815@linuxfoundation.org>
References: <20260923140644.756254324@linuxfoundation.org> <20260923140647.476063815@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I object to including this patch in 7.2.8. I authored the upstream
patch, but did not tag it for stable. It corrects a Kconfig default
and thereby enables the DMA-BUF importer checks in configurations
that take the DEBUG_KERNEL default.

Jianfeng has now reported a drm/msm hardware video decode regression
from the upstream change:

https://lore.kernel.org/r/20260923074256.9357-1-liujianfeng1994@gmail.com/

The impact of enabling this by default for stable needs further
discussion.

Thanks,
Karl
