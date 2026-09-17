Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A54BFE74;
	Thu, 17 Sep 2026 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641645; cv=none; b=FZHSUlqpZUoBXTehwTc86hUnVfrTPYEQbq0BQKC1ntRFJo0JgdOK8QPRe6vx88j+ikKY/VZnZqKCjZ4wB0pJ5Odp03/jE6TdBIixnRT22akij7J3VbQCoQp5/JGUARNnPAi9vL8hj0JTOJalt8e5cqJIIDRx/y6xOc7LFqQo/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641645; c=relaxed/simple;
	bh=e1w3CIrykqL3tQpgHrb7Jjufje0Dn9t/Wsa40MhCs7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qs6GO7epOM67qnRPDpqSr5IrZ/2Br56KxJIUbsPypNz5Fz07YxDr3/QebFiy7QguUEw6GJw8i3U1Z7+HZQYJiFW24kKM8lakFt3BO5P4A1YPiIS/knfOpV8TOGcvIQ7obAXx9DhtIvqk7Xe/mD+viOHgxG3kgjZ4uHQZc2tpCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0NdSTwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0NdSTwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223651F00893;
	Thu, 17 Sep 2026 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641630;
	bh=B1y9pUsKx0AJ915GGc6qcee+i+Ha2X0DlbvDWbjL+wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0NdSTwTaGbDb/J8htFLNu6DxeWRMmZ1UFTfXLLMyvpKNpZXb3zPeTEy3FfMoMqb4
	 Z8rqvOZ6MtcIsnEDh+p38EfX5VCVljC96Bz9K6R/GIfGKdDI26GeUr3gWcKEDO4DaA
	 nCEhcz6LpHKV9Ay2yFlG2TbVbunzHXgdRFD0R9Dx/CdZR61ctR1BBvkpKfqH7G6K4A
	 IYtsduH7bDAhmKblOz+/uPnDKUCs4tET13Bpw+CjVKjbsu/g81qvdsSVp6XLhgMSch
	 MZmBe5UpXRyJOGhyz+OwBkJT05wU7FnC8wfX6i++3v7RxGGSULbaJG8XsdrEp8LG+4
	 rDVViGSvnEIdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mtd: ubi: Fix UBI device reference leak in
 ubi_detach_mtd_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>, chengzhihao1@huawei.com
Cc: richard@nod.at, daniel@makrotopia.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, vigneshr@ti.com, miquel.raynal@bootlin.com, stable@vger.kernel.org
In-Reply-To: <20260917103102.2147038-1-vulab@iscas.ac.cn>
References: <20260917103102.2147038-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:40:29 +0000
Message-Id: <20260917104030.223651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mtd: ubi: double put of ubi_device in ubi_detach_mtd_dev()
--

commit dc1e1560c6a92e217dc3827eb13a6c41acadcafb
Author: Wentao Liang <vulab@iscas.ac.cn>

mtd: ubi: Fix UBI device reference leak in ubi_detach_mtd_dev()

ubi_detach_mtd_dev() takes a reference on the UBI device with ubi_get_devic=
e()
and attempts to drop it. This patch aims to fix a reference leak when retur=
ning
-EBUSY.

> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index a901f8edfa41d..866638c006494 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1073,6 +1073,7 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
>  	if (ubi->ref_count) {
>  		if (!anyway) {
>  			spin_unlock(&ubi_devices_lock);
> +			put_device(&ubi->dev);

[Severity: High]
Does this code double-put the ubi_device on the error path?

Looking at ubi_detach_mtd_dev() in drivers/mtd/ubi/build.c, put_device() is
already called right before the ref_count check:

	spin_lock(&ubi_devices_lock);
	put_device(&ubi->dev);
	ubi->ref_count -=3D 1;
	if (ubi->ref_count) {
		if (!anyway) {
			spin_unlock(&ubi_devices_lock);

Adding another put_device(&ubi->dev) here drops a kobject reference that the
function does not own, leading to premature freeing of struct ubi_device me=
mory
via dev_release while it is still in use by other kernel components.

If a user with CAP_SYS_RESOURCE calls the UBI_IOCDET ioctl on the UBI contr=
ol
device while the target UBI device is in use, ubi->ref_count is > 0, leading
ubi_detach_mtd_dev() to return -EBUSY and execute this path.

This appears to be a flawed backport intended for a newer kernel tree where
put_device() was actually missing from this block (due to commit 7e84c961b2=
eb).
In this baseline, the reference is already correctly dropped before the -EB=
USY
check.

>  			return -EBUSY;
>  		}
>  		/* This may only happen if there is a bug */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917103102.2147=
038-1-vulab@iscas.ac.cn?part=3D1
