Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4843AB47B
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142348; cv=none; b=QTjVlSE1fhQAWO+hhUBB6PZ5/C8tRbn15eDbFjPIPezyr4mtEbXJp2RYkkM46DW+duj62l+68KVQKIZaZdnFfG2VMZdjsq4c3Wm5ZsFBQFd9yj7QJfP9/7Y941VEBpf3jPeiVgv9RwscLA63Gfo3Zw1Tj/Dl7wXx1SFMXFOR2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142348; c=relaxed/simple;
	bh=savuDRnwfKSJa/qxglsWugu3vmJuvxS1ktQb17RRabQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=SemRRQi8rehkxCU8PB1oRwjSt8U15GJobsLTecepyA2iYyIr8WBm4XpWRYjT9gLoplOrIPu0l1q526WqAhfNxPvAvSm/YqHp4J6/jOt3PegmwnUyLgdKXQOU9qrgxWWiNp6v2NLGZTswXh4MyMqxktnaiHuxJ45ylIbYYvHl3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=fS/tcOnU; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="fS/tcOnU"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304e6c6464dso3999495eec.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780142346; x=1780747146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gmdve74lFCWsDe2dgq/4sXRpMatg85To6sYO/aXWQz4=;
        b=fS/tcOnULj3e0bVx1LyLYu/k4HvwBXSuyN+jigEpuseRvfUvuWhApqXVEck+d97pFd
         i40PUku1VJo1DGaDBtlQKhkTkdc6Wka02Tpe+D0JuVylxOo8RZPpxHQzYsOZFf/Qp5Qd
         0PcxBmRQF8SaSdzoVLnEYk0tXQA7TAwNODRqGsf5c53NeivqvXtO8TtUsUInsDu6kPNa
         n9vuZzUO/0RmTlz7IR5AhBgqeF8piS+8L6/4d5bOXT21TfibKREtnTUY5oJ/jxfWhV3Y
         SBJqQKlN3GSNO3RdLIL3kmTpnlGJ9kvvUJI1fpIgctb/CdH3lzisNzwHIW39PkUAU1td
         uSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780142346; x=1780747146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gmdve74lFCWsDe2dgq/4sXRpMatg85To6sYO/aXWQz4=;
        b=fgf2sR87bHfK+WGWoAlQwEkbADno4NVKMMEAnh4bxfxmNMjr61nSpwcPVfz+sHJza7
         Xj8Xvz5yr3N7aSAA10X5NjFiXVCO3qzmijTMXLyjX/1URfuxnqbZK19fIMJjLcABum/Q
         H2adkKDXc5ucV99aiQ/+uaQWFVA2YhWGQ4+lO5oagErCDw3fBfNE0EfauJ+fYPRq/iDq
         siqS/RIPURAwsodsqWzfrYArXDzLSiqHx8Pm/cjrljVTRCtn/Q6rAibmZ8Fsm5tz3t2s
         xj7Z4I47zslqALfAyDLptSl+S6kyrKFbVO4khcvSu1PTHZ4hKJcApX1YQOAlvFUnQ7V4
         C2qw==
X-Forwarded-Encrypted: i=1; AFNElJ8eSYP73lp+B+T812Fjy0oEw1ToeXFvLdKNp6ByQaKRg3k6abjXNbwreqE7DM2aqolzYGD0aUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJgTx5DqORJg7sQztvNCufeOoOn1991o/reG2P490BL4bXhFq
	B5F74lBmOt6rM26/Hea3zAG/j+x9pRmMT8+C+M5/sK09pJnQhRC47uYfuHqMenj1sUM=
X-Gm-Gg: Acq92OGiIWttoEP9ycwSU/ZAwwdk3m5MbWWv+brhIwp+SvWiqo+06bHSNXp3pRca7vR
	M/HcVqSIh9hNoMRuAW+kVpLvErnzRK2PzZS8dOrKtZkHDh3RWO/CmOWG6VQMajA2gwRJE7RDels
	1m6WR9brU0bKVndoMtjt4IpiQz58hSsD7TFvgY4NMnVYS8qEbl7ivl9ArBcsvaqeznPcUSiY77D
	F7IxecSVO0OhujdKzUjwNUgH38Qd65/JkRj5Hw+0SjycdtQdGImaoo9MXwaxfDmd88oJXhr01yK
	u8LkDoOnUwScqkNJr1AsaflWYG5YlB7O7ji0QKsyPXq2Cw92mcbPHz46wqqt0UNPWaOYvrOSzA5
	lCBi2ak9Qz7hsU8tRMYvwkr6bueQIGmY9g2k1ubkOPseRywWuUVVzi5lEIjVxyGXBoHGl+qlt9R
	/LVNBr+uIcItMVHKBpREJoLRZI8yg=
X-Received: by 2002:a05:693c:2c84:b0:304:9b48:5369 with SMTP id 5a478bee46e88-304fa523a50mr1709684eec.6.1780142345703;
        Sat, 30 May 2026 04:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed563d09sm3725424eec.15.2026.05.30.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) use of undeclared
 identifier
 'BPF_PSEUDO_FUNC' in arch/arm/net/bpf...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 30 May 2026 11:59:04 -0000
Message-ID: <178014234420.7843.1328062815700584977@330cfa3079ca>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 use of undeclared identifier 'BPF_PSEUDO_FUNC' in arch/arm/net/bpf_jit_32.o (arch/arm/net/bpf_jit_32.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5aff08c71816fbe6f6e93e8b2bd9210461c0dbff
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  5396d1aa2ec35b57f7c4cb5da3d134b29a8464b7


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/net/bpf_jit_32.c:1612:24: error: use of undeclared identifier 'BPF_PSEUDO_FUNC'
 1612 |                 if (insn->src_reg == BPF_PSEUDO_FUNC)
      |                                      ^~~~~~~~~~~~~~~
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a1ac078ee38c2a863f01ceb


#kernelci issue maestro:5aff08c71816fbe6f6e93e8b2bd9210461c0dbff

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
