Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92EA471265;
	Tue, 21 Jul 2026 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664283; cv=none; b=JfRvZQPdOD7xS96r6E5zDHOxxhwRDQFNBB4X7cyXuDSqRCBX7pFbY/ZKjWOXEtihC/RJ3MHeaVir3uZjaJyaBnNKJ/5ay41zTwrlBVbLDtqG9FHmlwZEvSXhJdwg5c9subjHonM0juausLvpgT08mOel01kSnpiGQHyRH7BwZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664283; c=relaxed/simple;
	bh=W6CIHXuPzDrnGTqbidIsRdE/FlsD8sz/vUFvwSqMB/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mr1sC/jC/tto5W6bqFJ/t4ZoLLa0Sfu4H6CVLZI0TDfJzqL5+See/P9v9QssB3Jz6Di//wFa3HpnZROKdMoQaP1T66JOJyEf5pBmPyO2aDUfc8E4gbKWNPD+4GCjmcQMI3M8uSTCN1PqWJYw48DsCxBWLplqvjIgOKZ6KwLgVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdtypD9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdtypD9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D91F00A3A;
	Tue, 21 Jul 2026 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784664282;
	bh=0mDhc1QQbipGkuoZ8++CWG/6T5q7EpnF9UvZXjzxB4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NdtypD9vGEsNGcfgJdSCE+Sjzv3NhvOR5I58pRwq1voeBl+kICPP+OD8LwECI3Lhl
	 YitVOWG9grJYAG0NOVTJbugZTsq0SG8WHUiNke4ABy9yD02EezIpN0j7NzXzQyRUH5
	 keF7h1deBDnSZek6n4yNcl4srxLkAeAsq1rFoucsAgcswGwJrCOJiIKGEd3zxLhvA0
	 Lw3QJeI9BO14u9AZ2SlbDDdvEC0aN47LoJerKc+AS1GizkpW0j6ARMqf2CGvzbc9ID
	 sjmxQ6jJyio/xNc6sUdor8CCyX2hhWx+Loa+pOhOWL3DWW/We9Xg68p73DGPSAJn0k
	 00oubikIuPcSQ==
Date: Tue, 21 Jul 2026 13:04:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 maheshb@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net v2] net: reduce XMIT_RECURSION_LIMIT under KASAN
Message-ID: <20260721130441.3c662a9a@kernel.org>
In-Reply-To: <20260711204700.1760374-1-tristmd@gmail.com>
References: <20260711134732.1385563-1-tristmd@gmail.com>
	<20260711204700.1760374-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 20:47:00 +0000 Tristan Madani wrote:
> Virtual network devices (ipvlan, macvlan, bonding) can enter legitimate
> transmit recursion when combined with packet forwarding configurations
> such as IPVS NAT.  The existing XMIT_RECURSION_LIMIT (8) in
> __dev_queue_xmit() detects and breaks these loops, but the allowed
> depth is too high for KASAN-instrumented kernels: each recursion level
> consumes significantly more stack due to KASAN inline instrumentation,
> and the cumulative usage overflows the kernel stack before the limit
> fires.

This patch was marked as changes requested, I'm not sure why.
If it is still valid please repost (please start a new thread,
please add a link to the previous posting under --- like this:

v3:
 - no changes
v2: https://lore.kernel.org/20260711204700.1760374-1-tristmd@gmail.com
