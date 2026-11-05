Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841770;
	b=c/san4f3AIxkK2/hDc+Fi3dxgUopteqJ43joqvbDVhL83lu6Y2Gw3eCTI9FHh41O18kX
	 XEAOxPwMlqocfEsdj9YzOeW4gp4b0TsHO8yOpq7h321oJMqsvSCEBLJzsANnEbe67KJiV
	 GjBcYdyzbdLbjmoKPboN0fVFWmJX+Bizd7qHBwqeZjF8qm8h4vck5rzgX5Z6PiRGlBDgy
	 +RTWrYhD2Q44bzO0TrBHh5FZaR8PboeRjzzN03UEPUBs3Yu7xPegMwok78TrQaCcaoGqt
	 Krhez9hceSYMFB/WKWCY2x2wYf2RLeTFMskObjcH50g0DAlpy0W/0P9EpgWtnE2aPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
	b=e4uWlVLMKd/ndxGSS7JIqq74rcMTICrFq37INOaZc1B/MHBcfBbwpymzcXxRIUeJcv9r
	 H+Ohe9Qv5daGf28sevHVpB9/5P+seyk4CtymjZeYOMxdEtQoz/J/p6RhNKIUt06YxQzKQ
	 An/YsmvMXZaa7obhD4hn4TOB4TViSNzuCaCxMUdABy5R5T+H48l3J9l7q8/S6nRqD4euw
	 +V0Ca97MAGJis8dyKhT7rpbMfXpzN5HdBqh6aL0MPUZ13xNVjoNvBysdqwrZLpQ59qFbU
	 YHrwpYI5Bw0ICen0qEm95p7c4zBPIKK9TLxsr0Wvos81VSXq8xt0mzTlGKgxRyY0UTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wXXqLWq5;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078E606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 01:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6078E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wXXqLWq5
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a2761c69fbso288064c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793841769; x=1794446569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
        b=wXXqLWq51EnKuCV8eczEg3m42Y8tLQoCeEt86ccSCmBF8iNWxTJiWbe/B5I9DX0Dam
         22BJ8WBPO1YrCZ6oc3u7dsit8THwZqmLvi3BWEly3Nq5gnMiXRcMrOJvIVOmf9Jbz+zt
         grivGH0X685Zjrt9HwEfUbejqxqsSN+I909TqS8Wbhi2BX0lWnGKjYBV7mjpAYDuILTn
         tbVRrbpIkAkYONNJuN5e6yaj/rmSDzAmSwjeGZN4EFKBOQpwbilT2eiS4KFAy+gWAwCt
         2JIG9VZ+5tD0O1GsVvVZyg9cSjLOdqQVqo+QvkBrF2PaR6ttnUZMv+Uv//WQovl1oqk/
         lvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841769; x=1794446569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
        b=SZOOpeR5xqvtXaxY4nsuiK4xk6P7CPEfLFMr9PT5hdqhraxPGwIwtEGuD93dSkhwzt
         Sig5khwjEVhyqy91KE0KRpaglueGuJyyEXQ60xzXfFg52uyVewWz3NNiuyHv8zFzKAYN
         hVffjdVYYmE2Zlb8VG67gw+R3Cqet9+w0knrfJrveNLW23HZs/9l93BlSOaUksyX3N3t
         HpUsNA96gWHcMDRj7PNkbwdZoX2ZWSUKRF96+zif+AIDIeQCwGKRlaIL17Cw7J0HkmTy
         6bZ7noU79ZxVN/Ps8P1DrZ8tKqVh7h84sfin1yCZziC72YXiNbfl4RlH6IUb1rIXtt1g
         rotg==
X-Forwarded-Encrypted: i=1; AKwUvBxMa7aF6JELe9TouMWr7wrzGxa/QYbmsNFYUawSxYYnl4SZ96oPyj6CaJU3P3YEm0HBJY5TULw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vpg9R8UjNdA46wlqnsKoRRWHQIrJdO3BFFE0jlPR2BLn1R0Lv
	mj3G2czU5ZnKZAqmncmxXMO9Jrmri+bRMFkGsabgXDrkfwuPEJwp8SZY
X-Gm-Gg: AYBFou131fM1x8E0s3Fnr6tLfQIv9GoOLvNzEpLSZX9BawKHVYs7a1B6EXb3q8bOMtm
	QkOIbRZC6Vg17bamCXmbAZqZvqWdHEfEoMzMgMoox6ZoD90lfZHSBwo+sM55HRmdWyQb0lxJ6Ds
	3KDLDFF0TBt1akIRIHhXNGftbEJP3ne22BrEeu6VYXccNfFOAffjnX+OtYuw5VCcVJ+D0CqWx1o
	O6yEgWRGDChAreWkOzavdjw5Ya9Y1v/8m1ZZcICblkADkkHEGIX/w5JyqgEYuIH70T1013xOgsb
	yRaiTmMg+H3uvxyNX1+8CKVZHJOksi3L9oqfiyWNYlTGt7sO4AtesdWWUzJdGWftNhIg8aYM562
	OES0S1iucRxrNk/sN8ydOjxo6zO1AfrhTKzBhzTqZ7hJvn1M3HuL/FcOvNQmRxUP2UcqwH2FB0+
	WAqN6dzJ/zSjEGYw/Nx/xiUoLVdDAeJY543Ij4Hode/gG2TSHSm5G9FhbHBZyAUMlplb/aAS4lK
	bEoSUwgS+exfS/JrhNUIrmx6HOAs7BEvudccJMTvPkijvd3nCOqvovJcr4yntC08yhKFD1s2b5q
	8sQkvcRi3+eJCVpi6Ret
X-Received: by 2002:a05:7022:281:20b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1ade9e3e335mr25492252c88.31.1793841769331;
        Wed, 04 Nov 2026 17:22:49 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm11526499c88.7.2026.11.04.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:22:48 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Date: Wed,  4 Nov 2026 20:22:42 -0500
Message-ID: <20261105012242.623962-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
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

On Wed, Nov 04, 2026 at 09:14:12AM -0800, Paul E. McKenney wrote:
> I am not inalterably opposed to adding a list_splice_init_srcu(),
> especially if quite a few more users show up, but here is what I was
> expecting people to do:
>
> 	static void synchronize_my_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu);
> 	}
>
> 	...
>
> 	list_splice_init_rcu(l, h, synchronize_my_srcu);
>
> We need at least six uses of the above idiom to break even on the line
> of code required for introducing a list_splice_init_srcu().

That works for a global srcu_struct, but nvme has one per controller,
next to the list it protects:

	struct nvme_ctrl {
		...
		struct list_head namespaces;
		struct mutex namespaces_lock;
		struct srcu_struct srcu;
		...
	};

nvme_init_ctrl() calls init_srcu_struct(&ctrl->srcu) for every
controller, and readers walk the list under that controller's srcu,
e.g. nvme_wait_freeze():

	srcu_idx = srcu_read_lock(&ctrl->srcu);
	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
				 srcu_read_lock_held(&ctrl->srcu))
		blk_mq_freeze_queue_wait(ns->queue);
	srcu_read_unlock(&ctrl->srcu, srcu_idx);

nvme_remove_namespaces() thus has to wait on the srcu of the controller
being deleted, which a sync function that takes no argument can't get
at.

So the choice here is between list_splice_init_srcu(), as Christoph
suggested on v1, and open-coding the splice in nvme_remove_namespaces()
as v1 did. Which would you prefer?

Thanks,
Qiliang
