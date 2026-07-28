Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB63CF670
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255013; cv=none; b=EwzL+F7iUFO6iU9t6xwVqdVairUBa96Cre8P7vBwi+shVytrFWEDsq/JECL5sja9Q8ngs7hz7672mEwOe+iCGibaqQ/FxWARlsgNyNXnohsddDSCTQt5iqLGoE31y2prdJLCbhwDxkHm47j8zenEZRiZgrAo5qG72tcn8BHM6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255013; c=relaxed/simple;
	bh=9DgIYCuYNgzGJHFGOESR19THV3AaPoljgY6RVDH6Oak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ5lSWGvnj9+RBsIPcCBtIA/FnA1JENO5f757j0zZ+IhbIfuVSuJbKqBlO3wuBv+vY1xusje2rxpDohxfAnPKVV/6lLKH7CDg101HcyEV5P4TTgwUJyZtbb8VdCYsumDKM5s+NR46Zi9AFxvDyGBBFiWvr1pu89o6Kx67GcB32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns+jOJG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns+jOJG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E57C1F000E9;
	Tue, 28 Jul 2026 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255011;
	bh=/Odllhcfl+ebODxpxuz5t8bxT6bXJ4TXgHBM7rGJneU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ns+jOJG5Gkdhgbm1gU5omcKlKrstMNTkpTeuO5Kp2r5/UmfIWU0gCsZSbKojL3SuI
	 Br9bpQky/avXPP7rPk5kWMo/lCjTg29smO6bYHXdmT2n/4Yc2CHI8EsstsNyubIol4
	 EX92pCg/2edz3TUbxdMy08CVRy4JsMAd4s/kb5xJWyiR6UPbBvYjfC61j7/SPAZ51c
	 qqsssBPAqhwNtZ65GNNqhAp2T/bTDVVYz3tf7FHghryLB1qquzFF3k/nd8hLt5FiD0
	 0LIAoA7LcFSTJHB7ob4mQBBMsWekW64KDb7qK8aO77C0JcPdAQtyo43DwEg50k5hfx
	 v2PyjIIJbtusQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 6.12.y v2] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Tue, 28 Jul 2026 12:09:55 -0400
Message-ID: <20260728155654.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728013551.2982450-1-xb@ultrarisc.com>
References: <20260728013551.2982450-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM RISC-V tracks guest local interrupt state with two bitmaps:
>
>   - irqs_pending: interrupts that should be visible to the guest
>   - irqs_pending_mask: interrupts whose pending state changed

Queued for 6.6 and 6.12, thanks.

-- 
Thanks,
Sasha
