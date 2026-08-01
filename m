Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245C3B71BB
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605710; cv=none; b=AWV8Ttk7nhqM+Ip5nm57thNcJ2qluC+CwEjYx8qlT2VaAcmAx+63ua+PfPw3NZ6K8aMi+W0L7zNamfiSsODzO/Ae4ub1M3zSERkvFz/Q/R7DA02zuz42VtXciz0iePQJcRyqLXxPEdlZT5mmE12k4XmRMxMyYL5HEPQX2pAa44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605710; c=relaxed/simple;
	bh=qrkQjH/yPS0Ki/jy3KZEKed04xYWuEysIpsTesxuj9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D1FVSFFAFIp/F5z8043ciKj9ViGHR1YGcP64BnzRLt7TM/4Yh/xu4WU+3lgOsWQGW04D/NSxQBE1tXmrtqICRDZYY81GZZKtGwIDn/ZkaL9ZMYg8XLKTnI5QDy8sfGb3vqjFaqlg3fW2PASua+H5pdkpC5+9JEiIEVYsgcQj/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw+Xa1p8; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw+Xa1p8"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso647362f8f.1
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785605706; x=1786210506; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ug8010ZyC+kV7fl3Lgjmm0rAlYJx/RD0vaE5unAL+gA=;
        b=Rw+Xa1p8b+Q79mnXdJ3t5QFA2uR/kKEh6P6I2IoRK6Rd92rsgaZLhgvhvbm0jCOONX
         aHeGv00bIRehPZdrWYaGE0j06rj/RX8uz39hyuV+nkRv9NVc7I9A+y1ScfHGMxrEg9hp
         n+Bp4SUWZGV2YwpUu59Wns178tBo7etr4lNs1mzuD4qy6plxhYuVx1U4FVwve+9LrAQv
         9RNFLHT0wkX707mSzZFDhXuHGBcEwNN7ahUuQuyISR8T40BNM4/0ZlayqG74B8J43eBj
         wiSwRw+mKONjCCUKACsLoV+6xofUDY9/EklE3b1oVuYTyVaNgd2mM3oKz1a7MWcof9q1
         8X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785605706; x=1786210506;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ug8010ZyC+kV7fl3Lgjmm0rAlYJx/RD0vaE5unAL+gA=;
        b=kwNZGGH66AyJTY9PLwRji4e5RdzpYk5ytD6t6kwgcbm0nayOrKB58+fjFakdSSjtOj
         +3ueGBS2yjy2gnvMu3Q+PGCXg7hdLBTWFX1H1lbjnok93vgNwyEmpjYwaievduHKORrs
         42emy1v2IKw3hym1aZgIbYl7AxizDWvOJ0Qw380qWQHkHeyRZ0BrEPiKEiGqyWy5+Mk2
         HnG2qJ955Q7XO5Q8Zk46F2TN/DMWCvryxtF5RNOP9CP7eOP5HP0qbbPVlsXWKcsomtST
         Z1pBDhTOkfjcCWzJBWqEOmbJ6Uhrz3DoCuwjw5sMhXNGlv9b/092/v7Ch8WwjHx7vi0h
         9gkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5J5SkosLRgZpKa0oqkg3diZYZitOQFX2Mresu2bke09Rd5eWoLcFaGQVHts1VI89YODt642U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQhwLMyIOCoqOq5901diMGDv9S26TnIFiYqNp/mvgm5u8XNqr
	QNh+A3HW3UEo6r2NZLpe9Tz56mT3Rx/MVcQHvzmu8anIsd1llSonOb65
X-Gm-Gg: AR+sD11xqbz/kktwNkJbAL4V1Y0+I8Ay1QBJ5HT0K7zh5obL7XWYNTjl04guBa5/9MG
	I8x45WTAf/iGUsKapRJspIqd53vqQ7QeeskZ7yy8NwSBAL4HbYWODie5SLsJwT202o8RQMGPeQn
	/4bd87n5nFP7hv9wmodKi5WXe1wVIpj8dn0YX/UscCd7kf4E3Wq+RKI+eIZQrgof5Lh0j6dkkXf
	4SjmbjMMv6g8zEaZ83TlNA0p0Cqi4o+1r2TuGYqQE9Zj/5XXC+mWGYT+1Xr7iNuZFAVzY/tZq03
	JS4OKeaYheikNrEBVOMuuVpXU32ICJfyuIcYsfceMiHsto8QMXXRwbTTBFVGp5/q8Dunta6safW
	rH9s9g5QncXH8pGLthwyV3L9TWBhBidgDiV2iGh/CJoG8mRXzoItQbUPlaFoHgY1aBvjwRhPodB
	jTiVAzqQHmKgAWZpQlz7UWCXBgZ2cDA8a78WKJ2jrNoDwycEWtSIzkBRRdYmHGtzrwBBUntCWOH
	ghLRE7nHkcf8xZJk3qh8SUcKWVRD0+9XnL317cQ/pTg9eU7El0D08vbfgN2iUtCLkGJVVu0c6F0
	VQZu08H/cEM10R+raqbz3mJdXNFAkc9GYtqHcA==
X-Received: by 2002:a05:600c:c4a3:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-4980c64b5c2mr55006905e9.8.1785605706390;
        Sat, 01 Aug 2026 10:35:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199f2csm98595505e9.5.2026.08.01.10.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 19:35:04 +0200
Message-Id: <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>
Cc: <fsverity@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Jiri
 Olsa" <jolsa@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260731003925.2728977-1-ebiggers@kernel.org>
 <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com> <20260801171549.GB3567@quark>
In-Reply-To: <20260801171549.GB3567@quark>

On Sat Aug 1, 2026 at 7:15 PM CEST, Eric Biggers wrote:
> On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
>> > Also correctly handle sizes over INT_MAX, which previously caused an
>> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
>> >
>>
>> I guess this occurs when using file dynptrs? Otherwise the size is cappe=
d to
>> DYNPTR_SIZE_MASK.
>
> Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
> So this particular issue might be unreachable.  Still seems like a good
> idea to match the u64 type that __bpf_dynptr_size() returns though.
>

I don't see this in patchwork, so you might have to resend this with [PATCH
bpf-next] subject again to trigger CI if you want this to go through bpf tr=
ee.

> - Eric

