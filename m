Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115921B87C9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621049; cv=pass; b=lSQlo9FXeVDEbNuDqWhKmcmjUdrN+6bzu2oRdGDicjklADJHeE7IoiJKZxWl5acAo7KxyBnAtQxjcAghLAR4nYCiHLOgg+tG8HO6OcusYqX7ta3lRhwsmsERnkykwAnaab2yWkwMvEOjnWdvKVRZQMLXhKI9k49gPaggCV/SC5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621049; c=relaxed/simple;
	bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkaiKgFqmR1lqno7vXtiBmyF81AfGOo+R37jGisz9SVxLTm6Fiwj0RrWrXxidv6ovEc1o+kCQKeFOJ+R0TR91Hx5ofh+83oF7c6PxVWEBkR0eXml290X1HzpXqxgLIAGo9mlj0ldXTfqxR6QRm6L8p0cHSkwQyvv5/5WFX3S0Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giEt2rYh; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giEt2rYh"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66d1447e2b1so401320d50.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621047; cv=none;
        d=google.com; s=arc-20260327;
        b=hR4izLkcxaftBNH5pKuM9Vg/9pFNaDup8Kl3prrasagFRhGxczm6WLf9LdiyGVSj+e
         u6BmeOmZdCnxDRcSGpQitXOki2oRcnafWl5D/YGfIyiTkL8jhgo8Gfbz+A0s/3HjubvU
         v3CSmom4A+C+63pWfmN6IfahhUdj5+H1G6V542vsVAcCoYNSmG+60kHJ5zjeyHJuHvkl
         YmFYPTuYvKAnRlnAVICOZW+sEAwGEf4YnsdnhEoVfZjWs8vEi1aOi/BKZI7YcLo4wjhh
         6QvCwL+ntQiJgVrTuqc3WuHpwa13mPrX6Q/xfDdW3D/R5DRlrlyUilWXdc8EQAnAl+Ry
         JDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
        fh=bSTKl9xpBknL5RDJR+WegR09i4B9VHJzwNDVdaBoLzY=;
        b=XxWbVnQ+0UeWzbOFca9asMt0cCmxPc5ep83Fn1pIjwAGuif4fMLoqHGv3r9D9SSUOW
         sPQgW0uCVM503jZfyBF9b2QOoWKkoy7R4IkzJjNaiNYPsPlm0lA6BlDp4o/kv4LJqTs7
         abscOo/etrvDY49UtmF3CgyrvjDDZmcl4docIJoXQ6nNbFAeRZZDidl6yh1ACqey7mKd
         zeERn4mNtWYb7EsgMwIWUBgNwtE/kdPelIjx7qf3Qy7elV5dudOkXLrwpK2mBH2YZPmn
         /qj51asLYwUVRG6S+dUl2m5VX3mSAV8zLXM0TwQHWox6Yz0lHtJo2e96iNTjCyRieEZS
         n/zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787621047; x=1788225847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
        b=giEt2rYhDGiR82Yf326eOmyy9AD6wr8IOvZ5KfFlSCZkMEy7rdTHiNFcnZf3KpEYmv
         TDWPkLiOTWt+tS62qN42Qta+xlBMdEm8Rg4nzHMsscGNcRusSsHJw0y8D1hhD7v0dOdc
         mczqFjeCeBZHk1MjRRbcpQ8MotUgWcXh/+oZLoQSVhAWOjJSxAeoEVAhkQCvQmf+NTVO
         jBIECIiILLE5FICEewH/+6fvTX+BCzmrT1blw2R/nuAiiVBi7MAAj9p39v6aaDh70QKP
         6LDHtE+LLnlo6djSXq3xmDj4SNWmK7IOtuv1hEQfj225YQ6t4U3bfkczFlZSrvcSxAcE
         frMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621047; x=1788225847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
        b=pobfTBofkn8WM+gXAyGzOkugszyPLU2n2yVlXj+t4gjoKTx0GisYQcL+9XkXAo0g2W
         T85lZ494t7MJ1YKMwMjBJMj9L8gcQk8J6f4iMQLv0dmF8FAkoy+HfQuOAfeQVo9VERin
         LgYIbISgPOtBZiOSMJtwXT62mjoXZzjb2Mc6M5/kK8YpjCK/gX7ffw/Tm5+KJYEx5qR8
         wY2dHMi9T1Gmgi8SwagUXsIhYWfRZyaKbAfpdUPARtdqxytWAahs9783eu05Msre35qp
         9a8Zwoh3H6u8KWL1NOd8bYl8ti6W0auVOlzuEQYIgK2uiehPxHLzuYDdWbyJFn9sT3Z3
         VU4A==
X-Forwarded-Encrypted: i=1; AHgh+RpzskXhFtWPEOOMNRNJ5EV6ICVg0AC8jsEpXxu18sxTGH3H/8AU1DMW9Q/rm6xuExDrsoD9rlw=@vger.kernel.org
X-Gm-Message-State: AFuF++mdJCb0cZk/MlSJqDDX5WOKpGoYUGVtxku8ZbIRozF2chwYknLt
	171tHjdiZNXwfoPejVCK4RGbRkSZgFM347khAt8C3PAqRktJSXh7TKLRCmx+E/ipl9Nz/9TYl0+
	IHwFIB6iZ0xBFQEzkrQgJZUQ0GAo+6go=
X-Gm-Gg: AR+sD10cJIBj+m2GWSld5lA6wDb0I5daSefFrTAo2gIjXA/1U0Yhf1o3BWBhR38W2bF
	/V4jky/dg/HKCXhMVJBBs3KrMJqY9xj0wuYHWKSnACcf+IjVc7TtxC34VumJIOYnyICiBHSZ/gF
	zE9lxIvQSnaiNas+tGzsKmx7Y4wzh9I3cRdqEY03j3IGyucOGH038P07MewePf7OMJFENYx4iP1
	Skpuf/q/JZU0vuaDBoSBbZsakIhdTe0OMtWx6LnS9tzh9vbLmu3yQVLLx0WvaHaiwbYGKQ+27DD
	+xBV8AV76yms2ItJ0x/uO2LfqrlCPNvePbCMSL9dxkI90wmgUMteDZRAEMBLiBpDtyHykc37/dD
	1ZHXxj3FTJQgFipAnAmMdxoT3c/jNl0/6
X-Received: by 2002:a05:690e:4554:10b0:66b:28a9:5729 with SMTP id
 956f58d0204a3-66d1466d89bmr917985d50.8.1787621046887; Mon, 24 Aug 2026
 18:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824144653.54044-1-kartikey406@gmail.com> <20260824110345.22c1cfa1@fedora>
In-Reply-To: <20260824110345.22c1cfa1@fedora>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 25 Aug 2026 06:53:55 +0530
X-Gm-Features: AcwNN1UszChId5oB_w55eG86VnC8BYYkfLa8ASZ8by93pDACWQio_jfBYcn6AlM
Message-ID: <CADhLXY70RXpWsSNToYGsFniSht__2nd8xma4bkFPeR1kyWcL5A@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Initialize ei->children and ei->list in init_ei()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 8:33=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 24 Aug 2026 20:16:53 +0530
> Deepanshu Kartikey <kartikey406@gmail.com> wrote:
>
> Yeah, I saw the syzbot report and came up immediately with this fix as
> well. But the change log is way too verbose for such a simple fix. Did
> you use AI for this patch? If so, you must divulge that information,
> usually with a tag.
>

Yes , I have used AI to create a commit log . I will add the tag in v2
and the commit
log you have suggested.

Thanks

Deepanshu
