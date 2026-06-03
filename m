Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A644534B4
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484810; cv=none; b=D9KhCWToJ/1SY57WaQkdLKVLLcrnVmxuJqsKggteEx3GqkfVa8V1D9Vmfl1YKyNghpp+LiFadBRBajjs303+SX0iB3eeiXkuEVV205wPxdLjCKO64uCTyk1K+n39gC+27WWfOgxWDrFASnRYmJnlmggcPw/Ocl9gXB9jnxDgdBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484810; c=relaxed/simple;
	bh=IabF/qhrKADpVfYSXfZTKIbKpsiQcARly16NJbg+a/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4Y2psOHQ99u3pL5aSt+/ISmgLJmmq8meE2p/R2sy8lIdq+SjfS2V2w3GXQmVo7xCVoSdm/0cWtcIB/5EYLxWwBhg6Wik4WoKfSTUdylJxxT+lm3uYQnmnWeDhh2DfOvi8W/CezgnsU9Py6hj14QOtPhPfIIldK7cKEV3a/CLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JwLGLwer; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JwLGLwer"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D2232E4;
	Wed,  3 Jun 2026 04:06:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D203F3F86F;
	Wed,  3 Jun 2026 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484808; bh=IabF/qhrKADpVfYSXfZTKIbKpsiQcARly16NJbg+a/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwLGLwerbUUjbzMIgEZSrZfLshH52L5HoP+gseROdIxQBRaPDXse9soqAsuZPpyos
	 Zgp1NYrA9fqol9Wd5l0eW0rZ9WU4Tu1J75NltXl/+X9OF2kGkIW+8YntGay7NZ7E9M
	 5SOk8NoAGEsvnK65j0+XDQeRuzuTrZFyoRx2EMic=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 03/20] KVM: arm64: Don't include <asm/fpsimdmacros.h>
Date: Wed,  3 Jun 2026 12:06:13 +0100
Message-Id: <20260603110630.1027435-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need for hyp/entry.S to include <asm/fpsimdmacros.h>.

The fpsimd macros have never been used by code in hyp/entry.S, and were
instead used by code in hyp/fpsimd.S.

Remove the unnecessary include.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 11a10d8f5beb2..308100ed25de9 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -8,7 +8,6 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
-#include <asm/fpsimdmacros.h>
 #include <asm/kvm.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
-- 
2.30.2

