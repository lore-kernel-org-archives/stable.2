Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178679;
	b=gGC7ax3ESi0jmIoDEGEPqJL/m8iAX8IvjCSevgdVPLM1LCkEd7YGmvyuP6FUtKVAgtpd
	 4b0+2XdeMQJlswR2xoxgfnws9o1S6Xtu5yc12l/5+hjrkRTDOgf/09iwYGqh0JkXR1lvY
	 OYajIfIYXUnHHjBtPe8q8R+qhqSNu/UjJzzpsnPFMtHvRIMAhZegCOPASKSS7AE8v9sbw
	 s2lfckZ3m5Whx3HoMbfRzZ0yKqB4UO/DUkmZES5did7TuazeC7W/o2N7lkDgCTOug7ELs
	 QML5eQunqN1uawyeBcMVTHWYkc8RAM9zYArvLBdDuuxX6Z9RSbwDPi7XeoggcADtX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178679;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lKxPVxJVXhL/lYpTx5d+L4gCfK2VqMevUG3BAil73d8=;
	b=SJ23IlAEa1Z4fXl2V3JEeX4F3HxiiUiyOK4Fb+tkdPiEFz48IRz0+4Eb7HpF0pgawzbU
	 0goUdmopcTU0S3TsQcY7D19BCw7vgfvQY52WwA5lBNWJJ28b3/wYqKA3YgiGokEAYDUub
	 9YMAeqCxnKUo6xOZMAMu8v7PrDAVMRvYuPxa/k9d+X0bTOK6pZ5NOy0CUm3NM7uCyynYU
	 EN8hvqVKM0gsGi8lvSQH0/amu82aQgQe73npM4cK2SicwH/5guFkO/49AFrp7UuujIz+x
	 /CWXL4j2JRUIvYhXREfx/2fH84OzFXamGdgDbda1GtENn0AhNsF+snqHcHWRrpGxqnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Noi4HUTu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E4606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Noi4HUTu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB08E1F000D3
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795178678;
	bh=lKxPVxJVXhL/lYpTx5d+L4gCfK2VqMevUG3BAil73d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Noi4HUTuGceZrJTXd9KA5l0ldJL1p13IKEWC6B5JYNRABMnCpPV2QH9loKxyPIXYX
	 7PdY9dVg4Hox9CGVFg0UtMPEcd773s+x9IY4YRPJLVgCpwGj7F/Olift8UfzDDBw+V
	 EBGODhj7fLvH3HFcqRlmnzdxQdf5ptjngGbRhEfb4Cpl1TTObF9KiIxHlqxipE3QZp
	 A2x1m0p4bPlagvG/h68wezIj6ajYJ0XEU8mXSuUV6z6SoESeGKdjwNMqHmYrTxYm+U
	 yCaX55Nvg4NCMuha1HzEETPBPXHm4T/uss+cqbDoH+rhdcX5jc5+TGxh3TilfPt1w4
	 1dhcC4SfwtvnA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c07c7306e1so680052e87.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:44:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHusZ1b09406xAPVzR+o9MDsK5zqU4ZQRwclz9IMxXTfx6ocBSUtptGhabepjw3dGjiuvt14gg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0aHV6BWMNosaaWZsBUh9rbwfdDsWPzga9DnbGAy8GGoiXk72s
	ps2dY4CEqT3IoY2a1CxthYDSxhTm/nzFaqIlBlXAqpBasTSmi0eGxdB8D6oW+zBZIOyjVc3Dqgf
	FsVHtzrtOfK7kD3/kzJQz2jsCSSf0xHI=
X-Received: by 2002:a05:6512:4016:b0:5bf:b74b:3fb8 with SMTP id
 2adb3069b0e04-5c1bc7cef09mr948426e87.22.1795178677102; Fri, 20 Nov 2026
 04:44:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-swnode-kobject-parent-ref-v2-1-7ff8bd54e526@oss.qualcomm.com>
In-Reply-To: <20261119-swnode-kobject-parent-ref-v2-1-7ff8bd54e526@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 13:44:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iiOPT58GM=UDV=MdpPuoqFHCyrbWnw0yqejCrLjv+O9w@mail.gmail.com>
X-Gm-Features: Aa3M54o_QhL8zO_eForf2dkAOpDrGma4Hrml5U9FdJ-znDiMb679XmnSf-mNb7M
Message-ID: <CAJZ5v0iiOPT58GM=UDV=MdpPuoqFHCyrbWnw0yqejCrLjv+O9w@mail.gmail.com>
Subject: Re: [PATCH v2] software node: make swnodes hold their own references
 on parents
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 11:57=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> In swnode_register(), swnode->parent is assigned before calling
> kobject_init_and_add(), which normally acquires a reference on
> parent->kobj via kobject_add_internal() that is held until after
> software_node_release() completes. However, if kobject_init_and_add()
> fails before acquiring the parent reference or drops it on error in
> kobject_add_internal(), swnode->kobj holds no reference on parent->kobj
> while swnode->parent remains set.
>
> With CONFIG_DEBUG_KOBJECT_RELEASE enabled, the random delay in
> kobject_delayed_cleanup() may create a situation where - when
> unregistering the child node and then the parent - the parent object
> gets released before the child who's left with a dangling pointer.
>
> Acquire a refernce to the parent swnode when registering the child and
> drop it on child's release.
>
> Cc: stable@vger.kernel.org
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the fi=
rmware node framework")
> Closes: https://sashiko.dev/#/bug/linux-82933c14-d212-49f1-bd2f-d4ab1e16f=
ed7
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> Changes in v2:
> - Simplify the code by folding the swnode_put() call into the existing
>   conditional branch
> - Link to v1: https://patch.msgid.link/20261106-swnode-kobject-parent-ref=
-v1-1-77dbd7213dd0@oss.qualcomm.com
> ---
>  drivers/base/swnode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 65e9388af8651f9d9602ff82e1761e5870284f26..f7b53e966b183cec1bfba6535=
ccdba308b0be68e 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -850,6 +850,7 @@ static void software_node_release(struct kobject *kob=
j)
>         if (swnode->parent) {
>                 ida_free(&swnode->parent->child_ids, swnode->id);
>                 list_del(&swnode->entry);
> +               swnode_put(swnode->parent);
>         } else {
>                 ida_free(&swnode_root_ids, swnode->id);
>         }
> @@ -886,7 +887,7 @@ swnode_register(const struct software_node *node, str=
uct swnode *parent,
>
>         swnode->id =3D ret;
>         swnode->node =3D node;
> -       swnode->parent =3D parent;
> +       swnode->parent =3D parent ? swnode_get(parent) : NULL;
>         swnode->kobj.kset =3D swnode_kset;
>         fwnode_init(&swnode->fwnode, &software_node_ops);
>
>
> ---
> base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
> change-id: 20261106-swnode-kobject-parent-ref-3bd9b9b75aeb
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
>
