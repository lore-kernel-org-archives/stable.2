Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239237;
	b=IM/YJL5+9CuEMxr8+v1TOsyHcR0w9i2smOpaOpxZ0XBLPJKrBCL7VrgtVDDNhSsXMMeB
	 tQCPE+TbzPH6nEbYAOgYo0ucWDfcvlzJILsB54ZCGlMHbe1FiM8Fu0l2RGjqx6EvrK08T
	 u/E4c9qsB9MIDj8UVeG2Dm21loJMo9aQR7q1EWOY8lb5zc+s2wQMax1t0eXBEsIzCt/5y
	 Lb7gXTPK6lUYeyVVaLYJpKAkLtmV0l1U9FWTzUwppF2fTJAUCyMwmaDGi9QdLB5ftMNZC
	 KA3HqHOHpUg4jb7d9KmagjSum1mdwVMpBWEG5KLil5D9OfcK8DSxn/wiHXH0gpWsqnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239237;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=cE6Ch6J1BkW58eNALCgFwBepu1y9rhfxpO10zeYVMnY=;
	b=L2MTOTADmxChqJmSFslUwUUFe7NQ3TvC5ANeYmsbM15y/PRzuWYUtCNxaarE3fQ0POC1
	 y1c3PCQkviYaZ2fYhq8bHzqGfyh906fqaCcyF+aFwdc/vUcHnM2fNYxNbv+/qnZQqjN+I
	 JC+6HQ79/TxmYlrea0E+JmSrqPF6pMHch35mU7f5hlf02hfJrHxR1P0q1eOLrhjnoyu0W
	 NJdAggkL8QGXZOzoA9zXU3nTZR0M9lcvYCqAB6uGx7+DNVVlyYee1Mh2Z97mnufaGymo9
	 75MorBMFucs8hnBErZGX5lagZ74q8CzE1y67BbwSH6AkLl0MfpGic00zjd4AVEL/dhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=FY15hpKK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vSksRZO1;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5E606A321;
	Mon,  9 Nov 2026 15:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD5E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=FY15hpKK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vSksRZO1
Date: Mon, 09 Nov 2026 15:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794239235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE6Ch6J1BkW58eNALCgFwBepu1y9rhfxpO10zeYVMnY=;
	b=FY15hpKK41oCXQIusu96AhsBNKriViooMdDu/ERpf86T56vEGlkmZZ2EoG+MtJWl61a+YK
	9orAERDJnnJsFCMI9rcuw7IrobFX1I4KRic7RHi7lOpAqKFF6KFUibU0Yb3l1yCQrUYbzC
	PGjJaoJOTE+q9o1UOkrFMjssH/nMqtJ1MiRcTuwZKDxIMGeOqAluB5QvfT3S8wVnVZk76h
	3sCIJIcZt2LFLg7oX7aK7qIhOQa9VYtjMyvcMlfVbyL6bPTfl18ObgBsle9CiY0QgzD6cu
	cZ0hihW/FkurdZJECLu2XzQD6jeqQVfti81PRGBKUTXXLYlyUToixxa7BDLm3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794239235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE6Ch6J1BkW58eNALCgFwBepu1y9rhfxpO10zeYVMnY=;
	b=vSksRZO1pbECyuNVIR61XhMO2VCS+gi5mFmr1nCqF9rev5ZGaDFU4h3MX+DgVVw002Imsi
	SFbBVnIByeZVbdBg==
From: "tip-bot2 for Florian Bezdeka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Complete
 syscall_enter_from_user_mode_work() to bool migration
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261030-wip-flo-fixup-entry-code-v1-2-7724c29e800b@siemens.com>
References: <20261030-wip-flo-fixup-entry-code-v1-2-7724c29e800b@siemens.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179423923291.2093942.7666652196041999066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     efe191f1605a149b06eb0fe1ff975e7d3137c9bb
Gitweb:        https://git.kernel.org/tip/efe191f1605a149b06eb0fe1ff975e7d313=
7c9bb
Author:        Florian Bezdeka <florian.bezdeka@siemens.com>
AuthorDate:    Fri, 30 Oct 2026 13:31:42 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 16:43:18 +01:00

entry: Complete syscall_enter_from_user_mode_work() to bool migration

The return type of syscall_enter_from_user_mode_work() was changed to
bool in the commit referenced below.

While doing so, one caller in syscall_enter_from_user_mode_randomize_stack()
was overlooked and stayed at the previous type: long.

Update this caller accordingly.

Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_wor=
k]() indicate syscall execution")
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261030-wip-flo-fixup-entry-code-v1-2-7724c29=
e800b@siemens.com
---
 include/linux/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a8b2430..1527841 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -202,7 +202,7 @@ do {									\
 									\
 	instrumentation_begin();					\
 	local_irq_enable();						\
-	long _ret =3D syscall_enter_from_user_mode_work(regs, syscall);	\
+	bool _ret =3D syscall_enter_from_user_mode_work(regs, syscall);	\
 	instrumentation_end();						\
 									\
 	_ret;								\
