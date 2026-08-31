Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60F17B50F;
	Mon, 31 Aug 2026 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157998; cv=none; b=pZcSwbFzQY6t2cIe5AVrr7L8TnM7ryEOnhxuWyUlt49aPMH0/FfyACzs6x/B+JQPKZu5BhT+EY+9od4pxwnhKbXLLMp39xTfJF9BgFW2TFwU+IyR+phVR42MAEJFMB+SMMNp3u5y9wpxiWgSVOn0MrKnJk7fjDdDlmO3T+jUEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157998; c=relaxed/simple;
	bh=k0ofD+FWP8VLGptuvb8ssju+Ux67B6q8CR/YgQGxxtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Itdb0OfwZV6uPmRPqB/XktUm4VZzoRfCyHU9krJcaOu2AXwgULCbF1qjSNLMhZL0kvcO9uC0gR1JBYtcprMI1oR7ZaJFHSc+8Bdq198qmX5H20EHwXLit7UPUSvPQv7mJq3PuzNA7z5cYTYnb8jNoVLvW6NfSSBYWR6w14TMQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hgbJpud2; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hgbJpud2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ux
	nda73GfvtayzPKA4MDGlGultGKqXadxGLD2XxdtiA=; b=hgbJpud25Uj8GrLMIr
	LloMEtjODE8OgwF0YNa8xYy3zPZ1/1U6uIueZDRKTEnalXI/rNkdGavEqs9jTPlG
	RzQXA0EmcHZIYoIZykaH+iGxOwP/7fKptPLhB15wIGM7clzprIc/iwNtohTfck5i
	9+hecnVNxDCzHbSED2a6RcmUE=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHMGIDIJVqTbDjMw--.5247S2;
	Mon, 31 Aug 2026 14:32:36 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH bpf v5 0/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 31 Aug 2026 14:32:24 +0800
Message-ID: <20260831063226.621309-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAEf4BzYLUTO+6bcp8X8M_wbc=JaxZMo4PZCgS0e-t=8zMO9tSQ@mail.gmail.com>
References: <CAEf4BzYLUTO+6bcp8X8M_wbc=JaxZMo4PZCgS0e-t=8zMO9tSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHMGIDIJVqTbDjMw--.5247S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWDXw4rXF4rZFykKrW3ZFb_yoW8KrWDpa
	98GF43WrykJr4xJ39av34UJrZ5Ww4rWryUKFnrK348A3s8Wr12g34ftF13XrnxCrykZw1Y
	q3Wjgan5G3yjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG1v-UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gQJxmqVIATjawAA3+

From: Yuan Chen <chenyuan@kylinos.cn>

This series fixes an integer overflow in BPF queue/stack maps.  The u32
head/tail index is multiplied by value_size to address elements[], but
the storage itself is allocated with 64-bit arithmetic.  When
max_entries * value_size reaches or exceeds U32_MAX, the index
multiplication wraps and push/peek/pop operate on the wrong element,
corrupting map data and leaking stale values to user space.
max_entries == U32_MAX would also wrap the u32 capacity counter
qs->size (max_entries + 1) to 0 and permanently break the map.

Patch 1 restores the size bound in queue_stack_map_alloc_check() that
was lost when the check inside bpf_map_charge_init() was removed.  A
single division-based comparison covers both the index multiplication
overflow and the capacity counter wrap.

Patch 2 adds a regression test for both rejection cases.

Many thanks to Andrii Nakryiko for the careful review and the helpful
suggestions: the bound has been simplified to a single
`max_entries >= U32_MAX / value_size` check, the selftest asserts the
bpf_map_create() return value directly instead of reading errno, and the
selftest no longer uses an unused opts struct, inlines the 1MB value
size, and closes the fd if a map is unexpectedly created.

v2 -> v3:
  - also reject max_entries == U32_MAX, which would wrap the u32
    capacity counter qs->size (max_entries + 1) to 0
  - fix the Fixes tag: the guard was actually dropped by a37fb7ef24a4,
    which removed the bpf_map_charge_init() call the check had been
    moved into by c85d69135a91

v3 -> v4:
  - simplify the bound to a single `max_entries >= U32_MAX /
    value_size` comparison, which also rejects max_entries == U32_MAX
  - check the bpf_map_create() return value directly instead of errno
    in the selftest

v4 -> v5:
  - drop the explanatory comment in queue_stack_map_alloc_check()
  - selftest: drop the unused bpf_map_create_opts, inline the 1MB value
    size, close the fd if bpf_map_create() unexpectedly returns a valid
    fd, and drop the verbose comments

Yuan Chen (2):
  bpf: Fix queue/stack map u32 index overflow
  selftests/bpf: Add regression test for queue/stack map size limit

 kernel/bpf/queue_stack_maps.c                      |  3 +++
 .../selftests/bpf/prog_tests/queue_stack_map.c     | 29 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

