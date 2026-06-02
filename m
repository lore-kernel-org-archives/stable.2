Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D83E8C55;
	Tue,  2 Jun 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409277; cv=none; b=t3HMW+WCgDSe3ljganKef54jBUwN/inwdhVkvcD495stBNodC0XTNWeTywP1bbyrcmTeNcleQMo4p0cVYOe6EqCIIxf8/LC0e+AKwC00Q+fnV2b6Jy9bQrid8Vv2kES8zve7yXfSET/gR+AYU0EOdk4a7jMl/gGK5nvX3FZoi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409277; c=relaxed/simple;
	bh=4dz0aVDbAza9NrGUOk6no+/5AUPcXlFrOeq10s213Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsO+mSEOqSJ0GUTNhuGDw2E7jVsMtW9y1MqEjmFkI3rWYlHdiRHF+ZFsB9cEnx8xDKfeFwoWokt2nOABEAj8zzD+VzhNWDYbn9O83hvqTuTLeitzS0L7cbLfEk02dGG56wDTPW6dfggyl1odYnTZhZFXYXnpPwdxg4VxWiLLbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nfmRBtia; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nfmRBtia"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0MDfwDh/SJOUK5N2F+NqK0JKKK0pl/RgJyfkhobSXcE=; b=nfmRBtia0xRzP4DigT1vceQLCg
	slWKmmhyybGDT0A1Mk6Vcpu4Fyvn9Ye0ivNvfJoofBQeVonzes8redM8uxn/Q0Z7mkoMK/AzjTmJj
	9WXMAeGCMvBS1D/I5Yz5p1J1PkhKAYToNrzj0ab2rmMSL0vlk5kvwwdIwc6fnKaceAgQPFzXxo/tO
	pRCUCdmY/Ey0BD+cebLcNt6tfwbfznBcOG/fPGz9DwEQg8Mr6xp35AE0UzH9AC0sfE2uxv8BFf7t4
	GLDEghgSQl8pa0oWNg8draCgGG0fz9GePEyi9qzMbd955J15u6eIJWkXPFaSEYuczUbh9gVF3XdIx
	wjogzplQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUPmZ-00000008InF-1SNx;
	Tue, 02 Jun 2026 14:07:51 +0000
Date: Tue, 2 Jun 2026 15:07:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org,
	Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH]
 block: Avoid mounting the bdev pseudo-filesystem in userspace)
Message-ID: <20260602140751.GS2636677@ZenIV>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
 <20260602013526.GO2636677@ZenIV>
 <20260602020444.GP2636677@ZenIV>
 <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 02, 2026 at 11:11:11AM +0200, Jan Kara wrote:
> On Tue 02-06-26 03:04:44, Al Viro wrote:
> > one should *not* be allowed to mount one of those, new API or not.
> > 
> > Reported-by: Denis Arefev <arefev@swemel.ru>
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Won't it make sense to actually check fc->sb_flags before we call
> vfs_create_mount()? Otherwise it looks good to me.

Interpretation of fc->sb_flags is up to your ->get_tree().  What matters
is ->s_flags in the resulting superblock; that's type-independent and
that's what we ought to check...
