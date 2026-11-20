Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211125;
	b=dBucy6BLnFBQzUEqWSV54Q8hoh/wMO528l8kFPziFku7724UGGFPg5mnvptgVMIQz851
	 rdneBizWedGRvt17ToicSByAxcqbS/6ySftL7xVen5Y7qp+aGX1b8ZakkGn7YJYXRlLQG
	 jdg5p0uSGT9RlZs8NfnJvOmquotSdQG6tcmmLQYZbq5JVcH435BVXj7RZasnOCKAK+IUo
	 8RhaVaQzrFi4HP7VSM8uRs7BCJg+aTW8LACNAzi0KHqPMqGLt5ISBmlHC0wy0LWD3/ybI
	 ifWL9vYvas/QfDPV+mTJ4Aec6u3vCcyae28ymm8SWr52apSE8j+3tzCl3fOM/cThoQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211125;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=7iPRfjHcD3QPP2Ak5f+fpt8vaZlfTjiFK4MIt1xLa8g=;
	b=2tJW+LMc/gb4XQvX54+JvCi5XOuj/EI9yNDC/L0rVuYz3sboY7hSg1bThw8DDebLaVqn
	 iAqPhaBNAIQxMnzH5njfHEvdhTgGD3ew8rCfaDgCBx93Bk0CQCZwlx2gDO7kD/R6O2ayU
	 KplUlZXzmONSb79YABhcKBrY1nzhvwKUcp+sfSQDG/IRkUDaMN3gJJCTIsId4K8fUueGi
	 3a/X9g+riDY2coTmXk/fgd/ixh06eE3y//fwoYFyJsNUkBvwgQl6xWdMwJb29EhkwEZkr
	 PYb/nTXx53yyhv85qW6M8mElKNPYq1mBE5HXEjnoeta9WeBcfMDtXe9CCqM/ai4IvRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arxrMPET;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2E606A6A8;
	Fri, 20 Nov 2026 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arxrMPET
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3BB1F000C6;
	Fri, 20 Nov 2026 21:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211124;
	bh=7iPRfjHcD3QPP2Ak5f+fpt8vaZlfTjiFK4MIt1xLa8g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=arxrMPETYn1Wlvc3AwMrhlDs1NEtwSkVedqBLhEKj+xmErEbR1XELMtEYke4H70Su
	 PbL/ZqnDpiWdd+aYEqr3Yp07cIoljzNer2dNU4H3/lX40eNb8pwCBvp1LZaoOrbyBB
	 Qw5wjL8GgR3+IvDvgpHG4yKhUp3/jvImZD3fNTzqguJLX+kz4jLIPBGKw59wg/xoON
	 rN7+vzNYv40FkVdmyvWX0VCRPDhL7obyxRv4Cij1LJckvS6Nx19pHY2jCdHKBqJnis
	 /yLW1Bz8q4SdbZ0JE+M382YmjOcVMbfQ1/Na+YVw2uGDuvQ2WeZOxB3vxJexHN50EX
	 eXOuBA0yIWD1w==
Date: Fri, 20 Nov 2026 22:45:21 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
In-Reply-To: <2F4EEC0F-5662-4FE4-B9A3-9FCB83B587B1@gmail.com>
Message-ID: <op182q3s-q21q-2r18-9p5n-60p7003o64o1@xreary.bet>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com> <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com> <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet> <awCMOvYf64DZfuWF@google.com> <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
 <2F4EEC0F-5662-4FE4-B9A3-9FCB83B587B1@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 20 Nov 2026, Dmitry Torokhov wrote:

> >> Ah, yes, I un-exported it in my hidraw cleanup patch series that you
> >> just applied.
> >
> >Hmm, but that cleanup is sitting in hid.git#for-7.5/hidraw, while this 
> >build breakage occured in for-7.4/upstream-fixes, which is based on Linus' 
> >tree and doesn't include that hidraw cleanup ...
> 
> Doesn't next mix it all together? 

Right, the build fails on for-next, which is a super-merge of all the 
topic branches. Sorry for the noise,

-- 
Jiri Kosina
SUSE Labs

