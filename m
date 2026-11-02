Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591821;
	b=QQYBya2l5bbW4d+anflUe2afPXQFWFZg+sOK22Ca3zFHPnv6+jhoQtRQddFVX1G1tJZg
	 NvrTeN/TO3HHJsSkM+HK83S+I3Td+DpkSaj7V5Sgaec8wBXhegHQDxQ+bHITxZbKjoq1r
	 tSTWlCibiL5W097ULpioREQCIRjjpE5aPE4Xu+DiGMax3wBXrsUQabRgaq6Nmwi6dxbdU
	 1gPG990d2yxYhOUPfA1Qnx2lYdzhprR9JsJmMUKO2zbp++lOFQOuq3afgvnV9R5VE2Q24
	 gx4ZhgwCxRQ8SsmFsJt5ii6fytBxiFAm0tOl5J2gh+JcZ8gvcSTmG9D9U8dhWQnI+7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591821;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=8PjF2ubDvNsdWLgY/AMNcylw5WsnOlgXUBz4u60tYnk=;
	b=Bkju5m3KswVfpinoUftw1B82oTyeHCMtpy7AgmeGb88gnYXOraCJXAR7v8i7BIpZX31a
	 bTaDtnx8eKrPD6IZwJ5coZidKNnRfyPU3I8gJg4rHWFVRSpE3yYuCLQc5JKJkXNoV2Iip
	 utJIJMXRvBb9LpaDYTjzQrR4AE1EkSO9bxhE7qRmUZtIMHmAam0K7ZXnNiP53JuBrFRCe
	 tegBOdwNY0/3DyTv84CCmUNGmcARYG+umt27TMAenp72BFuL93pMAxhp12GLZe92vHmnx
	 2rjdHJhuZi/auYg/J7w7TuMHnWK+0c7QyhMb+Udk2CzPTX4AqqUf25Od99DJbkBHzqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sI1ihJ7Q;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1jDUf+Qj;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DD606A324;
	Mon,  2 Nov 2026 03:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A44DD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sI1ihJ7Q;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1jDUf+Qj
Date: Mon, 02 Nov 2026 03:56:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793591818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8PjF2ubDvNsdWLgY/AMNcylw5WsnOlgXUBz4u60tYnk=;
	b=sI1ihJ7Q2+RCT8Ob/W41ijMh5SqJohu+GtmHwGcmPR5lKz/LJkcpMeztzLYGji3EOimtUi
	qvQ1vrtBXJOq0ChQTZd1C5sHIVmyQbVDuVU3AemK9wUhZHzxZorSZPu1AfQ0oCdzXpIocW
	5IXrKn2FQ5PeMEkwfNYGetc9q0q9G0Iue3z1p6oyY8pxje3h/yPzXwRlqoSsrd9P5xwucj
	I+JsJttyZbxPejNnVT8VD9XElBjp7H2Cs1XKPyvlCnsZXWTbsVPIG0ZwujVL1g9c8MoZ5k
	LWW0buHfbxpSXaXv9upnx/A+5kkbNISw39Y3k45Ebp8fy0CE+nu/8bKkrDP1ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793591818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8PjF2ubDvNsdWLgY/AMNcylw5WsnOlgXUBz4u60tYnk=;
	b=1jDUf+Qj2x51MdTlxUwyb9LzXeW/gVaTP6f+TIBbL7me+dzRGGNtomIjAi6L0XbVLXun9y
	HnlNDv81jCsVkvAw==
From: "tip-bot2 for Rosen Penev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/csum: Relax the len and proto constraints in
 32-bit csum_ipv6_magic()
Cc: "kernelci.org bot" <bot@kernelci.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Rosen Penev <rosenp@gmail.com>,
 Sasha Levin <sashal@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179359181669.1009794.18351008254076478607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8a8b11dec31270967fa00caddb2b4453e40078d1
Gitweb:        https://git.kernel.org/tip/8a8b11dec31270967fa00caddb2b4453e40=
078d1
Author:        Rosen Penev <rosenp@gmail.com>
AuthorDate:    Mon, 19 Oct 2026 20:32:38 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 01 Nov 2026 19:48:14 -08:00

x86/csum: Relax the len and proto constraints in 32-bit csum_ipv6_magic()

Building an i386 allmodconfig kernel with clang fails since allmodconfig
started building netfilter with GCOV profiling:

  In file included from net/netfilter/nf_synproxy_core.c:7:
  In file included from ./include/linux/skbuff.h:26:
  In file included from ./include/net/checksum.h:21:
  In file included from ./arch/x86/include/asm/checksum.h:9:
  ./arch/x86/include/asm/checksum_32.h:149:6: error: inline assembly requires=
 more registers than available

The csum_ipv6_magic() asm needs five registers at once: the early-clobber sum
plus register-only inputs for saddr, daddr, htonl(len) and htonl(proto). With
frame pointers enabled, six general purpose registers are left to choose from.

In synproxy_send_tcp_ipv6(), the GCOV instrumentation lets clang's machine
scheduler move the copies of two incoming register arguments, EDX and ECX,
below the asm.

Both registers then stay live across the asm, which leaves four registers for
its five operands. This is LLVM issue #206307. The error goes away without
either GCOV or frame pointers, and it reproduces with clang 19-22.

Neither len nor proto has to be in a register: ADCL also takes a 32-bit memory
or immediate source operand. Use "g" for both, so the asm needs at most three
registers whatever the caller looks like.

ASM_INPUT_G, which normally replaces "g" to avoid clang's poor handling of it,
is not enough here. It expands to "ir" for clang, so callers that pass
a variable protocol, like nf_ip6_checksum(), would still need five registers.
With "g", clang passes a non-constant len or proto through the stack and still
turns constants into immediates.

  [ bp: Make Rosen Penev the author because of a previous identical submission
    https://lore.kernel.org/all/20260904000833.2058186-1-rosenp@gmail.com/ and
    Sasha graciously agreeing and giving his much more detailed commit message
    explaining the background of why this exists. ]

Fixes: 403cec8ab6d0 ("netfilter: add option for GCOV profiling")
Closes: https://dashboard.kernelci.org/build/maestro:6ad55fe255fda507603d2651
Closes: https://lore.kernel.org/a28df759-d0e9-41c0-97c7-5f89a18d54e2@oss.qual=
comm.com
Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/issues/206307
---
 arch/x86/include/asm/checksum_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checks=
um_32.h
index 17da953..f74873a 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -159,7 +159,7 @@ static inline __sum16 csum_ipv6_magic(const struct in6_ad=
dr *saddr,
 	    "adcl $0, %0	;\n"
 	    : "=3D&r" (sum)
 	    : "r" (saddr), "r" (daddr),
-	      "r" (htonl(len)), "r" (htonl(proto)), "0" (sum)
+	      "g" (htonl(len)), "g" (htonl(proto)), "0" (sum)
 	    : "memory");
=20
 	return csum_fold(sum);
