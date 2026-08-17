Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407743B498
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988486; cv=pass; b=o/EfK8IO3sy1nMCrpUs3n/xXvrTOMxokI6LQSmEk9D7g9biu3iTDB2rSHIvTq5n6PuZOFHwnAd2+z2FTXx2iLVOjUm+ZN6c0h5wU3ZpP5N2Byk2OlVKQmOtCQrK81Js7futb4nK6PW2JXvMhsADmGuCjmj36LhoOpiWeRS3Q3Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988486; c=relaxed/simple;
	bh=D+PSQZTNWtUguKO9IT8EOUd5R0t1HlJeI/DPy/4wX+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k16hYNJcaY64QFuPUkeZ0FxytR2Nn0e9zO2kD8xC2x1iAEoKUTpTOeody1OlvUDaKD2YYA01j654J9HafVsVAgeohaZJmt/fz3bn/5FKFmg/7yvmDc0nVz7rWVOV9nFRWFcvN3DLc5QmJ29y1aw1ImDMXCVbPq/UM79yeTrt0EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnROKiv8; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnROKiv8"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so3702474a12.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786988483; cv=none;
        d=google.com; s=arc-20260327;
        b=MxzHCGrmtnj5QILkkfn7E7y9x0yIkkCu/J6PVX990fhg0F9QnEUdUjlVc8ZF1+RIJj
         VgHhfy6TiXLAZw4IuC28fV97VssHKm5kOU4O5hGyud7ySRJ3AkTw5xydqWZ606bZlj58
         eiZKFdZZOj47WPguiSjCDF0Q5LMnxKrHYxt7kcsqqb4qHgmHxsyR2ONpGLTcasRBUvcJ
         ek7R5qdUpe2Ontqf0u0LZrqPw/1GkelIYH8W9+BqKWzmAXe8XTraDbUyQDdbUqz+Aw8c
         HEdE83x3J0pZxNcslO4Il8Cq4W124zAsqcqSTKWC1MjcJp6+peIA5YoipD7cv0q1xGjP
         ierQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3y6CjxXHHdeM8tnL2wfghlsb88M2o9mGw/auke1rZrg=;
        fh=oDAaaDg7MA+9S74QbELtvSDjWoZ1bS/bm2eIxeO7MSs=;
        b=qL8Idm/Y+SEnk2NfWJjSkaQfSipq9L/rHE5l4OpWpKSzV0IdAwD8/v5IuUWj9T8NtS
         XxOT9sGhD4tZtk1x0vJI5l5zxsEMIrbvMIFAhsYAqeLuU/x3fCs57A3ji7NcntVYf61T
         no71lNTQhaEij6yXEpPBDoKJbrCNIt8Jhfw/neA80FUwGHQsUqAKYfymIN9bQXT6pYYn
         +lb07+iNjJLilHerX2lLQbXyhLDRKW8Ay2CbdiF0PtMjl/XvsI6+bkGVxdYpolBTt1b2
         /Ub8/KgnhrOHWjniy3w8JK5tIuRC7mLbhpOhK76Negm6uG/yOmx+Jh2ZkYrx6s69TOct
         HxVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786988483; x=1787593283; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3y6CjxXHHdeM8tnL2wfghlsb88M2o9mGw/auke1rZrg=;
        b=qnROKiv86z/KydXvhh2W1SQT/7Jtek1AYADysNFgL2ijqOm/SpHgerfphDjho//pWb
         lgi5+afoxx6J30QIHzEEcxdpcmB1jg7Pfvvmrb7kTDWDkUgWDl9nfGqdbCrjIjydcpVw
         F6fl/ZHi0eqLdeukgp9EQ3G5BiYLVoGp/daHtFs2otFgnVH/MY92JqV3OSCjWn4P1SVk
         gtyBTMcc139A8QDSHuxKdbIMGW2bhaJKZcH71mu6O/0Ea4KtVVrMyOGRqW5OzQHn3UCA
         utYPvsnYQNmdoZBRrZNXWwdikr79n8yjj5Pqsfdc5l56QqTNK3YhWX0wI6p4k9PBGFSc
         0VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988483; x=1787593283;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3y6CjxXHHdeM8tnL2wfghlsb88M2o9mGw/auke1rZrg=;
        b=iX18qyBf3iZh/oGT4Lz1RcgOCuqCxZMiMtOzZpC+DGmGhN/mq88VH5M7M6F//JjRwb
         dP3iuIwOugLUg199OtLiW/pOqJ0p61zUL2S9xcNHNDU8XjR3K+8hrAcT2l297vtx0q6I
         dLRrrzt2OqimPwtfi9+o+h4+HWRgyngtjtPywjYZppt+d1cElFwh3OeSNMMfs/CWtDA5
         cugdnlWegUWRfx16NewPJjvKv6/rLVu1cSrPHXyXHstFsoGgyByYb0+bffuAcSfTOMUi
         NjMehh389Mk4tPkbTJBBz9zbULv3BHpoEQeKJumL16pl5DrMOX8Nf9w2OWZMgOS+EPTW
         9CLg==
