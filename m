Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357183B9935
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787105423; cv=none; b=lg8jJts0H+9S6eKhLfDrM/EKX11beGbV9JX8qGv0FHlmGeJ7+BGypLMql+A624j8g4fDKyD3IQdIiuOKCSDSHd0QnhxjmmV7f7xWEkwA72USushCVM3LQ+/bg3sDKhSpDl37+wRaYUbpNX1DnaIP0SkWDHMOniML4X7hPp5WXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787105423; c=relaxed/simple;
	bh=wo4Q65uqCkTehgvGTLKylq4RWd/z0F3+iRJ3VNvrdN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4In/hSQV17d4CzVtGbVtvnuugsbvZcUB5NOpPhfw90HOxWMdmypCWeYIX00nLGVBGvzNtHPDf4Om3xL/mgpXszP3mHboPbU5vHYUIe5QEGT+kXJtaAMpAj4a/uRch3vzW2efXJaT/MoGW/XT7Mei+DIq4vT0CPtzAJTgrZ2YtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=kNW36Qf/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="kNW36Qf/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e347638adso669450a91.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787105419; x=1787710219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wo4Q65uqCkTehgvGTLKylq4RWd/z0F3+iRJ3VNvrdN8=;
        b=kNW36Qf/dhKkB6jH3FPJrpuQkryIilPMe///0XomJnijBEPQHkzlmIY2/k5ozAtRrg
         CNupq5oLDpk+wvRhjQ+KFxT+eYv0Kn7QhdrbpHsYTCsyAhzdzrSGsjr4P1fhp8nMMtAA
         9UJ/HbdM6MJjkzhiYhacGjoVifmfHzck+wismufg3fvSH1mZ/veUvkGtjLocpZFEUeg2
         4BQIylmUZJ3fleZfUJGO2hhSkGYrPw8uLLVQU0UC5+twoq4xBgXt+GGx1+bZZmVz1+6k
         XoFdG3j+f9AI5rkgOUUJCNfOr1atZsmIc9Diotn4rN75DMk8b6FHH6rT5XGaAbOy7Bhj
         Kn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787105419; x=1787710219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wo4Q65uqCkTehgvGTLKylq4RWd/z0F3+iRJ3VNvrdN8=;
        b=U5W8ncJxSSrcgioPTMMD+E92JOKYlPVCnv2iC2fCUb4x4UtNvsznJ8Aq6+zIkTlKJb
         pOkgg11j7+hfrsxAJLqWI6ewfBerLtC/rSdgtgB3LH1HRX9P5LKFsE2L4viV4RKa8cYg
         0WUxZM5suM1x5PIJMwG43hCeGU+Ylzo3RG3aEiTFJhwiWRg7RbMoBiBUWp8Q7RKxMoCs
         cMU6qdorxDwfeB12viSpIb3X+PoBqYtR1LmFHIcQGEDpnDdMCsoYSfRu7qySYGU5ypA2
         DjS4W7bFc9vg8MgVPYgypZOZk5pKsmmfW/9H2FLVYuUGpvzPAt+bzaoO1cD+jkp/yOo2
         vIew==
X-Forwarded-Encrypted: i=1; AHgh+RqVaMxl+sPMtayS2cr92OljnGlR5e7kBlASjUd5VThfGhKYY021gOmekbpqsJgHia0xdukmtzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLuVLY3dbEoI9pU5/LFehAy+Y61EnOibLmLN2w2b8rkERUGp+
	6Amry7i5Z1dSQ/K0xS9dyckZQZ0j78JCZWwbOABk97TjoD7ZazFEYhi05FKSIedG1MY=
X-Gm-Gg: AR+sD13ryJ8KrDgSE38d5tEFlsya1DiGLc/hZmP/d8Xy0t/ZO2G8BV2jzAzs2l+4nRe
	3j9kvMKBBe9Ilgob2MTCAgBAimP/uZILpOLEm3VzBclRiMvUhG0H0lT8JIBIv2rnqWi9BQpfNy0
	ZldJZzAkGHcDdXlor8AKOU6xdlh/jBDSOZm+3xkd5v8MscXEU6luna/C+koPCm2xby69BVmjsj3
	xNXABwTP3FVcdOIAoKH303L3VItQKsjlOq0ZGCkZZIsI8jdeGluYq4Ee1WnEVQ8WfkKAycmT2fC
	u03eaPnMpA34w0+ju8vbEQLHjdGgbukPQAihltrkbHSJE3IRsl6qTIdWkmMoKiBfduGB1FdNbw4
	qFkJRMiDHxRF+2eO6E1wABacsr2mcW093vBfV7RzZu4ZHac/YlgooI3IAG23P+mpELeRowRVnU3
	AI6+PMZkmmhmHotAFvOXxZFZbxVW7CFXWRlayasKvju5s6c4Z04gOmG23rHJ28/dLLR9QU
X-Received: by 2002:a17:90b:2241:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-39581228dbdmr2141544a91.16.1787105419152;
        Tue, 18 Aug 2026 19:10:19 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96cb76sm770351a91.1.2026.08.18.19.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 19:10:18 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: bvanassche@acm.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	linux-rdma@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] RDMA/srp: fix use-after-free of a request in srp_destroy_qp()
Date: Wed, 19 Aug 2026 11:10:11 +0900
Message-ID: <20260819021011.642747-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3ca5809e-96be-4073-8596-4ab53d72d6b9@acm.org>
References: <3ca5809e-96be-4073-8596-4ab53d72d6b9@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My answer to this went out without In-Reply-To and started its own
thread:

https://lore.kernel.org/linux-rdma/20260819014815.642500-1-yhlee@isslab.korea.ac.kr/

Best regards,

Yehyeong Lee
