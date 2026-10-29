Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793302849;
	b=yOMM4HFiqEfV5i093cJsKWNp0gAa0xCanij05ClUaXsajDR09HC/Ep//GWv8A2a3IV9h
	 bT8IU1APzufXFI7pj4O7EDsNmmMQ3dGIlV8taQsGtn6dKMFSA0A56g3d5Dwgp6LrIiw2K
	 O/lnylykOCO/qlCRd8IUqWCOrve8tRPVMl+4ztONFJ8oQTgizBu/ofNFjVWhY0TCKqexm
	 0uPYL6BOgHs+sXsF6wrFuqFH9OUJIk04q0rlC6WgS2+bLN5RiN3dXKoFfFa+ia0ryIJtx
	 hjMPsMeGy8nkx3va7lraAKtLbbTZaopsd2oqkXMa5c63MNIPGsnWG/d5XrD+XxC5Iyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
	b=nPBt2e3UhkxUJsVDa1xweRBIGgLA8NEDv2NFewwFzsQru3phN8vmyvo1JfgV4aWzCI2N
	 /0+vgIIWp4PPYfVgqXHStb3td1kmJQ227OPai6bs7Cl+LIyZ5Gtc0WJV7AOxDA979+NEq
	 NKSBmgvth7GejZMVuLooPiLfnX139uLk35/pytqYXKeV6Qm2BT/Yuizq81x2Tf6G2TPls
	 GioGbYp6u2RG954PbDgYTtbhj8QWfs7/bhWubctPn0ieYJJKABddm3JNMKauEAHm2OvGU
	 c2yBQvQpN3ewA9m0kdxvzcbyeDdJ4F5RFp/yd0ccbg9rIooOUdK3lyZrS1UU+/ODzyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oy04HEx4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE97606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE97606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oy04HEx4
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-845f3fa7f38so18574a34.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793302848; cv=none;
        d=google.com; s=arc-20260327;
        b=ZtA6FzLCTRtgAkgi/ty2q4jxWJFxao5P8cLJ9K/+jENb1Rcw5UXHxmcLy0c7N2iEIZ
         4CtSFA+hEjVlP+P7OKfYzdCUuQxvs7tu+VvZ1XucltLTgsqlt4LXYsqn3U7LaDNYyToJ
         aMyuRhKIQT+TvpWKiykDmJPR1hLouE1GDkw4a9yuqemsRPudKKYLDO5ydX6ZVuOzs0x5
         97o+Dsxum+SNRM/DaxLWAbM/b14v7pfAZJWHXoKZHx4SXpeIBS2HjQYZ1Iar0Fa21S8q
         PF8WV1gDp/B6xn+RE4eHrOJFxSH6i+Yf1O7x80EguSlstvoWw9OFS4kieOuLWaR4MKJg
         hqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
        fh=BJbWC1tFJclVOgqW0rz5pp1K3x7njhf2QuoS1l+pMYw=;
        b=XUPww8nSN00x0lGcgTdpUuIdAJGNecngnTfyutwxWWJJTopRCTIOCVWPyagOBPrUnI
         bGdfMbJIn14A1FQqEUKkZBvjwNG4GbF0l8l4lm8pv+T2vd2FyTziivOwebjPYEBFM8yE
         CkOhTBqYw/85ylb6x40WAf0GXLYR3VXg1caOz5W98bpzp91nZOzTcSybi3tBQmuQmHw9
         0oPOZUi2kCPacHZ+qp7jQ60v6oKMI1WLXmRezeVNtis9DtVlw5bZ4/xHP/X6eO9L8PCS
         4kmSgW+1wmXd4v7G6yLAkrawM7SdNziDM4PvQsr+hUidshO6gKiczB8/0wmQoW77jOCq
         /Hmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793302848; x=1793907648; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
        b=Oy04HEx4VXsy7bnK+jxK7wLwJKJgZjMD+ok02/ElUmFMcCdqOEpl4CNxdWoxJzIhzn
         U9RRGRt6Otan88a2NMxx9hAn+vJiyjDSutvbDnQ4fcfybjPlhxmIxNbVjs5s10zwcK92
         qYY1ODXDGpBmd69+yoWLRWbNxPvInfpeDY8XkeJeCFG0nCIscbu6LhWZlJFfvgNakjJP
         ggb9DU+L4K0N5slxw86nSUklX444AEIO8JnQXaH1vGuPc4coVKJTwqNt10udSvszwDnM
         Mh0X5ZLVObaRXY/xgb7VXOmvBk9Hv7hm3jm15v6zxqOE4mkNYW3VpvNXXZHhE1kT1t1/
         7jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793302848; x=1793907648;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
        b=N/kOxDo7CISULVq28eDrmV9MiPDMXODMcE38jdtBe216DFT8lmDDJ08Np3zgO6oaBP
         aQv+8eF2bYBgQmydXaKuf7p99hM5GX82H/E8ybMb9wKZS7huR5V7Y8EXALveAeXsgvhr
         3aWfjIrd/Csa2XpS2nTxuo05kkzAT/P8LaCWUt8ttvqmLNnx0dOd9zxqvWBMjB0rMZZR
         IP3D05mmNBOCj6In5C7elk1/0GZd5Hq4gNpWcCPf2dq8Fop3HUgju+uWErQKeyM70nj+
         CeKvVGCu45Ok57ak6D9vrVi8f9UH5Jaj/jfSd4oiwok1itvZsYpqaB+1FEjKjge/NhXB
         X9yA==
