Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515817;
	b=a0F2r8bgDuNiXseejdueDWzRPqjnNByocXDbTCriuuLjKyF7YaR9diSDEZW3V2IZk6UR
	 /HBLDw0nw3izGxLnUfBwqE0RuM+OAMCc5XLYpZdOcuqIA9q0uqazhC/ktRefAmxtbkEfR
	 9UkGPTieLIM9ROunXrw+YoyqDHP/y4Y8x9Mfih1NiaCmlcyao3mxTClHj4CRMXjKWGvjj
	 wltwfe4fJ6+5Us2qoHeCcWaqWRxgmwhjdH8/cFAaEGCAOnk0lKQR899fnjJ6XElOg6OgB
	 lKGu2ydxeK7pzSl2NKUNEMHnzpLMd0uCZhNFc+CF0v5dyYYa1hTfAHpBmde9IiOwrkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515817;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=WtEjfn1/bkQXnkb8OIBYzCwxyKgK+yemEcgr8ew+7uw=;
	b=E8M/p0HS0Z2YkopdlYQBnJuQAsZUnWh0pa5O0uitToJ9lJXBst+26quIN/P8cTHD32zX
	 OBb1E++XFaElek2uLoMlTkRqipXESTJ4D0LMBb0rVIDvxm67FmVXs1vnDYpP7hS/Of9x/
	 4u7qe65bxTQjk5ZzjwuvNSIyt3YZkt/ai3cQzSIdjHd18z2/UUFRXdIx9zuD5qcbOA6dr
	 AtaxwGdpNuPGqY29bX/0RGDZ/CWhtL8bEC3FN5s9zR1K5FtoHgrH1fWkH6GYeIs8OveAd
	 AHR9bK/ITqah37mfHtfXEB4+XFu4PuyNcao7sU3nIVA462aZrxgcr53WrZZz7ME8P2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HXneB8Yk;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667F606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B667F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HXneB8Yk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4C4DD1A17B5;
	Tue, 24 Nov 2026 10:23:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1019F601E1;
	Tue, 24 Nov 2026 10:23:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CA6C11E68B88;
	Tue, 24 Nov 2026 11:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795515814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WtEjfn1/bkQXnkb8OIBYzCwxyKgK+yemEcgr8ew+7uw=;
	b=HXneB8YkLniRqwDmHsHyn+pmJFy5NMAQT1ue11XAZWc+o91vX9rAoN8zon1Te38XPE32w8
	QRY7irZ210tb9NSBzRLDNvtH4Hiq+43dYMQ4P+3Iyz7wL3gXW3n79810r7OBP1IlGwFMQD
	4OvmeRe60/hOCHHO1ZMqYoj9LveaLz0ItRfgN2RqB/lNbMq8wvFSzs7IDELGA5v/4+SnAF
	I97nNx/8dWaZJDhVVGivdgQy1b6MxgGMEWXIpueEHFKB3SZmvVLkgr6VBD52f4sLI7XKqA
	5xTIrst4FnrZs5z3htpR9ywm/bQwE2XRF252MnGSFXo/yhXFjc3pozpOj0HVPA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: serialize dynamic partition registration with
 removal
