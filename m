Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF954DDB40;
	Sun, 18 Oct 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341023; cv=none; b=G5Jgqd6728waKbzJfsYLKjcgCi8bFzGx5OfgLcIky4wZsKxD8U5+/28QOZsRt7NaXG9ruqntKr5ugQun1rx/9yR55UMRR7LBvOUvxV+s9Gi9KgypI8iycl9dz04iPEnUgFHQ0eQOiyvCgvWGu0EYbg1pWrbgjQFsnsthdseQNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341023; c=relaxed/simple;
	bh=zs1HZ+KYef9n5R6g+gPrToq7opGyOT3ESvtuJ0X86GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGdB9laG4mDsfolhUrAxc4Jkdc5tEMbL3QE6VVMp53mDJzDcjNL9aWyI4o2h7YlVrqCBBk4x1MbfKvmNRZgpEjwtkeFj8tfJZ2TWi9UTA2ZETxCaC9RtVu4N0WJz+/PsoA1iSaPjuVOiE4xa7qky944HNxqjr6P6oHNiX3UNAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ4xY/5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ4xY/5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C24E1F000C4;
	Sun, 18 Oct 2026 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341022;
	bh=jnxTrLkT+m0/E+lWq+6/KyoY58FjdiQYXFtFIAiRqew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jQ4xY/5+irwQ1zA5udD+PrrVTSVPO2RfJ3Jtr+NxF/Uov1CoL12b7VH+XhI/jCFVR
	 hPPl9r02Ai3ePJmSox8Qf191nwRPa3AzQr7ngs3q0bsCw28284vaAGNVyoKbipN3NF
	 emnU+hwx0aAW68EzB/82kUhiME9rFTZktG8pZ+VevxqR1tpyp4mRFN9rr5dEQCwRe/
	 3mbcLg0Z5lxldiX8rMCEGEYvoIe4Ntp/iv/KBiTqjrnahYp6wEwx15YsdRF3/Zvfrp
	 ZIBOtVuy1ifoItZ/nooWBq7WmnbONqiN3EI8fhzLvOZIjH51vVGgio8ZnbNYFsyJvn
	 gMJC74Xk4kq9A==
Date: Sun, 18 Oct 2026 18:30:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, 
	Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: jack@suse.cz, jlayton@kernel.org, cel@kernel.org, neil@brown.name, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfs: keep the mount pinned while waiting for a parent
 delegation break
Message-ID: <20261018-mehrpolig-goldschatz-medikament-3de24ee2cf35@brauner>
References: <20261016093421.90725-1-zhaogongyi@bytedance.com>
 <20261016182927.GG989762@ZenIV>
 <20261016183845.GH989762@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016183845.GH989762@ZenIV>

On Fri, Oct 16, 2026 at 07:38:45PM +0100, Al Viro wrote:
> > So why not have it acquire an active superblock reference at the
> > same time?  We don't need struct mount reference there - all it
> > takes in increment of inode->i_sb->s_active on try_break_deleg()
> > side and deactivate_super() on ->i_sb fetched *before* iput()
> > of ->di_inode on the break_deleg_wait() side...
> > 
> > No need to mess with every user of that thing...

Yeah, I like that a lot better than touching every caller. All the
break_deleg_wait() callers wait in plain process context with the locks
already dropped so deactivate_super() is fine there and the next caller
can't get it wrong.

Please respin it that way. Mind the missing & on s_active in the sketch.

-- 
