Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793430442;
	b=T51rOq1/B4L/5pfYLtU7emf5X0NhovtI2raxKmzRyR3cU0dcQxeyNr7SNx0VhRUpgCRB
	 PtNncCGH17tEe5wcKDIHcJJZYegv4VsmXcQng2caegGKT+04GcsS7Nh2Vu5SP/UGad3AU
	 l83TjpQ0/gCH8pjihjzqYSZrUke2wkcCDneW0ZVxCd4PKm0LHlWuiLmIvC7jFp2LrvaMl
	 5QRJiGMiYpw4hDLk7l2LqUM5b2joWoU6OO5ufV/WWnXMz2JFvsFw1/uA7BnxVn1FQWUVG
	 cdSP7bEsSyXgHQ3Nk3LFKV8m8bTNoiZP65bWJeUkrN0NvTm3vARVQd0KlJp6NCWvQRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
	b=gFMdip4gFQBKhxtw2dYcTlRkpfMblUVUlsiNLWNKA03MiPeDtq82j1RAZn5Y7PPdav0K
	 wxw/0Z6OmX96laHvjWllGTWhDmElQ5MXzQeRPUqMgbToQt2U5Ielo4QELPXth4ALIlKbl
	 KKxPNGULqlPpAfvNdVi8zAJ4HqDpg4rWg7lIkEkk8Gbpc9ws1L9u6QjBZeNSME6p6RKYi
	 7Z6Bl77Ti7vjcbDwtfv14UfwLpBQ+nS6syjyK7j97QwHvIQlaKsaCSx7Lorzy079GggXb
	 nyq/L3wXGWZIrm0oa3CDJeK/Kp2ahR1/0K4Hv97zIFUuBWJWLCSzvn0KR9kPeyU3uhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mUC/ZNRG";
	arc=fail smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C25606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 07:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C25606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUC/ZNRG
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1337393e87.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 00:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793430441; cv=none;
        d=google.com; s=arc-20260327;
        b=IIkVkcPXEnh4+ui2dPyj3DQ6JIKoNkbTHIXjQjebezM75wQrS/zCw4i6f0X7fQn1xe
         KTYZq5CzVxlAsU+HsxpEC4Xap5IOW8XelEznz6U0Bm+AKBga97wNOizp8xikKV/XxOF9
         gC/bZQPYuxCWBN5y7kaL4/gNfr5PD5m1QQJJ7cZXD8b9VooWdnjvl8Rb1XQSRwsulNfY
         7rAIBZUoLIuab/NleGEsAF0nCLML5bMta0p1bdSLnwUCIwbMqEoNuYHCtSirkQ0zLilh
         Xnx4UDrJvRuMnrmr18hG0g01d8cfpDcXh65wK8YIg19zctahCB+w6VXQG1a2vHClcF8N
         2Liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        fh=FebyGzCO/YgxFoxni87lwb+paYICZPtwRvXEkz36Zd0=;
        b=GhMCx07NlQt/nnFPBRrkzyiqGxtBjh/v4s5kW2pN/ol7ka8NEUDbUJd0ChIhv+AI6q
         cy5NY4KuXadQ7LijfX4NsZ3QQOQzuQw/kSj50uY76te6MmbmK+MrHCnHxehZ9Xj33sY9
         7eBQEWPgFxt42NnriTbXtF5XnVXw/IriTeRlvAsoJFrt7/ZTg9XexlRo1gh+N4wSPP5K
         fOKhjkubFn6h+AWd+hVGZuV5E0/nWCl+YAuCWwRX21GpfUiwXf3iyjRf+qtm85ZbAzmb
         86P3Silqd/9MB4hD3gjlFRH316G534c2VX/kzivaBBsibNlNq20MFuRSevzyVxM43o8U
         GtYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793430441; x=1794035241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        b=mUC/ZNRGxHvMseEtdOEJmWVOL8SEcrnIyl+LO+rOY+pCywr6fgr+KDK2CIyE8lIsuz
         yQ1Np9gk8b8jKxaAfhEqP2bROPaNrhie/nknplsY5izO+GtjCMaTsnSI4wdjbSEFbJ2A
         v1V+FQHw3oxr+3yAX12D/DT/sUQ9qKE4G+uooZlPDxfs/u+oPXzxb9TRBVUps5TvUVPa
         1zS0+tldYvPBypmRuTh5upf+mvaRVO/3IMi4ZTkryxZGkOjq3yCeaf6+X5a4ylvGgOOQ
         lKmC7vQgmHoRcJHX40cgu4raIzql04uewGD2ZHWOa8sSFvfRTprZZlnZaInECB72XWYU
         O0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793430441; x=1794035241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        b=ZGFfgeqRi2Bi+AxRS0Ic9VOFbGeDJNCNThj6kw+KZK2yYDCJar2Q7e93K7QQFFy30s
         +TgSzxPb+cyBac6yQhlgUhx/I2sfU0v/WwqGsYvJCUbi6wGlk+G7JruwBhjYlKmpUdvS
         kV55HW9bHMjZghf+dN0oox3UghREH9HCLvu2I7RvA+86h0g19O5f0CmH/QuHoJaEZEPt
         UrvxhFpXqlPBOHmDhF4K+Ny7ARqrD7SOaYO4NRW/AVIzvZ3LE/fBFwcnJfdfjQaj1C9m
         +1WaLc6VZOcZgdWbsV2X3A0brxUGrD4T3K6J9CEz8XRMqBm56FuDiR0So4NnUC7DPDSw
         JjKg==
