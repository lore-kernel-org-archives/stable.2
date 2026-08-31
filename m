Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610639FCCA;
	Mon, 31 Aug 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177272; cv=none; b=qb7DXex2h8CTN4ZuLuaBO4FUtPmLcR9d75KVnBSehZwAknnjD4nFUiEOOD8Ky4/MjcrYZ3xYxpcnh/iTJRqFdE9QJ8/+gGzIUjojjEQTbWUXS/y7B+HQHm6q3sXsk2/2yt91ZyTC7x73G2HbC4UfO9PiHN+kMehmRNNJzedS1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177272; c=relaxed/simple;
	bh=qj3qoDe9nID+UcarZFqFo8J+PaFcLG4LTpRw5E9QIEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwue6MFTFS3sGQf6ysTQ+vvjmVnou21EAdXylZhEcvFyiew16yROiEFPTehMMyqPhHCbyvslc59/DXjBykrVMq77ugo6u7Oeb8XhD275QGQk3KYtb9hu7WNubF6/15RIkkYEj2i9hDTNBFHsQcg0KMB7yVpsHKcbiAKgq+PXjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1e0KeV+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1e0KeV+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52811F000E9;
	Mon, 31 Aug 2026 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788177271;
	bh=k3DIoBnWhit5Xx4ZLCyreri4/rx6jQ/5gRGDck3oLbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1e0KeV+ci8/FAT3Bn7A4k399JrtOgyjyrXc6kbYpY4sog8sj3xZWvfpUOevmmA6y8
	 5F0WZwqe0VokxVDj2TAxDI4ttDwO4e1n0b3thi6jcdvUc/AqJq1669Ukld/Ey+6ZLq
	 d/TFbCJzL0OOa7D9nCnYnioSanfNWTPPGO6a+J6I=
Date: Mon, 31 Aug 2026 13:54:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	martin.lau@linux.dev, ameryhung@gmail.com, joannelkoong@gmail.com,
	sashal@kernel.org
Subject: Re: [PATCH 6.12.y v4 0/3] bpf: fix dynptr release handling
Message-ID: <2026083135-hammock-bagel-3147@gregkh>
References: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>

On Mon, Aug 31, 2026 at 08:15:49AM +0800, Xu Yunxiang wrote:
> Upstream commit 308c7a0ae885 ("bpf: Refactor object relationship
> tracking and fix dynptr UAF bug") fixes these lifetime bugs as part of
> an 11-file parent_id refactor. That refactor cannot be applied to
> 6.12.y, which still represents the relationships with dynptr_id and
> ref_obj_id.
> 
> This series supplies three stable-sized equivalents using the existing
> 6.12.y representation. Patch 1 invalidates slice registers with the
> released dynptr_id. Patch 2 propagates a referenced-dynptr release
> error instead of turning a callback rejection into a kernel warning.
> Patch 3 scans every active call frame when invalidating cloned dynptr
> stack slots. They are split because the bugs have different
> introducing commits and independently testable effects.
> 
> These patches are stable-specific implementations authored for the old
> verifier, not cherry-picks of Amery Hung's upstream diff. Each commit
> keeps 308c7a0ae885 as the upstream provenance for the equivalent fix
> and documents how its implementation differs.
> 
> Changes in v4:
> 
> - make Xu Yunxiang the author of all three stable-specific
>   implementations;
> - remove the authorship, sign-off, and ack trailers copied from
>   308c7a0ae885 because those developers did not write or review these
>   rewritten stable patches;

That's not ok at all!  Take the original commit, and "just" backport
that, keeping the original changelog and authorship information
everywhere.

To pass this off as your own work isn't ok.

Also, you forgot the 6.18 and 7.1 trees, we can't take fixes only for
older kernels.

Please fix up all of these and do it properly.

thanks,

greg k-h
