Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EC3368A5
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741423; cv=pass; b=u6iKSLVT6dq3klzZSgIIrWmhwV2EHzToafFRr4Y/jyG8us5KkzvDSehf6qD/P4CQgDTATLHDEqOwjXTNn4Wxb2+YPIa7OnoQY+LEeor+b3Ro1vEWhMHzkE47C3jpTQDDZv0cSXvo0J9daWIc5RZyYVc6Bh9YpV0Sa1IhBK8OwGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741423; c=relaxed/simple;
	bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFX1cWytCHzSudoONN8KLCYGapq50+giSIUrszv0ONXmz1QQHKQJQ6ICQz1k4TWn+7lQgHeX1bMGxGQ84dLBkYStayr7tfEcFfmchxns168c8SifIlXKWPMXLmyUp7gnhrLAlt13v4aKqVDALVZAv+Xcfti3ATJVzAAKtRpCUgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8yJW5N8; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8yJW5N8"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dbcb505578so35748717b3.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 06:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741420; cv=none;
        d=google.com; s=arc-20260327;
        b=ZuGlNzSyXfE6ejJQq70f128j3HDgNZ39Iwjg7dExIGS98poX1j5NaRk4zYuKSgqfZs
         2TZXwZbkuZd2o6FTfSzNiKvthPrBTVsSXEKl5ALylQBbPyEdzVH9zMrg3X/reV3qTWX5
         WPcmyv6Ve+CjJ2oGdZZTyV5kzQO6KQ6WstFyurvwq5btkp2trnv/NWM35qob+/wYJ/gI
         L1e+ssqhJ0A9efJ1RgnHIKuKA3zVEzvbvXmT4gs8wSrFbDKevhczOWPgpQnCyKGh2Dw9
         YVo5r/A4OUuIKIkHIg7g9677PvUDM3F4Zhahw0roHEWlIoGIcvOe9MIWyx4mC5txvnRF
         6Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
        fh=+eMbIqZ1GAKaqYw1xsPF5BsCE8MvuhLazlacGukOJo0=;
        b=KoxfWPW2zyWXhQaJkv8Gg1aCL3IiLmUq7ARMueHpacCOoN7d4IZqQQ6OHuesbRR7N4
         VpXwNALRP9LD3yY6u2luFsSRGi+CbZ05dFDkeTZYyIWYPr52jptrkfQkYMpo8GujZEeh
         X1WPUzVSJztgWckai/Cz4xWBi65YwifN09tExBVxxJTb88t2Gnf7VP0uWLPimbIPB12N
         GkUesYBt3km7Oria81vPVDyJrB0btsGj+nZYoXTUsgM6gL4nLoj1CMzR6xp82DUPZWo6
         nxfZR6EO4eD3EL4ad86pHSPCQUhiSrCrbCqsNBhDDY4+iwQJfiZlzECpRH6vrB/6J13m
         ocGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741420; x=1783346220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
        b=l8yJW5N8Gg3D8cZ3SyZwKpTFu0TpO40X0+ySHGpxKk1qzUP7f5qzNGGPMM3xWaFEZL
         dh1beFJ9QgJa1/hfAdzncMj6HnU/hYRCfHCSDgKzxmxpyoppgjFcPLey3YxRYIM1Cnw0
         2rGyf+mnIMu3hIwzlsBY1zS/6U5ADFYQwnKWLLGPVg0ckcpWryLx/EEJhxRkVO4vJCYE
         e7vC0jqZJy2lGRMiyctgt3heGVQWOMx6aOa8xhQhiUADkg6v13OD7tFZyC7aJSyN8YoH
         glYO6VefkUWq5EY7le+8VqQ71FmtA2URUI/p5SS2w9wtGg6uqHEx4llup1J+iptTqFgd
         FtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741420; x=1783346220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
        b=oNcR9rOgenVE3SSg3B712a9wezUNTLhzumIVt1dMRs8oGlso5TXLYGj+HpUXyHpWys
         dKhmLO+NxR7dyJ3dbK5iWxl9QooBMMdlFwKi4h37HGVSQ0PFlC+4SQZjgIv68wya/9wL
         v1F4/h3dh2ZQSxavTu7r7Izm0k0eZnZXlWwCtp8p2bgrN+5w9yptJ+10oaIxIfz6TIUd
         R+edUxHBcwIIxAu2WxxN3fiZm4F24GpVBb+ftOZPHdaSidQHNQz+81KvrzZ0RdeqZB3E
         OOTEmtirgcNJ1qOq9aGPPlPrUJcfHwirP8RYBs7vAg1hqTu9V/6qa6XnB61N/4PmXVmB
         kaEg==
