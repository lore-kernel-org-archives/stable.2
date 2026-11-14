Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617430;
	b=mUeQGBgLPdQy1oqhb49a5fuyV6Lu5Z27zVSRWsT9ZY5viiAR5AIrRP0LTtMegjbv3BHa
	 4cNEAgiFpuN3wGLH9bw+uFfGtpTnh+m2SiMpj/fa0gEDPnfOjOQHT2fnbOhS/PR9xpdFE
	 +Twfb/JKPUAcnlIrf8iP0tNupSjvhpPYybGrzQiUPuwTkpsjxrdpRo7r919Nrb+bHaTZP
	 OnAKaGJVJBrlRpOMg1gjQ5qcXdFBK67CkfCEMQ99AhrvYxMn78BrmNh9rdN6U7rX2CrJi
	 /PWPHKoZle10rdhyuLgCL4EqZCTODL/cyYaxTSV76nunu/k1sjn7hqBo3hpdaP4HwiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617430;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=rLSKJAjdQ30Vjky7tJx+bCFWc1SyvtYYvxDMUVTLXvE=;
	b=Ebd1hkoqh/MyMAP4vmPAqakQp5danaw7pMeFrJAzQpvhjenPKnlKXIt4vCVsUpguis4v
	 rkpng7nqpwGt96MjQAptwisULbI///LZo0ymQaMZnxrY3RdJNepThRy1ssFNSrklIk2oR
	 nlI5SK2TfmveSom+xilZYWWcaGTmADptCIeGtVTQg9sRq1Dg42ZTkfkCQC/A+rnuTctCG
	 uUAUd4Y7VwhroikKS7iihh4o3fPNyDSgwt94tUgQ1hxvaxsz1svC7BOqYvbkJEwx5nBLE
	 HV6i1ePnNaTK4YBWV/tXewsH9wyByc7luSTgth87jVwxAcLyVSQ2D8xX2fS3/+A1scQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=S7p3BxY3;
	arc=none smtp.remote-ip=185.70.43.19
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D61606A327;
	Sat, 14 Nov 2026 00:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0D61606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=S7p3BxY3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794617426; x=1794876626;
	bh=rLSKJAjdQ30Vjky7tJx+bCFWc1SyvtYYvxDMUVTLXvE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=S7p3BxY3+zyWG/4+usTUelBlt7jQ6oBsNBXH/4O6QaTuZmKuXpVmIJplfewyYqC1h
	 h2Tka5t8M2ZG+gm6FPVItdZKB5BS12DpknnHXvTSuY3g0T15EUWiQtfvPkgaHWtZp4
	 RY4BsPFKOxuW2XlxZQvD90xWPUoI7Add3baCMhsqG6e67AMetYGmFRGie8FM9XksGr
	 2AiMNWcIqEMJUDD69BSN0wyBVbg5AbpWMSHgOr+wYZLDaLVsX36i+pK763j4G8fOVY
	 etE4OabbVX7H/FVVVkUaI2COUASETuRtQp5eAzOynOJrB8mWHqclx+fbbiaov1sB1B
	 NnDxnBv2F7UQQ==
Date: Sat, 14 Nov 2026 00:50:19 +0000
To: Denis Benato <denis.benato@linux.dev>
From: Aspecky <tarrihmoad@proton.me>
Cc: Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Antheas Kapenekakis <lkml@antheas.dev>, Benjamin Tissoires <bentiss@kernel.org>, Sercan GOKMEN <gokmensercan@gmail.com>, Burak Goncu <burakgon12@gmail.com>, Denis Benato <benato.denis96@gmail.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] platform/x86: asus-wmi: Ignore unusable kbd backlight WMI device on ROG Strix G814FP
Message-ID: <-sHRKK56awNgHWFUXMcBVRL0SSag0CruNAfbxPNPYJJC8qqk_N74k3wCldWqNkfw-CBwHj-6CvkYhrkCsBYqgNNUQV2oT31VbehOxMbR87E=@proton.me>
In-Reply-To: <04c46822-9baa-4152-8193-d8aa9d757b4e@linux.dev>
References: <20261111-asus-wmi-kbd-readback-v4-1-79df1567476d@proton.me> <04c46822-9baa-4152-8193-d8aa9d757b4e@linux.dev>
Feedback-ID: 110671326:user:proton
X-Pm-Message-ID: a91a08dbf9326579b6cc51664856e37e4569519b
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

On Thursday, November 12th, 2026 at 10:21 AM, Denis Benato <denis.benato@li=
nux.dev> wrote:

>> On the ASUS ROG Strix G18 G814FP, writing a level to the keyboard
>> backlight brightness in sysfs works, but reading it back always gives
>> 0, and the read makes the Fn brightness keys misbehave.
>
> With "works" do you mean the write report success but does nothing or
> that it is actually changing the brightness?

Sorry about the confusion, the write does actually change the brightness.
Writing 3 to /sys/class/leds/asus::kbd_backlight/brightness turns the
LEDs to high. asus-wmi passes the level both to the WMI device and to
hid-asus, the latter is the one that registers as a listener on the LED.
The DEVS(0x00050021) write to the WMI device fails with -ENODEV and
changes nothing, hid-asus is what actually sets the LEDs:

sysfs write -> asus-wmi |- DEVS(0x00050021) -> firmware -> rejected
                        |_ hid-asus -> USB HID report -> LEDs

>> DSTS(0x00050021) always returns 0x50000, which is level 0
>
> Always returns level zero with the presence bit set.

Correct, always returns level zero with the presence bit set,
i'll say that in v5.

>> As a side effect, the kbd_rgb_mode and kbd_rgb_mode_index attributes are
>> no longer created on this board, they never worked here since the firmwa=
re
>> rejects those writes as well.
>
> Isn't this a contraddiction to what is written above? That writes
> actually succeeds?

It's not a contradiction, the sysfs brightness write succeeds because
of hid-asus, while the WMI DEVS(0x00050021) writes are rejected and
so are the ones behind kbd_rgb_mode. The commit message doesn't make
that clear, I'll reword it in v5 and wait a day or so in case there
are more comments.

Thanks,
Moad

