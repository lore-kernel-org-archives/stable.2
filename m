Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B542CB12;
	Mon, 13 Jul 2026 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949880; cv=none; b=DAS7QwnK86XBPFrWRGjt+P6LHwdMYS1oCdwQabN4AWyxjhj7aGh9/o2PG5VHwHgg8P23B52ULw9mxcFIz1tEmCdUjp5mHyltT+6EC5zubZwbvygCkEDiAX4oXet07wBb56s1iWbIUzgxdwvkBCFbh347xwan2xOnf4SjBjqCgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949880; c=relaxed/simple;
	bh=tPBPcSFLQf5NItfqN1fV4gsCU8J6WgHiYXr5nQtLJPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzt2p87XVSmwig+2vXNaFOaorwW3akyFBT2YJ2PJV8xPQj4vwbp0/xkjg1ZCSsLGRncN7GuCap5to8Eh/ApzN4URehrOH0q1Z4Z1ii1VTKuMcYqRjCXqcMwVJtocOX8tgpPAUKklzL0W1drm9Tz9e3KpZaqFKFunx//wt8aTMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=A5n8TNgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYuywsQ7; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="A5n8TNgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYuywsQ7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id F2DA913000C4;
	Mon, 13 Jul 2026 09:37:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 13 Jul 2026 09:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1783949876; x=1783957076; bh=dzTqBUl2eL
	FYEhkrJ6M4erI1EUrg+fHBNBXuGqU63xc=; b=A5n8TNgqUZppV8a7BnSmMLEW9E
	dkSQlRe6SEWKL59hNN7rIXYGYyxzjGbCW2Ao0DSnzZLfGFN/YYWPuDnC8jCYt6gP
	/4zThlNsekmYHdbjMXE97AQZ45IbOPpRvB8Hx9crGDF3q1HeevwpSPokt8mTgCMT
	iHBm9ErSOg0nAN6co1vBAp047j5nktnM+Vpc3J7GoRJdJx+J8TcL9HX1va0PgWST
	A/Yx7R8Yv05tak4VJ21F6yYwNFbWiUeE7qvGNdXohSqNutGeiHEWe0vur29mueys
	UHBrQYs6TBmGvHkn9b2MDM5dRrEzzG+Ww1N08OQeMo8rdYDNU7FNVZjaQ6tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783949876; x=1783957076; bh=dzTqBUl2eLFYEhkrJ6M4erI1EUrg+fHBNBX
	uGqU63xc=; b=iYuywsQ7rorzH/gG9UJvq8B104L4PZqcgzrYmTdnZR7tq+LOSUL
	nptOm+iAJHmplBjhAKF2VBEWzeBo3pz+gQH7tjZQafvvI8rI5W9pH1NZDf1F4Fhs
	bDMPct1ZawHAYlmgXY3tjEsqclLJN5oAdb5c12vSOAmPYalR16gdGYUdDhafBe4/
	bsIz1TqIVfv4VElPcRH/LmBZG0x1uIzyX2cpEGvZXWzv/9o3A5x21cebMAJuZxgu
	f/CKBm8U2CCwK+n3J7YJLV1YPlzsWxSOT4FMEas6xEfP5D4wIIOpG8Mx5HU62D2n
	0wS8Uv+XmVNVTbpnMFqSTuz/r7oJSgZEEjw==
X-ME-Sender: <xms:NOpUarA8CkbVDT6mxQLl_qVIMiw89Bb4jCblRXLu8G9Zud1HGW4zbQ>
    <xme:NOpUautNWq0LSgNo8EJvRv1IJ_D-cEvCIiEwl87Fxh2ShsO_WmUrWeqN7pyJjpERF
    xUyxmrG2xJ9Pnzg2q3bmWKub8VI3FfqIqa9gniTgRArys0BefUFdu-c>
