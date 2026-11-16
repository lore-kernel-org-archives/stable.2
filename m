Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808710;
	b=i9FQN4lNgu1veAOPxTXj47p1wWM51XolWcColRQeELXQbkraHJCHcgO7119Dwo6dVH9L
	 uuki+vxxG9EuATgewTDY3jEvbvODeqVlvZivqYVC38qj5PfUW+II/pMHnde3KoyNKLFaw
	 DZxOUzDa4Aq76jOA0G2DKgM30bk4esGU95NCD2KEi3kjNswz+HAsomaH7znwQyh65Kvrl
	 MRytD6SbCWiCBYhPNPC3tkX4UypuyF7IysHChMpGPLFtWMbqI7Oh54viZ71edWksYl4tq
	 UeQLK1Gfw3vnn9Sah65KOUePxdALP8kmYmK+c12bGrDtcHFVP32WhdFDYaqdU+s7q4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808710;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Qtjxe/UkLfMtfJgLawV+AiEqNNAopf39+TFUQLWRVLY=;
	b=ozKOFvdxJa3aNhHv+n3gDCjVCRqjx3fuNC+Gx1iPauZ9knMZvUBng7gl/B/bWxFTsSb5
	 5InEGEfRWpCxAH64+L7fC9xoaCIdMfvatxfmdmKJHLJNfvdush5gdAnixF1ETilNKB3G1
	 r3gO4aO/N1HTfZiZ7OazXFuXfyRFAP9yfculQssHR2e4BSGPU4SM9e1nPi+D3Ta6X44yc
	 N1LolfCk1Yk0CKT+4OT19kfZKRseSaLsb16tLKQou+upaY8T1u9p1iIiZZ7H0IGlR3qvV
	 bcQdueSWeEO7qx1puqljPnKWEiMrTXM7BYVDwL8kZgj6tKLjY1NT0Sog3kjokO2m06Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkRIot3E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125A606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkRIot3E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4A71F000CB
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808710;
	bh=Qtjxe/UkLfMtfJgLawV+AiEqNNAopf39+TFUQLWRVLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NkRIot3E/qWwu1CwaGVWtl8JrHrQEzwk73mAjwkGenfeXOeLlAkS4uJkFbojGWqBS
	 tnysZQBg7zogpJCz+vWbFtmXYS1R6HekG6vyke7+nI2F0ve5j0QooBv22/039TVoWQ
	 3A93oSmtM8SJCrrHGYSWfFPRMqWIITpyA6ZT1nkaj0lnKhXOHaoJDHHfzFglbbfVuo
	 m+IqdJ7ZjVmZiWBIfY4y6o62zDVeTKojcpdaSIJTApxBB2f3q2a8/jFOalPA5Iwf9m
	 lrZpAUzGZPkhFe0lKdnE/7FYvPeNO1tzVL4pHRAgD4aLK3qgH/7lXIqKnE9+OpnDo4
	 UExrJ35QRXK8A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso6907891a12.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:58:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEno6WhplOYxWR+0j9uoB3pPPPmv9cgPezur3wuNrGjKyJhdIRuyFXWus95HebCKj4Q6v4R0OM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IN8J/c3JeyKNXSxw6B0xRscnYHvvbrZwX5KN1KkiUTWLRJTO/
	hTSIerU7iSbfXI+64HEJRfmmSjK6+fly0vRJp+23SYnS+ErVAFK5bH/3BQTFeqAoQ92NHuHRw2i
	lqRH30WDzUXUwDZZE7q2I1UQDHeJc1ds=
X-Received: by 2002:a05:6402:438f:b0:6b5:5ee4:c9d8 with SMTP id
 4fb4d7f45d1cf-6b7c0c8232bmr7182338a12.32.1794808709070; Sun, 15 Nov 2026
 21:58:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
In-Reply-To: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 15 Nov 2026 21:58:17 -0800
X-Gmail-Original-Message-ID: <CACRMN=fuqk67Z+OSEhTUnFK-owMyU7iV-Fk=AQexpnz4_mqR9A@mail.gmail.com>
X-Gm-Features: AclHuK-zpUdb2F46bithlUxQxaDMREUiER_9wRVuxeroYiWCzxmoBbULZP0FN9w
Message-ID: <CACRMN=fuqk67Z+OSEhTUnFK-owMyU7iV-Fk=AQexpnz4_mqR9A@mail.gmail.com>
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared fwnode
 owner is rejected
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'd like to reject this patch. More details below.

