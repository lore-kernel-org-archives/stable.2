Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FE488DA0;
	Thu,  6 Aug 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038603; cv=none; b=jrzCB2cnSCZEtguGLoPWOkNLfJoIUiPvzFf8dNO+llO7m/TAWVOSOB3EwSoZuBfwDQ/g76hIkAL3ZiQXckBd3RM4wlCgrBo0wwfTOWEMqddz/xL7etO5GpQthtgGTOOqJrGnH+1GCImC4ECO1ZPB/eYBxW35q8GtBnqeFRFvgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038603; c=relaxed/simple;
	bh=02qgsS8wEkD51wzpErsigtQtEXxICnIkVbKaDwzvd80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gvdd4ZXyp+6QlSiyLw68FQWgLDEPc2iuUNYMsoUZMfhWLPvxnd6ysf/XFmlFVbzNAGzZXDsOQD0xXsTuPcrT0gvYL4/JVCAiCfSaPKbk0k2UjI1abug9bL8dsjNF0p1YvQNJIfDOsgpWk+Zilbq93Z3bxYtXGgdxcy22aZxy+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6OhYPqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6OhYPqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E7F1F00A3F;
	Thu,  6 Aug 2026 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038596;
	bh=F8TiAXM26OEiIQfSONIS9MNS6RD/HRmk32N/8eNuLjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6OhYPqdn+GQvWoWvsOy0p2/U857WvEy39li6wmpQeVkvxOAvEA/iLxfQ5bu8o0lN
	 5PcRznYH1r4MX2QFfKB+HslOavDabaA10jeML3sKnCUlBRNL6cOkEZCOl4IIDFGDva
	 5ruC3i31YUrfJH53PjSQ8PkmD5lqz3gJFGr/LDRIXsbs6FksGgXIE0zHxaA/FVFZj8
	 KPN/UNOvj/oGBXnl3OCb4kbKhKYYg3JICdETUOU76jHMJh7/idUy+s0JoJbIJv/S00
	 783UbRxqbils4fwLSj0RPKoYGQMgrAv11fRSffZNtocrZBE3pU3dCyP1Jd7oEjavKA
	 mA2tuduuRQ2HQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	Alexei Starovoitov <ast@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re=20=28SUSE=29?= <ricardo@marliere.net>
Subject: Re: [PATCH 7.1.y] selftests/bpf: Add tests for sleepable tracepoint programs
Date: Thu,  6 Aug 2026 13:49:40 -0400
Message-ID: <20260806131002.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805-selftests-bpf-sleepable-v1-1-e29fa5af4119@marliere.net>
References: <20260805-selftests-bpf-sleepable-v1-1-e29fa5af4119@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:54:34PM -0300, Ricardo B. Marlière (SUSE) wrote:
> Hi, backporting commit 23b933c6223f ("bpf: Verifier support for sleepable
> tracepoint programs") without backporting this commit breaks the selftest,
> as seen in openSUSE CI:

Agreed on the diagnosis: 23b933c6223f went into 7.1.y as a Stable-dep-of
and changed the verifier error string without updating the expectation,
so the verifier/sleepable.c hunk is both correct and needed there.

The rest of the commit is the problem:

>  .../bpf/prog_tests/sleepable_tracepoints.c         | 142 +++++++++++++++++++++
>  .../bpf/progs/test_sleepable_tracepoints.c         | 112 ++++++++++++++++
>  .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
>  tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-

The three new files use SEC("tp_btf.s/..."), SEC("raw_tp.s/...") and
SEC("tp.s/..."). 7.1.y does not carry 0cd420a6f40c7 ("libbpf: Add section
handlers for sleepable tracepoints"), so its libbpf has no SEC_DEF entry
for any ".s" tracepoint variant, and sec_def_matches() will not match a
".s" suffix against the plain "tp_btf+"/"raw_tp+"/"tp+" entries. Every
program in the two new progs/ files then fails to load and
test_sleepable_tracepoints__open_and_load() fails outright - so as posted
this trades a test_verifier failure for a permanently failing test_progs
test.

The runtime pieces are missing from 7.1.y as well - 439ebd5b5708 ("bpf:
Add sleepable support for raw tracepoint programs"), 12628ffaf98b ("bpf:
Add bpf_prog_run_array_sleepable()") and 57918341dd19 ("bpf: Add
sleepable support for classic tracepoint programs") - so even with the
libbpf section handlers the functional subtests would still fail.

Could you send a v2 carrying only the
tools/testing/selftests/bpf/verifier/sleepable.c hunk, with a note in the
commit message explaining why the new prog_tests/ and progs/ files are
omitted?

-- 
Thanks,
Sasha
