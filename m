Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528C3FC5B7;
	Fri, 21 Aug 2026 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340115; cv=none; b=mfb9wXJxg3n3MAkcvVuEKMWtYXq+r+CqEGdnHjs4/BBoQ8eOcojgMWPwT5utwuQFxAby3M7SeiD7MFfpYesZOCRYkyY+muuBl4LhyTWUHOyENDvRNaRW6KO2+I4M4qmtmQrmmLMIPA4Wkys2hTGzy2Iebc98eaGu9raRL1HGAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340115; c=relaxed/simple;
	bh=gXF8iz+wYQgG10FLsZh6CYRv3Btle9XR/JcIBYOH+8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGWYGvIOTULt14Lai/Eg4LD8s8WjOVGk85STu39JojQFfihonUk1SqCMx2xl5MaOXHPEut/0AJQk90SlarSMlYXFyDQ7311IPnuA+T5nk4HMGXoGoqiTx9yHGXIhqRmwle+9ZNcIw/L04PjbHd/seftrsDNRKG583eE3aBToBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYHYML7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYHYML7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E41F000E9;
	Fri, 21 Aug 2026 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787340113;
	bh=6vODyF6CYY5aRNRATW9aqTUa410IgP9lF5ROlWTn/X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JYHYML7l1Hh3xeJyrzxBfvFPGoErp6qKVwslT8FxMcWkqsHJjv1jL6A9kKgYmn+R7
	 vb+G/lKFXgInA1DdW9tyYVlOq2qKVq+s/rnKE/WlL0lEIe24Yq6/+DtlVh93ASK8PI
	 e9osd+/ZFwJz4X+UWwnbTICjtYVC1O2MjWoNIgEIt971BM17SIW5T3cvScd3wv1QK5
	 1zsrSzrfx33IcndEp2u2lc9Y9zsHRzbHUQYz0KWnjkzJf8ecGtzwJXamdagFfqafQI
	 spakg7lqRNtoO2sNKgB0dHtvxwRDzbL1jTIkCFMdTS1b8qtBXDyt/AfwYQfqS7RDb+
	 Ln2vlxie5ohrA==
Date: Fri, 21 Aug 2026 09:21:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: gregkh@linuxfoundation.org, chenridong@huawei.com,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] kernfs: recheck of->released after acquiring the
 active reference
Message-ID: <aoilUIPIPAzHPuhO@slm.duckdns.org>
References: <aoc9XplwfHGjQym4@slm.duckdns.org>
 <20260821050720.14848-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821050720.14848-1-fanwu01@zju.edu.cn>

On Fri, Aug 21, 2026 at 05:07:20AM +0000, Fan Wu wrote:
> kernfs_get_active_of(), added by commit 3c9ba2777d6c ("kernfs: Fix UAF
> in polling when open file is released"), tests @of->released before
> acquiring the active reference on @of->kn.  A hide/drain/show cycle can
> run between those steps: the drain path releases the open file, and the
> reactivation lets kernfs_get_active() succeed again.  Any entry guarded
> by kernfs_get_active_of() can consequently run its file operation on an
> already released open file; on the cgroup pressure files, the poll
> callback dereferences of->priv while forming &ctx->psi.trigger and can
> hit either stale, freed memory or NULL.
> 
>   CPU 0 (kernfs_fop_poll)       CPU 1 (echo 0/1 > cgroup.pressure)
>   -------------------------     ---------------------------------
>   of->released == false         kernfs_show(kn, false)
>   ... preempted ...               kernfs_drain()
>                                    kernfs_release_file()
>                                      ->release(of)  (frees of->priv)
>                                      of->released = true
>                                 kernfs_show(kn, true)
>                                   kernfs_activate_one(kn)
>   kernfs_get_active(of->kn)
>   ops->poll(of)
> 
> The cycle needs the file operation to be delayed between the two
> steps, but kernfs_show() cycles like the one above are fully
> userspace driven.
> 
> Acquire the active reference first and re-check @of->released after
> it.  While the reference is held, @kn cannot be drained: kernfs_drain()
> waits for kn->active to reach KN_DEACTIVATED_BIAS before draining open
> files, and the only other kernfs_release_file() caller,
> kernfs_fop_release(), is serialized against in-flight file operations
> by the VFS, so the re-read settles whether @of was released for good.
> The re-check needs no lock: @of->released is only ever set to true,
> the drain which sets it precedes the reactivation under kernfs_rwsem,
> and the fully-ordered RMW on @kn->active in kernfs_get_active() then
> orders the read after that reactivation.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 3c9ba2777d6c ("kernfs: Fix UAF in polling when open file is released")
> Cc: stable@vger.kernel.org
> Suggested-by: Tejun Heo <tj@kernel.org>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
