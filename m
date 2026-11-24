Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795537879;
	b=tjjngqGPNKRGBShBciOfVILye7uL7T23WxqNMPjBG2kDSlduSYdDlpj/28TyDKYPx+Xi
	 VVEYeRtGW+/8Z+WYppRCMMVDwp516xg2JeZhvYROmcjQl/VNkId4ZRPuurXJE/lDx3ni1
	 VO/Em4yQjskW4jsANxe+NqY70wMqVAAzPE/9l/ps3uiTMWiwtXTJFbgIcDQxAS4mIymzg
	 stTtXFrYHiIYAMjf4gUB+PGirfUy2WNuoAmlFmhj0y0zerF3vapfF0fqFXyoUOMVxdTOq
	 bxtLt/vn9itOhyMIKrSwStNirRtP/2zMUmzZYdVJtmNEAtwUaw3VlBCT4iIzUFbyYPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Wbz5MHgrotvmvS234Ul0ZoF8Ky6iZRkQglERKXzkxJE=;
	b=2gTamJxHVvmjwAGreoQO+zhPfR5PuXOE8XyI+6KpYAfkdMecLiTsWKpcT6/bGlugi/kj
	 vkC5IF2d1/sSFUEzx72pjbuAcZZn+dO3daFvG3bIyR5C5DkK0KCqZhiKpyvYEKu5UnuVv
	 82gmJ7qoXICCDdAdaPXlxMJ4ruCPcguUbXWT6k6JpRM6YklFb+gfnK3HkpQpp/yizHM2o
	 xPiU0D4RPpgpDd8yjinvmKFKfefuXe6ZboicfoaSVCoAWX13hgqWmvZD2FHib430peq05
	 v1J07mKyrGwA42oak3NXFZ25WVf5nXamzKZM/AcqX5fUqKi+sy6mAPIrfQsnEKBdjqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKjkz+CS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C2606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3C2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKjkz+CS
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2b25786d9so2483231137.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795537878; cv=none;
        d=google.com; s=arc-20260327;
        b=IxTYQrw7MUl/1qw9+qlmwz55zEu2jSnl/+pW1ncH8DtlFFyQx+FHBBHSPkzHsrVIL/
         R6dLTDZbESIMOhi3e3ZZyicUUnwmNbVv7LunJi7zA80rfKUEjzgZgcGCD/ENu655Xlho
         guPEVzhcP8rQW5xjVfiR7Q3hbNNJr5d609Cpv6nelj+P0jsLKrcn226JXPXFuONRVHlI
         YjECmO6YmqhBtAkLweNli68sSbbKJp0jfWeNMziFXok8xPH1K/auqCIhHIhVH/b7z4L8
         0cKXYgabL2rhuBVSFnV1FAqCUd8epBWGFV6EPt771S4WpZ17clVF2YHolzUSyq2BsU0z
         bz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wbz5MHgrotvmvS234Ul0ZoF8Ky6iZRkQglERKXzkxJE=;
        fh=1dGEKwauSfvAR91bnD1nqbspSR5FkVwnP8eLCtxW1MY=;
        b=aP5IivWMwx31C9OgtF/4zcjQgO9s3NOeR6IwPYsUa4hMSERjq1uArr8+9hcBTsXQf2
         myYxTj6afPjyVqejGunHT7qpk6T4FwimcVMD4RbkVJ6Hl3fahEEDC701P8nG0FyObjSx
         RCu8hY9B5u3rWqXOPp5jfibbqF1yf/+1pFOKyiqxnOOQ+Qvi6euC5jdgLxJNYNplgbff
         JRJX9clcuCLGZ5YC0uV7bL6scOReg/wYoGj+8/g/GJX2nlPpBrQQTSNZpJIznna2NmM8
         tiuItFJlm43I75XCgBCT0xdrNSQ1jU86n0ENMzGxZnpjIHM/1FAP/C7nP6bs2/KY4dWv
         EJ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795537878; x=1796142678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wbz5MHgrotvmvS234Ul0ZoF8Ky6iZRkQglERKXzkxJE=;
        b=SKjkz+CSzFRatCJksOBZLL5X8iAEw4K1PEcqG7GdnHn3UfMBMB/pp40SO5lXbb9bTI
         iOQKjt5Y5ow9gEaCxIR03T9pOiOOfa3KudQZKL/I6yEVMe+shu3/B22UDgySUo5qkr1h
         RIFEadNvw7/+m3Gr52BBYsOVcTEYNVFWCOQPwYb0kVXWlj5Inbjz3DYk2FEObyuLPDKv
         NdXNoPe9w437/Q5LbLP20o0OHthU5JAnm7t1DcaeaQK5sfGGyHP9771+mnSasCbRDOvW
         qUAb8nI3rFPDoP4jnhRJWNo7RYvxA7ywFqd48mUOCwJbBTqf/SyBk8aNCHekWNisCMEp
         ELqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537878; x=1796142678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wbz5MHgrotvmvS234Ul0ZoF8Ky6iZRkQglERKXzkxJE=;
        b=WulYzGczJAzPfaOga/jHBwixMAGgg0W01fX7k0LLC3d6452p1TbMOhxXpCPE7AsBOT
         Wldb5CWdDGg0AWZ3mDI+ZVf22JItPrys5icE5AXX5ZqkyO7b1x1HtO++iBrDEUiCd25A
         alZsKOxjQRfXg9ipKxiC7UD/tyPzU+20M67PYddJrUg/ZCwGF3yDIwbH9z92Lz8cgGtd
         iIwU2votNphN2jvuguAfT9Nwfk9qSuJ8z+oQ7fZiCvVuHzBOdQqtWSquabo3OKuZGEYO
         I0TxgOKY/yQHUr9ZG9Z0xm9p0ad/fNIf45voBWKsjwpu/aiodeFxg8jAiUCBjriobL4j
         F1gQ==
