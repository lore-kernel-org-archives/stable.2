Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507206;
	b=qDNx2tjnpZN3JYp0MNennhlV79Z6VzOTijSjk6Y2BGMAlAqy5kLyMBVGSaqMUzx/wLY2
	 r0ytkxCmThlcdU/fdOHpgfEzcONLtIuVDyr6pIjQxKC0kqspFA1lp6PxrkZvTlZ/2bf6X
	 Gvhun+/zhvMqM4qHBcFCEpJCuP9nE5KaervcUBVq0omvcQfbdZfL0mptXD8c1WcuwDkWj
	 JdKzPiInarOw/EVgX4+RO8GpCNqiT+Y+YZ29XBk9AMsYMpQe5w0h7LA7mUPsFNBYNNvrJ
	 K6ElSa8nM85V69HPMTgwD2YuiHfqvbC8r1JfFPYhw2+MNh2N90xVzZSG1T/Hme9/66Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=Q6fIiazwiX9M70R0T78E4hxTPNI+gCf6aNUzhJ/QqFs=;
	b=KKp9P3oZ3Z2Bzk1APEOvTn5E3D/Fv0AqEKSPqF13b3iFzEig01j7t+SsNkM7/MBFFrs6
	 Gt2WNshjlNRuwJM331OWSA3vBJ/CM+f/luyKLszxCI47Ni7hI0F+Kv6bsn08KeEGjj2KN
	 ydjJY6d65ENixLAHLZEuYDRBWfwhBE8JzTWRjEEspsmSWag0QXQP3Z2GkwZ2HwKqoAnnt
	 6Dthpscy+788kXXeX4e8TBEhE7sTUeqNX4Ydff9DdkldUoCYpS332mhn6b05TPwu2RH02
	 D3CFkU1EPK+JGnvgT64y8JhMp70atgqBdRuwbvBXd5Ilceg5JT7/EBNWKWQmo3qZouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=OoDKP4rJ;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5233606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5233606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=OoDKP4rJ
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-16079d54c17so510896c88.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792507205; x=1793112005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q6fIiazwiX9M70R0T78E4hxTPNI+gCf6aNUzhJ/QqFs=;
        b=OoDKP4rJj8//Fkrqz3cIB4KZYMsqYLQDhx9M/EfrEsQmxL0M1ULhxcqTmAW6jk5gGS
         BfmcnnCDrF9qTdJE2j09nk3nxfnoC5HqTYTRu0khvXapBqv0xH7b7Og6QzI1BKlz6v/z
         dU96054x5lDvajZttrF2ZOnH8DJ6qZnvXN3Dz8ZPyuFXCazwgf+NHTtXcwrxy8mn3src
         3wLPHbCEmoq7p6V6oni+5J8KsHEL+bRp27NoiaP/wjjtlzQH5uOOMVaea0AMcALxSlyJ
         V7ZUp62T4yVKuSWfVTXYyzW/luqlIyWaMSNBYqO1QDtrdjs9qwtvHYfJEwBVY+emPaFW
         k5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507205; x=1793112005;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6fIiazwiX9M70R0T78E4hxTPNI+gCf6aNUzhJ/QqFs=;
        b=Sx4ADRDzHbc/shvVpFhsiJmgp4+S3XpcwCeEmwed+CZGMvhTvdM5r9vE7dwm1Y7ftN
         Rz9EEQ3pGdUAUcpcSQn3l4rzJZ4D7Nzghfibz3UIQwMKkBSTutSH0KU+EZ5wYWqIGLgI
         4yqAjHEmpBOBXdBfJ2BEnGqdceqSFcBDqUoORiawXVtyhvVch5IQNbtV9V0lT+q5bjT+
         yu/MjPw4ZnPDOhUtBAH9J7Y+GlDXeXVzSjSYkal6nwQFHbrPTjA8/9lckL/LG7ZcercU
         aMv8HkISYy5CCJCJ/RYJ0+il/n2kawYKAHvIZBaPbQATwI8KJifGTHhxOyzk1o1l4zpS
         DTYw==
X-Forwarded-Encrypted: i=1; AKwUvBzoHa0P+NzH+sSYOR+qJ8hcZM/vl+PxDhpIClVJIJCsLGAC48Um2N1uW9rwYRfCt3/Bi2l0HRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuTUYf6r01MachTXokRtdejemN6/r7GPwo2TELekD0Q+9I+itr
	bvjNFOFYTYqdF3enXJb32ygJX9OTh0zKR1zhUOcZ6GszEhoh+ktbKTMdr3lN/Y2ixzI=
X-Gm-Gg: AYBFou181LZsTsQ9mivJQAdV/bt5WLQ8wytzk97yCskDiRUyxPtq9aNWfGpP7JQzwpI
	HKTvkHBSFSbvdFxeQ3H0/qsbdx9fNNrhNYW6YcsPp0As1w2fRTxksJod7mp35xkire7BAqOLCe8
	kb26gQNKVjW4ZcoPuMM1H2s0OWnhdJybTX6YTw4HWIsHGn6Fi0fJCqvodiFo33TrKnU6ckrLyvN
	1qu/kgyJ7qPWbDrfV9TCVQGUFnxrdM+dMAl4ntekZ38A9QypUIHhTixlwABAyzUnJkIdMv2h3QC
	a4FQznZjd6LUEwOBc8JgyCkYuySSMBx5fbeSCpvCliALcMZVGIPyVkSCMF8tm3rz6bYYVeU+ZWa
	/6SJNEbtZuTcyU7B8Edy/6dAREVY0gzWShXks6T9NvubmExO0uTmll3IyLRbOCGgXULdIQVOe0I
	39uybzYvMyXnKBDCFC8UcxuiFHzGdkBkRIHKtLVLVPuW6eO/1I/ZblAIiT55bDWHotC0eLRSCHE
	ZFdu8pJBNzAWfuR1OCRk4Zn593Rlc5ipnhkp/UfQAsFesWRAiXhl69Wu6pCVkdkF0Rv1xzm6Tgv
	gKjuV6CCFnyk7vih/KZaJ2rps73SAz7RA3qgQ5EAvqIzTBN8ixz44UyMZoH96/FucCpt4oADA1w
	Iz4I=
X-Received: by 2002:a05:701b:2608:b0:183:4719:5c01 with SMTP id a92af1059eb24-18513e7c69fmr13146306c88.35.1792507204827;
        Tue, 20 Oct 2026 07:40:04 -0700 (PDT)
Received: from xps16.local ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm68494455eec.28.2026.10.20.07.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:40:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261020125129.430600-1-nirmoyd@nvidia.com>
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
Message-Id: <179250720323.3338252.2582321707097985664.b4-ty@b4>
Date: Tue, 20 Oct 2026 08:40:03 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 20 Oct 2026 05:51:29 -0700, Nirmoy Das wrote:
> When the last CPU mapped to an hctx goes offline,
> blk_mq_hctx_notify_offline() sets BLK_MQ_S_INACTIVE. Updating the
> number of hardware queues exits every hctx and parks it on
> q->unused_hctx_list. A later update can reuse a parked hctx through
> blk_mq_alloc_and_init_hctx(), at any queue index, and nothing clears
> the flag.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: clear stale inactive flag on hctx reuse
      commit: afc1de47a7ab607ae6403c4bfda36b0bf3cd342f

Best regards,
-- 
Jens Axboe



