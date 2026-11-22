Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795350976;
	b=LS+vFVY85G4NGs59/9Ypla8zLCWkBQ8R0w6G8ajfJNanojN68NKQD9+bjAzd8fb1NEy0
	 XODC/TojldWJZtSQrZqc5XHX5XOh9+w3wNtWLCE4JS6zRfITXld0WfbwgU9O5CHQIMnJ0
	 OplS7ue7yPtrfbU2gDtcbFjxZwIGhqGDrkkrgGzSRHHGgI1gwGB5PVTqmEUrHaaOsipka
	 56IlcukzCrEPM5k/t5GUU6FH/Jx76fOf5u1ZiYJw0LYaTnR9ChG+F0OH6QdQdui1HOA5r
	 IR0vgk8E12+A8QmyFH7PNC2GnT35nVR5pkcllIgdMU3ItxdQq8tNG0+GAeY3o5o9DGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350976;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=D1MuXXQSfxhAunCSCh6B0Ouy7me/RMME2XCu8g9bTPk=;
	b=JTN/lox5/bWr2ji1jfuK+EvEw2daGFSQ4NAM949AavdIylc0AJ6LMY17gEVAsPJUIxe4
	 U+yHRiz0OQ6uyEAN8WtGJYJ9sGPe8FJpiU+gu3LCz5ULDSLmifISKunzvX/uapWJp8+dd
	 dxL5oiv3UUiuTTT2PECu7L726ayfdmkUod9QYeBmMLtEmpZYA1ZX+4tbhTRn7S0LMFQGN
	 mrOPUycvch1/fVxGoIf0+iC7n0QYuR1ZG7dQukZrpB9J9nO45TiYppbzh+/BOVdYDMRZD
	 95Y2QXKVsWukOjfaxHYS2jck0wkzeeiHnDqMSomNz3WvN5+YdKrd6FWItzA6IM62vHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DErrCV2Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE10606A334;
	Sun, 22 Nov 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DErrCV2Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795350975;
	b=TlUf0tkslfILivUUVgJnATx4YaImhYK8Sdw+RjfoywYicJV7xHSg1f6PiWzk9eldwEye
	 64wkyX+SXwoE9YrENcy/wWGSPLy7dsyq6ohoqkrm8kweOMjGm0y4F+c+uAwovCIYcsgg/
	 UDx57bHwlu5p3Zsd2I4HMg+zgsqLnQNBIkaGedUUDDMmLPHrmXjmBqQJJH1RbFc6+tZIe
	 A67wW9gNYYCUUkc00Osh0bbSgUbjk5WcwCTrXKZpMm9jUbaUsm+FURZkORloug+xI5sbC
	 QqUdRV+OwMDXvwIh3MhvBsF9h7DfNi0OVk9NHhDXlzzAJ2sJbAei4JJOpdsN5vZKKZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795350975;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=D1MuXXQSfxhAunCSCh6B0Ouy7me/RMME2XCu8g9bTPk=;
	b=LNhLiN2mleLAvbItwQgSTFlU8IsTKxjpRqXv2HDWIbPRgOGfygX5OeCR9oeO3E03eq4P
	 LdWks5fGQmet5nz0i5AEE1YKI757whhXCMFyQfEe26fFzQFUTIfvMOMEl7XmnZajYp7OZ
	 V8mLCOOpEUFNa4hXaaSljObL59tl8Nw5g4HmjJPdKJABDxJDdy8TsjmEtYVc5FnlBJ8ds
	 RyZxgom0tI4nR0CYduV/DNWjimWnauQlBjQdtNmEdOtUca3LztGrJmp15Tf4D7iUQ4QDK
	 2I9Y0x4mLaDIccccaMEkCweYmB0IeZYMIZSOravp+SzjJO0apXabCZJAT2KI9kSqZ9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8EF031F000C0;
	Sun, 22 Nov 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795350975;
	bh=D1MuXXQSfxhAunCSCh6B0Ouy7me/RMME2XCu8g9bTPk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DErrCV2Z5RTpLrsTGHncZJXKIme+4NdUsuvpEOF5547jjRVV7JbeFlEBvdYYHbEyt
	 /VLlYIbFyB/evb9wrE8GiQJlL9aDhIekndjm++T5tTQGUO+PgXd8uH+dyRTDtTptJt
	 dQkCsGa8qoXnnCqBgqfMYAhIO9tSRsnrE7Qkhtyn43NL4uLXBO0YTqJlzlOdRCxpu8
	 VkuyJCklx6x+Tq8fs+QCKwrIO78uHQiwf2kGNjjdKan56OR3CFabD2mC//rRpiO2T0
	 alnuRrfobf3Y9aIBaYBxornkE0o1eKmMxbvY7ZjK8+16oGFaH6JdNiOAddn8arF2hx
	 QfZ3h0/plgdDQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E157F4C035;
	Sun, 22 Nov 2026 12:36:11 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Subject: [PATCH bpf v4 0/2] bpf: bound arena allocations to the user VMA
