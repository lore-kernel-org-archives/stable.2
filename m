Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784941;
	b=Z+zCs8SMxiuQ0S1fQ0AUTP6fUC++TOHeN+BN8vknq1xz2P0C4t8L4/yh1ZKl9SBDbYkf
	 TtZ5l4RL5Iw6xQez3k4qz/DD+m+G0PI8+ePqQikW/nsBhHA73duUuTGvZzAVuoXjoxwai
	 Qp/ZNOb/Drs8tkdcN+OnO8YGH8yVqS2Vi2SgvDEK89FWz5ljgz9/mHCOCWgWy9cEt+ePI
	 OJdghqHoQPq+MvUeDyYSKTMLw/2j0F7epl3FHCgoM1UFjBUnEZ0DjZ7eABOg7Z2UQ1URD
	 CgXsAFWlWs5aqAVvrQyRWgu20gtePM7bcF52QvRn9THMT3HZO8OPJADT5o8Wruu9GPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d27XOpNk91yrL5vN3Uipj5z8IFpcwdHS9KxcP/NHLhc=;
	b=GGxsKo/vcZzjemTXH/gsGcbxgd9s8i5QP0ddtIrYlazvp/h4AwMSLnv7dVlTJtwW2sj9
	 bodilt1enJJY6W07dSOltARcVcyQu072ePJLR56SYhHRioOO4iRT8zRlHLVKQg2B75gQQ
	 JPSX5SYufoDHAuh5cRJvSctEau5MAdpWhme6JNBoTKLadEPSuxKZVphCm6TCaxHkNHNE9
	 0Pshg99cXbz14oVf7oGdlUFUoGrXtqqG6s2lleKaZXrd11vW25hZ9hcxk9yWob+D68eQX
	 Tf0InzlbYv+diPReUGPvzBz3dpCp4h2fYQSg6RepqWwg4q7a6PvgipSZS7rrJ9qs0Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOrxg9x2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A89606A31B;
	Fri, 23 Oct 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOrxg9x2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763651F01825;
	Fri, 23 Oct 2026 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784940;
	bh=d27XOpNk91yrL5vN3Uipj5z8IFpcwdHS9KxcP/NHLhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dOrxg9x2fpN1ckn5qPPkaz7iYkTk50EX4LkmLA5ci/uVZUZar1EWqAbbkbcanXWFy
	 xWNAI0OfawuEGFJvJ3QWVUOiIfu0XWNhjWm/pYbPInNdXtWgxeAnRSqQJg88vRYRsg
	 4lxbUSv11Kj4hLAarlYxTrFXgKEWes7DgvWujMqSKVV4i+gSy71Co8U9jQkdfJx4GZ
	 l4k6TZ86R3TolL4RrQPUDWY0SVOToIZvXmW23Gtb9Eu/OL8YcsUpae9ri139uXhIxl
	 y3bekVA6rtJJln8kPp8MExzV5plUHocwH0RM7dlEU2DiklSV4gGqu7sp50KVfWZCee
	 oaqu0ZCgSmCkw==
From: Thomas Gleixner <tglx@kernel.org>
To: John Stultz <jstultz@google.com>, Daehyeon Ko <4ncienth@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Require permission to set auxiliary clocks
In-Reply-To: <CANDhNCrZbw-JnmC6DLWp6FHe6Vait=q_0uwRE1HqdbDYjL0Zwg@mail.gmail.com>
References: <20261019080324.4147815-1-4ncienth@gmail.com>
 <CANDhNCrZbw-JnmC6DLWp6FHe6Vait=q_0uwRE1HqdbDYjL0Zwg@mail.gmail.com>
Date: Fri, 23 Oct 2026 21:48:56 +0200
Message-ID: <87v76syz87.ffs@fw13>
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

On Wed, Oct 21 2026 at 11:29, John Stultz wrote:
> On Mon, Oct 19, 2026 at 1:03=E2=80=AFAM Daehyeon Ko <4ncienth@gmail.com> =
wrote:
>> +       ret =3D security_settime64(tnew, NULL);
>> +       if (ret)
>> +               return ret;
>>
>>         aux_tks =3D &aux_tkd->shadow_timekeeper;
>
> This looked a little odd adding the security_settime64() check in the
> core timekeeping.c where as is usually called closer to the syscall in
> time.c, but given the clock_aux k_clock is defined in timekeeping.c, I
> guess this makes it the best place to add the check.

The reason why it's not in the syscall is that posix clocks have a
different permission scheme than system time, so the check ends up in
the clock_set() callback of the individial clocks.

