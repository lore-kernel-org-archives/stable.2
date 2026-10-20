Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532143;
	b=GZ/Jyt6ArQM+qVoxdzWhxI66p/UaJF3LiDbRH1O+iH2SqOguscILKXuJDzkFcna9Muzc
	 gg69epWZpY2n6HMa5bPiTnH0CThYt6YcaOVFsBFa1QmJdh7eNaE+tbhFYnqrq0RvutnwV
	 IE7LQMCdizNCp/Ro//XdE2tQICSR+Dezlq7k73nE6f1nF4tJeFuStrSmsf7GkUnoy32/m
	 Aed1WqmLd6SnXIzFTIxjnxP+Zr8r1i7LhyyD+s6CHbpwoJ1sN9E8xzW8MNVBztiJrHgTj
	 pBiwNord9xc6yYQ5w8NSsT8kQjBItIJHR9GdfNCnDk22kMfbquZEiKBdh740RIXRPSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532143;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rd+zet0+rAOB7xi96SurssfEUvqiUoY3MfuDj8KXQNw=;
	b=ys7YacAUTX5KxRFh+82f0lHS67DOTA63maqvLw/UU1Xc8OhZk9su6FbeXwPHKSwZvKtz
	 7yjDXXOfufw0ODSZA2wC/Znq1C+MAa8+IwCzTbdTFu0rWSEKRirlc9tEiH08cSHC/Zaqp
	 VXmAz+LTPGuCQe3rEjN5OxyuBEYIUD/PBIkIHjSKdl1k2ZmtOak02BYHK5LBUjIPQoBi0
	 uTaTaOvW+sxBREN/+JwZh7U2ftvj9TvS48s4WS6I98E+ALi1N2I7jWR7dc87PK+K2egjw
	 Z8lWIHaCjNtW8FVHdReSo7ezQI5Gjxc+rkKJowZ76GZUTvgNtpfex+U54C2Js3LqKFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=gZ9U9U+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09815606A31B;
	Tue, 20 Oct 2026 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=gZ9U9U+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8688A1F000C9;
	Tue, 20 Oct 2026 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792532142;
	bh=Rd+zet0+rAOB7xi96SurssfEUvqiUoY3MfuDj8KXQNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gZ9U9U+Zz2j+MTPm0gsrSeB6cDEfOsz4fp/G1tmBH52wNiAEyftA7YcD4A2oxtb+U
	 cptG5SDol0UcQckzheiE5y35hx+qZTj8t7tRDYX/QTZQkzkN7PB933qP9KMieo4+xJ
	 Q8cRhT3uWnG6si/H/clMk8x56NLbXHb4PtUzAMg4=
Date: Tue, 20 Oct 2026 14:35:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: arnd@arndb.de, tglx@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] compat: Avoid double rounding in times()
Message-Id: <20261020143542.37b34a0f8f43ed3655647343@linux-foundation.org>
In-Reply-To: <20261020210157.52057-1-dennylin0707@gmail.com>
References: <20261020210157.52057-1-dennylin0707@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 21:01:57 +0000 Hungyu Lin <dennylin0707@gmail.com> wrote:

> do_sys_times() already converts CPU time to USER_HZ ticks. The compat
> path converts each value back to jiffies before converting it to
> COMPAT_USER_HZ. This round trip can lose precision even when the two
> userspace rates match.
> 
> With HZ=250 and USER_HZ=COMPAT_USER_HZ=100, one user tick becomes two
> jiffies and then zero compat ticks. Every odd tick count loses one
> tick, so any of the four tms fields can underreport CPU time by an
> additional 10 ms.
> 
> Return the value directly when the native and compat units match. Keep
> the existing conversion for differing rates.

The fix looks correct. The compat times() path unnecessarily converts
CPU time from USER_HZ ticks to jiffies and back, losing precision.

I had $LLM model the userspace-visible results for tick counts 0 through
10,000. With HZ=250 and USER_HZ=COMPAT_USER_HZ=100, 5,000 values
underreport CPU time by 10 ms. The patch eliminates these errors
without changing the differing-rate case.

Thanks.
