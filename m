Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F04322B8F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943343; cv=none; b=Ss9m1paWGItrBs7QmGO2zQ5Tt5yNCuhQkiT7yhtYFq1wuB29rBuharfJ42hePVelUlawAjkkeXuYN1npOh9lCVeuSpz7SfncLvqwRSKcKhJGW0jhac7oipDpJK360t30NdeNMgAlZZmcQ/suMn0CpblJlGTvBAk0JJ6u8hRdRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943343; c=relaxed/simple;
	bh=/eN/Kf05YOHbKQdrrbArM5JHYbujeG4z4H4EPRJtRAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEyigpkRZSyHR/mNaIG0FUJ/bQ+csnm4n6kYYPguvtU11ALbrDFCBd6ZoGIRxSJKbw28VF5Utl1PPDxe175cmsBTHM6LL2PhI6E+MtGyFfMzZXKM67bVLYK88i6Te9t1SSGOVoG0KmaYtVI0NA+GA2zhYizur3qv1U1bTlXZ7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNoytTlC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNoytTlC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2823861a91.3
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 22:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786943342; x=1787548142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/x7VDroEtisLQTINSAgqdabiGVN6bRi+UuVMbVvFgk=;
        b=iNoytTlCIQj68XUN8/nf0GvieTDfVCvMmvAEiTS+a18kjFxc4pzV6YdEzPeoZiFxf0
         Np1h8MQEwH2BHGKdUPv6sbr2ni6TOLQzxnsPNoDs+WgapC+Y1v8X58lsF3DlRalwbWdM
         9hA1my+VGeBmpJfOkQKnuMRQgCZI3sUUPDfbgLe4yLMq1wCgZNScTJwsXTLL5rfjI/uZ
         wmfAOyffjhxXAuTNifhH39lthknEbwb/fJcFpyGyZklzBNlS375ijm9Mxel5HeE1YDXu
         S1dWcuSTCuPJO6BoBCAPXNzOA/eVA23fc/5IuTy+Uyi28juXDWntvRUpJ9tmRgx/hLAq
         WyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943342; x=1787548142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/x7VDroEtisLQTINSAgqdabiGVN6bRi+UuVMbVvFgk=;
        b=OrM4eK6bafCLcHCCAUzwSTZslJr+xRAZI8JesYyy1PSBd2HhI7SjtO1CKZiDSeSPrN
         MHvrgj6njuW9yAPFXZCUnNYl7fEDigFcwMLZvctgD5JcT3cByE/daDqkkKsrIEZCoit2
         VrO0mUZnVPsL0kcwHxdqNGmDxhlmseV+e/CXgVnHHOnw2h2+3we0V0ZW81Dqng2kUsiV
         wRJfVKivTE6DscW9AYXLL3kmjbTO6+yOL+xhNN5zCEQXjjpJd9v1BkxDQvaXiwvEPFI8
         CspOldm1H+HWa9tc45e8doGMdHfvwz4KLRNp3yt/IfI7HT7G5dId8s/QbgDnz0ouOElh
         wrXA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7chpgM4ySWkeN6/ixBEItW/6W2T2/tPFMnIrIHrTrbsR9ZjaAIiRpT1Nis85lrKId0KuGcpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwFor2+r4hsb6TyzEBlk9MR24WYHrj7brABcV72g4XO6a+i4X
	Nc0/yX1fQkOJ7rHyZtmddF+L+uypdw/4ifl+1i2UMF31mmiAqBDonWwI
X-Gm-Gg: AR+sD12ZWGDLvxHtFZNLPiz1db9LC3/2lDy90o9tjHIwj9GGkAihYxxi9mYFZBZ01hb
	g/axtcpvAdVSnHHzQ90G/46VZyXIak0j56YdgblgRD+5C/Pr+i9R+OygMjrqenxxGCNqIuUzWQm
	78tMamQXNlyRLpuOTMB8dAficNFHyrUP7Z3BUCgeBYTijChj2wU7CoK5c3+A10V3NiEU+wfu22S
	YzlCYnTZfw1xIVNkgsiwmvza0X9watoDyHKFUztX7l1m8AlQiPkATqlrtwp47sFUOpAVzJaW/ot
	9ZeGj76q1y5gfoR4htzwrL3M8M0y1aYt11jc9dBQ4Rc5/0uZSfzGWXzTXkm3ENAWdaCOeV+CZXI
	r5Q0Sb1x91vgQz2wodsYDWru8ImklSUnZ603H/v1+fjGgvnWA8EDDQCqRTDPZsyPZCW6LbvsMyj
	z9M+n/vDySbatpxVoSMyrbwatioUkuzTuRs27SkYtFoRfDKCvOjGUZkyzV8QXfiET6LEr/rLBV
X-Received: by 2002:a17:90a:dfcd:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-3933b503abcmr23137686a91.0.1786943341831;
        Sun, 16 Aug 2026 22:09:01 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3b3b91sm712731a91.13.2026.08.16.22.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 22:09:00 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sunmin Jeong <s_min.jeong@samsung.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>,
	Yunji Kang <yunji0.kang@samsung.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix i_size when pinned fallocate partially fails
Date: Mon, 17 Aug 2026 13:08:52 +0800
Message-ID: <20260817050853.3437985-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c3a4a131-4a97-4227-8968-03fcd491c0a4@kernel.org>
References: <20260817022723.3324123-1-zhanxusheng@xiaomi.com> <c3a4a131-4a97-4227-8968-03fcd491c0a4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/17/26 11:12, Chao Yu wrote:
> Can you please provide a reproducer?

It needs a start offset that is not section aligned, plus a fallocate that
hits ENOSPC partway so the error path runs with expanded > 0.

  truncate -s 80M img
  mkfs.f2fs -s 1 -f img              # 2 MiB sections, sec_blks = 512
  mount -o loop img /mnt
  touch /mnt/pinned
  f2fs_io pinfile set /mnt/pinned
  # 2093056 = block 511, so pg_start % sec_blks = 511
  f2fs_io fallocate 0 2093056 536870912 /mnt/pinned
  stat -c %s /mnt/pinned
  filefrag -v /mnt/pinned

7.2, last extent and i_size:

  ext:  logical_offset:  length:  flags:
    2:  5120..   10737:    5618:  last,merged
  i_size=46075904

  i_size block 11249, allocated through 10738, overshoot 511

With this patch:

  ext:  logical_offset:  length:  flags:
    2:  5120..   10737:    5618:  last,merged,eof
  i_size=43982848

  i_size block 10738, allocated through 10738, overshoot 0

filefrag prints eof only once the last extent reaches i_size, so its
absence in the first run shows the mismatch on its own.

7.0, before 4275b59673eb, also gives overshoot 0.  Absolute block numbers
differ there because the start rounding changes how much fits before
ENOSPC, so only the overshoot compares across the three.

I will add this to the changelog in v2.

Thanks,
Zhan Xusheng
