Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200801;
	b=GHj2jwVqWa+7HO8F6CZNyrMtOBU/mTpX9QXAILB928mFprZTzvZNb9xx18iKEob9mbV6
	 1pC9U6B7WFkvdZQ6p5xOAAAMtSUPirfL6w3qgKnpKyVnL57YDozljmn0wbeyURj2/xNiX
	 mnbXYQe5WJ2BbVCirF7Vca1rux/u/uTc/gi13a9LJ8dKYrTTf5xuTdBGYpTpCaDpsjsJb
	 v1jc6TdE0Q8PmiQBqzKeloAUZruL23kiMFgIYvVwl93tEVgxXd3OwGmJn/8ygS90HGOhJ
	 fiQmCVVWW8k8HkWw+nEprE+h33xOtusUAstOEL5YP/dBHCYVolcgkr4NH1rrHpAy6lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200801;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=A9z9mPc50c9zcO2nI8W5ZaxJzLIoB0ucd+UQZfv8iz8=;
	b=0gGIt5DsCSQfGOO4eJ3ksRg0pmeGhtvIyT7qJwMs3pfwB7pE0h4EbOVeKQsHfKmoduKX
	 gLtGaOn3PV5EomqANIyJ58OI05igGvoDyeDdJkBsqjrzQWNhPQP1qvsTPymqRIa9BGKH/
	 py7L1twAP801rFQcmz2JWkH9vLt3fuL5xuYx9WmdQRcgk1qHt7xC46z0ty7PjkLHzh5fh
	 4hv+R5I0o4PueJcLWovhzyRnaAX2tA81fnkvjmHdxY6+9jFiLMb15n4N5bStXOGuOzcv3
	 3OLGl9CsJ9RJeBTxT88ZgcIHixmZgKi/zdGCcHbf9YOFvLDpOQnC28dxXisWMcYYR1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBmlPsG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5060606A325;
	Wed, 28 Oct 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBmlPsG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66D71F01825;
	Wed, 28 Oct 2026 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793200800;
	bh=A9z9mPc50c9zcO2nI8W5ZaxJzLIoB0ucd+UQZfv8iz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZBmlPsG36+63vfQ43cx6IG1M4sJcNfI+nj8gsLrSK7Fc3QS3Uc9M4jNJ2H7Iprlr6
	 BBMSjBED/JD4PYOiq6CBIPGIf8wsT1o5XQFwQskPRTEuk59C2VJnIrS8sBH327+w5a
	 18pxBHcvp8Gd1vsWyVU2gbEpP6fKutCmA5FA+y/sLBgEvag7IYlFqVCp5VoDqdDS6O
	 4RX8GLMvLSFG3o8tWOHy3jRbd0z1dLMB+SA3vN8cs1+6TwZLBxW/8TbxznEF3pOBge
	 hWyxV76Ef+1QRdBx2IrOCyftW4r3op9sAXOH58uOmV6NahosQnzZ04rHgyXZlPk4Zu
	 u8/o27dYDsO9A==
Date: Wed, 28 Oct 2026 15:19:56 +0000
From: Lee Jones <lee@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: tca6507: Fix use-after-free on unbind
Message-ID: <20261028151956.GA3774906@google.com>
References: <20261015144033.56519-1-danishkhateeb03@gmail.com>
 <179213356828.2581328.5085333261240588869@kernel.org>
 <20261028134857.36086-1-danishkhateeb03@gmail.com>
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
In-Reply-To: <20261028134857.36086-1-danishkhateeb03@gmail.com>

On Wed, 28 Oct 2026, Danish Khateeb wrote:

> On Wed, 28 Oct 2026, Lee Jones wrote:
> > Please review, explain or fix the Sashiko review(s).
> 
> Sashiko is right that the "LED off" write queued on unbind gets
> cancelled, but that predates 1b5c2fa7081c: remove() used to call
> led_classdev_unregister() and then cancel_work_sync(), the same order
> this patch restores. Since 1b5c2fa7081c that write only ran on freed
> memory. If you'd like the LEDs turned off on unbind, I can send a
> separate patch that flushes the work instead of cancelling it.

Submit them as a set.

-- 
Lee Jones
