Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483993;
	b=kQqszbT7ky+WFQB5RHckwpNd4oi/wdSYbncfJxPQyoqnnd4M5TSsndrk+zMWT3TDUNyO
	 fgX0noCHCBu8wRHOKNkwFgDzJm733nkwMEcGbeegZRvBycEdvICBzTWIDJAwcnaqiwKgP
	 XBz/xxUys0CkzR/z0dI5MBCVchwqBUIXGcEQRFYrLj4rbvV4eHSPKVCzdOOWY7n2Aha1o
	 I8AkvvnkH9EnM/iy8BspS1CMR3b62HtOPeHP35xJuGuxcsaRVXwTtzcoPuRw9Po7gcraV
	 2YU5WSXFlxMqettF7p8XPIe1eeIZtgezNjgGwsqGatw3tDCfphcrf5eXSa987gNa+6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TsTwpzFLaL87CUGnKEpNBjiUo0nCAy+dGY5mjA4Yxa4=;
	b=nx1W8vbe5deLK7sZCEJ+mcvfexrmO9NTMOtW7nmgkGwEt+d3G4i4BZmyGs1QoO7UzRPf
	 /Bdi2XEUMmQ30Ci+0FgRaO9AWh/SZkE13oxvOTGtHAjvMqcWoyFcAVWK9nhxCCp2ocZ1X
	 wO+p6Cpiq8Crpz4ok0JuQeaQd2ynGpcZTBXhXGvanHStSrOWDmexVd/U2mZNVOxtE3zuh
	 DaLZ7qtBaEEKd4Ee9ATrXS+mbuWiQhc1SFspzxAXfWECjvEF3smuBPtdNYJl9rQHQiRs+
	 XNkmCBiJTu7NoWY98BrnJu7pkcYKXKQVt1nbPJcYPMWPU45dpR3Rgh37KuK6tJoWPwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VGbBsq55;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EC606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VGbBsq55
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6afa6850207so3876301a12.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792483991; x=1793088791; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsTwpzFLaL87CUGnKEpNBjiUo0nCAy+dGY5mjA4Yxa4=;
        b=VGbBsq55SxMht3O1sFL/JYhDoUB1lktVionTe2hmEWeoz6nsvvNHdD4vuxO4EZ5VBk
         I/ykPxUt/pVq3kzNQgQyy1bcLYXwxSvhJbpvJXriWtSEq2xHTJLOUWDAFm5GFmKXzUKU
         zeQBf+1swtzmV6w5L41uWwYVRDI1Q5mrimf1EfENQOEGIF3TYEXUhcJNQSDB84BT7p2k
         IvJW1mNG6gsgso6x4r/2S8pXx1o+c3sH7wMfMUmWB65O6rwESMhS8iNG6vpMGx81Q/Jw
         oBATHwmSWWFs+gBdvOQg6BKlDe7FapxC+zmaUSwRwJZ3YnenOf/bWAs53FPtNREsDBiO
         CK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483991; x=1793088791;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsTwpzFLaL87CUGnKEpNBjiUo0nCAy+dGY5mjA4Yxa4=;
        b=zQlXMjs8y3zHQMGyAqQMpbRYMF5y1wO/HBdkWzq1IHkzJp9UBsV64m8i2Z1v25ahj1
         4LA2siAoMzYwKuveEDQ+KCOR7RQYXR9+4i1KeU1XwDBO+2Wr2UnrPSZc28HVHsO4YRtr
         +9DUvdAgY87FhpnsP06otaXMYRlh579CD92M/zIMJ0mX3oDaeImcbRVqMPkSDvMH+/CW
         EqR37pGjum4Ior7YcCVi/HepwxV7SkUQ2ZAqm5kLDL/fd9euZkKK6iJcS9/NwR8/N0QZ
         OULZsuzmppyS2QLs4Hug37qzxysyO29t8AHZ87G3q8mZWt+o9gT7WU/x8blCpyTbdTD9
         eYzQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/xzMWvVRKQtDZGUHxBtJiv6xF6e+jnT/5cuT3ezVitOI7P1s3kffF8IdbVxcDIeqqPclHWrs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwffqbW/QVjHo7qSusm0s0lDSUopubCrhbMY5W1rysQldzuvyp
	/RxelZrDV0vKExsZCXJFHlK4//meAcikpcsFtXT1Hu+CYNVi5eQ++U85TaV9Lw19/7uFb4a77jL
	IklZDYNcqv2MKeAR/PQ==
X-Received: from edt3.prod.google.com ([2002:a05:6402:4543:b0:6aa:ff76:b1f6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d803:0:b0:6b1:e474:e0e2 with SMTP id 4fb4d7f45d1cf-6b3a81dea57mr4861388a12.43.1792483991214;
 Tue, 20 Oct 2026 01:13:11 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:13:06 +0000
In-Reply-To: <20261019-rust-cfi-fixes-v1-3-9503472ba738@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019-rust-cfi-fixes-v1-0-9503472ba738@google.com> <20261019-rust-cfi-fixes-v1-3-9503472ba738@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020081308.1768290-1-aliceryhl@google.com>
Subject: Re: [PATCH 3/3] rust: dma: declare cfi_encoding for dma_data_direction
From: Alice Ryhl <aliceryhl@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 19, 2026 at 11:34:39PM +0000, Sami Tolvanen wrote:
> bindgen generates bindings::dma_data_direction as an integer by default,
> while C callback tables such as dma_buf_ops declare the parameter as
> enum dma_data_direction. kCFI encodes enum types by name even with
> integer normalization, so the type ids would not match when C calls into
> a Rust callback taking bindings::dma_data_direction.
> 
> Generate dma_data_direction as a newtype with a cfi_encoding, as is done
> for lru_status, and convert DataDirection through the newtype's
> constants.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Perhaps also add:

Cc: stable@vger.kernel.org
Fixes: c2437c43cfb1 ("rust: dma: implement DataDirection")

so this gets tracked alongside patches 1 and 2 for `6.18.y` backports.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
