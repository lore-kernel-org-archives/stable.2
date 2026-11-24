Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564611;
	b=4/o+qqiWLUTJZBQg3aDZ9fsXuJo4HfIwpq7XqLMb3R8iAz9dfFNkzzTMX5MsKPY4KYdd
	 a4F50OWVEKZ2sdKRFoTHk5DTlkCd2QD+ysqt2f5cPNrRt+KQktjooRlwtsefcjJphbNf5
	 +uBy33Blhaur2bYWAYHLntvKihTo+KkCcWOUtZW4XAvbNp5HQdZSPgrXzW0t7kv9CJMh3
	 x5W2rnNACOJwCxMvYbXDipD3YvlCPUjR0Y3Lco3tDwOiyxiAB16srgj5cZ3ns1Xq8LeOD
	 cmd6SNOIvWU1RFPfV1yxSsy/KbrGlDzbo6TRi8vVksc57AYu8z+BfbtsUJl7w4wTLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564611;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=Fz54SJ7qTGehb3UMp48cf/gfuNfCrF/Glse4fK+TDq4=;
	b=K8QMOzGHmnkLzoCCR/TTwN+t8ky+7M3bGOKxkLRxb5VCJM31Fpu7NE5uMWLeAob2w0Bz
	 RMj0iiWhLsU9InIQCsruDcR3hTjt8+SDIxL8pL57Gh4Kou7JC/sUgTj5ir812UykpcbtT
	 NfzNhA8xEEK3s6m156rk3XBIY//F/flOFkwxlpdmw3UAVxOBXx1weQUXl0tXpd6PJUyyo
	 NoW4rgb2/M2vp0i573GYcdF7Xr3zx4qG4/2jiTBTlT2F/7MEE4DKBkflcnPxMpYBBoCQD
	 aOa8OjjGuAK9eNVBQgoxAmaUFFP2dT1syc0wyfTu7OkU0DUY7wlOpwCp0cohZV/1Y7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=dyfKhMnl;
	arc=none smtp.remote-ip=195.10.208.52
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2D606A31E;
	Tue, 24 Nov 2026 23:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87A2D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=dyfKhMnl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jZ08Z5HxyzLmXR;
	Wed, 25 Nov 2026 00:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fz54SJ7qTGehb3UMp48cf/gfuNfCrF/Glse4fK+TDq4=;
	b=dyfKhMnl1ebbu15g20KDJk4eozwr11QnWM0LeNvIcuDD1o4AkY+BXVKr45lKeoWHGgo2db
	SStWtL3xsrPPsQHKpDaJIQVuBDsRZrbSwVQne9QA51d7xLemsNmyvrqj3UcRsjhRH0e+ym
	UvJJcxOsfzdlZLKoPIg2DCLW5yM3gmcHOHxvIZWaT/ICZ0ubwncW1t1tjQjtsJJ7CXbss3
	EcFJ6ZH7Iv+BmL+wQyXS+qBm057q9ZpKEFzdGhu/9A6+Q+XIiOXV+/DBCbKSaWxhxyLPbn
	kyvO1O/sstj6xD6JI5X4g46/8gyOzuq5X1bsMnzhnSgl/wsEG4woel5YwvBu8w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <d678b277-6b66-4d97-8745-23cb0adeeccd@mandelbit.com>
Date: Wed, 25 Nov 2026 00:56:45 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/4] igb: link queues to NAPIs under RTNL after
 runtime resume
To: netdev-bot+sashiko@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-4-antonio@mandelbit.com>
 <179555632542.3135.3194340362837900458@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179555632542.3135.3194340362837900458@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ08Z5HxyzLmXR



On 24/11/2026 22:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] igb_rtnl_resume_task() now calls igb_link_queue_napis(), which
>    reads adapter->num_q_vectors and dereferences adapter->q_vector[i]…
> 

Right, nothing cancelled the work item on suspend. v5 cancels it at the
start of __igb_shutdown(), before taking RTNL, so it only runs after
the resume that scheduled it allocated the q_vectors.

> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but igc has the
>    same bug.

yes, an igc fix is planned and will be sent separately once it has
been tested on igc hardware.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

