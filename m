Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465742;
	b=IZynVSDfhFt0F8OrG0Y73q9O4/Q2P6knw91LlHqZJiGi7dKr5PK6OwSkUr7zgC3ydeeb
	 s0FKm5Gk6JE7++0UgaTuASIFI3p98a9ZRo8M5w73uelVv9cWSlEqHdQx1XF0LltTdGIdB
	 SHGiCQKkFqL+F2m3ZSqRtv6TuFVD1nYx9pywkXlV8iM7aPxDVHfadYqBhfXCL6rcnhLfb
	 VnYOxO6P8EEJLRFK593oSUdncHRE++rOxXrtCVIVmCcsUnJZeOS+ijaWd+U02nJfnX1sT
	 6kHwh6Ty9mw4lCFjBNda5GUaowP9hubNyVSy20lX2XSG4vmCMKCfpFAtUFLrfY/fGrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465742;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=XE7qcYgylreJp0JifMPhFDkqe26p/1tmu93DZNaIw5M=;
	b=j7WoDSquhfgNbqNh4p2DbaawmQGMNMzruk8H45sCEUCYkivc/YWgRkXstF/qVTO2G4KC
	 8kqkSkLLteIKHu/s9tLqUQMlnhpewGvXh7MYHBSJFRqwK4v1n+wzEZrUddkkEC+4bECc4
	 KC5lTjyq8WV/HaE+AjrQ2Ay7DyyflxrBIDiV3Kgcn5uR9H/pySKIKPIYQN0KU+gSXr4dG
	 /wsz+EvWhxbSPVEMRr5iIC2s+1OfbqaFfB/g9Z6Nz2j6Ld3BrBp2nGlRDxNykZ9yl4iG4
	 Ujlsnbd0MpS9bZWtKT8HTrkfKc8iTo7irIv9W9w8fLnyO6MYQ1cnLpE8SGPFLFiUUeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=FKA0CLkf;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39540606A31E;
	Mon, 23 Nov 2026 20:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39540606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=FKA0CLkf
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jYHb705X0z5vQ7;
	Mon, 23 Nov 2026 21:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795465731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XE7qcYgylreJp0JifMPhFDkqe26p/1tmu93DZNaIw5M=;
	b=FKA0CLkfyWAcxUq1oWz9e0gq1cOVbJ9lfQ/Gioeu6GSlMfc1GEm+LmsBniqVZaIzwp/sCl
	1SipGsLM4pPbvE2iJxAWrCVc5kiEafYwA0LxsJZa/KkAUMNf6svm5E7qmecY5I1IhmgTn6
	zthoe8ZvvqICZi9+l9yGb5Ls6Tux5Sahr7NCAzkc8PmNgDiP03onhJsImaxDBEd98Zfk9G
	dWASAhlejk/mpxZzCi17ObjmqylKZM9HXFAFqvfxHiDxho44PyUB8n2FnQc2USOLo3QAS8
	l4Wm+iOolVvpdsaY1bl63sPHW9zNGnGLkDWT8IPZdTNe+zgNjNflp6sYPFOuXg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <5b8c4005-ed10-4be5-b79b-8f59089d6fbf@mandelbit.com>
Date: Mon, 23 Nov 2026 21:28:47 +0100
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
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
To: Janis Edvarts Lacis <janislacis06@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-1-antonio@mandelbit.com>
 <20261120210134.133238-2-antonio@mandelbit.com>
 <xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jYHb705X0z5vQ7



On 21/11/2026 00:17, Janis Edvarts Lacis wrote:
> On 20 Nov 22:01, Antonio Quartulli wrote:
>> xsk_get_pool_from_qid() checks the queue id against the stack's real
>> queue counts, which can be higher than the number of rings the device
>> has: on 82576, enabling VFs leaves a single Tx queue while keeping two
>> Rx queues, and igb can fall back from MSI-X to MSI with a single queue
>> on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
>> before enabling VFs, then passes a NULL Tx ring to
>> igb_txrx_ring_disable().
>>
>> Only disable and re-enable the rings the device has: skip the queue if
>> it has no Rx ring, and only the Tx part if it has no Tx ring, so that
>> an Rx ring using the pool still stops using it.
>>
> 
> What happens if a pool is bound to, say, queue 1 and the socket stays 
> open across a runtime resume that falls back from MSI-X to MSI (queue 1 
> becomes invalid)?
> 
> If the socket is closed after igb_rtnl_resume_task() has reduced both
> real queue counts to one, xsk_get_pool_from_qid() will return NULL for
> queue 1. As I read it, igb_xsk_pool_disable() then returns -EINVAL
> before doing the cleanup and resources get leaked.
> 
> I may be mistaken here, if so, please let me know :)

Hi Janis,

actually you're not mistaken, thanks for spotting it.
Once the real Rx queue count is lowered below a queue with a bound XSK 
pool, xsk_get_pool_from_qid() no longer finds the pool, the disable 
fails ("Failed to disable zero-copy!") and the pool's DMA mappings are 
never unmapped.

igb already does this today (it lowers the counts on runtime resume, 
just without RTNL), and so does any shrink done by the driver itself 
(e.g. SR-IOV reinit), so it's worth fixing here.

In v5 igb I will follow what ethtool does for channel changes: when the
driver lowers its queue counts, it keeps the real Rx count up to the
highest queue that still has an XSK pool, so the pool can still be
disabled and unmapped (the rings are skipped as they don't exist). The
Tx count follows the device, and the Rx count is lowered at the next
open.

This said, I will first wait for Sashiko to report any other potential 
issue and then I'll work on v5.

Best regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

