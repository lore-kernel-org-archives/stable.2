Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197828;
	b=tfsPIkaf0UsxlWrOfsSnHaGcbH3h+5mNAXtwu62BGtG3zzBhzTIOVwQEvSwTHEc4ek+1
	 DaWUY0Fit3z9y3MtMSoIyOaczgReHSjpadwvMR5+amowjhO4tCv4jm6GbMRrDBbU5q/iE
	 +om3gLO0FWPCT1d9v+a/ROIfBs217hnsC+NaBazgranBKisZ+hPEN7zI5PHscEmf0WyBR
	 Rubw4EMPJVYwfYcTRK4RNPyjMS5zi3jdsT8ftWAMzHdhreYNDwTeyD+vA9G5kNdFL3Yk5
	 1AT4Daz/SKhmb+ypAtBTb+id4bivHFMBY+ecf1QtE5jgTE5uxXTGBmCSY6X5L9QHpYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=;
	b=PsinlVmeYV03CGOD284TTb/8J4Vguie/vsuTPKIt1ICQ55fxMIdDI10JBCRj0f6tgGVo
	 XsaCNJMycrhm7VeHsaf+3kvN1QOQxifqaLl5vM1kcfjDaP/WvFKLwu0hFNlJ9eP/i8g9R
	 HVL7KPS9pfP8gO9WTzzzhIaURNeabaVdlXD+urlZTu4UdtkpJAYB1OHOtUH5rbYugWFDZ
	 l6/yOf5Wzv+1DCRcd0XC3ONB1lPpPtLqBLxtZGdbDC8DqgTfEbg+ySQcxYYZJAbf7zcY/
	 Gsv4laEGFlNS8w2M15kuXLaOsWGGwtbzJ/VAclPLcaQAhj3DJXifmU+yTcYCbfscAzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Qn9xrzae;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78760A380D
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C78760A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Qn9xrzae
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-71acd8968cdso59145eaf.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795197823; cv=none;
        d=google.com; s=arc-20260327;
        b=T4AY+DRUH/K+ruIgkKu4Rau9YGv2Z4jIQ2tdTTOP9ru9NRH2c3Em6iebqkp+nPKWV+
         kZM/EdAsIBupWsFAsNYlXhHeLBCwdAsu4G1Tf0STKDhwCpuo4sl4U/gzuJ98EJUlrSC3
         My7CQCkDgl48fK6+F7HfZKlxtsITLvXg/+MO0l0MmhiGoVOuwiXbdZDIlkkwY6D9CyjP
         +EMzywnLVNcIbYvC5OTY1YhBd2ow38W4D2InSm0Y0gO1e70x6M2jS0R2/0dYZVBOVbRa
         ytRsjbTmgx3ayWwmRyfxNd+WDNb7Lib52Z5Ma+pZegUApFXvzzTks5DUB2uKLjSJh6ao
         qQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=;
        fh=5+L1g97INkRQpnFU2BFjCc9Y1mjpqvqYx57uuQMo3Ho=;
        b=kK1Rbi16Iq5+8eD5saxvoWJf6iK3wjsszU1ljJYek/V8po3Uz/+QdqpdHtbah8sOE7
         ukV/+jFo+2ExBb8zajj7tjItCc1NItfcfY7SDT+EDyNDtyZEJNPL9ImLKARStAVg3aAT
         zCpYGKnACBX/ifUH95PlNYaIGx3yppSjUHJUyORGKef9wx7gcZfLj3S0ObRU52qnt17E
         g2AWQSpFPp1EtnsgPR9VBljy98ALvHDMWYAe1c5ltnFOvkG7/j0PEufxFFOY+I3dJVsE
         j3BVvnUQfePlVb53fjoVc158YqfAJzmcGHvUKJUfetBLznatP0eL6zblYe8O1UmTZAC7
         +zvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795197823; x=1795802623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=;
        b=Qn9xrzaeM6NC/lNCk5HvJjlS74/wdHgv02t9aWq6wVtdOIP2N4hJzHGr8euQzMOiRO
         7DjB5MpA5ALDBuo1PTYyDk58lc88mdxJ/YHZSBj/8lauORp1/rVM69euVsu0nhkCPzYm
         0TpqTqXhUmRJavCOrHaCCJp8KDISHRadqrkthIv9p+cTeJOAX5QBPK3OCW6V8C9s0+gw
         s6fZf8r8Zf4j4/DoshqTXTkcgI1d2zrDBwDWJ4sSZbk2CW8CcaUzAPCqKP/BXm0Rj8rC
         aHGAkEleTKW+y+YMHGjBMkm1fH46bIiwQLJRWzBMZ44tWlpht6WCm3mQIaXieelfoDV/
         4dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197823; x=1795802623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=;
        b=1kJTxoj1bj0HMeFYV6OoiNCcNZFvnY0ghFOAW5ptRnXe2NjRLJjuoaFKx75pQPvRhE
         EZHtAeCSSUsQdUoIH7fzVY95PXrpgxuiewjesGZY+UusHCdGgqmSJeQYwy55TcKZCO3i
         Y9mFudDY0/gZkGVlYbHyfHAQw3otjEo9CcZAhiP7YxND8WvNz5IHjc5muhIziDfZ+smB
         BPwc4hzz1CIq1MpXzkxMexcXYgJsbFRZ+26nzktrPJmiUaGfd/6IYCbEdHkCc3SGxvsU
         gTb2hEY3cYxMr1vYza1tMkRoyuOkpbrUfE+JzD8n1NnzGDT9Rff2Oto/AIllDI1et9uL
         yG+Q==
