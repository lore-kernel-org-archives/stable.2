Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649483;
	b=h1TrhgE7Mz6cxjwrC+XMx89uTJ7L7x6Bzwxmzti4uEYKOpWrBED7iIPOjSZHKMP/Csmg
	 tcQwnYf8dBZEQm1PDAam+CylKabAGAYZkkPiIyvlKrUYSQDvnsBhfV6oY6l1BYYfVBeFF
	 FpyQuBANGGvSXdKMcTjtChlb2iwlXr7X+dtPeanxBeeZQkOe7s1X/lQ+OlGMlZ1UOZuM9
	 s7/tNO61qC6KJxlWJchI8VLpOJPwbfWOpcGUOBCcYoKadyEQop0FhVtbuWVM9iXJQhLyg
	 ALeR/J81WuDzUZh0whHcFfdE3g+3TsxXJ569ViUaJZ/uGUR0Q1/CIDreEcEiGcShhkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/ZtgARPu379mLd6QbSu5w/3cZo17qHpWETtyZC6BRtE=;
	b=vrffcyZ9tO6naABJuijsFKPQ8mn/d+2EaNKWfMQx2YpxoOnNmZNbK9DqQNf3qhCJBXH+
	 OWQ+LKUIszs2NV8+agFN0dG3W04us9iMOqEs6mhY5xjlqQKpenqS+fEJw50yIm7OM4P9L
	 sJZXuV/suyKPsIgVPbcq76h7F6EKSrh59rzAUs5NisesuUTQYuxJ7j/wNeWgC2U4J1NNL
	 gLhaAndwy4CQv9wN0vLWusGfBAn6Nwm8hoNnyQbRy/q24xttGaiXt7NZzK0Ud0oTRsHTF
	 5w6ouM6FAg7rJKBp0cCLX8d4fZyCo54ON37k/AFK5Sx7Ww8+go8mT9LwPDwbRv9oSTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Etw1usMc;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31256606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31256606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Etw1usMc
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso13177658a12.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795649481; x=1796254281; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZtgARPu379mLd6QbSu5w/3cZo17qHpWETtyZC6BRtE=;
        b=Etw1usMcblqCO3PinEaDwsNBIFfJ2R3bcanX/VT2bD6spbWXgs4VMDGUWXITmEzF6l
         4cKuhjSQww9QCE9PiuHa0LDpfymmbEJ+aGkTLBUteHROqzGGXddaiwL8Ae04N/ksy9Si
         +Mag1Nerdbq310xTftvr6cmB5ax480VS+WF8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649481; x=1796254281;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ZtgARPu379mLd6QbSu5w/3cZo17qHpWETtyZC6BRtE=;
        b=kdjjTQqJw+u5oAo0nBjw9/S8UGzOCWsLqSBWvyqrPjK/duHIZAlayN8GDx5I+IStGO
         CdfQ9v9vlkCfA+0lWvjDlFwHKue/zx0IXtCQGB6u04xLzDMXM7VcJNCNsXb6lgoi/JvR
         jlwzMPmR2BZolqGohrtHxnqrZFbA8ruOuuC28mnt6bvx4zpdvFTxZRTALE8h7cVxePy6
         SqO/Lf1ENjqRcm/9QXzTLuX5UzgbOyKElqGyt4k36OhPY5XRmSiyH90VMwgfLnGjLIXQ
         NVfOL8BOhtSs8nYnvah/FtjPhcxBiKBidHW9Lkul98UbkCiqvAM2bnQu/ID8QODJyK+s
         zFmw==
X-Forwarded-Encrypted: i=1; AL+hErHacYPyF903XiQK4+W+ORDtKsWKQ1aFVNaO1wRbx2NXWD6J476NDcsffmTASo8BqXjm1vU0UF8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+od1qqoJkdOYhxgzjQcrFmDQYcxdFdwM8Xq7Dfp7SZMvVpNahY
	VE+CTCjFAxCFE0NYw2dtZMz6glqOez/MeoXBcxBcGkHfcypICalaH8RHAnJOcrn23SSjv6Dsa2G
	xNhdVoiDpcw==
