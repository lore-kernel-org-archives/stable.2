Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC03E317C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223523; cv=none; b=avrLOu4jjYPtCdP6ss2Tt6zJWL3FfiLPnc9zI53Z/AZRtsTcv3m6391udhlNccWeu47VzvlNmejyHwkL3+r5XJP9nwe57SJ5iYpHToIds5lwktnJdvLwy/VZzCh4Gr4zu2dm+BG+xHCqql+bOsarJ5ZjoWOOx5oZGuKNzThXOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223523; c=relaxed/simple;
	bh=YuliLND1Bl6MezWlvtJGFgFS6wgpb9uVyWOQmOxmWUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQETcJq+BPHvC8bQHgcRaX5nkW67Wxosnd8m+wl7f0HRRax/7wBQWrxjg5xxeIU8lXeox2FeNi5H6SbPoTFE0u6MH3qBGHMGHzv4ZeU8vLgERRXqlsU+6ff17jvuj6nbtyqu4BrmhCROFdHa8uDclYjaVQR0xRxFW8UB+4J46Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z8kv7+IM; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z8kv7+IM"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c16772d888aso191352666b.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785223519; x=1785828319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgrTZjeTu+Z5VPlDwJc+vz5u8K7+70QIRYs8DoHrZDY=;
        b=Z8kv7+IM5drc0cuqOznFaSKk1sjHXKipD1A+d24cKDGTfXRB5yK68rkeJJ3T2scja1
         KlAqOBG/95FfhLLA1QfRgdEoZWtA7ew/NH35otOtPgejeKb68CBTz3uihM5RdAz7ockq
         Y3hFHMHR7ye5QzY71NpG31TBpBVYi5IoZjl6CvoMmleE3x7bc378euHtdvAUxjw7yzWx
         tWb0tq+zDuRwTZiDEWyxnEF85/PMTRvsmUJXxo0DjCKU7hfyt4akkHyrJajNEKrDwUzV
         eYgQbo5zb4sL0J6M/uxw4oN8DRWYbzDfSJ9yzOe7wD4fe/Tj8YxhK0BQHmMtvJy1XToe
         Pnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223519; x=1785828319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgrTZjeTu+Z5VPlDwJc+vz5u8K7+70QIRYs8DoHrZDY=;
        b=WRPeFuOn9id6Uf+jRQCQRmgQoYAXTnMcLvmYSnZqNyrdD97SLxo/ROuINUp0AFrANR
         te4wAjtH147oAMbx6y7QtonvFE/Id+AEg9zrERDSnTPsaeKgfW7EuNHRz1NV0gFP0nQw
         NbqqDnhVY3MhA95dyA/fTHM/BdYzoSh96sx83PewJwDOLqAkj+PhTRqNQ9Sk/CIb7iFw
         AL4F6lX5q/yC/TC2JG3a/hFkrpEogKaMCVPRYQw1bYgqCyM0TC/BciMRu2meUrVs6Bu1
         rmtrACYxkNzjzKRll7YrFIsxufovrFEiFPwGMYHQ1e/Ik9vFxIkHV6q3Nt+lKAzDG8Mm
         uFEQ==
X-Gm-Message-State: AOJu0YzDABk9DrGwyItFVGdoQNDs1yaxGKk96TsKMU6UbXSMJABdACZ3
	KyavUudAtMU2vOQEITmqB7+sqUcz3+oDDVyxZMuXPbEzGBqUOA2QIUyN1F3sQFcyo2pXCtjdJLL
	FS/Tubl1IKP5h
X-Gm-Gg: AR+sD10S2rT5AH+4w7Lwt2asA3T6WOr24u8y7i+cHOwR1kpn0t1rGH5ms5rZLP7r5+U
	J9nWIqX/fC8877IlxKgy8lIEMH8FI7AI+xrrfd5hIFVd3XorHtFOh+d3d2IuPodi+nZOrAut09q
	sstZZ3Gx0D18zzGz26tg6XD8VfjvRjUD6OHTT2sSNWlGTMnNCb4H2K7f94Ch8zlUCoDG7vyP7Q8
	MdttCmQUE77rdKPaG1MpMsYnMmJPHGLKboCXBGsFv/zinxjqU1MTZisGeU524CG5PMT3YT1CkWt
	V21kjOLOV8qIVHW2AtwOFV8+nrsSiXKirRfR3iUI9NmnHPx3aTdIkR8+POi5iX8AVA8LXVoJuUC
	IResi2AhvTHLdiGdvhJBDDNDC58WMO5sw6yAFZKa4s6t9kdxDJqA7Ho5T89Kipnkh8qk6NUexXt
	BkuTZoZL8jEFSVT3wk2035QMAbNkB1yYo=
X-Received: by 2002:a17:907:e006:20b0:c16:8aed:cec3 with SMTP id a640c23a62f3a-c1f724d7c82mr30661066b.58.1785223518801;
        Tue, 28 Jul 2026 00:25:18 -0700 (PDT)
Received: from localhost (27-53-136-186.adsl.fetnet.net. [27.53.136.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344d3a7sm4069282b3a.52.2026.07.28.00.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:25:17 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 7.1 6.18 0/2] selftests/bpf: Fix verifier_map_ptr failure after bpf_map excl field backport
Date: Tue, 28 Jul 2026 15:25:07 +0800
Message-ID: <20260728072512.33620-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF selftest "verifier_map_ptr/bpf_map_ptr: read non-existent field
rejected" currently fails on 7.1 and 6.18.

  VERIFIER LOG:
  =============
  [...]
  3: (61) r6 = \*(u32 \*)(r1 +33)
  access beyond the end of member excl (mend:36) in struct bpf_map with off 33 size 4
  =============
  EXPECTED   SUBSTR: 'cannot access ptr member ops with moff 32 in struct bpf_map with off 33 size 4'
  #630/5   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected:FAIL

Root cause is due to both branches having backported upstream commit
0fb6c9ed6493 ("libbpf: Reject non-exclusive metadata maps in the signed
loader") that adds a new "u32 excl" member to struct bpf_map at offset
32, which pushes the ops pointer from offset 32 to offset 40, but
missing the update on BPF selftests' side.

Patch 1 updates the expected verifier message for the offset-33 read to
the "access beyond the end of member excl" rejection, making the test
pass again. However, that alone was not enough.

Patch 2 is the upstream follow-up to patch 1. It updates the probing
offset so it actually reads the ops pointer again

Tested on 6.18[1] and 7.1[2] and confirm that with this patchset
applied, verifier_map_ptr/bpf_map_ptr no longer fails. (Note: there are
currently several other failures, they'll be addressed separately). 

1: https://github.com/kernel-patches/linux-stable/actions/runs/30335038494/
2: https://github.com/kernel-patches/linux-stable/actions/runs/30334621104/

Daniel Borkmann (1):
  selftests/bpf: Keep verifier_map_ptr exercising ops pointer access

KP Singh (1):
  selftests/bpf: Adjust verifier_map_ptr for the map's excl field

 .../selftests/bpf/progs/verifier_map_ptr.c    | 36 ++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)


base-commit: 155b42bec9cbb6b8cdc47dd9bd09503a81fbe493
-- 
2.55.0

