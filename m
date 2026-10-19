Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443359;
	b=NmS0JbnQfcclldgTdvCXh2pv6wKiUyJdHQK1OLIBF36NqOMTNprHKTVXDk5u+6qahwuM
	 4lxGVm2wHPbKWNaJ4SulcgoQjbcF1Q2NkfQBGicgKc0llIHhDHC9gsLoVqVOXk6da/gic
	 Y4wJsI0h2AAp1FhqLgPQTeU7SCx1lcLms6Gb/YfbH4/BWMJgFZeL/Pz6t5AB5RhrRkV0I
	 aJcmdM9anpGjN+4QN2EaCABoUkpOqsEimsHSilMScIThGkfHP5Nw94M6knHhSeB81DLVr
	 MECnXQIi4KHE2OsxnvFfV/UgSRZfbm3te3nQtD7vAMnYzk+8FT+362NABfzVs47spbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m2REGhGe1RVFI0KGa0JdFY43LYwkhEZ7ABrNEvPFKOM=;
	b=fhcANT9n0zCXYRKroLOyL0LGKdKEEJrbLEnYJzxCC7NFqWkZOkw+MZh8PEjIveO9T0tp
	 NQ7lC7dhFjjigGCN65zjuHs7xMmRCrPENOPFr4WX7KmzQOEHEOEmBfQkHgyQsd6ou534W
	 ab/hBIygaLWied/CWq+63VBGEYHYCaOHD0v8oKS+IVqrTdS7dtEjHmf442obCdvr4Zg8O
	 PMR1GU95usX8n6s98bbBXWpvL8I94vbjf5J0cSB+HtE+MCz+VJI8iiG64W3tJdtKbq63y
	 vBnmDsMSs++IUsxoV2m+XxfEkOaysG+7ezL3ihUfjkkANT2gBE/6yRbJFhwJKmf4fsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExqFY1Iw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DF606A31B;
	Mon, 19 Oct 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExqFY1Iw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F12B1F000C8;
	Mon, 19 Oct 2026 20:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443359;
	bh=m2REGhGe1RVFI0KGa0JdFY43LYwkhEZ7ABrNEvPFKOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ExqFY1Iwf9PyTbHcefsDUuWoN/ZA+etC87YfJf/LutZXkbTmf4Vq2Biu1pRhdJx3j
	 52n2aNFh2dNUbWiijPskPSIKtghnVTPosAuWloGh+rNAaHET8MlkvG7cFKGJZuBVIW
	 z0NdAV2sXq5kMzhA84/PqtL7EiNabQ+N97P7h00CUijylIIvxo9QmtRBWeWtNVSaj/
	 Rg1QI0DKjyVNpbCAizL2x06N5j1amXF0VaMRrkE5iMGsnTzRWO60K9P/ImzZ+i9rWu
	 SLJcOX3xq97J10sjuKotYHz0trBtkESJjLN3FV0Cd0B9RbKa5bEqkDsZTcPtZJE2pF
	 EmEaajKx/os7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Abdul Wasey <w453y.me@gmail.com>
Subject: Re: [PATCH 6.12.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 16:55:35 -0400
Message-ID: <2026-10-19-1-daily-reply-0010-mptcp-ooo-fallback-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019111541.2063142-1-w453y.me@gmail.com>
References: <20261019111541.2063142-1-w453y.me@gmail.com>
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

> The 6.12.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
> fallback when OoO is present") put the out-of-order queue check
> in __mptcp_finish_join() instead of __mptcp_try_fallback().

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
