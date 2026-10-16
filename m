Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28B447220
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176480; cv=none; b=pdiBH1XhcVf9Pwoq3gdSShbjLZunVlDC5Q89uk88Mt7nXMRi/Ko2I8/p+pinE6W9NC6pNyB7dO/hZL2tdhxMEALdl+WILwYqe9ezlM4KJHWnUKfrHikSGVgsgNpU3gYvyi7iXwLkjom2+DXRR+hwDEir2P+2y0dEpkQm+FDibWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176480; c=relaxed/simple;
	bh=9HaWzOKfnpaXCLuhegUHtmuWqks+3jlaF1gMhEmsKRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fM9fmHjZeC+fBYAqLXLSQNNOFFt6ZgI2op6JcGqKIEzcKlXis0uKgMqIRgToxTP1cLIC0eLq5mDSL41TThTxaqztSs/BVD4+Ujw5fMrOgylR1DM+6kC2Oxbv3BfXXXSysisvQfbJ4OqP7KmU+QPDFSGkuiCDcR5WqoI7cdP174g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=cWiGq7hH; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="cWiGq7hH"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so236569eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792176478; x=1792781278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ic61/wqBGtfRXKsiAxz/tXXdVrm+pW2y1wsldll1w/I=;
        b=cWiGq7hHOnIm3ZX+xWXvn1LLHgSwL29Xd8Ej38K7tW+XFEWvPMBt8bSedxyBPDhbGn
         tisAQVd2r/5sXBgmzgVnMEhRB3GqCcLrJxQQejVt8gVehlKNcB5IFHqREwBli4DFX3J/
         a3X8NPtVFz6YTbaXOKu9RHCcZIo4ajWIjZM1rTZb8lwGi7cUjeci3SYwdYYBR/f/Cf0T
         eeOk6ap+0Ldgc4OTRg6m9zfoDAd7521NrH/3tNwT96ZvzOl+/piScRqRFNpe631wfG+8
         kbDjRHsRLSKjSYlfaVafg1xM1y32bflyCrD9VMZEpNzABGZ4rjllp8TgqSCQ7VN2czXZ
         PQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176478; x=1792781278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ic61/wqBGtfRXKsiAxz/tXXdVrm+pW2y1wsldll1w/I=;
        b=LFhGlCzIjvaMksdWOm6s+x3BnZ08qfJ+mXNmOHLcuXvTKTgPuVH0/tgczJMf62m30j
         k4P4FdRg6mC1r3z94gs2Hb8mCvx8dHgax7DRqgiKFvk7UidQ0+QOdqZg2TdmOIsMOz0K
         OHJe+Cc7QnlyuJvFHqblsE7M/2vQNBD4N4+4s87+eozQFB5+L9vjinBWmoY23frkl+a7
         TgQVFT2vfJlt+WbUkMlv8aj95j6aeTkfI18EubwOL8yFunJ9NfcaXUdYuWXKfYqdLtMU
         HZOp9tRasr0a/od4a7VI/nQ9qV+Div88K3l7BIDpgeprXcS+MmPye8GdrNypXj9E2Khw
         6T9g==
X-Gm-Message-State: AFq9FYJipSmpwA+WMf1yFf3jppf+Q64U9oQ//TvKgAdjrkKgu81Qn3Fs
	YLdSk2LxeGutWzsjxuCt3vXKpXE30zlrKjzaCpRehajPbZUd0qiv6StxhNDW+h3b98axP6i8bYr
	xHOTPzBRBwQ==
X-Gm-Gg: AYBFou3HOZumazMTZTjSH2R40BZvEHCmgII92rjBDzfED5GxqiOeRgVNxgPZlm4BJm3
	4BVL23d/El52/UPNTZtJxTDlbemheYwEmZ9RogkBaweQ69lLyHwN9RKtOuO+zRj3Ol5euu+uNBr
	04vDtg83ujHtoaBT4/gGMZ8KuDuJIIiSxLuRqvtqTXfEjGcvVSq49GclhxxNfBCLr8XY/siTtyi
	r1cC4BB0iMQoZ2g+mtlF82KjeHUgH+Rk/6CsTHhSOsTbHkkA6pF9ieRGKtAoLKi81tjFLN/6yMx
	45CYy3YI8I9vjBpuwk6mpzMhYYl5y6XeJAzI3gUt7+GGrmbuhiI1eR+ahlSG+9YJT06SEZN3wnd
	twJmChJExmmZBRReFxB1/6KNLFOa+L0CnJ+ZhZ52e+12PLUxAb9ZgHunUoX9o2mrOAVAIhIwtzP
	KyFW3TZ2yRKJpbB3S0SqGQGqSl5gFseJ7KL3BjYtYJzvbDHnR7Y+l5IZnMqByMJM6FaLT4Eov2n
	XPBZ73AOlkFzCVW9CYH3LTISzoF/OUZ9d1hDiGvXg/ppqXbTogxOUo7oydXxPmJABOcqTR6WcYA
	vbpMZw==
X-Received: by 2002:a05:693c:62d4:b0:35f:2349:a570 with SMTP id 5a478bee46e88-361a2a3832amr578015eec.35.1792176477713;
        Fri, 16 Oct 2026 11:47:57 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:85ee:eb9a:5637:424d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm8004502eec.22.2026.10.16.11.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 11:47:57 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 0/2] CVE-2026-64017: backport fix series
Date: Fri, 16 Oct 2026 14:47:51 -0400
Message-ID: <20261016184753.27189-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2026-64017 to 6.6.y.

Apply the patches in this order:
1. blk-mq: pop cached request if it is usable (fix)
2. blk-mq: reinsert cached request to the list (correction)

Patch 1 removes a compatible request from the older cached_rq list before
preparation and QoS throttling, then initializes it after preparation. A
plug flush can therefore no longer reuse the request while submission is
in progress.

Patch 2 returns that request to the single cached_rq list with
rq_list_add() on each of the target's three preparation or merge exits,
replacing upstream's shared-exit handling.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y).

This backport is considerably more involved than usual. 
We performed runtime testing to check validity and stability,
but would still greatly apprciate another set of eyes on it.

It was runtime-tested on v6.6.158 in a QEMU/KVM guest (KASAN, lockdep,
hung-task detection) against an unpatched baseline: blktests block
group and fio on null_blk (none, mq-deadline, bfq), virtio-blk and
ext4. No new blktests failures and no kernel warnings on the patched
kernel; no small sequential write throughput drop over 5%.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
