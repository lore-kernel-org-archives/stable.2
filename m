Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060347A0B4
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157874; cv=none; b=ii2t72YPJ/kR22Xdz+BFdX/MoPXFRPHadQG6vj/RaYQ6dJ95gtlgfPPe6QEtktOou8rcUSt8BKAZUuPYnMVzjjI7BgRXWVzXWp01NvTbXc8adbHJnSv/gtaIkRK4dR4eNeUEnksEMWs5Dsmo6XmLziqey8bgEy5G0o1lKIgkmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157874; c=relaxed/simple;
	bh=EoEAV7ejpSZmFcizF6/IsRWD8DS5esh3O+yCY1FlMaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2XgFAEkyF9jRb68/Ep6+gJsRBdEWTBznJ7xOyIMhWxDzi6ZHlp4KSHQWwiyCFUjIhRMX+trRWlZBdfda0LzG0YehSch8n7DTtYU2gihaqTUg1RRyOKlzobUEsMEqZRgFsDYgdImvNJjlU+AL8DYBbm/vdiJoTX62Gu8wrQhO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PNhoL/hJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNhoL/hJ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so2023152a91.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787157872; x=1787762672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUEL7Dgw3Ry1NoMw4a3dL5pN8hzybwWwVDY4tsypHy0=;
        b=PNhoL/hJ18e8GzZaMZubgsLB+q6DTppt3JgF1Qamz6G9PF5BvaUfcWaa3dQTDm7MM8
         ZRTrfq+DExEBoQpruWtV84dNDm3ICJTu5215Rtf8xsbEzig62XWzDUtOT51Bd/QNZWrZ
         6M5eXPNLTYuhNLfjvtGNPiN1mwfLzMSi4bF+pnmB0bQXy7nvyoqFzB0ss2SHNWqeQGwi
         +jLP0+p0uPmX2Ibpvyz1zV7sVindmU7eIHXbu3ZIams7yqVtpVcOjsTLL9r4aH02yQ1O
         78RTZEmPrhVDL8/H0L1a/mnrNV8ecKMpSkma3nGPqrtPKekYno5zPMriWFYjLZnJ8Tw7
         j1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157872; x=1787762672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUEL7Dgw3Ry1NoMw4a3dL5pN8hzybwWwVDY4tsypHy0=;
        b=k5J3ntNF8vGSvmHzA0J4dr99Owd9jygB5srbZSTAd5IE2sCj0L+MwcQk/XYJ3A0Wjw
         rzbjC2jtzjvIFLaOMdeRhfiGDnR46HY5ISC3RyZdc6DpVMdoRFnVsCSbYlmBvax5DZLB
         I34RWlaFJ2agDXJ5eBAjMaCAbz2GG/DTWbsCb1ecYqBSUN6WWXxiUFqDBY5tqcSLwlLM
         97rnqGPuEOTfARXKGNpHC/085gz/LU3MAr39/+pe0frCXSrX+/tU1h4L/InYrSk23JgO
         /EmFCz8bmlPrTWnDVNOGOCplz/E7HgWH7HMXqqr9KI4trYq4/ndG/nnl+JimlXDm4oHn
         +7Tg==
X-Forwarded-Encrypted: i=1; AHgh+RrAS7iGCmQTh7MUd2hAEVEnFCxGbERUVu+P54XZrwV4UvcCzxacb9Za/d/uw+sHyLyEH0Zxzqs=@vger.kernel.org
X-Gm-Message-State: AFuF++lSgcXumi2sus362XfeYCSCsJO7PVtmUHp7Ej7qOTBTJNED5nEg
	ZN9R6+1evShsn7JvP6dSi4w5FWox3Hl+ulko1tZPVuUnFEYWF3Ar4QSX5Sr5hBefkBs=
