Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9244F552;
	Mon, 12 Oct 2026 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794210; cv=none; b=dYSysGW/I1xCRHyoF91IsAghdMZ5zvZvwGnD9VbsK8voX68m5nSwC8lSEu/Wze+C82qJamS/eVHKARfMWU9Ay6A+jGMGc6fR8Sdz9FdGr3rBKP1RZ4D3sfO9BENiBCwL5mGVfiHGKyLN3CKJ3GsYL6YgqSyF+YEaYjvtXeh8geg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794210; c=relaxed/simple;
	bh=I6BIIbtesJ39iQTz7VLctGUXW00lbDT5PIkkgyn6+7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7oiliW0AyNyQzw4OjJWWirfFYnPq0QlOb9DlB4S7uHuLDVCpFSPL+I1EWrvK95QTJkQbqAaM7uLD6AdAMVgIyGAFslafMX3Dws0jOSo2jffAyEK0R128MPiCzShxuDsxWhR12E254xyi+iuB29kz3vPDyO1iKceG4uCXtBCHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ox4BZMjX; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ox4BZMjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=DTiVtIUtGBfVxQ7yYFuD3meimlqQg85rziaxJktMdLg=;
	b=ox4BZMjXQtHLUPDLkHI9PDvHUgU6oFifuDhySazVrBf4tOXsuPoVyCwSyx3cyR
	+liUJliBZfuK2Yz4ndZ4EhQC/ana+v4ri7GeXkLMHDtDwR7z5nyWEV7/zYyX4ta7
	/MBQiBfgejVrieKA5E00Pa/9oZU4DoDCTHzSK3g/hpbCY=
Message-ID: <f605d9f6-3ff5-463e-8eea-10be6d4b25f4@126.com>
Date: Mon, 12 Oct 2026 16:35:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: wait for in-flight Rx polls before freeing a
 representor
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20261012072959.254206-1-xiaolinkui@126.com>
 <179179045626.2527009.2374745016618209052@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179179045626.2527009.2374745016618209052@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Pxzem8xqpaKIBA--.62278S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XrWrZrWDJF43Cr13tr1rXrb_yoW8Jr1rpF
	W5Ars3t3Z8JryIkry8tw42va4Fvan3KF1DWr15Kr1Yvw15GF1YqrW3Kr15CFyDGr97Z34F
	v3yqq3y8AryqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZXocUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqB-rwmrMm99t1AAA3F


On 2026/10/12 15:34, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

Thanks for the reminder. This change was not tested on real hardware. It was
found by code inspection of the representor teardown path; I did not 
reproduce
the UAF at runtime and no stack trace was observed. The fix is based on the
RCU/NAPI lifetime analysis described in the commit message.

If a future revision is needed for other reasons, I will make sure to 
include
this information in the commit message.

Thanks,
Linkui

