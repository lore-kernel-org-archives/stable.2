Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBCCA6F;
	Sun, 18 Oct 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335671; cv=none; b=ET9/HNoouAerenXPMZP8Bz2jiBJg7hWj3hCOHpmZSsjI6S2mC7/LdzfvPly6fo16Y5KqQSAQLN3nFJYwpF064YIKudRluv2vjxBgtB/yvyPrpsay4UGOzE6zJtqWpdipnenntVlpl5k3T/glXhwdiyFx8n3geQYGmStBXCFxQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335671; c=relaxed/simple;
	bh=hHucxanoRbVcPV3hrlDuU407nTeTQ20xbLPEhLH8uH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6O2YQnmcBK18jfFa4uJna+UM1SBWmvpk+h0EUfIpVVcn47QlxGQtFgELZYwhRFM0prEpN0oVPICFggzvuunkFDiLO3WLIm+R7oXOUz5JkYKeSVLi3LrYxYIIaLVm3LPK00D1yaN+kCBMNgx8YKLf8RfMtPiAVVKxhD9gtLPSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UCiDyNys; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UCiDyNys"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hu6ewlO5IG9SLBwTyGiV+QusCIa7MkxJyl9d84DVc5w=; b=UCiDyNysttf7+QJf+TJdazXvBF
	1mFgI21YSgCqVl/GEnsdJKaC4GIpn7KOldpQYQXc0nTASeqrorew3JTx1HYbRY91yPnZ/JhcYom9C
	DnGUHcbfBLtbeS9gHCL/iBSRVtRkfxDPlWRhTH2xonZtVYcwyLMe040CN8AG4alGdYtf4BalfGLKY
	N5tP6n3jf/9pHcpACJIq91v5+zx4CNC6uZGJOgHX+9vErHGcFZxNLft6BVpYXrUmvQCh35OexQaqx
	GhUGxKw2R0mHj+bWd10AHGkgy5pKmWwQpBif0ri7k1iBNYxdDzmIzEeI/F+v8FINfGVq1cciWgzYj
	FY1zI/DA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xISNk-0000000BKK0-2W1H;
	Sun, 18 Oct 2026 15:01:05 +0000
Date: Sun, 18 Oct 2026 16:01:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Mason <mason@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/17] namespace: check a submount for references right
 before unmounting it
Message-ID: <20261018150104.GG3535232@ZenIV>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-2-be34c83956ae@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-work-mount-fixes-3-v1-2-be34c83956ae@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 30, 2026 at 03:31:54PM +0200, Christian Brauner wrote:
>  static void shrink_submounts(struct mount *mnt)
>  {
> -	LIST_HEAD(graveyard);
> -	struct mount *m;
> -
> -	/* extract submounts of 'mountpoint' from the expiration list */
> -	while (select_submounts(mnt, &graveyard)) {
> -		while (!list_empty(&graveyard)) {
> -			m = list_first_entry(&graveyard, struct mount,
> -						mnt_expire);
> -			touch_mnt_namespace(m->mnt_ns);
> -			umount_tree(m, UMOUNT_PROPAGATE|UMOUNT_SYNC);
> -		}
> +	for (;;) {
> +		if (!__shrink_submounts(mnt))
> +			break;

Everything else aside...  Why would one ever use

	for (;;) {
		if (!test())
			break;
	}

instead of

	while (test())
		;

outside of IOCCC?  Sure, compiler will generate the same code, but...
