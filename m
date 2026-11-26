Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691533;
	b=jsp1aj5a6+4vCQqTYaSvQbiq8Xo82TOkVHs2BQdAeKtfqM3xxJkN4nGAqZKwko/dbwWF
	 aDQUDxgPQToLG/HzS1nOF4Teh9DQtTWeeV+UsFRvsB3FqK6vtzLh6gTA/8Fhsr5/mejvr
	 dOcLTQdrShSqCBi1D/TXwOvq92KDkuLuyBjSoClp4k1AbeyCmtcQV17DPdyAMpxcIDdU3
	 fj7wAm2ryjaQh3rzwbLXnCrPvJs/FuAtYzCkG8R+fbb02pXpK/LZIvGSxS/yNxpKx6qj9
	 7CHDiAwOr/H61Krc7KX7CF56EMWm0f+0bBiglFLdJB+A3GjJy0ZzW8r75LWZ8XQ1MtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691533;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/bantJDujBdPXRkbIoqLhEHljHB1m6SQlPYF9yA+ZR8=;
	b=Xt1PpmOoufq4F7dK+4K8q6pAjHBWB4QYTPtVyM1NARgb+V+Afp8LiiNbnRft8uaO6AEg
	 AzRznVmNRzVqbT+MQCwqJprgrPpVTNVAKiH2PxCobsgkbdQwFjm6HvPjIj4vqUZzAxHlY
	 QhEJ8bcLiaGf1ia1CGWuZXUrdMqggOTI8wgpoBpppQPzTro0YBMWbT8n4u+GrsB18wSVG
	 tkVaewjjmNubgZ4zspCC2e7MR4Mcbs/XlMUQt66dKRPertE5NORvr0nWU755VNEdAt1vk
	 riBCQk41uNbffC/lkS7ED8XkvPg89x4oqcS7NEpxdBvCYMdITWb9L6uoD48dTC9CgOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfZ1kP62;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kfN1mrDt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF1606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 11:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89EF1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfZ1kP62;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kfN1mrDt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795691531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bantJDujBdPXRkbIoqLhEHljHB1m6SQlPYF9yA+ZR8=;
	b=NfZ1kP62lBJhCFaL7AzyO1ECIE0/NYCh+NNbvGO3+xPhDVPyldUN9xnX+yNVjtVIxIqBts
	+/V5XjGOEike52xFNr/lDFRafkeV6eyUaxEwv+P50eYm0XSldZlCCmOaZ+p2uMRWMxiFen
	g1BDKHDV2N+DwRTh96bwSG+5zpKmM9U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-MO5xlLvyNDO8w6yMhqcnCw-1; Thu, 26 Nov 2026 11:12:09 +0000
X-MC-Unique: MO5xlLvyNDO8w6yMhqcnCw-1
X-Mimecast-MFC-AGG-ID: MO5xlLvyNDO8w6yMhqcnCw_1795691528
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4901562b819so5021278f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795691528; x=1796296328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bantJDujBdPXRkbIoqLhEHljHB1m6SQlPYF9yA+ZR8=;
        b=kfN1mrDt0MhWb4rjfmm152dJZ9X1yPBt85q5ThY+EZ/oTKmOu+XE8fqlh4Yo5gkF1p
         5c3OAjR+JqN4ZQIkbJ0OoXcLFONt50vhNaHcwGSMqd4+oEo4M+Q/p96SfY/DyiGEmlP2
         GbVM0LYIcbS5L99JsGIzO2+n3xh3/ZMTGReyrsPxxtvCocGkkddXPpqHW485uPuO0OXA
         uNQGE2PdejFU4dhn6BPktODzA2gVouuYKOBWRlTESJItq6QtCduAOnz2p7wpas997hUR
         knukqjWZxgwcHKo3DttfFrXoawcEVo89erTlVcBb2xaHSHzn+5+1UfK+e0PWKMFHZtEF
         8yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795691528; x=1796296328;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bantJDujBdPXRkbIoqLhEHljHB1m6SQlPYF9yA+ZR8=;
        b=B4J6ybVx/5fOQKojdrGI7lVN+EBtzGF4WX9I6yXXo23DcTTg+LcGiOXPvoqwrc6pxZ
         t41XXxWsUIHNnvad6VueNMPI3o3Iajt1Q/pOpt4qAGoZI2GYS1dOguB1peX2h/epLX48
         AcyCLbBIa0cL56JjUfXkaoD1xfpyOewmEXkJkqedjiFKm//wU/jHWCaxZLnbbRo4d8No
         pvvR+sS5D6tMNVhwTfayFasSi54OrF/OW9CS9gDaW95+E3rFG+SAtumRlRCNgZqZPSNh
         WPaUzNdQYcD1O9f+zhtB5UYiPj0W9WdksfhFEmekZMvOF4pXC7d74C8SQflJgQCefIPZ
         U/NA==
