Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE448A2A8;
	Wed, 15 Jul 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130198; cv=none; b=pzdVc0jMdzVgKY0a6QOXsi42/HgC7OvJq7e43rEg/A3wjOEI++jC9o/TUK+lsSVzThhyOCChUXAiwB0vuQnMgtno3h9wJIgmBPfgxaFcXHgeq2VFJ0YHeJBXMMLLOkMxkKGtUWxDiDBMvGjJqqqfCkjcnDrkNsMZp5gbBnSAXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130198; c=relaxed/simple;
	bh=KTpI4ajP7tZ+58EKrEwmElnfiNgrQmJpX5w9lLsnbVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qrho1c77FYVpFEyQKUS5U2UkfroSNkqCfucvgjtMsJuwe8MQ93SzTgj0h2UuX3RRAZCFogGlWbvBI5mzjX86MvGtnsVuRdn6kW7fr6zonA8Uo5H3mG9kFb2UC2CzglgbNeYfaDpH4JWESj/y/0ZKx+OzIacHTsBUtWNfEvSC0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X+7QU0Mh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X+7QU0Mh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=h91dzcGBqh6bO1sKLAZB47WCpn3nyQhlpwOzbbUz0dc=; b=X+7QU0MhROV6xa8PpxNNybvUWY
	ywGBvxFFqkdz2oju4tkDDiKWZeo/aYqZLHaOBSTScig3nU6rjrQAySJ0160moz+jsZKdrMukX+4z3
	tOr6TRzZh6V0hFtGSM6CDTVtHuuYpXAUk5y1gaVaS41Ls03LPRIzJUcwf3Si6I628xsqm3LFe51h9
	0l01KORgxIl5vOdCsk0EGF/85xZwyiy9uiw95m7UZ5Bf57X61O2e+++SMqQfvL870EXXPiysWxUbH
	efwSGQMPhryXSmEXIcjpbCUP1bvabH+Z1Mc6h3OZhYSE6nIm5Xin14qRlZStlzFNE6fF+ibGtJ131
	+/7LJfxA==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wk1lG-00FWvx-5b; Wed, 15 Jul 2026 17:43:02 +0200
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,  Miklos Szeredi
 <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  fuse-devel@lists.linux.dev,  stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: preserve ACL_DONT_CACHE state in
 forget_cached_acl()
In-Reply-To: <20260713220932.413004-2-amir73il@gmail.com> (Amir Goldstein's
	message of "Tue, 14 Jul 2026 00:09:31 +0200")
References: <20260713220932.413004-1-amir73il@gmail.com>
	<20260713220932.413004-2-amir73il@gmail.com>
Date: Wed, 15 Jul 2026 16:43:28 +0100
Message-ID: <871pd445sv.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14 2026, Amir Goldstein wrote:

> The ACL_DONT_CACHE state is meant to be a constant state for the inode
> for filesystems that want to opt out of posix acl caching.
>
> Commit facd61053cff1 ("fuse: fixes after adapting to new posix acl api")
> used this facility to opt out of posix acl caching for fuse inodes with
> fuse server that does not negotiate FUSE_POSIX_ACL (fc->posix_acl).
>
> The commit also takes care to gate the forget_all_cached_acls() call in
> fuse_set_acl() on fc->posix_acl because there is no need for it, but
> there are other placed in fuse code which call forget_all_cached_acls()
> unconditional to fc->posix_acl and those cause the loss of the
> ACL_DONT_CACHE state.
>
> This is not only a functional bug. Properly timed, a get_acl() from this
> fuse filesystem can return a stale cached value, as was observed in
> tests, because set_acl() does not invalidate the unintentional acl
> cache.
>
> We could fix this in fuse, but it actually makes no sense for the vfs
> helper forget_cached_acl() to invalidate the ACL_DONT_CACHE state, so
> let it not do that to fix fuse and future users of ACL_DONT_CACHE.
>
> Fixes: facd61053cff1 ("fuse: fixes after adapting to new posix acl api")
> Cc: stable@vger.kernel.org Signed-off-by: Amir Goldstein
> <amir73il@gmail.com>
> ---
>  fs/posix_acl.c | 7 +++++++ 1 file changed, 7 insertions(+)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c index
> b4bfe4ddf64ea..3dc62c1c27087 100644 --- a/fs/posix_acl.c +++
> b/fs/posix_acl.c @@ -93,6 +93,13 @@ static void
> __forget_cached_acl(struct posix_acl **p)
>  {
>  	struct posix_acl *old;
>=20=20
> + /* + * ACL_DONT_CACHE is expected to be a "const" value and xchg it
> with + * ACL_NOT_CACHED would enable acl caching for the inode - + *
> clearly not what the caller has intended.  + */ + if (READ_ONCE(*p) =3D=3D
> ACL_DONT_CACHE) + return;
>  	old =3D xchg(p, ACL_NOT_CACHED); if (!is_uncached_acl(old))
>  		posix_acl_release(old);

Nice catch!  FWIW feel free to add my

Reviewed-by: Luis Henriques <luis@igalia.com>

Cheers,
--=20
Lu=C3=ADs