X-Forwarded-Encrypted: i=1; AHgh+RoRtkIzGLA5ZsxmfeI1oQYMxujdimpkctLBtHtLgEvpJdyBZjBf7YFNBvAui+TWcNJbWPRZJ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXSFbtPuL8KJ+2ZFe7mZchSh7WKlVIfuPN5+AaFmOo4APJIH2
	NKitL2VHUKfzO50dcKpqolLvIfXMGpe2lIMOx6L6YCPcPBVRV21W/BfNE+9cB85d6JMDJ85gJ8W
	uoowHYIXonHfF256beof+DPQ+gfimqC579KHJ
X-Gm-Gg: AfdE7clojDQPLLs0qHhtEpthSzlBMdmwYQFWo8DYk/CM5V2jw2nV7Ksmk8IrC23YZLH
	AX+ega8ZRXkXbv2EIT5isMFR3Q7oFyX1sA7tEdG5oMenQ5YJ17gyEcXIk64ZSO7gFmmrs8qx5/F
	IrFkVRbY+MLN25jA9mg51qRIdES4oLS/qaQ5Hw9/wz5tzEsOyCg7PGYK9yXVjhHH13MjvWCKuHm
	yM3iEEGhqFKG0DgrCZMCl8PoZmOF0ppGcOsi3vEUsC+1jpb4U3TMf5y6MV1zqrU8rXFmRnz
X-Received: by 2002:a05:690c:48c9:b0:7ef:758c:e7b0 with SMTP id
 00721157ae682-80a69d97421mr155842417b3.1.1782741419762; Mon, 29 Jun 2026
 06:56:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:56:59 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:56:59 -0500
In-Reply-To: <87jyrhd6c1.fsf@toke.dk>
References: <20260628001350.20997-1-alhouseenyousef@gmail.com> <87jyrhd6c1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 08:56:59 -0500
X-Gm-Features: AVVi8CcSuZeFAVGyi5M2iCAaJADLTm7w6GUYQ5N4ro2W-UlR5D107eFuYLkHe-U
Message-ID: <CAMuQ4bVzzsx9SDmoWDWpZrcoWPgRsFYFixnjY-1TGkGiE+Vfsw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath9k: avoid device access after async firmware request
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the pointer. I missed the pending patch; please drop mine.

Thanks,
Yousef

On Mon, 29 Jun 2026 11:49:34 +0200, "Toke H=C3=B8iland-J=C3=B8rgensen"
<toke@toke.dk> wrote:
> Yousef Alhouseen <alhouseenyousef@gmail.com> writes:
>
> > request_firmware_nowait() may invoke the callback before the requesting
> > context resumes. When a firmware lookup fails, the callback starts the
> > next fallback request. That nested request can exhaust the fallback lis=
t,
> > complete fw_done, and let disconnect free hif_dev before the parent req=
uest
> > returns.
> >
> > The parent then dereferences hif_dev only to print a successful-request
> > message. Remove that post-request access so completion cannot leave an
> > older callback using the freed device state.
> >
> > Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw ver=
sions")
> > Reported-by: syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dcb7ed9d85261445a0201
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>
> An identical patch was already submitted and is currently pending:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260605153210.=
20471-1-1020691186@qq.com/
>
> -Toke
