Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784074;
	b=3dtjy7/4aCovUYzjHfplPVxGB8UqD/uAR3dajPI5ysqBWZhQWUWbmeLWMOmvD9JgqaCL
	 jaPpDtUVGKB04TMWIROy4H5SbpiAdNKbcRtpDFOVCJOPRN1b1IUl0Xw5Fwx/vLgToUfH+
	 y57Ho4hjUEuPGnAeIrxcdpdU09DmXNkKIG+v4RH2cBh7utV16eGPWJCgG5qpfCY7iL8dK
	 p2a4CAOMh5FN5e/tkRYc7g1rzGzx+xCS7yPvnAfFlcGRIx9AC1In7SRXfUerjLY9QPuh4
	 sG/PT2xzuzz6Ctdw+HXykhh73rHZ/ikZcXr0udUIz2mrzgPnuclhOu6+gHXIlWRPgCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GY0htM7LLybH60Zvhq77Fsv6T50kPeUsLh+oGL9owIY=;
	b=OrLXCkr2uGUhuW6Pr5Z80aqS2C67TCpn6c7je2SgT0p923xCfSG3U+RxLwnurlJ1r7UU
	 DY80MrK/i6rp1mEeSRrXkIhrJISpxkkXUZ4XUixkopCvEXrfu9hGs+fO2Y8n+6gmB+6SB
	 vMNiaccjcuQ+2Mc5YlsREhFwL2mkiwH5eSd/uBYFlD9D6VoGWvV+V+JDjI0TOhwOqCrf+
	 y+luqyEHL1ygAc59BA5MtaP4MxCsfiFdRsO5WoiphsmI+0ZgbzvkTRJJBo0fDshYn/QRr
	 NKX4E5zpwTOyT8cgkaowwdx49BvkGx9ZOyu0tMm4WC517PC6V1Rzy8l+RRfuRjlD6Lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRKpF+mo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C0606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 09:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50C0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRKpF+mo
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b305e10ac7so4626717b3.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 01:21:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793784072; cv=none;
        d=google.com; s=arc-20260327;
        b=m/v4PdA5I6X+5Ph3A2ZFFwRTjRIoyC370F0tERaF+nl5aVlHkUtvnHYxvXnMx3SJTk
         7EDp3LYGxsG3d0dH56LbsoIZTmgTDGsZ5f56ejgpRAq5hWCKQGv0OrkRwqJYgJV2gneI
         3UTgR7ahyoIw2gANikJqHrWifQZpumMQUp++45o2I8CgRWjXTGI7vNE5YzRvJAWQt2vE
         1QlQxPhuE9BodzDuEd043+ltDVh9mX8ZAqhuk5/u620v0WnQa6265mlcAV+u/pmNawFC
         0GThSQgVL4RrqpBIF2qS1PWVHGAj42j4RIVvr+GBIzrmibZQfOUeCxrICzLXawW54daI
         4RJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GY0htM7LLybH60Zvhq77Fsv6T50kPeUsLh+oGL9owIY=;
        fh=0rxvPE/mShBVNWgSR6qti7XSOcReCk8lMl8JM+kY3Lo=;
        b=ciOW/rlVqQcpCVIqWtx9qVajgFTrN9mHP/54Iq+om8AmgMAQiJHkdkvNENKsp2d+cu
         Xp7xLIpUifiwj0KB4CVYFpnCL7uHsPFAKTPnncesGekwnkYCJlKcdayXMz1g593pByWN
         v5otxMhAzyxgS0Zgk+Y9W6xeCIK733dk4iyXfCf012K9ephK7RpnwIzxOewjahO3lk+y
         bzbNc3VUfAq4XMjB6D82zqNCk25HOnKJSyAD0GUF0fbxT+el0yc3U+r/p7ot4xGy4+6K
         PW5YXJKn5UM2AY3hDTO1zP1Y+eLWHB6A2jPlxNKFRngqgQmh/mdNLl23ihflgTzlaWQj
         Oiyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793784072; x=1794388872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GY0htM7LLybH60Zvhq77Fsv6T50kPeUsLh+oGL9owIY=;
        b=YRKpF+mojX5gIcBXUamGdAWJ7kMFWIy8+YYu4+aKV+1U5/nhl4aJNR8LSWs+hpuo0o
         89kqSzZRDO19yN21vK5wpbjZO6YZBSvhs66ZT3ZvnPEAYuRQe9+8+RcbHh/R8MBJKxww
         urRzZIB3ibLIXsB8VuQz/Qm9jb/+ScusInci2MqTwUVr5IlwxC/z9czLoHOo/69W7WAx
         rbwZuzOypvXbe+qlEdCDF19Tg3AMNCAhjwZVZHSKz40mkkCB9JO9sRhHjWpmY8QEqJ9E
         af/y1ap1XjUOv4VvWbAx7RqYpSAYehvY0+ruPM0S24Kc8NUUlNQ0kqSW3ddIGbleSoYZ
         3Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784072; x=1794388872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GY0htM7LLybH60Zvhq77Fsv6T50kPeUsLh+oGL9owIY=;
        b=BZFqKtPg1V1LovtdgD+cC1h8o8mGoTg4kFnkKs2ZFnvmPxZ1dC98GNbxHTHBsA81cy
         DRQhH4mRLIzx2ZrbWMvlPVe9XdJbNqvDLslDzkt3jf7R9pj+OHaSI5lSBeg2n5+4aNzJ
         0qNz1s7lMHfryC29RGRVU754CXbQ9zI9BIh8j24Kzi7uVUja6ID4UOvYDCvJIL5u5fn+
         XnGYBTwECvCJTVHssN7mZ5ilTak6oVIwIVmw2PllDLAX4RdDTxqzjUVrLr9sJ/1H3KkC
         ziXSaQeuriFHtq5+SHdnuUyeeDvHEe5ewz5fxC32YLNrHvS2a7+VoIc4bWjBNaQfovC0
         YYjg==
