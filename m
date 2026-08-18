Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACB47124C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056100; cv=pass; b=RQZXWCLenmboVY2rGY/uNgFddj1Vu51Mmg/zwYq0V60hOmg2ocYr2TtWpJzt2FZlkDk0cqCddQELgowVQNkErf14wocxNFIPTjlNDWyrNetoD2nvCMuP8DC2+cqqJHO+vyye4/qZKDWJmxUxVD0AFcOQU7P0M41M8gA2UP/C/04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056100; c=relaxed/simple;
	bh=2t5ruTH/FipDKh8OqaQCF5eNOVjeSsOw3J178x+lqNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnRTtUJ5HLfH12vAUxShsESzG6sklb8kusxSZJ5MMVLATllXJwLyXBSHg3Nd7DWIovoSkP7uZ0GTL/V8Z+MilPvCbOv5MWHRKm+ei+LIhKKqGellOJ4txYJsOHrzffNgiKpJFZHBHcVCuY0Yc+uF/7Q3CwYsLT6k2Q5Pd7Nf/lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Po3VnARK; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Po3VnARK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c08df8513so25458721cf.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787056097; cv=none;
        d=google.com; s=arc-20260327;
        b=d3NeBFICAn8a6Iv6f/S7YA5fE4FRjTQiH+MrcvjquZtL62kDZax+0Bk7TPaMKo4v59
         Ef3f+w9Xx1qUjb2D3xCs3GdnioeGQOUGA9uNgj72KMvfBWtov76nlt23kzwhpthPtp/H
         upwZoaJq+iK1QNv844zHaL2NJuAu9WGA+xlUW6iRNFN0q7R53cPXn2ednjTiY3jWuIC5
         lk0pjZR5FvnHryP79tcgxoJdWKzFt2nU92Dy11Tz6p79PFaB4a2MWlQ5On+rZ0mQ33aT
         nhcznYsI8tbiM6OqoXE/7DVMGylPVjusu2gJPg/QuZxCa8oGVAhec1/GZCZY6/bIuF+5
         6o1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cs4d/aTAdPmhjV65cnsHlW0NYElIqRWTFffV0xAefUM=;
        fh=CTSoyPeCgfitHkrV46DpLMXBv3A7NmFe5EpW1ocNnLg=;
        b=dgiKmz8dE69xheuFeiKaNG5tfoamSb50tLr8r3Limi4lCVxAvFPpUnvVPBlnhzl/Jc
         umEB8MHrMhxphqKOF7Rw349ZbBeJn/QfcBpG1kBg6fDvecBOo0Hiffw1i7Xuor6AZhr3
         UURQZOUlCiH98AhPqqe4XmY++zfvTvGjn2oCIGJN9b0oPXZJ00UYYBpuLnhaO+6moFUa
         bIQR7BmaPYapQHrpjpPYW+b0txMFLnmZjkDgtLTubVTQHW5Gh0ZWrEFZA/oce9UhAc7s
         DiB5HAvrTWS6Y4J6DA2zKThNctXmm6HzCzSGZgkH0vzs0ksHxZG9KGjM3IggaFjzX/oZ
         nrSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787056097; x=1787660897; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cs4d/aTAdPmhjV65cnsHlW0NYElIqRWTFffV0xAefUM=;
        b=Po3VnARKTQsX+tVYMj9GjkrRDp3XlWHd5BQXoarB5hSJfWiczO5bPUETIOnLvAcKkH
         wpLNmRltpoyPjpJmt2CaX/LzNibn2m5TZwKC6d4SExy2Tz3eeyVsW4/Cr0IxK8aFsYrC
         boJ0UImPQBfsNOsTZPK7ZqQS5D5FjeV9R/JHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787056097; x=1787660897;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cs4d/aTAdPmhjV65cnsHlW0NYElIqRWTFffV0xAefUM=;
        b=pgolM76y6KKFbhj+/RfdWbxCtPRWemUUMkp3dI/mXYQlZpvT2gsoLFwlK4Yc+j30Pg
         Wr7ZyxCPDsHfOXCgmJRlNlqckJ0QL8RpY71d+B11g4l7U/uCrzebivEuQN5qKDHb7pFO
         Al2Ufi6atz8Nz9kghd0CNUYqbbhKxO+C6Q66WxRF/VFKbt+ChtQSdN4GzipuHSx2Z+kz
         3UXhcHvPVOUXjBZsK9MoGC+qycnOZrrYBXE/9/FYWfMvq3jP8xhM+owMIYpuqt3yBGbr
         IOiX8HgoCerHNr4xI9FrLmDHUphAUirOOZ9XgdIoXxVgP3LysasYrx9nnIUTCPiOP8rm
         tzLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7nX05fTXiemNaqx0HkgM4aAWFM3uHVnYq+2KC+Pd9hSoaoTWzytUyfs3Wgl+AGr+PxWpSXGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNwhAgwmpLvTJu6A+KKOuCZHq3Soc/BOrEa+0G1TfKBN2VHby
	W+aF0fqUil06DdGftVUpNSnkdiSg9hx2edJsLap/EyT9huty+HWPn8W8++BEL+r9/seUcDAdngg
	l/mIekhxBjyML1It0ytlzJsvhcaNb/3xcr9go/YidvQ==
X-Gm-Gg: AR+sD11fHddgfOL3qkF31PBOXwTV0H3NJLJeZxre/l1h/glW8SyPa8CDhz4y2BcWvER
	yFaqWqTlK+AB4VzFVjDQiwMiTUtB91GL573AMm3HwqvMT0vFsphdViWNwtNy6dZrwtOpLuDK2jn
	uMW4OY/snCa5arkfHLud0SAIVh627tVp2whdjCct2f88SLYBgxVw9YABbxB+RB8PT23g5cpcvvb
	Knkuqn5CsGia4Rhj1bFSqcAS4JXNFpsr+82hi0sBzv0SIF4keQt5H/UMyT/dpSNDiCRILYIlReq
	kxF6LxxjvcekDwcnLT8m5GM63rP8+fxrrtN6sB7zZ6bMoprrUr2kcHv3LHk8oDsmi8sW5p1nDiO
	m
X-Received: by 2002:ac8:59c3:0:b0:52d:6afd:7d9c with SMTP id
 d75a77b69052e-52d8547d028mr343984551cf.29.1787056096705; Tue, 18 Aug 2026
 05:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727233706.218446-1-xmei5@asu.edu> <20260727233706.218446-2-xmei5@asu.edu>
In-Reply-To: <20260727233706.218446-2-xmei5@asu.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 14:28:05 +0200
X-Gm-Features: AcwNN1ViAlwrNDMh0sYUHfTW_N9xsab7LO-nyvgFlZMdK_NJrbjn_QJtzEfFsgM
Message-ID: <CAJfpegtvYJPBt=AcssH25mn5VDR3Gdkhf1PvuLR5HkJ=CmkYpQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fuse: bound io-uring payload copies to the
 registered buffer size
To: Xiang Mei <xmei5@asu.edu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 at 01:37, Xiang Mei <xmei5@asu.edu> wrote:

> Store the registered payload length (payload->iov_len) in the ring entry
> and use it for the import and both bounds checks, so the buffer the
> server provided is honoured and an oversized reply/request is rejected
> (-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
> fuse_dev_do_read()) instead of panicking.

Can you please update this on latest fuse.git#for-next?  It looks like
some of the checks are already added by Joanne's patches.

Thanks,
Miklos
