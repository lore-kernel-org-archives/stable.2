Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235A470E96
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586272; cv=pass; b=dX6FHw6FGR8ol5Y1aDMEFQ0GyC8jursMJ9PHu9TmokrtM5tskVsdXiaTH94H7UmeqavR6adXaiPn76G6yv5fTB+fe4RDsnIfqDcyStXCe1NVn1siFdvsKMe9W5g+zBrbZ3HohVkY+4PG04RMa5YN5TOdrGoC+yB/qr6P8R9rgws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586272; c=relaxed/simple;
	bh=sJIQb0qppefV+n+o5hwbpJZrM8HXT9DOFxFpufv7NOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7/0VyrL1/RZKndsv1qAOZ/DOwPNnuX7qU1byGBogy8ME7WWSb1KeSz02Z2ZCWpadBLmKpucJX+HsDSmFxuL+2kiTEDjMjd+wbS8VFbwWeIKnhxafrg8eyRsn4gnrdanjHe1srlvG+4p8r8P2Z2HVCqm3jDXFOn2OgzoVMGrb2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VKet908d; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VKet908d"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb766bfd3so25401021cf.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 02:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790586269; cv=none;
        d=google.com; s=arc-20260327;
        b=H/YNla0jChTGekouYXDt0a8o7dmSKXsX8iiAeOKMFy9NBR8tnjd4Es6ssysJ94GJcC
         3zxyapbgznGBi5SbsBDPI/6W7v7R7HuVvbx/c6VE4QYaWSl7vJobdit+j35sbcNSnbCd
         yNQCDrlDYzuqgZsKcRgadgKziZw1Rhkg08TjACbg7E2REyWxrPJWvSP3w5V0etlAPHwU
         Ab5+9xL656nj90LhWzWENeJIZHSznWc8sFQrmAi3rCH+r+Aw5AN/G6uBFkr9sLpUqEUf
         +OwmDYXL3MgtF+6wMjUBVTUGT/lYRdBp0+4L3mLdschiK31nzNaMAz9FdetCZawaQsJE
         lQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sJIQb0qppefV+n+o5hwbpJZrM8HXT9DOFxFpufv7NOE=;
        fh=b4tlhWZIAlrS4tyKwI9nNOSVOKUknsOXoiBHRqHQbp8=;
        b=B0ss1TkzrA8O6AieJmi1nMEqRYDYi42/oIgkA7qrDM+m8cVhLlaEViqbyhbWBX6hM2
         rdArVZmzMwujyF2g/6Nv5RI3v2OLkjrOPjO+QHLDnTfFNNFOFWECIDzlerRQ4C/wSz2+
         B4e+oCTzx/Xq72crMsmeKxJ6K3FqBsRyzoLbtomXNuKI90xZ+bzIYDQYct1/ZIrhSyFM
         QQI14zDMj9mR9TMpjMn0nur0ywmLWlh3yNVJ3VH5JzyxcTXif7jm5IeqFZm3dXjJO2Co
         6BeGnohKeawo+lR4dGDWzTZITG9hq8pKNtN67m29N+QiZBQFOuRiAoCOyFrTrEqWKAT+
         udjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1790586269; x=1791191069; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJIQb0qppefV+n+o5hwbpJZrM8HXT9DOFxFpufv7NOE=;
        b=VKet908dNqyrHYyJOHFVB3id5x57sPwwpl5J6xKMpbPUAtBc9ASov4XKrdhN9vmFSc
         ++rbd5t2N0cAoZsYodDx11zV898E13DDNXKeU7nRwp0Zy95xDnD4KvySEyJ9vaENmb25
         1t0ncgj4n9FZKdGIcAw7EowweAslo0zMbztfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586269; x=1791191069;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sJIQb0qppefV+n+o5hwbpJZrM8HXT9DOFxFpufv7NOE=;
        b=tBmMmq99h0PKTpHxqFFsp/9bxoe9wP1ku41nHuSggIeV5LjuGtra/yufhKaSg4CifK
         FR42j964iOaP0iov3msQSR/BwodqUOZ8kJypdE/1oGl67HpKI7dk4d9eekzaLJ6xtHAj
         YkyUFJXUq+mRRQxdAgMdDlbHbtQ27EOFhHHQ3IqbjW5gW9H2SbwFjVGyk9zRuaTtj4Bq
         6frILLDhRke2ZCG+W9ZnyvM3lFLf6ANKanXKlA3scE4uAev5bn21vK691ACJ/WikGHH+
         OwT5cqqNimmrc4+Yncaek6URMD2TAH9RLozOYBUn6ooJOUWhtdfnyDElwIPlUR0yZEcX
         ypTw==
X-Forwarded-Encrypted: i=1; AKwUvBxkauJ4DpWQQsryAN750CvSSMBWTNx0ZuWzGI1bWZNGEjcS4OwEOS/2750vqAGq0SsOgbWtO6k=@vger.kernel.org
X-Gm-Message-State: AFuF++naYtzGTSbmMLRVDNSAjOX6Ebz32pGGeI5y/537Orhm2seQmGq9
	uiuIVGATJnimQtMqmCQFosOCs9MahV1aF80Z/M0CbGAfSmTQK7rCkmaxokTqqEs+ggh8Yr8RY1R
	xl5baJhhw2PLUAXXfyiXKjmFSx2Hb90H1YdMO2ojHLA==
X-Gm-Gg: AYBFou06XUiPUa/ZrNd6ayCPpDa8fRkEpbnrW8JAVR5wpjoIx2XAFGLxABw7kwfGZqp
	kLHID0yR3UUmeriNHiYTOMTqzxsDTnhEPpQpsE9grKbMV5lfsuGxR0MGxD1uCVej0CIrMVToHPc
	NxSRuo8b0EOaT7U/OswdjMq8i8ws3pzKEw+ip+RLsdATlhyh7/M1D0A8n92FdTc+gtI1mVS1NeK
	NBsXDoxmAXjyyKsu7v6u64JTq3aPFYhd2nrn8jvO2OjVOrA0TNJbR8CuRHDdzAdAwl+zTzIbS9u
	/pR+8ZsUJ1fZAa+SUi05fSZ3Dts7/AY7gFxTmMWFbipb2PzOkcrk887osN+ftUqTIjnhyTpgaH8
	QXasvY4CEcHYrfA==
X-Received: by 2002:a05:622a:120d:b0:532:c7bf:7f88 with SMTP id
 d75a77b69052e-5330b556b7dmr206684381cf.9.1790586269041; Mon, 28 Sep 2026
 02:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811195733.38489-1-kmehltretter@gmail.com>
In-Reply-To: <20260811195733.38489-1-kmehltretter@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Sep 2026 11:04:17 +0200
X-Gm-Features: AclHuK-Jsl5DiALC-j7sE0rdr09A1c57R2WXrp1gltFow3WO34CRFJtZ2bJ4p_U
Message-ID: <CAJfpegs_4ae36hERZVC3yDr2w8S0zpoo9ER=NU=jth+pXfHd9Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix GCC 8 build with CONFIG_PROFILE_ALL_BRANCHES
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: fuse-devel@lists.linux.dev, Joanne Koong <joannelkoong@gmail.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Aug 2026 at 21:57, Karl Mehltretter <kmehltretter@gmail.com> wrote:

> Use umin(), which is intended for comparing an unsigned value with a
> signed value that is known to be nonnegative. The preceding bounds check
> guarantees that MAX_LFS_FILESIZE - pos is nonnegative, and outarg.size
> bounds the result to unsigned int.

Applied, thanks.

Miklos
