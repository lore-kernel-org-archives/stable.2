Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081067;
	b=vt59RCeRxkgHcaAa+YnU/LAs2EC/XTvIkpo4RloepA2O7iA/NrSGFAg1Nn53DMQniWaZ
	 QzddOobC9QwZZ5F97qauoNgxMkkHmM78lUaPYCTHgAi1YwYN0VBULFmEiAKqKnht0dShQ
	 Krk4wDC6GHvkoiTU5V3ihl0l+h7gMLXXIUI7JwDU0UXIrut47SAr5IIZDT6GkZi5EQZzf
	 er6U70D/v2UTl/xjDpxzJejrdQRmDRr7AdbuXIoNXo6aloFEe8O4yWN9oIiG7HiAUBp3S
	 Yukri+2zpujGe+yiGkE1MnnI2J11ILwUopMz0WTwuwBy/3+9jFIRI8Ul2Q7E5uI5SEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081067;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=yaApC6dU0pHd7sFvEPl37gN234fN9yV/70NJmvLF6ok=;
	b=2iBYRjcm50Ar/YUWt/vW+pda2wrFssWumca++jMUWpHzbzAIrZCtCc6c99D858HxxzET
	 3+5Njy/5a3rV+/GVQgsrtRegTtPdZjzU+rP7BxEPqH0bS4XVvPJ5hKybfu2V7W6nMq31k
	 wxv6g/O90fzfu6yN0keqOkHzW1uad1A1zNQ8Pny+MKi8UeJRNsSjQcdGsbsI2S1cB51Zx
	 nkgvaFAdKGEFCth1+zklMrlFlkl/BC7kO10JNKybYvuiW688A2KNwqnvxOEJqkn+GpHNU
	 T5tinIjZv0n0fATH4iE3+xly+K5EmlQbrBp3/oeTfjN/oO8nHBJ6B/TDok0j4OfZXfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=n2I3yU+F;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B532606A33D
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B532606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=n2I3yU+F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795081064; x=1826617064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yaApC6dU0pHd7sFvEPl37gN234fN9yV/70NJmvLF6ok=;
  b=n2I3yU+FudMJdk0zMQBAQ4Qmf4jXnGNfbgPo9oZxKbsOAkm4Mw1Vfw/L
   mNMZlP9r1MffZxGhhtapKJ1z2YggB9QX/d3i5w6ICKzkWjjPHUREoe8l6
   ZmP2ccKYsFTMxn1aWb2RtcdzamD+qor0W0sdj6a9r9jAo9oWIiHHOPSgs
   ifPpjkNiX4gvnOKSTnNCwDhD/ZIbsqgNzgpXlbPxHkvyYcwxC5I7womji
   g2MNR/rln3eCww1wvWfiT0k2qlPHIyz0EAVBU0TPozdKxkrh+XmvQSVIO
   E6WScJoCZWYcrvfZOmbNkJ76zvv/zKKu5/1ZgH2qqkyT4M0o5JVOVy0nW
   A==;
X-CSE-ConnectionGUID: RH7wZ7VMRcy0znrKcHYrng==
X-CSE-MsgGUID: aa+x/8ecRHSu5AC0qhKt2w==
X-IronPort-AV: E=Sophos;i="6.27,220,1787011200"; 
   d="scan'208";a="34545652"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:37:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:29560]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id ee6cc373-cb5d-4335-a538-01e126e61e5d; Thu, 19 Nov 2026 09:37:41 +0000 (UTC)
X-Farcaster-Flow-ID: ee6cc373-cb5d-4335-a538-01e126e61e5d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 19 Nov 2026 09:37:41 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Thu, 19 Nov 2026
 09:37:39 +0000
From: Federico Parola <fparola@amazon.de>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Zhen Lei
	<thunder.leizhen@huawei.com>, <kexec@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <nh-open-source@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] crash: Fix crash memory reserve dead loop when low and high limits match
Date: Thu, 19 Nov 2026 09:37:27 +0000
Message-ID: <20261119093730.49471-1-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On arm64 with neither CONFIG_ZONE_DMA nor CONFIG_ZONE_DMA32,
arm64_dma_phys_limit is PHYS_MASK + 1, so CRASH_ADDR_LOW_MAX equals
CRASH_ADDR_HIGH_MAX. If the first crashkernel=size[KMG] attempt fails,
reserve_crashkernel_generic() falls back to [CRASH_ADDR_LOW_MAX,
CRASH_ADDR_HIGH_MAX), which is empty. That attempt fails too, and since
search_end still equals CRASH_ADDR_LOW_MAX the fallback is taken again,
forever. Boot stalls after the "Initmem setup" messages.

The first attempt can fail on a kexec handover (KHO) boot, where early
allocations are confined to the KHO scratch areas.

Commit edb907a61333 ("crash: fix riscv64 crash memory reserve dead
loop") fixed the same loop for crashkernel=size[KMG],high. Skip the
fallback to high memory when there is none, so the reservation fails
with "cannot allocate crashkernel" and boot continues.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
CC: stable@vger.kernel.org
Signed-off-by: Federico Parola <fparola@amazon.de>
---
 kernel/crash_reserve.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index eee37a11380ce..1417b429b45c6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -421,9 +421,11 @@ void __init reserve_crashkernel_generic(unsigned long long crash_size,
 		/*
 		 * For crashkernel=size[KMG], if the first attempt was for
 		 * low memory, fall back to high memory, the minimum required
-		 * low memory will be reserved later.
+		 * low memory will be reserved later. There is no high memory to
+		 * fall back to if CRASH_ADDR_LOW_MAX equals CRASH_ADDR_HIGH_MAX.
 		 */
-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-- 
2.47.3

