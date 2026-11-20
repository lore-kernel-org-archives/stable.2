Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184708;
	b=xh+EFxF+kIZcztRWGcScox2ctIQwa9ysFJpD+SUsPuvUKjzndghjk8oMs47n6nE9H3TH
	 wPORLH3N7B/QeXFPW8BO8HZgrKbTYtK9gPFAxMDq+/EFrV1YQwClwPmnNWZ3b7N0vm2fy
	 hejC+IrELqv3E8NzSmNpNnZ38Bd4FdAoOp+xigkAA6eG7V5OcAxFTfiZHWx7F346BB1Ip
	 DLHOvuypawvFgfaav7jW3vUtMILtU0VmtdzrVrgtcPiXjEIvvoQ+g/enholeyC370XeqB
	 Fl6H7bHCGnJy+y6sBWIrIYm2/DSOJRXFY1hTck40hXlFRzs82ZFNioHzP4NS1WT0IIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184708;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=H6O65CLLUWIgdMsDRDATl9RK7ce3kVGQoA5luepajgE=;
	b=M6mSSmIPtUZDuMKXfnNsgU3SU9JdHMBzJNNsR/9eKM9dE5tPsHTlNrev3y692eULOTgE
	 LyEKjX8sZVwjQJo3Y/uI6G0k95SFWQ30En7L7pH4dw+jtyfV2Ug2iUYbImUtVNnxXBHYE
	 6Vd7PAdzW8TqSuIbOftvLHyaHuwerW6e+8TRZepllcOSbVVY7rnHspgOdU6Vr0G2E1pUp
	 WMs/tyrMDGAAmK94VU6PqT7C0XfNzovdz5+K8J/A717F5ICJaRXNe7wjQeT7r6UV5VDVg
	 Q8eojXv63PNANxhirgmnKYNs3J9nIUBIMqvZUMq0mYN2zPJIcTe5yA88IsArY1T9djg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ9R6d5G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67268606A320;
	Fri, 20 Nov 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ9R6d5G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4901F000C4;
	Fri, 20 Nov 2026 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184707;
	bh=H6O65CLLUWIgdMsDRDATl9RK7ce3kVGQoA5luepajgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PJ9R6d5GOaIKZEi4nmUquLjpNC1fiotHXi8WNi/LYohKkNms6O4dNlWJdqSaRIEOb
	 AU9MRFB1AiH50y0IDCqTRmpGiufDT0gmaU0aznIQz0hQm4euAqnoT3z+eywUhc1rxF
	 +sMkFT7mvfUSq1XN5YmSYQXDpdw00+81xwb1ZWKwxtjK9iX521jmUBI/2+x3k2eH1d
	 Qd+h0JA+BjSUHl/HopNh1L8JwRv90afaJQyizvyWqH0OvjSEeA7CnNAKag5ZGL2f0W
	 m0J3NF/iBUkTY+IWArmEtk5Yhz440vv02XH/amO03s+yQqAX2CIAbi497oKNILAtTf
	 osXxmq8dwm/Iw==
Message-ID: <45fa03f1-6a0f-47b0-bfca-8eb295aaf86f@kernel.org>
Date: Fri, 20 Nov 2026 15:25:03 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH] usb: musb: fix use-after-free in musb_remove()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bin Liu <b-liu@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Felipe Balbi <balbi@ti.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261107-usb-uaf-fix-v1-1-ba33689d0ca3@kernel.org>
 <2026112054-sweep-flap-b94d@gregkh>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <2026112054-sweep-flap-b94d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20-Nov-26 15:11, Greg Kroah-Hartman wrote:
> On Sat, Nov 07, 2026 at 12:46:17PM +0100, Joshua Crofts wrote:
>> Currently in musb_remove(), musb_platform_exit() drops the PHY refcount
>> before usb_phy_shutdown() is called, causing a use-after-free bug.
>> 
>> Reorder the function so that usb_phy_shutdown() is called before
>> musb_platform_exit(), the same way as musb_init_controller() does in the
>> error path.

...

>> 
> 
> Does not apply to the usb-linus branch, please rebase and resend.

Sorry, rebased patch here:
https://lore.kernel.org/linux-usb/20261120-usb-uaf-fix-v2-1-cc3cb2a38ad5@kernel.org

-- 
Kind regards,
Joshua Crofts

