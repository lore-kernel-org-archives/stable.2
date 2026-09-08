Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DE526A84
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865644; cv=none; b=tubcngzMBRAZl4lHdMy5Chd/HvsICN/E4PsNOaUOgYG0AIg3CpWryAfAQvyjkB/MnuXrDP2LMs+cduTiF4MnRQjeKuSaiJG9msFL0GNAyrOJs7QhaHFOVaCb9ZTm4o83K6ix4dJxua7HY4Mi+/TryoEl0ezZBrNpOlCAtH5hbqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865644; c=relaxed/simple;
	bh=nIpoc5sfHGTXjBAy3ABWY1KxxnQB5xQPhoL+P57mMcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VIR6A7ryKHpWN5zbxBngas37eMIe+ZnPTNFQAdW0PyxOcEfZupQt+aaeq8JsjzNcVPMSmmm/75ymJskuRNtXK2HCGYDTZt+ysN6MD8HQKTW11VxPo+6P/eR0He5flIwgkfTfabQGvzppKOu06DitepS31W4/0nuNILb6IQx1m/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fky8TGAO; arc=none smtp.client-ip=95.215.58.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fky8TGAO"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nIpoc5sfHGTXjBAy3ABWY1KxxnQB5xQPhoL+P57mMcM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788865638; v=1; x=1789470438;
 b=Fky8TGAOiy8DE0IDEkqE+srgvlRiIcysThTrBbw9d2Jad2Ij4Hb3t7FmNUWr5P4pNsDYzFCA
 WQkbeKjliMyLjAQ2HguMBM7+tGzA/BB2sv2+L0Om53PmGughuj3RTctPTFSlFoXOYnsKyq4X+V7
 113EeIvbiHjPNDTofrB0bKx4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6d105b631239bd15;
	Tue, 08 Sep 2026 11:07:18 +0000
X-Mizu-Trace-ID: 6d105b631239bd15
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Keir Fraser <keirf@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Quentin Perret <qperret@google.com>,
	Hiroyuki Katsura <hk590@cam.ac.uk>,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] KVM: arm64: Fix host access to the EL2 stacks
Date: Tue,  8 Sep 2026 12:07:09 +0100
Message-Id: <20260908110713.1540304-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

The per-CPU EL2 stacks are initialised as host-owned after pKVM init.
fix_host_ownership() walks only the linear-map alias of each memblock
region, and the stacks, mapped in the private VA range for their guard
pages, have none.

Patch 1 is the fix, and it needs none of the other three. Patch 4 adds
the check that would have caught it and would catch similar instances
in the future: once the transfer is done, walk the private VA range and
fail init unless every valid leaf is hyp-owned, or is hyp text mapped
without write access.

Patch 2 is a fix in its own right, but to a different bug.
fix_host_ownership_walker() matches hyp text on its stage-1 permissions,
and that test hasn't matched on a non-hVHE host since 7.0, so hyp text
is donated there rather than left read-only. Nothing crashes, but the
instruction dump on hyp panic reads a page the host can't access, so
the Code: line comes out as question marks. It matches by physical
address instead, which is what patch 4 needs too. Patch 3 splits the
start of the range from the allocation cursor, with no functional
change, so patch 4 knows where the range begins.

Based on Linux 7.3-rc2 (df2908090cda3).

Cheers,
/fuad

Fuad Tabba (4):
  KVM: arm64: Transfer the hyp stack pages out of the host stage-2
  KVM: arm64: Match hyp text by physical address in fix_host_ownership()
  KVM: arm64: Move the private VA allocation cursor to __io_map_next
  KVM: arm64: Check every private mapping is hyp-owned at pKVM init

 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 20 +++++
 arch/arm64/kvm/hyp/nvhe/mm.c                  | 79 ++++++++++++++++---
 arch/arm64/kvm/hyp/nvhe/setup.c               | 16 +++-
 5 files changed, 108 insertions(+), 10 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.39.5

