Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842626;
	b=StOkojiRBe/xJnNlx8HU/Vmbdgn5M2gx0IHRqKbnJ/6UaU0sPkzdAE77/3xwdBrW13mc
	 BCJDuVP0MVmOCe9COqDJvHLsZocsoli4rhpgsFjGStbNZwBsDBeRX49lnWCzTkAUQ+jt+
	 fQgR8vCvLelBz1lfCCwH1u3SA76VPjl6rUWpkbX4zt00BAx5mm651Xb6YnBnDJPJV6Yb7
	 0skTvw1VzVV4GoAUD6D7JsM0L9gE0Kywz6AY3Rde7Ro+3iy7YXPOBDM3vgyiJmzcKWarT
	 9KTLVrjmtRBhHz3GUCSXsBXNowH8Q5XkunHA+UD+mtpbqFOkFq30ho3KZMBN2yN1EkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SA2+HfHYPMGCbmJQui3IKYKhygxU8H4CQyQtWKnvlr0=;
	b=YQe5t77ltyrBSQ+pVNnaJI1Uwx4Zdc4RQb+frEhAaV0GZ/kxpHeHymRlukJ1Fo5QfUVi
	 SZIQy7/iVEyLrMwht8hjo9u4BfNT/deDvB9t+4+OzMoNOvG5jFg6WYQCyaHDWtwJUtZIx
	 qlNUU03mdHPrragpQIzPFWUbqUKGI9ekWNwO7G+g2+ELBm0jwoquUt6qxM8WGzFtOM0oI
	 OYwnPZXwIFmmTmMJIyRNKZPM3uBDB9MN7hy2thk+GHqTq8OagXkS47zeNKa1ea66dPcj7
	 rQAx6iZwexcqDc/CEaop5Yvd+uyumRt47KDonXRVJdN6Rni+PiT3skVrV/VaPyYp9xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLncX2Zs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41773606A31B;
	Thu,  5 Nov 2026 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLncX2Zs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4927F1F000C1;
	Thu,  5 Nov 2026 01:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793842625;
	bh=SA2+HfHYPMGCbmJQui3IKYKhygxU8H4CQyQtWKnvlr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLncX2Zs+2hBT1JWu+JG2f41a2GOjtb8ZMj/7XZz90p/SDCrpc6hRRabv19xKgK1e
	 90653Of7K/ZKdrCGmc/IpfESzxbWX/UPClFz605D6Wtg0Qw81+D2+8d+exoFHNzkjx
	 Q+nxPajPLOQRe/an1SJIlnOMNwuy98DfPnaw+WEhgjhqVXCjulg3OGZ4hFyLWoBf1F
	 4ikp1s+NBR17wwsL5/iEI8V0Tu8blmOXU9vBPo5ds+Soi1p+sdS+G7RkqAE/E4eB91
	 o8pV8kLqamj/HaSn2pp/HN9NA4uNvExfeubP/nBnhX7qE2tcsLGWaYYm3lDxBUHRDt
	 SAFdcAXtw8M1g==
From: SJ Park <sj@kernel.org>
To: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	jm5905938@gmail.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	error27@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals on scheme commit
Date: Wed,  4 Nov 2026 17:36:51 -0800
Message-ID: <20261105013653.88123-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9bb64032-09ce-4ddf-81cb-206bb85b9be3@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 4 Nov 2026 09:17:24 +0800 Wang Xiaolei <xiaoleiwangxiaolei@gmail.com> wrote:

> Hi SeongJae and Aveline
> 
>   Thank you both for the careful review.
> 
> I appreciate the clarification that DAMON simply executes what
> 
>   the user configured, and that this is more of an input validation
> 
> improvement than a bug fix. Perhaps I was too aggressive in framing
> 
> it as a bug.

Thank you for clarifying.  But my point is that this change might be just
unnecessary behavior change rather than an improvement.  What do you think?


Thanks,
SJ

[...]
