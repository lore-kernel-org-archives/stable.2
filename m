Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446068;
	b=pDxmHwxtI0gqCEYaSTSIKWU9a0jrhNF6rpSP+BFppPmh2bC3DiMP8lD41hMiDDRPm5vE
	 ScgsCc0HPd2NO/6sxrRXXsDF5dPFpnAgb6SBBqm35HN284yFLKQHpVnVKyLmUlHM0KLc1
	 A4X12ecFDDX/W8nigQy3ldASaCkoZmArGOeagP4PTPXjujTtSwSAQhSNAl+0xqn5LYwDR
	 zy/uxv4Q76m2gUSjDVumh4kNPxj7jKJtLPO7D8XWu9dEjFp0xL7pE+NQMpnF26xdqn+3G
	 G7ABgHsSuxtx6+kUfinbHZM9yszzyNz8AS5Z+ZKvrF1X3EqnEWtbqE2TMvCXXSzd3MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446068;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EUyMU/XwUgHp5lO8B06tp0V12TwyEXwID7MKlCvCTy8=;
	b=bH3dOmzRU38+RipAN2JTtiSX6P32qs4r7BEKGeYBaRlWKTTwNgHoGEhQ2msCZw7QovNV
	 CndTkCZpcD0IQh0bpcsajsLmwgBiCOGHv/ZtbUS7KUOLMDgpqo8QAGA90Dokf71vJY84C
	 xkHTJ1QsKrECxT9MijqqTCwcwBgabPjsd8YOU0zDZ0DyOQ4kocrf0E9a8aLDbzmDbFglV
	 weX/8u68XS6vQg2ZBsK3U1lf5q/sWP6U+E3txp+uTEIy4Z/qW8flHuQQkMB3iwLOUZhvH
	 9qTVl3kbiTIb10qk9jMMowO2R6jrPf0gn/VnwSrMWgTmwGXS/da31Gl3eJC/Ak/Yb7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiI9lEkU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807D606A31A;
	Mon, 23 Nov 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiI9lEkU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0241B1F000C0;
	Mon, 23 Nov 2026 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446067;
	bh=EUyMU/XwUgHp5lO8B06tp0V12TwyEXwID7MKlCvCTy8=;
	h=From:To:Cc:Subject:Date;
	b=WiI9lEkUAnH8OuHpkoY4GwaK5YIQ5H77rtEyur9agG9ceB4IA/UFAber1CklXJhjG
	 8RlPX9NyD52W3Ds0UOJ5gsqXlr0tH64AxOc9CbDXV2V3RUWyphHPpHuCweQ7l8NkK3
	 ohB1+SaISi0P1vlf8tFkVX0xGbrfce5/nkQ0vci4W6clyeL9Gny99YlwvnGnSIgnJp
	 K/yamsnDc4x0ZtTlgbu/6bQomUI1ZsUWvWrbLMMe0pXc+ejKimd9AnAOoJbPqeqM3J
	 Cc4kHsTPX6bqf1ajVNZXvxi4lUJFU3ixyBIbRLTB6EpyesKEBem49DktAwsJbaMY7d
	 EMt0QXK62PRPQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Aveline Noir <jm5905938@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable 0/3] mm/damon: three fixes for idle_time overflow and damos_walk() hang
Date: Mon, 23 Nov 2026 07:00:45 -0800
Message-ID: <20261123150049.81317-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Avoid 32-bit overflow of idle time calculation in DAMON_STAT, via
patch 1 from David Carlier.  Fix a damos_walk() hang that can happen
under certain watermarks setup and a watermarks commit internal state
overwrite issue, via patches 2 and 3 from Yifan Feng.

This is a batched reposting of separately posted and reviewed patches
for being merged into the mm.git.  Refer to changelog on each patch for
changes that were made before this reposting.

David Carlier (1):
  mm/damon/stat: avoid 32-bit overflow in idle time milliseconds

Yifan Feng (2):
  mm/damon/core: fix damos_walk() hang with zero watermarks interval
  mm/damon/core: do not overwrite wmarks.activated in damos_commit()

 mm/damon/core.c | 13 ++++++++++++-
 mm/damon/stat.c |  4 ++--
 2 files changed, 14 insertions(+), 3 deletions(-)


base-commit: f6538c11c47408c69dc77d38fea1b2a4fca86f3e
-- 
2.47.3
