Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822737;
	b=ukuBZ4xpphiZ055G1e2kWz9zCzIIx5iz/kGj/FiITtMUp4OslVGqkFW4xe+DbNcQxJ+U
	 PVrytEiCaNle3Wwo/3+58vs35XyUiijszrNlXALRFPMw31YQrvl/lmyqf1kjdWk8Buhia
	 0XppHsVyiMGRgyVcBJC3a5nX4KkN0il7kFWV6YzKG/A7rG2tm7NzS/pmZlKN8l0s8jFPn
	 JsuQnGJSaeMEH5jIBYr5NAlbTczQLKUYOw4OBYru/DlNU3ClLZ6E73m5sT1l+gCbOUE9M
	 UqKO+oJqzUdR0aigHAibHLrwIVKz/7DA5cKcgNfjjFguzz8pPFYvgvEMY9j7OPRO22A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822737;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lV/V3JThA3m22CZXnYSHM7ZcBeBc2uJ8CXIi8d53QrQ=;
	b=Rs6UNfgNaEMsXlo0Y8plwOvRKL0xi6Johv4XiO4Ysj3hFnW/9pOk1BEA3l9cWF3BjcIU
	 TqJboLc19++Cv4bVBFt1znvc/1dyKe91NL9JlsqX4a1+ahYdfTqRifc2s58t9JKkbealq
	 ZMB8/8cegzUpBNIRMuXZr7hiievN3asTvsWCQnCI9Rvkbc+kouvloWlrOZytqkGdHCpPK
	 o1kgslVxxhIfEGWbJJUHFQjpvS5pIh1KFgUkxyWfv964ettN4e/pEOt+NuDK3x+NsDo60
	 8dGbDsx2rI4SZcaAVJiLh3BWTP85Krhb+p3DsJ/rNlq1FAeqIJmWnTz3OVRkPfG7ssA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rEgx5HEL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20B606A337;
	Mon, 16 Nov 2026 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rEgx5HEL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617011F000C5;
	Mon, 16 Nov 2026 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794822736;
	bh=lV/V3JThA3m22CZXnYSHM7ZcBeBc2uJ8CXIi8d53QrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rEgx5HELzO8ju4Ra3rBCOLzsmDVyjr5a+2yiZArT2c64AkreukuoDaaHI3uMvceL3
	 HdFtbviJzQY+qA7AU4YACpFgMU8Du3aFF7ZWj3Flk+MgBtCmNgJJVlsgfW/O3iaSln
	 6P4uG9tW/a1DxsFf1RLsIgBGwqHbJedgzQxFYARg=
Date: Mon, 16 Nov 2026 10:52:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <2026111605-deskbound-clobber-a4a1@gregkh>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
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
In-Reply-To: <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>

On Sat, Nov 14, 2026 at 11:12:40AM -0700, Jens Axboe wrote:
> On 11/14/26 10:42 AM, Sasha Levin wrote:
> > On 2026-11-13, dev@rebasedinc.com wrote:
> >> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
> > 
> > Queued for 6.18 and 6.12, thanks.
> 
> Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
> Getting a little tired of chasing these.

Now rejected, sorry about that.
