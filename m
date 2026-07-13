Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829F42DFFA;
	Mon, 13 Jul 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949882; cv=none; b=F25Zv9HaoBCZThxTvUUEEL0reBxzKKx0+UmtClil6yoOCtIawfQ/PAgg3JbB1/nb6Cl97rULOVvkFu3QreHlVbaWZggoH64Y+K0+xslovQloofvRE1eL2/vgdmKOBe54an97lAsaIFTDuwGbg8lPry5Gttidn72LSdkHXl+HQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949882; c=relaxed/simple;
	bh=2DBiqKRYqbSrjzVq5ZSkTZf5cQARlCrAG2tlIQmkq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIj6HQZWTSt58wULaj0rD4dUog5DzHvJznE/BCzILNkJcGGVeP+4fl0dvUoW36jBsZpo/1d7xOBGoamO9uxbBM0QWkY5Ny6toOowi+8nI2ExWjf1wxMg50zmQc51dkDZdnQRsAXYhXM+uyFHSzKZOMYOoBYQtY9L4f5cICN+FaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=1CBCtny2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAPpN7JB; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="1CBCtny2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAPpN7JB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 6F3CE13000B4;
	Mon, 13 Jul 2026 09:37:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 09:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783949879; x=
	1783957079; bh=/jud+WB3AytPcrI/2OwbTXS5VtUrFeK0EaGOk27FRSs=; b=1
	CBCtny2sUeZcUKZzUvYEt2sflm/YrEJ9hVbpaKStmQ4kie1dy83JWOUfkKqzbCzs
	5DTm3ykPAJjOM3Cs68kpziZ7Oga9hwdb52ApPWv0mPlluTWUBL+HPSDhmiN2jIQn
	whU8SFKyCaA2RGn9/PrYOEua/MLcdmvm9woH5bj+clDIdMWaMN4Te/fv8a0Gz6ps
	Wy0jKFPYa6atsxLwKcTQsmYY0Pk4qSh2f9VWtxC8sPP4v0bcVjwXNeBHihulsyVy
	jeYB98QB+cflaNUnmRCLN0OGwZYRt7UKHHHxYB0U6xbyKre3yxpX9AnbfLnv0qiz
	VapVQmZd5plzi/2pKI5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783949879; x=1783957079; bh=/
	jud+WB3AytPcrI/2OwbTXS5VtUrFeK0EaGOk27FRSs=; b=jAPpN7JBwNF3JRq91
	/dbGeuHMQigIlzcMSyf4oIjLBVOqefg7NepA4ek2lzIZh6ZLdYczS8YwS+iBAWR/
	wj2jfm4YM4pkwC5cYf59DdtipCt59BNCPAkqVdeYEQvnKvjCqSLu40tBCBTB86x5
	kQbxjzmAgD+1NEQN5iDpY8affGUmmKSFKNu50gvFCc8iEKMPgPogEIBtgZIiatXQ
	BRKX4gSW6ghXD0a3a7/zVgSXxKkAVJsoemUpHVs6g6t+8wmG0vWQLraWUBWRx3mX
	KPz/vjdCC4FBi1cZjJ96egZJVNLon71jLSWOWgl/V0yLTQLRzgvt7Zo0UGjxYR9X
	CyweQ==
X-ME-Sender: <xms:N-pUaiVPT8dNph93HMJ1tj38UzKBV8At6gZg4MyS8RmCaeTDFQzf3Q>
    <xme:N-pUarxHNEDoREtShl9hEQDWH-Rle40sjZLjs1wmhkcn9cU7KofOD-LdBUW88K__m
    -47MUY36pO4vhBa6s0ijJcsmFKlIw840jaTNd62I5BeCUIXjreA8vM>
X-ME-Received: <xmr:N-pUaq7rvG897rW2EOp-15sa-05WeyPNwO_YtXqKq3dREqvG4um7obZfI_yhWw>
X-ME-Proxy-Cause: dmFkZTEW6S1SvXSlZs4OOnc4VahxjW69aaGDPVJd2EBjsmGIohL3aDaqbSu+8YkVanPFjR
    tgfQDCCpmX969bn/U9UO+n3QFXz0q323naPF4jWiHMmRntzGcQhp3Vx2KAhMBucKBrMoVj
    X5CwYvbDFJlTUkQTRAgKvI65LvTaLY14waW97LrBigSnkpE1VVt9mBrvLTUpmoEfS6d4eG
    NKQd5S3QFjNq4Gy3l1vDGekWs+36+zmLytr+byevjqc4klRvGFU3gjURfoh9Tfq4eVG+a+
    Cgqgl3n6aDHjUo+YCrNUfd8of0qgvvgGYEP4z2EH+IhHTWSStBT7XqcjOnyMOC1DkjQYFL
    oAfg3QAucdYxGUn3jeVN0nxN4p7Xq/MJkY77NT8/xFh3P4Vi+v0hufh3nI82OzyTTo40PW
    mZg5tjU+tSZxmmoGCoIRSwrctX05kHi86z/I6Xb9bTvTe6edRxxVRfANp+uWOow94KtKTF
    /wXlv6CTShc0eHn/oRi3jHPlNMsdTO8n/e9zzGnhGcHqgKR7O4Yc1Ioccp8iL9BhkYWLQj
    LZDFEMsidCliTk8kA7CZ1rF+6mZ979Mc5Q6TI0H3Zygtze4Eoov2WWTeueStqcIgEcAFNl
    6soFzwY/WC2VvlnBbvlR1JHJ4POS4leBrjRIhWgR+fsmjVTcXaekUhRwN/HQ
X-ME-Proxy: <xmx:N-pUali0X42g355dyDA8Ra7RdSxvEXQyK_SJSQ-gEDtMIysBSD2Cjg>
    <xmx:N-pUati-qCXdA3jnh_RekQiZbXj_upWpADKU6yA_bxtmYSk--cy1Rg>
    <xmx:N-pUatn4gKnY01SEvJTHo4WvP9XHg0y69j9pGbkCU4ebQz378d9lSg>
    <xmx:N-pUatGGg2_5hzEEqzhmYRqSeMHtGj__9keVbq1AwFUhksnFEQW1Vw>
    <xmx:N-pUaquuWjfjsmIM4HpYYB8WnxHw6kJ31STQM5wH2tObCDsVcBmDMkHC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 09:37:58 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v6 1/3] x86/tdx: Fix off-by-one in port I/O handling
Date: Mon, 13 Jul 2026 14:37:51 +0100
Message-ID: <20260713133753.223947-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713133753.223947-1-kirill@shutemov.name>
References: <20260713133753.223947-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:

    u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

GENMASK(h, l) includes bit h. For size=1 (INB), this produces
GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
bits). The mask is one bit too wide for all I/O sizes.

Fix the mask calculation.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 29b6f1ed59ec..b8bbd715fb62 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -694,7 +694,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
 
 	/*
@@ -714,7 +714,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 
 static bool handle_out(struct pt_regs *regs, int size, int port)
 {
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 
 	/*
 	 * Emulate the I/O write via hypercall. More info about ABI can be found
-- 
2.54.0

