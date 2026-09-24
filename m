Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DB1F91F6;
	Thu, 24 Sep 2026 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209276; cv=none; b=RXtUTjGeEYv7TIDpIlvfD9BFJq6gRG9FVaX2w0GZ3qN5XnJUkWQARFbmQiW04ijRxrf8UezFl69VzDdb0lACiTxby9V73Gbn90UMklEjc2x+lFDo4lalbJNtHu0JOm5UJJzI8jUucYP/vaItVYubwZecadOkyOdCDPIK+CfFkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209276; c=relaxed/simple;
	bh=jloYy6OWbZKwThUxrJwanE/7tsSMsbIJG/jYfBKPJGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhSpHqib5qR1iKGyLQcyYocmA/CuPU7/Vmi20XI4B0THyIUC5rwcr89BOev1OPZrU3rPab10rJGt5fcYK660QAWcaA566Y2y2FdZyDPrYLd42St9X3LUZzwma21db4WtFhT+CHkDnbrvfU0DxjhA9HneZ4Aygh8RA1KepOSbSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l30yGQZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l30yGQZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477C81F00899;
	Thu, 24 Sep 2026 00:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209275;
	bh=ffV7ITjQvf7WWD9UeUNYqSQEfV7p3TejrmVhisf0nbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l30yGQZhdeZ4rKamBz2ZbfrGkfDvT7mXY1QCHJjAKFVwx/ViHLMTOzzZ2nBF2ekBy
	 4Sy9M7pLQXvi4HGR6lqVQP6dLZOTh82vrKrhCkwXZTx5rPERKObLc0i+tnpmUCIPes
	 kqtFX7aLchqabDzjfdmWsnvf1gdPGdMjlJQhDHHeWvNcdh+4jjRHvsetMtO0xEZ01T
	 FesojETm/Oh8Su2PYp+5v2T4ugG1a6iobP8IdI3zTWrZCj+5BUEkvB/X3ReK2g4Og8
	 TPzczX2tv4oKWloeWME+oNlFvJdGGdtiqN6so3fZa1HJoTwUF7Nkkfw9lf0DokkRuL
	 PUSa51AUeig+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH 6.1.y] bpf: bpf_sk_storage: Fix invalid wait context lockdep report
Date: Wed, 23 Sep 2026 20:20:58 -0400
Message-ID: <2026-09-23-daily-reply-0009-re-bpf-sk-storage-invalid-wait-context-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922195539.26679-1-artem@trailofbits.com>
References: <20260922195539.26679-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: retain the pre-reuse_now unlink/free API while
>   moving the charged element allocation outside local_storage->lock. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
