Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795616754;
	b=TINqScHtwUfwHRRK6tZ8e/HSUd8FsyZPaEHRaD4aig72bsfcAits5pJ9n3PtCELG7J0v
	 jowGTjaPnLglxLQk4gJBLXC3nxJn1glnYhY6MmA/n1zwGqU9zA4UBrX4zb+SX60FLKGR1
	 WR5qwDfnHnA8PvasBXWZZHYfvF4vgJwm4FVayTcBRe+QsipdZ/JpL5+aHZaHEVhfcnXLs
	 WUMGHu+gDgpzUEZEx7Xl/09iEWNjKW9cLv+xhz/m9FAQpWSgfcR2TOUsHlItNOGfdUrt4
	 LW3VWnzdludiyDSGafQX6Sz65ehvSvU5qS+ZBOMkrmoDQRHZai3zWrCzFwyuu8SILgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UuvSUG/AlGrELdXALdkN0Fzdz08CRX6xTiTsgmsS7Q0=;
	b=xlvIE8tEE2ii5DmVrjZ2KdD4dLDLLCTnu8jki0/gcn4ICBqB/9ry4EMgEwpR7AfL1Fiq
	 wFgzwhIXmcGOEg8Z4mXwDGSRgJYcEJLi4dOlul2OnfV6KWL0lQarJW9z8zr1ICpny/XCi
	 bntkpQsI+l+pHhC1Vaw8yFulUAZtZGX8MdJMmtQ/l/JHmWd3iuhRLY7Mu+TaG+hDkvwmB
	 HMPZyXQBJ3AC/6nKgEKB9EU4ecCuk3kB4AdSOWKKCZm+VpDfNd/qmsI0lUPaz17eC+RIb
	 wrzLC+qC9oSy7LdsqthJXQRjlXWUNqWzuWnYfm8bPCN0wOguoJ02mUvA5TRPZL3ZkIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GSL2yFaK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C0606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07C0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GSL2yFaK
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-574d803e863so2141288b6e.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795616753; cv=none;
        d=google.com; s=arc-20260327;
        b=hFAo2hIHLRqIXBja0HN2WHLvwXnRLCBKFtuEmv8nuemi94cyaZrREbIJkcENjfqSuW
         6+Yr1svkN04iXbeRazmJFd/VZWSj81Bbyhboo+Qygp45F8TfMHQUhauWm/uJfxEhTndn
         BpsUq9fbJh9PeJx9vylj3xjhsaLvZFIDj7AB1WXyBOcdNzUYWN7qRiJG8SyU5k1KAYcl
         aTtZ4GrW/LWRHuaSlLyz9LeE+DRT8b/mJoAGfqFRe4HmLElMuTSVIspzROX/OKeUBuD0
         w6oNlo1Fr2alp8Q8PS9tq9J1vAy96X3naFtVvYFqvIGQzhj0O1fPEPssXhaigsY561K/
         OuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UuvSUG/AlGrELdXALdkN0Fzdz08CRX6xTiTsgmsS7Q0=;
        fh=GMSk5dZEp9F2AhrZZCfFKt+vw/DV72pSCq/9x9hSUVA=;
        b=XwVUtACX+2Mqx6MO7mF0DH04y226XRDuGh1NQLBtv1QLFOc9x0arxe2TLoYspgjgNu
         +fPyOwNnBcnyf5+uuZpHZAN4lcxQQT3KSv2dsAANGVHOu3uY8NRWWLiCWdc1GWy8m7fP
         l8iI+8u1xquuQlH8CGEQe7TcnD/8qoKW57GEUJYNV2U+RqMptsecbKIwVU8hJv6fsJqP
         hoJb7yNU7/JK07b47DpGve6eeQtdrn6NftJnLLpwC2nis02cW0/0OumvHSSSQ6siDEFw
         SCXGZeqJ9OVCWdto7d0XhSO4qkk8/YTT3mQZbuw5yAjKEak3BDaLm3HrwvtbX09bGsmb
         OjzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795616753; x=1796221553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UuvSUG/AlGrELdXALdkN0Fzdz08CRX6xTiTsgmsS7Q0=;
        b=GSL2yFaKrPgf1zPIeu3oVBQsq0J3husWrklGcBYY07GFFV3bd/3XxyPbUZZeHBrLm8
         rHL+YBjG8s7VaIJPM03BnevG82gBsRe1tBmPAYUkFlLH7Hpe2CX87cqgLDqd8sv2ifdh
         I5b32k94WYxPvjtM6kl+zXDICpKLeyxEO+eGoO8Fclor1Dr3oiEvgHn7JCajLzNCLq9P
         YGr2DpbcDMh3inxwON66ss/2/LsH38rCjJR6CdmLuo80EdevINWm9CWSNIniIq/+tqxF
         2Vic/WPSb/EjxjuemGatIHnMTWmjTvsWPedC8s6sicjTOKTXuVUzLspMja7YJ/32xFpK
         rR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616753; x=1796221553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UuvSUG/AlGrELdXALdkN0Fzdz08CRX6xTiTsgmsS7Q0=;
        b=gSbFIefhjjh9S1ffCXrtfNlvLDUzvmqB6X4Kyi4tXYBWx4zQP4gUFmGXI3WavWVmzo
         XxedpAyy98vUUTMcLmuUNLk0MvJ8Lz9T1l3znzvhNMRl2wwk1b7OQGlpleAsdzcRTejX
         kuZM4vF39e0MaxEGdlxh8fJDKyyc4viHHo7C8xaHVTTeN0z3WHZ4PVTqQUS8UQoSgUyk
         V35+bqhxtrW4zggqmpEoKDpzdUHqa9mzzQoJ0f86fx1WHZNGEL7+vsgRASpkFCPm24oh
         YNtWAkXCEfMSOiASq+6PNtoKzUuMoN3GNGbb6YiCpEcji+nEZots9HPFD9XfzepDG6Gn
         Ts7g==
