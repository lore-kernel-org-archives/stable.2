Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2F3BB48;
	Sun, 28 Jun 2026 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618922; cv=none; b=aTv7JMP8NUnE6hbngMeTNFTbqH54nJzrw7KcVI4XSCNjQzOHHBDMlvGRVihbIMMUzSafWDvYMdw0Oq6n2z/o3/I/9Uz7zmyrtEa2wp/M3DgdWoIIowMTbKDwTOGD5Qp+mqEP4Fmz7dc4jZOqLPapabUBTsqr5PBM/WgyyjFtkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618922; c=relaxed/simple;
	bh=tgOUAefXUOI7OgH2pPHLH6J6OxoeZ+NyShg3CBwtmGk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O1Hi9n+vaIvsoMIhQw/BfV3+AlW9L+XMnQBO1IV2auVLXdw01/GP9ryrFR83ncDNtHhxJih1rQ8ISjMnvDARq6B9vICAwTnNbJjh8K5LzOt2fIyIzxlbhdGeUq+RQo3HnCtpGC/47XD7SZpbJwmw9MCkJOxhMbWk0ns0hQSbpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S4;
	Sun, 28 Jun 2026 11:55:15 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm: drm_syncobj_find_fence: invalid flags check
 before NULL check   leaks syncobj reference
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626131719.37865-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:55:04 +0800
Cc: dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <71D22EE7-499C-4D31-880D-39602204570B@iscas.ac.cn>
References: <20260626131719.37865-1-vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
 mripard@kernel.org,
 tzimmermann@suse.de,
 airlied@gmail.com,
 simona@ffwll.ch
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5Kr1rCFyxGry7KrWxZwb_yoW8Ww4Dpr
	sxtr9Fvry8ta129r4IkFW8uF4Yk3W3t3y0gFWDJ3W0vF4kt3WUJ3y5Gas0gF98Jr1xCr1x
	XrnFyFZavFnrCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
	aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4NVyUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2pAiooa3wAAst



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 21:17=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> drm_syncobj_find() acquires a syncobj reference on success. The =
invalid
>  flags check at line 445 returns -EINVAL without calling =
drm_syncobj_put,
>  bypassing the out label where the reference would be released. The =
flags
>  check should be moved after the NULL check, or drm_syncobj_put should =
be
>  called before the early return.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 18226ba52159 ("drm/syncobj: reject invalid flags in =
drm_syncobj_find_fence")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/drm_syncobj.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_syncobj.c =
b/drivers/gpu/drm/drm_syncobj.c
> index 8d9fd1917c6e..e40e2d92d5ef 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -442,12 +442,14 @@ int drm_syncobj_find_fence(struct drm_file =
*file_private,
> 	u64 timeout =3D =
nsecs_to_jiffies64(DRM_SYNCOBJ_WAIT_FOR_SUBMIT_TIMEOUT);
> 	int ret;
>=20
> -	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
> -		return -EINVAL;
> -
> 	if (!syncobj)
> 		return -ENOENT;
>=20
> +	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
> +		drm_syncobj_put(syncobj);
> +		return -EINVAL;
> +	}
> +
> 	/* Waiting for userspace with locks help is illegal cause that =
can
> 	 * trivial deadlock with page faults for example. Make lockdep =
complain
> 	 * about it early on.
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

