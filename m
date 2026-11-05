Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893481;
	b=Ec0RMS8W+uiPZJxl9Wm0xGr2C0O6fFu/l0x/QVbPYbuqyU31qbdniHqsFywW3JVyQU2G
	 he/i3D+dDYRVft4qEAd+WB3ZmE96zE4Rylq489psBTeJfWqXbj5NJ/ZgZm16KWq2/ACNH
	 mSBSp02X09jb8oFwRQ3DwVT8UsMYAgq2nuTcq6nYRYD3Yuc81LCCPxhJ6nudrCPLRqPjU
	 Pp6GNXX2p1/pu32I9bjsSsO/3jPs0C1mnYIQTbL9L5gAIbx9aFbYUDjbgERa5JPs6qwrU
	 KtxwKuNwoWWw3dFQGau1clJ4G1xyGuBjMCiirOGo5wo3ywTiobdM19LzrOe58yf4rjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893481;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dEHSukm4T4eXj4wYWKIQpZ+9IcO69CzYv4uOD7S+jpQ=;
	b=XKQAq+QNwkPvdHHiOARNHESg2H/be4/R55G4dBZD4V8M43ZqO1ZmbQESLAotI8fs6Yh6
	 ERj4VlYwoWX1tJf6C3U8Nmx5oPenCtWPqJSoYMhXrwHiriEbj5tPdCMeub7dcRZD4ghr8
	 7iR0It1/+O2Y20cMvt0+mjjvGl4mOumU4M6iVYkJhh+aw7JejCgBPTNET3P3vD8DtwjbK
	 158C/9F8UuYp0Clqp73/1AAaGXpR/X77HTeh2JOcaDi3V6uRhxqtNC1X6Adu9985LZatW
	 Xz4pYf1h+h5gRDBXjrRydiqc1ms+JQjbcPm1nyDg8ojzZHI8xAsfoP3YuDDi3zgJrIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPDjg50q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA7606A32C;
	Thu,  5 Nov 2026 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPDjg50q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124A51F000C1;
	Thu,  5 Nov 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893480;
	bh=dEHSukm4T4eXj4wYWKIQpZ+9IcO69CzYv4uOD7S+jpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QPDjg50qQCIHzWlsgw3acSA/5xY6m6SZWjGyp1UDaH2j27o/23FstkEFFRWYDyJlR
	 Fg9xMgaUBcNKbsMh2LZkaQatRqIfNTD2eJCZoU0LKCuIVM99YZ35b6sgM5zc8O7xS/
	 L3ibsVPf/9JwsWuFvBKP/082nuZ4hnb9OI9qI+lBo++wnR20Xg71SdsHiVlM1adq9B
	 LTFt+d5FQybUl3SKx4y/DTQdzR8RTN949dljmstqem0tmfKjPoAOZ6yeCTWTQmYoL7
	 RLyV5y2faWjCN12smpuItcRCIBPCOzya22xq5gbmwto2HhWV0Xm2jLPL8Kgq42lPoD
	 q//Smeok+OCZw==
Date: Thu, 5 Nov 2026 16:44:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <matt@bobrowski.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
Message-ID: <20261105-berglandschaft-mitbringen-baufinanzierung-c0542594d218@brauner>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
 <atiawbBo6WRPA6QA@lima-development>
 <at_MbcW0OlciNLrE@lima-development>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <at_MbcW0OlciNLrE@lima-development>

On Tue, Oct 27, 2026 at 08:55:57AM +1100, Matt Bobrowski wrote:
> On Wed, Oct 21, 2026 at 09:58:09PM +1100, Matt Bobrowski wrote:
> > On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> > > On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > > > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > > > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > > > cannot race with that.
> > > 
> > > The crash is gone, but so is the path. file_release progs will get
> > > -EINVAL for every file that a task still has open when it exits.
> > > 
> > > It also breaks what works today. The d_dname branch in d_path() returns
> > > before it looks at current->fs, so at task exit a pipe or a socket
> > > resolves to "pipe:[123]" now and to -EINVAL with this patch.
> > > 
> > > And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> > > that current->fs == NULL in do_exit() breaks d_path() called from ext4
> > > open.
> > > 
> > > can we fix it in d_path() instead ?
> > > With an empty root prepend_path() goes up to the global root, the same
> > > way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> > > needed and the selftest can expect the path. A chrooted task gets the
> > > path from the global root, but it doesn't have a root anymore.
> > > 
> > > Something like this (compile tested only):
> > 
> > Prior to sending out the fix, I also considered addressing this directly
> > within d_path(), much like you've proposed here, but decided against
> > it. d_path()'s contract is to build a pathname relative to the current
> > root. It does fall back to a root-independent name when the path isn't
> > reachable from that root, but that fallback still presupposes the caller
> > has a root to measure against. An exiting task past exit_fs() has no
> > root, so d_path() has no correct answer to give in that state, and I'm
> > not convinced we should invent one for it.  That's what
> > d_absolute_path() is for.
> > 
> > You're right that my patch regresses the d_dname case though, since
> > pipes and sockets resolve today without ever looking at current->fs.
> > Rather than replicating the d_dname check in bpf_path_d_path(), which
> > would mean duplicating VFS logic such as the mounted pseudo-inode
> > special case, I think the cleaner fix is to move the "no root, no
> > answer" check into d_path() itself, after the d_dname branch:
> > 
> > 	if (unlikely(!current->fs))
> > 		return ERR_PTR(-ENOENT);

That seems ok albeit fugly.