X-Forwarded-Encrypted: i=1; AL+hErHsHdUa6bwmWhi8dCw9NGGClcwdDuUuofaA+E49H3U8up1U4yxlPAnBdqA/iEweulQC+KlLXOs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/69z+KLWpTxUJf98yg9WsqtJQX/JTBo68WGh/xtQP0BUPfMKHT
	suUMJpT2JqlGT9eZEMAXrp3KO98Q6WtE+1mXgzJvKdPnN/wKbKI8uDJ7S/zQ1r8Ez66jUCj9DWM
	s+qHiI6t1TBrohtNnBWOTKO03ZNygO8fsYF6pgD7mxPGMk7kfOHJ0pfr3iA==
X-Gm-Gg: AZFdTZdUaKszBkT5/PvyW8wrnJpVoSjhniHdiHKK3bastS5zFMZgR7Ufr1vXms3hNnd
	QosQbeHst1dX5Q2a69cO5IgnVe2CEXp+E5ichDBLVwvgYBhrfUuHLh2uuclwr8xtdrFe73fIZlq
	MneIvvkqEdyj/BeVMKMISML6L/W7vZ4BJYl4a/7vzxNy3viUPDYRcCgx67mcliYhlFk5BWooU+L
	MCAV6y9WicdAHFXVvvIxFJgm83UCtxp2PC/VgowQ9JDCFHi+RMTNH981j9gDR3UozutVbBzjHh3
	4/F8rfyY/pB8xykcJyh80CCuyFCQK68fZESJ0nRiKnBQF5vGLzMg0hBb7gFbZ0NlJ0/BY72E1AD
	Y4JvMw8fZiKB75f3BWDYWgBvrT1hWs3ljtBUStIzfEKnGM6LkZKY3pgYQMSdaSeh8y/vr9PMFlS
	mYtMuo
X-Received: by 2002:a05:6000:299c:10b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4abb47b2043mr29541074f8f.47.1795691528433;
        Thu, 26 Nov 2026 03:12:08 -0800 (PST)
X-Received: by 2002:a05:6000:299c:10b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4abb47b2043mr29541030f8f.47.1795691528027;
        Thu, 26 Nov 2026 03:12:08 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.146.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b70c05b9desm15925798f8f.54.2026.11.26.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:12:07 -0800 (PST)
Date: Thu, 26 Nov 2026 12:12:05 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Elkin Cruz <elkin@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	irogers@google.com, stable@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] sched/core: Avoid atomic cpuset_lock() in
 __sched_setscheduler()
Message-ID: <awgUBa_9VrhDahUt@jlelli-thinkpadt14gen4.remote.csb>
References: <20261125222729.1450842-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125222729.1450842-1-elkin@google.com>

Hello,

On 25/11/26 22:27, Elkin Cruz wrote:
> When Magic SysRq-N invokes normalize_rt_tasks(), it holds
> read_lock(&tasklist_lock) in atomic context and calls
> __sched_setscheduler(p, &attr, false, false) with pi == false to reset
> real-time and deadline tasks to SCHED_NORMAL.
> 
> For a SCHED_DEADLINE task, dl_policy(p->policy) is true, so
> __sched_setscheduler() calls cpuset_lock() (mutex_lock(&cpuset_mutex))
> while in atomic context under tasklist_lock and then skips
> cpuset_unlock() on exit because unlocking is gated on if (pi), leaving
> cpuset_mutex permanently locked.
> 
> Guard cpuset_lock() with pi (matching the non-atomic caller contract,
> where switched_from_dl() releases deadline utilization under rq/dl_bw
> spinlocks) and call cpuset_unlock() on exit whenever cpuset_locked is
> set.
> 
> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Signed-off-by: Elkin Cruz <elkin@google.com>
> Cc: stable@vger.kernel.org
> ---
> 
> I am trying out new Clang static analysis checks for kernel bug
> classes, and they flagged this code as possibly buggy. The findings
> were triaged/fixed and commit descriptions were drafted with help of AI,
> then checked against linux-next (not runtime-tested on hardware).

Thanks for this, but I believe Mathieu's patch takes care of it already?

https://lore.kernel.org/lkml/9194486f15bb0cb36b51e4525f471d1150c0d58b.1795115075.git.mathieu.desnoyers@efficios.com/

Best,
Juri

