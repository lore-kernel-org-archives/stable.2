Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6838E8C9
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805838; cv=pass; b=hlGqyqMMxkwUmImmTqZ2NNrDMI5WX4SVD3onwboIjtID+LmEjXdwovgRBRXZrcwTzzPKwGeqp19nPozzm2CGhO3gn2w0VCnjfYmR1zA3I4Ws10OuWwG57FYF4u5c3jf+NxtZn+yT0+hWt2w5wbhHZXojPEcHc8fkx6e1RwOgCu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805838; c=relaxed/simple;
	bh=z6VPGWCw7rEpPhw2SbJhvUKlG9shXTh5n37bEXti6gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXdg5Hx2UhPr0Fs1F2YgrcrvFaaBLA+jTVKmYfCdidquBG5ScE08ktxlBi2rAns+HAt4nf3q/5Pw9b4rjANynK7syEwb81Jgsm765bwaMlSiHvYmcd/DigXLM3LhleN04McnyxPO2U3aPXixGpm8yuJ2FePvyb7rgujnqdPNLKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM60DY00; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM60DY00"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c74c469e8so9566571fa.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787805834; cv=none;
        d=google.com; s=arc-20260327;
        b=kMRvD1u+kwLrzuzaCDDxNVinkB2fgZ+vfDgdTm+OGCiYGy26BLOeoSc7O90q3C/nRP
         ZqU6R44EGyVRZNG2+Ih6siUAtw5YWrQNeqGOCQ0UOphevMhw9+mKX4XF2au6vUMmH+7j
         KUTJJkYoi3zNmaeuHTBV1+ITR+PZfc4F4S63z5vP7PIsjjYPcsFezrpfQu6S0MdNLolw
         uQY2nHlomRPcgDGavA2A/MX7YjR9zdnHOqq+TEZWnJTUMbeXu3Qtc5pGNj9wMUhFzwUC
         VJ/LpXDb8taBZOYCrhh/fh4Fv+DC6LoiemY95sQfuatGTdbcLw9qha8Au9u7AD/WrPHN
         SIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhdZH4AQDOVKeQXrpMPQL9ICLmV8N8waJC5TxsBA0M8=;
        fh=tbbEYhC5I/bgJ7+BQ5c0X8upkcJ+DBCIJizTL3nAW9U=;
        b=UgxIzNlX0izsb1bCveJUdzRAkVNExav0XZ3dh70LZQsFUI75VWaBMKx2muTcVrh/T4
         ip5VPB6t7nVlOCf4OiDPvRNVm3hJVDoLXEhnFE1rsL9Q4uckDgBTMcjwfrqPuCrQdNPe
         uLF8afzhISXg+1f0UKYQkS2ti/e3BwLylw+dl6YRsDDUNRCzB/9DCnHLPxrsfbk7v8DN
         ttgTu4ui76oK1jCN/p6r5k6RcTlfUjipK6hkP3j6J1c1T3JiXYKCiERQ2k+JRNkZ9xFR
         lqbMX3b+ZUyqXWMUIIV7YCt2mCPL35uOr/cCZJ4iOswC2HoN0QFa2/Rkdax3jYpHPDdl
         MIGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787805834; x=1788410634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhdZH4AQDOVKeQXrpMPQL9ICLmV8N8waJC5TxsBA0M8=;
        b=EM60DY00o2WgRQsHGmTOqdgJhTo+gu6M72aIm4YHXBE6s4oOfbCI5owrqMw/HCRHsn
         +nmPjXjolj7NSlRfev+DnUzLlYnPK5+QVHmZp/K6Dv2Zfl+CcLSPorU75Ljo6F7/ro6D
         P152R7scIHwrTK/U9TkIg+QPNHfv4hgXi2itkPtuVwqffxj45ydHQ9R4UZRy5fV6Nf3s
         2KGIbBWWHF4KS7pPvEv6XJaLGz4j84YAlOy5mSlFWrBmur3LU1GijmzDiSOd1fPdcVan
         J+tAWsdrq368+TbrQEXN1a92BLV+liOTHXrPfmOFKxIBOcDdKHEsbWfY9YoNDr+Ke+vr
         C5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787805834; x=1788410634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhdZH4AQDOVKeQXrpMPQL9ICLmV8N8waJC5TxsBA0M8=;
        b=kP0LCxIc966xNr4fGpuUj6vt1ojRx8P6KPuk3Zdc/DsbpKLX3qSE6mAiWHUWd9RFHY
         qqPecSF6huW+UsFXU+FDdSR6SdpXGdrD2Vfg6+vN9qV7VWFIG9lk1c5MxvvIPNpEsa8x
         5DVmLu0VR7qB9JyrqyQI9vj1b+4Mt3TRD+fTQm+GHIeVue9kI2FJylA5in4+POKfOuxH
         BJCvAKlE+SKEaELb3dTb4hbpL6PEELMjV/yoYdjtUY3NMDlR2h7EFBheWSMRq4Zy+idv
         OERfcPw41MkTYD+ZH0tJE4V9DcL0M5H6zcJBaCPROH29wq9mG2f2Mpms+i8Ji2Tgyuk6
         OU9Q==
