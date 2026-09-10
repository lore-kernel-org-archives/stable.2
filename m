Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B51360EE5;
	Thu, 10 Sep 2026 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019154; cv=none; b=HkebrKajKIWz3Kx9KaPSYsQHXIL54l2wD+xJvjVFx3YYQnHh+uTgFMPqTZj2rWl3Z0A1uGgCd9lTFh2MZKBsWg7rfveUO4dgi7csAoFHCieeWxHqAO0H4HgLufn/pM5quAEnba8C3GOTE+XAwZQMdr4B8+hESUmzPaYR+QiSXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019154; c=relaxed/simple;
	bh=Yx8YvECldfR+xFyvuNIXzFxBIYf9d4aDx1k69/U2gc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcfiZ60+weogS7K6lVIGleV309zVGLHFBCO3WTrwl5nrOkE1X+8VJ/LvtmlIP2m6BlFHXiwANipA0RBZt9VK6pVWbvSR7kK382RCbyK8NXXATluWDiYADCh1L0BpOz+pUwKZgbBkVv/4AvVvYuSN3bbG9z3Sc75KcV0Je/aX9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=CHcLhKiB; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="CHcLhKiB"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3b9ebc8;
	Thu, 10 Sep 2026 13:45:44 +0800 (GMT+08:00)
From: Chunfeng Song <springbreeze@stu.pku.edu.cn>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	rmk+kernel@armlinux.org.uk,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	fujita.tomonori@gmail.com,
	tmgross@umich.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH net v5] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Thu, 10 Sep 2026 05:45:42 +0000
Message-ID: <20260910054542.163981-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909.164909.180036819630013679.tomo@flapping.org>
References: <20260901143251.136378-1-springbreeze@stu.pku.edu.cn> <20260909.164909.180036819630013679.tomo@flapping.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089d9bfc503a1kunm0fdda2f8183bcb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRgdVk4ZGBpLT0JITUsdH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=CHcLhKiBmfgJvNm2CUyOV05crl00YlyYstLj1mH21KmH8ZHP55Vkcpfn30zeomZYKq5Yzk0gVXOfDmf/Ohk3AnlMSQz+DiX5XZK/uKFyFmLbxNw0td9bZzot9Sp8vw0O2Ey1K3/k05/BE9j7ZfnQq2d9xnh66LiTnGE0kmt7Qn0=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=iTfyA4evkMqAmSmWoXKCfGcAZFSMKOiKgmNDzJu5slc=;
	h=date:mime-version:subject:message-id:from;

Thanks for the review. You are right on all three points, and they are
addressed in v6:

  - The commit message now names read_status() instead of the vague
    "link-change handling".

  - The masking claim is gone, and the impact is described correctly:
    since ax88796b has its own driver, phy_attach_direct() leaves
    is_genphy_driven at 0, so the broken is_autoneg_enabled() reads bit
    13 as 0 and always returns false, and read_status() never reaches
    the resolve_aneg_linkmode() call.

  - The SAFETY comments now justify the raw accessor calls themselves:
    the pointer is valid and there is no concurrent write to the field.

The v6 patch will be posted as a separate thread.

Cheers,
Chunfeng
