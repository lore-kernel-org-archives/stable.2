Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35F3B0AE9
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758371; cv=none; b=VM2oGW/8YkAJtSEIy32ioi5uJdOcHb+ulIDVF/7cSOzJ6j5xYW/UEdyOr7lDtDPXXyHkFQ01YIDGnLtc1a6fRWTarzwSGrNFJd9b3iOehwpv7TQFxGvPgJOH3gBKKxITJiP8qae4EIV7uOhYSF2aNNad1hgkBXUHpwJMfCEJG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758371; c=relaxed/simple;
	bh=MqrR1qkfxVNLgLGDFhtcAsrh6I86vMgInnQiO3VemTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThBeEXUdgpfwmrgeuBtX3NUxkuHI8zFzMb0Xl0lTR1EGuhXn+fjAYSOhCxTeK2iYtTl89Zaxj+DXdUBwka2HGnh0osE6PVEuc4FWIYLR0fL/BKY0wgO1Wk/uZpl1P/e1shhwJ6ExN9sCjjNhAxyOuRz58zeDfKS2ob3KwK9f0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFK+wQ7L; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFK+wQ7L"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2d865383so171715ad.1
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780758369; x=1781363169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGfvdtWSGmeyeBZFaUpRxe1TesgPLTrHXjlHvnqJz1E=;
        b=OFK+wQ7Lb9OiQr8q2/Y2v7d40D9KS+d7wpJutHDHANMQhUcNRk6Per6D4NK+EvgPjX
         GsSAlTpkgtENZdu2HjxaNmN/AShsea7y3cA0Go9nAbp0g+X9S5XUTjjrZtwGmyBWQubZ
         LHcKpMdNmukPbPYHxtdlTH3BK5bTVY1yzHQWLORPLM3c8CVaGjJpsZtH2/RRGBNCRgyI
         Zy7A5bZHOeQ9qGnzRqo4U0iU3qrtaXMJCzwhj2zKpPD8JUnxunW6iEJ8Ta/j74qXrIuN
         IRDkSrEZU7t+N5CdvGT4a7kPzr+QBTQ1rkcUYZAL4IYpRPJAQHaxteC9wRtgcJVjH1qP
         TMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758369; x=1781363169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGfvdtWSGmeyeBZFaUpRxe1TesgPLTrHXjlHvnqJz1E=;
        b=fuXzQzOCogtTfKpKWB/vRxQNwbih9JOYh2Qn94o84ZHkyh0if5JQA+zQnvqip/uQd+
         opbTKYSzx6ocDb+n+RgKM9w6JiLPcqS0mZ+WCBxaS+iSxXe4fnc+Gm0+j0BN7BkfF/KZ
         FDxFNa+9JS/8OJnaJBGIQJTYkNp8ZfLEIgvUS0Q196FY0U25VGDBzXtibPhbZTwbg1R+
         58Uy6aZU+v9Cx0cXRZixZvauk2q/arZ+fIbbROJ4668A/Vlc2MZa+RDwid56AF7UU/Vr
         lDGFLls/UOalY+CU4vmy0kF2kd10kZfbTlRNaiLaluWuGuqEu9HWFYYtsiPRetfYDk0N
         LKuQ==
X-Forwarded-Encrypted: i=1; AFNElJ94OUYGyUPsTmu0k98WvKJ+YCuTmSd436K+q6VKsHP7PSKNFF1gq7H8IZfHegMPyBELUgDWgkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMsxG9jh0iXAX27LpJbERh2gWst/OkYD3W81tyC2HxDxEM7UZ
	Wp429l3xY4BCG7Fv/dDpQpmm63nbNt7D+q64deBmw2pEUQ46Rnnys/IDzx0CCkXcBQ==
X-Gm-Gg: Acq92OF0ktIJ8C3OoTYRBcWBhNJ5/5dEwJe90RCrQPBh/mlguuU/uBMJh1MFu62W1b1
	I46mcfm5F6JQEhe8BByRO9ObLRIsxeZ6fv8qkGjx2QKA0OYfSJCzmU5tP/Q/p+liA4+mG01GIZp
	oyI/9NdbJSGnLrwHlTaLSLYTinT4ySa4sCbD5zIu65v49ru3dA6cEFkJ92xpKtyjAYryTon2j49
	x9tXBEUw5LFO7RcFlDdKfftefMV78DCVpzXM3toKi/N4D4kiy5T0Zo1bLsQ/oYxpNngniNiGKhR
	6vzB/PljwMHU9hfwE5Ab4yqr2zhev2xcZjKUz1Sn9QK6PthB+M8ha4Fh+na8XyUBi8XQJP2vHJm
	0ne32LKmH6qLF4XSaIfKqrko5IeIaolpObUCJoGZ417c5qQvc3M0yfTkBbimx5MMOQFh3qd3t5V
	Vc3sGY8Lb1WH+t2+JA9K2vitEpdAj/YcF4x6bzmXimeC2eewWhy+C7g9DxZBIaourICTrkQH4bv
	gfi1jYrKcOjbdt76az/askcZSi5ieLKOrHGhJTOTTEY87FgTORhkM2b
X-Received: by 2002:a17:902:ef4e:b0:2c1:5756:1230 with SMTP id d9443c01a7336-2c1eaab121amr3570175ad.0.1780758368860;
        Sat, 06 Jun 2026 08:06:08 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282350f8csm13647791b3a.14.2026.06.06.08.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:06:08 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:06:03 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] rust_binder: fix BINDER_GET_EXTENDED_ERROR
Message-ID: <aiQ3W0xVG4dOG_br@google.com>
References: <20260605-set-extended-error-v3-1-d60b69a75f97@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-set-extended-error-v3-1-d60b69a75f97@google.com>

On Fri, Jun 05, 2026 at 11:13:50AM +0000, Alice Ryhl wrote:
> This code currently copies the ExtendedError struct to the stack,
> modifies the copy, and then doesn't modify the original. Thus, fix it.
> 
> Furthermore, errors when replying must be delivered directly to the
> remote thread, so update deliver_reply() to take an extended error
> argument.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

> Clearly nobody actually uses this feature
Not yet (only error logs for now), but it will soon. e.g. EAGAIN will
translate to certain transactions/commands being retried.

Acked-by: Carlos Llamas <cmllamas@google.com>

