Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB0317161
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612562; cv=none; b=f1pdpdc2Lwtparla+NOsdm4dOFuL3prMAgxVnoq7zmFksZ2A9gOaI5SXoDXZ+amnwd7L0X1LJBAAFHO/oRzpnXML8wuqSSTzbfBfsIVxqOG8J3R2D35i3fgrIFU2BePGuOwLPKhkYi3hximAxeae5/bbQhnPh1A9oIpI4h0DBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612562; c=relaxed/simple;
	bh=fbjWo2e26L2rnYEXwGVNXWf4t6/WcF3EsJa97yrJ7qU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rul8ZXNeh7ZnKj4YH6wslTTYhkEj8zFwT87+/fNVy3j70pxp6qp/yPNI8KKwI9ruQ1OEYLw0H1cpqx3vVaZE5s/OxH3DdJi6iwH1KQ6uxPLHuj4Wou+OZL+jzP2+ygquy9Wq5wthLWMNIjX2NrfI5QO63RLUQwFYvcmpL4DVR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=inatUXXF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="inatUXXF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6E4C4388;
	Tue, 16 Jun 2026 05:22:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 836CB3F915;
	Tue, 16 Jun 2026 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781612559; bh=fbjWo2e26L2rnYEXwGVNXWf4t6/WcF3EsJa97yrJ7qU=;
	h=From:To:Cc:Subject:Date:From;
	b=inatUXXFF3tpDmb4Z76Vp3fGAhdHoajjkar2dipUMDgH8oVctJBZStx839tQ9zegZ
	 BDdZtQlNBRtTJzPeGEATiYkpOCjRkpWL7W8oXe3RxFS7C9xmIXeLTocE1PIlfhNKVr
	 78g4UC5mL4nxTdll1cRsDvAqEuyDvUNmFi44aeI0=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: catalin.marinas@arm.com,
	lee@kernel.org,
	mark.rutland@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 7.0.y 0/5] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 13:22:26 +0100
Message-Id: <20260616122231.237216-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

This is the v7.0 backport you requested at:

  https://lore.kernel.org/stable/2026061658-landowner-dangling-5d07@gregkh/

... regular spiel below.

This is a v7.0-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
recently:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-7.0/arm-4118414/backport

Mark.

Mark Rutland (3):
  arm64: cputype: Add C1-Ultra definitions
  arm64: cputype: Add C1-Premium definitions
  arm64: errata: Mitigate TLBI errata on various Arm CPUs

Shanker Donthineni (1):
  arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Will Deacon (1):
  arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

 Documentation/arch/arm64/silicon-errata.rst | 48 +++++++++++++++++++++
 arch/arm64/Kconfig                          | 38 ++++++++++++++++
 arch/arm64/include/asm/cputype.h            |  4 ++
 arch/arm64/kernel/cpu_errata.c              | 34 ++++++++++++++-
 4 files changed, 122 insertions(+), 2 deletions(-)

-- 
2.30.2

