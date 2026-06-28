Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07180348C53;
	Sun, 28 Jun 2026 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619419; cv=none; b=oR9bghM4sJBFaRJMMm+01SjMk9HT9VKeA2ToGrGaFRr7iJ8yv4y4CxBjdnzM+FrhOoBwwU5bKL2cPxwbmVGb2HrOqbveR1PL8QPifivitMz7RxpG7qC5N3pUUh6LaWmIxHCBhth1AIJfPUunFLUvW30XJ7WYU+EjK/fQMbLeWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619419; c=relaxed/simple;
	bh=aO00Dtfb28hrhjVta2JSwIBIO4q0ITewEiKD5ZrOdeg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pohKRBxiUaPf6VXDo+gFCNilepHkEq9K5XYoHo0iVmUJEySgE9RJtQWD8etb88HfJAIiv9Y6/W63FJ+hfyx7KjpoXOIHGg3ZD50WXbPqkzKokj8nbK7bh7/nl6KeqhTJ9Jlg2DA2hHq0x4Q7PJD1/v40K5wsYJbPBrxeMas1D54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S12;
	Sun, 28 Jun 2026 12:03:23 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/vmwgfx: vmw_simple_resource_create_ioctl: fix
 base object   refcount leak on ttm_base_object_init failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626150224.49792-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:03:12 +0800
Cc: bcm-kernel-feedback-list@broadcom.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D265306D-1226-48D0-8DA4-BC11C6CAF564@iscas.ac.cn>
References: <20260626150224.49792-1-vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S12
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UXrW8Xw1fCFyfJF45trb_yoW8XrWrpr
	4fJrW3Kr9xJrWIqFZrZa1kZFWxZ34qkrWFgFyFy3s3uw4qvr9rJws8ZrZ0qFnrCrWfAr4a
	qw1kAF4kuFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07j0lksUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2pAixEdPgAAsc



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:02=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ttm_base_object_init unconditionally acquires a base object reference =
via
>  kref_init. When it fails, the error path only calls
>  vmw_resource_unreference but never calls ttm_base_object_unref to =
release
>  the base object reference, causing a refcount leak.
>=20
> Add ttm_base_object_unref in the error path to properly release the =
base
>  object reference when ttm_base_object_init fails.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object =
functionality to the vmwgfx driver")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c =
b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
> index 0d51b4542269..05f0f5544142 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
> @@ -176,6 +176,7 @@ vmw_simple_resource_create_ioctl(struct drm_device =
*dev, void *data,
>=20
> 	if (ret) {
> 		vmw_resource_unreference(&tmp);
> +		ttm_base_object_unref(&usimple->base);
> 		goto out_err;
> 	}
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

