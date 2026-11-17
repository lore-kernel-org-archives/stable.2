Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884086;
	b=43/v0/n4RDetDxRjpSdJTpnCGeDOtaJZnIvhg9nAkrdA0eyHLWpcCDVDVTA2wCz4xYJy
	 Wba2fbi9wE/skys0KqMJF6iASz4NZynmZ7Q+73rSRYJZurbSTXLHHdTP2ccEyzCh9YvHA
	 tYVDbOs0qvxmKY4Fu+7YHSAIcSuYMeTcw5Ro+A6EWSbrI8Si5mqla3HYal1xWzutufGlz
	 O8892g/4DnhfjpcSbu84GTKbDzaomOBSqH43u4ZGGNHA+l2XFdCCUiLouP+01V4PG3Kly
	 v6xOYXrNx3V5eKWrkbpHt+CsIeyrqzsxAvM7i5Qi0VG58ETHvKx2aS9Hy0ZCSZ4x57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9mRXkzBGeilyrtl2xQUNu92A5sXxTwz+7Vog/x6aTi0=;
	b=uIjo0428i0wqbTwnFw0EkxZNXerBK+9EjNNRwX65Ln4lZqIpIFIwMw1gmtpftW50c7Zi
	 1LWjT4OuMjbdqp6BlPCBKWzUnAAX7te4nZriMqr75RmDHkCY4bgEiQkiRwy9dkATBA8gT
	 RS2nwIkVg9EDElFx+9cfz8e52TrYnWKbkbg8u6bdwXnY5LF8P24gpDgjyTKf7Uib1RS8U
	 qDHNfthAgZAH+rafM1gB0wQh05gkG5L2/E/pTvtgTFlrjgtukLlykTwKZRgkLbboNjaip
	 ugpS1hbq2mSSzKgWK59HVG2rbJIFoxni0FE3HAzY8k6/Qzo9GHWU8d+iNkyz8tVvYzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gad53SSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B1606A31C;
	Tue, 17 Nov 2026 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gad53SSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78601F000C4;
	Tue, 17 Nov 2026 02:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884086;
	bh=9mRXkzBGeilyrtl2xQUNu92A5sXxTwz+7Vog/x6aTi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gad53SSFAtTxw94ku7z15FEUFg5Onmufsy0VAucpxVCdX3w7K3NAYLbg+FPLgIPxp
	 4Up27XxYoinD6nvY8WRfyZNOwUbucJ5OWXY2ILMvsrj/KtG/iOJnE7yuaJ+IKjsa86
	 jvPSSgVUQfRfF5H/XfxonQtaWnWt6azhfilx9QNv+Pzt2Z+cg4LAKyRRKRM/zMjNCh
	 sVU2OCeaOJrkyhC6R5uTPf8C1WoIRDq0uy+jek3zKY5qo7UqgsSQBaSU/ly9n218yN
	 2h66TFtuW85r6m27izN/vWFql6EBfMywuwDSEclVqHscLWa9CAG7r8AYoXlWet9KjP
	 G/tVnaP4aPMZg==
From: SJ Park <sj@kernel.org>
To: Mark Polyakov <mark@thundercompute.com>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: Backport request for 6.12.y: mm/damon/reclaim: use parameter context correctly
Date: Mon, 16 Nov 2026 18:54:28 -0800
Message-ID: <20261117025429.117165-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com>
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

On Mon, 16 Nov 2026 18:39:08 -0800 Mark Polyakov <mark@thundercompute.com> wrote:

> Hi, would appreciate a backport to 6.12.y of the commit
> fed48693bdfeca666f7536ba88a05e9a4e5523b6 (mm/damon/reclaim: use
> parameter context correctly,
> https://git.kernel.org/torvalds/c/fed48693bdfeca666f7536ba88a05e9a4e5523b6).
> It seems 6.12 gets backports of most DAMON fixes but this one must
> have slipped through.
> 
> We've run into the issue fixed by the commit on 6.12.115: A guest VM
> with DAMON_RECLAIM enabled but no reclamation occurred. After
> backporting this fix ourselves, it started reclaiming.

Thank you for this issue report and requesting backport of the fix!

I just posted [1] the fix for 6.12.y.  I mentioned you on the comment of the
patch, but forgot Cc-ing you, sorry.  Please use the lore link to review.
Also, let me know if I did anything wrong while doing the porting.

[1] https://lore.kernel.org/20261117025144.117100-1-sj@kernel.org


Thanks,
SJ

[...]