X-Forwarded-Encrypted: i=1; AKwUvByqu1JCpSeWZa02gemJfU7WBqAqNsAq0qe4cZXw5lGbP+NPyJYEjauqOPZkF2WtVVmXnrt9EVw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HlXVaiV1HQu65vjhPPOzLJyUmpnDmOsK0kX4kanwE0CxnvqMB
	eOtajIcG77V2/Ib+7rHCJWU6tQGgOYITJiP57yJ1sP1sr0cU72x5PolaFrM2+AsiZnLJmPrjvU+
	nBINQhVmVWAPl6rJTO8Z7ptnUqC5UOtY=
X-Gm-Gg: AYBFou33a8Y2SQBPuikE9dOMvq17SKnrN51zMPacYeuhp7/TsJ1bitiEVVG4EBuV1F3
	c2zAcP4l6eG+QnmEIkBaFNM8tMitj3x5nf+jdLxbq+GVTdMq9dIJP/AnvwGR5BgIPBT/y+s90p/
	cof3rQfGSbW+r1UavUr/6Eus7h3zagXhz/wQ2/3iE1oihUXT54dHInesBKUz1DikTQK4677+axi
	cSr6nrzb3Mt8vRyafQUo/pORJxt4fYKgjPS1WS3AzLz9rsO1Qn8MiTcbFCfAyxZHeSziZMx176O
	PsMNAdhk1wW6RblwI9zTvkV+f6hEj7rLnLajz/s30s0MzdOfV5LTqgxBsVKmvN2YY5bEVnBWFMV
	jd1qA+9/rEVZbra5RPzZKkhjQtjPdlRWLNwqXU6xrmNg5z1/GciuCQys2E/wqPRBSTjDgAcyY
X-Received: by 2002:a05:690c:d83:b0:8b2:fde5:d95e with SMTP id
 00721157ae682-8b2fde5e72dmr27025397b3.63.1793784072404; Wed, 04 Nov 2026
 01:21:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102103621.156928-1-umangpokhriyall@gmail.com>
 <20261102103621.156928-2-umangpokhriyall@gmail.com> <auot2ZVM5YjyFlZZ@kernel.org>
In-Reply-To: <auot2ZVM5YjyFlZZ@kernel.org>
From: Umang Pokhriyal <umangpokhriyall@gmail.com>
Date: Wed, 4 Nov 2026 14:51:00 +0530
X-Gm-Features: AclHuK9dbghBwN40s0Kd9a8eejM4zi0u6MKlqoBKgZ5z64zrzbWRBqHetF1dhp0
Message-ID: <CAOdFi6fb=d8RDk3EJSfGHSCKtsVjf=dmG5o2fq0dPxQoyBohzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] userfaultfd: validate the whole range before changing
 write protection
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 12:24=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:

> If we a breaking on any error to out_unlock, why do we need err =3D 0 and
> this check?

We don't, thanks. v2 drops them and the -ENOENT inside the loop. I kept
the one before the loop, because for a range with no VMA both loops are
skipped, and without it the call would return the -EAGAIN left over from
the mmap_changing check instead of -ENOENT.

I'll also drop the selftest.
