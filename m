Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238529;
	b=0UZOqitECGDBRRKkObm65/C9mDJyQsNS6egOTWJB/SfHn9fmD3VNT5d/puEy2B0A/FO/
	 ReusSvpOtJYEju3vY908H4K0BWpVpOYNG8cWMXRDAMHNG9+05K/XV913MDuHAYDjql9ei
	 f8Fz4CJErmqACIeGa79qwkVMYULdRSs2Ra9zjm9i0x5jeivd9zKZakBkf4MvSOzUkHobz
	 0vcO1zGUCcNVnNovzgQkZBreitqL13o6zjxd++2KwcJklBLpzFrL+REgeXhJIlHH/byN0
	 yy/2FcdODkd4er/KUiWTct0me94jMm6w7C8Xk8OtV/duq2mTYRFLx5XO0FG0QQNf9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238529;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=E+RBQbTZkfJ423Bx1HUuqPZK54e4pHmAvwIXxuVWVqk=;
	b=xvPOUdEeA0avpNU9nIbWQBivfLpIQeSSud8Svpdf03rbx1+sp9kx510y2ZX7yJ1e/Re5
	 FomW4NLkC3BdsICt7KenKn0iOgojQSNFyjfjSL4SpjtVSsaAO82p7ekZxBVBfm8wjsfJN
	 zcTZzfPjpU36bstpsip+vDkO4zXfUXor4mj3AbJmDB+OgnVgx42AdAeGZmY4j3srYC2xz
	 lrkayH6af2C5Fl54AYhTjucdfDok74tcy+f5GjyndGbveTeEQEMochd3fT49dcuxiqIEq
	 HUlFf6yVcb7PWkuNFx9gP/CY5j5K0igcuPpZGwRSo+RxL7X78mtpNqAF1gVh8h6eRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=UoBW80IF;
	arc=none smtp.remote-ip=109.224.244.117
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642B606A31C;
	Mon,  9 Nov 2026 15:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A642B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=UoBW80IF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794238524; x=1794497724;
	bh=E+RBQbTZkfJ423Bx1HUuqPZK54e4pHmAvwIXxuVWVqk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UoBW80IFIi3JqPBMEq8oRKKb9++BRkkZ33tzycA6JNQ8KupN2KlFLuKd9ezvz3aXk
	 XXvmeDwXMkKndcQ1fGrBm9TjTkbnnxPFx8/ZZwI0tLVGZrSqZcE7EzsEJcbjcv2N89
	 A0xmcSagqQ1H4vYEAdhq4FE0AEGHtcu0oiz14WchrQNYfSwhAwPyTHN1Prx+eoZrua
	 GFY3d3toj15rQFd5F3n/+J5n5VfhzbCSLr4Ks2Fn3kL8C60+j2MWJ6r4SeLB4g06wm
	 9u0KL22AKApp7SQlnKw/sPzjjghOnaopDjvsxFWXcF2vdAeZh+sl3XnrdNSK0DbuvA
	 lTECSqMylaxuw==
Date: Mon, 09 Nov 2026 15:35:19 +0000
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Kees Cook <kees@kernel.org>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Hillf Danton <hdanton@sina.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, Francis Perron <francis@akrites.dev>, tgopinath@linux.microsoft.com
Subject: Re: [PATCH] Input: uinput - fix use-after-free of FF requests in ioctl handlers
Message-ID: <20261109153513.601686-2-ca@modelmiser.com>
In-Reply-To: <20261013051553.71887-1-cenzhang@linux.microsoft.com>
References: <20261013051553.71887-1-cenzhang@linux.microsoft.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 4e72bd8c8d7ffef72b2261dbcb97c408c7586ad9
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
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026, Cen Zhang (Microsoft) wrote:
> An easy-to-hit case: two processes sharing a uinput fd and both issuing
> UI_END_FF_UPLOAD for the same request id crash a KASAN kernel within
> seconds.

Tested on mainline d48723711bae (v7.4-rc1-672), where this still
applies, in QEMU with KASAN, lockdep and kmemleak. A test program
creates a uinput device with FF_RUMBLE, uploads and erases effects
through its evdev node, and answers the requests through /dev/uinput.

Without the patch, a variant of the case above reproduces at once: a
handler process answering each request while two other processes sharing
the uinput fd issue UI_END_FF_UPLOAD and UI_END_FF_ERASE for every id
gives "BUG: spinlock wrong CPU" from UI_END_FF_UPLOAD, then a NULL
pointer dereference in ttwu_queue_wakelist() under complete() from
UI_END_FF_ERASE, and the guest locks up. The BEGIN side fails too: two
processes issuing UI_BEGIN_FF_UPLOAD while the handler answers give a
general protection fault in uinput_ioctl_handler() within seconds.

With the patch there are no KASAN, lockdep, oops or kmemleak reports.
Each race ran for 20 s, and both together for another 20 s. Over a
million requests were answered. Duplicate BEGIN and END calls either
succeeded, while the request was still in its slot, or got -EINVAL once
it had been released. KASAN does not see stack use-after-return, so
without the patch it caught only what followed the corruption; "clean"
here means no crash or corruption.

Normal use still works: an upload and an erase complete, a negative
retval from the handler (-ENOSPC) comes back from EVIOCSFF, BEGIN on an
idle slot and END on an out-of-range id return -EINVAL, and an
unanswered upload times out with -ETIMEDOUT after 30 s, after which
answering it returns -EINVAL. The timeout case behaves the same without
the patch.

I also ran 300 rounds of UI_DEV_DESTROY while one process uploaded
effects in a loop and another ended every slot. That was clean with the
patch, but also clean without it, so it does not show the flush window
either way.

Not tested: KCSAN. The double-END runs did reach the window the
automated review describes for request->retval (about 540k ENDs
succeeded on a request already answered but not yet released), but every
answer used retval 0, so a wrong value would not have shown. Also not
tested: the compat ioctls, UI_BEGIN_FF_ERASE racing, an END landing
between a timeout and the slot release, real force-feedback hardware or
applications, and module unload (uinput was built in). Only x86_64 with
4 vCPUs.

The harness and this report were produced with an AI assistant (Claude
Opus 5.5), which also did the earlier runs, including the unpatched
comparison. I ran the final version on the patched kernel myself and got
the same results. The harness is available on request.

Tested-by: Chad Aldreda <ca@modelmiser.com>

