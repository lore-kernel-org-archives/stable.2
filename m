Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042043C058;
	Wed,  1 Jul 2026 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903956; cv=none; b=CS8EopEl1cMuOuWpkKTtDVclXeoAeJ44dzviv6nS6LWAm+Hpf7aYmdG7Xqu8tlq9LPoX3aWQkP+yqsA0a8SZ8GmuOTcKKyPUano3ZgUnUs1k6mOcJEXmLtWelELW5qiRgnkcGyAzpHMuhCRRJXuOAgBtXyBuCXDN9sqNFQhJesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903956; c=relaxed/simple;
	bh=2DBiqKRYqbSrjzVq5ZSkTZf5cQARlCrAG2tlIQmkq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrAoAWZHGIxbQOWG9r494WwJJjcxu5KtW9PJIuAIMyFjOETOdXrLamSJqoh9otpZaka0vqDlbZoNxVqfgtAp88fyuvtUkxg8XiuscOMq29AICa16H0n2bGjnMe0dHZEy61b0+qcsPsc5uZ+qIbQ7vruf83rakbE9ImGgtFa5l80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=GGZsauwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+lE3lp2; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="GGZsauwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+lE3lp2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id B583113803F2;
	Wed,  1 Jul 2026 07:05:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 01 Jul 2026 07:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782903953; x=
	1782911153; bh=/jud+WB3AytPcrI/2OwbTXS5VtUrFeK0EaGOk27FRSs=; b=G
	GZsauwnhhEikFicwm8swF6SEHAwl1mssbdphUxnycc8m5NLG5AJiM8wIMZ0MDGin
	ybni/UUBnAzY+LoDHddGfge9HkcT1DLwMjJQwsLZg1NTVl09HRgTK8/7tHHd7SnE
	l4cvuRdYLXS0nO+pn+bByJHS5KHGiFeEIEAApqhWwLDkp1QmjTjyY52jLC54qXQ8
	nqqZ3McUM3zfMDM9jfOngkDwvXz0yNH0BQWgfrseGRc5nouxtZ1SqvH5vZklqHQ9
	OD2mRxL6xfM4rZ8TJnZy8LbTLaFF8L78ZMxqbGSu2UU2sqzemD4bI5/7Qf0aj1+4
	NVOifNop9e3t9c/z39gOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782903953; x=1782911153; bh=/
	jud+WB3AytPcrI/2OwbTXS5VtUrFeK0EaGOk27FRSs=; b=X+lE3lp2MVINHLl34
	wYWCDaLc+L2fuF9YcGiTsUdQz982O7lfIyw6uefnbafgcv2gJLUomnWtT9MTplw7
	x1RNKxM/FHoTTK8+Ah9ZeEqc6bllcnNQYEi14TtT/vAZydcLFEqYQJPI4PQgex1t
	JSHGNtO2bOGWxxURhKQoU3MBEjoaJztAf809qRIGFjOp/w6dTSm9LeO+FMCPeKQ4
	up/zGtZH6koUcV9BjBBu+zT/WmVJH1r9qzozO+Quyh86Uta8wMyORmzRgzNuNRRJ
	oW4AnsgGX1Ecn+gS5oKYaRAqSPT3cNsprQbraGBIPLc1u1KHsz5UkXa+ind1mqNd
	mM8sQ==
X-ME-Sender: <xms:kfREajRS7LOoFqbnVW4pC1PjLfBgQUYnroeruSnXisAayXUPUboeXA>
    <xme:kfREah8PouNmvfcMLZ7EOqByjB_IKHjJYBokNjrDMIWJBmmDmXTn5B6V2JpYhKi9I
    y_QayXpSjNX9rTv7YAVXyYpMDqUqWw7JeFbeYmFjEDa5y2uFWmEaSk>
X-ME-Received: <xmr:kfREatXC4U9We9e0TpBo1nd89UM7mL4G9QZ3ozQhvlFWwCA_wXyP3AR5dJedtg>
X-ME-Proxy-Cause: dmFkZTEAGPw03jnBx0rhtgNj8xn6QixEvgJBmSUvcgHq3Uzrdg/NHT/su0kloMGoLd1HPm
    e0TdjJu4hTKvHuWngzEuybG7HbJy2ntM4nU+JlERCbphEp/wQkp4uyrNlkuR5w77lyznZX
    L/vx4/r/cZN1VoNDM8A3kb8VqUCU7uaQf12o/8GMf2lT/SYcdC2VegLtvNCD8zHjbcl5pN
    MT1LZEDOA1GSC2l4IhPLKd7qHJtcgqt+zM1KP7cuIpRsetV9154E5bAhEVn0BPdmZ4+6yT
    9GeGGxhn90mVbmTYMRwQzvsc7e/7iaK4jcKyFpJusA3BCM1pEd8HA+vlFar1p13gdvlbaQ
    3UvzARF/+UhswVtq80tUmnsCOaAu7+u7btrHJRO3HxbGeeKIgqaGcO/A340Bluwfer9ZH2
    GM12Er6UKHRIhmFtO6YOubWQjPiygXMWT4Trzq2iunWCWd+ayJuhp4XYqe5BdWZcIKDHu4
    WRhz0pa612SS89VBTz2AMSpbiNaOnK9wqlGffPz1gW0VzLTK+Mll75fvFiktMUoA7kkEFv
    y4G58Ea0YeUaijr2gueFTUppmiE958MGbwKBHcwVZm22cp/rdne8XqYCGgZS+IeD//NCUN
    +43DdJBtY1MnkigLQR/UZnouyQHFPMzAJuK1KgXUAF0XttNmFaXqXR3z7F1g
X-ME-Proxy: <xmx:kfREavNZUEDqKEbuWDlx3DiQxdytDPjuyfXs4W9jxF6dxgLzlO7E6g>
    <xmx:kfREateDzJ9heicPzzSOuE672IBFeJzgt8GUBPi9XGVwShee8GQrbA>
    <xmx:kfREamzzzIr-cBXj9nI29H1s0NbNyUixBs0wWciP1t8o8eYfSJUOag>
    <xmx:kfREamhJgRkOglTMixa1LRFZ9wwUCkB4pQZJZlBYJ2OjJrLuVaH3bQ>
    <xmx:kfREaopi0IdEOPcMPyXGZACow_bK6KR4t7CpkT1LDhuei_PM7Tu5wRsU>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:05:53 -0400 (EDT)
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
Subject: [PATCH v5 1/3] x86/tdx: Fix off-by-one in port I/O handling
Date: Wed,  1 Jul 2026 12:05:45 +0100
Message-ID: <20260701110547.764083-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701110547.764083-1-kirill@shutemov.name>
References: <20260701110547.764083-1-kirill@shutemov.name>
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

