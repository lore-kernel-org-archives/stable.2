Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE33D9541;
	Fri,  9 Oct 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537697; cv=none; b=oFzmK9waNJMmMf2UgwptnnA8h/KONsiTHsHodA3vexA3cVn7sJVR68szmmiUB/Coc3RudESPo72XPkqpLw4yo8Lh3T/jJQr+uVaqg6BWhcnwnQyjWphgeAYaecMMZ4xPZwrV52zJzEcfdy04EJK1AspLnfPeIgWerE7S6l3FuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537697; c=relaxed/simple;
	bh=uugjoDx0c+L3wuMWIqZP0X/OyGBzXsJCDMmQXJ0Ekxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h67tyc//kXI1jv/pNOA3X4ZzRowXvgM41FawubPPPFSB1WZMhCkmr1rVb5pnsLqSP3qQvdeszWKqP9gV+Gz+x3QUYLG1NRC7LwQCRQNZaS8ClfcjRmObA3HWIwn9QtQCg7YRWiLby4Yyod/Pk7+51azUaENQDCWjMMuszeWFEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmjjlH79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmjjlH79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26D11F000FF;
	Fri,  9 Oct 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791537695;
	bh=Vws84NjI9YU3PfHgWhqUoHAjWKtOzUf6T7B9xfFXSa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VmjjlH79aGdW/QsxmVmMophRu8dXXy5qUwV/UWL4IhZDy0sFybByXQaexVjvCWhz3
	 4TkutIudGao6zk1wu6+qYg1d//QbKhzX4CgVqDDKR/S1K/uvNH46g8w8ucNnYqCW9A
	 wH71p7Wj4uzA7ZRbbjwUUs82FhkEdjwti3kmJ120JfhwGqYHN6zK6GkZKo+45q5XrU
	 3m35tmeTrof3Xg0VeNj3ebnvG0GEGU+4c/6nXToGK463X6e3nLuYvieNTtkt+zkO0b
	 OwHfHIXX8pwzT33pYLTF9nkAWykVLsTGtg4EloI+u0rFgakcQZ9Blfx90AB+aR/KcB
	 c4YBf0Wu/bZcg==
Message-ID: <c8e47d1d-1487-4f51-a858-cb66b5f8c808@kernel.org>
Date: Fri, 9 Oct 2026 11:21:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: Fix clock leak in
 tsa_of_parse_tdms()
To: broonie@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: herve.codina@bootlin.com, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com, stable@vger.kernel.org
References: <20260917152719.2160395-1-vulab@iscas.ac.cn>
 <178972077003.546774.17878987805855996127.b4-ty@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <178972077003.546774.17878987805855996127.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2026 à 10:39, Christophe Leroy (CS GROUP) a écrit :
> 
> On Thu, 17 Sep 2026 15:27:19 +0000, Wentao Liang wrote:
>> The error cleanup loop puts l1rsync_clk and l1rclk_clk a second time
>> and never puts l1tsync_clk or l1tclk_clk, because the branches that
>> guard the transmit clocks use the receive clock field names.
>>
>> Use the matching field in each branch so every clock acquired by
>> tsa_of_parse_tdms() is released exactly once.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
>        commit: 7b3b0598c00e67f2df85d0b4cd99eaa3be6c9bfd
> 
> Best regards,

For your information, I folded in this patch a similar fix to 
tsa_remove() function.

Christophe
