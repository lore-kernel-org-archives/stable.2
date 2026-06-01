Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987932ED40
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291668; cv=none; b=Y23aHqFqa5I8H7iJks8jZuTRlGVwib6cbd/ZWhS+gb3b5KAYne2GB8EXltErolGzPmn3yx3aMSEQVgKvMCIYT+X9wSUe+w0ZBsChFvzZd8juqEq2ICmTlsHytkV012dgGrB6y5p3cJlRgq6KpLEI6dMltlepkvvmAAQAsPzeaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291668; c=relaxed/simple;
	bh=fCdzHVcZDhDh6SWNC9dgzMUJjZKOzYY3G2zn8sV+498=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3H0v/OjZLyI9R6944SbE7u6lMUYr0t5PatD0JLMt8lJqnkr9YgRJAG1Q0AX0ifTdo+/GrAI4LDcDa4FRnf513Bb8SAS/JL0RBNd5MMd0KwvHI07j6cQNt+yBb83gL44SZ9EUUvpGt2wT7xAV6H2AcjRDAusUTeobD5EN2f1xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrDsGu1O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrDsGu1O"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf1f074a12so29575615ad.0
        for <stable@vger.kernel.org>; Sun, 31 May 2026 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780291667; x=1780896467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouIO0zeZKWepmc4HQsvg0VN69/QHmiQ+jY/+kkRsAoo=;
        b=VrDsGu1OkAGiMPeiJGldzkoRA8+O6Chous83DwetnfkQOlREy3G3+soB10FRnyIWR1
         EsmX0am5HS9qVlSh7MFMbsUaoavGAjRClGTNtJ0gmbvxInlPQsV6t2+C7FulNj8US0gY
         j9WyGAkoN1IKjU1jpg+TH+fxGfjuDrtzCK90bNKokXU8J3DZaxs9R34dudj8BQll81XP
         0Yh3bYlTc3qVOdr37pqVMBe2uX6jwDC4RPgHxVqsQNrESG+5Ld+eU0STZLLgaNqqzQYB
         TqgOedrq3N6vFB7lRI8jJu5B9gyrULVvdXLOJlcwWiMZWwzYo9ffaOY4527GPsohOXH7
         SnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780291667; x=1780896467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouIO0zeZKWepmc4HQsvg0VN69/QHmiQ+jY/+kkRsAoo=;
        b=spgx2HAbOXKoKNFqpdGqh0n2+b9mBrV0Ab7rpqon5rK/8nj2tTXrD+WQjkxhuX6GE9
         IXdoPO2fUO4J0bdq1Fguqh60dy3JZQFNKRTjIBncL+rENlS5GRejewfcuBCEqA55EKU+
         uB1PP+7VFu34Fs1E5YfekH3D2bqBsxAPSeQfJzKD6X/Eo2mpeSqJekOEiv9UZRG45dsE
         400DSPr3BBqUNvDVAb+ot7G0QGAvMM0WiBkkYZS0EcWmpV0890eOrTcapMz6jxFxe+Vr
         64QMxZhMQXt/RZXFWKtnwjIcC7NEO0tUUUOzV0wjOOd/s8DOoQiIh7uVLrAuCYD4jjdw
         3klg==
X-Forwarded-Encrypted: i=1; AFNElJ/TRMtDLOhi5fDwxbr0vWAOmpLuHGU6JV6OmMRh9PR4W4bCZN6A0RStYD7C4GsxrQTK0SUIMas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfX2JiEmKC9buNYfZhwTCg0ITeWmSdkhdgRFpoqaoFA4AewNk
	GPmKlcQa/jKROpG59ZxFJFZKmJltucbhc49neodiBJMlmht6EOI1PhotNDYHf91mO80=
X-Gm-Gg: Acq92OGcvm1Hvj/3YWgARwGYkbIJ8S3cR7AxlbjtY8foq26+98TBv6rZA49R1PtSNdj
	XZcJJafqB+gmD4URSLtTbJxmewb3TCYbPAZUZNGa9rQsiPjug75JkgJDIZQRAicQcn5p+NgTNA3
	met3uDQo2tBfn0+QV3aq1/hGQaZfSku5x74ZZxlzq1s+r8b+qkeKKWHIh2JiZnKTbvOVm+K4T9u
	uym6uD+5H3dxwThdh1ILr6Jd/QD61zDE465Vqe/pFDZilschrn23KpmZSL60iy2XhZ/uNZ6tYZv
	7cg6a/pwzd42I/RhYOo5kjDZJ87CwEE4nfCDHtkkFsklBS2OZV4CXz6WiMddRSHbJHwBH1pRGUK
	JvTlj6a6swGippkm2eaJywJlibT4gP4Ztol+KkJ4yvUpugP11toh4+BLFXAfJ6tzlyUZcT08a7W
	wbSrYvzlgiiPKG8+oOknKlpy4eoF0JzCNGyA==
X-Received: by 2002:a17:903:2311:b0:2c0:cb90:1dfc with SMTP id d9443c01a7336-2c0cb902165mr50479455ad.12.1780291666708;
        Sun, 31 May 2026 22:27:46 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c51f80sm94259985ad.80.2026.05.31.22.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 22:27:46 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:57:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
Message-ID: <3s5sqsgwb2juanpromxdklc6mxhahojoflezdpi6nzsbip2hqo@txxh2lou26np>
References: <20260530095809.213611-1-ojeda@kernel.org>
 <CANiq72ncuqxjjx+1SMV977UC-TZL9aPrbFECmCPPdzSLi-Oc=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ncuqxjjx+1SMV977UC-TZL9aPrbFECmCPPdzSLi-Oc=Q@mail.gmail.com>

On 30-05-26, 13:34, Miguel Ojeda wrote:
> On Sat, May 30, 2026 at 11:58 AM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
> > introducing a new lint `clippy::map_or_identity` [1][2], which currently
> > triggers in a single case:
> >
> >     warning: expression can be simplified using `Result::unwrap_or()`
> >         --> rust/kernel/cpufreq.rs:1326:60
> >          |
> >     1326 |         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
> >          |                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >          |
> >          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#map_or_identity
> >          = note: `-W clippy::map-or-identity` implied by `-W clippy::all`
> >          = help: to override `-W clippy::all` add `#[allow(clippy::map_or_identity)]`
> >     help: consider using `unwrap_or`
> >          |
> >     1326 -         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
> >     1326 +         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
> >          |
> >
> > The suggestion is valid, thus clean it up.
> >
> > Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> > Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
> > Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Viresh, Rafael: I can put this into `rust-next` if you prefer (I
> considered `rust-fixes`, but it is not important enough at this
> stage).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
