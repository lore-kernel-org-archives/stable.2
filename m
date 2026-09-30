Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3014E06CB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778884; cv=none; b=FVglXPr/f3mQ2lX7utDqIQyS2NJ1qdXRnmsz1uXDkFAF4CFZ6CjHJM6GKbJqU6WK0bpQ6J8TYMyA57TyklG1SNgeRHmwj9Ua4Sy6SmOErmchHHxDo6l1FohGBH2eu6SDGoCXE0sv29ASjp6eDxnXXPfdLLx/LzF4ugE2EVG89zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778884; c=relaxed/simple;
	bh=dpi5FuofdGs2KC0e7Onv0Ee4U3xJJPwiyRHSL+LWSkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivzLArljCdLMWtrJ5czJXVcahqrz+I+DKG9A77FkN0FsiX0vULUCaQUEJP03MJ/h49Oi4VJUevG9RMInaEqOsGR10HMuhFEO1Ne+ez8ILXkvL0TReF/vW1UmssiZdi/6Q4cTtlavrmxQl6MNyE4UqAwUp41X/9Uu3Q8WmI2U1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka+fQutY; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka+fQutY"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso41507935e9.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790778871; x=1791383671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WbMv3YGX7nMfLppnaRbgidczcJaf5jYeQSivTTiMGs=;
        b=ka+fQutY8rrtx120UsgquEJDw/7LVnuaihjyyewP52akXkZCj3zGinEK8h6z1Ehuql
         +/cUTw9gqOIxUGNqLlGVJuDsR/UQ8I0X/2YbrKHYO08Tv84hL/rWfBQ+s1D8eLR0Pbmp
         0E07mvGSDUsEbRvQ5rLtcW1zvLfXdSPCrFaU7VX4OriL3vZ1Hzq2UmuQ+NMYv+mdCokH
         Oelh1i0B2sj9iHCXc7UHc882lbGWi69B65AXYEkER0x0iwfRbBU8yRJ0jZCPhbKMeV+O
         iEw0HgdWXpej5A+8NGKwgag2gY2k4wiPn3i2/+x7RE7DoIcjAnPU9PgNwK/xeK/AMGHK
         oukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778871; x=1791383671;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WbMv3YGX7nMfLppnaRbgidczcJaf5jYeQSivTTiMGs=;
        b=gFUk2kLaPT8ItLjdeOtLss2owsZcbsuPHw9gvbLFgFIXIbC2xdHgMV9S8c86x7JNEU
         fVfzpC6LqRAnDYe0wz0WzL9QduNsOINGlLxqxC/LJfM+6vX8HNcNn9/e8F8VsgtYOAvy
         8/E4Q6jsP706CL9PEqzYuh/kp45BzqznL+RiKOsmC67p0BDVcR1bCg0sE3zcR8wpGq6D
         maeXS9Ysd3ad2DqDlRVEw/6TqekVCsHOamRk0N+NZKjSumdoigVBM7SbMvRYl6tUl5/O
         WSxvxaoi1i7qGTomE6y4fqxDAxG9dpGi0YCBVogtPLv3Wd8QUKfAs6BSZNO6GvfVRc8T
         VEYA==
X-Forwarded-Encrypted: i=1; AKwUvBz0+A5q2XIubULIRl3zcrqU1U2p8i9HWg558sgHZXzz8n6o+1Xgu5ICrnWxcYSBtw5IcNnBfUw=@vger.kernel.org
X-Gm-Message-State: AFuF++nWZth/IYp8T063UJEopqr5DIK60+DXKZzTRH0z20xT0C865De0
	DM+EQvNEsqsUxNBGONvTa/3eX5a37BZyi95QZkxA2rli9ItDFvBTHzwD
X-Gm-Gg: AYBFou0fMPc9s7NKh48xkHb4RIYs6qJa/kkC/J31Ab2umlW/WNWuPHg8kL/z0hlxwTH
	aFB1uJgmj6hp9DzlnFF02JUEj3mwtWtuQt38pNEp2vYWGtxKC3om2TL56a2MU5dNPJEpfoZPvaH
	AglkmD+PqW24/Xoqg7c+TgtCbMR8aPa1o6N5aqqogfeZcZmEuwEffjJSQZ4yH5QcYK7WAunbKJn
	7nW1IGqCodDw5Ka2PFz9ru4wdN8s1QHJUF77doccIRGqpwlGkNr3A3pkgXnfLucPT0o0kJjsqj2
	gVFupq7m4BFvbWXHAsK9O445taKGy91faI2Z+1TqY9xloOLk1UKXAV4KAQ19NNq9pUfbnISBco+
	D+L3+KL095btjSrqE179K29l+pWEPrRCYOuqkBWXGZcgwfh+dIsJ7BNm/edq1L2hSZ3w052EUNF
	jsMFXz/ZC3XbzubI2VXs00ZTeeaxmB35nwgg8VnfTZde+hwGt403GzW7HZrdGuhUWjYZNYtIeR1
	QfZN83pbyLydZR9WKtyPmaOuqV3gJxtKWqgOjK/aUMaBgWaOc4OL/A=
X-Received: by 2002:a05:600c:1c10:b0:4a0:168f:d962 with SMTP id 5b1f17b1804b1-4a01ad8f2eamr34710865e9.3.1790778871080;
        Wed, 30 Sep 2026 07:34:31 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([80.87.19.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01e42ad94sm4577045e9.1.2026.09.30.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:34:30 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:34:21 +0100
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: bindings: fix VM_MAYSHARE blocklist entry
Message-ID: <ar0d7Xl0py6plis3@C422HJQPQG-Fractile>
References: <20260930123645.302318-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930123645.302318-1-ojeda@kernel.org>

On Wed, Sep 30, 2026 at 02:36:45PM +0200, Miguel Ojeda wrote:
> Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") added constant helpers
> for the VMA flags and blocklist entries to suppress their direct bindings.
> However, it listed VM_MAYEXEC twice and omitted VM_MAYSHARE.
> 
> Thus fix it.
> 
> Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Nice catch!

Reviewed-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