X-Forwarded-Encrypted: i=1; AHgh+Roc3KcH7tDuvVRU5dtAtefp0fHIt6NzsnYqH9yt2eOmwTUqHYkcBPftNnY7veNc+vWaakSwOYU=@vger.kernel.org
X-Gm-Message-State: AFuF++muvaghXMMKZPYiPd0g2cYNaMx1yuV+6nBrLhXHPlhv9ko7deN9
	O1VGTNFDTihSfLSBOvANad0LKX1TiIsiQYftf52OmFoADzLF/y9eb5HcgGKqKQ9oMjh4TJQWhdO
	d08GNWxZlnFyqIoL2IIPW0zGFXkI2u8M=
X-Gm-Gg: AR+sD13HgoK40WRB+YXcfjkQ8xkW2iVsYD8sxCujAeb4y43SrF6nTY5ziJMt7MQzfbi
	Ar1gJBtyzVaSJ4dUsNNNVrtWJO3HgmikFtBMs3lyMOloemMKRN/2/DvCsbcFRw2Q22Gg4hnf5Aq
	BR178d5qECwwz4TYa2V+TyTJSo1XqJvHsSg32aycwyYDzzw/jmOjW7tu3Ek8XExcr3NKl2GkC+V
	xzBnbekSM+2+f1kX7iIyzeh6lb0hrG4am05PIoVCTCEHxW+cnSzO2aE1Y1V4f8HC5Gi2wPTVRZS
	WuDYcEUJ2EbYZLJhsz5mRbfvSPKhweavOvPHm7pBtOh1+vugKNexW4A=
X-Received: by 2002:a2e:b8ca:0:b0:39c:9dbf:f7b3 with SMTP id
 38308e7fff4ca-3a1fd111a4fmr26214041fa.0.1787805834275; Wed, 26 Aug 2026
 21:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827031647.1605970-1-zenghongling@kylinos.cn>
 <bd197da8-a8ec-40ad-a50d-dc579840d680@163.com> <6A8FB73D.30104@126.com> <6bf63800-e169-4ff7-baa2-52c4d42bb35e@163.com>
In-Reply-To: <6bf63800-e169-4ff7-baa2-52c4d42bb35e@163.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 27 Aug 2026 13:43:42 +0900
X-Gm-Features: AcwNN1Xdgma1ZvWQvIA8ZJD3CihsJ2geawtIGSe3EcuUDM2iz2mdfYi8kHS-uLg
Message-ID: <CANFS6bYc88BcJFgQegg84DpDN4MHewowomCRAvL+2SxAO4L9aQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix race between fallocate and mmap reads
To: liubaolin <liubaolin12138@163.com>
Cc: Hongling Zeng <zhongling0719@126.com>, Hongling Zeng <zenghongling@kylinos.cn>, 
	linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Hi  Baolin and Hyunchul
> >   You're right =E2=80=94 that's exactly the unbalanced-unlock path we s=
potted while
> >    preparing v3, and option 2 is what v3 implements. The early exit now
> > does
> >    inode_unlock() + direct return, so every path reaching out: holds
> >    invalidate_lock, which let us drop map_locked entirely:
> >
> >     inode_lock(vi);
> >     if (NInoCompressed(...) ) {
> >             inode_unlock(vi);
> >             return -EOPNOTSUPP;
> >     }
> >     inode_dio_wait(vi);
> >     filemap_invalidate_lock(vi->i_mapping);
> >     ...
> >     out:
> >             filemap_invalidate_unlock(vi->i_mapping);
> >     v3 with this cleanup is on its way / attached.
> >
> >   Would this v3 approach be OK with you?
> >
> >     Thanks,
> >     Hongling
>
> Hi Hyunchul,
>     I think this approach is good.Looking forward to your feedback.

The approach looks fine to me as well.

>
> Thanks,
> Baolin.
>
>


--=20
Thanks,
Hyunchul
