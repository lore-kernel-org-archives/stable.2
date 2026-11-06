Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974975;
	b=RLr3Rr+evk3GKR/2Q2GjCkZ+2Kg7HX5JLCh8tm/r1qsiwtUkxzCxMYyCulHf5OjpJch/
	 lZ7zrBK4ZHKQo+azjGKkgi0gEhOaTysE0QpDshm/pkO7nlelG77/vzKYHedyvdaWhFvt7
	 MPgMIayhq1O8VnKALeigqf+RHk6BUddoIK7KyHBX2lcmOOmiSlbYQDDvXwxz4Mo8k6kbo
	 UE+8IcLIRwlDOFqgaVgz56m8VOAx3ppsAcuiHGAaeHp7dmGMWd+aYIdeJrtU0Xou1Q1Gg
	 R7CU4i9KljOYjPwPgH2YddMWDn+HJZy+TpszK9rs7kgltpf6TPxC8Ij4U8o+3XxcNbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974975;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=sB/ivWxLBx19IY7epzwn7EXeigYLxtl6ky09bUNMX1k=;
	b=Kk9LGNsowGycWM605D+6UxAHsHBR7xj2WEO6jejr2ldiXGPwkp4Aocf+EiwEE9zl6UCj
	 GhqCjZj45u9sW65Urp9I0pMvWWq+jdpmS9OrloECm3UrxArGUlqs58nLzEfg3NIcF6rtV
	 vLG2X0nBqOSrW9XuX/+US9xjYa15lMH8GU9FCvRIzSJ36/9RhcvH/DKqyi1HRr0IcH1uK
	 tsIP5pgVcT3ytclGLCDxpTuGwNCq/uJVrrWdP8yfdwaTFtk/1YcGJ6nBmFfrNJEv5HSdY
	 YnPLOwyBgr3vQ8VQNn/xmBWlAO2Na/Uv4G1q94D3LjQepzF+296J++C5J6xlRUxTERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/TTZpyR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7D606A326;
	Fri,  6 Nov 2026 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/TTZpyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61581F0089F;
	Fri,  6 Nov 2026 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974974;
	bh=sB/ivWxLBx19IY7epzwn7EXeigYLxtl6ky09bUNMX1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/TTZpyRbcugwuZf7q0QWy5BmaNUoDl2d2DYsR78mPBJzlKVhIpDCZrUgj/171jLp
	 qgaR+Hyroxe9oIvLjXeMri9AS1x5W3KeAtVFc2ZbH6OhJv2NLbJrWjYwMcGsIpNqIp
	 rbK5eZlIYifNEJChknybN1glNyzMxJ4NXX7T8iYhabPGsHBi3N2QFibHgIkywArGzr
	 DMGeRYsGd4CYA19J4/SleoRDO3cy6olTcQHXPke3ltTwCiaDt2i26xMOW6Or0WNdO0
	 liW61d3FiOJoKMKH902W4SXrAokTAY/uHRa6MiV0fmEF8KIOBql5gH1oHEQyzcw3ae
	 yHgpVhuQhWBjg==
Date: Fri, 6 Nov 2026 15:22:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 19/38] proc: resume readdir after the last name it
 returned
Message-ID: <20261106-salzkartoffel-definieren-anspielen-50df95db3caa@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-19-59422ed3e465@kernel.org>
 <CAG48ez2XEE+U4iyhxB6b2Zm88Mj6a36iQX1=X6NyJtB4o6hJ6Q@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2XEE+U4iyhxB6b2Zm88Mj6a36iQX1=X6NyJtB4o6hJ6Q@mail.gmail.com>

On Thu, 5 Nov 2026 17:44:23 +0100, Jann Horn wrote:
> On Mon, Nov 2, 2026 at 3:26 PM Christian Brauner <brauner@kernel.org> wrote:
> > [...]
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
> > [...]
>
> (For both this and the proc_sys version, you could instead do the
> cursor allocation at the start of readdir() so that you can return a
> proper error if it fails, but I guess it doesn't really matter and
> that would complicate the code a bit more...)

I did consider this and didn't think it was worth it. If we can allocate
a cursor we just start from the beginning.
