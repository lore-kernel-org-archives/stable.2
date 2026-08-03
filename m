Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2312D7DF1
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741446; cv=none; b=qppF0q/j1VPhmnzG6YQHQyhxDEFCUpEYVfLK+a1MhwQ4IOVSlRqzFsQV4CQQGSKWP3cGRAA+TZVTpEA9pyrE0vyyEZ4lEy++mXs8P9ylPlrgilDZmk78bYcBRhVwOqwxCv9qlClV1/dJcWwwTDV8nAi3g4pJUSGXFfC31iU5xWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741446; c=relaxed/simple;
	bh=U+5e91uQmJMhSeEJDMN1Jap5tDni7smE/OojSiTdnpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX+jm+dqn8EOEdRD5pUjwbd0Q1HBBK8TApMYRgk2Q1UmtWduoTIwwdGzxGIQVGw2tXTJ2TRvsk0In8DpYVq9qOYFhYdB1RN7+ivx1vdxC5MoSmlIF2OeIY+oCzvvtXoSZ/7I9YIgb5uwc3Jo6EtZdp6CeUJMdzqi1LMHwFQ6qkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0h4DH0F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0h4DH0F"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so7773425e9.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741442; x=1786346242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q+2A2Z7IoojlaYkRkYfkrCKzpU+eyj3RUWUUDSzJuJ0=;
        b=l0h4DH0FUgsfCeBr8twNzc6fO7x35l20RvXusShGJwYuVasTvvsCu6G4wRtH9s2406
         HLLAR9Us/55HzrAm3JvK98MexymY0c1wC2VX6ER1DwADcUVpVKDmI5TuLQyZ55sK/Vsz
         outEWyF+mlYW6yejFN77y+N66iEX1ei0PWymLj68SpYbJrQP3L5MYOIG9cWvdCCY+1zp
         GDoN3qe4Bs9iiI0JS57s68wXBSALEAz5HcUCAAP1CC+TOmESYZVuLjKcnOZgU52XelVN
         nZMYhMTO6eVqNf/zpAYt2YYisoa5UBRGTRsu17DpGLUyP8WdrF721xtEud2uv56rZUMt
         mHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741442; x=1786346242;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+2A2Z7IoojlaYkRkYfkrCKzpU+eyj3RUWUUDSzJuJ0=;
        b=mKp9QzuJYv/6gV0eNRKzQX+2jD4C+b7PGwGtt8SPy+3sVY0LnA8X21mY9ELTRqqGpi
         G9/sVZm9pJ3Eo0oO3MtKITHkE3FFbvJl+8FglB/wTWDk8gYe/lO5OlyXHrjRuVihNku4
         xB0pwD7n4meBhDSBdePHuqHv2yNN0yXNuUvm3TAHCb4Nrd1wAlU20jRZyvKPy7NCx3QM
         BjdaP0iA3UHeZo2rPG5URWB+7hcgIIviR4DkQi3uabt/mauWXE8NajRz0WC4tbvVxODB
         2/cfB3znpjoVRN5j+0Ht6fEborI5AbKamZ9wsyCnA6sAIbLS/fRWiMvcaWQhonRLIJNl
         NTwg==
X-Forwarded-Encrypted: i=1; AHgh+RrjmKKMipeA8RxiPfxsOcJZ95d0FdXgeJL+G8/JTjNX0b9vtHe8vPmXzZLFxKqmPdMahKZeF8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59v3a3jnTc3IqrCenNWQLc5IsMPFRUSp+YRSc/ADPn9k9rZGt
	yzf0BsHYH/vOpjQA042Mi6cu4CT5VKNF8jjyapXKYDn2rebhPPKiqG+puEK838Cn
