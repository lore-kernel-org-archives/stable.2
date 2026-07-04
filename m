Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3EB2472B8
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783161706; cv=pass; b=bRsn7VYMCTvP4AB9gJCLN5pRVakKpruWs/6csQAa1rtPhpuqQyseppxSWBewGtBsxA2YjZJygxDF/aUrG8xn6PwX3EaYCIhN/QQ6Xw+Ew758nKXsj1A/3kqENlW4GfakCP6zZquwG3cZa5zUaULv51cD00GfQwckmSOjDRpFJmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783161706; c=relaxed/simple;
	bh=mWZz5Mptz0/RiSUfawe8LlR+jG6GWkw52ioPqYH466E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNBvb0KTucdcbOzwHzR7cufMgFMcVL7kKyw6osaSaBzlQpjppuuM8U8fonNdrlt8DOQgCiu8JcGja6w18PqNalN5gAb+90oUtLOfZaUuA0OHsXGgQMRiv9wuY2lOJ3FdDStr+1sAkFie4ikfDgVU1zTv/rLed4ZrdW09xZPqV5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZDq03Pu; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZDq03Pu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caf4496889so4592125ad.1
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 03:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783161705; cv=none;
        d=google.com; s=arc-20260327;
        b=PjttN2Lk6K1uzysW8RUczk7sZ+s6Q5gICvCkgmEznPt87JAzz0FEVx3He7Cclv7kl5
         1ovBKe10B+529rdLBx3kNuX1MqTmoyfmKBLd/Bf1bQq45tO+H7h+x48h5uFHXHLd6wLR
         LDMmwIU7edaP/kByOPskjPcTGPgCsgViP4I6GruVscDVb3J0FnYRVjAXUSpWlm06XX+C
         L+rSMZTdm9R4xTftTJxs3TdIktCaiAhmJ+qd9vlkqrKjzVZrQ/dw+iqlwr41SOjAx+V9
         cbWOf+NLiX+44CKKa2EY4NdHkEnDswq/OBZBNfVkrV89BqvkeBYhNvAqtVwPqmiT1yd+
         RJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=831x1yZW+gScBu3FM5axlqX9hokdcT1dSf0nVkZowQQ=;
        fh=dljNS2ooK6fYvh9vxurHKUMg+Tx+AOHz+/1AkKhkEKc=;
        b=iasabBov9LF0eE8YI2VoHATZyxd45kXdicI6X9naqrRI2r0+7caKgP7WeeqVAsHMZL
         vkM5JLS0KhLXdmWDyzOA+coeBt48E0U8Wta4hRZtu2vVwZyTj70jFhZuN8KDuZW/v39h
         loHD6sDwU+5ajmGEfNMLDCzIHnioBlb6UxqA/fzDZ7J6h31C+6B/BkedSnspIwvzFNIl
         /4HNPx2DVRTpodxugyU4y4c0YIu/wB/sSXEyei1HFO36Qv7e+WYGYL1bgpH4JLst5/hX
         1j081u5eDFI6QDajZxaKNinR6+NSMfNChF2SwEQWQLOxOrnc9xC2HtrluvRFj70S3djJ
         6U0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783161705; x=1783766505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=831x1yZW+gScBu3FM5axlqX9hokdcT1dSf0nVkZowQQ=;
        b=LZDq03Pusul6fOevq11XvGBY+0ZR4QA2Z6nKy27+SDlpuZbiWlTtHw5FWDSsE1WFKa
         Ov84TeMRCNzgzKpVq0epDzEdopbh5WGvTOsM9dVDhWDXKY3jsg3EBmd05iVvB5C5L31X
         u/98UYUYZzGiSmbparCUCvbsScJxUl2tDGEkfhUEp803ZtL3MhP/KorXQW9wJkSxuNKx
         GK5nKi/2np4BZR86qfPkw1LbScxUoKw86I6P03Kta33oapQsxhwwTpFmgN6gT99FkdRZ
         tDAZu+nY9YZW5y7kH7G71Ylt0L6qpUgg83XGtxowkrWahJHMcZqMaoI+6aphPl5Eo9OR
         OiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783161705; x=1783766505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=831x1yZW+gScBu3FM5axlqX9hokdcT1dSf0nVkZowQQ=;
        b=Kij3W5puqDvvGAqsVUIRrdod2m3Om10meDGVei4RQYF33p5y95jxreNHS9mwi/OXrH
         fTmN82wMZS8EKWeGHJUd048t1ZL4eftT7X2g+NO5hOWW6YI7+9/jUwgD0Hd9reAM7+Ky
         efrvcM5NV70B0wqTtppI+VMiUaGbvj1q1zvEaY+e/8XIa4t9sq2eIXjFRho98BXFZQZm
         d8BmsEbUTZs7fCoJrcCtjLSuDeTDM7e8r4YrWzR1havzEzP+wbdi9nbQopRUS+lucAAD
         Ro+pmr+6mLrN2haKNTMjuuomXiU4p92cfXArj3+tAm8nKQznNWgkAieSiHgtWPMoF+Qi
         ELrA==
