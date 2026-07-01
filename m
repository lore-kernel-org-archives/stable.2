Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578B3EFD37;
	Wed,  1 Jul 2026 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903955; cv=none; b=IMOpiuSyRhr+lVNd0zGSNLRRY8cXY2L7HjP7/NQBatVp5mUEilMV9akBMoTSIM9bSSqlCmZuKtiGvJhZx7qmepkiAXBPmk251c11oiF7lP+cZfuhaYnAqOxLXwCfbviCd0NeF4gOqbosBFahrjgB9Dl4bg61gBGp6lOuqNlCHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903955; c=relaxed/simple;
	bh=T+bIugystx1BDC45M21sJdMyM+in5SsT15xSJ8iZ27k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWNeekdpsXn3RgjL248o4g6g5ZX/RCdjwIhiZMjh1ts/kfwuNWUX/ScxXr0u5sEYn824sP7BIroPXm37mfpdZ4WiGNXw/8HIzoXmY2HkQEBQ08y7btmhXnapMumR6V1yMpm5eYGfKSdq8bvryB4xFNsTqsCRk6M5MhOf6TvGmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ItZrKVsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pwqfeo4V; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ItZrKVsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pwqfeo4V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id EDE1913803F1;
	Wed,  1 Jul 2026 07:05:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 07:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1782903951; x=1782911151; bh=S7TBJiUa54
	KOKCAQ1GMPRZLT8SieeYtP5zVEkMW4AdE=; b=ItZrKVszptxCOJrUVXN3UDIbmQ
	Eekt1rj6vxSa9TX5Vw7TKbqv/y1kyVEnQMkVrM7ZCSg3lviT01sHX62w9M9vdQ++
	TfjGo1S5VVxlz3CEJZ0fXVHUvh7oKgGES+n+uIrla6fx3tzRD8ymljbLhhb5mQFH
	uKKU0IMnnVNWYFSuRBwrZayPgAdg6YX9PjSy27yR6YXsnRcn30YD0QTrr4DZh+W1
	+Fp/qucHvsz8e39s6OZbjStGb4Dm6FlCi7ZsQyUcAff7dtomIHyCHojCjjQySWBT
	w30cX0Vr0pzxiRWFXuI8JZP0MCFzNZS/olEt1pzCZPGLY7d+nj/XxaYLo/Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782903951; x=1782911151; bh=S7TBJiUa54KOKCAQ1GMPRZLT8SieeYtP5zV
	EkMW4AdE=; b=Pwqfeo4Vrye7XBkKmN6LL+/AlsRszFHycwVWecLxDsmULUtmS4x
	RBnl/qAa8a0P7CEYXzBT/fVheErSW2k5WY2CxLhq5+tF8UiI4pR8RugyDfLYFJd6
	hHC7GYimBnfRnIHYIy0NOPSNNcFhtnClBbFSLALTG6aK7sTL+xF7522i/VDimVeN
	69aOroE+SgXRfz/m9Kfo+D1H1ycJbFQ5DiIZY0bKDlT7F343lRE1gB99VgkwDao/
	ef4++iAKa0pMoSrSpaj68OS2kLykU2ouviMgnvVO2TpGSXhIeoTbgmrCemMY/1U9
	Hef0in9VEEs9QQmJrH2QgbsnSqh0RKpYXLA==
X-ME-Sender: <xms:j_REanYDyi8qhIFJjLBx6WNH0iNLYlJ2OYs6x1kq8tp1zBAaRbalVQ>
    <xme:j_REajnUH3P0jj6x5LdtBn40l9TWOPB_zq-3ef1JkK24xb_EhZIHEHzwiQRzSl-cl
    P7CEJKUK4hGshmHqAuReZRxxCwzRriIXcRvcweBjYHE-4AS9_bS5HE>