In-Reply-To: <20261120-submit-mtd-partition-publication-v1-v2-1-8098cde01961@gmail.com>
	(James Hilliard's message of "Fri, 20 Nov 2026 09:02:06 -0700")
References: <20261120-submit-mtd-partition-publication-v1-v2-1-8098cde01961@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 24 Nov 2026 11:23:31 +0100
Message-ID: <87bj7ettng.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 at 09:02:06 -07, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> If a flash driver is unbound while userspace adds a partition, removal
> can find the new partition before it is registered or release it before
> its sysfs attributes are added. If removal finishes first, the ioctl can
> even register a new partition on a master that has been unregistered.
>
> Hold partitions_lock from the start of partition allocation until the
> device and its attributes are registered. Mark the master as being
> unregistered under the same lock so a later ioctl fails before allocation
> can read bad-block markers. Clear the flag when registering the master.
>
> Fixes: 5daa7b21496a ("mtd: prepare partition add and del functions for io=
ctl requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Use mutex guards to keep publication and teardown lock scopes explicit.
> - Link to v1: https://patch.msgid.link/20261108-submit-mtd-partition-publ=
ication-v1-v1-1-cbff20b1351e@gmail.com
> ---
>  drivers/mtd/mtdcore.c   | 4 ++++
>  drivers/mtd/mtdpart.c   | 9 ++++-----
>  include/linux/mtd/mtd.h | 2 ++
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index b170c3144ca8..5ee1eb29fc1a 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -918,6 +918,7 @@ static void mtd_set_dev_defaults(struct mtd_info *mtd)
>  	INIT_LIST_HEAD(&mtd->partitions);
>  	mutex_init(&mtd->master.partitions_lock);
>  	mutex_init(&mtd->master.chrdev_lock);
> +	mtd->master.unregistering =3D false;

Maybe this is worth a WRITE_ONCE() to tell robots that there is no
possible conflict on this access?

>  }
>=20=20
>  static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
> @@ -1206,6 +1207,9 @@ int mtd_device_unregister(struct mtd_info *master)
>  {
>  	int err;
>=20=20
> +	scoped_guard(mutex, &master->master.partitions_lock)
> +		master->master.unregistering =3D true;
> +

Actually I'm not sure my proposal actually fits. It does not make the
logic clearer. At least not implemented like that (and below).

>  	if (master->_reboot) {
>  		unregister_reboot_notifier(&master->reboot_notifier);
>  		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index ddded0dbe77e..b20fa4309084 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -278,13 +278,15 @@ int mtd_add_partition(struct mtd_info *parent, cons=
t char *name,
>  	part.size =3D length;
>  	part.offset =3D offset;
>=20=20
> +	guard(mutex)(&master->master.partitions_lock);
> +	if (master->master.unregistering)
> +		return -ENODEV;
> +
>  	child =3D allocate_partition(parent, &part, -1, offset);
>  	if (IS_ERR(child))
>  		return PTR_ERR(child);
>=20=20
> -	mutex_lock(&master->master.partitions_lock);
>  	list_add_tail(&child->part.node, &parent->partitions);
> -	mutex_unlock(&master->master.partitions_lock);

That mutex becomes super wide. I'm not a super big fan of it. Isn't
there a possibility of deadlock with the notifiers or any other lock
inside? Would there an alternative?

>=20=20
>  	ret =3D add_mtd_device(child);
>  	if (ret)

In case of failure, should we clear the boolean?

> @@ -295,10 +297,7 @@ int mtd_add_partition(struct mtd_info *parent, const=
 char *name,
>  	return 0;
>=20=20
>  err_remove_part:
> -	mutex_lock(&master->master.partitions_lock);
>  	list_del(&child->part.node);
> -	mutex_unlock(&master->master.partitions_lock);
> -

I think there is a rule where we should not use those guards with goto
statements.

>  	free_partition(child);
>=20=20
>  	return ret;
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 8d10d9d2e830..cd7b4671c456 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -224,6 +224,7 @@ struct mtd_part {
>   *		     not only the master partition list, but also all
>   *		     sub-partitions.
>   * @suspended: set to 1 when the device is suspended, 0 otherwise
> + * @unregistering: removal has started; protected by partitions_lock
>   *
>   * This struct is embedded in mtd_info and contains master-specific
>   * properties/fields. The master is the root MTD device from the MTD par=
tition
> @@ -233,6 +234,7 @@ struct mtd_master {
>  	struct mutex partitions_lock;
>  	struct mutex chrdev_lock;
>  	unsigned int suspended : 1;
> +	bool unregistering;

Maybe unsigned int xxx : 1 to be consistent?

>  };
>=20=20
>  struct mtd_info {
>
> ---
> base-commit: 14b6830335eb6d70dec7a235094d66c22d38eb07
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mt=
d/fixes
> change-id: 20261108-submit-mtd-partition-publication-v1-4629be94d7e6
>
> Best regards,

Miqu=C3=A8l
