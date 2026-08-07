Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34253546CF
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139374; cv=pass; b=c9cnnfv8EiyV5svf0OeQP6KrllG3qlbCjrtCHgl40Xu5lyYX0kaxBPWL6c9x+iQkhUtOPjKY5iEoAzI6vJ6fPvMTPZQxPzahnz2NpdCJuIIjsrXuUUfKobiQbPY9L0xAN5FJ78h+eZU6+48lIW1VPv3W8Pb7UNSahNBu3Flm9t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139374; c=relaxed/simple;
	bh=G5FTjcRpMezBve/ofJFZdVct+f6BL6BnRtg87rQ8DyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+4e0vMnEP3f2qiNs4B8MJUY0gMEmt0tAblRNlC4pnPUssfAHEDLNJ0ZoYmIYKJTWXqvHL74nQ2v64yVeiardNGidEfxTlxCht8W7UQsabqYoi9aqIySDFq/P4VH2fmGkEHLR+JvbKQCJp4o7RYX6QDLYV0v/oiJA+A//aNqrwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Me3rQyY8; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Me3rQyY8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495509b08ebso5705e9.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 14:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786139371; cv=none;
        d=google.com; s=arc-20260327;
        b=rCRrEEf1itPcoAp+oAuxjA7iP7NrGNW3Uy++NwD5hcjY3EDCbxiK1pVkZt4E1AkrVd
         ZNdF/hsWjw/vOGxaBhrgfxFAwgZQBV6qZHa+AtvtPmF1adGeHj3yIsRVxic8fBOdCtZ5
         VbHYdae245OCue9ZFdXAyhDoO/Bu5B732QgOeMzChi3GFT7GRUgCg16ogs/8EUw2C5tw
         uC66zizACV8kwLsQoSXd04WfTn1EmDzod3oAgpCkOJRBD/Zbh+9zbpAi9tqOliAwxzPA
         GSAzGvsE6I4kutvnsStEARg4W6WNvGsaSXiGyUle5Au2MHDHakI8Zsh2PTVi9sRw4YpO
         4/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tojr7GnFU0It/HjO8jYmDDXbwX4n7nas02X2nGuMiz4=;
        fh=bnabsrsV/C+IznDrLb/7IEtmZHIcfIrILMTZHpeUjNg=;
        b=rCHdeHLkccoPK1+omcLD7QQEWVMhR2H5n7zZnoXuSPL+22eXfKxdZhzzc3/HGcBdrX
         cyFBmTE/6UF40WieUsN7Sook6hFgXDVkf4BvVE5TZB4iNaVz4LM2CWXC9YtY4h1UE2Tt
         YXliN77ZE3V23JJZti/eAsVH1ryn23D15uyoWx6vvZ8vd+K4GGbr8TL5oZ8pLcRvyrob
         ZFdSxqTlzD4CqkEgITR6eDXDrkpFTeI5swLCYvytFHBQG0ZnJeQsuRpoW+tYYGR/UV3j
         hVGAswOZylbu2iHLIM9mb5mk8LEzSyyXhUTGNemnYNY15MK5rTBUIipeJLuxewyJxrU0
         xqJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786139371; x=1786744171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tojr7GnFU0It/HjO8jYmDDXbwX4n7nas02X2nGuMiz4=;
        b=Me3rQyY8zwJnMbRcsTZYZBN0mUbQLcwqP34ndbwdzzsI6PoCk+y0Egkc15WFT01Mh3
         qnQozarUufIbzgac0Dxv6Ha06P/dpGiRhSB3m2cDz7eeIJy3RvG94vlH/jjLYVxYff9D
         qrotEmfATufKSn+YCjnOKCaKDuQENt0XZGkGIFsUWkwMpsR+v66iyxMHQ/oiFAjV1CUu
         q4Tr7dsLgdaUJGcpjhsEKwz2NFXStEvDuJJfjxlg00B7nYI2vTZNSnXa1tQCrJgaiASK
         7E6RjiiSlpiVu4DEEVO+s+FMxw7UKP0j0TPGrqTVGYtcZNouh7P1HvKvz//oPr4QGgRM
         WIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786139371; x=1786744171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tojr7GnFU0It/HjO8jYmDDXbwX4n7nas02X2nGuMiz4=;
        b=MdwYfb3V9enCVZchfU95L9hvDwe3PPO+dga0C5oHYrecUw5UU8No2/o1s96AsqKHg0
         EqKDOA9J9WprgyvO/Y7E5U3E0oSqLRk5VjCT3x4Wzs3VLYz1i/Fq+Us13PrKUuKW0bDt
         A7h2mgELfP+MZ7l3oah0cyFLMc+L3fBDutx0e/ZTGgUkrBdCgaHi5fuknczRHdw7nqRG
         Ayu5flmiUYFkiCNQRV7JwKN9/K54dcnKD3/ooZQ1TRSnSpbKbk0JkTfkfDnpUPFYPPl9
         yESpi0FW2/rADxQ+ZOE9PHyu+DCMzcPgRtSFPxxGT1vKc6u2KnPxjcOH98e5M5k1OoEG
         cFZA==
