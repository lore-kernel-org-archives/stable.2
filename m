Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742195;
	b=mWCRRCxo3q0bB9PjUfGs4AlJJaFY34TlkZJRlRrnmwrHDp5N7ALAe68SZJG4WIVCbd4l
	 tCkZmyE7Jfl7Gx9kr5fki765Njrvuo0mRXF7Vb7Df5ODM0bpNhXAzEdpk5zA+1HRxTO+Q
	 eognaSV3q+aPnZrfe6BJ7rBlvVp96aAcGaaAK39B8pLPrE+Ap7IV45TQF/Zlqnl6c3hGk
	 C1XAv7VCQcXTjqdl6Z0WBdw0f92km2w5HJbJmM9u4u5Dt6nQcT64MmsNV8fwcEhuLprd4
	 OkcUiFNBuN4KlHXpwyN24Sg/B8ppXOFsuPRrjMAGysuVtV1zlFKXGK62EQW6043+t3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lsQbLTCb15SEBz66E/puI9KOwSbRd2cOgYsx7WE88Ls=;
	b=E0N4jgpGCJqx4DWZFzlh4MkVxSWvRO+3QubKGYs//fjv5hDrMtnM8nyVqtrF7CTd9PCG
	 HZ94B4ctB0QbpXTesiNawIBC8BSwo7lPZ2Pde0WrZeF1IiiC1xa1kCa5LDgQHYruT8u3x
	 PP8+8HQfVAhKvPWRpYlMVCfuNOG4MtBpJMurSpSLU7s9u83h+ubWp4h4cfuV8v3XAw5EH
	 La8bFbbaNJ1bb1QXUj1jxA35UyJCIgycejFJnnRSiF7FKoDzmMjKK5jvJ4fifpV+JQ5Ks
	 wesROwUhjpZUeF4qhpMYclT/bUwhFr68oB+/uuOFYcHBFsjLijmMbSioRK5WtXMaIyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A5CHPewS;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B8606A330
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5B8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A5CHPewS
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso6438771a12.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 13:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742194; x=1794346994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsQbLTCb15SEBz66E/puI9KOwSbRd2cOgYsx7WE88Ls=;
        b=A5CHPewSGSTU2oeHArS+Of4cmMXag/WzykuQsiv+SZXPrjYlsQGklY6SHJ59b2R5Pu
         xDqfKMN0Hal/bA7PPxq8uR/fD0gM3HHz41jMUmDsFm+nwBbYFNirdgIn2Gy+EvbyvgV+
         Gqi1iUw1jlYykhd+2Rx7CUwTVVPUl+/wx2iLlOG41MWANizqlcIxA5AgLpprwAQKYgpm
         Hv8Jn4h5hczWt27TiFa9kt09R/Q+vnjJTBBHfU1FeN7zPUYNXpaO5xBK7OpcaBfuJ7WO
         2juceEhWRVEveMlYMoy+PkFmqHtTqARMwhNgoJIBC1GL4Nys2eLanVSgRNDhDtJSw1vI
         gSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742194; x=1794346994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lsQbLTCb15SEBz66E/puI9KOwSbRd2cOgYsx7WE88Ls=;
        b=MmPcScUiCt7Fz1i0H8ipM/8dtaxxnPXjWP0o0o3S9bl/7Umo4jjqynUZZOc/bOagSC
         AzRzTtrTkSFzYcHgLGiebG+UYXOM5A3PduichJ9whXlmS5CxSVVqDAEpx5lXcxPS3a4C
         Qpuha+N4d+AL1//IOLwbJOq/Gq7pFnSe74oPaHC5SF76Yz5eDswEszwxGfPh/SbatITf
         uaCPIUyD7wBqs8dnAxMLEZK6z3BWrKU4DToLEiiuL91KqdeXxPr4TMBmGeigaGfLFlwR
         6HYeLtsGwE5R7INJjnbQ2ujj4F9PIYZsoMYaEjdUPWhXQC8qLNBPExjBP+GPpZpGFFXc
         72dg==
X-Forwarded-Encrypted: i=1; AKwUvBymqqh0dulco534ojUqNlHGK1NHL1PFio/oqEFrfOYZ0FtTp/H1QozZg/E5DjucW859FISHBuo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iic/JuCjjGnoIm9xdbXfLs+vrLsF3MOeYf6Q+lAok7IKi3c8F
	BPOEZyBK/vuGiuXA092zD3ZkQtKFEeI9kSmT4xXF5hXI4PZbh4K8Kbv0
X-Gm-Gg: AYBFou3ZilWw8+ELSAkwpZx20B3LpseJZNKggT/8F4W7cyEmjtmGZbwA/uRYcfp6qeY
	odb2APPzcQC87z34cs9mKW2abhhDYrgn7hJtHI5r1FBj1sRwjhHzDMsB+VFIsTm2PdmMskpxZep
	8zS9a5y2XUFXOD/Pm7dsw/AlC9qWZ+x3/Lue2Yk/9L1mM6XteX4TMeXQ34j4HG8ysAGLGNc4nQU
	RTau8LBQxmPr0q/xV9SpJ7w0ecPHI8Awz9ds5k9eH1Ybzk5ko81xzFL/KQ2Ymwtm2uGbzrx02RD
	TBqgZSjpfrCCumspttPwD1Sd6/fx5rxhUtr2cmVBXskTUrFBALW6pD/cqjotvShJoPSKzuNqBpn
	IOkhLcEQVXSdu2lf2oNAFawddJ2HTbsgoXLHSleACwb5lAPFgGAUi3ImDiz8PBQk5nkhLN6U1M6
	9DST7wXfwV1ilhSchL9AmwvfHMcF4JTZ8jAyak11lpKQFVhF7YJzZv7KEQLSM6G+XUaUDtnF5xH
	jeTH9KNXxBKG25NSAbxnCb0c42ac2ajTBqD7aUcDHmkqV/l4uoD/xQLXqLcDeOeWYsXPCfX3NUK
	KTzZ65czYMiFLHYCQjWdYMKUkoXfVpFtjOy1Rv3GaWx2R5UZpODyYcmahSwmQUa2535zezY=
X-Received: by 2002:a05:6402:90c:b0:6aa:f0e:a15f with SMTP id 4fb4d7f45d1cf-6b4d534badfmr10647171a12.38.1793742193445;
        Tue, 03 Nov 2026 13:43:13 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac5a2a6sm40550a12.16.2026.11.03.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:43:12 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 01/14] alpha: fix saved registers in page-fault oops dumps
Date: Tue,  3 Nov 2026 22:35:07 +0100
Message-ID: <20261103214120.1099893-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103214120.1099893-1-linmag7@gmail.com>
References: <20261103214120.1099893-1-linmag7@gmail.com>
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

The aligned exception frame moved r9-r15 back by one word. Adjust the
pointer passed to die_if_kernel() so s0-s6 show the correct registers.

Fixes: 3b35a171060f ("alpha: align stack for page fault and user unaligned trap handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 3dfeb854f196387d8c8f709d0ce355e5145035fb..f09f69894cfd65d814ab1cf498c946043fb9e8a3 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -244,7 +244,7 @@ retry:
 	   terminate things with extreme prejudice.  */
 	printk(KERN_ALERT "Unable to handle kernel paging request at "
 	       "virtual address %016lx\n", address);
-	die_if_kernel("Oops", regs, cause, (unsigned long*)regs - 16);
+	die_if_kernel("Oops", regs, cause, (unsigned long *)regs - 17);
 	make_task_dead(SIGKILL);
 
 	/* We ran out of memory, or some other thing happened to us that
-- 
2.43.0

