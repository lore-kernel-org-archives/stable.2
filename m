Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2C4E236B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610839; cv=none; b=mDdPGaIxdKekrzCY07W2AWg2vjigzekl2kzMVdnu8RsUo9AjVfzDWDEKOCMhS8wn/GH1Ob+z6AkBPT5iVp+y7MF7556Fdk00YbyJ9+crJfORoX6/fchsV6e3QWJF9LnbS1H6I/2Da1RVueGVLGAAt9LSTKFfw2QlKewFclXE3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610839; c=relaxed/simple;
	bh=4gppzRtfi+OooFdc4Jlje8h5Xg6dJP0tobF5btgOxgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnakYCcHwauL0KWQ70l2neiLayfQWfqUwY+AyP2DVfFqHq1QAeDtDZALMAiXyvmvuQgXgfC9CI31GmZhP4ZyI8lf/4ZsTPCM+rYPq3yRQacsLJIVD9c1ivKG7qdPV4vA5JdDrBpNU8DxgytOc56qFTR0lUyyscixmTpE5TzhPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrnaA7T7; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrnaA7T7"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd54610so1073973a12.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610837; x=1791215637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zP4g8lXekauiwqdnSJjEc30nFtkgnAZ2P40l4bqb96k=;
        b=HrnaA7T7E+8CbuFAv1zuCqrgD7WstNAUn8a7HYU8Yytc29T74j0MW20pUEJzscF/KG
         Onz/Nlsyn0R3MdKdNOC8UfhHJ1dIpkbOtM00YpFYryJ037K/W4oJMlw6PAQpIoQwWled
         ptbmIF19hGDYS35oF824tJBEvO/yLG/GzhksTot40y0/cLJSMhkpLtfd64UdA+vi7wu7
         Xo3wx68Uw9BrvsgPnt6YTJCMcmiUzFDjK32XMENeCJuKzao3gRNPm7Iug8glqZb8EmeQ
         92HXaJLkjp/0Xc9pjuG/ADZnIi1HvCZA85oT4n7Pdu9/pLokqh0zpABL8fpA7YDYB144
         ceUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610837; x=1791215637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zP4g8lXekauiwqdnSJjEc30nFtkgnAZ2P40l4bqb96k=;
        b=BSrMkxGLf4jKTgtGeISbTB1nA6zI8D/adb3z66r6ilJpK6k0KxD3NaxydzR/I0Ol5k
         OgD88NLMWfYBbTcT8D0Td9y5496FLCFrr3QygWw25Z5OQIHhTnp3LnIgB3WbA5q/p3Mu
         lq9acqREejuUsIPLvqUpwehx4H4fQNcU6kKGsW46K+xOdha8vg0ipZRxNGZoUWtOT0uq
         Cwc6nsfPrg6fsH516dMJrFDWt4tYm4J+iB1t9jpqe6ILflMqXbuJm6SCXNZnVGmd1AY6
         evawViTjJgaP8lPJVokA2946Gk0VFwls4prUcW91jisqGad7FDRI//GBnG49srm95x0i
         Phnw==
X-Forwarded-Encrypted: i=1; AKwUvBzdvd50cWsyvNOnhJbHZar6/egF6UnrV8uxM9e4a8EySRrLHw2MItqNdIuzutwYNsMWePqfCbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbn4BjVw1Fx0NfzvCdJL8ocjONY7yKnig3k+S3AaXjs8T5hH/A
	tx/RMxMSTesn+toGwVrc5A/HMXdOjRc1woszxUt9kGJu5Zp5J87Auhwg
X-Gm-Gg: AYBFou2Lzz5bvFCxs0RpXimO6/CxUNcwQciG6fi0sVz2zRJ+DbqdopmlAaswidEqfzP
	HjAydYAqSAUfpKnpkx+9GcJCEl7okasEWpel/Vh4Dr6bwOKUOdSMPvldiL2yrbNrw790noCE/NL
	R/kmIsY0r5kaxu4F386SsrDqb+62/A/kpu2jcCDv2YjzfrwMU00shQSZ7Q84TeQTNzcz+WqocGt
	RF+0ddRDSNTMnyX88vhI8Kp+ebJzRVOo5QaF8tYE4Il9WhuKaQHL2oFoy3JZVS/niWZbdWV2Lx2
	BndnJ6wqDBPfEJx3+fSGbh3a1ld1r91d2BIdOAGuHVieLNwzC+ailZBXwria+f4RFumMnPutuDU
	4iSd8P4ltJpTRkbDp3CvS0x59esznzE+X22nGEFq8ds7Ql4Dc47mVYxpisK2mmm7+TDEPGulJub
	vHlRFmGqOqbE2miy6BpRnoYUxq3oPQwYx5GZ55ml+PiBgQLGkyLw7t4ubuor2JrqHBTOZK0C4uX
	gZvPtjoEywebfnq0k3jfx+B0CYJslKNqAs=
X-Received: by 2002:a17:90a:e7cf:b0:3a0:e243:28fd with SMTP id 98e67ed59e1d1-3a0e243355cmr3530151a91.36.1790610837089;
        Mon, 28 Sep 2026 08:53:57 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1905sm44269a91.13.2026.09.28.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:53:56 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Dongliang Qin <cccccccccccc777777@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bob Pearson <rpearsonhpe@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 0/4] RDMA/rxe: Fix MW/MR lifetime races
Date: Mon, 28 Sep 2026 23:53:47 +0800
Message-ID: <20260928155351.3222978-1-cccccccccccc777777@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Soft-RoCE keeps MW-to-MR bindings and type-2 MW-to-QP references across
verbs operations and responder packets. Several paths currently assume
those references remain stable without taking the MW lock or reserving
the MR state. As a result, the responder can acquire a zero reference,
a bind can race with MR invalidation or deregistration, a type-2 MW can
outlive its QP, or the pool can force-free an object with outstanding
references. An unprivileged user with access to an RXe device can use these
races to corrupt kernel memory and escalate privileges.

This series fixes those races with four focused, individually
revertible changes:

1. Move MW lookup, validation, and MR reference acquisition under
   mw->lock.
2. Use num_mw as an atomic state reservation while an MR changes state.
3. Invalidate type-2 MWs bound to a QP before destroying that QP.
4. Stop force-freeing sleepable pool objects after a timeout.

Patch 4 is hardening: it prevents pool cleanup from turning an outstanding
reference into a use-after-free, rather than fixing the reported bind and
deregistration race directly.

Before the fix, a concurrent MW bind and MR deregistration reproducer made
KASAN report a slab use-after-free in rxe_mr_copy() from rxe_receiver() on
the RXe responder workqueue. With this series, the same 120-second test no
longer triggers KASAN. MW READ, WRITE, partial READ, invalidate, and rebind
still pass.

Dongliang Qin (4):
  RDMA/rxe: Take MR reference under MW lock
  RDMA/rxe: Reserve MR state during MW binding
  RDMA/rxe: Invalidate MWs on QP destroy
  RDMA/rxe: Do not force cleanup on pool timeout

 drivers/infiniband/sw/rxe/rxe_loc.h   |  8 ++-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 70 +++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_mw.c    | 99 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_pool.c  | 14 +---
 drivers/infiniband/sw/rxe/rxe_resp.c  | 38 +---------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 15 +++-
 6 files changed, 159 insertions(+), 85 deletions(-)

base-commit: 93f51579e7df2
-- 
2.43.0
