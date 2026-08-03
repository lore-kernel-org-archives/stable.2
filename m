Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939B431E5F;
	Mon,  3 Aug 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781920; cv=none; b=pVIsIfYSB6oRgGh1+q6XPVi4fyrLkjGaAFWE4BLQlakbG+3fPhYESrclV8SKN2B04Yz3dd25jb7Mi+inv1YGEyyM7KIrK1vb63usP3DjjMXqZuZ4LewRpiW4HUMD586Nco/+HJ33E7qSSI0PR1GvTHjIbyJFOPPmTb9LHPiVcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781920; c=relaxed/simple;
	bh=yHSIppssmau7O/Uyl01a9DiF2/hrLb4vJ1TmcATHfsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PxoqxreZClm8fLWMQDbLTX3uJv9TRmJStDcjxvS1U4lKhmbskBiQZaWs/OTRDuL96S4AgrxIOCuakdvjx6FoTr7pj2ICEuX77FmmiidKZ79W/P94tm4YoMmLnfp+vOtiRfmPmDo7pCqjSBBahbix1TcMnU06Og1M8skXf9x+848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvSMqXUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvSMqXUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BCC1F000E9;
	Mon,  3 Aug 2026 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781918;
	bh=dTO6i08Bpg/9llOoeYbUZoHRz6oH1MCnWADjDMuXqP8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=XvSMqXUwRNPcVWSYtY/TLjU9Rl2TgWEr43u30ApbWDPM41+XwUiESlDUxfU65wLib
	 FlfOLK+eL3/7DBtVTG9Mlb/HcVwkMp5NLVZpBv+Jr5a3tYJwOgc7RTSLk5ccPxi/t4
	 +UjC/wYXRrJ/1Nxa8xEByuNJKQn4QaamftgTCAv0DIxALcPQ3xQ+LGRP+O4oe3oNNT
	 YLLdD05dT7qSDCDVyV+lyHRSHdIYHcdDRpHeVKJowk2N1AlTlZ+oz3DtrTCquPamHs
	 1AYhVD/LT6jC2un1ZgOLAi5qnNKQItjAJbi12j+h3nO0oRFjta9NO6zeeY2p0ck+AI
	 vEBScUt5sQNKg==
Date: Mon, 3 Aug 2026 20:31:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: sony: clean up device list on probe failure
In-Reply-To: <20260726124551.15323-1-doruk@0sec.ai>
Message-ID: <4q8o020s-9pp4-q2n7-1rr7-470689682pn7@xreary.bet>
References: <20260726124551.15323-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 26 Jul 2026, Doruk Tan Ozturk wrote:

> sony_input_configured() adds some controllers to sony_device_list before
> HID core registers their input devices. input_register_device() can fail
> after the callback returns successfully. sony_probe() then observes that
> HID_CLAIMED_INPUT is clear and unwinds, but only stops the HID hardware.
> The devres-managed sony_sc is freed while its list node remains linked, so
> the next matching controller traverses freed memory.
> 
> Initialize the list node and device ID to inactive states. Make list
> removal idempotent and run the driver-private cleanup on every probe
> failure path. This also makes a second cleanup safe when
> sony_input_configured() already unwound a partial initialization before
> sony_probe() handles the missing input claim.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis;
> verified against the HID input registration and probe unwind paths.
> 
> Fixes: 4f967f6d7374 ("HID: sony: Fix memory issue when connecting device using both Bluetooth and USB")
> Cc: stable@vger.kernel.org
> Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Link: https://lore.kernel.org/linux-input/20260724143925.007D61F00A3A@smtp.kernel.org/
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

