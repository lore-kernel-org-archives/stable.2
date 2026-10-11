Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00E35CB6A
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763053; cv=none; b=ohZyLWXCq/w+eS8luK5nVoCQ47yvEe1kURPilJnH+z9VrmgxF3VIf8e8Htk18hJ37w9+d0JFDL/Sb3xw90Bzu6auJXLtq1bmKIed1jDZFq+UQbnl2G6XF5RrV9kVptsO5ViVpkblzoOA9ro7j0mlxjfhqC25q8YW/PjXzyXXVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763053; c=relaxed/simple;
	bh=VKnH2yGmZMcFZt2mH89aB22XW2Y4GUfsPSnGPGdpbXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MecxMrm1sySCVEHkGxi23q+Bj/5jjLMWZDAGXqIve8lYn/85eXF/4v0rFZC93glmxa5+V9cdi7RYzpogftQFXkFj8QpHY111HdXQllQO4eS1SzQdm3yWv0a+YTtRX2dKgdZBMkb2DTfPu64EPRX/CTVvZ6jBltQ5KqhR15/7sR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEP+gmzr; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEP+gmzr"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso3461519eec.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791763052; x=1792367852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cRPcpD4bGybI0n7FRTBMhW8q9yb51oDjvzb7f7KdtWo=;
        b=fEP+gmzrGAAWoYazsw1jrvz8dHBmNVw4Bj50Xzr84Ev+ScPp3+JoL0cfhHx7Fs6ay9
         Bv7aZ7MybA2kocEijKfjyyQQhlr+QFwyXzz9jnDxL0RPBs8yTjMNZzQQmjtuFassHZdz
         vva+L2tbA6moSYZ2AK4A41hiWDJKWNF+84488r2Ci1/BML9JHZ55VPj8im7MstjuKF/R
         4uNYNsYdX1R/vAL4yzB5xmM5xTxOpW4+MMpy5SPZxA/T2xXRH8MwkZpxwAMqI2kjTXo7
         kppQVVHrlIQghpYp5p1ahNpEZrHhCJsQrXV9QaV3r2XCN6Hhkr7XJ3m7DsJPNoF+INjp
         K1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791763052; x=1792367852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRPcpD4bGybI0n7FRTBMhW8q9yb51oDjvzb7f7KdtWo=;
        b=NgHPYp8+7I5WTrr0uS/UbTCl3VpL8qVceq9l8dysMSSwh8P53T/GLXXG9ak/IgAG4z
         OxEC3LCsKHNaxknoIpW5rW6QCnDtGwVet/ferl1XXl/eTeGblTaJcBht9yvaek+00DXT
         hOA7vDKYbrO5xgF2yeFFqCoLOWjoxeNKZWxBsJQQOlX/zE2iakMtZImxzek4QzQ6rzum
         hWStDPLWrbwmd3FPGbcGMPFieIe6lz/7wftC3Cdp3/otElallS2EefU3laA/jW5z7Cb0
         0xu+5Pdg2L3aqsgANLz0eZ/t37FZNV+lVhxzfoVtp/hchQCm3MH4jaghn4cWPfHB8Ivw
         je+A==
X-Forwarded-Encrypted: i=1; AKwUvBwtx88lUxuQ3/HPAFsimqeWSarIYN40jwVPJM54oSeWcKOwCPTxF2lQ5eRqtP39aZPfu/0/7t4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrF0lMTx+lv0uecRsVwJ/aZ9wS9Fil7mBhXIAOjINCi3cXKMH4
	/7jh8VoIrZOlNZFWFzgAHxtaoQMtiS+DbSQngxzy0LzqjdV8NMd3f7RtuBoaLzoj
X-Gm-Gg: AYBFou1Rbgtz8Osf9YpSpeNFK8YEvC49kQQNacO2DxF8E78/V/lbaopP0WqlQ4+tbu6
	fqULew8k2LwUovoJEjmX/yVB7zZBpY1mjdQihMkfvemxECSmZh+zdIkd4msYYGXBbPfCw6o0M0b
	CsaapA3RrltxQ5+HS1T7diaLhfsZpmA3wMMDKsT7jouqRYmko+Z+e0y4dk2FggucuoeeBISEtTa
	nNbkZfAx8eSagvUWoyIVOXiAhkWaQ7klIm4XPWEg7bPKkVbSAjeBKJRQfiWtJeKa4XJRhdjxv5p
	tNERpqRaTAhv9GxBFb2R6mCZWc2rWrsgNPRLUoViQwnhLrZF38mlsVfrV1UJ2bpASdF96xIFVOu
	YcULLJOb3gaB+eXyYryq/o7zibsPq5QX4R8wV7ZdhEddcGf7aOsc+AUBpOYVNDlEgYOsPXTUeVX
	bE4xQ3yUa0H0ZML9yhGo90tbmWlAhIFBigY7uZZd1vIgIeN3mYf3nlNYgVK94R2LbOkixeKgA6J
	WO7qwyI99Ehge6PvycNvDVotjWcC9aVox7Q9AfC
