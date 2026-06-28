Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C926A1C4;
	Sun, 28 Jun 2026 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618837; cv=none; b=KNJvTwP3G0R8rmwxruxyKc6/SqBMTwuqe+O7iNsuOO+CuQBtKe82yj9hlkNIJtcn1M8D962NmDS3IhCD5kj/V19jM4iRaIAoLM6OQ8QKu1daVzmbQsU2KFo2gYnb1RNqZcp/1tWuzd0s+hz9JnuqsOYwmHcU8khGSbTt4PRIV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618837; c=relaxed/simple;
	bh=9igWnYevIDt9qipy/yI1lZQ4qtJOMWjzGwopn0a5yhQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TR2wCOQCSuwDasZX4eVo+MIax4j4EE6YbFJXdKckFPQmZNr5aE93pFHdhtCNiKW3Qw2kkMDcin1bZC6LGtRxyI93gSER3ZpGIeV68LPTh59SrWOPK+5TaeCG/4yWp0ZSzy0q++9MUSKaw870wGioP9IrhGxvT7+KWhgDmdI77cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S9;
	Sun, 28 Jun 2026 11:53:52 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: edac: edac_device_create_instance: main_kobj
 reference leaked on   success and block-creation error paths
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626123523.36166-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:53:42 +0800
Cc: linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74C6D5CB-0855-4996-AB54-50B38B2681FE@iscas.ac.cn>
References: <20260626123523.36166-1-vulab@iscas.ac.cn>
To: bp@alien8.de,
 tony.luck@intel.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAA33NRbmkBqExKqAw--.34181S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3XF47GryfGFWkur4kZwb_yoW8GrW5pr
	43Jw47AFW7Kw4Ika1DAF48WFyFg39Ik3y8CF1Fy3yIgr1DJFy7XryvqFZrWF1rArZ7Ca1a
	qanrGw1rJFs8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcl1vUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2pAhrYhmgAAsg



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 20:35=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> kobject_get(&edac_dev->kobj) acquires a reference on main_kobj, but it =
is
>  only released when kobject_init_and_add fails. The success path and =
the
>  block-creation error path both return without calling
>  kobject_put(main_kobj), leaking the edac_dev kobject reference. The
>  main_kobj pointer is local and lost after function return.
>=20
> Cc: stable@vger.kernel.org
> Fixes: c10997f6575f ("Kobject: convert drivers/* from =
kobject_unregister() to kobject_put()")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/edac/edac_device_sysfs.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/edac/edac_device_sysfs.c =
b/drivers/edac/edac_device_sysfs.c
> index b1c2717cd023..72b06d608b98 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -647,6 +647,7 @@ static int edac_device_create_instance(struct =
edac_device_ctl_info *edac_dev,
>=20
> 	/* error unwind stack */
> err_release_instance_kobj:
> +	kobject_put(main_kobj);
> 	kobject_put(&instance->kobj);
>=20
> err_out:
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