X-ME-Received: <xmr:j_REaucKfKc291LEnycpjwkNz2bc19v4OvlCtLtT1ObyG-nBBdL_5wzA-EHDBA>
X-ME-Proxy-Cause: dmFkZTE+8mg3IR1S/qQZa32DtIGlJoWSADNz2iPyzMqQ23r9HmFUb/Q3lf3xbgS4LHx8zv
    wCiUQ5asqismvQiyd23z3Tk80Xrp/qa/SFf7ZsuwRbwFFeFRCQS+l/PBt5p+jB+5ryRNbZ
    3H9kpmDIHXDuuU8CjEK+lnKEoUkEM6eDvvb6lo986uExS39Wm/lJtuFmNSAXAclt4KAxHl
    dgWw/MEF05ri1JO6LPPgcoGPlgX6mXa5uOKFPdddV6g/Tl0oenJBDfmmP9MB+A0oKNJQfa
    LwEIJJIQCZ1eAX/iGNGEBi5Z3ij9/V3fVP1D0fEJJu0NGqfVptRDFnYX60MGJiHz/u0TXi
    y/oFCQYXOLwd0bSsUqxALdbC5X/HfXxEDCD3yEA37FH59dTRHNFsy+6Gdd0ovklfbRqLBH
    QgHsI0hcw+zh1VQ6zSTQwp45bDkolx9jM8Ifu0YUAbX1MYWehXvNHXTgTkS98pxie3LdDS
    8zH/M09uqCBr5tEAX9PAbEvd4coP/2CYVw0K/+4I+9ZA/YmJTCdetzAm9yOgVkG5gNoAIi
    hshGIiGuAk6aosBKyE4ce2s0a6wrcnRBPbrlZ7zBsBcT2nl5MLBNUifcwL1gKjCU5dZNUb
    LZUsycneobx/yjWbZRG57UNz96y2QmwOl04+jbUdeUU4Olb0DoLMtXbaO/SQ
X-ME-Proxy: <xmx:j_REap01WTb0XFyFU9efRwmzja9qTcJY248nxPJrxnQSaTVxwrs7DA>
    <xmx:j_REajnHpENh_b_KuHEBXSWdoNMgPBFo3ccHZc8Jp7CC-uso_8G-Pw>
    <xmx:j_REaiaww7QPh1K8cWEj7jjwV6ZocXPsdC_R8IwxrWVPv4NRSWMfAQ>
    <xmx:j_REaprAluwxl7VSv-wHJnHwjIe-Vw5mYGT0zXL768WxAr1psa8h0g>
    <xmx:j_REaizUHYE6wj_x0y7xm8yl7jk3O8ag4a5fV9R7PX7EI5z_18ZmTiYT>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:05:51 -0400 (EDT)
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
Subject: [PATCH v5 0/3] x86/tdx: Fix port I/O handling bugs
Date: Wed,  1 Jul 2026 12:05:44 +0100
Message-ID: <20260701110547.764083-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Three fixes for emulated port I/O in the TDX guest #VE handler.

Patch 1 fixes an off-by-one in the GENMASK() used by handle_in() and
handle_out(): the mask was one bit too wide for every I/O size.

Patch 3 fixes 32-bit port IN to zero-extend into RAX, per x86
semantics, instead of preserving the upper 32 bits. To avoid
open-coding the partial-register-write rules, patch 2 first lifts KVM's
assign_register() helper into <asm/insn-eval.h> as insn_assign_reg() so
both KVM and the #VE handler can share it.

Patch 2 touches arch/x86/kvm/emulate.c (it removes assign_register() and
routes the callers through the new helper), so an ack from the KVM
maintainers would be appreciated before this goes through the x86 tree.

Changes since v4:
  - Rebase onto v7.2-rc1.
  - insn_assign_reg(): drop the arithmetic read-modify-write body from
    v4 and lift KVM's assign_register() verbatim (typed-pointer writes).
    This fixes the unaligned access / adjacent-register clobber for
    high-byte registers (AH/CH/DH/BH) that Sashiko flagged on v4, where
    the emulator hands the helper a pointer offset by one byte. Update
    the changelog to match.
  - Cc: stable on the insn_assign_reg() patch, as it is a prerequisite
    for the patch 3 fix.
  - Collect Reviewed-by from Binbin Wu and Rick Edgecombe.

v4: https://lore.kernel.org/all/cover.1780584300.git.kas@kernel.org/

Kiryl Shutsemau (Meta) (3):
  x86/tdx: Fix off-by-one in port I/O handling
  x86/insn-eval: Add insn_assign_reg() helper
  x86/tdx: Fix zero-extension for 32-bit port I/O

 arch/x86/coco/tdx/tdx.c          | 10 ++++------
 arch/x86/include/asm/insn-eval.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kvm/emulate.c           | 26 ++++----------------------
 3 files changed, 38 insertions(+), 28 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

