Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720695;
	b=iDa0BYUeHV0JG9cn9SynulSrv7R7jEm9/1QiMUaBKu9EFi+BeidXxPZ+IM6HI8fYWwdf
	 I2gAyjsP3Uy0Rby/kfTvKBuRYb2PNgmEuABfvSD5CU72MsNiR6KSpUUW48dmFB2SyAlCV
	 Ujz3yYmuauBl2Ua0foWmay1x3R7WnNpxP3tc9XuyIVFm8xs4EGWtTI2/xcUycUcSijEjq
	 gUiX4/NZ7xM5LXDPHdMxCqlCFcCeRl3cm+qTC4kyMd9qKV4nnR4U2lyXbZhHVQIDX5osq
	 9uuTpaT4YXYEIbDQ5UDjnmSB+2UHosSMZ6L0yGNHc4mTftTVnN+/XoustkPqPhtb9uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720695;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=E5rUhXxLObJaqeNwCfpPJbhOavyXZimGUEzXCiths9w=;
	b=Y3mb/akMpIZd9HsN6Ta+53nfhWGI/J3eGnyb9vcQafzPHAxFPJHH658eIyiZfrFW9H/s
	 dQzYri1xrhqjLxYlZg9C9ZM1Ta4F4qgyZ7N6XItWjeb1DwlsjcMWzB5+93RRhf87QbGfV
	 3LQtqTHdunIHCh1l8K7ED9DhRy1Rn7JFp/eRLUP8jDwPgvjqxtFzi5x4OHsQEHUU+5Ifm
	 BNzrkFVc+5RCCCT86LPE7xibWEnaPZNnS1eXO1iXWUUaIG4lBNZrOMNWqBNmah3mOKmZI
	 ZNDXTMn12LRIQQJOIxP5F3l2OX8zptsdy0yVuJJCmqyOU4aRwDv+gsJW0FoT0/q8N6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=P2FhE1L2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+Z7DCKPJ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2C606A319;
	Fri, 23 Oct 2026 01:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4B2C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=P2FhE1L2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+Z7DCKPJ
Date: Fri, 23 Oct 2026 01:58:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792720692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5rUhXxLObJaqeNwCfpPJbhOavyXZimGUEzXCiths9w=;
	b=P2FhE1L2GujgbomCNlSfPnxB76KhtiggCCfnWhxfvUHVxuH87Neru0gq87RTHVRiptixZW
	aTD73KvIa059epr+qoCqIPujNVbRw6x/ftH2f/ZQo8uRHey5hbgyx/p5K6ackr3M1wA/EX
	xJdODhcGllL/WYlfKBcDAB0e5IjSA3CqmLNwoqbPGlZzXXmhe/9dW+QD8d63BInuICjmcF
	rGm5JTOJwM6fRrNs5Na+jPOT8os4127qs6FAU6u5ox0Icnul/YINbJstxcX/qVMDzaeCyc
	0wJmfzDhXMU9PHMn8OxXRGucqgJL+XOhILAM852f7CYC6vpw7MqmQjSG94Hvzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792720692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5rUhXxLObJaqeNwCfpPJbhOavyXZimGUEzXCiths9w=;
	b=+Z7DCKPJKWkVdBrVBfoeMQAw76tDXLhObm45f+JBxGKK3NTOF7mZawzj191EeiaXFDV5HM
	SzZGxUQ3nqyzMDAw==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpuid: Mark CPUID function 0x23 as being indexed
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261022210134.612848-2-seanjc@google.com>
References: <20261022210134.612848-2-seanjc@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179272069017.3012171.7534138300125291612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     108775fa28fe04a16f19a828a779689f3d0ea9f0
Gitweb:        https://git.kernel.org/tip/108775fa28fe04a16f19a828a779689f3d0=
ea9f0
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 22 Oct 2026 14:01:32 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 22 Oct 2026 18:39:16 -07:00

x86/cpuid: Mark CPUID function 0x23 as being indexed

Add function 0x23 to the set of CPUID functions that are indexed, as per
the SDM and the many sub-leafs defined in leaf_types.h.

Closes: https://lore.kernel.org/all/213d614fe73e183a230c8f4e0c8fa1cc3d45df39.=
camel@intel.com
Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261022210134.612848-2-seanjc@google.com
---
 arch/x86/include/asm/cpuid/api.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/ap=
i.h
index 2d9f3d4..759b12d 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -181,6 +181,7 @@ static __always_inline bool cpuid_function_is_indexed(u32=
 function)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x23:
 	case 0x24:
 	case 0x8000001d:
 		return true;
