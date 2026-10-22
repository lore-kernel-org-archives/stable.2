Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792659825;
	b=AJOq5Swl7rY0/VjnA7HBzJVYRHo889bglOneke5iqzptXSWG69HuueMU72YQBDmfqacJ
	 jYGFwXpWP4+fG5Ck9cHlll7ZiDmxnDGOIf284BLf+Uw8YDdqJSMvHMgteAS80eZv7mpiK
	 CaUu2gi2lsW4yY0EIz87qhB63QbPxYmCYX3zGgVCbOAE0zm6COyyXqZl5jOkdHlDKPz9W
	 hFhRmMgTjG0VqZvYLcfREy8AktHNz+t2ubi+U8Veivs3Hq71+0Uo2FzULdnLcKQQ+/RgG
	 gF8JKHu5NLwMkSNmdrAd5O6YrhUzXevX8kMGP6Uh5599gBwPgffpwfyq+pgXD4iKT3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LWhw+HLJxYgscIYvU2wsKpAHdSFa/l1EBTg1QHDwjyM=;
	b=CEu61QuDlTT2rcsymKVC0CZL1/Z0L5FrtNTEKy4r6X9XaTgyhYphcLFn9UMpghAC9kla
	 lU2q6HRVT8YQl0P2tRm1Z0R/AvrhC7zIsQbpBQBcpG61eB0xTPE9jJBLyhbl7yiMwmI4L
	 NUraOQevNFTWDFgiVfo7LBLhWn+/KjBYlqVdA+qrUq/YuhYJllRrYPiIkZ7xGAo1OMD73
	 7xJEB3KTabBt2gPZ068URWM19LAh2j5fWL+STtSOVixm+qDZ+AMPCKPTRR0V01RmdeBlp
	 4HhnNU7qjTRw/AVj/pmTLU04sy8FEYgoA7PNZlOnXDgm4mgTkviITCo33TOZS4HTT+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FinbhuvJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AF606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E06AF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FinbhuvJ
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b12b1ee403so9899307b3.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792659824; cv=none;
        d=google.com; s=arc-20260327;
        b=C61i5lxOQ9SARN1+NNh2rWeEfEYnOKLdLygOf6LQBc6bxJ0jwPG6RYqrWA+ak6M498
         3NfaTTDMLRg4c7ELUrrHxgwNeZVireGHl/kO8yRVgupKKEDy4EsVQy0t0NEomcPP0IQX
         pvnZl2ojw1QlZ1ZnF2lkh9hGpyUC5wAID3Rd/jaO1AxDMrRmMP4c7ptYNDtxPC4/yb26
         dFAGB7uTNw4Ebv0beVuVuiP2hc52YytQqDJ8Ag+aemXevEc6vtcNrsrbs1CyOac2byg9
         y8HU/pcYR+Lq/vecVbCQgDpme6yfJvom94FnWDASWpe4ddyDRqXuyK8Plog5PvDoL1wC
         m8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LWhw+HLJxYgscIYvU2wsKpAHdSFa/l1EBTg1QHDwjyM=;
        fh=ZnTTz3QpyL5tPZqTIHBJYYJtqSr+72qI6n698VVDjSo=;
        b=Mc/29lzrRX7elhJwEzdbQTsEca6Vik2MljmwuiQRxQ3K2ZooOsDHXV0cq+EMkRuuIT
         kwar72LZu0Oo8VXPghD0Xg+9fj2YuCL3ZfZVWgqWJ1wRqoEH5bs/CP2r20wY+eAKyriq
         HPSYb2pynRHs8jpELs987G5YW8OliRpGCUqt8Xlh5Ycaw2/NJiT1u3bUaZZWWGU96Eup
         ugN1HP8nvlPmmP2/IWoMAsMVTo0bczWGRMZWAP7hrsPIH03H0M3H92Say9x4J66ItUFO
         7xO1apmZ2fwHSjuFrMC2fJS2fOzd45DlhxM7CZLmnAIIKlsCq/MlEENmZElpiEyJ1uzN
         mvwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659824; x=1793264624; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWhw+HLJxYgscIYvU2wsKpAHdSFa/l1EBTg1QHDwjyM=;
        b=FinbhuvJOlnR1YfXL2LeLMw7fnp4FfdEx88p27qSm/QuCdcxkCD3XNkj6cciRNl+kM
         XWYLPl9YQQOIxn5Sgamj4n1pSRbfDQ4f3Nqkd8EIDaQI+7SWA+FJtTG3pjXi1QGEMy+O
         marwTlnH/N/cCbOYMi8KQw2haspqopRoQ1Ob78WgHfe7yxhdNiEEYvS3jLxqWEb4HKkX
         rthJJeonSTtQgSSpJF7aOMUCqwB+Z4uJbeP1n3Q7LDmi2BGSZWS9VdCRu2PtaGMUf1ch
         Jxbf2uxPCUZ3ZZCtX6z1qLdR7U2/5C6dqsFZYJP/Ga9UDzI3fBGYBx2lIKxzkSILrCF6
         DfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659824; x=1793264624;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LWhw+HLJxYgscIYvU2wsKpAHdSFa/l1EBTg1QHDwjyM=;
        b=WB49YY0ce4x1fKi5qVuo22cQYl4+YRO2LgmIhGqOCcZNaiLgeJASZduDGR3i1vE9ac
         Q2vADp7g1eHnONN2BvDOJXKZBkyiBuMJgksx1Fmzn1cLA1q7LjWNfNo3HyRmpv1/jbhC
         9+5cWja2vWW11jtCeU5szuMIjFKtvWV2HoeOtwYfZ4fLRQPfOpa/gz22XkJ+RUVe4Z1k
         8clvkAMOkTqLFg9KKoqdPwupcMdtHHQs+bw04P9P+sQVl68Qwrw9wjthwTpRChPQZt/p
         nux6fGFHXZSlwo5D07D/CGFIA4Dw6Z+G8qnzycn8pDBNzm4l+67LVs7JikY2njK6hJNv
         rEog==
