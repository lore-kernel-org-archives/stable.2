Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119170;
	b=M9IULAA0jvjdmqMnvFHnXoZAAR9L2BhZBHlGrnw5WOWXyaZDChTWqYQbinZnub26IPeT
	 dkkfGbmXv7Q0XbRgg7k7Mwl0zmKWCUFj4GTDap9Ud5WmiiH8jTkQW2CDTUifzIRrQq3+w
	 jpJyafivoTr4VprVdyPYsoH3/lMkBcHqiurmlS4ha0f4XVEpR7jdkYTQLI7/T6v/Eyh0X
	 ovXuD04iaePmEtKIozhN/ODqsY1frSG3Ug2FxfMoDF+lGpE014vYYJ30Xa5gVS0l0LT6e
	 joY+dsYCOQM7uygvB/8diUx5NZDHVs0ypBtYGbz/TYOhEd/ydcY35QZMTp/TcOjtoQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/xHbHoTMKAiM2EJaprO2Jq1l52MSZf5ouDx/Ec+NukE=;
	b=rIm27a3ahy2Fh6+U+/Oy2oZvtmMUZmy9TSEy3IGcUYSuzYaaewQhoFyRe5W73ApfhCLR
	 DUbdWEMF2dRrdeMc6Z8hScdKzFG4otrK0/RkJ9ohM6WnyuOg7VPAF0nmbFQQ2uVID5x4Q
	 XEvQ28cN1h1/PuoV/U6h/rmh8qz93RLXSJluC7RgXPHuWa3xUfkl2SKcqgsOw5rNzW2hZ
	 R49hE7v75x6h4rzchvs9cYD9CQl3dG3k7Ur6nhcBJoUVkHjf5vltSDSGCPIF+IsRxB2rI
	 /xV+7O3NN5LH1jcDurhtSlJS/to+svHKNlVOZbq4ftUdAYlcOo8kCFNx7pTrSmHX8pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KMJy5Z/v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5C606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B5C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMJy5Z/v
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso31847f8f.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119169; cv=none;
        d=google.com; s=arc-20260327;
        b=jNP9pA77qxhhkmfCNWECJtUTH56oj4uiS89pFyiZIaVdOdYKHuePygGdDrkPwXgcbQ
         Xs/HYVHvMUtUWDmDLkb+P70z6j4FzekBlRPpx5Xz8kwVcIjsPSbUdFTAqD7STJRLLA0m
         pWW4h3BuMs5DZBvTMcyR/vgcCx7KNH1gC/hQywW0b0QjP83rFNizUqaZcFn+IKy9HcrJ
         KYwle4e6r78LlySyiD12TEj+q3yjPYyMsltOqVqI8wnRtPp+gU2Irpx04xhlqN0B+OvC
         leChBgYQFsnD8pPvzzVAE/X7NgwSvk2FMigLF2BfBE2DEKOzglf+MfAUEkRHSINkGF93
         FyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/xHbHoTMKAiM2EJaprO2Jq1l52MSZf5ouDx/Ec+NukE=;
        fh=J7sBhegYXiTQaZ6S0yxXm2EX0obby/1OLowGW66o0Tw=;
        b=lhX/Mrr5x3QheB3uvMqXp8uHpkh7YUrtHWE2ODR65wIJdXfwMaftPJ/2dQg/u7Msqa
         35kNeiXaPIzLUab8+yDMHIcw8dCP1ollzCRROuJSBZZ/Tn/Vvv4D1ZOJ12ACVwYh/5j4
         dYUFxsEkQdSdId/klIrbCwJyEQJSiRLmJNv6Amve27//3ONsxeY6R0wAr+8r24WNSK/T
         sXNtpPl/dRf8fJBAbFFg2kM+bg8xM6EJGWg59WYP4wRNAk5GNlUS3xbF02NMvjEBCHKn
         Er48sb4OxaNEP5OYw0E1fU8oEGm/oQRWR+taIhXBUMAuy5izHQHWenIjfBoJccYYRpUO
         t9VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119169; x=1793723969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/xHbHoTMKAiM2EJaprO2Jq1l52MSZf5ouDx/Ec+NukE=;
        b=KMJy5Z/vVF24lt8zvbx3u2E4P6UNPIwkmT2foRdQCwZVaZssCmWGUsUKztRvEfuN8C
         3O8AEa6u762xnqfa18/QnLHiYFi/fX9g8NDwVgQWd9OfHwdoJ7D5LtJvGYy5WSS6tCCr
         l66KmMxFKTYCWUcvZOGyILTRV7HR3Ox/XNdyp1OEe76Xzk6MPltPf7skQdDWDh4+fxlO
         tB5rnBYYLzBkObLN8a5XJxgakkplzFxfo5xu2zwWSkRakKfrBof/E3jJCyvt24R9NGMd
         r7s+tXK4BSDoUhyTV7XIy/aZth/nHLyXMamsDxOfwPL6w2RLvH/GVRYZY7vhBrwZzAlX
         Xdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119169; x=1793723969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/xHbHoTMKAiM2EJaprO2Jq1l52MSZf5ouDx/Ec+NukE=;
        b=T3yQ7f8PU+EGRl2eZ9Q+JlX3YRO7OA0su2p805lPUCPRUkIFJhcD1NYZ9mw/kE5Mmo
         abjSXOj/NQrXKksBltJNIHS+7tZZcbHqaq0fKsxC7kM5MoHiLleMC/SmErbr+iQ0lgsK
         ilBlaw4pNCKptul3UUH/0seQKIyI0aJYR05SvdnOfaYx3uV6E1ZO18sCHWHcm7lsOZtd
         Wd0Zob0jqlHMPXSfJpV/TE6cySgSk3P2ikJcuZAP/+rILjplDfAN+P/5rY7gEPvhQZKO
         Y83eV8804+NcM4pWBRX1e5VYsEU1HlIpZkvB38VQzNeNCZtIEb/NOKQlPgw2GjSunEnB
         QgRQ==
