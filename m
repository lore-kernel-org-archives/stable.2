Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C437BE89
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801140; cv=pass; b=g0gQbm7rnHIEntwYcMoIo4FHxsanrPb6wlemSl39l8as7KHDeRu+PHk9pJCom/hPtYswtjQMH1bUj5dVW85XiPnKtLLQtpp4qwUw+N3dup1hb6uBx+M68Mxe0ov8vCXtNi/h4i4cnVBTGAlQmzs44bPciB8pA3GZkJHnd786gPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801140; c=relaxed/simple;
	bh=g54itBuxSGyTv+TNAUIo3lSrFxdYUvWmXIkBOCtztfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdS5DUg+2/SxDWxhL6AS7RvvV/5S98NvqgH084slMaz82S09BIeNQ/gZQkv5EM44WqQeXADfqVEYu4RR4pFmb0c0TK+Eh3WEge2UoaZalZpPELJ3wQrRr2+v1eAfR8MI8xddrG9BpzbhV7XLablb3VLR22wamM3iwCF6mz8v/AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeViQMlj; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeViQMlj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so228160a91.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 20:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787801138; cv=none;
        d=google.com; s=arc-20260327;
        b=LeXUizJRLGqlK5zpMBSOmxsiTMXL3y8zPW92mAb4EywoEbom0BxxsrDLcIwvH2ZmJP
         sdILEvxYbgkYC0YfsYZQpIJ+tpVLyZLENcM/GjpPv4GAzzBxSj32eMiMEKqoOjRhMwHa
         NO1UJu680C3CajbvuP3MgNhySFiNQS6zKzrKdvKl8QDv/UEpTFcMakv7pqduwkLzjNP8
         hP0e0XpDzEoNH+/4K+m2Eq7aZX8Czc1tro2PM2QqwSCv+9ocQH3m//oT6EL27HT3O+2z
         KI2cVRowpTG6hf/NTS/QVG3yfKiDjEXBeuL1sVHACJZNLpCzbPtCRY3Li2zkgb7E6oeB
         AIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y6tDIPKS/uqXuuUFnPzqnQhBgbsl8522wLxb5JPJ+mQ=;
        fh=onhqUY6AIA7vAaPMW7E3jS9JZsLJVPmSxID/LOEazS0=;
        b=OfuwL39d3iyGPyO13Dteq4y7F8kvno8zJvSv7rwnQNv9GGcwkA3G5Fba1jbATR57Ng
         S4dxbjh4gn2VDkX6f/9leZXOc1fqN8HeT8VPjMgPHl8isO86ozm3sX+/fm9bALf2KaWi
         YsiSaA/LloG5P1++US20F8uvGAeY2YtALEfc17PXPmPvBQJ+7BIkMPo2mL8YHR1NYE/8
         7PvRA0Atjfo+592ha9ew/TsMVFosvP6Da4ZZloAfs5v6Dk5yoPP6V/pldogqv4wGpy3w
         eBFDzgkZIG6CQFxE7EaFFvYPhMXBeM5QrWfuAcosw14nkPF/3Ni23YjfS9dTdD9nT17c
         rVxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787801138; x=1788405938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y6tDIPKS/uqXuuUFnPzqnQhBgbsl8522wLxb5JPJ+mQ=;
        b=EeViQMljhcvK+BJjvzeRTbaTkGuVC1cxbaW+ykbBaejdPoSA/4+WZHw6VwKv8E6FoP
         vobt8Mu3opgs+l3yUhlszPHAzu1zWq6g1WkMIVUfEVgO9LKraXp7k8qRZ9uw1NimXUbE
         UtpLCMIWLkGWJUZ89lrOARkFU++vkosIOMQsHOGuy0zlwih9qJHhIkrS7Q5SP3bi0nes
         ybzXVjOe+Zq58UmhQ1E2ykj9lUUWebxw+CiKU66wQUFodfmasrvvBwicshYe/hGjXb5J
         HuG7w9tnAhJzazGTSJJZNfWZraCqgIGfw3olaCXMoY5qvCz2u9dn+q+9Ws+p4+k1JZ9+
         2AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787801138; x=1788405938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6tDIPKS/uqXuuUFnPzqnQhBgbsl8522wLxb5JPJ+mQ=;
        b=PMTp86DhwzEuq74xOemWqSDsMuggjVrJ38UcvDQ/9W7WREfTThF7hY2sqNJZHyly4m
         BgX8u8d31ea0IF2Xgx55o4QsktDe/lZY9YGrhCE19bB5Q3vAibLC1b2e8AJQBYkIErKi
         POlx0OkvtQtThUzQaTEabTjarbfMLJv3ZEdF0Mk+Zqq4ZIE2+yvoLC9dOQnLuijkB1ax
         H/moB7EzbhakjBhQPs/1TvLSqfw5kmuzLRwYs64WKBXuzwdrVsXN243IcKHEHcSWLN7Q
         T4fTcWNRwG4LguMxkLq7z+d2aIy4koFLMWToQKm4lUbGK4LMcyD5cWGpBQqEwC94sDjf
         JDCg==
