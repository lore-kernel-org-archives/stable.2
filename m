Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADA3ADB8D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894615; cv=none; b=klXMk5m11IkmtlkbkzNl+V/jJExkC7Mk57PNAvdP70hlmb188+Ll/dX5tIizR7O6xRqr3SqUeDArmGIS+/4XtAoTiE9Sjl5i8XdM9+SM1g/8xW2qFYtPqKDwiZ6w6U4wy8eJpB1L1gBVitRQCdmajawCsTxv7B/k8j+kIAf9Nyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894615; c=relaxed/simple;
	bh=tT0hCJYRDN3LIsSwxxavwBfOmPXwze8Ve+Aa53EBPjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1VYnxrhTgbfXsEIyLfACAIoCNzvPzH+39rKWltrdB5zFOjJPj11B+GmcuXtTunjpmaIPWFf7jtGTaP4K84c3ZszvCVSEMfSJ9Z1yWYKKNVge1W6E9NKCun8+i5KwD6eexTgAyu2IhpnuSuJ5R++9rVeq+pF17gxLRJSGqPuMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKMKGch/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKMKGch/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352DE1F000E9;
	Fri, 28 Aug 2026 05:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787894613;
	bh=SOQeuW3Bi9cxxdaDtKRIqBKoUhxugKEQcEkfWcFZ0iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WKMKGch/xjbKD3aqpzMxn+sOMUGLqFebJ6zUEis/s/9+UrfaGyg8sYye0AIQ+Zeh5
	 hDbUPXyo0aDhiGUFiC08jXKTXWlVzzp4jZr6P43Y+6t5PvkrTBZM3VxCtdWB+xNIMg
	 6VtHoPHhEWts+DlUjob+9iZ2EQTFJUFPRcoSKXII=
Date: Fri, 28 Aug 2026 07:23:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: Willy Tarreau <w@1wt.eu>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, security@kernel.org,
	andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	Tao Lyu <tao.lyu@epfl.ch>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
Message-ID: <2026082824-donation-nail-1190@gregkh>
References: <apDzg_JciKsoBk_A@1wt.eu>
 <apEShxAOrNDGUoga@DESKTOP-F439VFF.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apEShxAOrNDGUoga@DESKTOP-F439VFF.localdomain>

On Fri, Aug 28, 2026 at 12:45:59PM +0800, Xu Yunxiang wrote:
> Currently KF_ARG_PTR_TO_ITER handling does not check reg->type.
> process_iter_arg() therefore accepts any register whose constant offset
> resolves to the stack slot of an initialized iterator — a bare SCALAR
> (kernel panic) as well as pointers to real kernel objects (map value,
> ctx).
> 
> This is the 6.6.y equivalent of 12659d28615d ("bpf: Ensure reg is
> PTR_TO_STACK in process_iter_arg"), which is in mainline since 6.13-rc
> and was backported to 6.12.5. The original commit was framed as
> completeness (align with process_dynptr_func) and was never queued for
> 6.6.y. 6.6 still lacks the type check (verified through 6.6.154).
> 
> The verbose argument index uses `regno` to match the surrounding 6.6
> messages in this function (later trees print regno - 1).
> The verifier_bits_iter.c hunk from 12659d28615d is omitted: that file
> does not exist in 6.6.
> 
> commit 12659d28615d upstream
> Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
> Cc: stable@vger.kernel.org # 6.6.y
> 
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

You lost all of the original authorship and signed-off-by lines, AND you
changed this from the original in a way and did not document that.

Please fix that up and resend.  See the thousands of examples on the
stable@vger.kernel.org list for examples of how to do this.

thanks,

greg k-h
