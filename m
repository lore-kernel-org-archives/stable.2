Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028780;
	b=iyyPw39vPa9+l4UlAFNyouFPvDI+Hbdri/h5ewnQJzIrK/q8p4qZ904yDjMk6SDfaX5+
	 joTaSf+5b7FONnXZ3Yi8ES6/TP6OIyZ1+7EOmKIsv1vXsMsjGdI3wNTJEMbMOmzuny+N6
	 m8eWSVNai0y8VG2xvzDBWpaHczlWvgW4pkZrIugUurnIdC7HuGTwsyqTtkDoeAFvWwpV0
	 rVAUxOBWnG6sLx9v9ouwy/M0zGmeL2FpOf+gmfhAgt/3qFV+EE4jw2luD9lZdDSfDDPA8
	 Yy1IxYxKte/wHMvzY9E+sLKR637ZJhuf8RsMItHK3bXYsZwD/Mrj5REugW58lxfJ/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028780;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1L/sRvLXXTsA81LJd54Ga7im1P97da+8ZFczaoojjT4=;
	b=dKhqy+C/lS7rhUgh9ACk6QNfG5NoH31aAzJQ4u3W2MCjoiaZgFgQojiyAjQH6Ww1nN9x
	 gnCVq/9mDpf7yju+l6drRxs+4KCCTmrGX6iJwaxjFa2kctypJUHMJnsgcZQ4d7FxALb2F
	 cSzVarFG8SPIZ4LYPVvF0Sh9gKuAj7PM9Mz1KbKZWHfGZxsOidzM1YsB4WbUYxDE9dPt7
	 hAwvo8wsvQv4PK6Z7OWvA+BXbZH6rwsqZIp34fOJW9KIoTEzjaaJiQqTkKGvg7Rj5H7kG
	 HAWCZN3Mxpcq/mmEsoc+LrcnBOVTXLXMABYvObbw+kRz8/ZSvRwAcVk+yWM5/dtkjww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=LEXAjWIR;
	arc=none smtp.remote-ip=115.124.28.77
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CA606A31A;
	Mon, 26 Oct 2026 15:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 048CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=LEXAjWIR
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793028775; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1L/sRvLXXTsA81LJd54Ga7im1P97da+8ZFczaoojjT4=;
	b=LEXAjWIRqKoe9RUBnHSGTolAlfutbKEPwLCve+dRKf4NnI8crAgT31fR6xeU224Jq31/6B1Yfz3by0o+fHvFClY8rr5C5I7REhGL2WcdOW0DL1z5jFCaoSUptRgZpPNeJ444KoiOw3aTINVTtiiHpb+CmKbQ+YikpqD7Aw8mTUA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08317636|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00846258-0.000433577-0.991104;FP=5752320225235176881|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jq7I2l2_1793028773;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jq7I2l2_1793028773 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 23:32:54 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	mfd@lists.linux.dev,
	Guanglei Zhu <zhugl3@xiaopeng.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 0/2] mfd/spi: sprd: fix ADI transfer length handling
Date: Mon, 26 Oct 2026 23:32:51 +0800
Message-ID: <20261026153253.689525-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to Sashiko for reviewing v2.

v3 only rate-limits the two new invalid-length error messages in
patch 2. The exact transfer length checks and the SC27xx caller fix
are unchanged.

The separate, pre-existing issue about writing back an uninitialized
value after a failed ADI read is intentionally not included here. It
is independent of the transfer length fix and can be handled in a
separate patch.

The series was rebuilt with W=1 and retested in QEMU (aarch64 virt).
The length matrix and SC27xx software path remain unchanged. A burst
of 32 invalid reads and 32 invalid writes emitted only 10 messages at
each new driver call site. QEMU has no model of this hardware, and no
Spreadtrum hardware was available.

v2: https://lore.kernel.org/r/20261015-spi-sprd-adi-exactlen-v2-0-13203b6aef7e@xiaopeng.com

Changes in v3:
- Rate-limit invalid-length errors as suggested by Sashiko's review.

Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/mfd/sprd-sc27xx-spi.c |  2 +-
 drivers/spi/spi-sprd-adi.c    | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
