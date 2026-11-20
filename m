Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186249;
	b=dnZXfv9bzdbNPHNwwrETqBF6+LTcLQgLdHichr32aJvtRomOx4IPD4BcSZHVElWpb2Ub
	 IcDc/Orla3LyMV94ahHUvbrxrbrjnpBhw902jlqqOEpjc2D1Cn/7resM+Qn5TnJR+ixV6
	 Fb8/9VPKLRzsI8uHH+foxcGproaW5kOr6m0bq2NiFj6Wx/8D3rafZdbzk+qw5T9cNSrE2
	 6+l8f0ESCjtqtq7m2QTwMhLdDix8ZnO2D8pO8HnzjM46zya6vD+QfzW0UwATRuG/a56t5
	 NHtNy9Glwx5zvCwOMH1Kr2o1pYD0//pE8cF6c03wsWSOAFfli8oQd/rXs4zg0AbVIWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186249;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/B7HjCT8zRaaT9iQcwZVpGkgJCmKDQJosUGMwRG1i8U=;
	b=fVoVfgMkuAEciW1woDe09N87Wrc0QI63ClLGFp234yI3ZbmrQUSsaLGXuHdZHg/4Jg2B
	 43JUHU5kYjtQcO/KRJbZOEnUdHg2P7MA1DJHngdFu/AiqKxx346qSauXtQUp2Ef0hFHTQ
	 0sx0/8HueWrh1lL77Udke3JbmOYJyxZwcUNZFSyTzyjRb2m/QYQHSWtZT8x0Lmjby2br2
	 ac2JeGa1wxJKHMufrxlPgzCI0Q+tghl012JtD9RnpkJ+Ch/p5RmT2AJItA/n+QPpMgAIe
	 onhbXhok8roSeIvWehXNzC1+SDCBbigbWkg7vLlqtsRgOI6kx8vEubq6kbg+z2UmCYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IcD4/b7o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0DEF606A320;
	Fri, 20 Nov 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcD4/b7o
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2319C1F000C4;
	Fri, 20 Nov 2026 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186248;
	bh=/B7HjCT8zRaaT9iQcwZVpGkgJCmKDQJosUGMwRG1i8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IcD4/b7oZF2HqxggFNCmSMtsACUSK+J9mUi8D99Ls+ZGB51fN2s2nIiC4nHKbmVDb
	 kHJEoiyWqLDitvdJse/hIXLaz3a3WGYuWJZ78MOBAuctHZm4slEzWI/sJw7smWqO3V
	 vAS5A60tHujvSs3xv4Q2B9yMxxAviRaFW9Dje/2iGYykt/4vjFMoo5fimDxik5eJxv
	 +APYb40W9VpbkJY+AgopSzNNxEpaKkx/pljj8lY2oH1034FOjK/QWJsrJfXiSAYPzj
	 Ak1FuUznKyt4EIdUsBHt0jM2mytGAvY89ktbkCPfklWoOnGk45JBjsRU1arLdxf/Yl
	 UUQyTOiozfaeQ==
Date: Fri, 20 Nov 2026 16:50:44 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: Track the response read position internally
Message-ID: <awBeRE2c7UQH8SfV@kernel.org>
References: <20261120121614.978396-1-rmustafin@cloudlinux.com>
 <20261120121614.978396-2-rmustafin@cloudlinux.com>
 <awA8o4oIq81a7J1z@kernel.org>
 <CAG6=z5tzc8DG-7gU03mKs1JxqEzUULwBinfHKtYWyPycKkG6mA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG6=z5tzc8DG-7gU03mKs1JxqEzUULwBinfHKtYWyPycKkG6mA@mail.gmail.com>

On Fri, Nov 20, 2026 at 09:28:53PM +0700, Rustam Mustafin wrote:
> On Fri, Nov 20, 2026 at 7:27 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Fri, Nov 20, 2026 at 07:16:13PM +0700, Rustam Mustafin wrote:
> [...]
> > So... why does not this block uring? You are implementing a feature
> > as a bug fix, or so that it appears.
> 
> Patch 1 also fixes a plain read() racing a write() (the second trace),
> which does not involve io_uring, so blocking io_uring alone would not
> cover it. Patch 1 is small, so it might be easier to backport.
> 
> The io_uring block is posted on top of this series:
> https://lore.kernel.org/all/20261120142116.1630010-1-rmustafin@cloudlinux.com/
> 
> It depends on this series, because the new ->read_iter() would let
> vfs_iter_read() callers such as Coda reach tpm_common_read() with
> their own offset.

My mishap.

Sorry. I'll look into this soon.

> 
> Br,
> Rustam

Br, Jarkko
