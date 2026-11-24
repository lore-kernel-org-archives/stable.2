Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538318;
	b=Cxn2HIXAOlodZuX/5VmnAwCgbRABM6ZF9c0ocNyBZFkJ/qPxeGHv7LdLuCrRTLOgWU/s
	 5N7mjGAAttAo8YtUTetFrNsp4pz2D5rMCLq0bjIei+JiMdXmddbwIfJu7UyiPJNNWiz9n
	 RnMAMZI7E5J33jSHA4zuAhgWRLNQSJLgOb+QstEeNXL/pywVjiKi+SVWllYSmREakCWdz
	 sukMjRNTj+xSr3f4Eo8Bq9I54uyNlhcwZOneMWbu7YGw9UBKN2Ne1S2uAVxWsIzB3vD1/
	 X6pNzgeSxqnGXkOlMiI7sEPcD6XaaU4gAWMC+JYQEn+0dyuA7sYXlbvXjSuKdzAmaPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/EJeu8eqnYrieEoQuogN5jN7oNvPxu+IBN2eMIBR7Us=;
	b=QhgMNHdA9qQJqSBGlsGTfT/5zHK0Haubq98S6qQcjeGrVYKHTXFp4Y492Qn4Ztt4qeXr
	 F7/Gzj/WwKUv/QUm1QVdQdwo3MtMVFvh8p95ChnJGG+zPBSfLnfabm5uUhtuNrldy85CK
	 /KYgJ4fHMjdIk8Quek8L7keVgYfyvJThSGZ2O4YmZZJZMKVdHOA3IvED/hEI72ct8yA3q
	 PMb88gkYxVp6Udl9dgb8wp2qmond0yc9wYXNWfE6cHDPIQCtcBaZxsCJjDX923MU7FLBC
	 CAEn/XPjHd0ACcnGO7s8TtLFKBZXVxUZhvlv0DnQxlTkvDUaqi/DJMuG2xuvIpCNSCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SmXRxnky;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18F606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED18F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SmXRxnky
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50933bdf4bso939400166b.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795538316; x=1796143116; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/EJeu8eqnYrieEoQuogN5jN7oNvPxu+IBN2eMIBR7Us=;
        b=SmXRxnkyJOLfjP32m9hhuB7ThQS51Qqg4E8pnGZT731XzZv9AmeQPYedNc4kvhkkg9
         QgNtGVEqszVIACPOtKfyriOR/kb0aSARrq0rqH1Nt2PNgVjyHCS9An+G7RtbRXF3JiiI
         1LJN/DPgC0zS5NXRHTnDlSOh6GIFmg3ThLESg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538316; x=1796143116;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/EJeu8eqnYrieEoQuogN5jN7oNvPxu+IBN2eMIBR7Us=;
        b=2HvB3Dh7PRdU+a76C04B9G82J4wnNQ+T+YnsZxbtt/VDpZNl3bOgicQfhTrmwfUVBr
         HPafvt5CoYLtuQ9Ss99jbI35EKNkFeV91hgsOJLeIlqrUAOeAklDiOcXf+yTmLMyQp2w
         QH/VCegOoh2rPoNfbb1hMvytnjQN9hGV4dVeZ0mFvdA8Bepas3GfeAB/mX33ehzLjFQx
         mtn2oQBf271X9lQKiTkLDH0Nq7yFnOD3QK9PSW71k02H1Z/W1AcUw8YWh0PIoc+Gg/3X
         6T0HjNl18F3Og+3fB+BLkxfc3igtkUI4XJni8L3cMfV8dE04fKGLj/DI60LVa1aFQVM6
         D1FQ==
X-Forwarded-Encrypted: i=1; AL+hErGGo/TpJI/bNCb4ohob638rzXoEza/rjPE/eFCRXptA2FgfEoi97baJWRhUc3p8xiiKUqWYiL4=@vger.kernel.org
X-Gm-Message-State: APuU4Z976InPhDfU9GgPQiBvKGgU90/gg+EYoz0ogovsd8EPI3er3Jfp
	1P0V/ie16P4gD6XTXKGGVx0m4VhGxtychW58HF5B6mQKPAJoDmlMh1ErvgY6Xg0ll5Ah5Y7/Zyx
	/o4z2MTs=
X-Gm-Gg: AZFdTZfkKmCGegi1+4z65b6j6hTWTUr+B/pWMX/IucQ12gVhXFTIwa78YMiApB8p2ze
	xuhJkrrdgIKXl37wyGihunvv6VaTMeqYNfQ+W0+2KJBMj1H2TS/lkB01k3+umYoVqkLsmmbvs9n
	Duym3Cg52FqjBgZRfj3EGWcP3wa2AN+jRoCJj7rN06EW8vXj/DSc1MU0AVgbj+uNBlZgIhBJQ48
	wiuL6L0jxte6zM74V+J1v+Zw7LhG/kZMNsmnJZTL2rvjEPD155UG+jjA+wj/smLiaCYmbHtbkBa
	oAlnS71D4kL3cII7kwAdYuEWGSZ21gvYRBcHnsfcy9BPW9fSscnz5wNEEMo6dbseKlcsB7tcgdD
	93i0BsX5953bfoFlNQXXa+55ZZy88lpkJptiY4ZWExL9Zwi3j7N81Is5ORvEmbuuR/gE8Rbbi63
	MZwFS1Ck7HqogOCcy2B241Vd0HrISOfjC0LpodWudM6raQC0MFBFnqmWzjzRq0drn5qEkgUjX5s
	NP1yPzIM1ce+szSlJa1FKiRfW9gg9mEW70Iw9nGnvkzrvgJZU/XvCVU18Gfv8Ycs4TapWsiu/xU
	tO7CsQ9oj84Gh/7SYMsB7X5FOYj2IAtP8c44N7tE+fIT2+1lOdskbvVVyY9o5GhoTISQuT1PVZa
	9/2E=
X-Received: by 2002:a17:907:3f18:b0:c46:9711:e30e with SMTP id a640c23a62f3a-c5131a1601amr1321439166b.29.1795538316325;
        Tue, 24 Nov 2026 08:38:36 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3711ad52sm7130943a12.35.2026.11.24.08.38.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 08:38:35 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50933bdf4bso939394866b.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:38:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFqX/Fj6aBp56J64c5z7jPKwqUYIs4kNrXzhBa0BQa3ZwdRA4Lt1kTMlU+RuBk/UwA9+xToTCQ=@vger.kernel.org
X-Received: by 2002:a17:906:99c9:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c5131848f19mr1340338866b.14.1795538314950; Tue, 24 Nov 2026
 08:38:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com> <awWSwmvaTwBxfU-r@redhat.com>
In-Reply-To: <awWSwmvaTwBxfU-r@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Nov 2026 08:38:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
X-Gm-Features: Aa3M54rSVXLeJrh34QUL8f4_MzvjAY0ztkaZZD6rbZrwl4RoBJ3r5dHQUBjwBMQ
Message-ID: <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 05:36, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Well. It is not that I like this idea (and I bet neither you ;) but
> we can add WQ_FLAG_EPOLLEXCLUSIVE set by ep_ptable_queue_proc() and
> __io_queue_proc(), and change __wake_up_common() to check it

Yes. I called it WQ_FLAG_POLL_EXCLUSIVE. Let me send out a series
after I've cleaned it up a bit.

                 Linus
