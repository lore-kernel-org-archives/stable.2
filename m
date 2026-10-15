Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5853C3C3
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077590; cv=none; b=d6nTjjAzMWEZXha7HbilqpsQ1CAqCJy8thel7JtQdcfFWxbU4K1WI7PQm4jKSyMQodywoNQrSw9V2k8s+zil0tDFiiGmxcMp9BLvqLuTFW/iEPN2KC1br7NGXgwkZOxR4BF4cXUS/vvJ2Q8FRAxhWTRrVJQZ85dwx0qfLc7BuhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077590; c=relaxed/simple;
	bh=bEuFPOQiVyy1KX5sOgO4QdQ2fID4pTQ6O0IMMPI0HDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqIayT17dqKVMrfLy18miX3GUxD4csX5P5LB9f2AIesDA8VuRNdrt3flAvXsiWganTZ0rRAIyb5ULcUl2VxJrDvIZD7/9NkE+xgOMAJS2ESmxpiOYiZdV1R4JPA3Dt6kkQfBBKFAlztpjaLiZ+Tl3hpZjdLFdkhwDuNIJSmaI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rquY1iOl; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rquY1iOl"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-144f79153f5so75244c88.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077586; x=1792682386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEuFPOQiVyy1KX5sOgO4QdQ2fID4pTQ6O0IMMPI0HDk=;
        b=rquY1iOlwAtqyt/71W9yojpIgIBne71gySEqaHTRUimkXaf/Yde7BbqHeZNC8h4PiA
         ji7ybfqqwetEyUE7m/QFUbqsunehF3EgKpR6RASegiBV6ahnqOzVw9mllICLGCTYxzyf
         Qlfph33H6XF5cAasuxizHXdoRjbdAfJJxYHvtRxF//JlgA6WoRV0UtnFg3y7riEHIBtm
         uRD0leUkd4HFYSjaVBTewpmiMavApqu3K7CgXintKDuaNQz+ZJYdX/Yff5P1Oahxyqh4
         npuwR+2vVoPq3iHouM6l3TqA89/VEQd6IGcb9eNK1xATBKOu8uWnneklipOCMiTvJ/BW
         RcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077586; x=1792682386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEuFPOQiVyy1KX5sOgO4QdQ2fID4pTQ6O0IMMPI0HDk=;
        b=RSbxglz8Xj0WzuXR8+EeRNG37RL81LNF+eyQ8JW2dMmmq/xLrF94/yT7aO7HqeSiOX
         egbdRzX4TnlsdOn6KfdTy18IcC+FSHGQp+AYYGog3tsuiv2YLBVoYGYnzoU5ZsDSCfqs
         MZb2YSh9eKBd16rfpJQaCP4b13ftMxIDMcLkE0qac5L2B+PkB6HjBwCh1+lyUObh4y8Z
         LNV4/8Aqk2tULKzN2EfJCIfkwvQlysfla2C5hfx1UiS4srFg4yBJUGu+2GyR05w42ycb
         xeYa1CW7DOQc/3nedaVjN0wh7wz3L9e0Ypf6/TD4nKuqnLBSdW/nDW4Yng/gFlO0yXpm
         moJw==
X-Forwarded-Encrypted: i=1; AKwUvBwpFrwQaKldJeyzzNddmGNgufl7INC2aWtilsxYoqdgkjuQMkaq5TfJz9wxI0GgNp5/iIGhA84=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvKBki95X6j/atqOnWoqAM0X4bUrUSJzr4I1PKA+aaFHn/3xtZ
	VbhIoTpK80r6ZZPVYse3jzlh6r6HiFQauwpHLHosZmtVAaRCfUeGzX3s
X-Gm-Gg: AYBFou0VPebhAqviBRhhLBc4awPbllqhJ8PJ0VZZnqSDGqKX4uQpPhEeNvjtykJijoT
	Nf3pCKFUqES4BjZoKw037N+N43vdSSY9d8DgceMemmxqnTZ8jbnMhQIYKbRNP9ZYj5nnQ1grYVm
	S19KZlgBlt7HCz6QGDErl18lXREs1YKCusTmcGKpoOzyRAZWIw6ys1qpAjJJxsf1u+drNi4w2to
	JK5wh0v04w3766YXffMRTCo4vXW2/7V6fB+CjtWtKFoavAFl158EYJ+opUBqeVAnaIY61TWneLb
	Y2sj56pVdpZ4Y/vKnzDfvlJtjIN25s8cv8h4Q8eytgIsSUBOfI1gcxVNkbRv2KBEIppgLVE8H2R
	TeNg7lswS8/7cl0n94znMhn7v37CQUWBsn05mPJAXgSdluyi2t/vBUe7Th9g0+AJ2s0Wqq4+1DA
	Dpw2wnnCHhl5V9V3DxToyh4VYW86PDK5kmrNZJegjAFmGYOOgEJWWBOORWe+nl/l6xeeqhMROCD
	B0=
X-Received: by 2002:a05:701b:208a:b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-1825339eb73mr289092c88.19.1792077586315;
        Thu, 15 Oct 2026 08:19:46 -0700 (PDT)
Received: from JMD ([117.213.200.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm58994476c88.14.2026.10.15.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:19:45 -0700 (PDT)
From: Atul Akella <atul.akella@gmail.com>
To: mathieu.poirier@linaro.org,
	bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] remoteproc: mtk_scp: fix da_to_va() bounds checks
Date: Thu, 15 Oct 2026 20:49:38 +0530
Message-ID: <20261015151938.1331-1-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1791198233.git.atul.akella@gmail.com>
References: <cover.1791198233.git.atul.akella@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Just following up on this series. Both patches are compile-tested only (arm64 defconfig, W=1).
I haven't tested them on actual mt8183/mt8192 hardware, but I'd be happy to help with hardware testing if someone has access to a suitable board. I'm also open to addressing any review feedback.

Thanks,
Atul
