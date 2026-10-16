Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3380498E3D
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173956; cv=pass; b=P3xZSOyys1PXxeX1QG6mt/vEy5ata3TcDTWxjICxv8b/uFjqyfutXLAwmo/MsCtM0FmETU7EgTuNmhmvfqwxB/SOrJlIjXw6SGWAsUP3iqwiVDap/7xT2TpjvPXpmPBSX+RtaAkW47BCPBcFg0pMuBBuAiz3u1NZsJI8wuGNA0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173956; c=relaxed/simple;
	bh=W9zaZCC2PUL05KATE9nrs0p2Ph152nxKDF1hPAKaLv4=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLpltAkgBp30J6PHzhEkN/7dp+HdR3uz9wmTJxbhPJ2ksOCBiBjciW0SIJ6lzL//2Gi0KAwn5qKOKVwjr9HmptY2ZFv/allRrtkjIpLOgyRwB9L+57phtp9SW9U2ENUC3ucsM8oWWuKPQskjQRfpY2VqZ3y6mU3/XtPiXS2bk9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=fzLhOxyi; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="fzLhOxyi"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso189347e87.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 11:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792173950; cv=none;
        d=google.com; s=arc-20260327;
        b=IAPNjSMlPrd5IePmViEHl0ukLZaqnt4tXfwg6ORKUHwO1nD47tVwDPJD32TDZJMpiR
         Rp+HdNfMlodVvJjO2O9uTWPfKzWXky++jLrJmVJHgHswxtKwihXDhP/RTTLikiDADUcq
         1PNv+KmRqooUMXXoM8bO2pWzq1MslNLj25E5wv58S0D/H/49DLUWCvdWI5rKnZQ8Ka6n
         udCFqKvMyzzG1wUU7fTFouhbYKzF2Gmm8/VTfo8b7+/dajtxr2he8X+2Ul8yb9wCBJLK
         +8JVTaRFhTCezFnOt6M9QQjoX9j3E95HvxjZbWMNZJhJ/ay6D1+7XyibUAodiAp1w1PM
         lFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=W9zaZCC2PUL05KATE9nrs0p2Ph152nxKDF1hPAKaLv4=;
        fh=XuRrnkFvyIgAtCuQDgkXSPb/jNA8/Ju1S328ikLeABI=;
        b=BnofWvSaa2kksyME4TsPJGibfC/ildALrXveTAwj81PMPumQxGTlfXEsj5PwVfwf+d
         iZ8EkIJKu/S4nfZ/C8yZSc7ZvwDC4QeqbC0wZhTFXTsnt+VCPOCtUBC7ypowBCFfandv
         wO1jdwNZvF6uZhJLrslguYNnSKvk430FbL8gYZg3e2lxzjMVSL1FzhtJ+Tn+wUz5itoJ
         05etH5u0+opRJTzyFXivUXiOdcrzISvqDp84xaTyRt90aGfuRDr+oBY3lBf7YmDymiWL
         V+yllE93sEARSojdfTtGkJYVPVXVScbiakqXrjbZ4hPBqLpOVAOHrDbFBkOGp6Eoeyn2
         9xpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1792173950; x=1792778750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9zaZCC2PUL05KATE9nrs0p2Ph152nxKDF1hPAKaLv4=;
        b=fzLhOxyiORVjmgoUa4qUBIKtwUGXAagoa/AqN42OkkSIBFACP9lg0PC3ev1/WJteQ0
         NeZmJsP6Y8OGMtweyzoIeOib+fi+6d7hpCcRTDuxDvzjeHVjVqx7eTvJLmsB5fSNR3MH
         eFEJf0SXeVkcaC8XUrPzgMCjd7zxK0YSvdtic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792173950; x=1792778750;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9zaZCC2PUL05KATE9nrs0p2Ph152nxKDF1hPAKaLv4=;
        b=SxIXrLwRndMMXAeiOCVmImIBqX5yNc/+Sk1NONzCX7CBpQbR7Bjxx0iR3ONxHrPr8p
         UZZ3grkXYsDFdX1uPa4I+txQdWY8mHbfuSOCvgcbvC5nratsLcxWV56aFY/htuxD09aj
         9mbHY6XsCzn150oOV95gSNwu7ToaELDu6RDTh8RndZW3rhZDcukfgCsQ+e4gtELWuYL7
         n2TVAcbdV2ckSK1Rf/YQofJOY4WlrkPCF1+LOH5Qq3LJxjPODX7b9xkSswqssVPq11d9
         84A9iWSI6hT4JRf+ezH4hLTc1z3kSwtOsVmkCn2fAjRURZBC5q8haMOg4ERj5m3T2/tv
         nZnw==
