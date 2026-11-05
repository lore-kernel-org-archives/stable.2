Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841963;
	b=zEnrNi3Iry2ux8ZMrryf73rXMNjPxKS6W4sfLNccGIUduqoU2NlyNmw/Rnb6UG7sk3pj
	 eRsp+Hw2E+v4NoG0UnihtwilqLAcQWGJEKWzqdq8AGbNVdIMmJJS9yubl/SlUk4ds+XiC
	 ll5gKWb1zLOZKVUfFbo0pQsKueJRaeaMBF47+JRHdTCyHL2uty2U+Mvydn/PnPmOBUENH
	 YI0tHfYy7qyIcBCV9fLmsZcNXfWl6UMXaw9gWnS5cOTJkz5xZRLTc+h0e5lrLsXdo16K1
	 1wp+7wGWcSuVcWHJbJ75opI9hOHjiuwzdL8O6vmMi6RxTLVSn7gcvOGh4b5bLzLg3uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
	b=GyY6fwro8AqoiwHH/gPh19S6F8zu1isgJlGm0GVbSrg1WZDdr+tvoNe7sTGiUWf0nNj9
	 TEccJdbeGzkKtGSGCHPry9UUVTnYTyzIfKwM4N2ogF7tmOc/0vz/DBivuJGoX3z8Vt8KH
	 2aX8y5b0lBcBzQeFVY/bei28oY6KMPLvCW2vBsdKj71w0XKam1eZhNa+NP/7AksUgihWe
	 GnXh0b5prewGah+tjtuMPAlYrgzEppoKlpwaNNuAJizV1hhtqGGsravXj2jNI4entLiQP
	 4A0Xc0H9W8YGbxvS4xlKFRC0AexPoa0MfWByrw5WpATx8ocRGjfLw03Z+2n+gLNyivw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URcG2K+V;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681A606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 01:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0681A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URcG2K+V
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so2517289eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 17:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793841962; x=1794446762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
        b=URcG2K+VISfVk77nz9AxluxAo+6zOOU5BLm6U+wbfBxbJBSZ9mhRID6K3Fe0vr1dTt
         bGpBFinlx4Fc5TEHebUr8BZPeWqVY0zBtfX9rqHnjIm9pE4F2ziLMJM1XWxCuSr1C3qb
         f4L1Aa64IMK7FZvtc8jzMRmlnPm2EMmLMEYFxSv0JF8da0G822EL9BzvSYEuzrO1wUXJ
         kRZBhx4aamC84qem21tXx9NXtbhTj8quUvNkKgtFAFtFFE8LxVeolmqjDKwgy65fFeIw
         ObC7n755oIQJ4fh9m0/sbvXXl5S9+XBzr4mvMlUfH/+ELdadHjY9YNbKyFTruYEp++jR
         to4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841962; x=1794446762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
        b=znKvI4ZvNqmoCDvcHe+uwo+0v+javQmdByB5ZHWcmYd0A1SOeS/+VPbs/0RJpRjh2C
         OfutDlKq2LOjAaFsyN0t64IxVK5WtqsS/kQqt3oGdNIAv+i/5tCPoCVeUdP38S/wBBti
         +QMClL44JMkxxdoG4xZydd0s+CGGSyhtsvVP/f2Vlgfp6od8Bbf3LhUpIEFDQkz8fjhm
         Uth26YZb6NVlszMZNLDbnKBMapVBTg2Q8/WFWQUWLOLojPwNHk6e7d6UPOupuB27mrKk
         KevSScJh+xvCs+FbrhcCutqlkU99WqiSxX2Jmhm1Uh2k2b+kEVb0tyc3vtbd8pK+2/Pl
         Cb9w==
X-Forwarded-Encrypted: i=1; AKwUvByQFzp9JrCcfgAcxezLRwNQ6TdCMPLffQx+w6arNrMtOOUnN9QZYNSvU/wyn69nz+3HgwrQeZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g8WQnRtSC/7BJnjYyI5oTnopUMR4jd15Lknl5Wpb1wLhPJZda
	bDmK40B0OegPc8gEjjOJYjZsWEPKKkvrysQ77tN2v7MUlIx1dARdrWIR
X-Gm-Gg: AYBFou0Og7DwcQnKqLbTfWExHcqvCXUDPsmEDJVEMkIvZG+K3Q09FCaITlCWeGVZqBL
	qI0AOpd3byNG+CL8A1Lae73QKynw3nXQpJacalGSydCQ365EV7phaBDHdWllNpruNQFhBp1nya5
	1PNPAhLbPGmRXNjN+rTXn5C0CR8fkuVYaWSG1npeRSDEkd+ADCqjRxeVA3HKR5QrapjicA8c7aa
	th59YK8ZPAq9RMH3C9O0VzEge5vYgSfG67wupHeZ2f7d7bBUj4uCKxH+7dKH5D+cHAYupvC1MYQ
	botMJZ9tSWt7VPlQr2D0sgE2DhyR0NWM+QH0bBqFSgJwfKzhn21blmxUYfWaFAFVawMG3SA/WWG
	RzVOJcvJgyD8/XCkQyup1Ho6Axerymu0X0p4xTzxxz5L4B4d2bQJQUESFLLN39nIxDny2Qj2jmM
	trjNp88FJpVTPukUZlz459Z55yE4yeb1PNK4atGncceYofjU9JRyd22UQ2K1SynmcgCWdTMlMGQ
	5+RIlCkzj7C4EepRKV9B2iFX+Vk/JZrDtkSry/WS/caQTAwTYBjwOnz4d9ZSTesQrGJp8DYRs5t
	EI7WvvPb9ja1WFzDGfm/
X-Received: by 2002:a05:7023:d0b:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1ac5de53bbdmr27814824c88.41.1793841961963;
        Wed, 04 Nov 2026 17:26:01 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b8822fsm13868493c88.2.2026.11.04.17.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:26:01 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
Date: Wed,  4 Nov 2026 20:25:56 -0500
Message-ID: <20261105012556.634691-1-odys.yuan@gmail.com>
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

Christoph, as Paul would rather not add a helper for a single user, and
the idiom above doesn't fit nvme's per-controller srcu_struct, would you
be fine with taking v1, which open-codes the splice in
nvme_remove_namespaces()?

  https://lore.kernel.org/r/20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com

It fixes a crash and is meant for stable: a reader in nvme_wait_freeze()
can walk onto the on-stack list head and use stack memory as a struct
nvme_ns, which KASAN reports as a stack-out-of-bounds read, followed by
a page fault. A shared helper can follow if more SRCU users of
list_splice_init_rcu() show up.

Thanks,
Qiliang