Date: Sun, 22 Nov 2026 20:35:35 +0800
Message-Id: <20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-v4-0-d542d1233623@pm.me>
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
X-B4-Tracking: v=1; b=H4sIAJfhAmsC/yWN0W7CMAxFfwX5edZSx2SBX0E8OIk9MnUtSqDah
 Pj3tePxHl2d84CurWqH4+4BTZfa6zytg992kC8yfSrWsm4gR2EYiDAxOo/paihNJ8HlW8Zxzjj
 PCRfG6A4ul7yPZhGNNB3ULJQUYTVem1r9+a+dYFXA+QX7PX1pvm2d7ZakK6YmU75sqOkov7jB9
 8w8ODYfmIp8kBsCO6ZAXjl6ij6IWilR4fn8AyNqmCDaAAAA
X-Change-ID: 20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-f2eb9eff6db8
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795350970; l=1694;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=e0ZiUtyczM9A0TUsQiCpAJ4gxT0Nz/VbMD25/XSK4E8=;
 b=Jztxt8PhcyvKwjpW2x7GxAqcM0Y5UxoLrt7ySghXScqL8VYGr4htosk7yZLSWZU/61JkjLdj1
 Oz50foA8PhqAutsLos5oDBzuKgar6YQVPy5fg1ecUq3lKrbr/rAyZ6v
X-Developer-Key: i=fadouse@pm.me; a=ed25519;
 pk=b4DyzHJDRd8853IHUSKPA5wwzChj8eF4MTnZuyPz1PQ=
X-Endpoint-Received: by B4 Relay for fadouse@pm.me/b4-relay-20261122 with
 auth_id=1597
X-Original-From: YanXin Li <fadouse@pm.me>
Reply-To: fadouse@pm.me

When map_extra is omitted, a short first mmap() can leave free arena
pages beyond the user VMA. Automatic allocation can select those pages;
near a 4 GiB boundary, the kernel mapping can extend past the arena's
vmalloc reservation. Patch 1 confines the range tree to the VMA, and
patch 2 adds a regression selftest.

---
Changes in v4:
- Check the first allocation in the selftest and remove the incorrect
  offset-zero NULL comment. Patch 1 is unchanged.
- Link to v3: https://lore.kernel.org/r/20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-0-1f94ae9a884a@pm.me

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
YanXin Li (2):
      bpf: bound arena allocations to the user VMA
      selftests/bpf: test arena allocation after a short mmap

 kernel/bpf/arena.c                                 | 25 ++++++++++
 .../testing/selftests/bpf/prog_tests/arena_mmap.c  | 53 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_mmap_alloc.c | 33 ++++++++++++++
 3 files changed, 111 insertions(+)
---
base-commit: c44104f3642da720164042623e4832836aefdd8e
change-id: 20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-f2eb9eff6db8

Best regards,
--  
YanXin Li <fadouse@pm.me>


