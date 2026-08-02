Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04513D503;
	Sun,  2 Aug 2026 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662942; cv=none; b=FyOBHB/QgcP1w8aNDnnxpkncEZgq278hqpznnCMoWmFLPubGIhqI1316sC8uzouqiXZ/ZIQlA4HHlnA/u445MVBIgHPr2KNqafU3OrnbtcxHoM77EIFhHqZD590xgQeaOszLCVOFrBYRM3pOkw28Uk551i6EEmk1nbOM/Z+1hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662942; c=relaxed/simple;
	bh=FhHUQolbQ0t4rygaZM91yN57fJM/833vcxcMtKtMuq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctL5MST187pcTCYvKggprZbeTOFyy2BOqr3LVBuygF11oOr7v0SyhpZzXv+1ZW85ccasMvHakKEyupDJShxvlGY99ssIT/C5YXOiq2b1A3rOJllIt8MrE29zJRf37uNMryWqdBrv1Ch75WDfqW2TX3lL54t3mW4GsHGI33V2vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d0HgA9Ai; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d0HgA9Ai"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=f0uGqlPESCOfU7sin8e1FZf3dAwPtBxZbATe/9/GMWA=; b=d0HgA9AiyCWc7eZHKH0IX7RuDK
	XZ/M3ogVB0DBtwJ8U1UhRwZXKTNjvyO6IRWJKtw2VVSyv9cUkho/oR2+WkbYVZeedim5Wp7Ihiiwd
	0x+UFdspbTo/Lg/K9U7853/0Wbl6gBz16LKnGh6PvP0bEvr/uJU4FO91NN8xDNKkXdLjabzdXcoly
	SI7CFCvE4UDSzmg8lm5EOUHmIBD9Ij8W0hRTADUR9GB6zio+ha2NT/R1MgwE9RoKRMThWN53+Ndzm
	zjxKBX2vwemO9nVqorDZ8LSHv92k5MvRaiCCqROxhB9EdiKSUNJrv6mZOfhCvTmYjTLtQTetxROJh
	rcBM4leQ==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__AES_256_GCM:256) (Exim)
	id 1wqSUh-00CXkL-5j; Sun, 02 Aug 2026 11:28:31 +0200
From: Luis Henriques <luis@igalia.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] ufs: free the buffer head container in ubh_bforget
In-Reply-To: <20260801024119.12667-1-ali@iusegentoo.com> (Ali Ahmet Memis's
	message of "Sat, 1 Aug 2026 05:41:13 +0300")
References: <20260801024119.12667-1-ali@iusegentoo.com>
Date: Sun, 02 Aug 2026 10:28:29 +0100
Message-ID: <875x1syipu.fsf@orpheu.olymp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 01 2026, Ali Ahmet Memis wrote:

> ubh_bforget() forgets the buffer heads referenced by a struct
> ufs_buffer_head but never frees the container itself, unlike its
> sibling ubh_brelse() which calls kfree() on the way out. The only
> caller, free_full_branch(), allocates the container through ubh_bread()
> while releasing an indirect block during truncate, so every fully
> removed indirect block leaks one ufs_buffer_head. Truncating or
> unlinking a large file then leaks one allocation per indirect block,
> which kmemleak reports with a free_full_branch, ufs_truncate_blocks,
> ufs_evict_inode backtrace.
>
> Free the container after forgetting its buffers, mirroring ubh_brelse().
>
> Luis Henriques posted a fix for this leak in 2018, but it was never
> applied while fs/ufs had no active maintainer, and the leak is still
> present.

It's been a while, and I don't even remember why I was running xfstests
against this filesystem :-)

But the fix still looks OK.  My original patch also dropped the 'if', but
that's just a minor detail.  I don't know who's using this ufs driver
these days -- each BSD has it's own thing, and it's likely to be risky to
mount a filesystem in rw mode.

Cheers,
--=20
Lu=C3=ADs


> Link: https://lore.kernel.org/all/20180705150415.25070-1-lhenriques@suse.=
com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
>  fs/ufs/util.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ufs/util.c b/fs/ufs/util.c
> index dff6f7461..3c65fbef6 100644
> --- a/fs/ufs/util.c
> +++ b/fs/ufs/util.c
> @@ -117,8 +117,10 @@ void ubh_bforget (struct ufs_buffer_head * ubh)
>  	unsigned i;
>  	if (!ubh)=20
>  		return;
> -	for ( i =3D 0; i < ubh->count; i++ ) if ( ubh->bh[i] )=20
> -		bforget (ubh->bh[i]);
> +	for (i =3D 0; i < ubh->count; i++)
> +		if (ubh->bh[i])
> +			bforget(ubh->bh[i]);
> +	kfree(ubh);
>  }
>=20=20=20
>  int ubh_buffer_dirty (struct ufs_buffer_head * ubh)
> --=20
> 2.54.0
>

