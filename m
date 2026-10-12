Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F12E717B;
	Mon, 12 Oct 2026 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840149; cv=none; b=fOFtkmTqDsPfsthDRGqLdOC/kAkVYcRQdoG/77N9BNKlxDlJYXthzPmY0R7XX4GBT2jU1HNiCcqVFaFsljNlDiszFzyp48Rp2Mjx6c7e3adFqAXZyFT9js0PnXVHK0YE5i3+1mpQO0Tn2e29hUCpP4Fk0MBz1tK2cZF3puHZd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840149; c=relaxed/simple;
	bh=Dt1dSp6cnTsSuU1R5iawZnT8HZc1U2jnpnFfEsqtBxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8HDdhK9dxNeU9tjJhQ0oSuQnPqRzByQa1TTRdBdZUFfS9CBsBZgQM23amPQoOrw04wbks8tDanMVZlW+4N3O+E4Juu4Jm9mzfdNlgCxAi9xXfbRrwEjBrTSFjC08IWjfzT5PnG5WO8B6Qzsc3YtwY5cJ5AV3CYHHbLPXnc3JNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MJQ6uszv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MJQ6uszv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=I3KrjdeV0UiA+30eca2NC+dO4LthERlcCwBIkYYAoKU=; b=MJQ6uszvkqQtRc031WMjaNOvn3
	eoJ2JVpL3/0wvJsEaIoyk6gEiz21FPB7BgaDCb2GCsbPVEEhsOSRclgUvR6l/BCUdS62QWLQ0aRGe
	TcKI7SghRC2XEN3cLMuS1qd7WUZUBbptYeBbXuaLVU34uLWjrp6DGM0QsQFtlKGAy3O7zJqx6DFkC
	0BcEQkx2WnoIEcxP8hTTWr2PirXuVHGPU/KxnotcD117xnNU2h1MiBUKkHdQfYMMDnqWRbLtQ7KYD
	Im69pvKgcgJgaSLxmdwwTbyRHPl5BxshjmVOpTxUKUNU8f6+aACZYNbkRuSLNSJNx9s8JYQfEAVLr
	RpICV0gg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Subject:
 Re: [PATCH] accel/rocket: Fix use-after-free in rocket_ioctl_create_bo()
Date: Mon, 12 Oct 2026 23:22:13 +0200
Message-ID: <5113180.GXAFRqVoOG@diego>
In-Reply-To: <20260917180013.2166025-1-vulab@iscas.ac.cn>
References: <20260917180013.2166025-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Donnerstag, 17. September 2026, 20:00:13 Mitteleurop=C3=A4ische Sommerze=
it schrieb Wentao Liang:
> If drm_gem_handle_create() fails, it takes and then releases its handle
> reference internally, leaving the creator's reference as the only one
> held.  The drm_gem_object_put() then drops that last reference, freeing
> the object via rocket_gem_bo_free(), and the subsequent goto err makes
> drm_gem_shmem_object_free() run on the already freed object.
>=20
> Return directly on the error instead: the put has already released
> everything the function acquired at this point, so there is nothing
> left to clean up on the err path.
>=20
> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/accel/rocket/rocket_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index 91095d1b3066..521819041475 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -82,7 +82,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void=
 *data, struct drm_file *
>  	ret =3D drm_gem_handle_create(file, gem_obj, &args->handle);
>  	drm_gem_object_put(gem_obj);
>  	if (ret)
> -		goto err;
> +		return ret;

I'm not sure, which kernel-version you're on, but it seems this code in
question has been changed back in may in=20
commit f706e6a4ce75 ("accel/rocket: fix UAF via dangling GEM handle in
create_bo")  [0] .

Thanks
Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df706e6a4ce75585af979aec3dcbdce68bc76306b


