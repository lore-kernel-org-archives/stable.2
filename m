Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56965468C20;
	Tue, 18 Aug 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053351; cv=none; b=cNOGc6tCOYURCg2OguUSWWFAIcp3Ck1e1kAkh9zFsAv4O2qSTmnsGCDEcIA1onQ/ccOI03Dz5V9mT30MgpCEIudqOAP/kRs3pJtmYRXLOCoqpUDtw3L7QVZZPbZyLSwC2bx2T8Jw6Hs+vogjR3uGrgI6Bu/fm3HOjqjvo4FA3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053351; c=relaxed/simple;
	bh=RwwcZy8gqpPYywCuBDzHguqHhUy7vRVT6Pf+zs1+oG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qP4/e0z82fTRKWHyzOXHECsLi8TYFraaFhXieiXpZfEucUWwG1fEm3AtM+YGv0mRpmKT+YZT14oSn9w2zpmDLecLQPGphRQLhK5FDykR582cOqxs3UV11JERmL7tQceBUqghut7IxbGULewSKL/dpyMxDzGXr6jovmUqv1T71ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Es2aRNcN; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Es2aRNcN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BA8E1199B5;
	Tue, 18 Aug 2026 13:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787053343;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=X7j5R1HjJ/MADtrZfUBJ0aQHlMxkBv4R6xhT7eVGv1g=;
	b=Es2aRNcNvHK00DxoiycfH1ejX9khom695dYvmPaK9w1GyQ/XKROSXBSt937AbpMaaHJ+fb
	GkfWY0lXBKsAyWYrZ8u84UdUsPSp5zR5F/oG4w1xW2AEtTz8op5DgSSAI5C6qXDFA570kM
	UUks8PNMV6wSj399mPT+R2hOCDKtj40scOB728VPhqLvu+iPwANPUYMVOMpdgDHT3VXI7O
	b1qIjP++4J8ZK+dgXHhig2ZDAHIStOyZkPixe7w9Xkx36gDkgYAl30goO/KEOtXKAdf+G1
	VEeBZ03Xge/YxTEvq1aFLokcfJR/5bD8zSUnGzTx2wR2L8Q5bGPOgpsp0+2bPw==
Message-ID: <db311b41-ce2c-4018-aba2-8ebb7e9f1b31@nabladev.com>
Date: Tue, 18 Aug 2026 10:58:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
To: Thorsten Leemhuis <regressions@leemhuis.info>, linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260817182302.146546-1-marex@nabladev.com>
 <2719a7f9-71cf-447b-b4fa-a53e598d3d5a@leemhuis.info>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <2719a7f9-71cf-447b-b4fa-a53e598d3d5a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 8/18/26 10:32 AM, Thorsten Leemhuis wrote:
> On 8/17/26 20:22, Marek Vasut wrote:
>> The fwnode_typec_switch_get() sporadically returns NULL instead of an
>> -EPROBE_DEFER for orientation-switch described in DT.
> 
> Hi Marek! Just to make sure, have you seen the patch submission
> "usb: typec: mux: initialize orientation switch array"?
> https://lore.kernel.org/all/20260804083434.20885-1-i@4t.pw/
> 
> It has a fixes tag for the commit you mention and reads: ""Commit
> a53b4f9c51a9 ("usb: typec: mux: avoid duplicated orientation switches")
> started using the orientation switch result array as state for duplicate
> detection, but left the array uninitialized.
> 
> The first match therefore scans indeterminate stack contents before any
> result has been stored. [...]""
That seems like a different issue -- even if the sw_devs[] array is 
NULL-initialized, if to_typec_switch_dev() returns NULL, then the 
comparison between to_typec_switch_dev() and sw_devs[] would still be 
true and the match callback would return NULL instead of EPROBE_DEFER.
