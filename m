Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08933A3E95
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575071; cv=none; b=S0egiOZ6TKoo6XZbJjpXLHxQTUiM+PIZMBmR8O3ww00jxolifwZ6y9Pi0Dce76Sk/4kAf739gKZWKEJbEoXqw4VxVhrqN2xybENaV1X5FBW2jdQWvjA9gviSlGMutx2lLd4sW3gPNkvGol4f2F+bUnPCfCFb5gKItPvjW2pgkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575071; c=relaxed/simple;
	bh=rgu65xROSdjmMwwKg8YIQlif7PhAj3pgiF80j2ZjCnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaOXZqI/crmIzFae+aRTM6RBNRlTN3aGRwKmO52Ho1nOK/udt/wl7/ZumznS9aTnr3RnTic/NLIhuAA5K+bc4WNwAKk6R1OQI9UAty68v81Dyq2CTjglf0elf/061sC/4mco971XdaJVA0K8eEGBZ973HLX5hjmimbeEslkiyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E315w2u3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E315w2u3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so737885e9.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575068; x=1790179868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgu65xROSdjmMwwKg8YIQlif7PhAj3pgiF80j2ZjCnk=;
        b=E315w2u3x7mEyLAdk8Xpk+oiZOXezh9l3hJV+Ay/1r4Br2eBFs7nfwF8czMWwSiypf
         ez1+f3ajj3o/6EakWSXBY+e1WM8F0fS/CKY4t/lbcLcuHc+om/iDD4hFEdwsmValDaQY
         /pMS25VZBxv+pNz/PTp1Yw7jFHDtdRGT63hNDKDvwYpkbxm7Aoa9LG1VS+V14b56xhVX
         FZ3LcvP/i1mYKxp8gjL5gTaGSKFVMzeO04bALSfBHFrfFIm/M27BLtBXCrqgJMPCdTMH
         a2elfRM+4M4cqoGiK6Gc19+7nXaA+B5pW2u5dSjLDZvWf6vjewdbuR4uexKKtjCvKPhA
         KdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575068; x=1790179868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgu65xROSdjmMwwKg8YIQlif7PhAj3pgiF80j2ZjCnk=;
        b=0WPMgDRkc+xGJeIkeNXH71H58ky51Pa+GV3eSw1OLdmIDj7Df/mVeqAHWaUl9SNL89
         n04ylND3BU1QIKCucLWgLC6CiExL2UwnC6QLMMXlJ9TMmZzeTH1FpirWKO1d9gGZkN/L
         M7VAg6U8DXKU8s/NRlpvyu0U1gVKx3Y+Ri0kWGAhz8bg+v4YuE5eY1kJe817gx8hbdqi
         JlZNaU0aPEKpoBLiO8yR0fjUgf7sk5ZzpcNEuOmmDb5BuOMSShTgpXXoojQqNQFGMn52
         s0HNFBq0vudrj2x8v2R31OgKdigG66hx6mgp06vYSH/t4Cec0SFI14ks59yHWrhjpIw+
         1Jgg==
X-Forwarded-Encrypted: i=1; AKwUvBxiLCn1b0+6R+/TrwiBCJumuZaezFAiWN9VFnk6dmdHoitBZOHJG+hNGsb0uDLcjvMbzHBS/Xo=@vger.kernel.org
X-Gm-Message-State: AFuF++nny84nSsHN10UdnpS3+GAYzZs+AtGLuMG4Qz81b1qXtoezgo1P
	WVCMzCObx5QZwSD4oQJn2xCJKwWWMB33NJjyLp9RM8Pk3Xm5OFoGSmnm
X-Gm-Gg: AYBFou2sRvL6fQ+fKlZ68ZsQJrYB5gWSZs7LjeU8TwqU86gGCbUq4UIn1Gsw2fpjoau
	WsIrdouGs6PwVNEYQmAFrravpwF2SCIHdQ4kI7jfY7CoxR+EMe22qLjl/AHmI8Bu8FJyGOZ9ldR
	fDA3tOGZRWCmBj1P8S2GCTxVCKLl9moOvzM7u2Aa4O8NFxfUOdRlHZkHQydK1P0lxyKcCUzZxc2
	Yvt0ja+Y0Lw/9TBpglbe4IdZdz6YKSBeklmjSTARL9z6DEzrgzc3aUswIvWxFDvgLTsOJ4VF5zK
	P7nCrGx0E6xr4buohrDYgLBPKzNquUErSIJT1U/QFSCaE8z3I2a5QWcNUI9eL1/HlyuXpgV/QY5
	BK+DkqBmbFAzOE5KCT27YXtqr3Thv3DKwu1FBm9Xj7s5HjQn4SSDliQ8Bcd36/rgy3S2AvmybYQ
	MtWM+mHj/45BkiTx1V49SzTFEaYHfqunGDzql6WxnYu3WdLAQSMsYI6ScG2O8Z8EyGpwIbWVTCK
	S2H/oLc7wjw4/AUkYWdduCnLTvBnAYHJl+x91weCj+PygiV30OJyFLRJSj+P1WPqVj6A4udoZbF
	2y4ssJ1OIszS
X-Received: by 2002:a05:600c:5489:b0:49c:f9b8:bae0 with SMTP id 5b1f17b1804b1-49eb732b2c8mr38610325e9.2.1789575067984;
        Wed, 16 Sep 2026 09:11:07 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B8E02002D5AB124699B1F76.dsl.pool.telekom.hu. [2001:4c4e:1b8e:200:2d5a:b124:699b:1f76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24774esm2002115e9.10.2026.09.16.09.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:11:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	jeff.hugo@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] accel/rocket: fix runtime PM refcount leak in rocket_job_run()
Date: Wed, 16 Sep 2026 18:10:53 +0200
Message-ID: <20260916161053.11926-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915041047.1724928-1-vulab@iscas.ac.cn>
References: <20260915041047.1724928-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wentao,

This looks already fixed in mainline by commit 9b2dedadf6a9
("accel/rocket: Fix error path handling in rocket_job_run()"), which
is in v7.3-rc1, and the same code is in the 7.2.y and 6.18.y stable
trees. There, rocket_job_run() already uses
pm_runtime_resume_and_get() and drops the reference with
pm_runtime_put() when iommu_attach_group() fails.

Your diff is against the older rocket_job.c (index ac51bff39833, the
v7.1/v7.2 file), so it no longer applies to current mainline.

I checked this with the help of an LLM assistant, against the
git.kernel.org trees.

Igor
