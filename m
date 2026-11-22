Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795391405;
	b=C10QYc+rqiJbEikYqCCf7+qniua2AuD6k59q1Nvoo7eZTuNouPSUm/NqPsVSoFfsUux1
	 IsN9Jj6aiMN0E6DIhxssVydR+Tp70pM1S8Fiyxc1rpGPPyR1aECGAWJIz5Qz8TAKQBkgc
	 x5sVaN2VOZOIoEECEGi1lgJXAHm87M/wmadnZrNX3Irr7O7GrAMPxFi0yh1SxhdDIYPrX
	 xq4dS3ZKnm2iDOYHwMVx1pBLwwoZgicRenk0bQvclyckvzx8GzMmMQPfR/zqYHmEX59K/
	 +6QsdkvAINjJOr/WvUslGbt7ch2U6Py0fBlnw2ACCraLnzFeSQ4MnJZJucI5CbEtQPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795391405;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+t697FbN3YH1ito+3RCbQXZtdIEnIJ+uIHE/maxp22Q=;
	b=43cjEeBaat1bFSVy6uPmb0Env+aHXoNY2kTu/ogvESV8E49M2G+99uLoFcWkdLuCccql
	 fvypWQQDgo1EHw22Zkp5dx+V+pXg4wh5twg3CIBfKqH2dQkiEERDgZDJkaszhS3LUPzcQ
	 cztRxGc0py/g3MtWSHZLvHg/Pk10iKhOJwaItbBdA8H+EJiHnlyTnxqCxceoRA6NNkk+H
	 D6wMokavL07ImxBGOZLvq2M0Vn6Wav9HfCfFFVzX3ttcGZ90p/ReLVKLv8GokAvnhWDAj
	 rkmyFoWD6siD+CJCkgWORMue9hiTUUyHmDA2jkO8GMpKgGYc9Dx6DCeVfIjKX5ArWmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxq6GTb2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B4606A31E;
	Sun, 22 Nov 2026 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxq6GTb2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658FA1F000C0;
	Sun, 22 Nov 2026 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795391403;
	bh=+t697FbN3YH1ito+3RCbQXZtdIEnIJ+uIHE/maxp22Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxq6GTb2xnMBm4ZECuEMDIPVa7RuAdc0BWBCNGRF6IOKhulrMAl6UayEDSf/ZjRFT
	 u69o//1LLGwNQZRBYKxfe8BtLoq7YB0nVB+P/8zwyiTITuqxr7+yd4tUcUdIHbOyqg
	 3gMwSsWbSIOepxk7a4yj85b8Gz/by/YgJIdCPQcV2VxKrh69k/7pF1fzmbBE+Mxn1S
	 mCxRIZrEZoFMubx+unCi/tsnK3igkWPJv7iyzza6hd6qtcHzl4KZmo/p2/KD6673Nq
	 OTXWlljwt7jHsaTKUgTWeV33GzE9QgGGlIiw7HsXBXPLazxzcjo/qiXkqRS9XtxsKY
	 yQhrisJcxsRRw==
From: SJ Park <sj@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Sun, 22 Nov 2026 15:49:55 -0800
Message-ID: <20261122234956.22710-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122234633.89529-1-evanfengff@gmail.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Nov 2026 15:46:32 -0800 Yifan Feng <evanfengff@gmail.com> wrote:

> On Sat, 21 Nov 2026 17:22:22 -0800 SJ Park <sj@kernel.org> wrote:
> 
> [...]
> > > Do not restore
> > > it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
> > > the scheme would stay off.
> >
> > Is this really necessary?  If not, I'd prefer restoring it always for
> > simplicity.
> 
> Thanks for the quick review.
> 
> I think it is needed.  With DAMOS_WMARK_NONE, damos_wmark_wait_us()
> returns 0 before it touches 'activated'.  So if the scheme is
> deactivated when the metric is changed to none, nothing activates it
> again.

Makes sense, thank you for clarifying this.

> 
> I tried restoring it always.  I deactivated a scheme by the watermarks
> (free memory rate above high), then set the metric to none and
> committed.  After that update_schemes_tried_regions never returned on
> my test kernel (it does not have the damos_walk() fix yet).  With the
> check, the scheme is applied again after the commit.
> 
> Thanks,
> Yifan
> 


Thanks,
SJ
