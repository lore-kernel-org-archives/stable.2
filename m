Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152768;
	b=rZSD9BU6AAS92pVQ1wY/yd143BtsGfr5S/BcYXCLeIoMcnR2sT/fYW6usxBc5O0waiMQ
	 LPDyuJDI+MJCSzdn2q56u19HKs/h2weyau505N9Fv5AdvJNs5/Xl3Y3D6bnXAmC1k2cIw
	 36j2kulnw62FY5dI2nsD+tSaHg5qNwJRBLbKKTIJMeSBpQpyIL8udVB0sXJrTfGGz1KQn
	 IhE1bTHVFGpwkJQZsoLb/SaWolrCwPKv1BnF8+ivlbLSOCE190umZP737RS7hOsDPJvjL
	 AmFxAgu1HocSpOE/k1JMzJh+IrgfGcSrXE9OplW2Mauopw3cLDir5cDIl/dCQ8W8/Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DHS4IRcRkeGwthYM+/zX9QaAvmyaBpkm4EoH1u9SNX0=;
	b=NepuoAitd/vkDq9YZjHRl7eGBP6+c9Ovdkq1QaMNid4+qiKzYXoL87OdmOkO26ZR48fC
	 LsKSjhBu09UsbW9kD814p8ghvRBd9IRzbbujxIC/Z42zqFrZRCraUt1k2TvcI8cHIPsgb
	 G5eig52zWJSx2wvFilkCsJlhXAGH/6AJ7efGhNyezr/4Qk66b+reD1sUkEta7/mzWSUA+
	 EEYHKKkGv6+EncqnbIl+97sL13E7svPIxdOP15eXQq05rqkV8ckGKhz12yeCDMlrQ2DSy
	 b8RiCbvLh+IE9kfnASGyzHy9PJab5qZtKEuPb7pgW1DP/SIISkbdrEpzv7PnDp6e2jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXSB0ddo;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF676606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 01:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF676606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXSB0ddo
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso3693915e9.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793152766; x=1793757566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHS4IRcRkeGwthYM+/zX9QaAvmyaBpkm4EoH1u9SNX0=;
        b=bXSB0ddoJhJtjXkwdMkJRS/E2I6TCGhZ04ss0GfAyrdWVyHHX+VR4yLNpJ4QJ5o/e2
         +b0Pea6zANKP+keLpUTqoacpuJ9tTqUPIgVKqSfklDZfI772hui27cWMHH/67fxDRyJ2
         xv+yPcCieDLS0gmPICYj5dugt8Ndh+5EuQSSyUAspl02u1pszzkz8+aE3qk/x91Mcm/r
         xTyRiscsTjYAGhnVIfGSJSvcwIyMhcUuN11ZS+DUOQHjN/kPMdnlydL9df/Jr2jw6bgi
         l215JJHK8cQFTBkTiOT+s12xDCwy8+qc+UMZ7CwJkBvptKgT9HYMalkESpU6Kw2gLeT1
         BLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152766; x=1793757566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DHS4IRcRkeGwthYM+/zX9QaAvmyaBpkm4EoH1u9SNX0=;
        b=JuGm5HGQhMK+aNFT2RFVnaCTwSq/cLIf4YCcT0BWMlZPS4o9+9G8uhqvwXu8G6LPij
         7KMmWYPvdusa1zBY8M0p+sGEW9v5hT6D6WGQyPQmseBgjXgY+5Cl8OmWsieqVJf56WVA
         V0R49TnIK94H2NRduSq/zGzStBEiMZNRYJ229aOJancXyjBtVfAbz+rxCAYX5JQ5TnaC
         PBFLXXsZPF7XJtM61FJVO358yBYCHqJolb6PX0u5ENyNdzmQtU+vYSkD2hNcRyesXWXL
         hZRPmPd2Mv/o5e+WN8Na2kA3YAqxXgEX+fajHQvgUmOtI7uH6cENaH9vc6wxkAixUt3K
         TJ7w==
X-Forwarded-Encrypted: i=1; AKwUvBzk5kZx/K/1bUzS21K4a20s9ZEfFuf96Tgr7bLIhQK/6Sn8pJTYJNPyUFCX9uODFdEn8/Yxl2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRxvlBCiOnHKFPZAxTSuqWDB4XpeAsWkel/Kd3JJpCNYJm3nhX
	ErwxiU+4LlT8xiYA1MM5o6nmL3a4iPButUzU91PGi3NaKjF5tvndqJeT
