Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053AA4457B4
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746493; cv=none; b=Enw673zEDNodVl3M8PlEK+eNtOYfyS+4tkIeFFpPzbLTEa9g77EBl3ME2ulwrRZCM8tWjZtvHEVVwtSJw0znceYvJqj81JqJyln7/cTeTo/XHUuK8rqHaiwJUF1D+TLp3jA99TZVhcgjCbxjTutt1WfAgpNWbdR/c2+OnK4PTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746493; c=relaxed/simple;
	bh=2QyNWmp1hztpxmrpukYXG2ZnOTcS6rMAjzh9m2F9QEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbFmdHY27+vxopIHHwSkf4x9lwUqsQU4dDEQp6DQEUg26oHQvPPuu6cniURpuIJafr3skpkq3H8iW4rA/baphr394+oVde3e0WrpcqghKYM9VI5HTYDzEXDDLF3IeZfMKPoS5qfh5Nw8zGqWVi2xO1Y6W0QyPY3cUgGeBnj3VSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XANTbUkt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XANTbUkt"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38deea72eebso11099919a91.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784746490; x=1785351290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=979Piyb1AK7sVzfdlmcBmpZIlN7tZrXX3BOsLsFclTk=;
        b=XANTbUktEI4CgMk93t0B24XiXFiYf25FljzpL6yLIuhXnyROxzshuOmnHOmB5cIzY/
         t1jlORnqEPMsC+JqNqW66RWVa24dAWYYoP9Zf2UdxWLapchELHsvhh3GHh1H7d4LMAfI
         G7Xku/afoS2/1JN5fV3Lp5851/hJtf+7gnvAAp3TQpqnlM2H4JLFETIZL/k5yWkzegin
         OGZZzqIiwwsQijTCfWSyblnCm1yhvsf2tUBaLLZ4EVd2ViXKcIPCzNdheZEZhG6/XkpJ
         dhWLHaEVuyj+aGqsJK9exZSYL4POO36tDiC1bNm8uXsEeeEUctYluA/njffpepBnJb4w
         auNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746490; x=1785351290;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=979Piyb1AK7sVzfdlmcBmpZIlN7tZrXX3BOsLsFclTk=;
        b=qIn5S0AR52Hu5uixyEw8jCMg44InQVYS/L6cXs/y9xJ+3FVop9vjt6BCtwFGvW3Tqh
         1yEBYc5/BlDmiC7k9a33fNKVf4DHaLYUapmSzzvpWzvebwc1LVpPTgpfoQF4zCKTS6sZ
         oLNtjJCQB5b/weug0hysGrT/4BOg/c8HbWgBGDa1nHS6Aip/ttcKM0ulXLODRXKvMfpz
         N56okFTcVL1tHsjwvxQLHtx0asPY/VVIUnY64AS3Nlhye397nWwhgIrurcOCWtuNKbji
         oqwQE0KwaHuRLjtgVUISGzRmZz+Zxw7ciEb1KtnX1CKWgm8quBIbrpcK7+qbItdcKCym
         pFPg==
X-Forwarded-Encrypted: i=1; AHgh+RrT7NNTUb+vguwIlS8I7d2Vcz55aG4yRUY+Y5bUkbeuwXhx85CeJOQg9UXWyRH4je0zD9Y/TKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDXO67akZrWqrnJAAl4o4qc5jzFAaAtI9Xj/hKALtCdpaftKl
	DkaHJ0TGdyvNu/N45ifT9N7pKWoOCgxEUJF3RZsIPHglUnG3Jx+cf0n4
X-Gm-Gg: AR+sD12oWqSnFcTNTkgNxY1FQN9JJbnhSsuo5G14ANKCzD+zwcH006mVwg1tP8z69UU
	ZvFr++Bqehk45z/vDVRwwokdNSKm34uJ9EfwrfKqHcEIq8ZhOk3phg64/Op5O9VUfavpG0Y34Cs
	dB/THxGd+lL7sUfs6FmLF4ne25Ak4sPZiucr9Tlj8cYbfFcz1vD5a4pcrPwmqCO0um6LFWqR46z
	aITExW3vXi/5H2//sCigTXOIuvzrQZS0a2aeDdNAyW4XK6KV0XYUcxpkf7SlE98sZy6/ayy5qhc
	avkGe1MUyw6f0liupLG4yHgPEiKA6OdD3FrLMk7mGrXrgYhx2o0irNtjJtRlzKHBbnjrMLNTEQl
	vwL0Fn2wdV8TFwbVlf+DSYcPOrJh8GwH8nEzx6c4nFDNq6ToXqwDM+lqUTikRapx48vz5cgD3SI
	g6uGxjWKJvHhlAAIBmOef1yzsTj/oy3mnmGPkPZEInGlQ=
X-Received: by 2002:a17:90b:4c42:b0:38e:a555:8fc7 with SMTP id 98e67ed59e1d1-38ea5559070mr4172247a91.38.1784746490313;
        Wed, 22 Jul 2026 11:54:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e13f:e272:947f:d8ac])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a87e9sm7978056c88.11.2026.07.22.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:54:49 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:54:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Kees Cook <kees@kernel.org>, 
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>, Richard Pospesel <pospeselr@gmail.com>, 
	Chris Diamand <chris@diamand.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: byd - synchronize timer deletion before
 freeing private data
Message-ID: <amER82tgDcz2wcs_@google.com>
References: <20260720033030.1580891-1-lilinmao@kylinos.cn>
 <20260720061259.1601281-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720061259.1601281-1-lilinmao@kylinos.cn>

On Mon, Jul 20, 2026 at 02:12:59PM +0800, Linmao Li wrote:
> byd_disconnect() uses timer_delete() before freeing the driver's private
> data.  This does not wait for a running byd_clear_touch() callback, which
> dereferences the private data and its psmouse pointer.  A callback racing
> with disconnect can therefore access the private data after it has been
> freed.  The timer can also still be re-armed by byd_process_byte() while
> the disconnect is in progress.
> 
> Use timer_shutdown_sync() before freeing the private data: it waits for
> a running callback and turns any later re-arm attempt into a no-op.
> 
> Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Applied, thank you.

-- 
Dmitry
