Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248740;
	b=jyrST6RfyFBWfA5iJguD34+psPqMkJT/JHXUlJneyEiaDhdObfdhuTG5O+k4Q3m1aGwT
	 9zBsM3Zi18plHXC0cmZQKsuJ1jVRO+B7tABxIro9Tee9owGPu8HxZ7ZRIcUUKCUzc17RS
	 6IFWJ9V6GESmhiZhUrQ9rJKAZ5TVnqKWgYmukKD/oF7/VE3cT3Qz86/ZDqhwp3+ChAFWa
	 587Bdnom6KnnF8OuLxhrOlEvMKqrrxGjUMJhwYtLFjckYv1huCuucTLGYDNrl4u2UI2OK
	 bmzZO5NufXRp7uTCyXdZmiNB8wj8hX4tB2uZGNp+yWtYRAgHmduDunnHmiGlEOR0BMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248740;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vrr3J9jDAWoXxoZTgAde8TMfIdLINczImmqo7qPCG5k=;
	b=viYTGK/a3bE4v13LqER1EZPG+0gJmHcHxcm80rbO8aX8QpqZ5Q8X1JQ9z5DTkCk/EprC
	 UkJaIr4YCiB37H+8TVLW+9ghv8JAxmF539xkn47WbFMfjTeQikkvFn1ZPoWDWK8TS6Gut
	 PC+exTZVaciyFmRQDXSZudNYNP7fbKIf0ARgY92C+Ycjk4KEzwf5qwVlcOJw58WaDHOvc
	 L2N4TaskcXLoC1Npdr2IqN4LcGx7nXb0MFj8/UCXEYOGri7CZhvKSIM3o5qjpdDBlgcys
	 ohEnff772jSc/nPLfkDjP1pW2LSiDEUqqdk3Nha8HRQNSvQOk+K9ug79VRBxc35EQGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=cAH0VmGV;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED7606A333
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2ED7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=cAH0VmGV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794248736; x=1794507936;
	bh=vrr3J9jDAWoXxoZTgAde8TMfIdLINczImmqo7qPCG5k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cAH0VmGVfZUyJQFNTm5B6ui1k0DcPTiXyIcojdtuTA92cKAIH7rjzOSRxBxs9wA+y
	 UibHcKk87hShMTrz9orYeKJy3vJAw68hWr3YdlS27c6qcDLYPB7H3l7MA7R2gpfPgr
	 bipA8iL/+Qkacef9Nn5ZcNrfJ+2JMEtX1ntWFnY8dOnqrLZ1rS8BrySyqsv3VRdlTo
	 vqUkMh7nmk+1ALYfkqftuY4ZqMYlrubdCQIIZbfa1KcV3yR30Gdbf+0uaNOFmSAoR2
	 agflVbUn3lVRZKN60Z8hZ2JMoFyIISgYYhB+I3OQ+9VDsX4SRHYGmMgIK8CgROil4s
	 oqp3ybM3tOMoQ==
Date: Mon, 09 Nov 2026 18:25:31 +0000
To: Jinmo Yang <jinmo44.yang@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, alhouseenyousef@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] HID: hidraw: fix use-after-free and double free on disconnect
Message-ID: <20261109182524.743597-2-ca@modelmiser.com>
In-Reply-To: <20261010230108.107272-1-jinmo44.yang@gmail.com>
References: <20261010230108.107272-1-jinmo44.yang@gmail.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 25868f462026df30b04c5f654ce7c6d3272adeea
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

On Sun, 11 Oct 2026, Jinmo Yang wrote:
> hidraw_report_event() dereferences hid->hidraw with nothing keeping the
> object alive, and hidraw_disconnect() frees it without clearing the
> pointer:

Tested on mainline d48723711bae (v7.4-rc1-672), on x86_64 in QEMU (4
vCPUs) with KASAN, lockdep, DEBUG_LIST and kmemleak, and without a
window-widening patch. A test program creates two uhid devices with the
Wacom vendor ID that bind hid-wacom as generic pen and touch siblings.
The pen device's descriptor has the WACOM_HID_WD_MODE_CHANGE usage, so a
report that toggles it schedules wacom_mode_change_work(), which stops
and restarts both devices.

Without the patch, toggling that bit about every 2 ms for 20 s (about
9,400 reports, nothing else sent) gave slab-use-after-free reports
reached from hidraw_report_event() in every run (5 of 5; 31 to 61 KASAN
reports per run, which looks like 2 to 4 hits of about 15 reports each),
on an object freed by hidraw_disconnect() <- hid_disconnect() <-
hid_hw_stop() <- wacom_mode_change_work(). The free path matches your
trace, and it reproduces without any window-widening delay.

With the patch, 11 runs of the same (220 s in all) had no KASAN, lockdep
or DEBUG_LIST reports. kmemleak listed unreferenced objects after 2 of
those 11 runs, and after 3 of the 4 unpatched runs that got as far as
the scan; I have not looked at what they are. About 18 million pen and
touch reports over 20 s without any mode changes gave no KASAN, lockdep
or DEBUG_LIST reports with or without the patch.

Sending pen and touch reports while the mode is toggling oopses the
kernel within seconds with or without the patch. In every such run the
first fault is the same NULL pointer dereference in wacom_wac_event(),
called from wacom_wac_report(), and the later reports are on a tainted
kernel. That is in hid-wacom, in a function your v4 NULL-input series
does not change, and after it those runs say nothing about hidraw.

Not tested: the double-free hunk (I never saw two teardowns of the same
device overlap), the NULL check on its own without the RCU change,
reading an open hidraw node during teardown (attempted, but the
hid-wacom fault above comes first), transports that deliver reports from
interrupt context, real hardware, arm64, and module unload (everything
was built in).

The harness and this report were produced with an AI assistant (Claude
Opus 5.5), which also did the earlier runs, including the unpatched
comparison. I ran the final version on the patched kernel myself and got
the same results. The harness is available on request.

Tested-by: Chad Aldreda <ca@modelmiser.com>