X-Forwarded-Encrypted: i=1; AL+hErG3CQ1EnOs/zSAp0G3u6+Up9vQhdhHcyzR1DtfdEQU5o7is9cWhSZb5Bc3qwFoFrezTOlJlkTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vXhAwhTP/Yau6IaydaOZAdxXCSCrht7VxA2X0rY/WBszjzpCR
	o+mVJ5EQ8VJgruMlunIzhp/z0hWneUgYyqryTtzahSMWeU9YuDBNXsqH+TxmnXX6d0xizu7EvAx
	vtVHBNBWxq2Cg2J+1nm6bYMfNE95qROzck5lf174=
X-Gm-Gg: AZFdTZe84RH/wZv6qB7PN4eitF2VEO+AxyTDTLWW9VymOTAmVfKyq9YNYJ8R7+c4JBZ
	pLTDxK7kLiLIS021sPxOirEFDssjpFjwUzY6zypg5xttAsIhSY7Tx5c8Shwp8T0Dut7+RqKC8iP
	IbDy6xg0ucvYIbpnSG7O4TGKPMvfUTd2XctVJ1iFBcSL5Iwt2o/kaZcCTWuI0p5iTtCotTrb6y6
	JAIodjrv6idyk7mqHCN+Tp4ClZ7cn3VZpyr11yzwQrq6dlC32DP68Psn++qo/b9ypjfBJ4ayT7t
	4wnsjk2Dghe6rKBX2hSrnJgxWjfd1978iusgm658J7yX8VQ5boX7dIuG2tkeL5QpsYAK2jEyhkf
	IaL6OC96rZHPaE7vXQZ5gT4VaLe3M149UoeF/SmL/4SEPpMvnMgu6MVrTcithgepZpljbSEmCXi
	Tm/FmGqCzVbqpTwsDh/EgpPudTChXS1Xpz0DbFKAz9zx/gEwFG6qcGCDG+8Un1h/wSpE6/cN5Cv
	F08QHsCvotRlmWmfiPZ5Ya837w87g==
X-Received: by 2002:a05:6102:f11:b0:7d0:6cf3:d8f0 with SMTP id
 ada2fe7eead31-7d7393ff876mr9420859137.18.1795537876719; Tue, 24 Nov 2026
 08:31:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-submit-mtd-partition-publication-v1-v2-1-8098cde01961@gmail.com>
 <87bj7ettng.fsf@bootlin.com>