X-Gm-Gg: AYBFou13vom31JTuEMglo66lXv0MiuaGKABXSuEzFXh8U5RmCjRaQWZQp5vRkoPRZS1
	wZvfvLtXQzGrNSv74RU/LuYuYdyqkH7GkwfOZ9gM1RaCizmBmSI5XRNKSX/Zg87C0s5U67c9z/J
	JkezQ+c37SBP9dsfLsUyx9JKLoU5WU9CnfYnavaugT/GlyEY1XcuqNG006+9WhcislgRFP0RZh0
	sMd0ZP9hotdylUndInMzRSsq2yvhEhVQ9bls7m9YEXiKnYSA4CnL1zhVv5clO9Dmnk8nw/hsIA2
	l3HkBd6OxbGK0YZG8FhVtXA49K8Z9F5CR9M7XoG+lpwKnsz2BeRL58TbhFLTy6b1W+b7wIS8THa
	lAzXzXN6OJTRAC0laxKvRgrajjCgeAo+WrAwtip7Y1AY2YfOyKJfy3WCe3tfrDfdd6/SFmdFURu
	wR5wvC4QfHr3AedVy88WXSL94yb90ggn8dvXWkha5HQBcxTfel7b26yeQuVG+XZhlxWU9kU8vpJ
	jiBKNFEovR9xsmTjIaxfW8k/UmXWYnYWDyPQQNu15IPKrgHLFOlL1boOU0VXIiyApuUVeNfV5aW
	yxaVtoqjsIHyDZMubu0GEtXkG8aRIW1NMZX4GOtnT3YrB7MDnmqo8w2zowuod2lSfdQURncs7Jj
	oRxcKpINtMsmbCByuzG8QEv0envt3IWrowklJJQoPzoruNmt4mzFf0FeeV4GRIT0Ky7Y=
X-Received: by 2002:a05:600c:19c8:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4a967201e9dmr16334615e9.27.1793152766074;
        Tue, 27 Oct 2026 18:59:26 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a976010ca7sm10831475e9.1.2026.10.27.18.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:59:25 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com,
	robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	iav@iav.lv
Subject: Re: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is already valid
Date: Wed, 28 Oct 2026 01:59:23 +0000
Message-ID: <20261028015923.2436122-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com>
References: <20261028005603.2399220-1-ehbello@gmail.com> <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 09:34:04 +0800, Shawn Lin wrote:

First, an apology for the noise: a v4 went out seven minutes after your mail
and crossed it. It answers an unrelated review comment about T_PERST-CLK and
does nothing about the points you raise, so please do not spend time on it:

  https://lore.kernel.org/all/20261028014116.2432425-1-ehbello@gmail.com/

I was respinning too quickly. The next version will wait for this thread to
settle rather than landing on top of it.

> The assumptions here rely on a very weak constraint. If some designs
> don't define the 12V and 3.3V regulators in the device tree, but those
> rails actually do power down along with the rest of the system during
> suspend, then upon resume the reset wait will be skipped entirely. I'm
> worried this could cause regressions.

You are right, and it is worse than that. vpcie1v8 and vpcie0v9 come from
devm_regulator_get(), not the _optional() variant, so when they are absent
from DT the core substitutes a dummy rather than failing, and
_regulator_is_enabled() returns 1 for a dummy:

	/* If we don't know then assume that the regulator is always on */
	if (!rdev->desc->ops->is_enabled)
		return 1;

Combined with my IS_ERR() checks treating an absent optional supply as
satisfied, rockchip_pcie_supplies_enabled() is unconditionally true on a
board that describes none of the four rails. The wait would then be skipped
on every such board, on resume included. That is a regression and the patch
should not go in as it stands.

The underlying mistake is that regulator_is_enabled() reports the present
state, not for how long it has held. Probe can bridge that gap: the system
has been running for seconds by then and this driver has not touched the
rails yet, so a rail that reads enabled has been enabled since boot -- and
that holds for a dummy too, since a dummy means nobody is switching it.
Resume cannot bridge it at all: the rail may have dropped and come back
microseconds ago, possibly below the regulator core's visibility.

So the next version drops the resume hunk and sets supplies_pre_enabled to
false there explicitly, leaving the full wait in place on resume. The change
then only touches probe, where the inference is sound. That also removes the
one hunk I had no measurement for: it came out of an automated review of v1,
not from hardware.

> Intuitively, one would expect that a short reset period prevents the
> endpoint from recovering fully, that seems more plausible than the
> opposite. [...] Therefore, the actual observation that a longer reset
> causes failure is highly counterintuitive.

Agreed, it is counterintuitive, and I cannot explain the endpoint's
internals -- only what it does. What I can rule out is the reading your "as
long as the reset is clean" suggests, that something else happening during
the wait is the real cause. Link training is enabled just before the sleep,
so the root port spends those 100 ms training against a device held in
reset, which looked like the obvious suspect. Moving the wait to before the
link-training enable, keeping the pulse just as long, still failed 0 of 15
boots. It is the duration, not what the controller does during it.

The v3 table is one kernel with two module parameters, one sleeping before
the PERST# assertion and one in place of the msleep, and the host driver
rebound to re-run probe, so nothing varies between rows except where the
delay sits. A rebind reproduces the cold-boot failure identically, which I
checked before trusting it.

> Furthermore, even with the same power supply design, different endpoints
> may behave differently. What if a particular device requires a longer
> reset pulse to work reliably? How would we handle that?

The only floor the spec gives is T_PERST, 100 us of active PERST#, and v4
started guaranteeing that explicitly with an fsleep() rather than relying on
the 100 ms. Beyond that there is no required minimum to preserve.

And the short pulse is not new behaviour: from the driver's introduction
until c47f90be4c89 in v6.11-rc1 there was no wait before the de-assert at
all, so the pulse was only as long as the register writes in between took.
That is what every endpoint on this driver saw for years. The 100 ms pulse
is the recent change, and it is what broke this one. If some device turns
out to need longer, that seems like a quirk for that device rather than a
reason to keep a default that regressed another.

Thanks for the review -- the regulator point in particular is one I would
not have found.
