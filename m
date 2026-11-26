Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697649;
	b=NQ7m9eDNB5qgsX4hY+5yM1SgFhpRqXUW9mCPIeG0BNZW5KaZRoqIWFML8pHcGesu26gD
	 55JdIl5PpVz4R06gBT3XY3UeU1jO6jqsG5vP62ywbmCfPipQ4wC/kW1lKktLx/ChVaer9
	 o0i981cgULYh/DsScCowfJ7P9ydgmyZ8XkTM7rtZEv9Efk68kQO3JPC8sbEZ6U2L1E/Fp
	 W/FSO32UZh22s3IWvLrSKF65C3I/r7hw+F2p1TivA0Vvi8URt1J7QRoKcS6JHJAx03qp7
	 jIjx/akzsAvY/6i0+rnGHV1+Obk2CU0GS6xcKvO0GvPYQqv1WdSifoRoqS+0D82y1HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697649;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1eGZAHcdQSSh2BKXte7f157cFdC9KIFSwmvdwmH1yp0=;
	b=yf0jfcnQEuYGtuY2e2Ul9P1vqeOEVDrX9bLytI6fiZbIizghhxmjL95GthjdjYWLn7Lj
	 K3+g/Gcqj0VpVpECd3q9IEQyDMRw1DjaPv09Eq5yulFVCi6NyULk8ylPL/REgckt4JlSx
	 HoF6v3GHFgorT/+45IFbJMPhRxGkrO8S9i5vc8jxCV7on8YSZRo+Fe/GxsHoGGvm4521B
	 aIfGh96v6MfCowU5AJSsfPeE6bBr3ERnVkIW9+Sj1LEp8MCGbhciIyw9rSgL9Q5UuNw3f
	 0na75u/JFtxW9yMjAVQ3o77F4Ci7sVBP2wjTg72wfnWm9UbfmuLUiSf7Jy/XlYBSWZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvNBamKv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD4606A31C;
	Thu, 26 Nov 2026 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvNBamKv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E958E1F000C0;
	Thu, 26 Nov 2026 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697648;
	bh=1eGZAHcdQSSh2BKXte7f157cFdC9KIFSwmvdwmH1yp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dvNBamKvhhU2WYf7NnfnVsEBn4rtyCGX4ZGMnMFktRiVavkuUxlEs0KOWVP0Tc1zq
	 w1ZOOq9qR6WtEI71tmB5TEf8gU2xk66jlPDPUu8onD5OiUw80c8gKwvhcJOT7LM4FO
	 exedDkil4sTSBWLh+CwGU/4G8l5mWXHQQpFQCi3Z0Su256ozhl3rI/VmKPWInCAOkw
	 35zdyKB7J6IJDj911rQauxSRntfpeK+w6z8qelNwxfAFthhhDzjspLP18Dw+aLvkfW
	 15Hhh7O4gcQe4vzT29IEFbDgcr4IY+1A6W3n9APweBQc7Mht0IXPQL7t2t7UyGyPiO
	 I3EXvtbT0l7Pg==
Date: Thu, 26 Nov 2026 13:54:05 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Werner Gartner <Werner.Gartner@congatec.com>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v6 03/10] i2c: cgbc: Use real I2C bus names
Message-ID: <awgr3fSG-6yYEFlg@zenone.zhora.eu>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261117-cgbc-i2c-storage-devices-support-v6-3-bb070ad3e9aa@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-3-bb070ad3e9aa@bootlin.com>

Hi Thomas,

On Tue, Nov 17, 2026 at 10:47:43AM +0100, Thomas Richard (congatec GmbH) wrote:
> The adapter names described the expected purpose of the buses ("General
> Purpose I2C adapter", "Power Management I2C adapter") on conga-sa7 board
> rather than their actual names on the Board Controller.
> 
> Rename them to the real bus names "cgbc-i2c0" and "cgbc-ddc0", matching
> the naming used by Congatec.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
