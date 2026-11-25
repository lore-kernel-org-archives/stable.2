Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618996;
	b=Vi7o0YxkBprh2LqPy5u1/yd2S3z0B1kH54dxsGrzrfhF5WxHI739UwsLl0juWz6iRsst
	 d+NhXvgEU4ptL5T7f+Jw1w98m+cjzStiI5V7Flo/sSeCZ88vpGC+JuA5B2pInc/zDX5Y8
	 rKZOfVwuD5LQynYr5LblrIEZuEcZQAdNHfEOgjVgdn0kSkgTk1pDcJk6eJXmiGU26LaEE
	 l7Qzu6erB9s7OGd08hfKUoOiNr5QNSJo2Td4hmZ6fdEh1bEGwIrj4SxO+IWplp2yCTinK
	 +rUa0sv/XiG24/ttiCoceu2pP7gyawGUsyTnCBdLrsUdp3IRCagfgFJ2STyb1+T/FTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8aj9nTYzj6cuyNzNLusXOllcp3z+nABWrRwzBA+BFgQ=;
	b=QR7nCRzYXZ7MHiaU9xzuyxBM3JygZxy5lmAgTWpgEtnAQSS7YmYXhKzaHqxTi7n+K3Dg
	 UHdTOC1hE/dkkguoRNrjPet62gUw4x1sr3L+h1ZAkz7nwxezjX9daJUXRO+yhPBnqzv+1
	 lHayjR/m35a7VUGsb60zZQnkiu05F5gExAlZXe8VHzWKCgBUqE3a+RDDpUGS6OHxTmxo3
	 FKHQKauKr39n+A3CxNX89tPc/wXdkuRmXV0c266x8MMBPW/BCkOm1STu7zaby7vkh+Tuk
	 IsDQUhGKmA/E6vo49B8DwAUj/iegoSic/YQzFUCRO5X+keFOKMv6AsEBClDnbR5RM0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MIP09PUu;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF8606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1BF8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MIP09PUu
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4a370217dcfso5463174f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795618994; x=1796223794; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8aj9nTYzj6cuyNzNLusXOllcp3z+nABWrRwzBA+BFgQ=;
        b=MIP09PUurF3S2YFaERK70bZXWItvXb0OK8Pfro4q5FbsG1amrlshUUx9v8OwgO4rbX
         eSwxp1NlAm1zLkNy8GG9aqDWIAePnxgGDszaIpQLFYj3O1icITGUKzi/mhKeaMU8tBE/
         XujLy5HHIcOUveXn7Yw6zVBf2I4fRZ+XDuBZ5bORKtkShkBRra9+kAeZg1PLimF7X3jS
         ibLYnD5ChkgXJ1KO+R90XRzXhemCmUstZL2okgFLs8x4q2pJovHKGHGTK7mgGLNaz+Qa
         /8nmk8ZKA0YXaWx3YTEIuHer2ctFdZZXcXWrF0XMf0ssNdyvS3LVKdHaPuP3xv7+covE
         OfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618994; x=1796223794;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8aj9nTYzj6cuyNzNLusXOllcp3z+nABWrRwzBA+BFgQ=;
        b=pxNix0GBkQmkpVQgxMto+7MzrYiw96gaVrBAyKJc1PB0v1SBZp9ztsuPzY/cdSOX1/
         WKVAgYCfcGqFdrRsR2DP8wmakx5SZO8S1X7bNYcy0Pz5/m7GL1e20iVZnbsG0DbQe2Ji
         pKYI3XtbLo6jfLCVDfEfTBJ+3fB97R910JTyVv6Hxs2KU+oS28cwhgwJruDkoIXW/SdK
         Cxh75A2UOmuIYtBpXsRL3dVWQWkoGzVonRUEb4yAs+D30g4LS68HRgB/bKGbEcz7Jb4b
         Hv64DKo4+/1qtHZZNusIZJZ19eASf1R6P+0PmcLWAGLu0fLtBwv733xZcwmL3roAN4RQ
         OIKg==
X-Forwarded-Encrypted: i=1; AL+hErEUGw7TJ5rUULgtEV3fF26QARqHVlxkS/vZKbHbCCDr2q/x6+U2k3LAcVdQF4qQB/lr9ZbvQF0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aYEpwg5j7rge89RU4EaryDCsC7X8/4pFzPD9zMOGR2X4Jjwky
	g1/ara/rVY6K92grfERhvJwfbGwB4j+uL6fS5FR8SbkMhHA9q2XpHwwrQUaR8KLNV9DDsYGKa9S
	5Id3Un5uqZ9qq/XTx6A==
X-Received: from wrzt4.prod.google.com ([2002:adf:e104:0:b0:4ac:99cf:5a0e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:29d3:b0:4a2:6542:989a with SMTP id ffacd0b85a97d-4abb4b85a5cmr21029290f8f.52.1795618993824;
 Wed, 25 Nov 2026 07:03:13 -0800 (PST)
Date: Wed, 25 Nov 2026 15:03:12 +0000
In-Reply-To: <20261124-rust-drm-gem-shmem-imported-sgt-v2-1-000f7a9ccb8d@jannau.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
 <20261124-rust-drm-gem-shmem-imported-sgt-v2-1-000f7a9ccb8d@jannau.net>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125150312.1587642-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 1/5] rust: drm: gem: shmem: Do not use drm_gem_shmem_dumb_create()
From: Alice Ryhl <aliceryhl@google.com>
To: Janne Grunau <j@jannau.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	nova-gpu@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 12:37:43PM +0100, Janne Grunau wrote:
> The existing gem::shmem using Rust GPU drivers (Ashi and Tyr) are render
> only devices which should not set the dumb_create callback. When a
> driver with KMS functionality is added it probably will not be able to use
> drm_gem_shmem_dumb_create().
> The Rust gem::shmem::Object<T> wrapper should be allocated and destroyed
> from Rust code. DRM drivers have a `gem_create_object` callback which
> could be used to allocate objects from Rust. The C code will "destroy"
> objects with `kfree(object)` on error paths which is unsound if the Rust
> object's DriverObject contains fields with a non-trivial `Drop`
> implementation.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Fixes: 80df573af9ef ("rust: drm: gem: shmem: Add DRM shmem helper abstraction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