X-Received: by 2002:a05:7300:ac81:b0:34b:f456:25ce with SMTP id 5a478bee46e88-3537ddd6fb4mr16618625eec.3.1791763051589;
        Sun, 11 Oct 2026 16:57:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8999:e631:ed58:366a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c843079sm26847414eec.1.2026.10.11.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:57:30 -0700 (PDT)
Date: Sun, 11 Oct 2026 16:57:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] wifi: carl9170: revert broken devres conversions
 for input and hwrng
Message-ID: <aswgwre0SeBnYZwo@google.com>
References: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
 <5771235e-fa91-402a-b5d2-ebb153872c26@gmail.com>
 <aslvBb9VbMvnHmHi@google.com>
 <76210777-9f09-48ce-af97-90fec06a6f84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76210777-9f09-48ce-af97-90fec06a6f84@gmail.com>

On Sun, Oct 11, 2026 at 04:41:02PM +0200, Christian Lamparter wrote:
> On 10/10/26 1:13 AM, Dmitry Torokhov wrote:
> > Hi Christian,
> > 
> > On Fri, Oct 09, 2026 at 09:37:36PM +0200, Christian Lamparter wrote:
> > > On 10/8/26 11:39 AM, Dmitry Torokhov wrote:
> > > > Commits 23de0fa0d2a0 ("carl9170: devres-ing hwrng_register usage") and
> > > > 87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device") converted
> > > > the HWRNG and WPS button input device registrations in carl9170 to
> > > > devres attached to the parent struct usb_device (&ar->udev->dev) and
> > > > removed explicit unregistration from carl9170_unregister().
> > > > 
> > > > In carl9170_usb_disconnect(), the driver calls carl9170_unregister()
> > > > followed immediately by carl9170_free(), which frees struct ar9170
> > > > inside the interface .disconnect() callback before devres_release_all()
> > > > runs. Furthermore, devres on &ar->udev->dev is not released on
> > > > interface unbind or registration failure in carl9170_register().
> > > > As a result, both the WPS input device (whose input->name and
> > > > input->phys point into freed memory) and the embedded struct hwrng
> > > > remain registered after struct ar9170 has been freed, leading to
> > > > use-after-free bugs.
> > > 
> > > Ok, so you just reworded your patch? Sight...
> > 
> > Yes, as I promised I would.
> > 
> > > looking at the WPS input
> > > 
> > > |        input->name = ar->wps.name;
> > > |        input->phys = ar->wps.phys;
> > > |        input->id.bustype = BUS_USB;
> > > |        input->dev.parent = &ar->hw->wiphy->dev;
> > >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > > the input's dev.parent is set to ar->hw->wiphy->dev and not ar->udev->dev, right?
> > > Does this do anything at all? If not, why? The wiphy gets shutdown by
> > > ieee80211_unregister() and having the "freeing" stick around after the USB device
> > > is gone should not hurt, right?
> > 
> > devm_input_allocate_device() explicitly states:
> > 
> > 	NOTE: the owner device is set up as parent of input device and
> > 	users should not override it.
> 
> Yeah, and this is something you added in 2012... 

Yes, in the same patch where devm_input_allocate_device() was
introduced. This requirement was there from the very beginning.

> The carl9170 code driver is back from 2010.

No, the devm conversion was done in 2022, 10 years later.

> 
> So, was this changed to "break it", rather than the driver?

The conversion to devm in the driver was broken on arrival.

> 
> From my POV: What's the point of devres then?

In certain situation it allows to reduce amount of boilerplate code in
the driver. But it has be to be used properly. One of the most important
thinks it attaching resources to the right device and not mixing managed
and noon managed resources in the same driver, as that very often causes
incorrect order on unwinding.

> And why are you so "eager" to revert the changes.

Because I have to deal with syzhot reports routed to me and I would
rather not.

Humor me: why are you so against reverting the change? I have shown that
it is problematic. You can go back and re-introduce devm for input once
the rest of the driver is ready.

Thanks.

-- 
Dmitry