X-Forwarded-Encrypted: i=1; AHgh+RpO5GQ9skaXuhEPNoxKGloF5mngh8D9UXDsH3Kg7i76Mut9A2QQ/FVfs3Qoo6BpQPjwJML1uvM=@vger.kernel.org
X-Gm-Message-State: AFuF++lq4YbckllGfqK58hmxBWlI0r0FusKT3NGfUbaav9GdpgpLyODs
	+1ZHfNzl2NdRhTbJR+bYYzCfGzabb1zbimLscNSlp/LOTVMWeTngqqzHVWkTIFwCpyvl/wHu4v+
	Xf00/PJNrAba7PohnldDZQUBCMHNEmjs=
X-Gm-Gg: AR+sD12sibc0OoxlKw+hkOIbhFxqpuUtipGCCzsu8eMceQU4RrP2BGWTW8X0h3PklZB
	pri6o4brUxNEBYtg573vrvTMswVc7A8aCHc9I++IepW3efPu6NLsBy7wmSD4wTlUBXBA7LGWnP6
	/uyqmH0U6jRhYoa6cGemOfJSFP3wsHmr9zynsXdjdOuEqjsFZCyQ0O+jBfPBnywl7ZKe5VJKX+4
	+CZDQNK66J4llwfU75dSDit3hcb9zWtjs3SXkKeBzHmq3HY+auysXfrKdpHL8lVwBCaYumXRxil
	VgBmkVzCeVFW5ARjEMt0voBMWzKSr5zdC3mwsft/EoXKfBFwNa8k+pe4Augdocd82bYhgjRVUr2
	A8tNRnbD6ByQziH2ucxCzVa0oyYabXo8Ju0toIbbefln4pg==
X-Received: by 2002:a17:90b:5890:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-3969784322fmr4319785a91.2.1787801138078; Wed, 26 Aug 2026
 20:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com> <ao-OhAl-Mys6zU25@fedora>
In-Reply-To: <ao-OhAl-Mys6zU25@fedora>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Thu, 27 Aug 2026 11:25:26 +0800
X-Gm-Features: AcwNN1UsW2jM8ssQQpvcbBQcH5RsqQMruPr46XEBnGMCtC1F0gnCVtmZRBd-LOI
Message-ID: <CAH78GvupXnEHuW_MW=19u2yAw1gHq1+wnpdtUYKLGp3eS1jhYA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: jv@jvosburgh.net, jiri@resnulli.us, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hangbin,

Thanks for the catch. You're right, my wording was inaccurate. This is not
about an active slave switch or changing the bond type while sending.

The issue is a hard_header_len update race in bond_setup_by_slave(). An
in-flight AF_PACKET SOCK_DGRAM send can snapshot the old
bond_dev->hard_header_len
for skb headroom reservation, then bond_setup_by_slave() updates it and
installs a new active slave. The existing send path can continue after this
because dev_close()/dev_open() does not synchronize with already running
packet_snd().

Later bond_header_create() uses the new active slave's hard_header_len, whi=
ch
may be larger than the reserved headroom.

For the first-slave case, the bond can be slaveless before enslaving, so
removing existing slaves does not prevent this window.

Thanks,
Qihang

On Thu, Aug 27, 2026 at 9:10=E2=80=AFAM Hangbin Liu <hangbin.liu@linux.dev>=
 wrote:
>
> Hi Qinghang,
>
> On Mon, Aug 24, 2026 at 10:18:01AM +0800, Qihang wrote:
> > From: Qihang Tang <q.h.hack.winter@gmail.com>
> >
> > AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
> > bond_dev->hard_header_len.  A concurrent bond type change can switch th=
e
> > active slave to one with a larger hard_header_len between that snapshot
> > and bond_header_create(), so the slave's create() pushes or writes past
> > skb->head.
>
> How can bonding change its device type while still sending skbs?
> Bonding does not allow enslaving devices of different types. We have
> to remove all slaves before changing its type.
>
> Thanks
> Hangbin