X-Gm-Message-State: AFq9FYK/w43u0k/Fgmh2TteQRh4UVCFDlhb4q5tSb7W5UsroyWzlt5Eo
	EZ2LLcCPt2IPDyoSuz2EaO/a1KIQ8LbdoDm3tMAJfEItEOads9gtFys2nyDKo9twg+rFmCiiceM
	EjI1JV2VHUeH52YTCmSWCuLog8mt1J/A=
X-Gm-Gg: AYBFou0Yi5tzUKsGF+2DCpqUvRj8YtPKOjuGHMIK4dKmtaKmVRF4sR0RY0dadl/sAVT
	WnWzGl92XmQtqMe0705wPWrh9GYJwlpVi9u5hJjh56SkOfnDtCfXf9ARJzVt9d8ppOobn3yXw44
	b3ICyYyGAzkSGpHVcAVBbVxll8AUIZBCi5wNpgo4ur9EffyHHOppN9odSQuheIjfFBYtrEpKeh9
	rP2OQ+y8XTHdX2TpPY7hCZEBOto1X6lf6BNcU7p3yNbDU5vJYb5Novnbn2qToOs57AIAhZkStM3
	U3Y4ZHKX8HYbioU2RTBmeBQg8nGBEeNaNGxdW6CSwKK5mx4IZXtC5N2qjUekURrceCbr/n/aqXE
	ZseJaPkfjohxFzB9G5/duQJYD/I4gIUIFpyr9SryOPmUso//lK7y+4OIgVf0l173vKLduxKWSJl
	g1QzJ38qpzsggQeQ==
X-Received: by 2002:a05:6000:607:b0:48d:ff81:5201 with SMTP id
 ffacd0b85a97d-48e3eb9930fmr24315573f8f.41.1793119167916; Tue, 27 Oct 2026
 09:39:27 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
 <CAGQVrL85gG09Uo_+PgGxNOrh+a71eLhsnZn4e93aubpMvXGK5w@mail.gmail.com> <2026102643-untried-devotion-b7f7@gregkh>
In-Reply-To: <2026102643-untried-devotion-b7f7@gregkh>
From: Leno Hou <lenohou@gmail.com>
Date: Wed, 28 Oct 2026 00:39:11 +0800
X-Gm-Features: AclHuK-gxKbEz3b92G_qOyia2G2fhsEJcDkuf9YgfEQrkimH7TEMuuaNJUZft2A
Message-ID: <CAGQVrL-7ca3t=_7_5J7CiWs+5HCy81zG2WGcH6A7eP0NeN10RA@mail.gmail.com>
Subject: Re: [PATCH 6.12 0/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Wei Xu <weixugc@google.com>, 
	Zeng Jingxiang <linuszeng@tencent.com>, Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
	"T.J. Mercier" <tjmercier@google.com>, Yu Zhao <yuzhao@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Hildenbrand <david@kernel.org>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK,  resend as following and also for 6.18 without regressions

[PATCH Resend 6.12] mm: vmscan: fix dirty folios throttling on cgroup
v1 for MGLRU



Leno Hou
E-mail :  lenohou@gmail.com

On Tue, Oct 27, 2026 at 2:08=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 26, 2026 at 11:50:47PM +0800, Leno Hou wrote:
> > Sorry, please skip 6.12 branch and just use 6.1 & 6.6 branch
>
> We can't do that, you have to have all patches in all relevant branches
> (i.e. you can not just have fixes in older branches, otherwise users
> will have regressions when they upgrade.)
>
> thanks,
>
> greg k-h
