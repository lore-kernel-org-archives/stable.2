Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652925C80E
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344610; cv=none; b=XssvGhxmM+1Ou17kPFkRcQqiiw361a3e8ioVqVqCw7Euz3anoFxQrbN8TDPdWciZViQZgup4IMkwswdtASPIc3yqoLD0Z6YLblEOwFOPVMWxtnVJZOVtvnf/desvgY5iip1XLoubTLvQlgKg0F55Vtelsa+oMnDVUYcAafGZxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344610; c=relaxed/simple;
	bh=vxlV2M6NKGbXDRvXckTB0aekRXZDoJYInvLokjRB/Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoW964PZWw3DcgeY8xvQUJXB3rbmTJjji2TR/ZnUxbemrxLllXtG8uKvz6cJlZ2UjE4D1RkmgajAQfyqsuUHD/k3Z38P60/jCt/ollBP5VDJqUTcwUZWa6UC0eg0abCPjjys7yvt6mGuZEj+6t9UnU5ec+SJMRae/yrWsaPQoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikfzRNf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikfzRNf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C661F000E9;
	Mon,  6 Jul 2026 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344607;
	bh=B0j9ufw0cSwaxqElH9cC546YjUcPCSnSm3E/R9j+tR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikfzRNf8W4JKEuJoHkWDQV936R0S2iBLmz4/g7S7CzkfKgePguC5xpMI/rodFVZJb
	 Cy1s1k+zfhakI8prjiVc01L+BXWhlyHbOE9ROzI+lwGLdz48BnudRfSrrw/pq1Pwum
	 NtB7tyBglIkRD5T+BSb/zSB2coNVL2wheogmTrGxhOEFe28MmMfwoaaMOAOjQaLlOK
	 qzj3C+kWcMpwcGGJCZ9BGYbaqwYG5HKIoZakH0FlJqvi7P7uY1S/NP/bOlZDgqK3VF
	 lZ1oFQbgHc2f4a5V+xaAd91Dizqsd6lHc3G5UIQ54hLu8pccpTVYZHCNvG6ptA1K/L
	 zgSgpqBrSRPAw==
Date: Mon, 6 Jul 2026 09:30:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: maher azz <maherazz04@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
Message-ID: <akut3otLG2zG5oNS@laps>
References: <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
 <2026070446-blank-duckbill-13ec@gregkh>
 <CAFQ-Uc8AAEGw90BPximQm3cLzB+KiH_PXr-UZEPK9nvueMGtSg@mail.gmail.com>
 <2026070406-squander-geography-213a@gregkh>
 <CAFQ-Uc8CDnGUH3xhjaVBd+Dr=+b7Lfu1SUrGGh2gQ17WW+gqxQ@mail.gmail.com>
 <2026070421-overflow-voyage-73b8@gregkh>
 <CAFQ-Uc9JvsHVCgj6ydVrg++hA4CCxw+FuQYfKzBC65HyuJNMoQ@mail.gmail.com>
 <2026070400-broadways-designer-ea0b@gregkh>
 <CAFQ-Uc_+TQutABrGb5+JvrBLUyq30KcfLURQHoJdCw_Uu9-MPg@mail.gmail.com>
 <2026070613-shirt-festival-f84f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026070613-shirt-festival-f84f@gregkh>

On Mon, Jul 06, 2026 at 08:44:46AM +0200, Greg Kroah-Hartman wrote:
>A: http://en.wikipedia.org/wiki/Top_post
>Q: Were do I find info about this thing called top-posting?
>A: Because it messes up the order in which people normally read text.
>Q: Why is top-posting such a bad thing?
>A: Top-posting.
>Q: What is the most annoying thing in e-mail?
>
>A: No.
>Q: Should I include quotations after my reply?
>
>http://daringfireball.net/2007/07/on_top
>
>On Sun, Jul 05, 2026 at 04:19:07PM +0100, maher azz wrote:
>> Yes i am sending to cve@kernel.org, i sent using another email just a
>> few seconds ago, please re-check?
>
>Taking everyone else except stable and Sasha off the cc: list as they
>don't care about this...
>
>No, I do not see anything from you sent to that address at all, sorry.
>Sasha, are you seeing anything from your end?

Nope, I don't see anything here either.

-- 
Thanks,
Sasha
