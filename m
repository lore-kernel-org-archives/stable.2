Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CC35CB61
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698096; cv=none; b=uqTEPoydcCIOxiLlRmM21VqBMuGSF0M8DPPd04rtrVeSK1SO5WDFWnFX74ze+Sor420cQFL42Ug8ujLnK8vxl28Vuw9fVR4Ygrw0zt2ouEnsE6UN6iFo4EzId4CvM9pDwFO5Dzo8+oEZTyLoLiiNW60zi+giNNAUsKoda3XizN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698096; c=relaxed/simple;
	bh=tUw2b7crU+HHHqcx/66Gimzh2XvrG+qMeLaV1m8ApW0=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 References:In-Reply-To; b=Y3ih7xHZcizRylC/Tgwu1Puwe5E3mX5YXrkYAwUfuSb7VwNWYjhy+6HSC5gcJevxMYUh9poe8aSxZSUxMHoHXh+R3Ypev2WuUW0P3R7YziXSKQmz1wi1F/addwf56z+SWRrNUYYTjvhrPoDy1GCKLVaHcmPj6mFsN0EyjW7Ff9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gKcImSqE; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gKcImSqE"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so241805a91.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1789698085; x=1790302885; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZ/9bEBYN1Z12jKLfTJjtmiNcTyLLJmUMtlMsC9kMPw=;
        b=gKcImSqEmdoYC5Fgr/5ueGjyHsJSFbcfwDgZAU0AhtDvYPKUWLdx5D4PuStEAzmHk4
         xiLrAWxOln6K9XPTweM19KhHDg8BrgpU33wc4iAbb1Zcm7I2/Lw4Jl3PaabJV01D8+jF
         UsbwTgjwaJD5a1vmBb5FoscUMrkqufba0SS8l9I8+smM74HY1rhOE1JkC/cehphDNepW
         r5DoGggL9dGDKrdsL661lyhh/xagT1S5MieH2yUusy9UJBJ7RUuSZQUQWm/32+NHp3ZT
         7V51Iokq6lZYr4Mt9D43Od8LGt9qDFtwlL1vtPAnZOM78pHByVDI8SKEpO+0s9Kj9bMf
         Trrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789698085; x=1790302885;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZ/9bEBYN1Z12jKLfTJjtmiNcTyLLJmUMtlMsC9kMPw=;
        b=OGwdkNorCe5Uhgp2lq3sW/bkdNzkWjKg03wPtprZWMgEeAmpm8gfQTkpn2VVJWQrJ0
         8UP9417NGVdaS3HkxHxMgwenNBbEgI6ryozeXvcQLw8CCrkwFUZ9oY0S3GWb7e/Jsswm
         vV8eE7N9XJHjglISjcSy8+kh009D5drRWX+i9koQvIWLT2DSGCbmNF4xP2HzLE98yVdd
         dwdidBTr7DBgGeVfkddEJV0tZFfGhkcHAalcw2Bg5Y+LH1QGFVepFtxCrdOqSsp2wQGi
         ioR0+sDtlPCJAUqQQtQxIJZSNmj59hbZvB9WonRocM8s+b8cyv7MU5ILfri9/NbbGpU+
         vS6g==
X-Forwarded-Encrypted: i=1; AKwUvBy84aSAI5HMjN7MO0dQuSOnUJamq/DMEN1vmJCzi4OAwBhK3odTsSsS7PMmtn+TSTkR1tmS560=@vger.kernel.org
X-Gm-Message-State: AFuF++lq18+5yl96uD3HOmay9yyLLYmIIFj6HdW63cm2UM9s6PJhzSom
	9SWjBhpYn4NpG0ypT5EkNQQ3F3XrpRWCH5VgTgBDWfE7wj73EQ1ol7hBTe/RiWi9z9g=
X-Gm-Gg: AYBFou1ZlwtSHK6Y4bTtpHOGX369ocd6AjvJov+RIdE94HuNRXxlUez9NJaIquXXjGD
	EGzCtIKHuaNoWXM5jAiTG5rqgLA439sRCZWQSrWGnlwZA5gtjjCbJI4J32pfjqPyHFNTfyL231R
	yf+7RvTM0nBsBLwr0es8Ic5FH3Y45CFIvMOI+sQWHzdwunuMxFhcQqpgY2gIZXs7uqJZuxqOE4H
	x0uO3qGvbw6QFk++TCKliyuqgTGoJ1CWj44PhQWIjGVH/FSszJRiDG2lduwmJ3S10v+Mp10hg+N
	Z4hap1OGumB34N98AD/Rz1KksrcBpYZG6u59znwUSl2T+Dr7OGNWDUrYQwd7VudgzB7c2OYVjrM
	XPNSz4U8twiJnD8ByY9LBd1Ses+xDTLv0EFoH/Gk40ppxy3Lgq0BnXZzgkwRepqJmv9A74cduak
	anQcAw3iRMVhNhWY/cXkbb7fklSW7bMIk9ilGNZBcuiU9b3fvenwBwDPoxowB3/LUAV1moN2Z5f
	8ypzw1BCw==
