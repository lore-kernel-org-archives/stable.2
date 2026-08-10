Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C136167E
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379110; cv=none; b=UZI4tkymqnWaHsuVAMJONB68GjBBv8RepxxpzACz6S3o3rCkw6RnaV2EZbdR5px0exMr5NwGuBkKCqF9WyfJmc5Rns1n2qtgTBoOW2nCytM862CjWx3fOX88Nb9OWVbfK0mVZx7dY0RNoxhssCOylqUVPTlUs2xWlm5N39YD6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379110; c=relaxed/simple;
	bh=eueGAj8oGaM4kLErdKA/dG4Vvkc38iQ6SdZdskMAKH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l60PsOgEwT27R3Wr4WJQl6mcvqz9qcGRgFPd1xEVSr6vQ+iag2CVuNJshcoekMJ/r+lpGyVmQTebLJ8NHdkUvQAlQa++A0LzSYfgZ6JLwpa45oUUsp06lAqlhW/2oAB31DCqQ3ieGUiccitkSZqsQxEqNUhd1p0LzzbP1hECGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRYEdOJo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRYEdOJo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2256726a91.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786379109; x=1786983909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fwrUhGiqFfBO/bQRRK3RvNMgcT0RQUx4H8uPR9x4Qp4=;
        b=LRYEdOJo7+loBOEy70i9mAg37sr0YDRtLyytMLL82/24H1hGL8BGoWfc3OMsujMKpO
         Wy6g3WjpcY/PmcYfXQRI/4vdq6v1/xVqWnRnoJ2rLU7EzuCNX5MNYqkEi/FsYiD2PEKb
         V+GRgZm2ukabYEwCqCUrZ7KitVIYJ9xBOsr9fepxy2uOSoC33dsIgu9baj1oVm5G4pAS
         3CvQ80UDQTPDuU8WxXu7c44EXMLOaFyTNYHn1njYYz2ZwduInyeXDZeeDxREwa7X8tJd
         Be4waaK4wt7pmMCkJZZJoFcR0oY9H6P0rtdC48vmC6+yS6RusiQ96A13zFTrVwj7Nh/P
         w6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379109; x=1786983909;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwrUhGiqFfBO/bQRRK3RvNMgcT0RQUx4H8uPR9x4Qp4=;
        b=ZOjhnfyTkrfRfH2mSl22kSTiBWwPKkJGF80BkcTm1CKxN++1hAT+5VuTCcUyKJjRLk
         TwIzU0Z7djrH0n8MZGzIcnTEEbZVJRbnvdNOwD2g4/XrpJmjnIw0TQ6pSArP/Fxq7vGE
         rZ4WJGMj48NKlxNIbskV6Wf3WQuiFP/Tj6wrUzAn9VgvLktn13EPkBcOSRJGXhn/q434
         Hb8ZyPVbJeOHFnrk0D4cKk44nke6260QOnyxd8uV6Vi4pX3gFQ5ChZ/Ex8qMb2VuJA7E
         Pp0RqdOkOHIRIOf/q+8fNKHHGYcz224hnvuMEms4sfgLuYQHAdVyWpgxdRrvJ3Cd3sbi
         Zi7A==
X-Forwarded-Encrypted: i=1; AHgh+RoIMJdeSGyi6kMfRYtx3HNmLQt3+Zjx08foUv0pDvWjflGfASueXwKfsYakQDEc0k+F1K7kook=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuT0wPdiln7Ow85AOrgxQtFKcz26sAuV1C3QbhjmFys7RljpOv
	0ENbfCDWo0LNvpXvHiou5mxgZ279vThO0uYFuG+QQ1Zkt2L6kliqQ9L8
X-Gm-Gg: AR+sD12xk1TcJLtwMBHILz35FyjnfJy8Wpch9/CFEqyk9bJ2rVZHGXc8xCQ7NI0f7bL
	DTaN/SSYdFj4Mx39HOxeG8foK/vd7j/IsKS9Wuy1CAiWQCXw0Sw/DBz/3l6S8BOOReNmnrEEHb5
	M5eFT3aDNumQ38MgiMOZV7T+6spkSlxiHwf1CJCxoWNfZhEE8JrVhBglBfTrnXKPDr+V0IyFBuC
	BNsT6xYblK2oG/0y003iDLHTMQoiOLtiHtq/am6yNu2zfx7ClsbC3P3LCiUpoZEYm7BHoCCSQ8n
	k6lzOBIQJk9f5tJgl3GaUIZTXkNyBfPHjjEP1N5BUjZu0+Ay/cvUtC1SO/bcf6JY2l6QAsl07Fv
	y/Pr2cb+mgmEUF5Hmpo9YIBDQoPldBzc+LSWjwc3ri/63Xfzd7Mz1/mp9ViCAWE5If/3na4r2n1
	2TB2PeANHS9wCS3jAdtpGAIse9BsvyCMB4hnVSQF7FXGR3fhqGKCTLjI7xmRAsgK8J8DD1ETNZh
	A==
X-Received: by 2002:a17:90b:554d:b0:38f:23d6:b4a9 with SMTP id 98e67ed59e1d1-392cca737c4mr2724462a91.21.1786379108861;
        Mon, 10 Aug 2026 09:25:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b330f89dsm6192516a91.2.2026.08.10.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:25:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Aug 2026 09:25:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (max6621) fix temperature clamp range
Message-ID: <374f630a-b4a2-4599-8435-4a5951b6a6fc@roeck-us.net>
References: <9d3a4f1895a47794bb359a2a32fb1ccd6a15812c.1786334038.git.congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3a4f1895a47794bb359a2a32fb1ccd6a15812c.1786334038.git.congnt264@gmail.com>

On Mon, Aug 10, 2026 at 11:27:54AM +0700, Cong Nguyen wrote:
> MAX6621_TEMP_INPUT_MIN and MAX6621_TEMP_INPUT_MAX are used to clamp the
> writable offset and critical thresholds. They are defined as -127000 and
> 128000.
> 
> The driver decodes the temperature through an s8 and its own comment in
> max6621_read() documents an 8-bit two's complement value, whose range is
> -128 to +127 degrees C. The current limits therefore reject the valid
> -128 degrees C and accept +128 degrees C, which does not fit the 8-bit
> range.
> 
> Correct the limits to -128000 and 127000.
> 
> Fixes: 92b64580f14b ("hwmon: (max6621) Add support for Maxim MAX6621 temperature sensor")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Applied.

Thanks,
Guenter
