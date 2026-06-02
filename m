Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C578237180;
	Tue,  2 Jun 2026 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363153; cv=none; b=N4CGxDVnjj+uyV7aUvYQfmmM7/UD/pBe30noJyCbsnHshkjmPAhd7urn2tbNpdzZIBRBPqzgqwK8Mb7sbUxBga2UPDE6H9GTaAPYVnA9ZCTnem2p2Czqm/9LDUiZrfQaJgS1Aguc0VcDWo+RqOOxxoL6mWzL3UJOIymFetAJ1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363153; c=relaxed/simple;
	bh=ShsXF7M+jxyIDEwGqkvYyN6ijk25qHrEl6sJqRhRKfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnEKox/5z13SmwWJ4uN/HNuy4zgi5VkdmcR2IrCAbCSGq4e3UrvcCfVQs7KcxoZtxCFWVs+MbMb9vX99aLL4rffHfprLHng+M4W9A+rsFLv1E9r3ZKS4vQEpaF3mOH6ueXeY6Uwh6An4JxXkWVnVorq++l/jjlkCvhPjZyIg018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gvFAtvIh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gvFAtvIh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Oa5E5Z6jfi3drM8y6J/iD9T/dfhGImX59IzeXVuxfy8=; b=gvFAtvIhONC6qtku9cSQSHbhO7
	1qu9U0Sry41uB2jF7i4IPvHEGBDXFJWy93nWeMSSe0Y/XPU+LHShkVGM3GMgz3RaepNgiKl5z04eM
	q/kwPz4yLWidGi4dR16hatMT5Axcm49hbU3trpJK4Fya54nj0T0IInBLQOIxlPYhjm/De2wxRO9B3
	gMS+stC5xJKU6bmtuLEviOnleDXJgnPbZaGRRg+GTQITOuitPDDWKu0ZInMXAj8f5pelgpet93Lgs
	Txs4iA2aoOoRE95MDV9oc3yQ7eQ4HHpeT5/fTKDQrEjzfTQrkVA5ECDhbHRc9yIB+Wi8HrmutZxAI
	MBmZVoig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUDmd-00000005EaV-308W;
	Tue, 02 Jun 2026 01:19:07 +0000
Date: Tue, 2 Jun 2026 02:19:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Denis Arefev <arefev@swemel.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in
 userspace
Message-ID: <20260602011907.GM2636677@ZenIV>
References: <20260521072857.5078-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521072857.5078-1-arefev@swemel.ru>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 21, 2026 at 10:28:56AM +0300, Denis Arefev wrote:
> The bdev pseudo-filesystem is an internal kernel filesystem with which
> userspace should not interfere. Unregister it so that userspace cannot
> even attempt to mount it.
> 
> This fixes a bug [1] that occurs when attempting to access files,
> because the system call move_mount() uses pointers declared in the
> inode_operations structure, which for the bdev pseudo-filesystem
> are always equal to 0. `inode->i_op = &empty_iops;`

What?  init_pseudo() sets SB_NOUSER; what are you talking about?
And assuming you've somehow managed to mount the sucker, which
->i_op method had been accessed?
