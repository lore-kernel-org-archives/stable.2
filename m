Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01030E0CC
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392529; cv=none; b=XrbnkuTk5lAYQckXqnID3C3fI78cciDvlNeTnOSdswj9WxJReOaoMSQNpm2iQrm9XUvs4c0TFjpSk1K4BrFj8cOmvxyFYudueQyCx65pcvodrn3Zz7tyupqUqFwTE/VNThtKiGo2/Yd63BD45kdbudIs8JtLwLUVvOwx6ilqFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392529; c=relaxed/simple;
	bh=Oiq4HEgaRf9tjh8x7ZlSbBUshrck7Ju7Cqde2lx6qMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oyqn/DKnTj23W6AF4KKzecdSUg536BvxoUUfva/qgnHWi6GEUK8zvbmtx5Cmbdk7UmGH9esbIVwQrJC0+BvbIquwE5GdrXuf72pPnhtNSuLv+0KLbD94pzH4sIdtJiCzhNUZteSH0P9GCywrQHSoB1xbOjhiDHhz3q4mCSpUJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGMM1plB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGMM1plB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso19323665e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392526; x=1780997326; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHC7I1CVe7v05xLZUOjp28bBF7y5MMCiMICuX+nCrzM=;
        b=jGMM1plBZADST9MQ1CVoPvZrV+eXC39xaNIzLj35n7NAm9sig3mQYYmjHN765rrdje
         jsxdZgjhdNO8sr6aYnYpKWbCdpPvKexOV9YrSxjwPJIYefDiMxO0fFVnjqUVJJ2HDiei
         0Czk2iDcijzGcUacIRqJr6zMgVFLDtxBoLrZXaltTkxJtkxBq+qO4O9yzkV2vkvLC9vI
         wSJPBO+cue6vCnTkYxp75jpvqiRgMHi6iq4b3sLxZQOgCuLpwNTMoRAq2R8eYUjk3h6S
         rG0sQrmQxPBoat8VAzrM0/OO+vrQ5IzEylDivE1Z8PL2waNQp/P+TL/aUgjjH4v4psEr
         +lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392526; x=1780997326;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHC7I1CVe7v05xLZUOjp28bBF7y5MMCiMICuX+nCrzM=;
        b=RZH5Wy5M5C/VydSQaWKXAiLhpEqUoNtvRA6w8nTThnKpvtw7LTcV5euKaRHsnBsRfa
         ov0vqEs3A6v33M4Tn6Annr6HWENTD2hTmGFqRkHWOsuR/UY6zqLkUajl+r28VU4YKiyg
         x1fHPgzN1OPMOZggdxH9dRgjhHXa4TEjYSIqkRg4PQDJuqZGVvfguq4hKqE9x4b8xltL
         a2a/lGDxdtFhXunsRhokQtdyOeWUER7wpxSHLdyWCgQDTfToFAtCc/jmiV+ZGFYKxgs6
         ev2yhviKP7EhVR/TZG+wkCKWFK7Fh7YJ7XwVKKnxKZerIbAmvdCZHGjQWejq9CybsCEx
         1BfA==
X-Gm-Message-State: AOJu0Yz6LllGH0x1+YwGRMa7+RUDKH2n66OWycQmRplu2sEShW5z+/fz
	CmM9rxqwJnhAlWCamQ8ibo8g+DFebh8mvzL/vS+BrKCU0efjeLevK9V+OzW6tRoC
X-Gm-Gg: Acq92OHpOgdbmKGvRpQNoBg25Z5nA1axIITYZdVPV/UyHHsc+48hhnbmmI351C9OlzV
	XtYjYBnYE50hGo+L4Zsc56LbSHNmuf5DRvhnukh5wIHFpNTGQjy/lRihP7Srg3asj0ygXp3h0JZ
	Y8r41Qfmtuf8dLQ3TiH7+vWs5Ximki9C1hlqrIAFeL3rTN+s3Af8jTYgUQiZkCsrnY/+W4AN8K8
	PsugepwA6TgEpz+3kDS9ZzmB/RLMEWDX0eCuqrzqjtu68ll/CBP7PmCXFTwkm0ctIu3T0tK60wy
	C0SrcYguaIulJ4ilg8b5R17j9X8BrqQNiTBuRWOZT4PRQ8JRP+w6IfT6Ko3O8GXxCbAuz1lMWdr
	4oq27/rJiJ5xVCphvWBG/slDSmJh0t8PK7lKCo9e9VjW1oHQaz2Zavpfq3mqzYVdIXSZKUSSlwz
	zYO5hamc6329NFtzeGznHQVyEBkYya/njt7lZpSBqualk4SaPCgj5Ka/Jv0rkKfIEL+2gkuJv62
	YH/wTCET24P+v7xmCyq5rg38VNrh3YBxZFk+BFiQybDXMV/2yGHuw99hmozwRtal7V452t31Myz
	pugfgRi5e5Zi5RkBIm5ckLL3NjTbMPDv8voQ9FYJMHhBFIh5qRg+Gw==
