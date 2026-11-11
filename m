Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794372888;
	b=kJm3VDgzQqsGDTg7MGYlforAB6NhBNC1PXMRVFZkK2J8pvbTYJY5Z/cOO+QvLdzInepY
	 1kevAfwcIM1h6TeVdHuNVleKSoc2bzSOz7HkNAoI35gGbuR6eM4a98nCek245fEsOX9X2
	 /C7W1DRAzIvQNlOCvuMLGZ7g3Utzdfyjeg+yf686XwQBgBSIyeq0Hl+QvYO1XLtsWYTzj
	 MHFm+Zpr1xW/CBhHlIMPgN7hCkN/Xs4O0K4oWVC9C+r8PIp4HRr5hPk0QU622usBANVbi
	 dkx5YYtAoYK+8brYyEaSqD+OwjSeXYZ6Myv/QFLLVFfv8ON90PwJN+FaejYSVIirLog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372888;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=yHTqYk5LyUXJH1MJkA1V1ZTEvy+nMYFD/OUdr/NdRxY=;
	b=hG7gDT3O/vW5saP/N52LxIiAgFysw4yI2BeHFgohNI/OtAJT8DkQq1l3p4U4B95V10Wv
	 kvhBKTKwHdhax2dj6KNFlbFjoJoe5Ez+ZNYiyw6b2PERZgt3pfAPDbM+NynTVVXKk1fPl
	 K2jQfZwUFqJuChiODwOwaeFi6EteYGJ1FxAqIes+binZ7BiLFYcv3QjAaQowcYGDJ0m3q
	 jDyPlpZjswabJbyKIFrelT+/4og/OeQNw23rCBAKvJc/zlh38PS/NpsCJGZsuB3bRaDdX
	 63X71iTArAYIpSBs11f5G4fNv38mRiXOPYnuo1W6tv0ci7chy39svojGEODtd9v88yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPhqrFp6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E1606A320;
	Wed, 11 Nov 2026 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPhqrFp6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794372888;
	b=cxoW7mTL3r95EX/Y1f+hmDM/tG3Dxx1Z2w0n9j5qx8D8sPTauT5iLyeHkYiHa7BTtsWh
	 bi67FW/c9PGd+ZhAbaFyQl17pDZZMs1kuKqTgBGjrl9W7LFGri9jds5iJp9tXP1laBQ3A
	 Ir9NLZ2TsLoGG8/bbLmSqgUzLgIXCGIDl3brA8W9Qtx794xug2ch9p9E3T6MoIe0vEGxQ
	 We6vSomta8ieiVygnvjuQLv+kGMoDwpaaSgY8tQvO7wwG9D3kCFFP8ZcY+w0ZFYPWJ0r5
	 AOkrFJuHNYcYNGLJQo+LjzMnfM9jf37PKbs6d8Yxig0Harh0NCwMPRW4usVVC0FIuTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794372888;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=yHTqYk5LyUXJH1MJkA1V1ZTEvy+nMYFD/OUdr/NdRxY=;
	b=D90oCFu+twhgPT5/j0hUYBRuEp9BCYpoxrhwJbozz9ER2pOK8nuG4awAxIcwAybNh07F
	 YeNpA07wEeLbhirmvov9v9qj6EAUMn/pAtP7O/B5SvgQFZYuK/vyYz/MgxXrcSZ++1Y3H
	 NIvWqHYA9xglVczSeecSsEPocSI3s0ldpmwc5SZkSRCXF3vq2HD2BCRo4rOl2uG9w2aV7
	 WlDeYX5PYRyzfdho1BP7/5/8jl111+pJPOeIv7lYYgKPZAw3E+vTSHpooCVQTUUn1C32G
	 kABuIIKRev9zzBhAjQdOmBf0Wrp//6ql4subN705UdkRlaFXnM2oQJ7huUwzuGsunFQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7310A1F0093C;
	Wed, 11 Nov 2026 04:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372887;
	bh=yHTqYk5LyUXJH1MJkA1V1ZTEvy+nMYFD/OUdr/NdRxY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=iPhqrFp62ocYWmcPo4P/iuntSuLGsPniD4EFr/UQrJbxij1/SpEJNWZQkMGRGzDsU
	 0WZEywl9L/3Jo9svdWRL+v0661bUv72iqiG/Kv7tbUvBORk5EKrFsKTj1eSuDAbneg
	 dZog+3TMwGVIMKn59ytzyBV50Nu64OkoRnHJ/Iq2EcTqVzI6rDQe2hrSACbCJX5a/g
	 SswK30IzpMYQQ6QePQjjmLK/pTyxNKKDzh2lyoN5LpwUwhj7OSdX9vMggtyqCfETj2
	 /CQTSAEmAjf2NdDYYa8d+axJOcjM0DqXI4Jmfqi+jQ8lp407GAx7d2VgD6ooZ7BuNE
	 A3SP/W0IWas6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C343F48D9B;
	Wed, 11 Nov 2026 04:54:46 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Subject: [PATCH 0/2] landlock: Fix landlock_restrict_self() on long
 executable paths
Date: Wed, 11 Nov 2026 13:54:45 +0900
Message-Id: <20261111-landlock-long-exe-v1-0-588cfd174a10@samsung.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABX182oC/x3MQQqAIBBA0avErBtwFFp0lWiROtWQaCiEEN49a
 fkW/79QOAsXmIcXMj9SJMUOGgdw5xYPRvHdoJWeiEhh2KIPyV0YUjyQK+NEztrdOmOUgt7dmXe
 p/3NZW/sAA1FTl2MAAAA=
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Dwi Siswanto <me@dw1.io>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794372885; l=1166;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=xaD9x5hOGi5bU7Yh+ce0HiRT3Akp4JNRN8QyWNIXG58=;
 b=o1+NYJLc/GsQlPVEcfpw+6EGdbF5/yRNquIi6RQb7zWg7iJHGvMT8vlyHXHquEooXjdnKCeOD
 /tr4JPiSF96BXKxKIdCQa2NZryQMhVALjr423/dTt/eSSyj6hf8K66a
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Reply-To: daejun7.park@samsung.com

A task whose executable has an absolute path longer than 4106 bytes
triggers a WARN and cannot sandbox itself. Patch 2 adds selftests that
fail without patch 1.

Tested on v7.4-rc2 with KASAN and lockdep. landlock_restrict_self()
from 4107- and 4350-byte paths fails before the series and works after
it. The domain records then show exe="<too_long>". The other Landlock
selftests pass on both kernels, apart from five skipped hostfs tests.

---
Daejun Park (2):
      landlock: Fix landlock_restrict_self() failure on long executable paths
      selftests/landlock: Test a long executable path

 Documentation/admin-guide/LSM/landlock.rst         |   3 +-
 security/landlock/domain.c                         |  15 +-
 security/landlock/domain.h                         |   3 +-
 tools/testing/selftests/landlock/fs_test.c         | 175 +++++++++++++++++++++
 .../testing/selftests/landlock/wait-pipe-sandbox.c |   3 +-
 5 files changed, 192 insertions(+), 7 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261110-landlock-long-exe-61cbbfbc3300

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