On Mon, Sep 28, 2026 at 4:51=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> When multiple devices share the same fwnode (e.g. the SCMI bus creates
> both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
> the first device registered becomes the fwnode owner (fwnode->dev, set in
> device_add()). If that owner never binds -- for example its driver return=
s
> -ENODEV because it is blocklisted on this SoC,

If it's blocklisted, why is the driver registering itself to match
that device? Register a different match list during driver
registration if you realize you are running on a particular SoC?
Saying your driver supports a device and then not probing it when
requested is not right. Honestly, this is the simplest fix.

> or because its driver is
> not compiled in at all -- then driver_bound() is never called for it, so
> fwnode_links_purge_suppliers() and fw_devlink_pickup_dangling_consumers()
> are never run for the fwnode. The child fwnode supplier links (pin group
> nodes such as lpi2c3grp, uart5grp, ...) stay unsatisfied and every
> consumer of those child nodes defers probe forever.

For the not compiled in part, after a timeout, fw_devlink unblocks all
probes. You can even set it to a very small number using
CONFIG_DRIVER_DEFERRED_PROBE_TIMEOUT too. So it should never block for
the scenario of the driver not being compiled in or ever loaded.

> On i.MX95 this manifests as a complete boot failure: the generic "pinctrl=
"
> SCMI device claims fwnode ownership but its driver returns -ENODEV, while
> the vendor "pinctrl-imx" device binds successfully. Because
> dev->fwnode->dev still points at the rejected "pinctrl" device,
> driver_bound() of "pinctrl-imx" skips the supplier purge and dangling
> consumer pickup, so all I2C buses, SPI, UART, MMC, USB and PCIe
> controllers wait forever for their pinctrl suppliers.
>
> Fix this in two places:
>
> 1. In really_probe() failure path: when the driver definitively rejects
>    a device (-ENODEV / -ENXIO),

This is just arbitrary. Why not do this for all the error returns
other than -EPROBE_DEFER and -ENOMEM? This might work for your case,
but I don't think you can make a sweeping call for all drivers.

> fw_devlink_release_shared_fwnode() is
>    called. If the rejected device is the fwnode owner, it either
>    transfers ownership to an already-bound sibling (and runs the
>    purge/pickup on its behalf) or clears ownership so the next sibling
>    to bind can re-acquire it.
>
> 2. In device_links_driver_bound(): re-acquire the fwnode when it is
>    unowned (!fwnode->dev) or when the current owner has no driver at
>    all (!fwnode->dev->driver, meaning the driver was never compiled in
>    or loaded as a module). This covers the case where probe rejection
>    never happens because no driver ever matches.
>
> fwnode->dev is not serialized by a lock; instead every writer only ever
> touches a fwnode->dev it already owns (=3D=3D dev, as device_del() does w=
hen
> it clears ownership) or one that is currently unowned (=3D=3D NULL, as
> device_add() does when it claims ownership). This patch follows the same
> discipline: fw_devlink_release_shared_fwnode() only writes fwnode->dev
> when this device is the current owner; device_links_driver_bound() only
> claims fwnode->dev when it is NULL or when the current owner has no
> driver (and therefore cannot be in the process of binding).
>
> Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> This issue is triggered by
> aac4e67d6eb9 ("firmware: arm_scmi: Always create devices for standard pro=
tocols")
> in linux-next next-20260925.
>
> But I think this is a fix to
> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>
> Detailed information could be found in patch commit log.
> ---
>  drivers/base/base.h |  1 +
>  drivers/base/core.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/base/dd.c   |  9 ++++++++
>  3 files changed, 73 insertions(+)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff0..36d34aa328c5 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -292,6 +292,7 @@ void device_links_unbind_consumers(struct device *dev=
);
>  bool device_link_flag_is_sync_state_only(u32 flags);
>  void fw_devlink_drivers_done(void);
>  void fw_devlink_probing_done(void);
> +void fw_devlink_release_shared_fwnode(struct device *dev);
>
>  #define dev_for_each_link_to_supplier(__link, __dev)   \
>         list_for_each_entry_srcu(__link, &(__dev)->links.suppliers, c_nod=
e, \
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5daa88fa724a..e76153d5f124 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1376,6 +1376,20 @@ void device_links_driver_bound(struct device *dev)
>         struct device_link *link, *ln;
>         LIST_HEAD(sync_list);
>
> +       /*
> +        * Multiple devices may share the same fwnode (e.g. the SCMI bus
> +        * creates several devices per protocol node).  The first one
> +        * registered owns the fwnode; if that owner's driver is rejected
> +        * it relinquishes ownership (fwnode->dev =3D=3D NULL, see
> +        * fw_devlink_release_shared_fwnode()).  If the owning device has
> +        * no driver at all (driver never compiled / loaded as module), i=
t
> +        * will never bind, so it is safe to take over.  Re-acquire the
> +        * fwnode here so the purge/pickup still happens.
> +        */
> +       if (dev->fwnode && (!dev->fwnode->dev ||
> +           (dev->fwnode->dev !=3D dev && !dev->fwnode->dev->driver)))
> +               dev->fwnode->dev =3D dev;
> +
>         /*
>          * If a device binds successfully, it's expected to have created =
all
>          * the device links it needs to or make new device links as it ne=
eds
> @@ -1390,6 +1404,7 @@ void device_links_driver_bound(struct device *dev)
>          * consumers to defer probe indefinitely waiting for a device for=
 the
>          * child firmware node.
>          */
> +

Did you add a blank line for no reason? Or am I missing something?

>         if (dev->fwnode && dev->fwnode->dev =3D=3D dev) {
>                 fwnode_links_purge_suppliers(dev->fwnode);
>                 fw_devlink_pickup_dangling_consumers(dev);
> @@ -1474,6 +1489,54 @@ void device_links_driver_bound(struct device *dev)
>         device_links_flush_sync_list(&sync_list, dev);
>  }
>
> +static int fwnode_shared_bound_match(struct device *dev, const void *dat=
a)
> +{
> +       const struct device *rejected =3D data;
> +
> +       return dev !=3D rejected && dev->fwnode =3D=3D rejected->fwnode &=
&
> +              device_is_bound(dev);
> +}
> +
> +/**
> + * fw_devlink_release_shared_fwnode - Hand off a shared fwnode on probe =
reject.
> + * @dev: Device whose driver just definitively rejected it (-ENODEV/-ENX=
IO).
> + *
> + * Several devices can share one fwnode (e.g. the SCMI bus creates both =
a
> + * "pinctrl" and a "pinctrl-imx" device for one protocol node). Only the=
 first
> + * one registered owns the fwnode (fwnode->dev). If that owner's driver =
rejects
> + * the device, driver_bound() never runs for it, so the dangling consume=
rs of
> + * the fwnode's child nodes are never picked up and defer probe forever.
> + *
> + * When the rejected device is the fwnode owner, relinquish ownership so=
 those
> + * consumers can be resolved by a sibling that does bind:
> + *
> + *  - If a sibling has already bound, transfer ownership to it and run t=
he
> + *    purge/pickup the owner could not do.
> + *  - Otherwise clear ownership so the next sibling to bind re-acquires =
it in
> + *    device_links_driver_bound() and runs the purge/pickup there.
> + *
> + * fwnode->dev is not lock-serialized; this only ever writes it when @de=
v is
> + * the current owner (fwnode->dev =3D=3D dev), the same ownership-gated =
rule
> + * device_del() uses when it clears fwnode->dev on the owner.
> + */
> +void fw_devlink_release_shared_fwnode(struct device *dev)
> +{
> +       struct device *sibling;
> +
> +       if (!dev->fwnode || dev->fwnode->dev !=3D dev)
> +               return;
> +
> +       sibling =3D bus_find_device(dev->bus, NULL, dev, fwnode_shared_bo=
und_match);
> +       if (sibling) {
> +               dev->fwnode->dev =3D sibling;
> +               fwnode_links_purge_suppliers(dev->fwnode);
> +               fw_devlink_pickup_dangling_consumers(sibling);
> +               put_device(sibling);
> +       } else {
> +               dev->fwnode->dev =3D NULL;
> +       }

This is not even correct. If you don't have a sibling that's bound,
you are just clearing the fwnode->dev and leaving a bunch of device
links stuck to the old device. And in the case there is a sibling
device, you are assuming all the consumers are only pointing to the
child devices. If a consumer was pointing to this device, then you are
just deleting the device link and not moving it to the sibling.

This patch is just a hodge podge of ideas that happen to fix it for
the imx case, but not really a sound/principled design.

This patch also makes a lot of assumptions that I'm not comfortable
with. Please try the simpler fix I suggested above. Essentially, edit
drivers/pinctrl/pinctrl-scmi.c so it doesn't always register the
driver. Register it only if it's not one of those blocked machines.

If we really want a systemic solution to the "two device point to one
fwnode" problem, then we have a couple of options:

1. Have the bus code that's adding the two devices to make one of them
to be ignored for fw_devlink.
2. For any fwnode with multiple devices, give up enforcing fw_devlink
for that node and all its descendants.
3. Have the bus code that's adding the two devices to go through all
the fwnode_links and mark which link is for which device.

(1) is simplest and an opt-in.
(2) will affect a lot of current cases where the first added device is
the right one and has no problem (eg: PCI)
(3) will work well if the bus can actually tell the devices and their
consumers apart, but will also increase the memory usage a bit (need
to store a dev pointer or cookie for every fwnode link)

Neither of these are great options, but they are better than some
partial heuristics that can't be easily applied for all systems and
depend on timing.

-Saravana

> +}
> +
>  /**
>   * __device_links_no_driver - Update links of a device without a driver.
>   * @dev: Device without a drvier.
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f6525a7ee8c5..e19cfc91ebe1 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -762,6 +762,15 @@ static int really_probe(struct device *dev, const st=
ruct device_driver *drv)
>  dev_groups_failed:
>         device_remove(dev);
>  probe_failed:
> +       /*
> +        * -ENODEV/-ENXIO mean the driver definitively rejected this devi=
ce
> +        * (errors are returned as positive values at this label). If it =
owns a
> +        * fwnode shared with sibling devices (e.g. SCMI creates several =
devices
> +        * per protocol node), hand the fwnode off so its dangling child
> +        * consumers can be resolved by a sibling instead of deferring fo=
rever.
> +        */
> +       if (ret =3D=3D ENODEV || ret =3D=3D ENXIO)
> +               fw_devlink_release_shared_fwnode(dev);
>         driver_sysfs_remove(dev);
>  sysfs_failed:
>         bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
>
> ---
> base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
> change-id: 20260928-driver-core-f1d9e991edb2
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
