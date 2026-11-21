Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257962;
	b=hC+CsCK5zJn/4E7C7VpoySjtR1LJqnnJNKUasdThbkP+vwkB2Abwj7r3VouJZLpOvbjm
	 YWHOsYgrsKSH/zgZYdgTM0mPBPBfz+vcTG0eQFVFpNQPoCtQuZykpV8Zq3anguzGEaS7n
	 EEHyQT2clEG69/dEs20Zr09ma0Yfy3VkY7o6LVZczEMqg6DWTvIoINOyDzdI4brdPzfrK
	 be64P3KakSoa41qB29RdcoxRsU3zwZQDHHkR1ShyjzqNv97hIVzqj6KCImPaiPdyfluDB
	 PU+OaDuk4ku9O4Mp080ED/bj+tay2ypDc3KKoki5K9vUQbpIhwrHaA0x6umAZ7e0Pzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257962;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gsLRs05el5S8eUMVy/O2WOBbiWJRz3HNAwLOV1Xv6Xs=;
	b=AITB4KftcgOIkTN82Bfj+FUWb/NQago/MrPX3NS3kAarEl3yaEUMN6+c9Ee9K9JUDbKV
	 XSAqGE0zeNi7xQB4wlRd46cx8IlIfW6K6J+dw0ioVOKb5HR0INUOp+gZ6ZP13V6xOiTUR
	 EhkYrSPzdRLEg7yNVcX85xO4vtt8fQemKt55ICsoKChqUH9H487JmhqHVr3g5Fj2voXvG
	 1Qhl8OemYQNk54WH/uusjl3rLJuN4PVfwmfS7a7BvqUqRkDWlbrpo6uHLW8YH4HHqMdgD
	 tfDeKB4P0VmWKr+bFJJWbJfF+oBixssvdK1ReDDYC38slQWuhNl/1BDwRozqDyv9fRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgaX9cUe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFA606A320;
	Sat, 21 Nov 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgaX9cUe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADF51F000C6;
	Sat, 21 Nov 2026 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795257962;
	bh=gsLRs05el5S8eUMVy/O2WOBbiWJRz3HNAwLOV1Xv6Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NgaX9cUeyOB46uErMYn0TiSu1JV5cHTOw/8b6D2FeUWideRIYKYtfwuJ2XyvwqDmJ
	 zG9dFLwc1/gj/xCEvgddBjzwBNKNrg54dsrE1LbtQlMR2M2csuJ42m4Fda2aNIYzub
	 Oar1C3dJrvXauUwlZPYnQG8fI/5hneshV4lsB0fZYqdscc3JAgwY9E7eeB1hSzaSCg
	 7Yo2rOOl0fsXxEc1wnJKWhrlSQopj5LYO9kLudm3xwig5IBIPNwl3D+DJDc4LZcbYM
	 fUY7oTdF/7Bxi05PHPWd2iKfY8H/WDH14BvVYh60TvcO4/E2IIhOYxhnM/kgF4v+8v
	 opH/swCaOy+Gw==
Date: Sat, 21 Nov 2026 11:45:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>, 
	Luca Weiss <luca.weiss@fairphone.com>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] media: i2c: dw9719: Update DW9800K driver
Message-ID: <20261121-oxpecker-of-fascinating-tornado-747cea@quoll>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
 <20261119-b4-dw9800k_cleanup-v4-2-df26c431595e@fairphone.com>
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
Content-Disposition: inline
In-Reply-To: <20261119-b4-dw9800k_cleanup-v4-2-df26c431595e@fairphone.com>

On Thu, Nov 19, 2026 at 10:51:24AM +0100, Griffin Kroah-Hartman wrote:
> The previous DW9800K driver code was created without access to a
> datasheet for the part, now that we have one we can clean up some
> misunderstandings and add some features for further expandability.
> 
> More specifically:
> 
> Previously we were blindly writing registers to their downstream values,
> Now we know what the correct default values of SAC and SACT, and write
> to the correct bits as specified from the datasheet.
> 
> We found that the device does indeed have an ID, and add it to the
> switch statement when setting up the default device properties.
> 
> The largest change would be the implementation of "Ringing," this is
> actually an internal switch bit used to differentiate whether the SAC
> (smart actuator control) modes are enabled. if the "ringing" bit is
> zero, then actuator modes DIRECT and LSC are available(based on the
> value written to the Mode register). If the bit is 1, SAC2-SAC5 are
> available.
> 
> For the devices we tested this driver on, no new values are being
> written, but now the option for further use of the DW9800k is available
> to others if they wish to do so.
> 
> Fixes: 083f7f0dce16 ("media: i2c: dw9719: Add DW9800K support")
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

Well, not your fault, but that's a nice example why register values
should not be the DT ABI. I am going to bookmark this patchset and use
it in future discussions when people insist on using hardware values as
the actual ABI :/

Best regards,
Krzysztof

