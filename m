Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEE46AF03;
	Fri, 16 Oct 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142528; cv=none; b=F2NtYrL6rt1w0l1wU+Peim80Xv69yBFraUUCVKBO0YJrhtOdIR3HyvFsZV3l1ZJinB+WAvGQkuKBwt6zyyzzzpQ9rByEXGn53evDUJQ8xlUpKVFcWHbgDIxnsjBjb+C9cxcJ0VjHut6P+9B8Btdcwg6oA7mP//bCOxqOmuzXLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142528; c=relaxed/simple;
	bh=AnuSFB9WIHhhpt+hux2Nk6GEF2J5zHQZR3aGoBtjrkE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fuKiLC0kWItusYSEkjE7QsJZv8v8fch+039ICsJg3Un0GMGSX0As3p6zrufQx6ccj7W/VzN9nLqdoXiW0iZX2f+1idZuKQT6jga/0Iq7SVHbcm9HmUp3ZlzpC8vgZhPo9mHSgtZZVRo8HZasSSoKUaTjTaZzuGYFzUcj6CLT7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTpQzvW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTpQzvW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FB81F000C4;
	Fri, 16 Oct 2026 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142527;
	bh=gvrAYIcD6ybpRTvHJ1/WrWWnHB0ECjD8mCUCZMWd5QQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=aTpQzvW0UAYBW2fYzlV4ZIvPhbQUfsc+OhUz8kgCDLE1MhxQep73AJg+IVghfkf3n
	 jQ2pSzgAzmzEKjwarc1Ry4tDdHIbBw+VWXBHAkRrLWSWs8EFRRJE05l2AOYiJTa+uO
	 x2wHNCFmLxlnX+wTxb1gp7eJyC2T6mvc0zFydpW81l3HWZqKilKoSbY8IRukBlejHV
	 2BSRajMVHOsyi9claWZN7J83oSK6iB7w5hxhjl41uPhoxJ0rIwBp2fid8lWTgc98r2
	 UD8ZJJXYLzlKdb1iyFmiciWA0//XfKf/uQ8roqblCv7d7qhsIAE0WlLpoFc0xj263D
	 Tp6+bj6lN6QKw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] HID: multitouch: fix use-after-free of haptic data
 on delayed input release
From: bentiss@kernel.org
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261009133316.3371188-1-qwe.aldo@gmail.com>
References: <20261009110509.2432308-1-qwe.aldo@gmail.com>
 <20261009133316.3371188-1-qwe.aldo@gmail.com>
Date: Fri, 16 Oct 2026 11:22:00 +0200
Message-Id: <179214252067.1109876.7779829429623391509.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142525; l=2549;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=AnuSFB9WIHhhpt+hux2Nk6GEF2J5zHQZR3aGoBtjrkE=;
 b=N5J2+6nRmH+HY/o1up3nbyuDvd31DNJ+L4+3eJS0kKlb5+V+G4QySkeUG+ZHM950GcHSsb7MK
 r3uGuI1qGByB9mmbofKVf7eN5dwy25AOs5Dt9JOOYihPYtY5k6p6j7i
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Hi,

> mt_probe() allocates td->haptic with devm_kzalloc(), tying its
> lifetime to the HID device's driver unbind.  hid_haptic_init() then
> stores the pointer in ff->private and installs hid_haptic_destroy()
> as the force-feedback destroy callback.
> 
> When the HID device is removed while a process still holds an evdev
> fd, devres frees td->haptic at unbind time.  hid_haptic_destroy()
> runs later from input_dev_release() and dereferences freed memory.
> The input core then calls kfree(ff->private) on the same pointer,
> double-freeing it.
> 
> The existing get_device()/put_device() pair in init/destroy pins the
> struct hid_device but does not keep its devres allocations alive,
> since devres runs at driver unbind, not at the final device kref put.
> 
> Replace devm_kzalloc() with plain kzalloc() so the haptic struct
> survives driver unbind.  Track ownership explicitly:
> 
>  - Add an 'owner' back-pointer (to td->haptic) and an 'ff_owned'
>    flag to struct hid_haptic_device.
> 
>  - hid_haptic_destroy() NULLs *owner under a lock before the input
>    core frees ff->private, so td->haptic becomes NULL and later
>    kfree(td->haptic) calls are harmless.
> 
>  - hid_haptic_release() safely frees the struct only when the FF
>    subsystem does not own it.
> 
>  - In mt_remove(), hid_haptic_detach() disconnects the back-pointer
>    before hid_hw_stop() so a deferred destroy (from a still-open
>    evdev fd) does not write into the devres-freed mt_device.

Sorry, but even if you are fixing a valid issue, I really dislike the
approach. devm_* is introduced to make code more readable and somehow
safer (which failed that point here), but removing it feels like a
pretty big step back.

Can't we achieve the same result by adding a specific devm cleanup
action instead of just removing it entirely?

I'd be fine with a custom devm_add_action_or_reset() in
hid-multitouch.c, but of course a full conversion of the hid-haptic
functionality into a devm_* api with things like
devm_hid_haptic_allocate() would be even better (but not required).


> 
> Additionally, reorder hid_haptic_init() to call try_module_get() and
> get_device() before input_ff_create(), eliminating the input_free
> error path that called input_ff_destroy() without setting a return
> code -- which left td->haptic as a dangling pointer on those
> (theoretical) failures.

I think this should go into its own separate path.

Cheers,
Benjamin

-- 
Benjamin Tissoires <bentiss@kernel.org>
