Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689684;
	b=txkIjeynBYCATSAwe3aFUUCKWup1qBCEPY/3tv04k1mZm5wNmdz31acLPsr5iNw2GbRD
	 9O5ZTQcDKahJkCggC3iDlQYJk9g4qsx2TxOPok5Jg5i5Ti8kD114UAI5U7aAJJ3DfOozE
	 PLsk1DCoFJz87ZxeOYBoYV4TZLz8imkJw1DD/tZafX2TKG9UrPPxb6xijSiFs+f5wQZnj
	 sfeNUtzZ2qbs5yiDpxye6FXaYZ4iu5tBjS4NhL7cEqRRB1ryRaC6W6pKbXLa9epUKEujt
	 CcGlfK/sTwerqu8+C/mgeMg5knRXoF4GjrN8bRw2UmNgl/0iL/nBk08hwYG0YimwHsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=5L10UPph3rpRCzL0clTnMvz/d6onHkzoKgkZYIrhdEA=;
	b=awsMGQ+SLKsJ1Ah/YibF8JKvCGh+vHNc3In40lBEJrerQjqe2BLX0WTBxVVS3pU3Dzra
	 qtVm9UfVLDGuzd9fA/1NNBU2OubNAu83b7m4GhNqIy+emtuLx5ePiS3bnlr3JSMv4P6vd
	 IgjxXF4mnWJIAJ/uFr5l27v/waRqNIm0LN70uRlHTk10GtnRnrdIicNyl9LCiOkdNwjhJ
	 5wL2ONq0nJ5vH0S2VkI76jOBJxtK9lNflR+UylZgWtoVL5i116J2Re0DphvMbZOjqp0dT
	 e5GrCh0iBTjmg2KxBt+ip0wsF61GsNgVPG8SFuMKW0PdwpEq6XS111mxFTHuOh9YllA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=POFbXVVr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEA606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03DEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=POFbXVVr
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67db35e7953so6943669d50.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:41:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795689683; cv=none;
        d=google.com; s=arc-20260327;
        b=pQzNzQfpYgHKfaVawhsaSfJk0+OS2/qqr9j9zNdb5jj4l4/WQb4MbvTG6WGW0uDUpr
         YFlP4gp6+NQVuTRh2Es+QSNEcmeps/CggUb90bxTw1hgEVVu4L56o7PYHkDnz28vncay
         /LrF669YKCFf6+rE7OgRCJ1Ny4obWcK9CLmPUTQlt5BU4l4SVGSsYFlFXhWE/duvXeUt
         txMwno2hFV5fyVKdttOO7yNQUXlU69verPn6xnAD8p8DRwH05uLzJjYzq9NLtZ6Js8X7
         BJfG+tdsqW8vpfKZMeDiAONsS9/sZYrowT1cSvzRA6+8VUqVO7YY2rByNPa6kTDFsHeK
         hntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5L10UPph3rpRCzL0clTnMvz/d6onHkzoKgkZYIrhdEA=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=PLAAPJEucN7XsgS3IbCajtnFAVlnyOmOOUlKcH97sAPI+vNbpdEIlMDa8eauU1Sg9y
         qt2T0GQHxQGrbytf3Vh08YJ/4eI28PJL/UayN3556lYKaj3SZP+B8+dO3XULVbvWKWLJ
         bIpWbL2QIf74bU6ok47UEN7aFX1MpG7DgcVPQF0w3nYKac4qdfI0TUPv9qL1OAVelaLK
         rK2WTNVjH1pNDDeRi/giuAPU0/KYq/GdXAv+hpLao5wlk7SyX/Z836IzArdmapVWhSpK
         AtjLBA1CJDfCaDLzKCnBafrDYkDAoo82sn8MF+TFzgkS9jRAK429+FNxdT81GL93VfFD
         ioiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795689683; x=1796294483; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5L10UPph3rpRCzL0clTnMvz/d6onHkzoKgkZYIrhdEA=;
        b=POFbXVVr2dFYl+k2T5NHVOrxOeCdtm3ar1/BKK5zLK+WxIr1PzmyCsu0uZcaVRQVSi
         hpAajRYHs56YqcIqY5uUIf2QUrC+zUZ/8Jrp6qa70YHJ0WS4UvffnL+YoP8INLGAdGFS
         xWcv9WyqXnDzloCneWmHQAh76VcFuNgnSBplE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689683; x=1796294483;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5L10UPph3rpRCzL0clTnMvz/d6onHkzoKgkZYIrhdEA=;
        b=0txAd3mZVKFW0TW9Kr+G2COuyye2x+SLMeOLLVixeopXgcXRekpptZZEWz6ZVe20dO
         KcqglRcIwNRAl96jPezLrqRJlPfxI2Lj6egJwhTu72jFmcDF+VAvPE+v9ijk/mW69Lrd
         FoHNzVZ90IN42459Pi/N/SZpw7Db3KDbNYSaPwoIAdhAluolrBMWI0AhdhWie1wVcYGP
         kZy+0GJtvNNus4G9DBmUxrQM6gAazW4hKM6xFUXre4jixBKSr9YRMcxJmKDAW/2VtmC4
         uExnWc5zI6gjaoTi/NhVxF5U2XeLuNF8ujWqePmO1gRj025S5aCiXxY8/44Fttyu4Gmn
         d1Vg==
