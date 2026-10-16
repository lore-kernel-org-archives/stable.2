Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870A49BB4F;
	Fri, 16 Oct 2026 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175376; cv=none; b=ZQt2QwM7MdTqWhEoFAWB0vJvqcbtn0xJli87RVoM2TLPVOW+LsunMX2hdHoaeYOcplHEh1cZzNhvy+jrZh/cCf1qFZxzFjR6iphGQnGA0D8PoetWXXLfa2Wv8F6mOgMrlQ8Uh7CwBnV1Bw1YtqU2q3E9A47suxWYCe1F+7T4j5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175376; c=relaxed/simple;
	bh=nUebxZQn3TLHaGNPBhoD4qDbk9N0SCipmKJ/9dDwwPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5yM1I+UUeS5jKGUHUEj88/pkUWIs6skonv03ofCRIqtHBFU4f6j0s+oT8+h93o/UABBxkP2gPbVVy4c+Bb9x85MDUCGttiHpKNoj6afHAgTVFnIPQt1HrYdKCH/wk6ujjI+QN495QLMgQj6rje4wxYzop/Lx04VvNZR4bzalqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Zqk05LVg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Zqk05LVg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LcAiFagNgw78WjAIjATMbNu+Gq86KuUCUXOpdNmtAYo=; b=Zqk05LVg7PNvEI+h+jsDHeZbzk
	NZ/okrhchLU9FtfDFOMzlsJhus400keuSoTO+WWjUZ71/NjpEOJsyWervR/8e4WeacGH8Q27NZtEv
	PAvrIW1OpfYfGjFrcKZmGm/nDTJEOBZmC3iQRt/fxsZNEL8E4C1MWYK8C8bC0Mu8qlKTyFhQ2kLkS
	/LWdDdBpKqcSTGLxhmauoVTKmSsery+KAZsM3Dw4GVb9QFWGdsVn0d59cUKv4WcyYdwJpoTBW/aA9
	1e9OZt0DYcv2kiVLN5KT2mwwQ6nmt55QlwJHCTIj60IJNmsY/Wni5NsTWfwm3rzaEyaxmAiNqY2rV
	sOZ+M1uA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHmgJ-000000063Cz-2Wk4;
	Fri, 16 Oct 2026 18:29:27 +0000
Date: Fri, 16 Oct 2026 19:29:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, cel@kernel.org,
	neil@brown.name, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfs: keep the mount pinned while waiting for a parent
 delegation break
Message-ID: <20261016182927.GG989762@ZenIV>
References: <20261016093421.90725-1-zhaogongyi@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016093421.90725-1-zhaogongyi@bytedance.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 16, 2026 at 05:34:21PM +0800, Zhao Gongyi wrote:
> filename_mknodat(), filename_mkdirat(), filename_symlinkat() and
> filename_rmdir() can call break_deleg_wait() on a delegated parent
> directory after dropping the struct path that pins the mount.
> try_break_deleg() only takes an inode reference, and an inode reference
> does not keep the superblock active.

So why not have it acquire an active superblock reference at the
same time?  We don't need struct mount reference there - all it
takes in increment of inode->i_sb->s_active on try_break_deleg()
side and deactivate_super() on ->i_sb fetched *before* iput()
of ->di_inode on the break_deleg_wait() side...

No need to mess with every user of that thing...
