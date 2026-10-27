Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124905;
	b=uKo1852wBe7IlCRHmK1cp7LGcFmayC8NbskoMgEqnk83dt2rptjYon67Z6DL1VRrY+TM
	 9B2QGr0xTvtLb0EsfH//gevwo8j0I9F/0Gxfpa908wKfiMiLMLjSpqHt1Lm4QOIEFVPug
	 o4aYF0Au/FuWgq5D/0A+YDAoA5V+wnj19Ti38msyshyii2y6VJjXAmFZmP9wMICSY1Wpt
	 YX+zmNKxOxBKdyA7je0+C5OHYvo3Bl47m86j+FWowH3CvCSebfDmMvX8zKaTgXx/MruCD
	 egqiQoTW1s0XpOAEZrUkrRq0JmnHT2ZjBg5wTDFJrewTr5cCoz9VEVG10cH7a0ve0mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124905;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=a1Ja3qIFPRW5o1f0UvkP2WWshxKnpvUF89aERI+066U=;
	b=uPWFmeMbbE2IGbNOhdd+ByFMCcXP2OhjZb+L2diLx9IT8w3Kcso2n00b8iEF2dbVxmkD
	 xTqH0AB+93BSMHGXX3RzjPau4rZcwm+fmruVvOJ5St/q7StVSsI4O+KPP9qyUNGZzIGCJ
	 ZbAUwezPey7h3lBcetIrbKXXUD6/WjFu35/+f3S5Wg2C2+Ou/RyU65nLMiiWvDszMSDxW
	 5pMNlYaXqBwgB2JSsqsaPorYOgAx4t3ukKk12BRx/MGWFs8b9iNgCSkAM/+gFDjFnP+lO
	 ohaHOohcLZuFo1IwM8EauySG4hQNil284ye3tdXs08xGmtvZh4T0FVjH4o4QO4nUuFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29C606A325
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B29C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so1164225e9.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124904; x=1793729704;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1Ja3qIFPRW5o1f0UvkP2WWshxKnpvUF89aERI+066U=;
        b=Nfl7BS/iA73x47T9e2FHPA7AU4nP+oCJOuLWT5gwsOXE+eHIPE+LUi962DFWFdmPur
         psi4YKur9+hp+QBrd6KqsJYljIEeHFAQUtMgPqZwd3gbHUdm5ph1DgisLVT2v6+/7DcA
         u6teH/mR3xJ2JdE99fl2ol/+ByK9jIpmN7xk/UmmGOnxfZOeEtjuiYwsqUEMmf1rKoAO
         u1qn3EOcRpvU/KRyYEraXMqXf9nkEO1l3DfhDmQ+dueEAf8nd3hifoDrE1CdgPBsQHch
         oKGoTg+eFwD/Bt+LqT9zEua25R0kNKjURIpfoBw+EyI5+zKMA54Wax/daa5j6DS5n5gx
         AAWg==
X-Forwarded-Encrypted: i=1; AKwUvBx463rJ618CRK4sLZuh4Ldtp1X2NA7YZr2a6Kpz2QDPjd7QYzBUdrzgFwDoeNLQYWu06iswvaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpXxYtJU6xs73sr8YQMs8OPWM9XnwJa9y0C7PTI6GRIoDEAk2u
	VDg4BJ4/yusXZeRSnIVJ/VUYv+XFmtSReIJl8dQwnd8XCgKeyEzeuXg=
X-Gm-Gg: AYBFou07mKfYdBt3pf+uwxeHQP/vOckO+2b5Q7/cKalywaZM5GBKxZ0sRUA55xMh30n
	3Bqez3h5pzSVuPmJWvfsiz7gDv2dgttoJY21UjbKhRua2vy5d+jQ6AuwRiMyKy19gceDYsRbWbE
	ZX0P3IB3hhXqOVodB13DV+N63/TLl+W1jXazco1DyvbqtwHCu8oz+qyRQ5/dSIE2TjVI4dWHaEN
	DR21yn4WWVWIMeyaUEtQ4BX8hyZ9XFS7tu/x2n6Hsx4BDPlZ/U4eEuHgMBDH88B/gfXqsfIq9sM
	XYFYM/UQPTj8ugD8HRPAEjtf8dcic6yEiz+f5qJlu0AU4pbL3DYxQqcqXwhCpwYA08lSpnuc5WK
	FAfzeK1/Q7qAzwIhFlnmjt7ut/uJ6upBS9eoPdpU0mvno/C1dwkhtmnZ8dVg9qpjjVpJjAdgD/E
	YbtoQPg67j8wehWZJj9XVul5UW6501q6QltZzDp79i81fhpa5p34zbJijeMDCYVzD//w24RyBEO
	JSAbXZ2IhYGQNQTxrwwDe831ul+nG4fLOIvQ5Qh5BNPcIsDjfPLTPQFt2lwe8k7Lgb/PVK8s1bv
	zb9eonD+LuPjmw8YpQKq8BNRnMIDpNNkZDOQllg=
X-Received: by 2002:a05:600c:37cc:b0:4a1:a6e0:4ce4 with SMTP id 5b1f17b1804b1-4a35acb990emr210145325e9.33.1793124903858;
        Tue, 27 Oct 2026 11:15:03 -0700 (PDT)
Received: from [127.0.1.1] (84.124.213.91.dyn.user.ono.com. [84.124.213.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94c118e19sm10345e9.5.2026.10.27.11.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:15:03 -0700 (PDT)
Message-ID: <6ae0ea27.08a8f783.2e4276.0395@mx.google.com>
Date: Tue, 27 Oct 2026 11:15:03 -0700 (PDT)
From: D. Manresa <dmanresa@gmail.com>
To: dave.stevenson@raspberrypi.com, linux-media@vger.kernel.org
Cc: antoine.pichot@gmail.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
 dan.scally@ideasonboard.com, hansg@kernel.org,
 andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
In-Reply-To:
 <CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com>
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
 <20261026111032.88355-2-antoine.pichot@gmail.com>
 <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
 <CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Dave,

On Tue, 27 Oct 2026 at 16:50, Dave Stevenson wrote:
> @D. Manresa it'd be worth trying using a prediv instead of (post)div:
>     .pre_div = 0x04,
>     .mult = 0x85,
>     .div = 0x01,

Our mails crossed, and that is exactly the change I had just finished
measuring, from a test patch Antoine sent me. It fixes the link on this
receiver: thirteen 150-frame runs at 30 fps, every one 150 of 150 in
5.2 s with zero dropped buffers and zero CSI-2 error lines, against
seven bad runs out of ten with the index fix alone, three of them hard
stalls. i2c readback mid-stream confirms 0x30b4 = 0x04 and 0x30b1 =
0x01 with link_frequency still 319200000, so the link rate is unchanged
and only the VCO moved. Full numbers are in my other mail on this
thread, which went out a few minutes after yours arrived and does not
mention you only because I had not yet seen it.

So the 19.2 MHz / 319.2 MHz mode you could not test behaves exactly as
your 24 MHz oscilloscope measurements predict.

Dan's instinct in the parallel branch was right too: it was the
driver's PLL settings and not the value ipu-bridge advertises.

One data point on VBLANK, since you raised it. With 2/7 of this series
the 90 fps mode runs at vblank 92, and in its clean runs it logged no
CSI-2 errors and no corruption I could see here. I did not go below 40,
so I can neither confirm nor contradict that part.

D. Manresa

(Written with AI assistance, directed and reviewed by me.)
