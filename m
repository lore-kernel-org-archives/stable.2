Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C76286A4
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894679; cv=none; b=U21hyFLZL2TdOfdaKFCBggsEsIxgr7g11xhGzq3NEkcPPGbZ06gGdZRRjsjFfc8tFGMryQqnBs3WjVjLuJBI5VUZ0Lkz/Pw/DGnr3T9G5x3ujHoOP4nUD8qc9U5bBLR1gq+NVzovCszPvnr0CM2sBAdqWa0ehdKkkJL7xDaoaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894679; c=relaxed/simple;
	bh=6WN2JkoPbYZ9NZ5dzE10soK8jNGJFGFbCkCw+y6FUNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3IWulUpoHuw+YoswrL9pkoHX9CuSDU4X7uEWpPepeks7TBJ7akqReGeF2h3FpVGpTJ4AbSZRJoCqh1kFa7XpMuL37K/frIZHpCeJfqOI56vlg3HDum+asFFR5gEx31iA7R5tE9h90YPS/6LdUF19BoHEB9BcweotNDATl19fQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nOG53LJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nOG53LJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C81B1F000E9;
	Fri, 28 Aug 2026 05:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787894677;
	bh=9HjnIjN8C6NSppf+gxQ0+N5ReF7iI5M5fvAjyT+VSe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOG53LJPpfXtE9uDcWjk97Ucv4hSUX0LljfLVW1nB2mUS08gYXnKesycwY3KzMSdN
	 1+ST884tBKFDMRl+x/lb3nZ+8yDXs0ufNlZ8un90B9oa2V+va/CIaIdOR6tx9lOl05
	 HhrridFaCjLT+FiJc3ePelwZVS45CvafpBPbWDgs=
Date: Fri, 28 Aug 2026 07:24:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: Willy Tarreau <w@1wt.eu>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, security@kernel.org,
	andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	Amery Hung <ameryhung@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: Invalidate dynptr slices by dynptr_id on release
Message-ID: <2026082817-strangely-brute-f06e@gregkh>
References: <apDz2usnU7NuPNQm@1wt.eu>
 <apESnzAPQa0cMeK0@DESKTOP-F439VFF.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apESnzAPQa0cMeK0@DESKTOP-F439VFF.localdomain>

On Fri, Aug 28, 2026 at 12:46:23PM +0800, Xu Yunxiang wrote:
> unmark_stack_slots_dynptr() comments say it invalidates slices associated
> with the released dynptr, but the implementation only calls
> release_reference(ref_obj_id). bpf_dynptr_slice() / slice_rdwr() stamp
> dynptr_id and deliberately leave ref_obj_id at 0, so those slices survive
> bpf_ringbuf_submit_dynptr() / discard_dynptr() and the verifier still
> allows LDX/STX through them. bpf_dynptr_data() slices are already covered
> because they carry ref_obj_id (see data_slice_use_after_release1).
> 
> Walk registers with a matching dynptr_id, the same way
> destroy_if_dynptr_stack_slot() already does when a dynptr stack slot is
> overwritten. Do this for the released dynptr, for each clone, and for
> the non-refcounted path.
> 
> This is the minimal stable equivalent of the slice half of 308c7a0ae8859
> ("bpf: Refactor object relationship tracking and fix dynptr UAF bug").
> That series is an 11-patch bpf-next refactor (parent_id, DFS, folding
> ref_obj_id into id) aimed at qdisc/file parent-object UAF; it is not a
> viable cherry-pick for 6.6.y / 6.12.y / 6.18.y. This hunk is.
> 
> The same change applies to 6.6.y and 6.18.y; unmark_stack_slots_dynptr()
> is the same shape there.
> 
> Cc: stable@vger.kernel.org # 6.6.y 6.12.y 6.18.y
> 
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

And again, no authorship :(
