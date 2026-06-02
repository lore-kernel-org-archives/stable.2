Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3025B09A
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429159; cv=none; b=e63ezMyQji8M+vfvZgpE0k97P3hCej0Zm+nVJ+YzQ7zSKJH7g9bEwKksOM1mJBx+7fNvwUzT4WyMmEZGqEAm0Iu8KslIQgnhKwMAQhDBvVljAurVEdNrb3mJEZVnft4h+NLe9kRgvXXRk7NFzy3CK6fOpjo+BN8uXfQQZvUSSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429159; c=relaxed/simple;
	bh=efKRPUDTPUoGOcVDERs/7DG/6rThtLMlbYrSuiPb8cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vE6HAjxBnCJtVR2s3G9AsEWtH8bkPYVQ9OuCaQDjjcXapqlFiK40faRJ2xpwQ6yVMHc3VZ9B7711BcVy5RRFzQPkYyNRgordJJAQhDFYgSz3s3/dv/V69r+QLI1UEgYIv1U0+XxhN/J86qVcHpA8IBOMZgCsKx1mew7LY30fn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCYvDT6K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCYvDT6K"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so6878256f8f.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429156; x=1781033956; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37nV9vxfz0/ekkonDlO3tYm5sw+ScB5jVbCrede1ePM=;
        b=TCYvDT6Kw+3Ytc+tSP11YYLo2OdT4eM+DDOBx1VLZn1mkNx2q+AXKbu94tjZg4Yk8r
         2RuzFfMmhy7RNjAWl7wYCp/pc65AwKxL7iSbi6NfrLmzVPasYZKPnDsdmn8XtC89QvUN
         MYiQloNU8VtUUYY/MmPzw70/7+fbspAtS9SYIiM6bnPvZ/fmHJaCAUQkkWqWIk1jblg2
         ezrvoA2s4tANbYBxtA1WDT9CxdEKPL0K9iXdhSpQBhv1ygVZNVMu5ZZiV3GZmDlyliR4
         F3KnBFQfzqZ+tfc0+vQygap+WZbGh0Z/K9Q6F7s/jDcuYb5gyKAm3syqc9pGmGS3/67G
         ChtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429156; x=1781033956;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37nV9vxfz0/ekkonDlO3tYm5sw+ScB5jVbCrede1ePM=;
        b=hE7mO4XhBh0rOVc3gMoHV8CY1ecR1cxpXSkdzXg5bjBYIr4aYZmm2Vo81rPAqtMGCv
         uDfEMzBchOfq6SO3ay+uckwJ+1I1dLtv8nOrftVBWhRz0/xnMdfhF5sFYILkTd0iNxS/
         frTWNhdWzqOQ38ryQo377kRcwZ4z/uQKdsz0gcop1Dw4WTO+8QxjQrjaFSX7ZYKNomDc
         v0/ZLwVTfkJIVrA1NLYV2rwtk758UFoXnTwrczgIKiTPpWZWzMonggKl9C0a1vFTmMZW
         /Ohi8NoaeWixr8ABtv9x5LCGIsPXkIp7ZQ8he88+IW0RW15PkF2WKLIu8sWTnGZLcP6j
         VAKQ==
X-Gm-Message-State: AOJu0Yx6/V+PG6wi2n0M7F19TuSl6YzzFbgGQkHb4lwUAPh1+lO17Y/V
	xItUnJtOERYQn147NH7W2QOHBVvI2TE9g69fjuJyDBzPTpP+xrmZgvWlM7xzTW7t
X-Gm-Gg: Acq92OE37VnMA1BYq2dmxSmEXTncNx3G+dSsYR+Mj+trtvc+aonMH0XdNbor+av+kUc
	FW8h/tJJ9q3/Q+3cwBX8NpBpn+ot3d8/qJqaW33FxXHjhzJhS4KiXF+NEr+tReTiE1y/fpn0Evq
	Ev9d6XaXFkuposAML0ux1Q3DaSmyw8lrdg8zgGv+Ojpvo4bPSEgje0S+wctnPCNMy+Dxq6tyqX3
	yLGzXcNHxGnbcaosdP4do9NBPpv6NHzYbmHlbpNx5s0fo9O2KNEpJEobT/nUoctujiNXZSKQvhQ
	LVppfs2R3xCe6ukpyED9wcmsO4WHN6ZDA49OtSTy7cvk0nrGH1UJfjNm7E/TPhkpHzMWiS/I219
	kIM+tpxkicB1X18rCb23LFxEkvwb6iXlQ2NIFtiW9QjHsTY3khb/2xMEhlkArgix9zZy+CVerha
	7SoAToZjJ/kFK6ZKBcEJSF95baVpW0zqCh0gDgeXFAt8giSZk/3QCXzcZkeM8cXPVkMllJMJuxt
	3js4oGiCOKObEhKdzyEM0GsUd9KBOpNGHfByHGjtH2333to1a2yG0BIKq5v2B0rsCVxWFiQHYDn
	4IOjDDzbq1u1YrfbctIJFhf2l+H4edKypBYIFfA9h1tDYIopNmnKDQ==
X-Received: by 2002:a05:600c:35ca:b0:490:44eb:c1dc with SMTP id 5b1f17b1804b1-490b5fe1fd6mr3859195e9.20.1780429156275;
        Tue, 02 Jun 2026 12:39:16 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b61511d0sm1823735e9.2.2026.06.02.12.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:39:15 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:39:13 +0200
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y v2 00/11] Fix BPF selftests
Message-ID: <cover.1780427227.git.paul.chaignon@gmail.com>
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

Changes in v2:
  - Fixed the conflict resolution on the first patch to apply cleanly
    on 6.1.y.

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