X-Forwarded-Encrypted: i=1; AKwUvBwo5B44/63Ak/fJ1Yno8sD0UEzGANZPkcNnS6UuNCdovpc1YyIbFu+TU6kzw7vOcG84RoBzMWw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMWRiEYh2f+vh/r4y+8ZDMMttC95OrabulFquZPp0SXhq08x49
	B326NdkAihN51CCns8C5IrEFEV0TAVRLWGHs6ke8/gHTahGUMrea1KjCynj3CcJNfAaMJNUVo+b
	GbDZI4250plZof1BBUXdA7qgYkzL5CkhH7PwwlQnO7w==
X-Gm-Gg: AYBFou1Zki2mMR9/Tqp9PFVhg3rRokNKTjptq4x1l3zO/73IfB0MfaGm4u7j6Olj25R
	A5L9+pT559K5uHhMkLNi1P5SeZQ1lJcdZXIr+GUTJ4YoS07UpDk0tUDsZzpwYlzvP49SZ+TfYJG
	FrtFzcrnnGiyG27klHlpPP9on/3HRN2jqSAhOInu9KccTA7nYZZN444ZaPdQ4ijQCyo0BNyp5hi
	uxZJqtRu/cy/gH6FX8Y8Tg1rnfSdm7yi3/Ljfzrex9PAwYvUCPylXVVgPwgX7JhGKZfsBKAa6JE
	rnUUN3bSMHNss9dIEjOveycjuDIsFYfVpZCo/4djYA397tfaWfTkyLmcMt+yZzvXWBEhkDznJTw
	YadY7M710lrZHct8xesPhM3jiZw9Xv7y5XlrPX7anSMsg
X-Received: by 2002:a05:6512:124a:b0:5bc:e472:12fb with SMTP id
 2adb3069b0e04-5be50a74cb0mr92020e87.63.1792173950529; Fri, 16 Oct 2026
 11:05:50 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 11:05:49 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 11:03:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 16 Oct 2026 11:03:19 -0700
From: Kim Wooseok <5mghybrid@khu.ac.kr>
In-Reply-To: <fd91ff33-d8a1-4ab0-83da-c15816c148cd@gmail.com>
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
 <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr> <fd91ff33-d8a1-4ab0-83da-c15816c148cd@gmail.com>
Date: Fri, 16 Oct 2026 11:05:49 -0700
X-Gm-Features: AclHuK9ZwgypZrng-PnEqwREU_wxzMOVesmRvYGZ8m4Qdc2U_H8EMyixUe0zrSQ
Message-ID: <CAH1Bc_w89ymu+E1Gx13M9JD7ZNmdQ3=y_zFwVvMkQMKk4m6NAA@mail.gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bitterblue,

> Perhaps it's a silly question, but doesn't this just move the problem
> elsewhere? Or does kmalloc_obj() guarantee that nothing else will access
> the memory near usb_buf?

With a separately allocated kmalloc buffer, the kernel ensures that
CPU accesses to other objects do not corrupt the DMA data through
cache-line sharing. It provides the required alignment or bounce
buffering, and usb_control_msg() uses this DMA mapping path.

The patch turns usb_buf from an embedded member into a standalone
kmalloc buffer so that this guarantee applies to the buffer itself.

> An allocation for every register access was not happening even before
> this patch. I guess your LLM wrote this...

I did not state that the previous code allocated a buffer on every
register access. That sentence describes the allocation strategy for
the newly separate buffer: allocate it once in probe and reuse it.

If any part of the explanation is unclear, please point it out and I
will clarify it. I don't think speculation about how the text was
written is necessary.

Wooseok
