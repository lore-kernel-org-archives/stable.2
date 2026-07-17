Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFA311C2D
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252272; cv=none; b=BQLcJX6KHIsY2rp0ImzVa4Ve1vB8ax7vOKPAhzvIWSx9qZ6AeNdTcA74z+I+ZnQl+lg0MWqxKjio8wfNK27SsYfkNn9kbIrebfUpRzgxWy/uUMtxmCZFYTxu+/xOtwqZ/tKDgjQ6YWr6qInlyGYIefIPOCUMonR37PM+IoE4sA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252272; c=relaxed/simple;
	bh=zTDEBC84/cEAFrg3irrSXDknCyflgdaw/Lm0bEK8+ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAdusKMiKPtS0F4z8sAXrTmBTJyjoDH4a/vjUml+JXKeB3OlUYFpzEBW4j9m2LGuMLcPCp7tIdXpjYsXhxmNqSvnItBvGGxrjr57EChZFQSmF5p5yLGUkbxeFPNOF/NeluETMFalp+9EkhVVTVNe7J07+4xsFy8tKDILsYIWrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdj447U0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tdj447U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86851F00A3A;
	Fri, 17 Jul 2026 01:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252271;
	bh=9EUBSZpMnBOaIEKSGbcI129CUm/xtGnKjCdmNO+KS0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tdj447U0jE+/DaQmFa9vgSUqVrIUbS3pqp33SSknuPOSlaHNIptzs4vZKEvTgtNwg
	 NP79eWyWhz7vbcSqagLjHJ9Lf7++A/geM+k+k913Do29MZ+pHV3xFTrr5MSRTipZ+X
	 IBXnbvYsOONNdTw7VO8ZvdD6ab7kPHUs2dAtyMLuaPQmE24ZX2unJz+F/J7WXT5THZ
	 o54lyc7ZWkQLfsFzRkLvvdCigBOxLKR9U19VYUrXsLptlYh64fdIhNLEfM0kYKAiRD
	 gKbOJ4gq1e9FIrrPPtta8/qSuoxORqPJIDkkXyZyvl3bHAtUFbdWsCepUoGzu4Q3OS
	 6EW4oGrz1rofw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@kernel.org>,
	Weidong Zhu <weizhu@fiu.edu>,
	Chao Shi <coshi036@gmail.com>
Subject: Re: [PATCH 6.6.y] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
Date: Thu, 16 Jul 2026 21:37:31 -0400
Message-ID: <20260716232340.0004-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716073452.3246468-1-coshi036@gmail.com>
References: <20260716073452.3246468-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 16, 2026 at 03:34:52AM -0400, Chao Shi wrote:
> bdev_mark_dead()'s @surprise == true means the device is already gone.
> The filesystem callback fs_bdev_mark_dead() honours this and skips
> sync_filesystem(), but the bare block device path (no ->mark_dead op)
> lost its !surprise guard when the holder ->mark_dead callback was wired
> up (see Fixes), and now calls sync_blockdev() unconditionally, which can
> hang forever waiting on writeback that can no longer complete.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
