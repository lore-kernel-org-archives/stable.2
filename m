Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44E3603D9
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864194; cv=pass; b=M1QNURkXqM7ohXBAiOqgDX4piZlpN8L4k73vUp3XuCjHhQqaTZWJPCad52f0wWZmu6yB8sa1ygC6rE1EMiaFP9Gngyl0NqNaOPGL5e58dkoueFHn1s50RxMEyuFc0gd2vMPNtKZ+zg0lnROWT/KF93aUgT3MB2NPCfFwC8+cuoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864194; c=relaxed/simple;
	bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pwf2igPHAsSGj4nI/ErGOSTjXYOgFKFIkPY8iE256SdMOiicR5io3ChasutCxXC/e2kHMOXdEkFixRDwfQsuOdo7KEz//AJ1BSNGGMs6kuVfMbQmskW3VbFBDyFCHCOQMHB9gkirE5AbGkqGBJ6241dukTawU4CiGuSGfaKt/9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm803m7M; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm803m7M"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423f52cd57so206878b3a.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784864193; cv=none;
        d=google.com; s=arc-20260327;
        b=QmsFYUHwW22OlWsvm92SVpUOPLhMetb4MVr95V7U+W1cLRv+isScOa661uDMNP7T/q
         0Up8hJpcOpMBJ3qbiYjflhSceO1bY6XrIgw5oCveKXJaoq29BY8n8uub5/95OlJlZonw
         VaJy/y3KzKpdo+ugWq8AwJ3tKR2IGvy2k02dKsHp/MeDX26rg1GK3gwu/1Y/ixMSusCz
         Nn9zHVeDEoTJXYuLrfBiF0lhRXqlw/8FzsSOHz2CgoqUDn+ilSwqjvCgT+Wj6f2/j/gF
         RKA/QV798VmeK6XruhRx4WZI5IvweEXCUP+wiuZmfKsrTjxPzGFsnsrCCQ97jrPNgaC+
         tsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
        fh=Xar1aTkFX9gi/ZdCfgrQYX4CEkEQVbEl/Dp+hRhjIbE=;
        b=afhteWjjyHxy1c656tDtlyZPHzuKSScJE/8NgvYI0Cur8ptkPvl023jWyozn2kINCV
         2yUXhvUKqmDkMiVxtl5YuhcvwfdD55tVTnvYAttflbee57jULlScbDS3nk2NiumNJ2Ws
         sWTL8XcpMI9PrQgCb/GfaGfOCvDVph5Fe+BoZ12zKm8+5Ld85p7aSmJGO4VymzmNaHse
         VCiXtBk6WZxBIiwjEEGFmThqsnfmkO0limP99wX/jYVV8s766I+xU3GTuO2zzAJGnmBT
         nN0V0ZSAIvn6mG9CH5igIs+w/UsBDvG/PPz+drS2qQI3oxRT9oIyDE0ewbIV1YojPOch
         2baQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784864193; x=1785468993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
        b=Lm803m7MRz8oCrZj/ij+be88C9vmMlFFXVR1GnW6kMgHROfMHJXdB+hHTgay+Ay7rv
         tiIvSYjPDLD3f0RCEmYyO5B/7G72RQ19t5PKY+Cn5Tn3FOD82VbjaVZcVDXBvnTAR1Ho
         KTry4nZM04Se05ltRrKQENmbrXBbPsxiLD4XbUPa9ERL+8XmyQzsLlSjl7Fdrh4ohGgN
         eCARNJysLfZQEj6Wj12WUIk47qFZQlaLKg/Xll6pbKo8yxIfaicqLt9ynNGu42B2oXHY
         yifoGJTarjv9tMUCEOXBQT+mhHJP3t0KNKncTuubFGLBD19rEZS1FGHhc7k24bqnIH1a
         6BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784864193; x=1785468993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8HcC/oA7PCfFjJtXkAhXIBjiaFdK3uVq2t3mipV6lmc=;
        b=JnXFnOOjmJZpyt949FhJzZ26xKB/aMIihPgVx7kSPNREuW6JeCAm/7yWVE2ey6RtD+
         p5G6HHhOj0exTQRIAZTw4pRL+n63jzzC+9gcdpEFNiyNSJ32WdPKdwvZHstyAYtEZHg/
         HgQgf+fi4kzi0T/QrR2Xr62OzpwE2XIa3FO88246YLuiHhXaEYhexk40c5R9vy7lD+dl
         Z+VzV6P9ofqQHkA4aEtDLwPKgk+7MKDpuJCPAJNEHLVdmtsRCzmSfuWd1RRt/8A3JIpS
         3AessIfk869aT0gR9i+1ZGOrX4OqWa8k22UusvNM0+uNHrl6ZU+o5iuhORoSq6pkphkS
         nKcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp52JNV+g+IvpLYlpAfXNlopT1TriG1Zr74WZjVktvGRJJvTLXMLVMxqGThWhuf6zZ+C8zMJX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFL+yk6nT8EtextMUKLL5DqxgcjC/S3SdoWUmR9F4mSCqFEdHv
	fvGzvI4brHg2eSBNSCvs56YExm0+ViG+AylSsGLI5uOULmlI5zk2CcaddWJG15XyjYp6XaYTvJD
	c7IFyEJhlbmAY+iP0V7W7PgBJ2a5KjN8=
