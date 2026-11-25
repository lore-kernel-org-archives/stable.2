Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566720;
	b=jPBWx1QI8TCNPtLIDuxxhz5x9Bll+y8htRJhStoyzH6x7fNiprELzaGrcpFO026RrRU1
	 9EOi8luTcD2WMKiLesIoaIigLxjZPPzEpsPkIMbdSA68lraD0RvqYYGONmKFdOg24jUF7
	 0dfnf40XnTwI8iIXtfqzKzqFHRidw74H2r2iesbNBTBM4xISjB3tbU2oeC/DouWQwZVQe
	 89KWMMai4EETLnS9Je9P/4vc1kXSuVFFd3naFHEfraoWtRbllWQnSSGqV+ktU/zHEn935
	 +DLzIBL2dsdbnjJKtm/36bYkwW6oziGwSo2vqSX7HFwHSsVfTTrDgLXZT0LTO7K4VYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Gcn9k5RyT2SrLf7rw1mzgR9U0hO9J3AKAxDoC8pAHaE=;
	b=sy/ZC3oOH+WS6XZ0yl9igEKaJHbWO6vPMWNokfl8vXHfdlAwek+H8ePI0qUNtwOMVq2o
	 tDpjmD60hfQe2CawoUC6nY/uhMfpArI+zbZUDShpyPYGTRej1K7qli2/oxNMb3/Ntk0bN
	 iLLGN0M9Sdik7qbC6i1MFBwr0du6/NYt/B8YiDDbgsT2+zMn/Gm0g8vGAzVM58fNm71E8
	 +buy8GZjnhL1gzr6xhSDicTE+8zi0ohtIr5VGaTLKU1+SUI1k2dJGImd481wgO/AQVtak
	 mRRlYXGvzrgIg1Oia2KPZ40OGcM9RPMFCkhfbGzI6+/987ByviNWTHV46Z6MX/neOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--willemb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XQwmHO9u;
	arc=none smtp.remote-ip=209.85.222.199
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF6D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willemb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XQwmHO9u
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f33438950so901421185a.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795566719; x=1796171519; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gcn9k5RyT2SrLf7rw1mzgR9U0hO9J3AKAxDoC8pAHaE=;
        b=XQwmHO9u+G4hYbfjQQeoBtP0836u6rFMOum3quZGgd8jUKrOktAJVwEQuog3RtOmR0
         /ry4sUgmBhTa0VJ+gsXi2il8IjEVQbkCKgqIxFm4In+weX8rQHoGRHvzFqFzB3Kd6WtV
         Z5pZ94I09jYptL+vsSsRoXLBbi0yhwV3eCUMhQmYwmHJdSpC5cWLLWezW+If2da9/l9s
         9IP7EBTwCDSaVwLhAYHmD5Pd5QyzOhLzNqf9+H1zdirHMjrf4TBLtNCd/Ni65Rxt0TfX
         vS8nYnwvKz0RUdhL+Obbgtl1ieYbZFd82+sbfUP9wroXnbE4hVHL3U7XXMoLZ43y2iQJ
         uO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566719; x=1796171519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gcn9k5RyT2SrLf7rw1mzgR9U0hO9J3AKAxDoC8pAHaE=;
        b=eFC9RE1XdHYDxIkaih0tF6/7TDdDJ1rlINa7uDtIXm7l3tIJ3ajzLXgG8u8oxHqhrO
         xQH+CVrINqtIXASBzcQlsVPDtwSKidGWY4y5ArUnOKpiDtjFZJSN5hS4uB3AayyWo1mW
         6x3QdXPgflxAttpfV2vIsr1jHsNEBNcIRpvTyWUXDZBG2WwqhvHPb5lzGEtohZGYFu1Q
         yEPWs69zVgY0DFMmQA5IjC9eR8hCfr/06mmJgD9DNZeDhucMmf1VmxVFeyXQXKltTun1
         M6/4oqNhbEjOyA7/VUpdDMrGHh/8ZhNP8Vz5RBtgncmh7ZJCoefXCM8HiaBkVkyljkk1
         hH5A==
X-Forwarded-Encrypted: i=1; AL+hErFZPt9j6Ty3Y7aaxC+T/Xwe8CGZySEpokZq0DLkOD6WXAF60uMU82k4kLRHWCJPr9dIUuS3tYU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XcwIxnFeTskCIb4EFDt80pN7jkX1ZmvaWiPL4O5xcGbtA4Mk7
	V0Vy7IIwvxL11bDn3Dc29mOYm/vj6XhCP6BOex5V/Fmjpw+oDw+MmHeU8MsrvKZNvagUjM23+Ld
	X7srFoxya+g==
X-Received: from qvbld10.prod.google.com ([2002:a05:6214:418a:b0:921:2ee8:44dd])
 (user=willemb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:6f0d:b0:939:6dea:374d
 with SMTP id af79cd13be357-949ba9d1fa6mr2800574685a.49.1795566718729; Tue, 24
 Nov 2026 16:31:58 -0800 (PST)
Date: Tue, 24 Nov 2026 19:31:58 -0500
In-Reply-To: <20261118143500.dualpi2.1.543a9a1be910-zhiqizhangg@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118143500.dualpi2.0.543a9a1be910-zhiqizhangg@gmail.com> <20261118143500.dualpi2.1.543a9a1be910-zhiqizhangg@gmail.com>
Message-ID: <willemb.4158a0ba73d8@google.com>
Subject: Re: [PATCH net 1/2] net/sched: dualpi2: refresh head timestamps after trimming
From: willemb@google.com
To: Zhiqi Zhang <zhiqizhangg@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, koen.de_schepper@nokia-bell-labs.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Zhiqi Zhang wrote:
> Reducing limit or memory_limit in dualpi2_change() removes packets with
> qdisc_dequeue_internal(), bypassing the timestamp refresh performed by
> dequeue_packet(). The cached c_head_ts and l_head_ts can therefore refer
> to a packet that has already been removed. If a queue is drained, its
> timestamp remains nonzero.

> get_queue_delays() continues reporting an increasing delay for the empty
> queue, and calculate_probability() uses that delay as input to the PI2
> controller. Partially trimmed queues also report the delay of the old
> head instead of the retained head.

> Refresh both cached timestamps from the internal queue heads after the
> trim loop, while still holding the qdisc tree lock. head_enqueue_time()
> returns zero when the corresponding queue is empty.

> I identified this issue and reviewed the fix. I used OpenAI Codex for
> root-cause analysis, drafting the fix and this changelog, and assistance
> with regression-test development. Codex also performed automated
> validation; the archived results are described below.

> I reproduced the issue using Codex-assisted automated tests on an
> unmodified arm64 net-tree kernel in QEMU, with real AF_PACKET traffic
> in an isolated network namespace and HFSC ls/ul shaping to retain
> packets. No source changes or fault injection were
> used to trigger the bug. The companion kernel selftest covers C/L
> dequeue, full and partial trimming, mixed queues and no-trim changes:
> the baseline passes three controls and fails eight trimming checks;
> the fixed kernel passes all 11. Runtime coverage is this DualPI2 selftest
> on arm64. I also used Codex to build arm64 Images and compile the modified
> object with W=1; additional build coverage is in the cover letter.

> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>

The selftest flagged checkpatch issues. It is also many LoC if only
testing a single small issue. LLMs are good at generating tests, we
cannot include all.

Let's also include the original author.

pw-bot: cr
