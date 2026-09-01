Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2F427FB9
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230263; cv=none; b=jk0bfXZpkq5/mJ8mbVtIh07g+HvFe/4vdDJ9EF33CmQeYK3HRhWE71hVpUyvkL87kwC9i9PvnNaXbPWaXVexcXhXJu7kOH/dVFfoCeyeWBCBG9nsJb46EaUWTuyY3XxT0x/baFDrYpvyoPp66MvK8p3n2i0lAgfBKDSwJ0OVuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230263; c=relaxed/simple;
	bh=qM0/Sa/akYpAFTQhfHlvfVOQIqgdK93DDZ+kOkezo0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqLu9tz0oUjwdNrJkQlsVf0y7lZadUlTYnCPJRCKgkXJAVzibegyEjXsH/3/2p0AJhhRgV1UUJcIu0+4h9NI0CLd9v829g2mpFeKb85ZgOsA/2HDw5DWynpvyyLkU0SaDS8LSmCXjHPlbY9suhMc3kYtUk86p3ZddW42ZrcMOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gwxjez4w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gwxjez4w"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso60215ad.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788230258; x=1788835058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TigSYxFnxWq9gKiGhMz2MZvb5kxbBnb0kPL72Ch9E78=;
        b=Gwxjez4wozRmwFvloTmovlsYIytqq9jXkqC+EFyGWiCF1PAZ1L49JqdxePWzmBPuCq
         baUrOP/m5+lUatVrFqWmG8/iRqwpRd8wjR7/YyxCDupUuvdmzOlgHPk90eapuoX6gVkM
         DtK6F2zw2ob7pNklmRoIqGqBWSbg6OGKBLmaVBlCZRkwjgUHzpw/WUviJ3WQldOxaTMt
         zrijCaEzFaN2aNtM1GnbkRPF4sRW2s8rn/Ea4wuWX1oCljRcVdroPpfKFw26LUd9c+UP
         nwKTLNXuPKrX6XVnD5RhotkgVCwWUBllcASVJiRcl/TGzZy+uzwnlrZWq31Rhqx6wKtj
         JlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788230258; x=1788835058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TigSYxFnxWq9gKiGhMz2MZvb5kxbBnb0kPL72Ch9E78=;
        b=kwFBbrMLJl+PYctaUa/jU+/099RgekTjDf9rsJiTV46HYNrB21ARZTjsLOA8u6JhyR
         Xhztw0GP7IErvsrh+IxjlJEy+DWs0BPujfSzQw1AJZT8eK7lWVWibfggji6DV8Tk5T9E
         ki95L/Cl9dSmaSXPtwEwWRs80M2P3NkyTE/mKhcld7o7C8+qYnIC0044AXJtWiSoSkI1
         G7ruA6M3ShixZXUZhHfoY+6QDTvPORyZrdk/3DLQLvaY9bMPfcC/cANepbuOuUkRjP6P
         gGS55gJf4uJsLT/byEh4C2DEuUHe+8sqZMK5kqDlsA2+00YQbnVo2uq6NoH+/e6zODYf
         /Lbg==
X-Forwarded-Encrypted: i=1; AKwUvBxJv2oaJDvUsrw1I1hZUMJqxE8iEBS131314rCtyQ6w5VkvDXoS0SkXaDy1QVHSoqNGcKKe6EE=@vger.kernel.org
X-Gm-Message-State: AFuF++m7vgMEeIyeDpuODtfC3f/sOqIRaxN5yKoKw+XEtt3s931N/giO
	VN0/nFaPgKErFyTYVm1EJ4qqBk7yPeCulpPctpvja9UzrUwe1k0vuVbm1Or8O+XWug==
X-Gm-Gg: AYBFou3sYBe7dQMmn+F2KaFomPV3lPuaT4eCrq3m0z3DrqBXvIcZGh9pXtmlTGyE0hT
	o5neN5ImkYc45Tn6CgJzmKMS4QD+h0JENGsOwVXQK5lMOLJaShPuXsEoPpCr827A/NIUwTccHzz
	tyUpX/2cGLWCMtNUr+mOS0EUCWJAAZ+rZClqQmI7kRoLGcKNpf776m68itMmpgIyFd4V1/k7h8L
	s0lOP4WYL9NWIYF1JXVAidPJ4H8SKBr141Y2Ml7vJUdokzAYwu0TcYEHsFFOHR1Y9jwqcWmtrOe
	I8EQzt6+EOyQ1LFVwacL1rQeYY4GyaBJiQJbo2Hy/t4VbkdWYqg2bsoKOlZvyTH93Lz5OKTg7Cs
	gi3208+Qkr1p1fN9rFdoRzeEFJmSmn3O12EagRJm6Zvn4erUaMF7y2xl39cldq/ZWbJGUjvXLpG
	3UwkGeDzfKT2triIPgpN3JfiBpXf1jUT9kC4fKwKCqtmd5CnGtW2DhTKM+NSy4lbD0AjgQjd7sL
	LmdPmCt1OHv8dSnogGW8ON62y8fUDGcor0IvYRUPa0Xwg85+19wuK8p4NhI9G47esqfC4QyUCZB
	M1EkcltA0LmqfVtJCA==
X-Received: by 2002:a17:903:19c6:b0:2c6:a078:bfb7 with SMTP id d9443c01a7336-2d959b82c4dmr2821605ad.7.1788230257133;
        Mon, 31 Aug 2026 19:37:37 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f727bsm5288561a12.7.2026.08.31.19.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:37:36 -0700 (PDT)
Date: Tue, 1 Sep 2026 02:37:32 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	"open list:RUST [PIN-INIT]:Keyword:bpin-initb|pin_initb|PinInit" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust_binder: reject mremap()
Message-ID: <apY6bAKxms37Xdt1@google.com>
References: <20260831224145.169403-1-cmllamas@google.com>
 <20260831224145.169403-2-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831224145.169403-2-cmllamas@google.com>

On Mon, Aug 31, 2026 at 10:41:43PM +0000, Carlos Llamas wrote:
> Binder does not support mremap() as it caches the mapping address in
> Inner::vma_addr. Moving the mapping breaks the IPC communication for the
> process and can temporarily leak pages during a shrinker reclaim.
> 
> Fix this by explicitly rejecting the .mremap() operation.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb%40google.com?part=2
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Sashiko had a couple of good points that I'll be addressing in v2.
--
Carlos Llamas