X-Gm-Gg: AR+sD13HTDvjXS3xuW5DonlvYk66ZKtR92iprA7Dvs/zcP7KAOwd3r6/a7rLvJM/aB9
	hkTu6Cc+14q+Ult934j+ydA3AUEHJRBRCiAZl3wfaH2MtftNEebhPmAqJpVvTpf3tnBMPxWJo13
	61uBCvfhWtRtoeneOjPKnxatYSz5eIxxQtWEsFYzRU9r5V1r3QLSJhH0v2Rzph+4OfnXwUxoXFV
	WDt/Pu/9zKa4mECybUsMQWFWmrlRsrSmqL1xNlq9w3tZ7A6g+usxp15nxngSiWwHD2vtM0bJ5eg
	k41VsUMkRkCWMMXNpQ==
X-Received: by 2002:a05:6a00:a90e:b0:842:5a18:9af0 with SMTP id
 d2e1a72fcca58-84e3ddebe70mr2100467b3a.0.1784864192764; Thu, 23 Jul 2026
 20:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
 <3e4b1552-57d4-42ad-a244-a91b74b8dae1@gmail.com> <willemdebruijn.kernel.3e74e4fda69b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3e74e4fda69b@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Fri, 24 Jul 2026 11:36:21 +0800
X-Gm-Features: AUfX_myMQCLMi8B49UslUypNDm75uADo-4b77-P1llJQTPfcQ7oEOs46vfJYVgE
Message-ID: <CAH78Gvuoqf89L8dm-FwRBzCGm9LaB7H_vt3MsOY5QPd0o_zhrw@mail.gmail.com>
Subject: Re: [PATCH net] packet: use a consistent hard_header_len in send paths
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed. Caching hard_header_len fixes the RAW paths' inconsistent skb
arithmetic, but not the SOCK_DGRAM race between headroom allocation and
header_ops->create().

I also missed packet_sendmsg_spkt(), which needs the same RAW-path fix.

Would you prefer a v2 covering the three RAW paths, with the DGRAM
callback headroom issue handled separately, or both issues in one
series?

On Wed, Jul 22, 2026 at 10:26=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Daniel Zahka wrote:
> >
> >
> > On 7/21/26 4:49 AM, Qihang wrote:
> > > packet_snd() and tpacket_snd() read dev->hard_header_len multiple tim=
es
> > > while building an skb. Device reconfiguration can change this value
> > > concurrently, for example through bonding device type changes.
> > >
> > > For SOCK_RAW, packet_snd() stores the first value in reserve, later
> > > allocates headroom using LL_RESERVED_SPACE(dev), and then subtracts
> > > reserve from the skb headroom. If hard_header_len decreases between t=
he
> > > reads, the skb can be allocated with less headroom than reserve, movi=
ng
> > > skb->data before skb->head. The subsequent skb_copy_datagram_from_ite=
r()
> > > can then attempt an out-of-bounds copy. Hardened usercopy catches thi=
s as
> > > a kernel memory overwrite attempt.
> > >
> >
> > Wouldn't there be a similar issue in the SOCK_DGRAM path with
> > dev_hard_header() calling skb_push() after packet_alloc_skb()?
>
> Good point. this does not use hard_header_len directly, but e.g.,
> eth_header() assumes ETH_HLEN is available to push.
>
> Simply caching hard_header_len won't resolve this. dev->hard_header_len
> and dev->header_ops (incl .create) are not updated atomically.
>
> I missed this earlier, but besides packet_snd and tpacket_snd, the fix
> is also needed by packet_sendmsg_spkt.
>