X-Received: by 2002:a17:90a:d005:b0:39d:ba21:fd90 with SMTP id 98e67ed59e1d1-39e54f2bf77mr4084275a91.16.1789698085330;
        Thu, 17 Sep 2026 19:21:25 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2876ad4dsm219835eec.21.2026.09.17.19.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 19:21:24 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 19:21:23 -0700
Message-Id: <DLI30THJZGQ0.2NVBET2OS94K1@nexthop.ai>
To: "Rob Herring" <robh@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Cc: "Saravana Kannan" <saravanak@kernel.org>, "Frank Rowand"
 <frowand.list@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Shawn
 Guo" <shawnguo@kernel.org>, "Grant Likely" <grant.likely@secretlab.ca>,
 "Grant Likely" <grant.likely@linaro.org>, "Pantelis Antoniou"
 <pantelis.antoniou@konsulko.com>, "David Daney" <david.daney@cavium.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Sashiko AI"
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v7 00/10] of: teach overlay code to keep /aliases in
 sync
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>
 <20260917203938.GA3480871-robh@kernel.org>
In-Reply-To: <20260917203938.GA3480871-robh@kernel.org>

On Thu Sep 17, 2026 at 1:39 PM PDT, Rob Herring wrote:
> There was another posting in 2024 of Geert's patches and AFAICT my
> comment there[1] still applies. To repeat, what happens if the alias
> number already got used because the subsystems can pick any of the
> numbers without an alias. The only way I see to solve that is make
> possible alias numbers and dynamic numbers non-overlapping or only allow
> alias names that are not present in the base DT to be used/honored in
> overlays.

Thanks, I missed that thread. I went through what the users of
of_alias_get_id() actually do when the index is taken, to see how bad
the collision is in practice:

  i2c: i2c_add_adapter() -> i2c_allocate_adapter_id() does
       idr_alloc(nr, nr + 1). Taken index -> -EBUSY plus
       pr_err("adapter '%s': failed to allocate id"), adapter is not
       registered.

  spi: spi_register_controller() -> spi_controller_id_alloc(bus_num,
       bus_num + 1). Taken index -> WARN() and -EBUSY, controller is
       not registered.

  serial: serial_port.c sets port->line from the alias;
       serial_core_add_one_port() returns -EINVAL if that line already
       has a uart_port.

So a collision is a loud probe failure, never two devices on one
number or a device silently landing somewhere else. What changes with
this series is the failure mode for an overlay that asks for an index
which a dynamic allocation already took: today the alias is ignored and
the device quietly gets a dynamic number (which is exactly the bug the
series is fixing, since the pinned number was the point of the alias);
with the series the probe fails and says why. I think that is the right
contract: an alias is a request for a specific number, and refusing it
is more useful than pretending it was honored. It matches what already
happens in the base DT if two aliases name the same index, or if a
driver calls i2c_add_numbered_adapter() with a taken number.

On the two alternatives you list:

Non-overlapping ranges: the subsystems already try. i2c computes
__i2c_first_dynamic_bus_num from of_alias_get_highest_id("i2c") at
init and spi re-reads the highest id at each dynamic registration, so
dynamic numbers start above every boot-time alias. What they cannot do
is reserve numbers for an overlay that has not been loaded yet. The
OF core could refuse an overlay alias whose index is at or below the
subsystem's dynamic floor, but it does not know that floor; it would
need a per-stem hook from every subsystem, and I do not think the
mechanism is worth it for what it buys. In practice the overlay author
picks an index well above anything the base system can allocate
dynamically, and if they guess wrong they get -EBUSY in dmesg pointing
at the adapter, not a misnumbered bus.

Only honoring names absent from the base DT: that addresses a
different case, an overlay redefining an existing alias to point at
another node. The notifier already handles that one: an
OF_RECONFIG_UPDATE_PROPERTY on /aliases destroys the old entry before
creating the new one, so the old node loses the id and the new node
gains it. Whether the overlay should be allowed to do that at all is a
policy question I am happy to go either way on; rejecting it is a
two-line check in the notifier. But it does not help with the dynamic
id case, because the colliding number there was never an alias in the
first place.

If you would rather see the failure mode documented than argued, I can
add a paragraph to Documentation/devicetree/overlay-notes.rst in v8
stating that an overlay alias index which is already in use causes the
device registration to fail.

> Fixes should come first in a series. Then I can apply them if ready even
> if the feature patches are not ready.

Understood, and thanks for taking 4-7. v8 will be based on dt/linus
with the remaining fixes (find_target absolute lookup, ERR_PTR from
dup_and_fixup_symbol_prop) first, then the /aliases patches.

Abdurrahman

