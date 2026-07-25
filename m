Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D643AB0;
	Sat, 25 Jul 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991838; cv=none; b=CMsrRQahz1srV0lRtT55qjSp9yT3Fw5Mcw1LRMdTM66bU+MwqJUFefkjOBib0Khv0iRCMGr/j0gb59KztWLbYyf7ACoQhFPujBy16GqZnc2YSuwUEcQMVKBlt/zq4ea/LktsOVbsvTalJUj8wMw2ltFurTmQg30p3itv8HbgCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991838; c=relaxed/simple;
	bh=phsj+8OicHP4HTkP6kh/MF4qMxtRitJHAIc6qEEWhlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0DyAWDFl0WKRVeuIw9mbNNbZ5KtDGl6jdHqIqDZD2WaOST561U/AXWbseIObJq69tHcz8YJmXnK9v1U4VEkA8K2GSBpgJrsyHijEAp0vQ7PLvmlmP+Tx1XYzpxT7KvGPQd4UbEW+mDutssvb9GIDkCtJ/aPNycJPA5AThJPspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ImtWjTib; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ImtWjTib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784991824; x=1785596624; i=deller@gmx.de;
	bh=gQP41PXDTlt8OngRtb0K1E2PPrIQ/NdOYOkcaDf98PM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ImtWjTib35YJvqYV3CZjBjrjf2UMmVJbO7LDTRxJqM2OlHyc1SA1ctRgXXc35z8H
	 ZsDa6P3yw9dRl9IWEj7pwj6vmuGDQK9g+l/ink1h9RrHsQVJJWeL7pGaatU31Jjej
	 pkq2jg9KZSGhzfdH7EkiG7yaVv0rvR3284ULhpZKEt4aRrukgUw8AaQiB5hj6iXSc
	 7KdLnQx/5iv3d8s9XAWe+wYzvHEKT8YNK17dkiWojbM0zK4yynMxyGwZikcoSCkde
	 bkYPB/4TZnlDsT4nr4vJixoKt65Zk0YR9bJ3tFIxaEwZGrlZuulOAnlhBr+qh3k9N
	 MvQmnyq+VYZAsHQ/2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1wtxyJ1GBz-00BK6v; Sat, 25
 Jul 2026 17:03:44 +0200
Message-ID: <86a0387c-b704-4ea5-8117-02b30c4faeb3@gmx.de>
Date: Sat, 25 Jul 2026 17:03:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: core: Fix pointer desynchronization in
 fb_io_read()
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>, simona@ffwll.ch
Cc: tzimmermann@suse.de, sam@ravnborg.org, javierm@redhat.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260721081942.107024-1-25181214217@stu.xidian.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260721081942.107024-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UkxEi2cJg8mKSpkLg+oOYjH+MpfqNX3ACm48EI2uA3PEKFCoIkr
 jzgKSJ9hF17lwjIw9ufU6ukCwqmfxUiTDQA41BPmtcFtCWaWbP2wpoYpPgyybHSS1FTzM9p
 KgsSYL5srUYovgmq28BImz4J03HgYOF2C2w8T1pnd0NzAgnkrlRafHJM4m7492ULJXtnb78
 jQ2urh14fdQ34WOwtZRAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uzaZrYGbvIU=;jGSzxZKdt1QXrNoW/mqqEfLliUu
 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
 sHltU3TgON/Jj+LGjkW2n

On 7/21/26 10:19, Mingyu Wang wrote:
> In fb_io_read(), if copy_to_user() performs a partial copy (e.g., due to
> a faulty user buffer), the loop adjusts the chunk size 'c' and updates
> the remaining 'count'. However, the hardware 'src' pointer has already
> been eagerly advanced by the original chunk size.
>=20
> If the loop is allowed to continue, the read will resume from an
> incorrect, over-advanced offset. Since the remaining 'count' was only
> decremented by the successful bytes, this desynchronization causes the
> next iterations to execute more hardware reads than originally bounded,
> eventually leading to out-of-bounds I/O reads.
>=20
> Fix this by breaking out of the loop immediately upon a partial
> copy_to_user(). A partial copy indicates a faulty user buffer, making
> subsequent read attempts futile. Breaking out ensures we return the
> number of successfully read bytes without risking out-of-bounds hardware
> accesses in subsequent mismatched iterations.
>=20
> Fixes: 6121cd9ef911 ("fbdev: Move I/O read and write code into helper fu=
nctions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>   drivers/video/fbdev/core/fb_io_fops.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Thanks for the patch!
It seems correct, and I've added it to the fbdev git tree.

Did you actually ran into a problem, or how did you find this optimization=
?

Helge

 =20
> diff --git a/drivers/video/fbdev/core/fb_io_fops.c b/drivers/video/fbdev=
/core/fb_io_fops.c
> index 6ab60fcd0050..0798e88799eb 100644
> --- a/drivers/video/fbdev/core/fb_io_fops.c
> +++ b/drivers/video/fbdev/core/fb_io_fops.c
> @@ -61,6 +61,14 @@ ssize_t fb_io_read(struct fb_info *info, char __user =
*buf, size_t count, loff_t
>   		buf +=3D c;
>   		cnt +=3D c;
>   		count -=3D c;
> +
> +		/*
> +		 * If there was a partial copy, the user buffer is faulty.
> +		 * Break out to avoid over-advancing the src pointer and
> +		 * reading out of bounds in the next iteration.
> +		 */
> +		if (trailing)
> +			break;
>   	}
>  =20
>   	kfree(buffer);