In-Reply-To: <87bj7ettng.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 24 Nov 2026 09:31:05 -0700
X-Gm-Features: Aa3M54okleW4Lj0RRelpnmYTI5rOyLuDyszpkPnhLAOeuLzYyHg1VmfHbZ2XORk
Message-ID: <CADvTj4qup+jzmE++MiDEXfwEUcAMXDrsaM3+T+qX_Yoa+==W4Q@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: serialize dynamic partition registration with removal
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 3:23=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> On 20/11/2026 at 09:02:06 -07, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > If a flash driver is unbound while userspace adds a partition, removal
> > can find the new partition before it is registered or release it before
> > its sysfs attributes are added. If removal finishes first, the ioctl ca=
n
> > even register a new partition on a master that has been unregistered.
> >
> > Hold partitions_lock from the start of partition allocation until the
> > device and its attributes are registered. Mark the master as being
> > unregistered under the same lock so a later ioctl fails before allocati=
on
> > can read bad-block markers. Clear the flag when registering the master.
> >
> > Fixes: 5daa7b21496a ("mtd: prepare partition add and del functions for =
ioctl requests")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes in v2:
> > - Use mutex guards to keep publication and teardown lock scopes explici=
t.
> > - Link to v1: https://patch.msgid.link/20261108-submit-mtd-partition-pu=
blication-v1-v1-1-cbff20b1351e@gmail.com
> > ---
> >  drivers/mtd/mtdcore.c   | 4 ++++
> >  drivers/mtd/mtdpart.c   | 9 ++++-----
> >  include/linux/mtd/mtd.h | 2 ++
> >  3 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index b170c3144ca8..5ee1eb29fc1a 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -918,6 +918,7 @@ static void mtd_set_dev_defaults(struct mtd_info *m=
td)
> >       INIT_LIST_HEAD(&mtd->partitions);
> >       mutex_init(&mtd->master.partitions_lock);
> >       mutex_init(&mtd->master.chrdev_lock);
> > +     mtd->master.unregistering =3D false;
>
> Maybe this is worth a WRITE_ONCE() to tell robots that there is no
> possible conflict on this access?

This initializes the flag alongside the two mutexes, before the master
is published. A plain store should be enough here. After publication,
the add and unregister paths access the flag under the same mutex.

>
> >  }
> >
> >  static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
> > @@ -1206,6 +1207,9 @@ int mtd_device_unregister(struct mtd_info *master=
)
> >  {
> >       int err;
> >
> > +     scoped_guard(mutex, &master->master.partitions_lock)
> > +             master->master.unregistering =3D true;
> > +
>
> Actually I'm not sure my proposal actually fits. It does not make the
> logic clearer. At least not implemented like that (and below).
>
> >       if (master->_reboot) {
> >               unregister_reboot_notifier(&master->reboot_notifier);
> >               memset(&master->reboot_notifier, 0, sizeof(master->reboot=
_notifier));
> > diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> > index ddded0dbe77e..b20fa4309084 100644
> > --- a/drivers/mtd/mtdpart.c
> > +++ b/drivers/mtd/mtdpart.c
> > @@ -278,13 +278,15 @@ int mtd_add_partition(struct mtd_info *parent, co=
nst char *name,
> >       part.size =3D length;
> >       part.offset =3D offset;
> >
> > +     guard(mutex)(&master->master.partitions_lock);
> > +     if (master->master.unregistering)
> > +             return -ENODEV;
> > +
> >       child =3D allocate_partition(parent, &part, -1, offset);
> >       if (IS_ERR(child))
> >               return PTR_ERR(child);
> >
> > -     mutex_lock(&master->master.partitions_lock);
> >       list_add_tail(&child->part.node, &parent->partitions);
> > -     mutex_unlock(&master->master.partitions_lock);
>
> That mutex becomes super wide. I'm not a super big fan of it. Isn't
> there a possibility of deadlock with the notifiers or any other lock
> inside? Would there an alternative?

I haven't found a specific deadlock, but v2 does call the MTD add
notifiers with both partitions_lock and mtd_table_mutex held.

Could we use the lock that already covers BLKPG instead? Both the
native and compat ioctls hold the master's chrdev_lock until the add
returns. Unregister could take that lock to set the flag and release
it before starting teardown. If the add gets there first, it finishes
setting up the child's sysfs files before removal starts. If unregister
gets there first, the add returns -ENODEV before scanning for bad blocks.

That keeps partitions_lock out of the add notifiers. The exported
helpers would need the same protection for direct callers, without
taking chrdev_lock twice from BLKPG. One tradeoff is that unregister
would also wait for unrelated ioctls on that master, so the lock order
on the unregister side would still need checking.

>
> >
> >       ret =3D add_mtd_device(child);
> >       if (ret)
>
> In case of failure, should we clear the boolean?

Not when add_mtd_device(child) fails. Only master removal sets the
flag; a failed add just removes its list entry and frees the child.
If master removal itself fails, some partitions or OTP providers may
already be gone, so it wouldn't be safe to allow new adds again.

>
> > @@ -295,10 +297,7 @@ int mtd_add_partition(struct mtd_info *parent, con=
st char *name,
> >       return 0;
> >
> >  err_remove_part:
> > -     mutex_lock(&master->master.partitions_lock);
> >       list_del(&child->part.node);
> > -     mutex_unlock(&master->master.partitions_lock);
> > -
>
> I think there is a rule where we should not use those guards with goto
> statements.

Using explicit lock/unlock for the list updates would let us keep the
existing error label without mixing the two cleanup styles.

>
> >       free_partition(child);
> >
> >       return ret;
> > diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> > index 8d10d9d2e830..cd7b4671c456 100644
> > --- a/include/linux/mtd/mtd.h
> > +++ b/include/linux/mtd/mtd.h
> > @@ -224,6 +224,7 @@ struct mtd_part {
> >   *                not only the master partition list, but also all
> >   *                sub-partitions.
> >   * @suspended: set to 1 when the device is suspended, 0 otherwise
> > + * @unregistering: removal has started; protected by partitions_lock
> >   *
> >   * This struct is embedded in mtd_info and contains master-specific
> >   * properties/fields. The master is the root MTD device from the MTD p=
artition
> > @@ -233,6 +234,7 @@ struct mtd_master {
> >       struct mutex partitions_lock;
> >       struct mutex chrdev_lock;
> >       unsigned int suspended : 1;
> > +     bool unregistering;
>
> Maybe unsigned int xxx : 1 to be consistent?

The adjacent suspended bit is changed by mtd_suspend() and mtd_resume()
without taking the same mutex. With adjacent bitfields, setting one can
write back the byte containing both. A separate bool avoids that.

>
> >  };
> >
> >  struct mtd_info {
> >
> > ---
> > base-commit: 14b6830335eb6d70dec7a235094d66c22d38eb07
> > base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git =
mtd/fixes
> > change-id: 20261108-submit-mtd-partition-publication-v1-4629be94d7e6
> >
> > Best regards,
>
> Miqu=C3=A8l