X-Forwarded-Encrypted: i=1; AKwUvBwcBtgqUSqRtiZd0lcMYz5idNAcEMq4jvAWp9Gd0TzMAIiVe0D0LmzWcfGS57Tm4X1bCFfzQBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5Irzam0C6yRdDY8aG5WJLgiIfjI8U3fWd/kz3OZiLw4Ke6a8n
	1bsrsh9h88iOssBWfPxJ3OMPRnQWQJRc0n7CWInxnpD83tsPfoDJXxoXPHtKdYopLYSq0kF9D65
	6dK6mIJYl/JrxjFfAz9fdFJPFGwbM50Q=
X-Gm-Gg: AYBFou02Jc8+4/glEGI3FDg8kU2qcnuKPFDRPHtbeENzTLovcIQ8szdQUQZXWJLwRX5
	7ljGp8NQNLrtofURlWw0CxUl5IGdLZjLyr8t97RSjdCnjMt/8M4ssmBrweLhAtIFB7pq3GgL+U9
	QT/9jXJLvr8ecPsQSIzYV3v/VtVywwojhZ0X+qxfhMonn39EVEcJb4Ve7ESnHgfzqkIwLUIwhs6
	d+ANLeQxjYig/dchtLmdDVmxb2H5VqWtcCf2kd3JJ2OiKHpd/TsdJ/pWV1OPQYOlf91p7PVE9iT
	C5C848Mvu5clzxM0tGF59w4sPezcpjL4q/2IPeVPdSLEcGMFvI0TXAn0VK9LPDs5mANj/6gacM1
	g/mpyyXJfmhXmQ4csh505o/fEgt6I7hojpJnyXQg=
X-Received: by 2002:a05:690c:e3ed:b0:8b0:d9a6:dbcd with SMTP id
 00721157ae682-8b13406330dmr30687627b3.48.1792659823756; Thu, 22 Oct 2026
 02:03:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com>
 <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-1@gmail.com> <9e071e7d-ae86-4b55-8609-1f00a0deb913@linux.alibaba.com>
In-Reply-To: <9e071e7d-ae86-4b55-8609-1f00a0deb913@linux.alibaba.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 22 Oct 2026 17:03:32 +0800
X-Gm-Features: AclHuK-h6BXGmIG1OsOHu9Jb9Mx2Z8xCnybGzVquX23jnd9uB-qla6UpJFXDbIM
Message-ID: <CAFRLqsXgk51QnjPDoZ+5JmLSrY_M0RWPtc0bMEAqt3Ee48J0UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ocfs2: snapshot dentry names in file-operation traces
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Joseph,

> Seems ocfs2_setattr() also risks the same race, and it is missed in last
> review comments.

Thanks for catching this. I've added a name snapshot around
trace_ocfs2_setattr(), passing both the name and length from it.

The inode lock does not exclude a same-directory rename of a source
directory, so this trace also needs the snapshot.

> This looks wried, the inode is dereferenced above in OCFS2_I(inode)->ip_blkno,
> but checked below.
> file_inode() returns filp->f_inode, so it seems inode is never NULL here.

Agreed. I've removed the redundant NULL-inode check from
ocfs2_file_read_iter().

Both changes are included in v4.

Best regards,
Cen Zhang
