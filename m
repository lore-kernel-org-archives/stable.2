Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228F318140;
	Sat, 27 Jun 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573829; cv=none; b=e2tm5dPzKu8gXP9jXIt9j+G71Wa1vZX+ghO4FCFtTPnMXrO7ymRUFJtuXWvZdbN/rAv4xAbX1fzyJHFcB7QK8zSOCaOBjYb1aCkpIJx8nfvpEGHgDaPyJSz9kY8fAQszlZqpo6DIb0HDk0kaWfDondLGK08+aY3/IF+YIFdBT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573829; c=relaxed/simple;
	bh=SKkLgfzb+9PoSVFK40fgvdbioDrAdGq2TjIBTmzzUag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLu+oCr6iIzJu7GzCqzGC8gnH4ZZy79OglRt4Wq3gvDvNlI2F3u6Cjcc32Qo89xnQhKJdOxaK21iQ3F9+zeRLj3hjhcynIx7s4QU6JYYyrQIRyIuuTFGRNccuia69QQ9tvjVjtvGei9MzlDU4+me4uKo/qB6qmiOq/8NNZMzV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=GYILUGZY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="GYILUGZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782573825; x=1783178625; i=deller@gmx.de;
	bh=jSXXShRaB8CfStonBcGI5h0Koo2ofDmZljhRh9+RD0c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GYILUGZYKixYwK5uGARoL7RWIk212D7sGQwBVBCy5Ytdjw9w6pJhSJuLbR6caRD8
	 hkK0aHWa+7+ISzPwNzUNsz02oN58JdZ+mcJyC0pqs/WvgAcSSI4ooNoGw4sFCOSj0
	 zZGfSziQOlejXlaNXrLjvLlOpZ2HHHIF7wwho3sZEcZmZs1JIxidksSGqd5ARi6s2
	 gPn6HuMG0AEohQo2rgm2KfP+LjSJ3XW/RMzNiCkAbJmIgz1nRGvSz7jU47ctr0LYl
	 mJpvCrDm7YdQ/s3tiYMxf3AYAt6tJe2fz5DZqp98WBF1nEcGIuXPgvB3oJxlNDkZj
	 BGHTITa7Jz0rqpqZOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1wNFDG1BwB-006L28; Sat, 27
 Jun 2026 17:23:45 +0200
Message-ID: <c9c60382-e6eb-4ff8-8756-a48a39924d46@gmx.de>
Date: Sat, 27 Jun 2026 17:23:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: drivers/video: __screen_info_pci_dev: leaked pci_dev
 references in pci_get_base_class loop
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260627034428.59479-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260627034428.59479-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+sa7HlPLXSTyz+J2UEPH2rxmNZjdBsit9NS+PSjHy+AkTkpPjdr
 OzH6ovkgXYLOc+1m+Cddr/QYLvId5/XaBhxAiWc9TPrifu+jlYnAC20mdLYOBFpK/VlnZrz
 ydeFtA87o5QC0hk5e8txbXHnXwQ4/skzuwQTHK1PpCTvR8rvsj7h9fCCR394vXkVmqJdXIZ
 NjAAEp1nRpLMCReS3ztyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KjY9Eiju5BM=;L4nIl7f2N7mdqh/nPfFIOl8dpjf
 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

On 6/27/26 05:44, WenTao Liang wrote:
> In __screen_info_pci_dev(), the loop uses pci_get_base_class() with a
> non-NULL starting device pdev. Each iteration returns a new device
> reference but does not release the previous one. When a non-matching
> device is found, pdev is overwritten and the previous reference leaks.
> When no match is found, all acquired references are leaked.
>=20
> Add pci_dev_put(pdev) for non-matching devices before continuing the loo=
p.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 036105e3a776 ("video: Provide screen_info_get_pci_dev() to find s=
creen_info's PCI device")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/video/screen_info_pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info=
_pci.c
> index 8f34d8a74f09..c821101e9304 100644
> --- a/drivers/video/screen_info_pci.c
> +++ b/drivers/video/screen_info_pci.c
> @@ -123,6 +123,10 @@ static struct pci_dev *__screen_info_pci_dev(struct=
 resource *res)
>  =20
>   	while (!r && (pdev =3D pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pde=
v))) {
>   		r =3D pci_find_resource(pdev, res);
> +		if (!r) {
> +			pci_dev_put(pdev);
> +			pdev =3D NULL;
> +		}

Have you tested the code?
If pdev gets assigned NULL, doesn't that introduce an endless loop?
And, similar code is in amdgpu*  and google's framebuffer-coreboot.c files=
, so if
this is correct, don't they need fixing as well?

Helge
