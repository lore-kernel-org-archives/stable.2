Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638593;
	b=T9GRayjsDJvIv5k14g1qgb/gJcT+cSDX5PfvIbGdGo3vlp7UNdNlAEyQoUwV5uHQTjaY
	 N9hXAwwRpCXssL4BGsxNtUBdrJqkbOQ7GXHEVSexGUs7kYT3Bfct9RgooKH/uONjXAxDE
	 07SSrcI1z70oC0xsm+NcIvfqz18wS8lWQE+hWF/E8Vfsy/yy0sxfNYQD9ZAkJo4po4nni
	 PRZTNB6g4c/BE3PTvIBv6C+2Rx6RJWT+wKvRK3Sx5G58WtUC8K8Au5lzLwispsXPmVHQ8
	 FT0SyQ3innD81c+/ztpJwCVpkwCxqabLZQy1xkibCxDAmNht/QkBQMmmDuibsIiSpCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5by1QEX/cGC23E25Nzrw5GrZTEPj5OnY/lGT7wIEPVw=;
	b=FF6LkCBWd45/jxRXv8Vm3SwgVITXjl4S3fCN5oy5jrYEubv/BPp0gbhv143Q59ggOXbG
	 VKHeIsG58wJJfGAGxNk9i8SpP/NJ8twew2KXMcG87D9fDGE2EhT2RxsDkyCbgE0UzKG2M
	 ZCDni3KVLiow/lDuGYE54lj6NIt+zEsy2sy2KaKc92U9RmkV930xEpTUOz9vZ+LnSEBWK
	 wwbLjuIu2rBciqbV7bpXzJKwQXvvld3F67Rj5xpk406AbKsGDGYwgK261b0U0uJrIhAGi
	 jrohm17K3HMHMdyZK09sfkLawDj2YnthdbEVihMbHLDyCQDwD3VzAQtNmjQ4S7YaEJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b="I+MxKs/p";
	arc=none smtp.remote-ip=74.125.82.225
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3C606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A3C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=I+MxKs/p
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-386b8f2f671so3244208eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795638592; x=1796243392; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5by1QEX/cGC23E25Nzrw5GrZTEPj5OnY/lGT7wIEPVw=;
        b=I+MxKs/pMhX9Lj7v1b+pmXCQGTFkou16/qGRsto0wbGAUWQ3XXn+aSRSICAMwXsnkN
         Lir3Ad13iPHE/klgrh1D1amjN7jyUF14MN4Hf5XwHQ23CXLJgptV6+7655hf0dMcFkM7
         f37KztvfT8gUm0Tc21eq75yL/QjOQ+RnKIaARtYTnIIBcuaf3/y6XoFy6eTpASUtOVkQ
         u9jO17NSMpZQFnKDv4D8MTtY6CY3HoX4AswUfqWxpKRO/IBI6kfcZKkNh9c/62jdEr2y
         PmE4pCnc15x+tCmJY1nBLRghFI4OCiKsr0liwdqIgjg6a/q1qJT3ixv5I7I6W1b7Myws
         XT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638592; x=1796243392;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5by1QEX/cGC23E25Nzrw5GrZTEPj5OnY/lGT7wIEPVw=;
        b=YCI+b97+WPM8o9MsF8nkpKYaYQ2Eh4UY8kptJqJijSlKHNIKHZFAa9YJ5HYt/h+p9R
         nuQIUXa73O7TfRwdXHjdkN2/q6lsokSPVZ4Xg3ktG4YBHqjEopmiOfwptQ3yP6qqRYD7
         a0ZK11X8vom33on/ceJfkjqkZOx4v0/wle2eGOM6sEl3h8TDt/5CmhT3qLrtq+I21da0
         59YMSPyEoyq5l6t9OOtdOAz+8WOG5MjuBrgMHsrCBMWfQfuM3hlkZX05OKy4lB1LpfQF
         XbRV60kFn0JXJfhDjmb2v+j+OHfPzk/mayr6GO83IQrws7AYwsKVs06NEbE52loAbG/3
         NEVw==
X-Forwarded-Encrypted: i=1; AL+hErEvSdplckHsbbAEXqyDAvlbWIwgdCtecZTnsC5mcGGl06V79/FMiWA3CxE5jZFkrirSW+8LbIo=@vger.kernel.org
X-Gm-Message-State: APuU4Z92T6+OMpNCLehHQ7eitin6lZEdFxafXAeR5ZY6hz1gL0ahP2ml
	gDjwrYA5DcpD35hypIFyRkZ2SrQp/W2YIMEXnNrnv5ONUXmNirZlQdzjOhN23gwKjhHfMW7Q2Re
	af8/eF1WHPfQEsEIV/86r/DSbys8HyM6feUnboXWHMPQfW3N1ecEK+MgPitf2iOXt8HPkXRW9Ix
	l2gPUih6aXnBqb5RcJm7qjEc4IgVRqpzK6n8ACNbgMOW4CH/kvsooAjbacWGjcwQVnc9qhsdHzL
	r8sh2GYFQ1mQi2G7skCfAU=