X-Gm-Gg: AZFdTZfQhOKV8ri96Hy66IeTbZBWUUVLrvFr5cqhlbeHdPo3MbjKVtaDoAFBFlyyWsm
	vPZ+OQw/B8Rr2l9/BsxjxhdbpF1PQcRUem2RQJBnf+VNJf2ruNxKbVOd4bAzOFMPny4QzuojBOQ
	HZlf7tUg59SEgjBaAGrD2A9hVzBAPg/gbvzRNyO1uG6XA6D4QksXJdEmJ9SlPqQk57Aszg4J6b3
	/7BXQvi339eQ8AFv3SJeSdSILnHG9KkIqFkCL7lKArX7NRG4FeToAD9zfnGp+dgEgJCmwaM3zVD
	o315Q66sA+8PWKbxrIYjsId7zVcVETA/Rks8YJFS5S/0x1k23+wm+PqnQPjh5REE5E1KESl3p7l
	w8hfTHDkQRABAaaMSoJ4mmKUa+7crASx9tmKqllJUdKf6WRIr5NmKk6evW/tuehN8GdYCrYmwpT
	TzBjDEOJnGK7YCf+DsqOStsZ7NqSgnyI+6xwK91xvnVWPEW4OJ6M8Pc0pHnPo+naN1env9USoBa
	E3Pdhfxp5pB+qrssHBTXwfJBPZh/Z/aT7MW9Xk+ok+MqkUjCExVHKQQBqKOMNMbLO589d6nb/sl
	DVB73Aagkn52NlWnGCZ+PSyMPncI6mxDuWe/DZrkbPzyrVtV6JVOC36wy3RUXa2DnkBPvSudfa+
	nrJ4=
X-Received: by 2002:aa7:d1c8:0:b0:6b7:37bf:13bf with SMTP id 4fb4d7f45d1cf-6ba1fadf982mr11884623a12.4.1795649481541;
        Wed, 25 Nov 2026 15:31:21 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d03f9e5sm2041145a12.24.2026.11.25.15.31.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 15:31:20 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so1328130466b.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:31:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHoK/JdDwF3rfmFJUl5ZSZe4SXBI5qtWC/c520HcVwI+eF810y0R8jCxXQSSJucp5xnZWvRKgY=@vger.kernel.org
X-Received: by 2002:a17:907:3e86:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c51315851d7mr1801088966b.4.1795649480354; Wed, 25 Nov 2026
 15:31:20 -0800 (PST)
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
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com> <awV66PQWrBOKcZCE@redhat.com>
In-Reply-To: <awV66PQWrBOKcZCE@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Nov 2026 15:31:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whanFATRSwcW9TCa+4zR=k_QnNFtgxnFCg1d_vr6Ye=OA@mail.gmail.com>
X-Gm-Features: Aa3M54q0sE_qX8UjHHTquK89Ec1CONb0zaQmq3jckN_Jm8WAOhqo827YNI7zBIg
Message-ID: <CAHk-=whanFATRSwcW9TCa+4zR=k_QnNFtgxnFCg1d_vr6Ye=OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 03:54, Oleg Nesterov <oleg@redhat.com> wrote:
>
> This will change the current behaviour if ret < 0. Say wake_page_function() does
>
>         if (flags & WQ_FLAG_EXCLUSIVE) {
>                 if (test_bit(key->bit_nr, &key->folio->flags.f))
>                         return -1;

So I looked into this. We only have a couple of cases where waiters
return -1 to break out of the loop, and none of them have other
waiters.

In fact, I think that's pretty fundamental. The reason you'd return -1
is because you have made any other wakeups pointless.

The wake_page_function() is a good example of that: it returns -1 when
it has taken over the lock. That means that the page simply isn't
unlocked any more, and there is nothing else to wake up, because the
*reason* for the wakeup has fundamentally gone away.

But you're right that it's a differen tkind of case, so there's a
slightly expanded comment about it now in that "always queue new
waiters at the tail" commit.

And:

> Can't we at least cleanup __wake_up_common() ? See the patch below, I already
> sent it but it was ignored.

Yes. I've added that to the branch too. Maybe I should have added it
to the head, but I was lazy.

And I've updated some of the commits with reviewed-by and acked-by.
Maybe I should have added it to the head, but I was lazy.

               Linus
