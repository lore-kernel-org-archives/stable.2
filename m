Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEF37189C
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615915; cv=none; b=XFKhzD/RUEmyNfnYguV7843v4I0Z6S1qiT2nt2Wb2WQkQ/ma61BKAVb6G2zU4PWYl0x4YPE+NzHDhbSZ4vfjwHJ+HySGj/0HP6lNduFBbs5mnwQM3KHMkE/2+fUM63KpC8KSIQUJHlVsT9VmI1+fShiYQGyzD4yxJSp9Bfm+ECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615915; c=relaxed/simple;
	bh=t8DVFcwVouByAULESlvSnWi9+KEBgxDGmG+Hr+IMQQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyweKRnXFspSZGWl9gqxW25Gdw1tJiguCBae3euskKQdm3ZRfEGW0CEB+D88L93q2IjdMV8VbsNktoBPuJa12EWW1cPhoZBMMiGK/hpPARR/amChhvdamLmWH8MTLfsNacV+g/Mm7wuOC/6rE8w4un5n/z60yHLHc8YNIwhB0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MICe5ZEX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MICe5ZEX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so4776265e9.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615912; x=1792220712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DweFzcI4gHZFLSxIvwyVvNqAgdk6GYFvRotJCZPm6FQ=;
        b=MICe5ZEX2FP63640UfiurVTU1XXY9CIZzs0qixQo5PfIfAL0EGUfiGJhnmrBTiz8ih
         WVJR0aWhDqORJ2idD4CVgRTirORZQR7/8S8CegMG2L0cVUyZ9ckXGDP7K8RXM+qgnKfg
         bKVI5J6U7391lroB+uw/RV7U1cUaBnZ+M0rod21PTnJ/3zVHUdZj2XV9snEQWAwS7BtV
         INXLY4758zSZ7Cn/nQ8rBSPzqnrkiZUXjF2/klV43ZiM+IO38MgSt03ei96rydgiQZo9
         YCjiX4WXhpMdduX4hiPldf5RM2SdOQvo4WYm9q1KpBOR+yl3iIaqK19J2sQkHufFNv7v
         XD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615912; x=1792220712;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DweFzcI4gHZFLSxIvwyVvNqAgdk6GYFvRotJCZPm6FQ=;
        b=BvQ/ApP1RArwTUzTLA64UU/kMat3A+tG2J20y7yrvpyowyooSy4JakzJaqA0Ghqot8
         ZJHQ5bd16+4XS00/PqRvRlkMg3d9/VDLbwGFJie6FTNByKyOqeyDhzoDyADJ2+KPlJw0
         Td8Dj8AjP1ZsoAv3Dq9v+welBK1uhoIEboIWCWB4LltkwnJlWX92XLqCAB6mccPpIDuN
         4W0BScoCZmGku4u/EfA5ftHtIt4Xw2Mgjf7bQXiqQlPX8qWgJCXI9+4QX/ybOG6gx26Q
         YMH/JtE28jkZ7bRMuafkHqzYCy+nDoPY062DthGGXFmKX4+RDEEt0VzPIlKyuqDqDhs4
         e6KA==
X-Forwarded-Encrypted: i=1; AKwUvBw1BpP6zWbPP3pCKWh4pHPm3rURW3mlFIzhg1j6ZW4E3GIQRsZeCa/oxlN1Oz9xticLVvS/Dxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsaR+/SgotDHbbSqpwCm1Wljt4Hcw02p46x/+ciw3fmhLkbLfC
	hsqCTO3DNXZJ7ds1MrNpG0SljEOme2e+GHnrzIhBTlzMwdaHTghF0bnw
