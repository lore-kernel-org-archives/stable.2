Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4917419305
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786798261; cv=none; b=Kf/n4/gBqwzyNE3rWgd6SX5WkB6N34hQs6kNtTlWSEU5a/VkIyazzw4u3GOUjz7LxwP8A4g6h7alCiuSta12QjyTepFzm1uy/64u1+gcVYXFD9mCT+jcSnwxbo70T9Qa5ipvwv7cwt7aRdPGDfBtzKg7owx27GHgwTitgG9ZkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786798261; c=relaxed/simple;
	bh=6cOcCYfCe568r+y9R2IJ7kM2MFz5Kt2mUcEn5bM2QCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OEXQKx37hVJJ7/p7DNE9j25o8BxYmtgcx2mLXZNQWgYpqdqY4/b3KCM0AzjTlujFLvx8UzoJkitgYmBEqJGH3Rbfl80S3/FlcC2a4sbjK2eLVogQG24BUicnH8DKxuNOpd1yf3xMhbVYkGe8G3oLzOhc8huf5lyvoipyBkyX1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=OWKX0MEx; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="OWKX0MEx"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b1bf68b387so664438b6e.2
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786798258; x=1787403058;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgXfO9Knh+lvJWXJYrcjIAPvKSCV55TJfVKEYesskuc=;
        b=Yk5sSB244n4C33Hvk/oyHf7OR8jD1CuNkPZjhuYz7larPmb/EWOwL5pRjcCO3difUH
         0ze4tsRFdpG5qVxY3ZZKBQTH03/OwOlyZ7lfiSP28hobDc7zwaPVHTz9QtprY67Eahxa
         JP8AUWcpClN30YxKt/zxQOctwlmDqDicU/3QuJDuDpJ5hhqlueCK/jsHIGI1zWF8Mfov
         FwjQiFuA9EMnVA408Zgv/Cx4AF/O4vZZsRUFDd/QwXacjqlsWPXIH9Exph0OdpTEIASU
         Ed7EvcKgiDSdLKetZ/KM3IqRTl7riBYOF5yGXTn2bpUgPqhlckT4GskV5FMS1PwK+n9I
         Ct0A==
X-Forwarded-Encrypted: i=1; AHgh+RohDDd+YmgUmGUI1gxDnTED+b7CdSk4idELj1Jvq36Q0fWgDYZZqhBsPeCLFQXEFHwFLaQUkG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoL5LAa/DMhkiO7mLYVGa0jsFIhWAS6Ep3MmYQhp3vvLMMX0R9
	wOm4T+vehF/xXoCVE/rwyEMKb90w9q/Mo/Jm4QPnn6hmM6AgMNbYvat5LNcyWJd3LKM=
X-Gm-Gg: AR+sD11VHsb4Tuk0MzAkg6UDnQDQHitvppuzGldMb3OM9iyb7jX/vDqT8lUQ/Z11EHb
	Jsc20LB5S2JM5SUVlgnwrYH2QkE+OknkJvqode7f4fGfB3GeofSsz976moSuPM0Tard0/4K19q6
	qbX/FX8sCO8qfOk/ikJWNIML1wAuvDtbvDmaarwwL2IjxR05nHK0GSJKu9aBu/tmHLiy9o747nA
	noDWYkF6luR2FiySPnjZQb0KjV7TAP63gY4fZ70tWDBVdXs3t4sV6pmQ2ccSXiIPiwL6TLSmt7G
	w9WptZGy0UzKBXzDtW5RVm/maN2LuvBD58c3e3fvoLp+5zvdL8+q7kTpE51sKuWIwmgqH/j6d3Z
	E7kFhAp83lPJ9H96kIo9rsMkxaEhd+tl/rjbJdY/P51yRQVIy/iXzuLX3IfD5lmws22FZQ8EJYv
	Cs3x+4gbWaVHmn0i4WeYbkk2iAIQfBIergOibkY+WkLk6h5QAuqP4U0BaJSoDgiQwRhItE6cXev
	KKm6a7pqbgQdhwVKXQfND1zMmLf++Q0cl9Z6VMjzbRt6Di+NIXZtZmHcsnrD18mZg==
