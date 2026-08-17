Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB5248F64;
	Mon, 17 Aug 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968213; cv=none; b=BR2vuf2YBeLfzzPilCMnoAtTDYk4DSCG5IHTta/Iq6izzoJLTIZjiBqyx0WA/TROwEETrphdbD2g/6vMjN0xFNHVPwJXqBb1NqqHNLM9pddjWeUE+1+8Y2Lb3JVCEnGPcuNLvKias54qQGFUN/4cvx+0bJkaxK2QQj8p2/inNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968213; c=relaxed/simple;
	bh=ACoCOhp5lQJrgNW9bpl3w734Arhnd/5tMaUwjZehLOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HYYW8my4PmkO/QWPFxyz4HmlZD+JjaMX5eUKIHqaNe/egbTQmL6xm8mr6xTGr0Wj73dEnQ3c9+2Ur1J2Puaqq10Zav9coAH3ZV3oRgSxDxv/eefqiSJDmlpe7Jt+E++1fWbosWZ29Ljt3pUVwT4QPlRH8TXYY8pohwq1OA+ewp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=A1r5RnPa; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="A1r5RnPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786968203; x=1787227403;
	bh=T7Qi65ZuEviSumPdpv7W1+KMSg1GaAfLV6e+a5a8Aw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A1r5RnPad3umsPyWguCQnSyaY12H+PEsysjN8olko8mMkfmrYGlCduT9GEnqaOz7B
	 xGgLewKOSgstso9p7H44S4kQDYwvaB55M9GMgZeFTDu3h4vPeft8aDIWHFl05kG2+d
	 z7oxpA86K/v0q+LfS4Na2osBjitabHR6f5Qgge3LbIYSk80/dhfQWqxjlF3rH2v/vR
	 dxfsjICt8l+tab/fwMccPwFLrjALDKNak8jmfE7aP5Mo9QIE0e9oEKj73jq2cvXsIt
	 ccD7caRF06VqQaO6tRexaXUkN+jwF1SVmvY0rxeHhAEasAEejACSJZv8H1Z5BxdmJ3
	 PAv6OWQ930Mhg==
X-Pm-Submission-Id: 4hNs150zHZz1DDs5
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "David Lechner" <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,
  "Andy Shevchenko" <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,
  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley"
 <conor+dt@kernel.org>,  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov
 Dmitry" <maslovdmitry@seeed.cc>,  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,  "Thomas Gleixner"
 <tglx@kernel.org>,  "Pan Chuang" <panchuang@vivo.com>,  "Yangtao Li"
 <frank.li@vivo.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] iio: light: ltr501: Fix duplicated error message
In-Reply-To: <20260815043715.5ec442c7@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 15 Aug 2026 04:37:15 +0100")
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
	<20260810-liteon-ltr329-v4-5-8bd3dfd15280@geanix.com>
	<EWqy49t7-NWyVAySwmEyDQgDJFuT1o3ib0wXMHAbeEiSujikP97QqQnn1Zjni3jtV360cRxw17602bFAmbDhBw==@protonmail.internalid>
	<20260815043715.5ec442c7@jic23-huawei>
Date: Mon, 17 Aug 2026 14:03:20 +0200
Message-ID: <8733wdkl87.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Mon, 10 Aug 2026 09:11:15 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> The dev_err() message was causing duplicated error messages, as
>> devm_request_threaded_irq() calls dev_err_probe() on failure.
>>
>> Fixes: 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
> Not a fix.  This is tidying up.  All good, but we don't want anyone
> to think this is something to backport.
>
> So drop the Fixes tag and tweak the patch title to not say it is a fix.
>
> Drop duplicated error message
> or something like that.

No problem.

/Esben