X-Gm-Gg: AR+sD13cXjR7pWsHUnXGALr/q5cK1VB5AzNwrfbDhkJxzOk2o4sEhBdQXM9E7lM47Hp
	/1pS/aS+dvfEQHGAlCSKSD0nNEF0PAL+ilZ6mXRRtgcQ90bgJ3nejwA1Cu4I6krGCJN2QMepPny
	pC7nX0kY0swP3YaKEwF5NeL7J1qlvIhLa9iklYPnsKUzQvlLIejRkyioR3iGDn9FDCL22CST7w9
	PIvoZMsG8SbIzYs+9L8vi3g4O4QpydN8nbkkP/GZt5ji3cXXCV5blCzPccASL5x3JU2R99H5dWt
	QYKzSlFv+W8AEhShmioHVejcqasEOmZj1gIcth9p6hRrmbKwt7IdiqSmbQVQwksLZy0867OENnO
	7oduJO/gGFSc4eE5ssKzhQ2BW+sQnvigovwIryx8Cw6vtMu0acJUDd6I3qnwn2nHqX+ZREv0Aox
	SiCXa9bllWVE1QU6sZZslePhgTgpQvQEW6GcwFr1k4j8MHJgyGXRueCmy/PPZSHf29
X-Received: by 2002:a17:90b:3a05:b0:38e:bbf1:de34 with SMTP id 98e67ed59e1d1-39580aa6b77mr11612863a91.7.1787157871904;
        Wed, 19 Aug 2026 09:44:31 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:97bc:8ed5:dd4f:e433])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96cd4asm3436661a91.3.2026.08.19.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:44:31 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:44:28 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: elf_loader: bound the section header table
Message-ID: <aoXdbENOmRRx2o6l@p14s>
References: <20260724025322.2341205-1-sammiee5311@gmail.com>
 <CANLsYkz+h6ONmvhgdfGLNu21J+LrMSySFw9sxRcR4ZxLwPfbsg@mail.gmail.com>
 <CAJciObG2OahhKz+t9pbA1yCHz4pFQLK6EKmZMwY2zxqD33SgQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJciObG2OahhKz+t9pbA1yCHz4pFQLK6EKmZMwY2zxqD33SgQg@mail.gmail.com>

On Wed, Aug 19, 2026 at 09:15:27PM +0900, HyeongJun An wrote:
> Thanks for taking a look!
> 
> On Wed, Aug 19, 2026 at 1:42 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> > On Thu, 23 Jul 2026 at 20:53, HyeongJun An <sammiee5311@gmail.com> wrote:
> > > +       /* find_table() reads the header at shstrndx even with no sections */
> >
> > Right, but if there is no sections, @shnum in find_tables is 0 and not
> > arm is done.
> 
> The loop is skipped, but there is one load before it:
> 
>   :266  name_table_shdr = shdr + (shstrndx * elf_shdr_get_size);
>   :268  name_table = elf_data + elf_shdr_get_sh_offset(class, name_table_shdr);
>   :270  for (i = 0; i < shnum; i++, shdr += elf_shdr_get_size) {
> 
> :268 reads sh_offset out of the header at index shstrndx, before shnum is
> tested at :270.  Both callers, :336 and :380, reach find_table() without
> checking shnum.  The value is unused when shnum is 0, so it is a 4 or 8
> byte read past the buffer and nothing worse.
> 
> > > +       shend = size_add(size_mul(elf_shdr_get_size, (size_t)shstrndx + 1), shoff);
> >
> > Why the shstrndx + 1?
> 
> To hold the header at index shstrndx the table needs shstrndx + 1 entries.

You are correct.

I would assume that if e_shnum is 0, then e_shstrndx would also be 0.  If it
isn't the case then your patch is valid.  I will queue it when rc1 comes out.

Thanks,
Mathieu

> It is keyed on shstrndx and not shnum because nothing here requires
> e_shstrndx < e_shnum.
> 
> > Also, there is no point in doing this check if @shnum is 0.  Please
> > move this block in the "if (shnum)".
> 
> The check it replaces, :95, sits outside any shnum test today, so moving
> it in loses what master already has.
> 
> If you want it inside, the way there is to drop the read:
> 
> if (!shnum)
> return NULL;
> 
> at the top of find_table().  The loop already falls through to return NULL
> at :313, so it changes nothing today, and the bound can then go inside
> "if (shnum)".
> 
> I am happy to do either.  Let me know which you would prefer for v2.
> 
> Thanks a lot!