X-Forwarded-Encrypted: i=1; AL+hErHabkHY8NL5Q93qsNRgHWCeXRLEhz1s/BWMFrHdObYe9zbAnq90WwOek3yX/5L+Yc8OlIdeH20=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V08ISzypu1uuKtJW07ajoi0zT3u0GKbC9FiUFoJ9S/TgwVSCQ
	gabaamG4lIsyyLvP837OjTKQXoOF1JOG8uQeI5S75GAy2i3KhG6sjKLzgyINx+pQeiekNtWXYL1
	UzFu+tiOiTArvIsJcgeXfgGUYbhK7hlLNgMJkuN2kHg==
X-Gm-Gg: AYBFou0UXDJ7PloBz8pCPQXbXt8UjP6mwr/uEejnIUo71Z/hnNpv7946irp9FV0yElQ
	A0WiEPTYeJ7LPQQavJPExadRqdF0MMVrLFcMkqMubjDCvfNzZPGgmf4p3UNo9TqEv5odJKRl3Rc
	6rGmASJMbMe18QnDJ56P8rIu04uJUiYOe6uM7GWLzRBXi7MslHoO43eyCzCbxAc8D7Y+SnxsIhJ
	+C8XYm4YfTmjgrJY/62xjCP1P6pJBKxSU+WoPJIGm1PXwKBAAdX8IPxDMHMzkpBCzfYwRSlmVA2
	iW2j0dzq+HLDmYiOAApK99N0M6H0XPi/e38N8/nuq2LcqpIbF4KAipgZO7GPteNby92t3UIh8KM
	mzSwiyV1cJvTHAio3bAgcLB/MEOVlwNj1Y/0Ul78nS1AyOhoqKN0yFOmYcg==
X-Received: by 2002:a05:6820:840d:b0:71a:ee8a:5d26 with SMTP id
 006d021491bc7-71b3903669fmr3370770eaf.0.1795197823321; Fri, 20 Nov 2026
 10:03:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn>
In-Reply-To: <20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 10:03:32 -0800
X-Gm-Features: Aa3M54pd1WfunxbMR_7rgO7xsdkMjIOdAlBuB31wGQur8IoVOOkbFLJHq_cPaug
Message-ID: <CADUfDZppuZYzPyOeAc8GfW=KjpGQj5wK0T0D-UXBHokG67Zxbg@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvme: map passthrough data when the length is nonzero
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 11:13=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> nvme_submit_user_cmd() skips mapping when the user address is zero,
> even if a nonzero data length was supplied.  Passthrough ioctls and
> NVME_IOCTL_SUBMIT_IO can therefore submit a data-transfer command
> without a mapped payload.  For example, the loop target returns a
> Data SGL Length Invalid status instead of rejecting the user buffer.
>
> Map whenever a length is given and let the mapping helper validate the
> address.  This also permits address zero if the process has valid
> memory mapped there, matching the io_uring passthrough behavior from
> commit 99fde895ff56 ("nvme: map uring_cmd data even if address is 0").
>
> Fixes: d29ec8241c10 ("nvme: submit internal commands through the block la=
yer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
> and a file-backed namespace.
>
> NVME_IOCTL_IO_CMD with addr=3D0 and a nonzero data_len skips the mapping
> on the unpatched kernel and submits the command with an empty data
> pointer, so the target rejects it with "Data SGL Length Invalid" (status
> 0x600f).  With the patch the mapping helper rejects the null user
> address with -EFAULT before the command is submitted:
>
>   unpatched                            patched
>   control read (valid addr) ret 0      control read (valid addr) ret 0
>   read  addr=3D0 len=3D4096 ret 0x600f     read  addr=3D0 len=3D4096 -EFA=
ULT
>   write addr=3D0 len=3D4096 ret 0x600f     write addr=3D0 len=3D4096 -EFA=
ULT
>
>  drivers/nvme/host/ioctl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index a87c9ca9d06c..22efc5412416 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -207,7 +207,7 @@ static int nvme_submit_user_cmd(struct request_queue =
*q,
>                 return PTR_ERR(req);
>
>         req->timeout =3D timeout;
> -       if (ubuffer && bufflen) {
> +       if (bufflen) {

This is a potential UAPI change if a userspace process was setting
only the addr field 0 in struct nvme_user_io/nvme_passthru_cmd to opt
out of data mapping. (This seems quite possible if a struct
nvme_passthru_cmd is reused for multiple commands, one with data and
one without. Or if userspace isn't bothering to initialize data_len
when it sets addr =3D 0.) I agree I would have used this condition if I
were designing this UAPI from scratch, but I'm concerned about
breaking existing users. Are there real applications mapping data at
virtual address 0? The change for nvme_uring_cmd was needed to work
with kernel io_uring registered buffers, where addr =3D 0 represents
"from the start of the registered buffer".

Best,
Caleb

>                 ret =3D nvme_map_user_request(req, ubuffer, bufflen, meta=
_buffer,
>                                 meta_len, NULL, flags);
>                 if (ret)
> --
> 2.43.0
>