X-Forwarded-Encrypted: i=1; AL+hErHVFReEvtpWG+4husL9WIaS1CIDcDEuLsgsAoHGAlK0MNjrnveDwOHhGShtQBuPZ5nI0EAuexE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wIvDAcdBYPbgNBoqP3Fgi43pOTnVCyaTb4lHrnjb8C5Gywmfj
	e7wlw+cg5YkGVUXrnE8AwyOQBf/+W74AXT9BGLc5FEIZV4p9vYx6l0qfceVSQS9DcwpwyZFkPmN
	sC3tDS4o32VIhyaO9qjViUkwcEUWwrxE=
X-Gm-Gg: AZFdTZfJWNUZ7O0Mew1+2wCQYDCe0y7SuAb8x2kME/ARG/6YwtMiEyM9kopWaXKlQqH
	SPQBUs1wp04R3Q1T+SGRJAdPwbiLHdym6n/VyVH7zho9WOl66z0H2c4Cw/HzrJiUBKdbFPPAxo+
	4QgGMLnhYGjvVeMAsYGtAC7ahGQjC0cjHtiJ5JJYdEkk1xsfO5b9JlZf9VBT+4jMd6KDQT7bWXr
	uKPxbB8uaZbGViE3fwCAVyhhGPtvmwqkFOJ0mCo+yswjuh5l9U6gn4x8UrbTyNwjfHslj8k7ifk
	OaJJbyblKoUz3FdGmG1tl2cmZvNIb9zeo9yQfWTl5nNTlw16kGIVdK0A76utkcXukbGI4n02EBC
	lbZbPm2cy4Fqkoy8h8e2DPqTxAGrJkyOXDAMe9dyVVuImQQhkEHxTlgbBudB6yWJzQZca1yI01H
	/n0S6piH+73W7HUhyy9HCZp+pH+rA=
X-Received: by 2002:a05:6808:1314:b0:572:75e6:1cf3 with SMTP id
 5614622812f47-57a0b3464fcmr18893238b6e.35.1795616752595; Wed, 25 Nov 2026
 06:25:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org> <awbtZjtII9h1oJ5R@raptor>
In-Reply-To: <awbtZjtII9h1oJ5R@raptor>
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 26 Nov 2026 01:25:41 +1100
X-Gm-Features: Aa3M54pcmOBqypz_nIQFR-Ig54b2tAgMU3tEPOdP-w4b7Z4sSqpiMGUndOnwO8k
Message-ID: <CANOyQmGPHrHAzVW70Q8T3AYtzFi3C7jCQdd-QW0rQCPEf=ycyw@mail.gmail.com>
Subject: Re: [PATCH] lib/test_hmm: invalidate all mirrors on device-private migration
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, 
	linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex

On Thu, Nov 26, 2026 at 1:15=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:

> Might be something on my side? I'll investigate further, but I'm not very
> familiar with the code.

I reproduced the same 0 versus 523264 assertion on x86-64 when the separate
mm/hmm: account for subpage offsets in device-private PMDs fix was absent.
With that fix, the test passed. May you check whether it is in your test tr=
ee?

Thanks,
Aveline Noir
