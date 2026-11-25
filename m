Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609414;
	b=t82+sCc9ToYiLuZo1Oh13whIQ7P/2ACSybkgseIjnMxnpQDShkhqboGdPSR882icaGLW
	 Fl1hrsywSiUeFKT2gNSjcBzqtH38Qx4QL+02nZf2nDDoeOMrdLuCfHa/XEDbZwF6Ui46O
	 HWHObh0ngZwZL54hV0hlrlj2qoFyIx9cV0VEIU7riTfruC9ONcPa7/yQkf1gh4blG7EFK
	 tAZ6CwSCjNuNPo05ZMtdImPfpIs3mrx+fhoNx/B7Hk2+3dAHaqNazkZ2iqsLBDEVqd9s+
	 odhVQ7sS92hMOKeHjXiVldTYPuPbKE5ydbXfahHTXgWQjr7zNVyIsUATugb7OtPB3fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609414;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3JcPl0u0zEmTMYTdUq4KTpzhdgRKbxbY1Uoa4zzd3fI=;
	b=3OibTOQY3mERxQIw9fVuI2xHuKfuoSBkXT/aJC147mq9KDIByl9pNybcBj9V4ed0r4/X
	 dM+vEUPmVH785+SiOWJSpJJKZoEM69AMx2gGwYjwu0/3aA4cSaI6SRx9ic1TMzPquZacO
	 wNbVhL6jomtCrUDaVNDx0w4cZ325o3mo3HRTGB1H1WqSCEqvtY9mHJOr8Sj3cW22POTLb
	 K53B0pd4g7xzBwiImgGVkg9EWBEqXehBrexpBOAA9Ux5caqIC5wCHV+3he8fJ7SlBeSTo
	 d7tsIbbOqtWHOaJI3J/qqkBpJ/fr3hWssEC5n2PsrKGTyciBy+dtHp/xGAxpvMfv6Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MWCNC3c7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A326606A31E;
	Wed, 25 Nov 2026 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MWCNC3c7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187CE1F000CF;
	Wed, 25 Nov 2026 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609413;
	bh=3JcPl0u0zEmTMYTdUq4KTpzhdgRKbxbY1Uoa4zzd3fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MWCNC3c7myMqGLFjmRL+vw46So9XVuf0vNTJrrSCbgGCHqk6VIEmsEEmN1RPmUZqc
	 jahHxQ/dHU+etQeQpyjBC0DS2jKyrTw8r2Z34epxOxm7tJ/tEmGVcYEFqGdbkDkThN
	 wb35FU/WtX2L6zWyKNyeMf05BtYI8Yuov5QdZU7I=
Date: Wed, 25 Nov 2026 13:12:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhu GuangLei <zhugl3@xiaopeng.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] misc/pvpanic: share the shutdown handler across
 devices
Message-ID: <2026112547-dayroom-proofing-0658@gregkh>
References: <20261125091520.173803-1-zhugl3@xiaopeng.com>
 <20261125115602.72420-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125115602.72420-1-zhugl3@xiaopeng.com>

On Wed, Nov 25, 2026 at 07:56:02PM +0800, Zhu GuangLei wrote:
> Each pvpanic device registers its own power-off handler at
> SYS_OFF_PRIO_LOW. register_sys_off_handler() accepts only one handler
> per non-default priority, so when a second pvpanic device is probed the
> registration fails with -EBUSY and the driver logs "Could not register
> sys_off_handler". The handler that did get registered notifies every
> device on the list, but it is owned by the first device. Once that
> device is unbound, or its shutdown event is masked through sysfs, the
> handler is unregistered and the remaining device stops reporting
> shutdowns even though its events mask still has PVPANIC_SHUTDOWN set.
> 
> Register a single handler for the driver and keep it as long as at
> least one device has the shutdown event enabled. Serialize updates of
> the events mask and of the handler registration with a mutex, and also
> update the mask under the list spinlock, which is the only lock taken
> by the panic and power-off paths.
> 
> The shutdown event only reaches pvpanic when no higher priority
> power-off handler, such as the ACPI one, turns the machine off first.
> Tested on a v6.18 based guest booted with acpi=off under QEMU 8.2.2
> (TCG) with two pvpanic-pci devices created with events=7: after
> unbinding the first device, or masking its shutdown event through
> sysfs, and powering off, QEMU did not receive the shutdown byte (0x4)
> without this change and does receive it with it.
> Masking the shutdown event on a single device still suppresses the
> write.
> 
> OpenAI Codex was used to write the code change and the QEMU test
> scripts, and to run the tests. GitHub Copilot was used to review the
> change, to rewrite this changelog and to prepare v2.
> 
> Fixes: 7b51b1373321 ("misc/pvpanic: add support for normal shutdowns")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhu GuangLei <zhugl3@xiaopeng.com>

Please slow down, there is no rush, at MOST do a new version after
waiting 24 hours for others to review and catch up.  Usually a few days
is fine.

thanks,

greg k-h
