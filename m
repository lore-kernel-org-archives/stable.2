Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427672;
	b=IMSTNSPYdNGtN6FmqLIR+Y3BFjNLPBmYJpRfFfXNuBP8dIU40g8FHlwsk8TFJOx/aePu
	 eZ2RkcJOlDgJPxb1xgl/YW2nGE3A3wwuLYKZ5JVYwbKqchnIKNkhamcmWSWBOwD1s4eeY
	 KFiFARsRJx4iht0HVhCBQbX7k9hmg9LsLH5OgDMd7Nw9rLtw9ur+46Q8Cs+YOOHHbeWxy
	 5KUDaPzpb9xuhjPgPM69Z+d6M5f6Z+a1X2SBX6XcK56GrjwXZ3xVlMTWNXkGmWJ3f9ROD
	 AOA6HE4mS4oIzg2uNA3yhBv1PfxWCk2bK+WE3HVq1HjETJZhKJ7blQGmGyT2n5G/gsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=5EMCD1rtKeIzP4pmI2Kq0aEOHvbQvIVCDlgtYyGqRvY=;
	b=YCDcNaCqFqf3u/cx2Pb9vDZB2MKUleMeT9o7AQM6yrCcxDR0AcC8XJ/X9nl0+GS5Mv9d
	 fwM497RinoEL2+e44H/OIf0Tn5uVShUcc5slUSDx1gp9worIn+sbvEHRnApnzMkRVE7nK
	 bM7EL9poQXH40IxJzNEhiyBwZdh+WUOQtds4cGDhSSVrUOtunLZP6vil8+2++tOaxDnID
	 /IXcjvhtLL1/gZAzpCN6TsHgh/+OVKF2+uQQDKItEVRPJvBZe4g/y7aJ14Ii2PvIllirg
	 op9TFD9Z2moKAnH+oeM+tCdDsbJoE0fxRS9mBEskwkqbE57FAt5IECvJs84PeR7x30w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ib994pDE;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8264606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8264606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ib994pDE
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso1358205a12.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794427671; x=1795032471; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5EMCD1rtKeIzP4pmI2Kq0aEOHvbQvIVCDlgtYyGqRvY=;
        b=Ib994pDE2Q7BaLhj22bPoqfOJhpjDDRFZvrAJjF7ehEjzTVOj9cWTjN5eyCaRLx9Do
         uaS2NF2dBOoNhOHaCI9cq6B0c4DpZT44Hwg4BXixTHzx/hoKZRKbUk2vfdj9GyW29j7f
         U4BAO1G3gUuj8dyUyzwVofzhK55MVd3KDdmWW0CyJi7QEjT+RRSF0k5VKFhX7ObI7VYH
         ZihBiev0hpknq2qZjGUOhL6B6WeIU89r6TxdMuT5YsT29F1WLV/aGEEzx20tAeRGPyaL
         zxhqro5AjHVmfqcVxw1iU2Dd3YE+92tQUea9yMj1bQgdPsP8FxxF9dTN/JDZEZO6Q3mi
         hP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427671; x=1795032471;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EMCD1rtKeIzP4pmI2Kq0aEOHvbQvIVCDlgtYyGqRvY=;
        b=1ple/bfGRpgg//x18LCnQiO7fYlVJn24LcXexh1JmfOH0MyvUqspJH4xiEHTxg5lbu
         Bjy+NgofMyponVQCR8ALxKyEy8WQfLseJf9vf2wgA6Pt+UV/754EtKHVxWhbXl2+XUxl
         GG4bLwr83fKfR/zts4gRYIRkYQh9U0qR9C39jEKjSZKcic6WbN3LDmo39L69n8YrX1qo
         lBYyXIfWUmBMOJHtTMnXWbw6c+VnwL/o5Buean1DfbMpa6fiBfRI6FTWpcs5inukyJov
         VQip1/I+j8aB6sIq3FhTqBlELq05cGhm4igEOvoTjBcQPp3Grh3ywenX2kHWgprOma1l
         jbYg==
X-Forwarded-Encrypted: i=1; AL+hErEFvkENZKe+A8LmmodQibaFi1k93Jgeg7BTdR9/S9oxV6IaiSOjT8FJO386+sIfyEuqo/XIsEc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jB8aEMu4PvFke/kCqV6uqO0PrhIerJKfM19iMKL7bVPqPZxjE
	+A1J9raGahhTWvdygCw8U9SK/eSq7XRHZDGi58U6/lh17o6UhwhEnJ6I76CDuCmyxw==
