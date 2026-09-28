Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F94BB80D;
	Mon, 28 Sep 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601573; cv=none; b=F/JB250FrhJ20yqSXri87+jz6px/l4pFlVbBKryq7gbMHq7PqXblMBajG/mFSPHgTr43n/S1ENhLtaCl2gu6qS9G9Uy9MiuzcRrWDQd/F/lBUGudIwfAv/ClNDWO5tvrg0ckEMlQIfU5XYsBODMfmaBuzbmvytKbNXN9Qhv3hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601573; c=relaxed/simple;
	bh=Mpdwkx8kBD98y5ruq7HKQutfAfXpenUdUfk20v/I58o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6pQPRPpLgt+a7kc/VqidN/6Mjemmli4TKaRu96TLnMhc8dQ1FXqIfUh047zcvcfqo9v7BhG6Wjp84OsDiwB+lqYlHZsI/rMk7wmxGimTS47CnlK9FmtXfF1CDiBcttpsUvqptPGf8gcoGBcif9IQU+6Z9/EAkbsHD/4yeRiwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzGGAWUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzGGAWUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8161F000FF;
	Mon, 28 Sep 2026 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601572;
	bh=Mpdwkx8kBD98y5ruq7HKQutfAfXpenUdUfk20v/I58o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzGGAWUxHoid9WZ+h1LMRcp+pmlpxyHrVc+B5KmGyJpF7YahbNSAShFFwxiDwBWjq
	 GC41TiyAVF1oTV7DfUFmqjQEKNtMjmL4yD4lZWzg69NB9jVXiKh5m7Qjcfhec+JXHa
	 MnCfHUY+ETK5TQhO14DOGD4Ywm1dVHDRIZJ0PwMWrvAKhNhMkvUbtpIR47dLwxju0D
	 HLjssK/A40XSyBSGd1ryRXgbz8KN1xAgUGBDmiBY1ViXdd41QC5vQkYh95ean1A4eY
	 j/OCfgXkADNOv1j4zQIYZgv0IXvbM6jMaZd6712RB2FQ1LEPXu9QbXvcGb5NRBWHF2
	 6ztiwfmQReW/g==
From: Imre Kaloz <kaloz@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nsafran1217 <54966414+nsafran1217@users.noreply.github.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] sparc64: flush vmalloc ranges from the D-cache on map and unmap
Date: Mon, 28 Sep 2026 15:18:28 +0200
Message-ID: <20260928131828.1504-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1330dc280f59571c1f624ccada069b73cd8624a3.camel@itx.no>
References: <20260927105539.8742-1-kaloz@kernel.org> <20260927105539.8742-3-kaloz@kernel.org> <1330dc280f59571c1f624ccada069b73cd8624a3.camel@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Stian,

> Since the vmemmap has no aliases to flush, I suggest we skip
> anything outside vmalloc and module space, like this:

Thanks for chasing this down. Confirmed the path: dcache_size is
still 0 there, so the old code took the "exceeds cache size" branch
into flush_dcache_all() every time, and the mondo block PA is 0
until init_IRQ() runs, so the cross-call landed on physical address
0 instead of a real mondo queue. Skipping non-vmalloc/module
addresses is the right fix.

v2 with your check and your Tested-by follows.


Best,
Imre