X-Received: by 2002:a05:6808:5291:b0:479:f7e7:4a81 with SMTP id 5614622812f47-4b240662d51mr10556854b6e.0.1786798258407;
        Sat, 15 Aug 2026 05:50:58 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm3339747b6e.5.2026.08.15.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 05:50:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D06E60791;
	Sat, 15 Aug 2026 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786798255;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EgXfO9Knh+lvJWXJYrcjIAPvKSCV55TJfVKEYesskuc=;
	b=OWKX0MExSwH4IWxKjefmJLS7Z+ebKcisYuIZUFksP9KDFvpQyZdXvKmCT7s70fwPaD/x5e
	ZzKXPBWVcTDgxTQf3hUbSNrPSECfRqVTuWVRUBrhfBqFlvOmyF9wXNNFOknlVqXwpxcoc0
	vPXyP31D+J/eovMFbwb5RS9/PWaCJXAVLR6oqUr4u2BJJYVhJqubJ+T/Y0XNIB4KWVljj3
	SBS3ob6InQpmq1iqUeQi7PWcxNP6hb4ZoLXD+QFfSX78PPSxl5yBdKTa3Im+sW1Qdf8SGi
	1dGX6hLR7fcfvCvF1qBf7h7kw8HnMvSR+ULSe4RNA13y3HkTpEtsz3dIwGC0Dg==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Subject: [PATCH 7.1.y v2 0/2] selftests: Fixes for BPF
Date: Sat, 15 Aug 2026 09:50:37 -0300
Message-Id: <20260815-7-1-y-selftests-bpf-udp_xsk-v2-0-c227473a2300@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ1ggGoC/42OUQ6CMBBEr2L220WKIsYv72GIacsi1VpItxAI4
 e4WvIB/My+Tl5mByRtiuO5m8DQYNq2LJdvvQDfSPQlNFTtkaXZOL+KIBQqckMnWgTgwqq7Gvuo
 eI78xPeniIvKzkKQgGjpPtRk3+x2KRCQTlD/MvXqRDqt5HSrJhMpLp5sVcZDK0sEa14/oWxvDE
 39wXTeGQ+un7fMgNvlf9waBKeoq17mgotKkbx/prSFPiaMA5bIsX9AtiisQAQAA
X-Change-ID: 20260813-7-1-y-selftests-bpf-udp_xsk-04c781561aeb
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>, 
 Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1786798251; l=1083;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=6cOcCYfCe568r+y9R2IJ7kM2MFz5Kt2mUcEn5bM2QCc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDSiAAq0PTwiz1KaExq0kBOGWY+YF8qBwe6m++BmJ+HndbpATbx5RonRWExaH2bx/42B6SQ3nec
 0FiobVJ6u6AI=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Please consider merging the following patches, found through openSUSE CI,
for test_progs (subtests sockmap_basic and sockmap_listen):

https://openqa.opensuse.org/tests/6159071/logfile?filename=test_progs.tap.txt#line-4034
https://openqa.opensuse.org/tests/6159071/logfile?filename=test_progs.tap.txt#line-4212

Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
Changes in v2:
- Corrected upstream refs
- Link to v1: https://patch.msgid.link/20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net

---
Michal Luczaj (2):
      selftests/bpf: Ensure UDP sockets are bound
      selftests/bpf: Adapt sockmap update error handling

 .../selftests/bpf/prog_tests/sockmap_basic.c        |  6 +++---
 .../selftests/bpf/prog_tests/sockmap_listen.c       | 21 +++++++++++----------
 2 files changed, 14 insertions(+), 13 deletions(-)
---
base-commit: e2466b32e02a49318b99520c40b397062c65c84c
change-id: 20260813-7-1-y-selftests-bpf-udp_xsk-04c781561aeb

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