X-Gm-Gg: AYBFou3pYizYByti73TtAm3G1Xvo1bAeUw3A9I0tI58JJRXwsNOuEMAVoz2F3Jw2iLG
	BLpkWWkL5JpGNIhxn9oPzH+H6nNfou5SSrfGE3cIuIFZdO82L7lOd5pq0XitPPnvjmXN4dueMHa
	LnANoASUZyXzP7Nl1kA6LuRWkfTT1lC9FltnVeqemr+cGG5NkFyiT7gX5S8M9kgikVzJ7csKjx1
	o/nztVoFvyVah/EfsU90jKWVn/Txf3x60yfwzcL45LIZ+shuww0kVmSDehTHfeyTZCzt+aB1Bs7
	MMsKEwOmmfVkGisZ6NNFX8Lz/mhpfsLbInwxPJ5RY4tngCtItDLI62lkXmSlL2sud3KHRCu7FAw
	WA1BRD6QmqCnQyjq+4dAYd5B/n6eFbUzkt+m4fgu+nOgkx+RMJyS0SHf0RLt/wm0nbd3UDJaVm1
	w24i9VLfGjGeNWzqLvPjB1Vm9FrSAvPI6KRoGEuCN4atmcsuS6HyysViql4AeqrRsVO3LkHPf7Y
	mFVRizFWj52UB0mWtaNsrKV5wNjonPPoxwu3+TZsLoGT/0o5Cbzdh+4Qz8Ot32w1Im2wHWIqYJK
	yEVGSriGX2bmIKRJlciqKGoB+GQpfb/g/1tAztNy3/Up+/A1c7fUNpb0tKeskix4
X-Received: by 2002:a17:90b:5101:b0:3b1:64d3:f308 with SMTP id 98e67ed59e1d1-3b182f8511amr3538560a91.43.1794427669947;
        Wed, 11 Nov 2026 12:07:49 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27cf1sm691230a91.12.2026.11.11.12.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 12:07:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 12:07:48 -0800
Message-Id: <DMSNIQJ9G6P3.2L2X6PDV6QBGA@google.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>, "Abhishek
 Sahu" <abhsahu@nvidia.com>, "Raghavendra Rao Ananta" <rananta@google.com>,
 "Shuah Khan" <shuah@kernel.org>
Subject: Re: [PATCH 4/5] vfio: selftests: Add sysfs_kernel_warn_count_get()
From: "David Matlack" <dmatlack@google.com>
To: "Alex Williamson" <alex@shazbot.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261029203324.1637772-1-dmatlack@google.com>
 <20261029203324.1637772-5-dmatlack@google.com>
 <20261110103434.48709eba@shazbot.org>
In-Reply-To: <20261110103434.48709eba@shazbot.org>

On Tue Nov 10, 2026 at 9:34 AM PST, Alex Williamson wrote:
> On Thu, 29 Oct 2026 20:33:23 +0000
> David Matlack <dmatlack@google.com> wrote:
>
>> Add a helper to read /sys/kernel/warn_count, which counts the number of
>> warnings (e.g. WARN(), KASAN, and UBSAN reports) the kernel has
>> encountered since boot. Return a negative value if the file does not
>> exist, e.g. on kernels that predate it.
>>=20
>> Factor the code to read an integer from a sysfs file out of
>> sysfs_val_get_int() so that it can be shared by both helpers.
>>=20
>> This will be used in a subsequent commit to detect kernel warnings
>> triggered by tests.
>>=20
>> Signed-off-by: David Matlack <dmatlack@google.com>
>> ---
>>  .../vfio/lib/include/libvfio/sysfs.h          |  7 +++++++
>>  tools/testing/selftests/vfio/lib/sysfs.c      | 19 +++++++++++++++----
>>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> I have a concern with this approach.  I run selftests in parallel as
> much as possible, using multiple devices, each targeted at specific
> tests, with other functional and performance tests running
> concurrently.  When wiring this into my harness, I initially saw a
> failure, but can't reproduce and have no log from the original event.
>
> I've updated my local CI to keep a console log so that I might have a
> chance of chasing the next instance, but I don't much like the fact
> that any warning occurring concurrently with this test can trigger a
> failure and the test doesn't provide anything to go on in the test logs
> themselves.  Thanks,

Thanks for trying this out and the report.

What do you think about keeping warn_count to detect warnings, but also
reading /dev/kmsg so the failure details are captured?

 - In setup, record warn_count and open /dev/kmsg and seek to the end.

 - In teardown, if warn_count changed, read the new /dev/kmsg records
   and print the kernel warning reports (WARNING:, BUG:, KASAN, UBSAN,
   etc.), including their call traces, into the test log before
   failing.

That way, if the check fails, the test log would show exactly what
fired and you could tell right away whether it came from VFIO or from
something else running concurrently.

To avoid breaking setups like yours that run lots of tests in
parallel, we could also make failing on warnings opt-in via an
environment variable, so by default the test only logs the reports.

Alternatively we could just say warn checking should be up to the user.
