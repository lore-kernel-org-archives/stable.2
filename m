Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5048331A5B
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158724; cv=pass; b=YELTXa+X4Rd1wE+9GGVRT3OKMYr4V7QHtfo9mJaGfTa4LnSzOWDlwgj8cnQrBBVbA8ihY829SGYYDgVPP1ekA21qO/ac0yjzCpWqkScMwhUf+0jzS6g4c3mQcjiTXmlDFBS8xYVY0kB28A8JuMCjaDYhGDWx3o9HSpjyS/5+xiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158724; c=relaxed/simple;
	bh=sdRCAvwzHeyDtWKR9+hjR+VSJk2x3HzlI7jrONWWSrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2VbycIks9Ss61BRbvxjyTTAct3hridBAB/02jDR1izeH8M3mDHwxN9kIdZk6NIZxh4CqkwaqyRzoLYfPnPD9SB66CdXEFZPxviuINpHJdwpR04SVZgyf8JV3dydtecr/5rpELp20bvZF4qyowop0ktW1y4HO94Srm1rUa6eZ8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9TzdFox; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9TzdFox"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-499b02fc590so1500575e9.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787158721; cv=none;
        d=google.com; s=arc-20260327;
        b=WakMTQyihfKM14zqtBRWnxvifq/Ym+1UKdPSwQmVjRFLTcfqTjnN/f4g5D36kUNM7E
         PxWi2o1P3YmNkmJ0bNh2dDoeiW0Jy2kCxw/QOF7xZVSx6KNDNp+D9nQWZJWYw6i8ZLcn
         9QeSA//MUdPfu+4i0uJhNmWVixn2tjEzh2sGEv3FCUbbt/139c5F75ceyMaxw6IoH8Ww
         bqUHYWRFH1m1L75c99rxD/i1X3m6ls30P+4eX3Vu/3mKh/xG7yeMlkbPtrFSt/GVfw09
         r2n2M9rDteQtzKvcJVTlZEJcGzmJNjjPh8i3rEwGQeRgSfoJdvcaCLwTwgSwd1Z6scI7
         5Bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tcz2+ERoxx+kYTtW51wId71vpMRHIJ9V7FlPA1/aeWY=;
        fh=/uo6gsWhhOvQLIisRP8EowTCiPGOT+Jl8BOCWtM6HVA=;
        b=HRxxQ3dayyj553AndLvAI5g4TzMq2uGa6SC7W0ne8N7ydOq8kj7MHM6suq2krpI9NH
         GyezQYWB/+JNGDyaZLgjutOSM3MrNWY4j5zFd6PGRoPARVEnRU/zdvt/lgZ1jr8JawBh
         v92YQXonaCnlELkJkHB5HxEySsIkR6EZJ9Q5jNIqy5AivRzksqnPCt6jjUKump0Fa1+d
         cf9wzLJSJEdlFCCxHxundJ4ImYDpk2RY869cvnExX3h/45cKNdfV1GszXsNvECPNyB1g
         XpzWo++u8PjlDV+YuEPyAKeO9R2ONVwCZdJfjsEE7RM7HJ7qpklpgiwhx0yrWwaiqNup
         t+xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787158721; x=1787763521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tcz2+ERoxx+kYTtW51wId71vpMRHIJ9V7FlPA1/aeWY=;
        b=C9TzdFoxayZVNdZUXkkbR3lzl5L46ljpJV/330+17vCzOcZ2RJx/jpunmf7bKvWHEe
         MyTABJQgLgpkZSEq1ZZWYXEMuMXxN7CWbg/biZGjHIi2p5MJigGF/QlAVoaok+fxn9RX
         lpNVxZRq/SmsOK6LsRdVYwFfAXEcnHg3Be4xqXF+OBGogeizz7eUD3s5x1dW27YiBOV7
         Za3vIbGxAXfZ1fgZ8gRyq1/sKnyufuXvWg9jFU76PEvZd1KXAcgxOhVW9nCqPihSHjeV
         JlfCh4iUwwBVza2ELOSvqCU1AD2hIkgbb895vHYNGAwmqOizOS9Ef/+aKc2lcQOVDATy
         bNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158721; x=1787763521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tcz2+ERoxx+kYTtW51wId71vpMRHIJ9V7FlPA1/aeWY=;
        b=dRDWzqyzPHz1nMYPZLb1XXb1Mzc9N2bYqJ7xGAqfbd2f9CmrIWNpmK40zc/O+2FLkw
         XC9qY/FHPLvqymrz6TOzbdHTzQwKcYeedKztLWSWWgL46Q/UTSwGezCi+b/LylbhywnL
         sAKBT33elLGiK86RAUYcPtHiXtkW6gJtB9zRMVzaFTzGQSq+V6O+9lw4Z4nc83qjm2/U
         GNiE7Q3/fvK0d1cM1WQMLpKjFe4EneemDZ3KrnAmXG7JHKDSgxEoGxyWFvBche8Joxnt
         xDJ412fXIlEWWE8J6luCJTUdGeP44xMHHJ6ooP7R/40loVq9ZlZTMa6GH2dS8MdabzKz
         SSoA==