X-Gm-Gg: AYBFou0dzhCN08qwxf6fesiFGud5ernesBK2GafRDhiMQfm/QV8qko+drbkUP+9zvYj
	VQdQCKKPsKhY/sz+lqINDLhxY4ZFJoVvZ5O6MD30PZU1Qka8fdzu6ituUZNFvhmfcCL/h81KwIR
	nYuhQK7LS/LrXzbNxHaf4lHhEaSmyCMpN9O6foo8o0dZl6FvQoYT4yXLHd1TkmGNciUSK6sLly0
	kbB+Jp4WfGZ58p7Mkt7bb+g28FQNWriNYA7PVpYmhzgvYqo76JaB0Yp0W7m4QLl1sUCTB6l0aUG
	0leXfp3Yimqo/G13gGjcfUchsTI1QRprTjfAFnYuKv3uGGi8yxwjSz3hg7sP6WcypZ5rS22PpwP
	WKlyB7QEPN7UZG89Dz0ihddQiFwVxI1zoveVOyDPYVByFHwOJ1nSJl/D857PJSE7sp/bPDgIaX0
	+C5KjJBBXS/b9WEmZTVSpY5bpquDXufglLnnrnrMKHhZiJ63Qlm/lAeB7sYLrQ/OqA0yh9r+kQI
	aPg1HGbXEZ5JsVa8GJNgp7i3EbT2ie2RLQdXM3aP4Vm5Zo1Spe9nqUDFrVz4ohegmoTWqZKdYHt
	pQtVAMLHouFf7mVFBBbziLV+pM/+dk2EJFWbOwnbtRRekvDkcDHHdBD6RbarphtATD2GuIw9/8J
	A
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr81147435e9.27.1791615912019;
        Sat, 10 Oct 2026 00:05:12 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d3f-0d01-48c7-5d76-0ec6-9dac.310.pool.telefonica.de. [2a02:3100:9d3f:d01:48c7:5d76:ec6:9dac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18dcd7dd3sm68365155e9.2.2026.10.10.00.05.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:05:11 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 7.2 203/428] rust_binder: reschedule node refcount update on thread exit
Date: Sat, 10 Oct 2026 09:05:04 +0200
Message-Id: <20261010070504.73698-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261009140950.590490061@linuxfoundation.org>
References: <20261009140946.008206689@linuxfoundation.org> <20261009140950.590490061@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[...]
> Cc: stable <stable@kernel.org>
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://patch.msgid.link/20260903-binder-thread-exit-node-v1-1-be09ff14f6a4@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
[...]
> --- a/drivers/android/binder/node.rs
> +++ b/drivers/android/binder/node.rs
[...]
> @@ -733,7 +733,21 @@ impl DeliverToRead for Node {
[...]
> +    fn cancel(self: DArc<Self>) {
> +        let _drop_outside_lock;
> +        let mut owner_inner = self.owner.inner.lock();
[...]
> +        if let Some(node) = ListArc::try_from_arc_borrow(self.as_arc_borrow()) {
> +            _drop_outside_lock = owner_inner.push_work(&self.owner, node);
> +        }
> +    }
[...]
> --- a/drivers/android/binder/node/wrapper.rs
> +++ b/drivers/android/binder/node/wrapper.rs
> @@ -57,7 +57,39 @@ impl DeliverToRead for NodeWrapper {
[...]
> +    fn cancel(self: DArc<Self>) {
> +        let _drop_outside_lock;
> +        let node = &self.node;
> +        let mut owner_inner = node.owner.inner.lock();
[...]
> +            if let Some(node2) = ListArc::try_from_arc_borrow(node.as_arc_borrow()) {
> +                ds.has_pushed_node = true;
> +                _drop_outside_lock = owner_inner.push_work(&node.owner, node2);

I object to this patch as queued: it causes compile errors with
CONFIG_ANDROID_BINDER_IPC_RUST=y.

The upstream commit was written on top of dbb17c9ea756 ("rust_binder:
move (e)poll wait queue to Process"), which added the Process argument
to ProcessInner::push_work(). That commit is not in 7.2, where
push_work() still takes only the work item, so the two new calls do not
compile. dbb17c9ea756 is a performance change with no Fixes: or stable
tag, so I am not suggesting to add it.

An LLM agent assisted with the review and the build test.

With CONFIG_RUST=y and CONFIG_ANDROID_BINDER_IPC_RUST=y (x86_64
defconfig otherwise, LLVM=1, rustc 1.98.0), "make drivers/android/" on
the review tip 77b730c57839 fails:

  error[E0061]: this method takes 1 argument but 2 arguments were supplied
    --> drivers/android/binder/node/wrapper.rs:86:50
  note: method defined here
    --> drivers/android/binder/process.rs:173:19

  error[E0061]: this method takes 1 argument but 2 arguments were supplied
    --> drivers/android/binder/node.rs:748:46

ANDROID_BINDER_IPC_RUST depends on !ANDROID_BINDER_IPC, so a build with
the C binder enabled does not compile this code.

With this patch reverted the same build passes. It also passes with both
calls changed to the one-argument form, push_work(node) and
push_work(node2), but that is only compile-tested.

Thanks,
Karl
