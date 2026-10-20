Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502654;
	b=YO5DupFXth9+0AAUIgXMFre32UeBw8ghIfMRU+ne5Tn/iFAel1eSZ414XrjO/ALDyEm9
	 wDOQVSl8BF3FXXtnJRwzwov9FuzTi9VDNdVxnFGSg47N0ZtVGC8XYKrV/TX0V15chBfY+
	 xlrzljyrgSGK8IAtL6q7LLDJBKLhfTY3I8afEOeJN/dpw6PNA+qbJ9wRHkIeV5Kgf9vqY
	 hCZ5S2IaUyf73A41oa2H48jSpQIlW3ZK4SArTk3HvP3+dCXFyFmsj40dGJ1Z0Phck+UhI
	 zPZ50cBVMxd4TwesHVnjFTdlhr8E6tbGms3Iuglrhv1RA/wErdhOa38Kv8yyTks5Pwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XRtR/3LEKCT96Cn332o020ioqbbOJSAYNYdI1pf8JNI=;
	b=jCPaPlD/HmhDjIFJ3yiIw3pWEvooboAEHKXntN8zIz4k/ZCxAtT8slJKTiVtlpsJUeU5
	 1cRv1cBZXs5PAg+nI5A+4GJdNAPDay8m7XRHXwpwXUG/zCbTbrJEw3MIB9BP8nxA5SJ5n
	 qXhCTkNi3s0fPKOb04rnsCMvhJ1OX3ZyzxdxY8kpujnkZk+Sy6tu/DtCh68PMoMFIq+A1
	 C86ZSS3uMCZ+MQSYgLBLCFV5DfM6lCAgkrbs2avVocvQ3tPb/hMvevdUmmBkKPplvmjew
	 Y0qOpA3QCPA8FrVn58QY42yNB8xTcRMqHxKHmMZvybIgj5M4Nyp8Enkzj6RL/dcAtOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EWJBmoPi;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB5606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6CB5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EWJBmoPi
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2372096a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502653; x=1793107453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRtR/3LEKCT96Cn332o020ioqbbOJSAYNYdI1pf8JNI=;
        b=EWJBmoPiTzgM6kfVEl+EtqoPCzocUVxgwjVlaA9tBeRdOEyfbSlWaNCHaymhCC7hm9
         NNAwloBqdpuX2iRcQvH8EPAUjQix3RolaxQ9KYXKNvACAg2VaeOKy2DMg9FENftE/PCG
         UoCnA5vpsfMfL3G0dO9R7pGOCb5m2tulus4DHYsvrYFcuFOh6E4PFEh/WX5OhgOm7fLj
         M3YveFmIqZ5mvjjh26FdsZBGx0o6t0RcIz7IboKGT0ccfIsh8zSQBimMVjQ28glI4sSC
         riAyJ/C+tcb85fiNGCNlmlht+s6OH97nSzoe3ih8jTP19629AfQ2wV+wzsTOjNHfXJQS
         kv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502653; x=1793107453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRtR/3LEKCT96Cn332o020ioqbbOJSAYNYdI1pf8JNI=;
        b=cLjlMPxnQ6QrAKomaoFAiJvaTawvKFxg+EeBz5gW9zH5aQyoetgCrnqrRLNUNAom6w
         iOH+tE4C0y20vbfFQ/QviwXc9lz+iPFpTkCKcp3epP6WrjWkzhRr3t838I6OSVqvZDUz
         UQUa++97z2TOJdsvmJsa91t8OenY/QcEBbxCCovkamokeDmwtO+TsQX1wRvDjbjiMFny
         yA5W4euPEJKrm4hnSyJm3UP77TC75N8xU6HNRxuibvqidqVajAYQXow6uglK2RWZKOPt
         AxZMfN8DGhbcCchZtZGpuLVnPo66hsrVSCXn3JzK1uYWqgSo93vhhZ5AkPIMnLU+U51V
         Jdgw==
X-Forwarded-Encrypted: i=1; AKwUvBzdrPoo456HUO2ij2FPOQcDfvtaEq4CWwIY3kOA7PeKOPJ/ypT55LxzBbm6AFdjUw5aG9X98Vs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/qlrx1oj4olieBb8ivWJTWwwrO1rvQhO8vGPuTX5xnn8IkBAj
	uOs6QFcM8+O2NpP5EUGsZbXVrEoxakSARANG/HNB7OvzXMEY0c1JOzwh
X-Gm-Gg: AYBFou0XvrUy4WYvHANuLNhElugdIEnnfjKCqlPaZCfbwFySBMkDWBShntJ8BJShFcu
	w0d70zA0w9jk2FyxghTKQ6teOVAPMKRClZWyazsLkcaPnXCvZW3zOy42P81W7eOBMtYHP/6umMV
	+3MoQfmN8vshvMlv897675XnEnEJb4USNeHSCGEF23xlzvp27PImFmgQkRk7w8XvOkGdp7c6ngx
	LFGCdfCuKZLCZx6tLJi5wi56KWX/zFMPhYMj/leNr/XYeAs+sfPg2moU36i7RJepm6ZtjUmbzzE
	1n0L7Adqlt/ptr5GUo15JVRRbS0/blNpq43ti+uZsbD0FgQZnrGXtXZbr3V7rf8DaEQYfuWl1Za
	l6e2KlVSf7jTkhWrRdjCR2H9GxDazPN4hCLtule9AjWhhdnImWx4Mk3KQbzfg3xFiz5wrkvgkAF
	Y2mawZwcbO1B/J45RJ9KQVlcBgrqsWrboQHbjms+LCRm2j2oRWvHhJUNwJja0v0a3oWWs+KRshE
	X94yxOpDgowIzA=
X-Received: by 2002:a17:90b:4fc2:b0:3ab:f2a9:cacd with SMTP id 98e67ed59e1d1-3acef5700abmr10872896a91.49.1792502652945;
        Tue, 20 Oct 2026 06:24:12 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60be992dsm3550434a91.2.2026.10.20.06.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:24:12 -0700 (PDT)
From: joonhoekim <26rote@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Joonhoe Kim <26rote@gmail.com>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
Date: Tue, 20 Oct 2026 22:23:58 +0900
Message-ID: <20261020132407.968-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <atLkH_D2JrYdzacx@debian>
References: <20261016124600.31-1-26rote@gmail.com> <atLkH_D2JrYdzacx@debian>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joonhoe Kim <26rote@gmail.com>

On Sat, Oct 17, 2026 at 09:24:38AM +0530, Manivannan Sadhasivam wrote:
> This loop is going to block other nodes. announce_servers() is called from
> ordered workqueue which only executes atmost one work item at any point of time.
> So if any other node queues command while this loop is running, it will get
> blocked.

Right, the loop holds the ordered workqueue for up to 10 s.

For v2 I'll drop the loop and retry from a delayed work on
qrtr_ns.workqueue, requeued every 100 ms while the announcement still
gets -EAGAIN. I'm thinking of keeping a time limit like the 10 s in
v1 and cancelling the retry when the node says BYE, but the details
may change once I test it with rmtfs started before the modem. I'll
post it as a new thread.

Thanks,
Joonhoe Kim
