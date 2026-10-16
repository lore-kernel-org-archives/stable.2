Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94631326A
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117926; cv=none; b=nDbPT02QuA10kqADEMf+7K6d+z5nnlOv2GyZq+XDpHQlCV3khgxK9WHci7wGx45ppqfPNIdNr2FOuffZ8/6p8k6HvH15DyMklIcLyKo3fKZtsf9ao+OX6700UZZtK5eP3B298PDmoO99W+ceVPkIkc2WMxAbc4M4eCy1h0X9rgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117926; c=relaxed/simple;
	bh=f3DORJrJpkP6ZRkP19t1XIOYLbgIcUWXGly+WSIdbaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT127mR70ip5iHf22vA4JjDWQZ6T5M9i58Qh+eFcy46prqabgd2dkTY9hz+biug6w5uemqJak5akiLD0Wjq1p+9yuUWPwwWW5xI7ClHwDdq/Qn6i73ovXJ7q8HXjrTVybbuxBNoYGrKf9JgdvKe6oTX46fGGEpgDe+rvwK3VUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=Lb+yK4lq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="Lb+yK4lq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53505bc6524so6805701cf.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792117924; x=1792722724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myFazyiklnuqy8xHfQCBKX5TKL0fchWKCY5jJRzEhZ4=;
        b=Lb+yK4lqkt2BfUfCOe7Bt8yvghRl9MUpErEBMAEYfXa1prT4eNcmwhHcy/WnNaPDQO
         31DJne0gjcuj66Lit4Nol8wJDO8rnFNowtS4Spgwo40BY1lZKdo1R5Ls/kDGu16/fKU2
         k24jLb6tQvVlbnbhmLrCYBWKLBcbRmFg1966I2EAhK8fKsdjGEfhQ/Qb+Juxj0wxSZB9
         kO7ipFOUMgtn9A1pw/ad9moHelbQU0e1smRYinSMp3Tvyeny3pmltDV2KB3aVdwwb4oi
         wm5zyQZ1YlX7FFT2bkQ1Gab+gFwDh3Z+lnvYS82ITjprwO+MflkNaueAtIJv1xJu7a4y
         pMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117924; x=1792722724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myFazyiklnuqy8xHfQCBKX5TKL0fchWKCY5jJRzEhZ4=;
        b=tNoUsOKikGTXV3k5AVJXVfB6vSLBwH8Yg4mNoTPw0jbJyv3c0zj/agBK3YWMsBXdxj
         Uh9+toP0O4P1zkDCHYVs44Sgaq9aHH16Gt4U4CZznlhI6f9pvn4nn72vb7hyqrsO3mYq
         gbFw2UASMl5Pdxc7pd/b2qGIp8GuYo98X/U6FmhjpZt7xcxt8m3BvqEcISrLtsYNlpVh
         Q+EpJyBLKZS9n+tWV+Z5nWurCtm8f9SW0XZF8tjZIdlTEB5Ms5uGb56NlJmR29Z6yiua
         bDlbvOcs/HG3h1ykN/3mWiaBJt6oRhA2NM76JNwlY4Woo1aqbYi5n7gDW9FnffMcw2Na
         +UBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBnGV0xZDObINqP7ArnKeXzk/mqf+aqb/3KvaTJYGsgkGF+Y0c/Wzck0h/ohjiHJwkTFSfkLE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSqelsF2JLPZpIn3H7JBVxB3GYhJk4llOpn7qlhjHQMo56WUSH
	cxk9sFMWF6ZI2lz4Lbj52iuiwuN3kyocsLNOFZ24olWF6FQKC2hkneuZgwSoPoFHDg==
X-Gm-Gg: AYBFou2lrtUbpHhwdYV3VCjLqcFU1hmKFfUfV4BBkGjZ8FIHVXldXAnFVgwBOHJVZ6P
	EcDAQ1GmAAO7Enh+jWIagBsRjcQ3inA7UseILhp1xsmRySMbsIEkwWpxF0UFXDObvEULhS/d9e0
	PZy4+bhJrLSsa1DW4xuuH4fa9+MuKmiZlEZ+rZ6IEquHU08gO9WxZ/8UXTqG9ZMGrN/8yrJkxrW
	hwNCzf4R+YRAbpRSZ0CAEUuA9PUn7SpTIYr4begf36uThlSQpLpu8kaSzRuucZEgQ25/pp7RZIa
	XLwiL3Fj/PA7+kOD2Iwmxu7zLUXE6v6ihJpjF/hgMJAPlbwTpN1LRIfiwrez75/92Q7N2dHKrso
	JsIHb0oV40xWy9uE5XyPlfgMByEMg1TV3xG05DC/rRrfB+2frXN44eRn4AiopCUj8p5C0Ed+Ekw
	LrWB5RS1qt1a53DwfaTr+y0GcYvuLv3iKolT5wsKsYZp5r3a8R2osFkZu2vai7dYIlibZmfUzUK
	qxJZ2bOOq4EXzek5Hk1
X-Received: by 2002:a05:622a:1dcb:b0:535:fdd7:b490 with SMTP id d75a77b69052e-53626d2623dmr35175501cf.0.1792117923761;
        Thu, 15 Oct 2026 19:32:03 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bce8918bdsm6778646d6.48.2026.10.15.19.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:32:01 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Thu, 15 Oct 2026 22:31:25 -0400
Message-ID: <20261016023125.2271361-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <45b692cfda51e3b10caa27ae51609edc34efb0d0.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu> <45b692cfda51e3b10caa27ae51609edc34efb0d0.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Thu, Oct 15, 2026 at 12:58:14PM -0700, Viacheslav Dubeyko wrote:
> (1) The goal of hfs_correct_next_unused_CNID() was to fix the volume
> corruption issue. Have you run hfs.fsck tool to check that volume is
> valid (not corrupted) after your fix?

Thanks for pointing this out. I have now run the additional checks on
v7.3-rc6 with this patch, using fsck.hfs 540.1-Linux:

- All 14 normal-volume images from the original tests passed
  fsck.hfs -fn after unmount. This includes the reproducer, CNID holes,
  missing optional file threads, concurrent operations, and reordered
  leaf node numbers. The checker did not modify the images.

> (2) Have you run xfstests (especially, generic/736) with your fix?
> Because, the patch had goal to fix the generic/736 failure:

- On a freshly formatted 64 MiB HFS volume, I ran:

    ./check -i 10 generic/736

  All 10 iterations passed, including the filesystem checks after each
  iteration, with FSCK_OPTIONS="-fn". A separate fsck.hfs -fn after
  the run also passed. There was no "invalid MDB drNxtCNID" error.
  The unpatched v7.3-rc6 kernel also passed these 10 iterations.

- I repeated the minimal reproducer on a separate fresh volume. The
  first creation of c failed with EEXIST without the patch and succeeded
  with it. The surviving file's CNID and contents were unchanged, and
  the patched volume passed fsck.hfs -fn after unmount.

For completeness, I initially ran generic/736 on a 256 MiB HFS volume.
The test body completed, but the final fsck reported:

    Invalid map node linkage
    (4, 2048)

I reproduced the same failure on unpatched v7.3-rc6 with the same volume
size and tools. The catalog had 6129 nodes, while its header map and
single map node covered only 5984 nodes. I then used fresh 64 MiB volumes
for the runs above; their filesystem checks passed without repair.

No KASAN report or kernel BUG/WARNING was observed during these runs.

Thanks,
Hengyu
