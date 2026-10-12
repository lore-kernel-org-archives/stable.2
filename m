Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAC32B126;
	Mon, 12 Oct 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802466; cv=none; b=XkV/SBO9WmVRSAsD7BCW2fqpZK8GqQtWpcDZCgSCk6RlVMeuPdYZ4Ic9ymrHhzqEdw5+Ap8UPG7qEaRS8E6BDLX+KurJ9kN7304chNsFm1qiJ3GHeHPOI8T5tul30xpDc17imhwxyeGUibSSLZWWhBhTuUnOARifaYtEmphd9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802466; c=relaxed/simple;
	bh=cvpnEkyV39qcDPnFiNy4Akoyb7vS0Zey/nueEwHLbao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7jOwhhsb4Rg++66KC6/bBbHLl5ICZP1yqPaBEbHxB5OXSWObF/MzQd+FbTeIRV3kt/dizegIIgF/z8pdIZhlGesQajJ+3C4oM9fW0Jwexwt7dGDmICa7v8B4ztMpxjAZO8WgNp5L2Pe6N3ueWAmKSyYhA9Qhyk6vhg8yHvP9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9stZLvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9stZLvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435891F0089B;
	Mon, 12 Oct 2026 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791802465;
	bh=SiQYpDwehUopcrMt0+cGxy+F+pfFjpt6YKcfNMfHUoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h9stZLvxXbOXy9TCr2h75kAsd/wtdcLy8wjxv1ufiKUwk1rwm53zWjLvyXYVDisBm
	 XwKFVzhBEzCKExIPKX2J36AbaRajEvjJTMY+x77g1JGAPAspfNRDj4rDbeXau9DpTe
	 ZoQP6tJf5IEuzFW6n6rqRQ20tBNZP6aB4WtmUADX7X+oMOMz7gIKNXGAPrPKnGWLHT
	 JkbXhWaOHF4VS6b4hLYXvgX5bKU0uaeAuRt16lD/NkpvMqnuzNO3R0Zhgef665reBp
	 GNpBVNuJc0NUnxQaFRpoGc3vg/MWGRukGEwFum2fSWy2rgELqyaqQ3+8kxw6rvS5PD
	 jFuLuEHVi0zvA==
Date: Mon, 12 Oct 2026 12:54:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>, Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
Message-ID: <20261012-pyrotechnik-plexiglas-dessert-d525a446126d@brauner>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
 <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
 <CAOQ4uxinQiXn=F8p92rCTzwX5AcBiN0abWW7jE9jKE+zqjb1_g@mail.gmail.com>
 <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
 <CAOQ4uxgXLcV3tmFp-gfF4Fm8ivvqGJzZXf3hmSeqo5dkzPv-=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgXLcV3tmFp-gfF4Fm8ivvqGJzZXf3hmSeqo5dkzPv-=Q@mail.gmail.com>

On Mon, Oct 12, 2026 at 12:48:30PM +0200, Amir Goldstein wrote:
> On Thu, Oct 1, 2026 at 2:06 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > Isn't the inotify problem described in the commit message already solved by
> > > 669bb5af15d41 ("fs: make sure to call fsnotify_inoderemove() only once when
> > > inode is dead”) on vfs-7.4.misc?
> >
> > Indeed, I forgot this patch existed. Good, then we can drop this.
> 
> Alas, not quite.
> 
> Kyle Zeng was able to provide a reproducer for the race off-list,
> which is not solved by 669bb5af15d41.
> 
> He provided a tested fix patch following the same idea as I mentioned with
> FSNOTIFY_CONN_FLAG_OBJ_DEAD, which he called
> FSNOTIFY_CONN_FLAG_DESTROYING.
> I provided RVB for his patch and I think we should go with it.

I already have it in vfs.fixes.

> Regarding 669bb5af15d41 in your tree. I think it needs a new revision.
> I will send it with explanations on the email thread that lead up to
> 669bb5af15d41 [1].

Sounds good.