X-Received: by 2002:a05:600d:8498:10b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-490a29299acmr200439035e9.15.1780392525817;
        Tue, 02 Jun 2026 02:28:45 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0495fcsm162136685e9.0.2026.06.02.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:28:45 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:28:43 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y 00/11] Fix BPF selftests
Message-ID: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset fixes the BPF selftests on 6.1. Its patches fall into
two categories:
- Reverts of backported selftests, usually because they test a change
  that didn't land in 6.1 (3 patches).
- Backports of selftest fixes and their dependencies (8 patches).

With this, the BPF selftests are passing on 6.1 (tested with both LLVM
16 and 18).

Andrii Nakryiko (3):
  selftests/bpf: add generic BPF program tester-loader
  selftests/bpf: Convert test_global_funcs test to test_loader framework
  selftests/bpf: enhance align selftest's expected log matching

Daniel Borkmann (1):
  selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test

Jiri Olsa (1):
  selftests/bpf: Add read_build_id function

Martin KaFai Lau (1):
  selftests/bpf: S/iptables/iptables-legacy/ in the bpf_nf and
    xdp_synproxy test

Paul Chaignon (3):
  Revert "selftests/bpf: Workaround strict bpf_lsm return value check."
  Revert "selftests/bpf: Add tests for _opts variants of
    bpf_*_get_fd_by_id()"
  Revert "selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid()
    test"

Stanislav Fomichev (1):
  selftests/bpf: Update bpf_clone_redirect expected return code

Yonghong Song (1):
  bpf: Fix a few selftest failures due to llvm18 change

 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 -
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../testing/selftests/bpf/prog_tests/align.c  |  18 +-
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   6 +-
 .../selftests/bpf/prog_tests/empty_skb.c      |  12 +-
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  87 -------
 .../bpf/prog_tests/ns_current_pid_tgid.c      |  73 ------
 .../bpf/prog_tests/test_global_funcs.c        | 131 +++-------
 .../selftests/bpf/prog_tests/xdp_synproxy.c   |   6 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   5 +
 .../selftests/bpf/progs/test_global_func1.c   |   6 +-
 .../selftests/bpf/progs/test_global_func10.c  |   1 +
 .../selftests/bpf/progs/test_global_func11.c  |   4 +-
 .../selftests/bpf/progs/test_global_func12.c  |   4 +-
 .../selftests/bpf/progs/test_global_func13.c  |   4 +-
 .../selftests/bpf/progs/test_global_func14.c  |   4 +-
 .../selftests/bpf/progs/test_global_func15.c  |   4 +-
 .../selftests/bpf/progs/test_global_func16.c  |   4 +-
 .../selftests/bpf/progs/test_global_func17.c  |   5 +-
 .../selftests/bpf/progs/test_global_func2.c   |  43 +++-
 .../selftests/bpf/progs/test_global_func3.c   |  10 +-
 .../selftests/bpf/progs/test_global_func4.c   |  55 ++++-
 .../selftests/bpf/progs/test_global_func5.c   |   4 +-
 .../selftests/bpf/progs/test_global_func6.c   |   4 +-
 .../selftests/bpf/progs/test_global_func7.c   |   4 +-
 .../selftests/bpf/progs/test_global_func8.c   |   4 +-
 .../selftests/bpf/progs/test_global_func9.c   |   4 +-
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c |  37 ---
 .../bpf/progs/test_ns_current_pid_tgid.c      |   7 -
 tools/testing/selftests/bpf/test_loader.c     | 233 ++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  33 +++
 tools/testing/selftests/bpf/trace_helpers.c   |  82 ++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 .../testing/selftests/bpf/verifier/int_ptr.c  |   6 +-
 34 files changed, 561 insertions(+), 347 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
 create mode 100644 tools/testing/selftests/bpf/test_loader.c

-- 
2.43.0