X-Gm-Message-State: AOJu0Yyg8d2vSvzwOq3QLiYP2i+OK8ooSFHtpc1y/7iVyB0tvD+20Krh
	hbrj2w8iRfG/o3km2v6rvIAiUVXb9tRaw6JmphAkdZPK/UIUBgk4ND3gMwfHl+saq4B55JL8il9
	6sVXhHALAs4CckmTnSm3gJM4Xpo9NRlE=
X-Gm-Gg: AfdE7cnIc7SJGUCRFd5vEXd0vWPtr5eyTxK9t93LR04PccuUzmjLnDYYVJOlVdQBSRK
	WobuHkCReYdI1H/PE2E4616M/wjW5eLjDAtYfWVlaGf2Ir6YdLn0r5i0QFxv7/29jGgiTA5kGB7
	nufhUrfNOcDwTt9oxHM4wOKAxTxENV5uIx0FWmP779ql3da1rMlzut7sArKP6FYWFo66GGx5VH6
	dBC8+1HqhTrgF0PFza4oGE7+IU1EzrQ0X/CZmNSsJ2YSe5Kg2zQN1SwQ+5DotJ+Zh62YgeFcZjb
	zESPpAC9
X-Received: by 2002:a17:903:3bcb:b0:2c0:fa52:1c47 with SMTP id
 d9443c01a7336-2cacb1975e0mr80557835ad.25.1783161704798; Sat, 04 Jul 2026
 03:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org> <20260528194657.359703301@linuxfoundation.org>
 <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
 <2026062933-storeroom-amusement-0b66@gregkh> <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
 <2026070446-blank-duckbill-13ec@gregkh>
In-Reply-To: <2026070446-blank-duckbill-13ec@gregkh>
From: maher azz <maherazz04@gmail.com>
Date: Sat, 4 Jul 2026 11:41:33 +0100
X-Gm-Features: AVVi8Cdp9nRRwcPFcpQTYVWqiWwmJdHjPoagAQpqxojtvTXgdnc0MFFxq5KXc8g
Message-ID: <CAFQ-Uc8AAEGw90BPximQm3cLzB+KiH_PXr-UZEPK9nvueMGtSg@mail.gmail.com>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Yes, I=E2=80=99m sure I sent an e-mail one week ago to cve@kernel.org, and =
I
just re-sent now just in case you didn=E2=80=99t get it.

Thank you,
Maher

On Sat, Jul 4, 2026 at 8:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 04, 2026 at 03:12:12AM +0100, maher azz wrote:
> > Hello,
> >
> > Thank you Greg, I already sent an email requesting a CVE for this
> > specific LPE vulnerability one week ago.
>
> And where was that sent?  I see no such email from you sent to the
> kernel CVE team, are you sure it went through properly?
>
> thanks,
>
> greg k-h
