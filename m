Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE818871F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623608; cv=none; b=Htob4nrD3oStLrAB1uEr7/LMWLK7ruU91ZM4VIB6OKSmgNmUtndp/vfXa+Yj/r9brqGnSAPJpb1wCqcDQcvyczRcmFVytB49s7gN5++NW0vmrw6XdSGjbVHU/z3T17O2dCSlARixku2DM5gaskCiT4g3qwlXH1vCCIUYeQzDGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623608; c=relaxed/simple;
	bh=m6XdPBYYpxn2mAEPLfpViEKVQhRDQgfCatUfMIvur6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHUOWvgOsX00d98sae2WoMuocUn1GZpThMf3DqQ9pjEK4TAyRlB8iPNvcpePH3v5q5Zs55b3ktHjNuRq087NHIAi8dO0j6bkPZUoHP4WaXwFdTTX0S3KETr+Cn2YrPnknEWnuUUn8nbESUK2cJbbCVlpNIb8nK1fwdPe8N2TaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=uYrDGRGi; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="uYrDGRGi"
Received: by dvalin.narfation.org (Postfix) id 9FD1D1FF0E;
	Tue, 21 Jul 2026 08:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784623604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPW9moFv142WsZjbbFkfPFjCMwXkpF80bmuAk3xsVfw=;
	b=uYrDGRGiEz26s4QY3zyn/+cniELWUmcDJ5ZajuqAzXlaxS8hkhtX4mlnVCuDp3ej6w0tNR
	R7kuuVsuNKeMDnIJr5/ttvC/ONjYurWs7Fl1bJeeEDNiI6DbBe4XPZk5zzTvuZ4D4UM3fs
	vRchHo85Jws/4KqtAJhEpmx4j8N6vUE=
From: Sven Eckelmann <sven@narfation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject:
 Re: [PATCH 5.10.y] batman-adv: clean untagged VLAN on netdev registration
 failure
Date: Tue, 21 Jul 2026 10:46:40 +0200
Message-ID: <8752433.NyiUUSuA9g@sven-l14>
In-Reply-To: <20260720175500.0023-stable-reply@kernel.org>
References:
 <20260720134709.650871-1-sven@narfation.org>
 <20260720175500.0023-stable-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2067427.usQuhbGJ8B";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2067427.usQuhbGJ8B
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Date: Tue, 21 Jul 2026 10:46:40 +0200
Message-ID: <8752433.NyiUUSuA9g@sven-l14>
In-Reply-To: <20260720175500.0023-stable-reply@kernel.org>
MIME-Version: 1.0

On Tuesday, 21 July 2026 02:56:30 CEST Sasha Levin wrote:
> > The register_netdevice() call will try to clean up the net_device using
> > unregister_netdevice_queue() - which only uses the .priv_destructor to
> > free private resources. In this situation, .dellink will not be called.
> 
> On 5.10 this move regresses normal interface removal: 5.10 still has
> the legacy sysfs code, and batadv_softif_destroy_netlink() removes the
> mesh kobject via batadv_sysfs_del_meshif() before the untagged VLAN
> cleanup (now running from batadv_mesh_free()) gets to
> batadv_sysfs_del_vlan(), so every plain "ip link del" hits a kernfs
> WARN (a panic under panic_on_warn).

Correct, this is a situation which will now always be triggered when 
CONFIG_BATMAN_ADV_SYSFS is enabled (which wasn't enabled by me for ages - aka 
6 years).

Had to check the old code. With CONFIG_BATMAN_ADV_SYSFS enabled, the deletion 
of the VLAN must be done before batadv_sysfs_del_meshif(). But 
batadv_softif_destroy_netlink first does the batadv_sysfs_del_meshif and then 
calls unregister_netdevice_queue(). This is also the same for the 
batadv_softif_destroy_sysfs() which I forgot to modify in this backport.

> Could you send a v2 for 5.10 that keeps the untagged VLAN destroy in
> batadv_softif_destroy_netlink() and only adds the batadv_mesh_free()
> fallback for the registration-veto path?

And here comes the problem:

I don't know at the moment what is the best way to detect that 
batadv_mesh_free() was reached via the veto path and not through the normal 
cleanup. And if we call it here in the normal cleanup, it would cause a 
segfault in 

RIP: 0010:sysfs_remove_file_ns (fs/sysfs/file.c:470) 
 ? batadv_tt_local_remove (./arch/x86/include/asm/atomic.h:190 (discriminator 4) ./include/asm-generic/atomic-instrumented.h:221 (discriminator 4) ./include/linux/refcount.h:272 (discriminator 4) ./include/linux/refcount.h:315 (discriminator 4) ./include/linux/refcount.h:333 (discriminator 4) ./include/linux/kref.h:64 (discriminator 4) net/batman-adv/translation-table.c:254 (discriminator 4) net/batman-adv/translation-table.c:1440 (discriminator 4)) 
 batadv_sysfs_del_vlan (net/batman-adv/sysfs.c:930 (discriminator 1)) 
 ? batadv_softif_vlan_release (net/batman-adv/soft-interface.c:545) 
 batadv_softif_destroy_vlan (net/batman-adv/soft-interface.h:41 net/batman-adv/soft-interface.c:642) 
 batadv_mesh_free (./include/linux/instrumented.h:101 ./include/asm-generic/atomic-instrumented.h:220 ./include/linux/refcount.h:272 ./include/linux/refcount.h:315 ./include/linux/refcount.h:333 ./include/linux/kref.h:64 net/batman-adv/soft-interface.h:44 net/batman-adv/main.c:293) 
 batadv_softif_free (net/batman-adv/soft-interface.c:1045) 
 netdev_run_todo (net/core/dev.c:10346)


(depending on the order of batadv_softif_vlan_put)

As workaround, I can use a simple boolean flag in netdev_priv to signal that 
it is called from a normal softif_destroy function or not. Not that explicit 
but also possible would be a check for "(!dev->needs_free_netdev)". But this 
was just a little bit too obscure for me. I will post the v2 with the more
explicit flag in batadv_priv.

Otherwise I need to rewrite everything and handle both the untagged VLAN 
removal and the batadv_sysfs_del_meshif() from a NETDEV_UNREGISTER handler in 
batadv_hardif_event_softif().

Regards,
	Sven
--nextPart2067427.usQuhbGJ8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCal8x8AAKCRBND3cr0xT1
y0miAQD7pJZ+Ccozph9ovtpMdN1KR3UeGZPgz/vpajyvkPu63gEA++pZvKM76VOo
5d5Ls90LXNt9P3W6YvmA7BZLIbqG1wg=
=exWa
-----END PGP SIGNATURE-----

--nextPart2067427.usQuhbGJ8B--



