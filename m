Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343912;
	b=jgdna8B39kchWQwz9p5iGrZpuH+udIZXzcGvHClFZIlziWGL+0MXJsnm12BPuxW61XOO
	 FLvp4JcP9GzJue8a4jU6eVDYfTlxGqFXxZ/Ox2EASE+R1gKPSjjOmxA2S3C/G9RRzDb8O
	 +UXLggRQIrhO21ZQ6c5ryHNXPXhUZ+sCxRVvcSIlbuMgeKuhfyBsDzaZu9w/+xGq86H6P
	 2RSn2YHTxyjNtVms2TAA56zVZQh0qaNdcGDr7B1OJmFtFWnzID1Ti3DDRf9NUF1suLLrg
	 xQ2GQlsHTklw7VbzVUP4RAJQqEq7kj32q7AkH8fdQd9TYoMadHoE/vLQbt2kVDk/wow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343912;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ndFzpOQfr4dmnnL821+zKdNgvevfL4iCv9N/kuCrB64=;
	b=ulfsGPjp2/YaeFEAva6Pw+aSfec1yDBzj6gTFDOWdTIlh3SprEg33Q8K1wNERoDSWEQv
	 r+Df0En1Aiq8BHwbWRFiQFWJ96ziJQ7rXm7kctsxvXUtT5DGVcYvRG6PnEAlmhdgwOZTS
	 qN4GNr70Ah0gEDUwS1huAl5muDlw5ob/bhQusIBjzoOOXRw7O3QRmTXlMlnmIAG8GP8N4
	 kuqoK/0KO4UzV4su11LqErQRi8l5fbINWqftE45u0BKB6HMv/3SOFznLpWgshcbqY3d05
	 gGYQnw9BAL7pNfrXBWDRn1cKwzrryjU3LdjTmG4LKGdavoGysmvAoOOItbrwrMkPseA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pZZnDX5z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07724606A320;
	Sun, 22 Nov 2026 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pZZnDX5z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F356C1F000C0;
	Sun, 22 Nov 2026 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795343911;
	bh=ndFzpOQfr4dmnnL821+zKdNgvevfL4iCv9N/kuCrB64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pZZnDX5z3ZLDJJlYq5jsYGPHj/qxzVUt880payjTTM/KMJxzG6IpW/DDYcRLL2yHa
	 dNBKetGDMYsMSO7hUu3tUDH3yviSM8bQ2WfvmuQGuHtHquGcEck4+78KQ5XwY+zos2
	 m0g09I2zcMHdQPMb9vzc6CF1+pZCn0qzbCkaof0I=
Date: Sun, 22 Nov 2026 11:38:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Andreev <drunkbatya.js@gmail.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: fix missed frs_sourcing_vbus() call
 during FRS
Message-ID: <2026112206-lapped-unvalued-8696@gregkh>
References: <20261122102839.2902079-1-drunkbatya.js@gmail.com>
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
In-Reply-To: <20261122102839.2902079-1-drunkbatya.js@gmail.com>

On Sun, Nov 22, 2026 at 10:28:38AM +0000, Max Andreev wrote:
> Since commit 0908c5aca31e ("usb: typec: tcpm: AMS and Collision
> Avoidance") the TCPC reports sourcing vbus while the port is still in
> AMS_START with FR_SWAP_SEND as the upcoming state. Because of
> _tcpm_pd_vbus_on() ignores this state, frs_sourcing_vbus() is never called
> during FRS.
> 
> On Pixel 11 Pro XL after an FRS from sink to source the phone keeps
> showing the charging indicator, and about 20 seconds later VBUS drops
> and the attached device reboots.
> 
> Call frs_sourcing_vbus() from AMS_START when the upcoming state is
> FR_SWAP_SEND.
> 
> ---
> I'm not test theese changes on mainline, but tested on Pixel 11 Pro XL
> vendor kernel 6.1 with the same _tcpm_pd_vbus_on() code, as i see
> mainline tcpm.c is identical in this area.
> 
> Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Andreev <drunkbatya.js@gmail.com>

Why is this all below the --- line?  That will get cut off :(
