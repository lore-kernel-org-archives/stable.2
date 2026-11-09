Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239239;
	b=JXQ1JhF+bnfoThBqjAZP7OFLmEWUPHTRi8izwLHwWobS3PhliacYIxCfyMuTpNuAWNoJ
	 WC4LAcB7hyYqcpwZYkTvyS+PQzKaK2r7kMDuaTPAuzZjUHVuPjEfGY9AQhKb9kDC4s6kC
	 HmnYfIipmyYFrp2+aJoxAVoP+ohibFpZ/VPS2FznGcWpRiAGRD1l15zK5OdfjEKNFAbL0
	 E6643M40T9XzH1Ovq6FiT/DC96/ENIu48m8SNk/xbUi1VHTDIFSJGOXqannMnemPDk0fa
	 F163didFFTWmYIMiZZgJNO0OPstkDSHO09qOVcXRw+FO5YnbBjOVSGcbUX95mPFQsBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239239;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=lXiYbGPgsaTYaiTkzzYBday4tt4361HJPokmNFTCkrw=;
	b=qmsY/3RaaKKQ9hjEvHUagyJct4Z/4sS109Ir3CafxDivdzI54FhrPcS1i7WBcPW8psZk
	 NIxWY6fZXGotm6yTlLphFB4w7wNj5w4nPBGniyoRS9lq9u7sbDy0AUJQ2KbxH80Iz8vx3
	 V/80IotmgDr2VpqasqBimpxBYnc/uC37jQXtB6/Egj+Ef8oPLocoJgUNCB4X7tXTD3KIV
	 cURNmbK9mMGkxQXeOZwG4n1PmOmK9V66vzI8ZnyjQMkWUSRhfv4Lfvfv6lmK+6oGbvZW1
	 OLHjj/qLoQZGMSohdyZ5AQoAPUCfTjlGcCZjLMaDv5Zym2YxVisdhTtQfr237FNJWuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4Hjnnd8e;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="9C/tvgiH";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F7606A330;
	Mon,  9 Nov 2026 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A9F7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4Hjnnd8e;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9C/tvgiH
Date: Mon, 09 Nov 2026 15:47:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794239236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXiYbGPgsaTYaiTkzzYBday4tt4361HJPokmNFTCkrw=;
	b=4Hjnnd8e7B4UDCjQvtMk2q3eMaNsUYx621ug2P4zXL5Z882J/8VODvbknpDUxmzVtLDaLK
	LP1HxGZc5u+wpE1nPiEHkySlfnML9qrAeovGZOYPYAMCqrJ4Cn6Pb6pFR0houitMt6odno
	bQEPEq2F00ST2uZ9gexM16XpZkVLuJ59a+aMEjN37ZuoNACd5pnD+T9aQ0/Ff9VAtRXltL
	aVbiQRW2Lg6F45YXcXvHRjd1Y38xRZEFm2T7/auKRkir4cPiU2Q8j2gLSz07rmyxPwNhQX
	ZWFsAmXCKHX29SWX/QJT4wFn6W+RG5/BUUOTZCMo/wFzEs0LY15gc+X7tUq0cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794239236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXiYbGPgsaTYaiTkzzYBday4tt4361HJPokmNFTCkrw=;
	b=9C/tvgiHzBJkyplMlHsoxsboOMOiLzKI0fFxZj76rso/RXD+s894R2UM7vg8ylq8JuJQ1/
	X9tH7tZJ/G3eMICQ==
From: "tip-bot2 for Florian Bezdeka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Fix return type of syscall_trace_enter()
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261030-wip-flo-fixup-entry-code-v1-1-7724c29e800b@siemens.com>
References: <20261030-wip-flo-fixup-entry-code-v1-1-7724c29e800b@siemens.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179423923471.2093942.16733071930714527580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     75b1663222d7aa0b3c33cc3522a347757e6d1d26
Gitweb:        https://git.kernel.org/tip/75b1663222d7aa0b3c33cc3522a347757e6=
d1d26
Author:        Florian Bezdeka <florian.bezdeka@siemens.com>
AuthorDate:    Fri, 30 Oct 2026 13:31:41 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 16:43:18 +01:00

entry: Fix return type of syscall_trace_enter()

All return values of syscall_trace_enter() were migrated to bool in
commit 71ff30013f19 ("entry: Make return type of syscall_trace_enter() bool"),
but the function declaration has not been updated.

Fix that up now.

Fixes: 71ff30013f19 ("entry: Make return type of syscall_trace_enter() bool")
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261030-wip-flo-fixup-entry-code-v1-1-7724c29=
e800b@siemens.com
---
 include/linux/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fa2854f..a8b2430 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -62,7 +62,7 @@ void trace_syscall_enter(struct pt_regs *regs);
 void trace_syscall_exit(struct pt_regs *regs, long ret);
 void syscall_enter_audit(struct pt_regs *regs);
=20
-static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsign=
ed long work,
+static __always_inline bool syscall_trace_enter(struct pt_regs *regs, unsign=
ed long work,
 						long syscall)
 {
 	/*
