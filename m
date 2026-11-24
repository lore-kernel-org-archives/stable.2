Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522411;
	b=d7xilZULpf1wudAc24ldiYJyEdYcA0z89dT++hAgEWuMP6GOWqVAaPRVppxczjpfRd3y
	 TnkLHAO933xA5rGmb6vmKKUrXzA2sgiHyczR9NRPZZo6kzfRkZxRrLUXUSai3NG76e8Wn
	 4B4ioUz4tnQ171OOMQqZYi5u2SCE/ZRtfsxf3bzrweEs3Y70l9wHI1Cp3Qdxs8paiX3M4
	 RqKo7jHgyTbo1+HN0NfqErIVDytwcCOH5kIo0wBLH4BmvCLE6pRWh2LJvwzYUMVS1ZhZi
	 dspddM1dG+5A9IqmJa4wpUAadBJeFrOJ01wkJ51dxrSDNDLrCYIRiMrfke38xRbNXvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9txfLV0X7J+AJlocBX4pn0cSS8Iiklmn56A4kBLwtUM=;
	b=K6edhWT/IA0ipGIzSBgy0RpaThLDFQV4Vv2hINTgIKpML7mofhrLahdWMbmcctGy92Nj
	 ++pAQoAAxOJwGkVAOIpoENaYWNCKXuadpt+Z8vNcCYMpS3SC4CMUl2fUtB4OH2XI2DHFi
	 +woItUNnCf7eT/8UJor7xx4w0RA5DuINpO+W2f/wTJ9IkSQXTW8AOdAb9ElZ7ukYClTbO
	 P17MC0aFL49xCFBC3QniM6q2x0vbWt/NlA69Axd/Xoc/BePaEfwbY7Ig4pl3ydZFQwB/y
	 Io0ikeZyM8v+oYFxP/OAec7dvpuD9U5gzlCLhVUMpGES+mvNcSrItjw30XyTmscYRFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YsgMZmDi;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D10606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D10606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YsgMZmDi
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so36145595e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795522409; x=1796127209; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9txfLV0X7J+AJlocBX4pn0cSS8Iiklmn56A4kBLwtUM=;
        b=YsgMZmDiQbEqjVJRBimGhvLGwr9kzHj9glkDjgCVetBle1OrRe66JT2A0wAoDOJlVH
         3eKtFaYlR3COaFP7I/pHY1t8i9hQGp7K5EqlwMLpxS0/3XEv74X92iuLuCqG8QX6il7q
         kxoYjIvqquTnoKXVyJ72GFWMyDlIOjTrV1z04jHYs1a3vXYdoOUq2rHc8At8o4Dsn4MH
         e1YWey657bbBZm42gXftzDS94wKDaAbUCOuEPOmQRcTQgJzH4bjlgFN62yBYHdzAasdG
         14cuZ44P62LK117RMeK1ZJCVP9A8fBDkyM9/uACc8LIXi/lDaHSu6B4E9tl0HW4IX3WO
         77zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522409; x=1796127209;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9txfLV0X7J+AJlocBX4pn0cSS8Iiklmn56A4kBLwtUM=;
        b=sRYMyztAxgbqor5CfQTKIlQMjiLPdFXEAhl7avu6Ylam5F+stnGj2YcigXMHhrY0Bo
         1K14OxabK4Of6PzqljNRVPoN9NyTNyqm6mzSJzVVfvxZCQRvurWHSRQVb0hkSkI0+Mwf
         84o6qQYKr1BMudbtSVry4Q80l6vM77jIxZuaYO/h8+WvdLamlleRhFjHS9dPSEZGHBHz
         FThOGjU3Vp/ZkRvCRisTHq8CNWuTIFK1gcV2X8n6PWW46TZU48SV5jsNZpCQpmg+Yre1
         M2sGaB9V6ZJObZ4Fysdm1zq6mR1Cw29H+wnHboGEHPIGnSRhmWpJWXGVni3kLL2AF2sx
         nmGw==
X-Forwarded-Encrypted: i=1; AL+hErHdYrvjZxPDDhPJ9v7T9873xHlglzPCZtsTsHvFvoDacUsFjRqE48ID+O71VRntMBoKUi86dtc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YF2vcYcTnQL75uXHo6Tzkw1kd2r5WVX1Us0QtSXdFNp21mCbM
	pdS7dl0TyoIkSHEq60sQOraGVyTWaUEFHl0fcxpdM6bG0fgIQlV4AdyvmxhFlNJNcQX9Gxl4sDy
	1TMbim0o7vs3OflXMcQ==
X-Received: from wmcn6.prod.google.com ([2002:a05:600c:c0c6:b0:4a2:853:1e95])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154c:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4bb8881c378mr304628095e9.8.1795522409266;
 Tue, 24 Nov 2026 04:13:29 -0800 (PST)
Date: Tue, 24 Nov 2026 12:13:27 +0000
In-Reply-To: <20261122191322.929005-1-inguyen@fit.vut.cz>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122191322.929005-1-inguyen@fit.vut.cz>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124121328.3253693-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust_binder: only remove a node from the tree if it is
 still there
From: Alice Ryhl <aliceryhl@google.com>
To: Nguyen Le Duy <inguyen@fit.vut.cz>
Cc: Alice Ryhl <aliceryhl@google.com>, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, brauner@kernel.org, cmllamas@google.com, ojeda@kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 22, 2026 at 08:13:22PM +0100, Nguyen Le Duy wrote:
> --- a/drivers/android/binder/node.rs
> +++ b/drivers/android/binder/node.rs
> @@ -636,7 +636,7 @@ impl Node {
>          }
>          if no_active_inc_refs && !weak {
>              // Remove the node if there are no references to it.
> -            guard.remove_node(self.ptr);
> +            guard.remove_node(self);
>          }
>          drop(guard);

Nice catch, thanks for tracking this down!

Instead of still running `do_work_locked()` on a node that was already
deleted and checking the tree in `remove_node()`, perhaps `Node::do_work()`
should simply be a no-op if the node has been deleted?

If we track `is_deleted: bool` in `NodeInner` (set when `do_work_locked()`
removes the node from `ProcessInner::nodes`), then when the stale `Node`
work item later runs `Node::do_work()`, it can clear the `delivery_state`
flags and return `Ok(true)` early without entering `do_work_locked()` or
touching `nodes` at all (and `Node::cancel()` can skip re-queueing a
deleted node as well).

Since `do_work_locked()` only removes the node when `active_inc_refs == 0`
and `!weak`, any required `BR_RELEASE`/`BR_DECREFS` was already sent when
the node was deleted, and no new references can be acquired afterward.

What do you think?

Alice
