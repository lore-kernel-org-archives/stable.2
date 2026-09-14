Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1894416842;
	Mon, 14 Sep 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380362; cv=none; b=OU1zLJTrqnZeL5rw0VrU0MbvAwghqIwz4BdL9hjBD/+JjPt438c1sTN/CZo7EdAAxFfqEpS6hrOxGB6H+reykTyH8ZYQpAcspS7fGdPBc12QJ0gk/+V1UbBkSmYYUMoRQJ5/O8eaW8SzHhAgV7d77a+VL9uRb1bvaBgyoKis83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380362; c=relaxed/simple;
	bh=DMDWCM6JoxGA89eSSsTk0/dEK4XIGdWdYKOGMSUf3xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyDCMUiGZcXRMvb1dgVExsOa+FDqeIZjyXOo5EMPhysd+7748k9ZhMAu85izBzbwPIhVWH7DsvW4pvJYTDM+JqMaZpoqz4G0A4/QLBXRwtzQ8dVJHNmr91alJZdk/tqQyupTJpPTv1G6BT+pyqu7IGIAoaayyfkTgCh/YWHPN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PvQLSmgO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PvQLSmgO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Z1v1PVkhwXuhzUjiuSH7T4iPyc1/sQhU/UPzOLJk74=; b=PvQLSmgOBF9dhBHwMD2xbtUD3Y
	Cs9pSVNzuo7MSooTy6u9tPv6tci36hXzmq7swIY0Ldor9CxztjJCDRgchFhx72AKoEIKcqgEF72IP
	yx1AM3BFSJWEMQSMWwN+bCniWlsX57BoPbEqA/FQRKNFtDIb4CoIKfecshSxRckjfxbOECFgabS//
	tonhKq9Pku0zhuxtiqk/DyAWu7v5sKyhWy5UkIqY6cKk1TPhLG/JdR3C+7CtHHZc4+RsVoheCPaw5
	+kJ730D/cD+bzMP6ecnN9La+kQ9IR4dOH835haXkDHlEQXEk/fh1I9U6d1P5FS1rI9n4cEvsm9yKb
	vE0XT3Nw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x63Z5-003XSJ-2e;
	Mon, 14 Sep 2026 10:05:32 +0000
Date: Mon, 14 Sep 2026 03:05:26 -0700
From: Breno Leitao <leitao@debian.org>
To: pavankumaryalagada@gmail.com
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] configfs: fix NULL dereference in
 configfs_depend_item_unlocked()
Message-ID: <aqfGt6OFIRuqMC6H@gmail.com>
References: <20260914094426.25595-1-pavankumaryalagada@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914094426.25595-1-pavankumaryalagada@gmail.com>
X-Debian-User: leitao

On Mon, Sep 14, 2026 at 03:14:26PM +0530, pavankumaryalagada@gmail.com wrote:
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> 
> configfs_depend_item_unlocked() can dereference a NULL parent when
> the configfs item is still being created.
> 
> The item can be found before it is linked to its parent group,
> so ci_group can still be NULL. Check ci_group before using it
> and return -ENOENT if it is NULL.

The crash itself looks real, but this reads like a fix in the wrong
place.  include/linux/configfs.h already documents the opposite
contract for this API:

 /*
  * These functions can sleep and can alloc with GFP_KERNEL
  * NOTE: These should be called only underneath configfs callbacks.
  * NOTE: First parameter is a caller's subsystem, not target's.
  * WARNING: These cannot be called on newly created item
  *        (in make_group()/make_item() callback)
  */
 int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
                                   struct config_item *target);

"cannot be called on newly created item" is exactly the case being
patched here. 

If configfs is now going to accept a not-yet-linked item and return
-ENOENT for it, shouldn't that comment be updated in the same patch?

And if the contract is meant to stand, shouldn't the caller stop handing
over an unlinked item instead?

> Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")

This tag and the diff do not agree.  4bb8548df632 only touches
Documentation/ABI, drivers/usb/gadget/Kconfig and
drivers/usb/gadget/function/f_tcm.c; it does not add or modify anything
under fs/configfs.

--breno
