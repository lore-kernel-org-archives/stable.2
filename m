Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795346952;
	b=h3/TgMqNmkXbscbWiItqe+Pvge2RcB+LYG8mfkZSr/2vwWltPQlEJnPqmB7wVCYm0svR
	 xCcciCBI8139gOe+J/cOPMyDsmREfeTovwtOdKDEsGehc2XLxi6f/frezSIDvieZGqp59
	 s8dd7VFwAYvWy1QxT6aCLw17V7d0s3StclqzA7pXF4Nf4c3vh49R18Mcj5lQG1qDpen3w
	 R6MWYfz5ivh6eB60YVMEXzpgkL5d0h3Blaynd8rJRIKrzB0F4tH2lR6xttYw8PsZTAq5r
	 ELnvtKes4qfja1uvgZsDHCQhLSCqeDYLxUduxUtGYj1I5E31WpokNIZZ24rXkmr1d5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795346952;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=RUES/23o4ev/4H5Nx4jBd4qoM/eQD2wvlXKexFRNjWE=;
	b=PEov/OdGO6w8WFYoC04Tiw7OaBMMbbPiRVoYyKePfJMQpYoQdX7f0FOCgLOssRN4Zvek
	 mQY6LemaEizAc6JeK45BEmGCAn56Q2wLQOkqPsfpMK7id2dcVgS+piOkcMM4eopjUxL5Q
	 IWuurcIn4lSKlAKEd+zJEm+SINkKwaz8dzgqs5NtAhdvtL8e78DWhdW1QbEoa0HcerBlJ
	 0tV5VoR2hHMWuf89NWEQWgOlONmjsS5UuMF0PoEClrmNB9KAIhIgC/cErF4k9APmZnkPu
	 MdhH7lXEi1JPBESe6d3YNfUE8mhR0Losi+eNOkbA42mw3LwGYP2Kobzb78HbmJUkIBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtJbyUwf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481C606A320;
	Sun, 22 Nov 2026 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtJbyUwf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795346952;
	b=EZNr8i+vTaYoExz2dyp4fsFIUYi+LQl7ceSaJ5HehQu10L2TAKm49qyfIVg+LFFhEo1i
	 RGlidSJZDtajSb9yACylFcDimdBonV2GQMAdGbnhCzqkrjAGC8ejr3v0DymgStBn3tMrq
	 pXLD+bR3sUo4yjIOTbvnupOllIyZYI7wZcMEpLZoQyYsCLJ4N/VnxsHVqRV3DKBzMS9gs
	 FcAV++cNRowC7SIDkY8/6esbA4mFTe18fDDrnSg0evIxkC4ran0GyIjexne6zYURsRQl0
	 VgNW3XHf0ruBKNCvqSZ/bHHu5foLixQ9TF1g4TEKeYQViWUKajLlXBcOsVxpYWgi4Cg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795346952;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=RUES/23o4ev/4H5Nx4jBd4qoM/eQD2wvlXKexFRNjWE=;
	b=J9gBNaXh/fXTrredA0QALkn5LXSLVN4ob6m6nX8NaTSMNrGzZRe2YSggHRZPh6x/RcDV
	 jlS9u4Bd6cOnreBa2UMbKq4WBbXJXajoh0wbgbh+xTcczIBJXcw8gj+l7GXWG954syGoL
	 WjCdCMLS5lW0mx/xDqjEUzrCJ5ILhVT/rY45lr2AlXeGQNTQKOB0Ry3da/LNkGdBnaRIw
	 rU2Tef0TvXFsaHy5n40rNO1qSfyTYDDIaI7wZSdU26/8UrY4ccfRphKj5fq7PysTRt63I
	 pUejML81c1QeNhuBRQbh6ec4mYQAkjdHpNj2G46/Leus9FddbP0Zz3caPim1wAl14MQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8818C1F000C6;
	Sun, 22 Nov 2026 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795346952;
	bh=RUES/23o4ev/4H5Nx4jBd4qoM/eQD2wvlXKexFRNjWE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=MtJbyUwfC5QUbfUnQnCwba1qh/RdogkBQ+6rtLfW42X0Nss6zWJcKUgt8eHqVS3tk
	 sXwHOQKzZlY3hUABndrncL8bbhTGICQ5q6rGlCsBlJw8MGchJufiW85XhcfV+5MT+/
	 pR66k+XJq1xlrZbhbbq99XCK0b8YqcDKHqoHpUdq94/b2WSDvd6cYrKxI52KetOFY7
	 am7sJQ6/TaqE1jmDtvQwTnLivulNOLKrXlWzwjAsfWGb4eaai8TgcLoDfe4fy20KO2
	 ljSnk4uu4/s4Nj43w/7eFiZc3R+LiIE7xobbbhZN+gpimL/6PAoYOuRwfc0Kf+m7Xr
	 8QqMQ7diqOsdw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB07C4C004;
	Sun, 22 Nov 2026 11:29:10 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Subject: [PATCH bpf v3 0/2] bpf: bound arena allocations to the user VMA
Date: Sun, 22 Nov 2026 19:28:34 +0800
Message-Id: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-0-1f94ae9a884a@pm.me>
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
X-B4-Tracking: v=1; b=H4sIAOLRAmsC/yWN0WrDMAxFf6XouWK2ZLTQXyl9kG159UiTYndhJ
 fTfm2yP93A5Z4VurVqH02GFZkvtdZ62wccDpKtOX4Y1bxvIkXhPhDGgY4z3gtpsUlxuOo5zwnm
 OuDBmpZzIy8BJ0EvUpBK5kIfNeG9W6u9f7QybAi7/sP/Eb0uPvbPfonbD2HRK1x01G/WJO/xII
 XgXCkugrJ/kvAQXSIgtDEwDi1rJeTB4vd7hg/Mn2gAAAA==
X-Change-ID: 20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-16baca6b3f21
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795346949; l=1499;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=COKNqL4nI/46X68yJCZPIZvXWvI3Jps4kTw9tNbbcx4=;
 b=EUNVg8NGYoj2WTffKgAt+mEAWKVgMBjshnXixmU9nBKOR62IA2jKTlLhlD62jRiONzl969mXP
 GwS5SCeS8w7DywrzgUEUKTX3djnCXlWbv/XxOg1AU7trC7c+JLHy44F
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
Changes in v3:
- Correct the 288-page boundary calculation and describe the vmalloc guard.
- Distinguish out-of-VMA allocations from 32-bit wrap and limit claims to
  what the local test establishes.
- Remove the unreachable arena_adjust_tree() bound check.
- Point Fixes at the range-tree conversion and identify the test commit.
- Split the regression selftest into patch 2/2 and skip it when arena
  program loading returns -EOPNOTSUPP with JIT disabled.
- Link to v2: https://lore.kernel.org/r/20261122-b4-03-bpf-arena-vmalloc-oob-v2-5f6209c1a20e-v2-1-b2a9906e9676@pm.me

---
YanXin Li (2):
      bpf: bound arena allocations to the user VMA
      selftests/bpf: test arena allocation after a short mmap

 kernel/bpf/arena.c                                 | 25 ++++++++++
 .../testing/selftests/bpf/prog_tests/arena_mmap.c  | 53 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_mmap_alloc.c | 32 +++++++++++++
 3 files changed, 110 insertions(+)
---
base-commit: c44104f3642da720164042623e4832836aefdd8e
change-id: 20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-16baca6b3f21

Best regards,
--  
YanXin Li <fadouse@pm.me>


