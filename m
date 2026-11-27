Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789672;
	b=H6au50w1pIktOII2ieVrxn61huv1IkRyp0l69LwIeCypLbDeJp0Hn7PttXgy3rX6RvgI
	 SgCCU204bLmXpptf5jwNapiGAqBlPBSd1WI0ylE9uG9SpMxXimMVXzH1EDnKjTWQQH0wl
	 ZQGI+EWNvZPOeK3BAa69/Dh68YQgoz9qrU1naN5dMNblxSXP8kND6IaTdAZYRaQv6PzKr
	 92q7gRDHa1MhXyA1HftOPb3zCOcli+UlTtyrBZAGadXD5iFGZK0bpo2HrL1ylTRi2twSs
	 mratJYCnh037d+S6q23d73t75SEiGq7ffKpbTSVbfQC4L5donNLs2TWAnhmarnFAycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fmwxBbYiNPEFRVig1qeC7kHZSiWSAH+dmCLjzHg5iBo=;
	b=t6zrMGuoumnmEKPqhM9qYFB+HQgORlqzxW1vYSECSCCbWMMEvfJcPStMTr45XaCP2e9K
	 xC3o0IaVJbkus6GQoQFN7h3Knh1nUM9WqdHRjW+fwQdivNzdjCMkndYgM2hv95T3sobxH
	 TUHTcA2GrwS/EVnT9LuvmubLO5az6z8DuN25FdwQdOsHMp2Nl83gz3gTWVpaitxRmn28e
	 Iel55bzs9mR7a4QEpV4cFri+gIdOMEZMjlIQyW0XdTBd7hcpEsG2/Ph9d3ONn6R2QXKQf
	 KzAagyTkL06klIl4/KGS9Hkv0avBCxfkTlKxRqqftVA3GVl7cO+D7ypSMErxEL08DtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KhAvzGst;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A6606A721
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E04A6606A721
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KhAvzGst
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so6727155f8f.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795789670; x=1796394470; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmwxBbYiNPEFRVig1qeC7kHZSiWSAH+dmCLjzHg5iBo=;
        b=KhAvzGstpDXMZRfcStx9CvVCbkFHRYldWEODlqycEfI2+y47e7mxX2zpAPqbZ66Dov
         8HL/HOTbAdfVCrChbMSyA3OWeHTaLkCtnwaUThAUTuOfWeEB7D2V/UnVboSR6zywIesr
         +KFjPTF2vP1kvObXUDCnUjr4RZ0Xj9Pf7UMCKYVqr3UTlvL9/6niuop7i/YnnVQWXIoH
         jIN/leia+g8GIHyglhzUyZSFmCV3b/gq2/auS4EdN+AZ4LH8ftZ71mBD6P6HD6gHXsRY
         v593/ZvN9Au5rVsZF0/57Zrur8m/wYRTG+lDv0ny6FXFiKgjSgJdxNm7RhI5JYaEYZil
         Sdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789670; x=1796394470;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmwxBbYiNPEFRVig1qeC7kHZSiWSAH+dmCLjzHg5iBo=;
        b=uWffTrk5LVuVBLrCitbRbeAkoGEoD59TuVm+ysUkNcFeGD4IcRTApsvP+VSaWe8fc7
         gwUVIOJEKBvdkZROcwtbShsG2VPFNjwiKGEoh6Ia7EjQwuTCASHizfVfIu9cjFi68Fzs
         Wi6pRcB06ClwtVaflZEVLs7IqxlB4NkAkih9YYAYX0X41lRqiTgz4Iop7xGnfjqJd+wc
         q+0iAJKF8zHxdq31Ix5bMZLy5NTqYeKtpEB+yU3kFkSiTaWyXs5+D+DP7NTitimUyzNf
         HX76XcCsV9siDhYadAkjAu0t1NNw/u1bKluNQaz9Rt34R/e+fou7lWy4ioJltMEVSGFm
         CTrw==
X-Forwarded-Encrypted: i=1; AL+hErGIxi5MxIoERM/UwCNWXO/ag6+HG5R+Srk8Edz7UQvklLNbN0PNOSF5tJ62+uErEwN7InecZqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zMDFOxnvk/rdruqf0C/zD6u7HSAfXSaaAPcyXupSxWgA6YKfZ
	JWC0vykWAHZT8oYsDwP1ymELGmzNj7Rnenl6BgiYALXI+tArgpS6yCfJhEkqQVjmPETIOFNNA0R
	NLpsEgQPqRCw2wbxXAg==
X-Received: from wrqv17.prod.google.com ([2002:a5d:4b11:0:b0:48d:efd3:32b4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8210:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4bb887865b5mr500739915e9.0.1795789669930;
 Fri, 27 Nov 2026 06:27:49 -0800 (PST)
Date: Fri, 27 Nov 2026 14:27:48 +0000
In-Reply-To: <20261127102232.74796-1-adhyanshverma2010@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261127102232.74796-1-adhyanshverma2010@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127142748.1874983-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust_binder: retry ready threads or fallback to proc
 queue on dead thread
From: Alice Ryhl <aliceryhl@google.com>
To: Adhyansh Verma <adhyanshverma2010@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 27, 2026 at 03:52:32PM +0530, Adhyansh Verma wrote:
> When ProcessInner::push_work() attempts to deliver work to a waiting
> thread from ready_threads, it previously checked only the first thread
> with an 'if let'. If that thread has exited while waiting in the pool,
> thread.push_work_inner() returns PushWorkRes::FailedDead(work).

A thread in `ready_threads` can never be dead: `Thread::release()` is
only called from `BINDER_THREAD_EXIT` on `current` (which cannot be
sleeping in `Thread::get_work()` with a `Registration` active) or from
`Process::deferred_release()` after `ready_threads` is already emptied.

So this case is unreachable, and I don't think we need this change.

Alice
