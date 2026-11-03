Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717607;
	b=ABjMdAr2fyGZS3jTfu4/VHZTfeiAhB9qnh3G9muJ8BSZtYNPv5BpYEoOmZtv/sDGgGYc
	 2Qd4hwEMig5bv/5fruopZGK8/dhrYy/XM2qaATxMbvpGmHe/d7IDGdg0oF1q7mvt1bHTS
	 don/ljGcgpXppoSRjj2afSY/E6l6VunBeXaiC5OqCbICBGuk779DSGowhkkbLJnLzmknx
	 qGjBqobwVOBeoi8nIJuBQeSQ2Ok9PVWqnDnLtHaNo+V2db45X1N5kgz2C6zEpBiYnPM8H
	 LsRm/FYwPHSC1QPHDh/ozPaDmmUXfMR5HN8JIvkYr6HfkThSYUQldZeux+ILuJ7h89Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lN6/UyH0yVLzdc/bLBgkSFZGjwZsixPue/fM7Y5QUY0=;
	b=yuVQjsQreIbTUX/mntT6pRwZql55neMS7Jc2QVAjaR/1tutxYyGeqRtZnPiB+Jzd8kXP
	 L3ukqvlxV1e4Ycy8+Gi67O6JUN5IBSq/783Kqz0WI2Trjo1veYP0wqpKC5QL3pqKskIZt
	 Xb+AW2ZuHQur/AtELobR4tEC5U7t41pNn/qzoLWPZYG90QEgSDxiWopm9W7O29nEOvjvt
	 yYElGzfklZLSVFmGWoRZC9wZ/CrZwHak7Qa9q3v+eMnsC0tdEKJPEu5Sp6Dmq2+vdxb/z
	 p8HIuY3Zq6UTxeUFWCWqEhb5PMd/JrJm7Wcga9W80ow230PRGuTmWMz3mlfjf0b8qpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYYdTd3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3B606D2C8;
	Tue,  3 Nov 2026 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYYdTd3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A981F000C1;
	Tue,  3 Nov 2026 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717606;
	bh=lN6/UyH0yVLzdc/bLBgkSFZGjwZsixPue/fM7Y5QUY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYYdTd3yhf0Ql88uloJlEQjPcAm7611vv1CFkAKOfqBFmbVpxeh9LsD99MWBK+VzC
	 OTpRXC1CN6sr6UupfqPB8Dy0keYYoMs5/g26kF6OFpSZIZqFJHwm8MO9VOqRGFgDCg
	 VVLMCUILiD+R0uZKD3Hwgs3o5X5av5i/QHt7hxHnQBzzLKlzTu84Ay+D0919U8SpMW
	 M2K9awzSTViN8Gyyn/rFkUVHJRhLMOhsF9vGZb46MZvW0M87tljXxuJyOwxO7LL4MP
	 yAfsdutiziA+UHsCoG/mAvMCElgOWGh8Q9yykv/lyasFQY609cIEUIHGXNLfj2A+Dt
	 QrbTm6eiwKQjQ==
From: SJ Park <sj@kernel.org>
To: "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com>
Cc: SJ Park <sj@kernel.org>,
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
Date: Tue,  3 Nov 2026 06:53:19 -0800
Message-ID: <20261103145319.88120-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
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

On Tue,  3 Nov 2026 18:54:18 +0800 "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com> wrote:

> DAMOS schemes accept access pattern bounds with min > max (e.g.
> min_sz_region > max_sz_region).  No input path validates the bounds:
> damon_new_scheme() stores the pattern as is, and the sysfs ul_range
> stores are plain kstrtoul().
> 
> At runtime __damos_valid_target() evaluates "min <= x <= max" for each
> of the three pattern dimensions.  A reversed interval is an empty set,
> so every region fails the check and the scheme silently never matches
> anything: nr_tried stays zero forever while the kdamond keeps running
> normally.
> 
> With such a reversed interval, damo starts normally (rc=0, kdamond
> state=on), but nr_tried and nr_applied stay zero forever and the target
> RSS does not drop.
> 
> The same holds for the watermarks thresholds, which must be monotonic
> (low <= mid <= high).
> 
> Validate the access pattern and watermarks at the beginning of
> damos_commit(), through which both new schemes (damo start) and online
> updates (damo tune) pass.

The documentation is not explicitly mentioning about the inputs (min > max and
non-monotonic watermarks).  But I was thinking it is not really difficult to
infer this behavior based on the existing document.

If my understanding of the documentation is not wrong, I find no problem at
accepting the inputs and just behave as documented.  It might look silly, but
who knows the users have a creative reason to do that?  As long as it is not
causing a harm, just supporting it is better for both users and code
maintainability, in my humble opinion.

Pleae let me know if I am missing something.


Thanks,
SJ

[...]
