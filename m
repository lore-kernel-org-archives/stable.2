Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0925B09C;
	Sat,  1 Aug 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785604552; cv=none; b=gfAKg1849Dj/5rvTRF6fsKiTX9umO/W656yiAzCPqoPOaeoi5Nbz+WxFf+V1FDeENCQ0nna1WOKr7XM3ROB0Cw0wPAk98DJdw36+CayI8refceciLcv8aAwdy6eejtqKUdAo8zRa2GrS8FFyMj/sEvp9kZm5VSSTyg3sjcbnRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785604552; c=relaxed/simple;
	bh=bUOAQR5q4kA41Cpj4Srt3WibasPOLQjv4wA/qW/rYCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFp1jSkdtbJj0SoM7/VWyYtSF11Cbhqah0rIVnanHMWez89NHBY5DV9G5zZ/oOGDWEm/Ny6M+qLSeTvd4Qby6ifcU9AgoTpVjvwIrqFQcAAtvLKN98jHwXipdrxJOPJMPNyTMsIVRAajl3UbgI6JPC+v9GeHIJzRYHCy4uriGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQrCGkY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQrCGkY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752131F00AC4;
	Sat,  1 Aug 2026 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785604550;
	bh=KdDXDmp7FAJf5kIwU0xoHMb5HTMwunbkXtS6iAf1grM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GQrCGkY7yOKeCBmmET5+jvtjqoD3j2CN3YrY7FGfFq75WjGnfFjrtE7spy7v9Xa7y
	 ltkQa16/yt7SM9pOwNEMYMokLI+rOWL9/KuHHtxpdey2/eaKVcX0ieQLWSuOHaflUM
	 3w7q+ZkSvF8q+n1ulAh/5Bxm8NL3UxvDU0283/fkYSpKu+AR4VC4XYnSV9Kf9c1xeZ
	 fhxB/N95eQTlfn4Lo6yZOVj0mnwE4dPAT5a23J/tkTodTrZfHgcW9OA9No9WRVYnlm
	 drAJFO1+LmgVyJ5dVs2um5KpsoKX4CNm0JRQKEV1r84Q/bemZsM8ctJL19rCosMYO8
	 sRWmHU5EQlAoQ==
Date: Sat, 1 Aug 2026 10:15:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: fsverity@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
Message-ID: <20260801171549.GB3567@quark>
References: <20260731003925.2728977-1-ebiggers@kernel.org>
 <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com>

On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
> > Also correctly handle sizes over INT_MAX, which previously caused an
> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
> >
> 
> I guess this occurs when using file dynptrs? Otherwise the size is capped to
> DYNPTR_SIZE_MASK.

Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
So this particular issue might be unreachable.  Still seems like a good
idea to match the u64 type that __bpf_dynptr_size() returns though.

- Eric