X-Forwarded-Encrypted: i=1; AKwUvByWnyssvujHTggU3jpK+yqc2NersPVPjrC2WIq2WhNaXAMJNsyLIhKLr85o+M3L3XBCr/LRTLQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBqzevHZ1N6npzqeI59+8NcRHZgiwnGOMajuKUgYfu2yP90qE6
	qCRtPGs2gAqaWIRIQYEfjHtpslC/6e2/gsQL/l1WwcpfE4t1yTKhj/SD0af2JlTj63P5OKIpDXH
	NJyzQVf7x5JpqSUd2lZnDYPIMtzK0vPo=
X-Gm-Gg: AYBFou1/QaRpiIuSzDhIB7SbNE8e1Gm7ejl0zUZ0eGm7BD/pnoh9CXaR64lMhdonkNN
	E29pKEzGLRbE5xVQi95ocY15WayynDpyixhMxDjiHwkR9YFZsAsm1crV3KWYD/Q69fN4f06TcwZ
	kUE/x37KqWCgjsMHZo4lsmbZ7aIzb9OqzcCGUCoD7/Wq3Mnq9cuhpYHoDni56fm958zbgRLf1Y5
	+er0arWr083puxYwZfzEB1Sgco7lJp+cwrjK81Nw8AggELDWw87NIEstNGw9lde8lwXDJFPeTqG
	0aSvlVVugEl5jFuZ6pcF+t820SVSdYCD0K2DBiyNmubk4hCz3sRY/0yjZKaP++JerzSEJoP+Qnk
	2nUZ092/hyeppDHtAJRTgFjFNMwNX3luo1TsGJKZM5hlhIBWwYc4Llrh/2grgOvmYkW1QC39kul
	GIp7xEK0F5uZiCSGTDfownRBer4CkzZ+aX8c9p3sohKb5ZUPsJi9Y7jlBVc/zol3n2081oHAKXa
	+qIsSnG2hE=
X-Received: by 2002:a05:6512:1393:b0:5bf:cfc6:edb2 with SMTP id
 2adb3069b0e04-5bfd951d540mr1610800e87.1.1793430440393; Sat, 31 Oct 2026
 00:07:20 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
 <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
 <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
 <20261030094633.27910-1-testwrzwrz@gmail.com> <auSF/bDmOW0Y7T4D@boxer>
In-Reply-To: <auSF/bDmOW0Y7T4D@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 31 Oct 2026 15:06:42 +0800
X-Gm-Features: AclHuK-0fsS0Xg_Rkxrpa9yorygM-pSbQySVfqzZJZ8DT6_AjEHZacGUrZv2dts
Message-ID: <CAL+tcoC+bwVdf2N+Ku92+ifPOQMvak8KMYM9RvMpv6hkdpMt2w@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>, netdev@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 7:57=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Oct 30, 2026 at 05:46:33PM +0800, Rongzheng Wang wrote:
> > Hi Jason,
> >
> > Makes sense, thanks. I'll wait for their feedback on the selftest patch
> > before sending v5, and fold it in together with the rest.
>
> Can you stop removing all the previous conversations and rather reply
> inline to related paragraphs?
>
> I don't think v5 is necessary. And as Jason said you received 3 review/ac=
k
> tags and none of them got included in v4.

Given it's his first contribution, I suggest sending a v5 with our
tags and that change (removing else), so you don't need to re-add the
tags one by one :) And then Jakub can easily pick it up with auto
tagging.

Thanks,
Jason

>
> >
> > Thanks,
> > Rongzheng