X-ME-Received: <xmr:NOpUarHHz4facFzDgxA-8BCO8g5aZneqG06gBcnoXRn8PW4KHGtUxDvGCqSXtg>
X-ME-Proxy-Cause: dmFkZTFB8CWiq131oKGJAq6ry3QIOKk4f8msJsEELyHZ2RUJCg85Wx+xqjmRp3VQJUxKRS
    RBZokesNlsIXQCdluz0As3UKcpg6hDo+dNM49VZC+6CT6SF3LoygdiHlkX/y15SWgBIQSC
    io/E8X3ZB06zJlpPy7C0I7H//Q981rJqdqbjOJpEUqa2XvpgYz6NecariubYX1mVfLggwp
    zwGRdaOTu3xqHK3mkhEih40z8RGyjuVF1JdTgrbMFMf9YN5EFJSGWZyM7e/7xAoURzJQZZ
    C4h2HNPGYPQN1Zh+Wk90LmGLqX/zsNIXnAEc/Bl7xzrrqVDkIscLsyUS+kYgiHayJwcVHq
    VGV9nR6RzhX48H7XqdwZG+pPtUxV/zUgYjmtYdDhQ/SKySu/xdilUIKEorLmZ3kpJIbAam
    S65Rvokmqvt1PPaXwedU7TKZQZGVF/YXFcGRD3+bdFC6QUV4pbigyxWxin9FZ7fnYjvJ0L
    114YNILkgvQkefDfs45Zz2EdUXOB9wRhlnyNHDAcSKXNvMb6M8Bgl6yRTruaAgib6NsxQ/
    du4obEl8BtcpYyAu25Aja1XDPu392Y453pCztfkSI+oc3EgoUDHgX+7eH/U+VGg93Vn+3/
    Oa/ubTLE+WjGWqbBn45X3SSgmUnD6N+kRVM8bt+DsMC4lUoGglsE7pLA+uOQ
X-ME-Proxy: <xmx:NOpUap8T1iuQg4_xtrGgoeLMz7Nh6x0L7J-stSNZZF0mTHV5lHJhVw>
    <xmx:NOpUahMaHV_O7LUg8PlgzQldFedQkfOpbqkhxRe5-hdO4IW3HOdWiQ>
    <xmx:NOpUavjSZu53Vz-xU0ZojWcRh1331WI50Htdi_sucemoVT83g1U-3A>
    <xmx:NOpUagRA7T1u6PeJfoVe0rBEQrMOeOvxkpI2hgaz2pb4HcUOKNtCCQ>
    <xmx:NOpUakY8Z5D3HkXFrvS40mwvqmJUnUCQJKCT6uhOq1_7lzMZgcHAMarl>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 09:37:55 -0400 (EDT)
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
Subject: [PATCH v6 0/3] x86/tdx: Fix port I/O handling bugs
Date: Mon, 13 Jul 2026 14:37:50 +0100
Message-ID: <20260713133753.223947-1-kirill@shutemov.name>
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
open-coding the partial-register-write rules, patch 2 first moves KVM's
assign_register() into <asm/insn-eval.h> as insn_assign_reg() so both
KVM and the #VE handler can share it.

Changes since v5:
  - Patch 2: reword the shortlog and comment; no functional change
    (Sean, David Laight). Collect Acked-by from Sean.
  - Patches 1 and 3 unchanged.

v5: https://lore.kernel.org/all/20260701110547.764083-1-kirill@shutemov.name/
v4: https://lore.kernel.org/all/cover.1780584300.git.kas@kernel.org/

Kiryl Shutsemau (Meta) (3):
  x86/tdx: Fix off-by-one in port I/O handling
  x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()
  x86/tdx: Fix zero-extension for 32-bit port I/O

 arch/x86/coco/tdx/tdx.c          | 10 ++++-----
 arch/x86/include/asm/insn-eval.h | 36 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/emulate.c           | 26 ++++-------------------
 3 files changed, 44 insertions(+), 28 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

