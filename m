Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843806;
	b=Blml7e584N0D4i8D9ZI/1C8Ub8u9ZCLOzFmFHfuYXiqmEcjIKr/IM3ZVrb8zZjafIq1E
	 9sHwukVmkZhXL0PDzbUk+ewB33x5pyfpifO4sUTqxM+AfHwP/FIPhakA9CjRDVVvFvtCg
	 IM8RNEgNYw6zkPaNjJETT1VyJ8Tz6tsn0t6WMJE9YYZMZJ5avUjGa+FWev2wB9cxY5h3s
	 ROB26LtYbaWm2F4p6tGWy+3epIXOD0Q9qbR5PUk8sNcd0EqaKCCi4yOf+GeAI0E9pJfTT
	 mqjXULFHvM+d1NSZWen9wH6pDEusczK+uZiYRbhzOHMRQGtUD3gDjgw5FCRylzqSuIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
	b=Il7+yHdC23PBcsZ1Fyuz2Pkjn5i1GqTMnuDS7mFElFjuBXds5A19lqtjOQdR/oLs0O6T
	 2lD1rjU7/RKeZ6aab8WZZwIRpvUsS3eEPx8iFfHfhLPrxzThigvQHOajJIZezD9QRVgR7
	 yQ0xJ0I/qPFytFnIJ/1LpvYqi5cinjoKlPVKz6CoruiZZdtkzesJMIXCNVc3BjNj7G5Id
	 TKjN9VBHicqbPbzcwAf8gDJ6UFVaIlbwDdvfozogWbt9Oqd1xtwx6p3CM6M+fIK9XdT+l
	 Yme1Y4B7Wmx7SkWGjrV9DVL7WGGJ2m/Tbht/YCCYSyZkajFv4eJ+Rin/tGGrq+5POJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sg8D0+ka;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575A606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 01:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8575A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sg8D0+ka
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3396552eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793843804; x=1794448604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
        b=sg8D0+kaPPpUPvH8Fa+Cei6LuqtopYyEBflLw3ALL3zHuxcJ3l8hfMCApuoapYXBko
         C/4oNFNo6KunjH84xv1nEH5swz/YXSUqyAE/18jbK7uIBFx9Wbkr6CX19BBTKpIecfTw
         DXdOlE8s6O0cMfxjg8oR3F7Bzgn4jIpU0UddZzrW8ZqQYjM1Juqlukl4flzFiphzTW4/
         +gQ6gkEIv1j/FMSkkYJUkIg/XnUsK3tSHswyNm+RETHwHP4yzcCNF34ubVo6zHzrUwdi
         5tchKAr4KUpYBIW6UOoFhVKJXAkf+wbf+v/DWJ3qpYFu2T31EAO7+4jmprAzZLSN9Njw
         Plyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793843804; x=1794448604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
        b=jv5yTjd58hOpLvcs2t/44jUMoNR+qJi89zsW1JMEIMPd506rq/9g5Nk3wLue3kaTAC
         XL6ok+nipkcdkCu7K3w8PAIYzcFLURdrShjNYYhuLWk20A71cc/jGTYeZXSkoinrvMlX
         hrVSOWmy4kWEeSFr8WwACAcVk3uBUoe3sdNiNq/mjq0yrjKKto8VmlLHD5fjEIcJhhrg
         EUd09Dz6sDxGLjVgZQa83iKOCNAg1F1ixlljpKGOjElc2PFLSyr4RRHOaBtRttn8tiW9
         GH69QPa2QhP5y2GDP1+dzgTP9rMkbyJb7Esnotgx8QKUEDJgFHkUvNTlZHHM6ruuES97
         V0Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzRv52LrgfpIMlYeKSUfz8qtCVaSipvstemkkbDDpldPtKnyVnQ5twJ+ZLwi3O7S7JEKI+E/UA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OtmJlDofra7ECg4ffS0LTyj8oiLOnFBvkFKlz2xAPVSYW6iq0
	ekteUs9rNs7m5l2PiUTLO9uPEwUuJdoYaJYzZNwPgeubTQF7gXoXpr52
X-Gm-Gg: AYBFou3Sa9UeEbCifBkt/wlMLMqm9iKPuBfyNdnoi5rnze9MBKfYuvFbwyiynoeLbB8
	itpvj0V3p82Z5Z5DmUaq/fRUAMVWU6PnBQMeFNHICGOKy6fmd3IBfwa1yfXzkWE74znpvE95yM4
	wcEn8Wejs204pygK2A2f8rr8a57AeBs0ZjqCIuXlH7cfbCyzYmRrNZJ6/8Z/YJSLUEwHLCkvPtU
	VJlFAx4CfztvXaC5bpKOHOBm70C6d1OBuzegJGnl84aj5cuGJw/K73FeGg3AAQloHAYLbo29uvc
	mZgfjNF8kus+0C8NOrJUXksV9KCdZfzx9s+aGT2ij0cQ5wAmVRVayuMjOTRxV0NHEYxbxdamnSC
	uzLg3kTeOKyNa1tN7NLcctuZ0o1hbEotQiLbCBGEEoF0+GIO8DuctPAmsu8EF0R6ATlCM9bBVCK
	fQKvlwLFfaosDwJw+/0VVh0YozJweOLyv14V1+OmZ1re9rW7BdlgWYvyxka7VYTsoz2s5yLxWkU
	AvCgQIH/nUugtCYj5IflBCyTELb8SBn+Garq9jJHRchvYTNgIKyYBYMQfbrTPBmNc4vKfU3f//D
	5AnDEFSo6TN3kBJRYYw+
X-Received: by 2002:a05:7301:2a05:b0:36c:b138:651e with SMTP id 5a478bee46e88-36cb1386818mr7686510eec.22.1793843804409;
        Wed, 04 Nov 2026 17:56:44 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm16872570eec.3.2026.11.04.17.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:56:43 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
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
Date: Wed,  4 Nov 2026 20:56:38 -0500
Message-ID: <20261105015638.746024-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop> <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
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

On Wed, Nov 04, 2026 at 05:46:45PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 04, 2026 at 09:14:13AM -0800, Paul E. McKenney wrote:
> > I am not inalterably opposed to adding a list_splice_init_srcu(),
> > especially if quite a few more users show up, but here is what I was
> > expecting people to do:
> >
> > 	static void synchronize_my_srcu(void)
> > 	{
> > 		synchronize_srcu(&my_srcu);
> > 	}
> >
> > 	...
> >
> > 	list_splice_init_rcu(l, h, synchronize_my_srcu);
> >
> > We need at least six uses of the above idiom to break even on the line
> > of code required for introducing a list_splice_init_srcu().
>
> Given Qiliang's response:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks, Paul.

Christoph, with that, please disregard my suggestion to take v1
instead; v2 is the one to apply.

Thanks,
Qiliang