X-Forwarded-Encrypted: i=1; AHgh+RptBgAciP25+cBGQ38CHgq1zV0CFzEwpO6CvNMvsfeWfkYStWGNY5yctfGo5gDojw21A45asso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9Ko0pz4GW+E9WcDlwOTznrjU6frIOhwxDvVhbOLOnQbn0+9R
	u0Aj+rqKK6ES6kbKqt23EwBaORasVy6/hFXF33FkOrD1NEsiyQRjszecCqtQkzp1Ns7PZH0IVrQ
	YdzIagB+8O0gIs63UmpM5izlkSfhcIkE=
X-Gm-Gg: AR+sD106D/1+Pom9GwZUuu9qnGx3lTUsLnl3r6V5JrOkIaOjz6ecX5X+LqmmA45rkeF
	WfosW2qTVJWeWYeeGscWlkFZy/pZx5DXHW8qNnbjiE3RCpmpYM8RwQ4wSgCVC1ehHjwRYYP26MX
	BefoDnlQdSOzdMbxWGUst1K1Lcd99hms7YOvJFoU7x+fMwCDPAPj5XDRpXvXEDySsIeYSrfXCuN
	klKIYexNz2dHEvgrFdGeq9caGdGGf5EBXwvvvW+QnjgcAgnsZpevTyiMBDO9LL11w9NgKZPORWz
	sEPMQzo9mR0TU/y1RQmiqnaAtZ5FSVKTZIox+J1CsCRwcQ==
X-Received: by 2002:a05:600c:3487:b0:499:53c4:1daa with SMTP id
 5b1f17b1804b1-499aa1c2764mr129950665e9.15.1787158720615; Wed, 19 Aug 2026
 09:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026081459-handoff-wildly-eeb5@gregkh> <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Wed, 19 Aug 2026 12:58:29 -0400
X-Gm-Features: AcwNN1U52Hw-7ZSDDUeVbroHjiKw7peKR6l4dffU8RrMLUnsjU8oPSXsNB4pcaA
Message-ID: <CA+ysrSLfVBBKF-aEVW0tzWO1CKOxJjY8CoPOK1+xpEbdB=HyAg@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an
 over-long PDU
To: Greg KH <greg@kroah.com>
Cc: security@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:48=E2=80=AFPM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> nvmet_tcp_try_recv_pdu() reads a PDU header into the fixed 128-byte
> queue->pdu union, then computes the remaining payload length as
>
>         queue->left =3D hdr->hlen - queue->offset + hdgst;
>
> and reads that many more bytes into &queue->pdu + queue->offset, without
> ever bounding the result against sizeof(queue->pdu).
>
> A struct nvme_tcp_icreq_pdu is itself 128 bytes, exactly the size of the
> union. Once a header digest has been negotiated (hdgst =3D 4), a second
> ICReq passes the hlen =3D=3D nvmet_tcp_pdu_size() check but yields
> queue->left =3D 128 - 8 + 4 =3D 124, so bytes 8..132 are written into the
> 128-byte buffer -- 4 bytes past its end, over queue->hdr_digest and
> queue->data_digest. Those bytes are attacker-controlled (an ICReq
> carries no digest), and the duplicate ICReq is only rejected later,
> after the overflow. A remote unauthenticated host can thus corrupt
> kernel memory adjacent to the receive buffer.
>
> Reject any PDU whose declared length would read past the end of
> queue->pdu before the second recv.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/nvme/target/tcp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 75a276d73be3..c9c98b8eb149 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1229,6 +1229,8 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_=
queue *queue)
>                 }
>
>                 queue->left =3D hdr->hlen - queue->offset + hdgst;
> +               if (queue->left > sizeof(queue->pdu) - queue->offset)
> +                       return -EPROTO;
>                 goto recv;
>         }
>
> --
> 2.53.0
>
Gentle ping on this one.
