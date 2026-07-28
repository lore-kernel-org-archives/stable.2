Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76B3A759C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276831; cv=pass; b=e7CgRxiDGBYky2YswNbcV/kxC0DU1kABCGDdEf0GBCl/Vlh0yPAtVWODjJj8V1xU/vc1y0h089+kQW6nAIbJZUWRMbqus5+ymuPvii4svxdnKMpEsvQLzu5df48y5s+YD0eGkYeBFWguPiCx30iDzC+Un1vedLf2oIXSWThGsHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276831; c=relaxed/simple;
	bh=PdyAMPZcjTLVXK+xekpz5J6Po7FfoLTjxMEj3fsYdpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inOyFuB3ACwxHiE9hrFhj/G4SphkNbefkzd4IaJlocZZUJpx81XYFIiTMCRZirMcXBZu/lr4W0FVox4zm+eaxB9Epy39GE9+B5WMPWSz8LttESWp4+plcDSU1zxHWRK0d/XY5Gb0oTFOavTDGSZCPq476a0MTa1WJzpkkXbczK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=Q4hqhKa5; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="Q4hqhKa5"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92f03daaa97so25999285a.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785276829; cv=none;
        d=google.com; s=arc-20260327;
        b=rqcZs99pQwThyGZ+Hq4Lv6QqMpVdxD1rqTXyuBpRWIhJMXZLvx7i913Pgat96tHXEd
         U6H6vHrWdi+iwU/H6R7WTj9Ba/GP5gWTVgt9GgzsosVxEvMra0JMtjrI5gNdpKEJ7iKC
         bMzJLyeEJlKk7skJDTajC8I65D+Km8FpG0NOCl7jh0MudQlVq3QL4ZnwQQ/okjQ0tKZ9
         5gNvfjWKRPltHfK8rTJe1uMfEbb9sVqEvho3yV83G2VL1wDfaAp/LqurNCeQ+tSnStKb
         bC49bInDwr416Pbzu3qpveBxJRsswLjdOQCVwIFH8Yo7p8ftgHhr0PIUc3HbfeYJvLW+
         5TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PdyAMPZcjTLVXK+xekpz5J6Po7FfoLTjxMEj3fsYdpI=;
        fh=zlWRh+HOMgTA60YycDZmzY4SXQ4ix2U6wCfb/KProFA=;
        b=ea1qBi0Usn8qx6JRDuWDEGJB/NdWAZ54NW7gmjDDUKyD+KQVFCuxu7QBaSscSLTZKr
         9svgnq12V3hKNfuD+flcawkq3ZVo6wFlCgNDk9CZq5LOQBU5d9z7qCmW6DuhvQCxV7YE
         s1qK/GDWC5bOM//G6j05oPOzSQNh2QgKK0oc6i+4Q2/MrpltgwStOJOq01Zz/VWvtZbv
         nUf6uoUPSUnvGFaDljacB9H7FpErbMCJMJUlVYT7Ar41AupJ83zTk0EN50CBno9ZCDxi
         gugp/4e7MvUNLJz0q0YYmC35Kk3l36CpGToaEDzv2KmUN/T8/jf6SIDsU9P2tNqrUKmb
         O7kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1785276829; x=1785881629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PdyAMPZcjTLVXK+xekpz5J6Po7FfoLTjxMEj3fsYdpI=;
        b=Q4hqhKa5nsENc7pxlElMbS8QypOa2heXa8OWZN7vWjxQNTR1X6pQMw1PT9Rw5tFf4o
         P6HSkeLmsC2pWiXSzGqcY56ok9j6R3ALD9inPgiVd6B+iP5czxhdSWqSJgDn/Wn/Kc8Q
         ejOANVxsWbttsc4p5wOXpvdjQzaa1EOGkfkDsIaUr7T2ItlVjysqCBP2Kp6XTuc67kFR
         IupRJEVyii1tUTe+5IyZkFC4bIl1hIXSiMHcqfwL/RuL6vhDqG8lWAHpIKW8jHlGtS5n
         htrXjg7vnFX8fcKBiZgQ0jlxkPvGckNRKxJk8RXOimw/aZZSha0ZKHwDaeT8OvZWJ6ae
         CiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276829; x=1785881629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdyAMPZcjTLVXK+xekpz5J6Po7FfoLTjxMEj3fsYdpI=;
        b=qvQgRSQaozwSTBO1i7huCGllaV8X/YidH+MXq4KCNNdcOHQyJy06OyUsnKb7Xhh72B
         ZLYX5tKcpMjfcDFzjOTUTvb58jWbILYifoFpKoMcIX7+FWNUCLrhnE5DNzu16x29WW7a
         YVtS2eq/JoTLnoJHNdGsspxMHNQ81P1w9CPAFzZ9p9DArXfLgma3VhWc7X0SBP8GbsD0
         wg66psa4f+WYXm4+ZEgxiCT4DOju7xuIeNCaEmMQJXxQBTfr2iNPd4xWeL1Maq8QIGfj
         +aGj3Wrf36jJdee9TMMz8h28EG8UdUH0DNLikKEiq03iDL2q9b8jQyoU6lDUgpmqV4l6
         rWjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjitSOLrIhYbBYLwS2Yb7LvzL9GLubMm6819QVM2DN0AaYuKCXhURkuPdEmuTExapX6Av+AUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOY1pW47al5kTYbMsCVLSI1Vr1A2HuoOYfIRzpwniVJ6wQAUwZ
	epXn8BzoncLEn82BjJC/GaxO7MUilGmIlBKpcf4UschwGbc0jCPM5QSxo4Zs1ankdW8BLr203vq
	Wo/24FStBi0unB+PmBmUKf/Z07sb9VRtMsyj7I9IZYA==
X-Gm-Gg: AR+sD11Lhwfz0BlhzU/RxT6NXLWEcV15sKJKXR1mjHN13odRHtp49TXZ8R50/JV7ApB
	cddi4LEo+4MgHuTvxHbRiiNkroYB6Ma6I61eemlHu371laodyNnHfQ4MQLl7BwxARYXp5HfOtMr
	xOEeAva15x6hkSItmOJe0pi0O4bqdlI+QDOuKR+0qYAs6mrGLARTJ73okfhwbqbObHA/3y6fAXM
	KDY+jn3ZKKn6ziAZs8zKwirxmBy02U34Ankmkp3fNu6xg6ZH7E3e14i1abMfnyVVI3CeyytR17i
	rf0mte3H+1q2ju7ggQ==
X-Received: by 2002:a05:620a:454d:b0:930:dd1a:5675 with SMTP id
 af79cd13be357-93302774085mr419024785a.55.1785276829036; Tue, 28 Jul 2026
 15:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87ik5yhisv.ffs@fw13>
In-Reply-To: <87ik5yhisv.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Tue, 28 Jul 2026 18:13:10 -0400
X-Gm-Features: AUfX_myxlfo16wijUL0CzrEYDZWU7MhN8Sv4sOvn8r6nlCr_qWsmzE8xGEFy8kk
Message-ID: <CABV8kRwf=WA-O_+NtEx2N38wO4qLJA7YBfDh1Ds88Et9hxjqXA@mail.gmail.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
> Seems your mail client mangled the patch. See:

Yeah, sorry about that, I've fixed that since. Gmail is a huge pain here.