X-Forwarded-Encrypted: i=1; AKwUvBwko9kxfzt+HSW5o97zpBv5YcTM02cgwt4WYA8jGxTlUn11nO6Aw95eldAFzP/CfuiEYYGo+Yc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJP+oVeEDJ1WAlIuLkreI4u7pA+IXu8GfoRgWXTaDPXPUGKEIG9
	FqIxdjqz7BL8jmjIOaNv+RGZ8e16JnolanWvqeEH5gF5qHHN3nCPcnKNuJvDtVlu39V46rmJM8w
	GUAMxGIUvDy0RiruLEcdMwZh5bQZuE3g=
X-Gm-Gg: AYBFou1sbiLqtmJdMpHn8Tcurp3F5RHg1doK7hoL0KyySfpMEbEsY3iiMNWuVCDsGud
	o2TS01OJCH6yjeKT8kEvoRvjMsPb+Fli8FAmyQkfr7vrrT3aL1L1U2YjF2OJKyOx0p80M5jzmdp
	gI1FUaK+e9V9RM+apt+FoZlCdxxQuUEI8mcs7clIYKV1oQtANfqq2kEUG/UX0PppDF22XJrpazW
	6pMUYNRb86aurt8T/rHK1U7BPqOvCiAN0E4NX1ckkCGcEHnZHmxJs39sCytWqLMhpm7MzJZvGrz
	fZuwJCN9HlDANJHrxt1H8sQg5aOjkmsUMkjQFBsQWi83Go9RzQlsa7uC7p0NqNObxNCOKJJcCrw
	zRNTWr83SKBrTydWfjPdcuCPt4rDN92FHlWu/CQ==
X-Received: by 2002:a05:6830:4391:b0:822:95ff:43f3 with SMTP id
 46e09a7af769-85d3664ca3dmr142180a34.24.1793302848352; Thu, 29 Oct 2026
 12:40:48 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022163639.2566945-1-andrey.misyrov@gmail.com>
 <179303675173.3134.11217955296529787762@kernel.org> <CADvbK_dTUCUFn+sLY+zuN5_9+YC-axzM9FVr-yBKJ4jxwebkkg@mail.gmail.com>
In-Reply-To: <CADvbK_dTUCUFn+sLY+zuN5_9+YC-axzM9FVr-yBKJ4jxwebkkg@mail.gmail.com>
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCc0LjRgdGO0YDQvtCy?= <andrey.misyrov@gmail.com>
Date: Thu, 29 Oct 2026 22:40:37 +0300
X-Gm-Features: AclHuK9ZvCDg2n35I76iYH83HI7jntHSzE-MkCUSpArWzEKyyvJVxDkcplmhCjw
Message-ID: <CAC=piAqJCtKEn=jLaoaBCr5yAgF5dibhPYcrZGWPytYN=Ct8cQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix ASCONF address change on single-homed hosts
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, marcelo.leitner@gmail.com, 
	junvyyang@tencent.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 27, 2026 at 01:38, Xin Long <lucien.xin@gmail.com> wrote:
> This looks like a legit issue. Either way above works for me.
>
> Thanks.

Thanks, Xin. I've prepared v2 and posted it as a separate thread:

  https://lore.kernel.org/all/20261029193454.1028626-1-andrey.misyrov@gmail.com/

pw-bot: cr