X-Gm-Message-State: APuU4Z83mUAXf+NWfVZzcXW8u4o+3yyJnZJNHSHUAvbT8EL6Cgt5ZfWr
	8DNR621AkmMJ6EjvXemrktq1iTvcOAXrOcN0WcTBagAIF9R3h/VZPn7+peFlEXVmeAkuHKdcGcZ
	roQdGCufvTUmvpRKRr3dagwnPs96CfQc0nm07o02hO1Eipa39tiglq0U=
X-Gm-Gg: AZFdTZfAssB5sdWvZQipnGkY44P77QJdtwIrltUdyd69pi0XSYxcsiLgJS/au2oHLbF
	CpSkyHr9kChfNQIbd0gJfhBsqdOzFIzwTNkfiSTaAbnOAqjb4XEZwmmCvHS7ExKNIY1IMjHMmIQ
	6NohNKCPMrdcAuUzpJw+z+Xp4T9gdcGH6pchqPA0yZsdzyt3NpBAaqCSzBkFdIZPmEUYzal3Cc3
	DxdubPSoSwZJ8okcXKpqMehl2zP6Ut9bySZJYCUjbc/I19HFlCiKIfzI97lkK3AKzifEyd0/fxY
	2Bs71Ge6nErgtpy26FAehWTstHiQAPMGpWq8zpgAurlYBV5iRmftxWufUEBnmFJqgAUD9PiL/dC
	16s+g3PhTK+ZaUJ1L6d8zP4QyVsLmLlTEVn28bhP3EELcoJ6F2NERBophYKHiahW96kKO2MXmLh
	LkqDBWAnfsv0IzX+NwBVJI0wqAN/G8paRGbjRf+WSLjZEijP+QacKKFY7ZRIlgURVDEayt2MwVD
	OQM4O1r8ergTSjN2lQYJh6FnxbxCXuc/sgL
X-Received: by 2002:a05:690e:408b:b0:679:8c5f:3fb6 with SMTP id
 956f58d0204a3-67df42cdademr7228166d50.9.1795689682920; Thu, 26 Nov 2026
 02:41:22 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 26 Nov 2026 02:41:22 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Thu, 26 Nov 2026 02:41:22 -0800
X-Gm-Features: Aa3M54pbvsy-Rd8GKjV7yIJcw92m78lxrGsA6UuzH4xnQCiRG0xp9cTZWcC0JnQ
Message-ID: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
Subject: Request: security fixes for 5.10.y and 5.15.y
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg and Sasha,

Could you please queue these upstream commits for the trees below?
They're security fixes that newer stable branches already have or have
queued, and each one cherry-picks cleanly onto the current branch tip.

5.10.y:
- 18e126e97c96 ("firmware: dmi-sysfs: Fix null-ptr-deref in
  dmi_sysfs_register_handle")
  CVE-2023-53250. 5.10.y has the commit it fixes as 985706bd3bbe, and
  5.15.y already took this one.
- 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on
  syscall entry")
- 5306f124f317 ("arm64: ptrace: don't warn on missing siginfo in a
  group-stop")
  CVE-2026-90347. 5.10.y took e057b9477232 and then reverted it
  (ba8b9a906d80), same as the newer branches, but it never got the
  replacement fix that 6.1.y and newer have. The second commit fixes a
  warning the first one adds and is queued for 6.1.y, 6.6.y, 6.12.y,
  6.18.y and 7.3.y.

5.15.y:
- a81047154e7c ("netfilter: flowtable_offload: fix using __this_cpu_add
  in preemptible")
  CVE-2022-48976. 5.15.y has the counter change it fixes as
  5345d78ae64d. 6.1.y and newer have it from v6.1.
- 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on
  syscall entry")
- 5306f124f317 ("arm64: ptrace: don't warn on missing siginfo in a
  group-stop")
  CVE-2026-90347. Same situation as 5.10.y: e057b9477232 was taken and
  reverted (7ec6eebb438b), and the replacement is missing.

Testing, on v5.10.275 and v5.15.226: cherry-picked onto the branch
tip, W=1 build of the touched objects before and after with no new
warnings. The dmi-sysfs and netfilter picks were built and booted with
x86_64 defconfig plus the relevant options under QEMU/KVM. The arm64
pair was built with an aarch64 cross compiler and booted with seccomp
enabled under qemu-system-aarch64. I didn't run targeted runtime tests
for these paths.

The list and the test runs were prepared with AI coding tools (OpenAI
Codex agents, with review by Claude).

Best,
Dickson
