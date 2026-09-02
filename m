Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D143E076;
	Wed,  2 Sep 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344257; cv=none; b=czaQKVAfnxVTv3NLd/RPc4xxrgydzYGzZh/xhOm7651TSFa/vbjgW4/Yk9sV0mhSRTFB6VqhPLhcCS5sQVsOyBvGLQDRpItKk5r5YOk46r3mlIzzKfQVN/+iVKzfi9I/3N+qi17laAicDP1GO1+b0ozbNtlaAV+OALj5QBajJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344257; c=relaxed/simple;
	bh=v0i1IW/K0lCEN+UhHHuqfcpg5pQ6kIzUY/h8qXk8Qc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oPRD3J+2kxcDUrNvO4S30GCDcmkqj/t5qq2eZ5FRuQlkW1UEi6Zu3AyngZTRsSTliyhWjwYedJxRDgK5T/+2+pGC7hlof21s7nkMguRhrQQ+kG5RUq3twCvv0P6Geb9hPVXwRlEtWbArXC2DsgageIZIR20FSZFevagLLddNI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A63GuMXe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A63GuMXe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F34DB1A1950;
	Wed,  2 Sep 2026 10:17:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C50196053C;
	Wed,  2 Sep 2026 10:17:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C45FA11C79340;
	Wed,  2 Sep 2026 12:17:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788344247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aGdN2UjN2hke+3EUIE2BMe8wlc88G/++lGdHQipHA0o=;
	b=A63GuMXetukibemYG47lx5bU87mEh432g1k0HLhRwhiCKPEQbkCH4l3fyG8CRT1PFYRJj/
	pQH5rHmlpUuhGnxmHT5l4Fb2Bf2E3qrUzfNRDLeL9YN5raFI6wzwDlFROrLiB76VNBXDOJ
	FUkAOdmpTVFCMV+UbNGXUVIQRZI/wrcYaWz4z5CI2ghST2Gn/e34PQRuEsRsm5J4hOvfQh
	ScutLTjTLWc4xrFKDA4XBnirYGPIAHmu+Ev0gxsSywJUk6WJxA4/RHfFt59bPAoXQDkGrS
	5Jp2UkhpDZz2QIe/idUmeim2YtjSKKLzS6bworBKo0TXMZkKEKaSPAnTkzVeWg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Srinivas Kandagatla <srini@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Heiko Stuebner <heiko@sntech.de>,  Michael Walle
 <michael@walle.cc>,  Finley Xiao <finley.xiao@rock-chips.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-rockchip@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH 1/4] nvmem: rockchip-otp: Serialize reads
In-Reply-To: <CAKTNdwH5S3MxgR=5s2LXPquCFRXE-61LTTsZoHP9+YmXo_P4Ag@mail.gmail.com>
	(Alexey Charkov's message of "Wed, 2 Sep 2026 13:24:00 +0400")
References: <20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net>
	<20260901-rk3576-otp-cpuid-mac-v1-1-ea9135270fc2@flipper.net>
	<87ecfc81e9.fsf@bootlin.com>
	<CAKTNdwH5S3MxgR=5s2LXPquCFRXE-61LTTsZoHP9+YmXo_P4Ag@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 02 Sep 2026 12:17:24 +0200
Message-ID: <87y0dk6jpn.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 02/09/2026 at 13:24:00 +04, Alexey Charkov <alchark@flipper.net> wrote:

> On Wed, Sep 2, 2026 at 1:10=E2=80=AFPM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
>>
>> On 01/09/2026 at 19:33:11 +04, Alexey Charkov <alchark@flipper.net> wrot=
e:
>>
>> > The OTP controller is driven through a single set of registers holding=
 a
>> > state machine which has to be stepped through for every word read, yet
>> > nothing keeps two readers out of each other's way. Concurrent reads
>> > interleave, and the outcome is either a reader bailing out:
>> >
>> >   rockchip-otp 2a580000.otp: timeout during read setup
>> >
>> > or, worse, one of them silently taking delivery of the other's data.
>> >
>> > Reading two cells in parallel from userspace on RK3576 reproduces both
>> > within 150 iterations - 53 read errors and 9 corrupted results, the la=
tter
>> > either losing their first word or, in one case, ending in the two bytes
>> > which belong to the other reader's cell - whereas the same reads issued
>> > sequentially never fail. Concurrency is not hypothetical here, as six
>> > thermal sensors source their trim values from the OTP and reach the dr=
iver
>> > straight from asynchronous driver probing.
>> >
>> > Guard the read path with a mutex. Reads are the only way into the hard=
ware,
>> > as the driver registers no write callback, and they always run in proc=
ess
>> > context, so a plain mutex spanning the whole clock-enable, read,
>> > clock-disable sequence is enough.
>> >
>> > Fixes: 755864feb729 ("nvmem: add Rockchip OTP driver")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Thanks for your review Miquel!
>
> Sashiko complained about mixing a scope-based guard into a function
> with goto-based error handling, so I am replacing the guard(mutex)
> with explicit lock and unlock calls for v2. There won't be any
> semantic change though, so if you don't mind I'd like to carry your
> tag into the v2 version.

Of course.

I haven't seen Sashiko's answer but isn't the goal of guards to just be
released whatever the actual return path?

Thanks,
Miqu=C3=A8l
