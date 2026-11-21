Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288938;
	b=2gfj1HOEUTsClN9VaYZiTpbHjyGmSemH2f8/wkdiz2/QzbbSDWHiEp2kEmMBlrBQw56V
	 5nv5msgQov61MRrdsPt2/9hGOv4aD9K5IOitN0Phvpk2JT80XcS4ke6b9jwfF0iXIVVjz
	 69b4CYb2cMy3nwO/MUbYC9KD/u0c+SSUPSLeRNy9xmxIH45Vjg93XAz/WoZ1XWHFmYm/G
	 wx9BI1xfVqf/Q/FWqdgHujDlFwBKDGid8JByhqlPIhMjouGbn5onwqHyYMLQa4j+/OuEV
	 xiKeBivra629frIvrOyDw79SMG1MnxqYdqA/kOqiz4rMv6GEDp7QHMhV7eM1rDn3Q/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288938;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=jRSWqbYA2cl6HiXR/+G7WQM88W3YYY56d8wMra2Uv6A=;
	b=j3xYC+TuCVmI74S9bBTrVYdtL5MezZdwyTDrvevp/HYlMSRJW/YJBSoTcEpi9yjycE4a
	 vd04Z0a02YqpihB/QQmMIKKRBo0HZoTwpJE6KVOnYeFC9+ThTRwnWKEDdr0Zv2G8Szjpx
	 suo0Kb6/evwBMrTUf5fQ+f8PNqevRKgBRNr3wxvEhVA/gRWMWGeCeyjfKgSaj8nYngRaz
	 ivXVId2kiPfiuY0h8P3bK48GpJc+LTyHsNSCGLQfkFsMDq693d85NS9qbpOa6soD3GQXK
	 ENFAjrl0ZYb+YZU3bsH1tTaQnpkpHuOPapGM6cINsZ8fShpWOcd7pj2i9I3lAOqE24g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xCJH3yBl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5mJDcjln;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941B606A320;
	Sat, 21 Nov 2026 19:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2941B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xCJH3yBl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5mJDcjln
Date: Sat, 21 Nov 2026 19:22:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795288935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRSWqbYA2cl6HiXR/+G7WQM88W3YYY56d8wMra2Uv6A=;
	b=xCJH3yBlsfoVRdQTE/WzpG3hcpavsHOvEhGLv4ZiQpYzNu2vtw+OnJQCfqHSV+uYrboOdi
	nsSzHXlp2mF/gmkPLlgKxmpcHAn1SRV4S+PIU8j7IXq1qJ+zt7IIanHBTykbyP9KJEuDup
	YJ+JDYwXbdmir1a+0LkKQtpQm5to+Y0q9c3rP9LIeTxVgHF6pS+KQFCSY/y3e+Nr2GOAmq
	KkZzo6xbf3XdIAnItCH+rOHg61JJRKisxTl5Bg9xoKvXlI8VmEqt01sgAD6/aCykNLjxxk
	jNsiJKW6gCPlbJEoNSbKwT+QzlPXyfNQb1SUX+2pxdiz3j/L4nKSSzQtRE6oIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795288935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRSWqbYA2cl6HiXR/+G7WQM88W3YYY56d8wMra2Uv6A=;
	b=5mJDcjlnJQBKKBjS5ffQV+JjpD4IkBU1c4ujhbbXU/sS/ZMHOUWda6FC9c9dpMhdJP/Y4Y
	eTBBMIVyN/M9p9Ag==
From: "tip-bot2 for Richard Weinberger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Enable ROX also when STRICT_KERNEL_RWX
 is present
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Richard Weinberger <richard@nod.at>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vinny Horgan <vinnyhorgan@gmail.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260625090627.1501095-1-richard@nod.at>
References: <20260625090627.1501095-1-richard@nod.at>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179528893241.92412.16620607999563559576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ae3398a7da224e1cb14a04ce8e9da66fc2948121
Gitweb:        https://git.kernel.org/tip/ae3398a7da224e1cb14a04ce8e9da66fc29=
48121
Author:        Richard Weinberger <richard@nod.at>
AuthorDate:    Thu, 25 Jun 2026 11:06:27 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 21 Nov 2026 11:06:09 -08:00

x86/Kconfig: Enable ROX also when STRICT_KERNEL_RWX is present

Running a kernel with CONFIG_MODULES=3Dn causes the W+X page detection
to trigger:

  x86/mm: Found insecure W+X mapping at address 0xffffffffc033a000

The W+X pages come from __its_alloc() with type being EXECMEM_MODULE_TEXT.
Without ARCH_HAS_EXECMEM_ROX pgprot is PAGE_KERNEL instead of PAGE_KERNEL_ROX.

Fixes: 47410d839fcda ("x86/Kconfig: only enable ROX cache in execmem when STR=
ICT_MODULE_RWX is set")
Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Vinny Horgan <vinnyhorgan@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260625090627.1501095-1-richard@nod.at
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b..3159852 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -84,7 +84,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
+	select ARCH_HAS_EXECMEM_ROX		if X86_64 && (STRICT_MODULE_RWX || STRICT_KERN=
EL_RWX)
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