X-Forwarded-Encrypted: i=1; AHgh+RrPMumPUSUnZ8746q6rDFZx393X/dOyWHdQNwMOzKbz+4CTnzziQWnzww1gpXLpI6aVy3hA/HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyonT6P720xc2BlhrZEt6egQDPomaj26TABEuIuAy42do3QgJ5W
	NffbXgW4RiwiQPvvbokR1QXZ2MbtNNutkCyegY9B9f7O4lnRbQjfhdwpaFks2qNQvDNIAa/WQe6
	PHIxcXjws9RsZ/p1qc3gsDH3mqULMeEg+DYHioZ1x
X-Gm-Gg: AR+sD13juVeXlCMXrm9fNku1ic4CqE17LaXgU77KdHUBoitosWEr81ECa4VJgIguNmO
	nLuNXfBcZskb5cC5TzlFMHW5Dc/NC6lNk5Bg0hIALCyCi8frpkTbdgSM/dYEDbrEizZFpJn3z/P
	n+249bh8MmoivSgu1IeeVTz2NSL/e5iJ+XxN5QL68VblslsvQ6AJ2kFbaexfMQ5KJLXBOyl5iCO
	Fkn7heriFYJhHnMwc253yfqrx0gOaaz2CTrlZ9rFeVV93n7wBPEob03JugYwIalnsCQHHfwaHlw
	h9LE71yD6GwkhvxsMmseoUCTFIoJWSwqLl8W1oxdPLdIgx/5w/i+Gipnh6te3Gt2xQcThRcjJDU
	=
X-Received: by 2002:a05:600c:1792:b0:48a:5618:b4d4 with SMTP id
 5b1f17b1804b1-499624fa627mr282955e9.1.1786139370663; Fri, 07 Aug 2026
 14:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com> <20260807101140.1357218-5-shoubaineng@gmail.com>
In-Reply-To: <20260807101140.1357218-5-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 7 Aug 2026 14:49:17 -0700
X-Gm-Features: AUfX_myL6rl83duYDy7P4wt3f7i8-Bq4xO_AORup9Lze93VGtdc5GMGWYyQ-sUA
Message-ID: <CABdmKX0i_DaS8Q2=Q8Xs5bTbSCj2FFSpib9ReCGYFXSeiBcntw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
	"Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:12=E2=80=AFAM Baineng Shou <shoubaineng@gmail.com>=
 wrote:
>
> Add a test case that verifies no file descriptor is leaked when
> DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
> to deliver the fd number back to userspace.
>
> The failure is triggered by placing the ioctl argument in a private
> anonymous page and flipping it to PROT_READ (via mprotect) between
> the kernel's copy_from_user() and copy_to_user() calls.  With the
> buggy kernel the ioctl returns -EFAULT but leaves an extra open fd
> in the process's fd table; with the fixed kernel the fd count is
> unchanged.
>
> This serves as a regression test for:
>   "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
>
> Suggested-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
