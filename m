Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B242124E
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439141; cv=none; b=QMWCtjDqe3G/KWZs3oYt6Q1N54hJvNjwChMV80koczRssIF/Bf/K2gPXmB/SmdKyD/nB+6KINFVzgUwEVXbP4Lk2KW559CZr9t+rBqVUJUgSXS7XmKpetporHrrLfEl43icoLKuYKNiy7iXn5gQFJFUy0f2k6xwXxomhgyrVC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439141; c=relaxed/simple;
	bh=dd4bffafaU8LLv4sKADEnrR0GE/MkVQsqdpQEYYiX/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnIWJJOtD6yghTbh+dGdR/mBBwxg8OVqQ+EVALEK5L9cKQt1s9wSf0F1DoWpQvOpBqETd4j3p9CkcCam83N8ngiPBnENxJpMsxQus5VJWey8jUbuJa3RusEHEKvPjtK1qWHOuybWzZONaEs4gJBWt9eGN+fzviGeHvTDoHmC8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0ntYU18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0ntYU18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F68E1F00ACA
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786439140;
	bh=dd4bffafaU8LLv4sKADEnrR0GE/MkVQsqdpQEYYiX/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o0ntYU18JB9KM8pWFybLrIbFwBNL5ZgY4mtINyKPzOR407cIeum/uvWO4KvZWnNXW
	 aT0C+0Xag5Je6SveoaUBCEKLdl/Slz2+uo1k7PRCTxEl8E9zIcTxpEuSAVwNv/3PP6
	 HuOLBKeIURMrtoo+gXQcQh43uwDsE5eCVzFBU3Q7+gGLSHKcqndl2C7P1SyOOzrYE4
	 N85oaOZNMSdJ4vQC9b2r2oy5mzc6IdqnUPWCxstyc1E72hHTGDUGdmEN839GHJ44oe
	 cNidrB+88zTOqKuV0wIWFI21RfqKOMhoip7kJ83lzRWn5v4Lli2XN14giKZ05XcLSY
	 VwZtS2elQfPVQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15e2dab83eso425677066b.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:05:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqypqqe0WfcC13lJix30Mb6VOiMZ+KnOUJE1byy0fp/f/XD+wIrgZKOt3id/8ZjKRM1rIvr6ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWir3YiGKshVQj3E7jr8EU1N35JVKB7Vs0/kHycoNLcE/eN7e
	AC3NAAAIxWYko2sr0rLSzFiE2xOMXzb2pbDvqABQ0FlK6yLy82skSeft5VeXsyWhBnQNNal8eP/
	7qt2a2hDF0ntFcvbVVzRx3luEygQxScI=
X-Received: by 2002:a17:907:d501:b0:c19:fb6e:5fec with SMTP id
 a640c23a62f3a-c20e61c6e72mr97286266b.18.1786439138677; Tue, 11 Aug 2026
 02:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811021548.15328-1-zenghongling@kylinos.cn>
In-Reply-To: <20260811021548.15328-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 11 Aug 2026 18:05:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9KtNhc7x8N0RaaAY-D5CJbanCB6Cy5_FgaTAKFvzcAwQ@mail.gmail.com>
X-Gm-Features: AUfX_mzqeXSPy8VM69kyOd2z5sSiBtVdSMUxku7y1L7DUpwx96q97bAEQBPUvJw
Message-ID: <CAKYAXd9KtNhc7x8N0RaaAY-D5CJbanCB6Cy5_FgaTAKFvzcAwQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: verify run length exceeding volume boundary
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, hexlabsecurity@proton.me, ntfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:15=E2=80=AFAM Hongling Zeng <zenghongling@kylino=
s.cn> wrote:
>
> The mapping pairs decoder validates that the starting LCN is within the
> volume but does not check if the run extends beyond the volume boundary.
>
> A malformed NTFS image with a crafted mapping pairs array could cause
> the kernel to access memory beyond the volume boundary, potentially leadi=
ng
> to memory corruption and privilege escalation.
>
> Add validation to ensure lcn + length stays within nr_clusters.
>
> Cc: stable@vger.kernel.org
> Fixes: b4be3a47f8ba4 ("ntfs: bound the free-cluster bitmap scan to the vo=
lume")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
