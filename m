Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA053A8A1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960437; cv=none; b=Cfn/IJuSV6RxtL3IB1F3bGhGrORhrH4mfAK+Yu2fxiVBfy/YwRzV3MNoZti7mBpIvsWJZry5XVQJ1Awu12kjdJOaQC23T/hHC9VyGT/ftDf+ixVdsj7ebJAkX98Ju3ygfxLs3nv+bt0HQxu12KHFcCttYD1DvHBBOYw4p6G82m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960437; c=relaxed/simple;
	bh=HYsTh9t9kd4bhtCJZP8RuhHSBhaLDPN70GEFAWxsCjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeGRoorPNZjvjXvjw538b/H2nCL7U9yhtudd+FMcG2F1CUTGbeHGLnT0ck37sYb+xSai0s/k73toY7YuWaHraX7zu5mOz5PBMMvnUAICwsvRYfVfkA8zmRpPQKNxCye9boXYV4W3ltwzRiTTwlG2OhkZBv8Z739lv6Hsq37HBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBHXXTjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBHXXTjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAA71F00A3E;
	Wed,  9 Sep 2026 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788960430;
	bh=GGpIaNpTbGts1ldRwdiHZbKBwY7bCvclyL2OcMs6GFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VBHXXTjVCv7tif4cVOy0eFazfkqzhhVqGlTeUEbxrgEj4gUXuqQc1Fu7F6r1OHl25
	 Q3G/xwuV0rMwXFyzKT3qy0VKBSlBCRhWE48ORZUjZWMtcfSAGpPckQtEzyPuzjHKHA
	 I7VbAKWmfcEivh6dvNm8KKY6g6u0kbxaMlRLrric=
Date: Wed, 9 Sep 2026 15:18:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudheendra Sampath <giveback4fun@gmail.com>
Cc: stable@vger.kernel.org, almaz.alexandrovich@paragon-software.com,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	syzbot+7bdfe1182e4c50d2a21d@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH 5.15.y v3 v3] fs/ntfs3: Change new sparse cluster
 processing
Message-ID: <2026090924-idly-theology-e828@gregkh>
References: <20260908192213.1169088-1-giveback4fun@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908192213.1169088-1-giveback4fun@gmail.com>

On Tue, Sep 08, 2026 at 12:22:13PM -0700, Sudheendra Sampath wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b upstream.
> 
> Remove ntfs_sparse_cluster.

This is very different from upstream, and there's no description here of
what changed and why is this needed.

thanks,

greg k-h
