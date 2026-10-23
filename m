Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785780;
	b=1gd+DIIdGYiOvbFpafX7kNtsiN1fJ1nGQn3AqXH5Hb3XfWTT6Wr/966sGimiddxRa4GK
	 0CdBKznqx2hrwevxrE1HqimGR3rZVxntJ+BITxJpuNltlkDX4LuiZ87ICZk+6aLCyt59p
	 TOK+dgfgll6PJNV9LYaDpQDLg9/0295LSNSh264TPlfyAInIcseDSZK8CQNfMs30E/DpR
	 l7A1gtXAEBL5yfU0XupEckTqnz5WdxIpuUZavSAAVhhFhpmi5U3U5fjw0shwgR+fN8Zdj
	 ChA3uheTAZXLnGu59gjVkMTobyeIZHcJBkC8tQ/KQ6mOA2wZIHtpZ13gOPkQmRQ6PTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785780;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tY3/DeI69/zvryWxg/j2PhsOKS+siWw1e8E63ARHKWw=;
	b=UuYKlf5tbWAaePgB2q0GG1JI2+4Jrdbhy3u5po9WeTzjQ6OUw5RSEcsdQFe6aFMyn61L
	 96zZZYP51kF0JxMVgBu0W4FHBVp+AuktYHcw25aJf7QcQe66U62sBY1kgGLzXaQnb4qFR
	 Prv8F6ccALc9z6H6H0nmrcpAUzazNI4SXbcn69eHf/9hdSpRPXZIuP9Y4q91VCjsSKoPM
	 0eOA9uCmVf7ju2Ad9HLP5+R6kjoyF34KUrRJU0fb6OfDeoY9qvXW7+WBXvTHBbXbAYP1q
	 uv2Wp4yUcP1Jaq/tEB9Dw++8WNzJ57vTaGFQIzxeKIXao7wur1K0qOX+YhF7i8rizig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n7ZLOnm/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B8606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7ZLOnm/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C91F01829;
	Fri, 23 Oct 2026 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785779;
	bh=tY3/DeI69/zvryWxg/j2PhsOKS+siWw1e8E63ARHKWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n7ZLOnm/QmLlkiTMK/BSzxg+FLHU65R6rVKN6GjECTD35WVTpPJmdpjsx6GNPU0Xs
	 jgHBx2IMbmnl0h75EVonHsj3B0B9FhUhxeN9IBz23SBvj1h0D85/buRUWdS2gsSwZl
	 1Pefx61sxSS1NRL49eM06J0pEtUs6OB3KjPc9xA1pwcGuyVkcH0R/5KB3ylcnH/S6o
	 o1YbeG4gANRRuy99u9LAYB+eGTNsR3mmx2ed85UzmrfNi6IqPVvNBKgN3P0YCAbxhN
	 dNTgiilz1EnxW9qvxo2/926SqCz/lto8/biALXec0BHjNknKLRtpd/Tm31vNJ3l3u3
	 RJqX+tFOVlsow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 5.15.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Fri, 23 Oct 2026 16:02:40 -0400
Message-ID: <2026-10-23-1-daily-reply-0004-scsi-st-uaf-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021155526.2740230-1-loberman@redhat.com>
References: <20261021155526.2740230-1-loberman@redhat.com>
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

> st_remove() drops the probe reference on the scsi_tape with kref_put()
> and only afterwards removes its index from st_index_idr. If that was the
> last reference, scsi_tape_release() frees the structure while it is
> still published in the idr.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