X-Gm-Gg: AR+sD116gcy9I7hnaCE5hVnr7GbD4RHz8MW7d1SFcAHEJwVdESOyiWPSeBQU/dTD3m2
	jj5uP5qwXObTMbZQ7MRkjaAKt2r8mzfHC5cJKumgow+pS+W55JB/15krU4OUdPFJOvy7vcmFoxh
	nsBSBHyGvRtqEL2IwkBb9Dg29i/sZVTGGRpM2LVJK3viJ3b/eIj9doAc4ysT9AVr6NyXJV+1yAu
	f+kzXP9KH1Hpz/6CHOQiWMgyw1k9pxGb7TMp/c5neccWjAb39KGoGUHw/Mp3jzFDwB17BxuM3MR
	wr0zlGy5xLJT9ldG/+/IWSkI306EsMoUcTG0cx2GFZHTXQE/EZSAfSG3UvhRKV/7YTAHYkUKMtL
	OQFpAgOtoUzZvdGdlUyEQeIIxIUmsci1Lx2FOTflTJUv1SwgpbYsmGIHb2J0wWK4CqkZESPfT4H
	+RZzQjjQ0n+2SXGhaZMbPX9eXBFFa04SvmEFd6ks3ycdeBg/9LmVW3hTxFCnzCWMIPOKHI3y0eY
	SeKTIbBHQsRbAfgme0OIl5MRM/nI2l1BP22yAJhVl1YYFOtNsyYUN0miu9BeF7tYjNdIsxoA/nz
	ofSZsxbodQJ/18w64/SHPt0NgMg2AFz7iE3yzrkK1nbFsFeIinFxmMGWQrxe5IT2dzAYnOvoA+i
	9IcGBOi9hGktwrCGUeBhqHT32PXWxVjN3iyY2Eurim8PPl95dmowdHjUcFQw+6yvCQh1UxfUlBU
	GTS7fTrw==
X-Received: by 2002:a05:600c:46ce:b0:498:ee7:e403 with SMTP id 5b1f17b1804b1-4980ee7e7dfmr149263745e9.19.1785741442335;
        Mon, 03 Aug 2026 00:17:22 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808691014sm208280535e9.11.2026.08.03.00.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:17:22 -0700 (PDT)
Date: Mon, 3 Aug 2026 09:17:20 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: midi2: remove default configfs groups on
 teardown
Message-ID: <20260803091720.00006bf8@gmail.com>
In-Reply-To: <2026080342-theorize-everybody-9f2c@gregkh>
References: <20260730135811.1498-1-joshua.crofts1@gmail.com>
	<CALoEA-yuzdD9=gBy0s0VFc2yD5Kwga57LjECUWTTXdF2SHed8g@mail.gmail.com>
	<2026080342-theorize-everybody-9f2c@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 08:25:35 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Aug 03, 2026 at 07:59:17AM +0200, Joshua Crofts wrote:
> > On Thu, 30 Jul 2026 at 15:58, Joshua Crofts <joshua.crofts1@gmail.com> wrote:  
> > >
> > > f_midi2_alloc_inst() creates default configfs child groups for the
> > > default endpoint and default block using configfs_add_default_group(),
> > > setting their internal refcount to 1.
> > >
> > > However, during function teardown in f_midi2_free_inst() or EP cleanup
> > > in f_midi2_ep_opts_release(), configfs_remove_default_groups() is
> > > never called, therefore never dropping the refcount and leaking struct
> > > f_midi2_ep_opts and f_midi2_block_opts.
> > >
> > > Add the missing configfs_remove_default_groups() in the afformentioned
> > > functions to free the structs properly.
> > >
> > > Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=eaa106d192c9daf37f95
> > > Tested-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > ---
> > > Aside from testing the fix locally with QEMU and the reproducer,
> > > syzbot also reports no issues after running `syz test`.
> > > ---  
> > 
> > Hi Greg,
> > 
> > Gentle ping on this patch.  
> 
> It's been 2 "business days" since you sent this.  What's the rush?  If
> you wish to see patches reviewed faster, please help out in reviewing
> other patches on the list.
> 
> And as this is really only a syzbot issue, the "severity" is low, right?
> 
> thanks,
> 
> greg k-h

Apologies, I let my impatience get the better of me :( won't happen again.

-- 
Kind regards,
Joshua Crofts
