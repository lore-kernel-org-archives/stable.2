Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2102E06EF;
	Mon, 31 Aug 2026 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160412; cv=none; b=qwfGUeYrl8ErLBkYWMQNi+bvvlFggexG8qz9VAyw94su6V3LRYI3fajhKLzsn1tcdfylcAg+X+og9OlEBPvv+HwKLyTKTvQIsQa6aAroOG6UwhyDNMtRyjTw+1e6dD60OATjwauKyrAo7jLzoJXu9HvxTIxmOT1BBBdJRn+S1bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160412; c=relaxed/simple;
	bh=0nrB+sIhXkE6Qo4QsY5geIk3e97a/henQLSCAduykuk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f36xgFovRXYCFuq0rnQ0YZ3rg72k8zpgSgY4fw98wdy0NTMMD8fzAKRyohOUh424YtgX6+oq5WdCD3pEvJLlv8LkOqpGRaF+3FwIpxba2d7PIMNCMX52P4Gy8xaPnZDhsb5bqp43EeGO5yC2sLvZqNuSpYY+CmJ/AfEZSLueNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3b7Dl9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3b7Dl9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8A61F00A3E;
	Mon, 31 Aug 2026 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160410;
	bh=DXM8OoP4+1xGpALJBlph/aL9bZdqRRLPBGuhhtyRrnU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=B3b7Dl9crSE763uBiFKi+LIV5ayBfFijE+7gcdry1bgveNK7AtsdmbSKkPSGEsGJ+
	 LSDcca4HyxnIiY/XlnAt0/vHzSa3el5nSPfUAKQ94pQPnzNAsQGpALyNltl2iQXVmo
	 2QgJTHilpNUG6ZPv/bOa3DnhzGKDTqF6tVAPC7xhwdnfZpd3fv6n5nysPPAbSqKhBx
	 ElU75Rqi2wbYr2lxQcdn6qun+T1MiTiWlQ+mYQKKMhF4vMES9PfB8+29KbSb8SJfv5
	 vPnk+pEupgUx3AlM+aPd/oTb9d/nzKVhTcV80OGCp3SoEj2dMWQvcyvQ0tZzvXtE7u
	 R2BUTntshQ0Qw==
Content-Type: multipart/mixed; boundary="===============4659053659008186715=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45e008c5a0a1521235a9a5f593bab46cf21a73196c50ebcdb800d039d4cf97f3@mail.kernel.org>
In-Reply-To: <20260831063226.621309-2-chenyuan_fl@163.com>
References: <20260831063226.621309-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix queue/stack map u32 index overflow
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,chenyuan@kylinos.cn,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 07:13:30 +0000 (UTC)

--===============4659053659008186715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The queue/stack map addresses elements[] with the product of a u32
> head/tail index and value_size, but the storage itself is allocated in
> 64-bit arithmetic.  When max_entries * value_size reaches or exceeds
> U32_MAX, the product wraps and push/peek/pop operate on the wrong
> element, corrupting map data and leaking stale values to user space.

This isn't a bug, but would it read more precisely to say the product
wraps once it exceeds U32_MAX (at 2^32) rather than "reaches or exceeds
U32_MAX"?

A product of exactly U32_MAX is still represented exactly in u32 - the
wrap happens one byte later. The new check is deliberately more
conservative (rejecting when element storage would reach U32_MAX), so
the code is safe either way.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33365692838
--===============4659053659008186715==--