X-Gm-Gg: AZFdTZcnytUlh4VoA8K1WZ3s+4XSM24logWYArp9Q5QYVKjL5a4PWI77d5aRlGb0UV0
	hfe2SvPnINRnzRXtexxfpRsWA8GISmgHuC7HX8UGuDwqlYiISql/Yfk2YwB9ffygXCnbcAP85ph
	GHC0X4t9MbhwkbbLaZfXu4jPrVUF7MOe3eavjnfR3KkoF80L1QcyoIek9dXaoFz2wnfKZR9rGqo
	mVWiPUXeFWTtsY2B0zaoLxS4dZlPB+B+zIPzxHvtw/BawMbVY+BNmwATE3cvNGKrh3msdQJuOIG
	vAd359/OHfR+lYB72V7yyLXHh7/sIQhgd8WJM8XtdlvIoUfIMjaZlc5NJf9IIO+68EUJ0HZrgks
	qZ9SZlqp7VeCn7p9c9AOsJEuHHGgMvfgNl9O89A==
X-Received: by 2002:a05:7301:391c:b0:379:f7aa:1013 with SMTP id 5a478bee46e88-3856fd59fcemr19297575eec.15.1795638591450;
        Wed, 25 Nov 2026 12:29:51 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-386c213b6c6sm1225263eec.5.2026.11.25.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:29:51 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id AC32934038A;
	Wed, 25 Nov 2026 12:29:20 -0800 (PST)
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
Subject: Re: [PATCH v3 3/3] xprtrdma: Wake connect worker on device removal
From: tmenninger@purestorage.com
To: Li Xiasong <lixiasong1@huawei.com>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 stable@vger.kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
 weiyongjun1@huawei.com
In-Reply-To: <20261124021842.130141-4-lixiasong1@huawei.com>
References: <20261124021842.130141-1-lixiasong1@huawei.com>
 <20261124021842.130141-4-lixiasong1@huawei.com>
Date: Wed, 25 Nov 2026 20:29:19 +0000
Message-Id: <179563855914.3954750.11018048330217114132.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795638560; l=2167;
 i=tmenninger@everpuredata.com; s=20261125; h=from:subject:message-id;
 bh=Kd2c2EKrkQoXWQCM5emjG4zJKJ8aBSctLvqtZYaDmn0=;
 b=1V7sWT7lWWf0f8yfMDpj+BIRdbhVgODSyOZTykZ9roGfZtm7tD1sUCxO14/jnJRB0pHPY/wI1
 EgFk+lSkYfJDaPC2jMoNoxwp/6D3les2LPYNSdfYjt9mCQz3/cfkBmY
X-Developer-Key: i=tmenninger@everpuredata.com; a=ed25519;
 pk=nZPlfTnkwWNTqraxDCv+eNh7JBZRFxAoLY1xeLR6zXI=

> Device removal only forces a transport disconnect, leaving a connect
> worker asleep while re_connect_status is zero and blocking endpoint
> cleanup.
> 
> Set -ENODEV and wake pending connects on removal. Give -ENODEV
> precedence over other failures so late CM events cannot mask device
> removal. Force established connections to disconnect and use atomic
> transitions to prevent late ESTABLISHED events from overwriting errors.
> Handle REJECTED with an atomic status update. Wake the connect worker
> if the connection is still pending, or force an established connection
> to disconnect without relying on CQ flushes.
> 
> The final endpoint put can free id->context before rdma_destroy_id()
> synchronizes with CM callbacks. Destroy the CM ID in the endpoint
> destructor before freeing its context to close this window. Remove the
> CM callback get/put pairs so final puts occur outside CM callbacks.
> Initialize the connect waitqueue before notification registration.

A bit of a nit...

Could you split these endpoint/CM ID lifetime changes into a separate
patch, ahead of the connect-worker wakeup changes?

Moving rdma_destroy_id() into the endpoint destructor and removing the
CM callback get/put pairs changes the endpoint ownership and teardown
rules. That addresses a different failure mode from the connect worker
remaining asleep during device removal, and I think it warrants its own
commit and explanation.

> 
> If transport pinning fails, fail and wake a pending connect under the
> device mutex before skipping the notification. The final transport put
> can be waiting for that worker to release XPRT_LOCKED.
> 
> Translate -ENODEV from the connection status to -ENOTCONN so pending
> RPCs retry on a hard mount when the device disappears during setup.
> 
> Fixes: 3f4eb9ff9234 ("xprtrdma: Handle device removal outside of the CM event handler")
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
>

I have no other feedback on this series that wasn't already brought up
by Chuck.

I'm still working on a reproducer to give you a tested tag.

-- 
Tim Menninger <tmenninger@everpuredata.com>
