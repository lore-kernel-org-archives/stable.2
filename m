Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438085275B9
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877478; cv=none; b=JRsJKakYb3A+cCBReyupx0aisfjhkIF/pejyt0hTxQlkNSpDXMShl9zVYsrHNgqS4usA2FxeyyJME4LV5NwgeyyUcdZ7p0gciqwZAN18H2C3/hooLXAC2JYVQ7dyjvYT6FFYDZoF5iTbOqdGycktG+Jva3BHvl2h91xgZpbBqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877478; c=relaxed/simple;
	bh=wziKKdMlD3hcI7MX5wQqpzq9dm/mx6FxotMLX0ZW0Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tcwRdV+cbbECtOv3v0Mj4A2UJrvuz0kHnJz/wsjbm4dQvRHYoDBb1QDw/czA9PcDJLWOGCi70pFbPr3pu+etYuiVv30CRysdZkTqmDqHgU5zM1Pee655Pt1JnodQ3B9aFASQabqXUu2f0I1RJWDnEdlqK2fwu8urHh9EbFvIzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUmd4VUj; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUmd4VUj"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so57745536d6.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877464; x=1791482264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LidMRNdI/T2ht2GtwBzMBnzfJUDX6P9vSM3+ZvhmuPY=;
        b=JUmd4VUjZf5UGQEHyg2v3EtzBn1CiIoQfcQ9UTVW0xdLgelJDEOQ1OOu4UEDCaFkxJ
         rYiKw0lACoXi9hlsfovaX0OQYin2yds9rVMvF0ntKa8Av64XoTr7Dxvq60WNW3mhfeM+
         7HGQ6pSQ6BBBCKQNIfTL6cnz5mjQy+Hc5KP5l6KUlHNduhLbPSjh8YJXW2ziWDy8evvq
         kQkuKMf02sP4ccw/T9FwkSZGBhYyVl6GLvifWg9Hkfgx27Uz6QIrO8Tqa4/ioJEaXKM8
         tGQTpfelkJzeV87N94YhXgl9Q1EOXwCHl0l5uTscPvfoCm4fh+sJK0pxJZwAe+5PYPhD
         u9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877464; x=1791482264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LidMRNdI/T2ht2GtwBzMBnzfJUDX6P9vSM3+ZvhmuPY=;
        b=cfvm2ljiDzEZMDqtb8TEdiBECw8FpHQ8nA/1uMJlJ1HdVhkYCbWppfEtCOMYRXVhJo
         m6zpUl/12ZC8pQtLrAuvKK7561aWmgD5JJ5HLZuhT+/rMTKyWgouKUsnfvQuYxmtLnug
         FmhrmpbJ0cea9AWpYnwrCPLrkjBHORxvysPY3PFIwPJpg8O3P7ZCFRTS8iRON3esqnlg
         /5fzkPv8Aw9HSfsBK0MhA2bEJ5AhVO5LobNw2++V2R8wW+QK2QmqbEOgfSbIbZ3pu0Bz
         mv/LiaaJx0dg1zLNPx+DgWJuIeBcthsh6Ambz8MbVuZeyHKGu8Dy8cmrmCzGQO58RTS8
         KZXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwezJ0ALcPHBrgEpJ13PsuJDhB8HnVlH03z9YN9Z4NVD0f/rLqYzI7WKymIE+SGeL+H8MlKAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ98esmekAX1vcpmeZxBoQnQK/iBGl0djgugVM6cv4P2JnwPZj1
	SStIyIqbVEOxE4XV7AZl9K1xdELEvrcltmM4YovMX9cpjNks6LD4xPk=
X-Gm-Gg: AYBFou014QLTr2CE+zOestKoYIAW59RPjBQHCBhtRT0zbdaQtvay1j8IUS20Wf2VbqK
	VdJvAYvl0hETcTT5cRVYm/EnfP8dGKnh0EH/iprstxGmwtWjwRjL1mrhIgDfebY1haP64piACPJ
	gf2NxhJCha67i56hQe3uBMLQ1nEBrXoXsHdcZ1CrS2IZWk/bhV1ryumea5wHaVqPrTghDu2qpsk
	mCf5yI82DjglaeIqkuRHnY4qovc10h7jfcrnTzApZxn6u7g6tvUKChKnUi1lfo22SpU3hxPqex7
	7Ey1oifG/gJXosy4pVy9fwPzEFb8MoV/MTWvMaw3DdCXOWe44sWvgvq+VJoKVtaUFQZwPYaGegp
	DFCqgo2/33yTr5Qh67WuYtOYSoO0EIkGdKPJfkfnFZgcsp2asudeLYzWRnQoRG70UGTRcIDbXu6
	NaW2aAKlHGw7Z5Zk+IjUhqH+nwa2SnXBaymcyicehNP04/ROL9q2FmfVZhFkDMsI1ckW+REEqpf
	t72hvuJRFAxjGsSf9ic0CdqTopAb58iOuKNvdLmCBNv1pru4puE3lX2fpxbyzHwasPaS9OaQBie
	7+qhOUXfy9MtShKUkx++F/QhS4Lf
X-Received: by 2002:a05:6214:5284:b0:917:a742:47d with SMTP id 6a1803df08f44-917c0133a38mr4412546d6.25.1790877463842;
        Thu, 01 Oct 2026 10:57:43 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a9800dsm31853976d6.46.2026.10.01.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:57:43 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ming Qian <ming.qian@nxp.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Zhou Peng <eagle.zhou@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Shijie Qin <shijie.qin@nxp.com>
Subject: [PATCH v5 0/2] media: amphion: fix VPU core lifetime during teardown
Date: Thu,  1 Oct 2026 13:57:35 -0400
Message-ID: <20261001175737.4048254-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vpu_core_unregister() releases the message FIFO buffer and VPU reference
before draining queued message work. An open video instance can also keep
a pointer to devm-allocated core state while sysfs unbind removes the core
or its parent.

The first patch drains message work before releasing core state. The
second prevents manual unbind on both platform drivers and warns if core
removal encounters a live instance.

Build-tested the Amphion driver for arm64 with LLVM 22 and W=1.
Both patches pass checkpatch in strict mode.

Changes in v5:
- Rebase on the latest media-committers/next.
- Add Ming Qian's Reviewed-by tags to both patches.
  No functional changes.

Changes in v4:
- Resend through git send-email after the v3 Gmail submission altered
  diff headers and whitespace in transit. No code changes.

Changes in v3:
- Resend with intact diff headers after the v2 mail submission wrapped
  the diff --git lines. No code changes.

Changes in v2:
- Move vpu_core_put_vpu() after the work drain.
- Keep runtime PM and mailbox teardown unchanged.
- Address sysfs unbind in a separate patch.

Myeonghun Pak (2):
  media: amphion: drain message work before releasing core state
  media: amphion: prevent unbind while video instances are open

 drivers/media/platform/amphion/vpu_core.c | 18 +++++++++++-------
 drivers/media/platform/amphion/vpu_drv.c  |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)


base-commit: 4a069a763e8a86821edac4159f7c59a20015631b
-- 
2.53.0