X-Forwarded-Encrypted: i=1; AHgh+RqZ7mxPRUbo/SVaNQJbhwz2/8kL4gyZw69FjJPPER0zP0/WngBFPORO7ernacHLD05gJmu4qWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6R06I1NlJE74nPMyFA5f1bGoBkmAcAh1o/0vuOXWr8meGvWTN
	T2SiTIfzU3TPvhyVJB2b+iXWa2ja/uPhGZ6NY6iwlhs3eK4pUoHotVF9isCWeFW5SpdVbfr5vqP
	EKPU6ztGgzaf+1Gu+bmX5agGvdXXqGvs=
X-Gm-Gg: AR+sD12ZMV7fceItePd3k7WN53ZFHI1cpNnAY3bDXawhgSBfDMwa52BnEAGEdSvC+HF
	UXmL4HLYlmhERwMM9wFnLTKnYXJomI/NyS73+sZGlviNp+86ilEUouhZwptaGHOS/v0uxGTecDI
	9MdTq7KMtxC2JJ6h0QgUXChVRznJB0v/tmJk7ZdHCHer1JtUBXAzxM9lenwyOcmaYNHm2U/IraM
	9D3KwmK74a2rsjzv+zrG/hGmGWawEAia5v2H4x0d21vT84V3m7GfwEQan9sDf7wMfPFEdXXZ0Sn
	hrxfeg7jg8w5KD25CZzaZF3/MVX/ObQjHSZ3Wfm6sj4YEayO3R2XKXo=
X-Received: by 2002:a05:6402:4583:b0:6a1:ab16:5c05 with SMTP id
 4fb4d7f45d1cf-6a38a9a4799mr12641988a12.19.1786988483274; Mon, 17 Aug 2026
 10:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816191729.2865523-1-coshi036@gmail.com> <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
In-Reply-To: <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
From: Chris S <coshi036@gmail.com>
Date: Mon, 17 Aug 2026 13:41:12 -0400
X-Gm-Features: AcwNN1UQbko-W5cGmUo5i4jil-CtTZTZ078Uketb8Up8FXe3EKGlTDeM64H-iXc
Message-ID: <CACd_6n3jTkxohh6joJ=HxsVtMwU3X8o863jn47gYyuh2Q-vOUw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, 
	joshi.k@samsung.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"

Hi Damien,

Thanks for taking a look.

Christoph already answered this, and I agree with him: the split return
is deliberate and a common pattern in the nvme driver, because some
callers do need to tell a controller-reported status apart from a local
errno.  This function is one of them: it opens with "ret =
nvme_identify_ns(...); if (ret) return ret;", and nvme_validate_ns()
then only removes the namespace on "ret > 0 && (ret & NVME_STATUS_DNR)",
which it could not do if the status had been folded into an errno.

So I kept the fix at the call site rather than changing the calling
convention.

Thanks,
Chao
