Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B0331ED0
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358970; cv=none; b=ZoP0aG0fjTl3UIxu/T52sze79L+vGHLMlzCWQWjRm3ZJVesns6Q3zoTZ8jxoB0B+9P3PzXa4DdELjB3Kca78KqPQS0ugJdDjncGaOmYEFS5FV9VVATpn0lump3CEHT7Rl6TZeo17IJxkLR8fuiaVUFJL6WcHYiyFadkPblpKRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358970; c=relaxed/simple;
	bh=kHWwMrEotM6IrRJpcqSUfyhD0sPiyKGP+EIxUzLpGxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B41MAIDrWn+hpXw3CH0FhXkLQh/ykt7Vfrl1zXI3eMZPBT3ObiWAnRb18gXJE/S0OCtuFOJBLRoTAkAy8n/nQ3cSGDisSdvzr8ZOQmuTdNGySmaLbEG+SNNKrBk7I56gH4sb29sfk1MIhlW7bBEjhBb2FI001UHDaOzTGXDVfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQD6H3p0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQD6H3p0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso13093315ad.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788358968; x=1788963768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xhg4nFUTwBRfkzvOZ3lYhulq3dN/Jpsw7Gc9lSLlRQY=;
        b=hQD6H3p05owStewpsYUCUQJbLiWKw0N7/xUijdaG6eclJ0Kf/cJubrL/9sHNHCKYqH
         MrLMwOaWykpIypEuye/KkrSieplQno1MeIgcYczX7sHBVJ+KEHJxZ677e9qsnmUO0WTo
         Anb6oAf2fODJX/wOkRPY5DFXlExef2YguF+YnBxKdSjF2pGY3qugVLq44cL/wwC64Dx2
         VSgg7gKPEmww5g5rCv5A2qq33VTv0pU6z2IBlrYaGlETCGnxCCZGTLtKsA4jRpOtTHtW
         voeqZozoSpM/T7dwwkLQeJ67XKU+z7qVYwDne1H8CHbJdk6XeErCRhUJtteVxkbuSA8w
         P/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358968; x=1788963768;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhg4nFUTwBRfkzvOZ3lYhulq3dN/Jpsw7Gc9lSLlRQY=;
        b=gHA6ofpIvwHRDw8XnbOA7nYNtukFeBtwsR0Lu2DcwXcj5/mMgCGimfDEgXgpf/9N/e
         KZWspUCrefTCFxz5GA7mBcw2IJi4kstFhkTcfRsyckmsj+WR5ons5/9lw0RGoJwwNogA
         gd25pdHZd7gp1PXQV7poyd8jwC+AKUfL0HKvpQ3R9gqy3DwcjyvUqzP6ppp8PhKd1wvN
         oSOjb2yulr49YPQXfDHqW2Dz2/v912R9zeMWGYXka6j0OIplFovRoYyt/hbDtq+dCT0d
         n+etw8nbKx0RskdqzmfUxRGcuhDCc2xgFT0F6cjsmwR2Es0wwAqjlu8py9IKf8CdhJQM
         RDLA==
X-Forwarded-Encrypted: i=1; AKwUvBwwciHU+5A9pU9R5xJUiScJ0zQ5IMrsISM/DyXVKZiJK6BLuXjE2d3jGNDKkw79EYYVep8Qn08=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ3uf1JeN2CWWFVlD7NsHemzcp0cf+ygYo8kxoUXuxGdYScPk+
	unhudiGlWCE9clknbFcBfiNJkGyUtJyouQlVsUS46L8DzpIwe5IOm0ot
X-Gm-Gg: AR+sD10Zr0n8N7s/xRDfNYwWlJtq/JhJgexO/sBofWwYT/BFFuHuCIM9o6WvKj8ctlD
	onoJyNHvVg5O5bICDDU089oxG8eVPLIXolGEQxnzE+McD2VYOKY7bhcCtO5R0XhExryptHE2+c8
	fCsMis6aTsHIYJxkD8blgcTz0GX+tkyfDTqilVhJLLEF4MHki+DIRkGNL3IG+UDqG2cw41dSIaL
	9wavouC94kDpGzfQASkGgdcnJ0l1JKK1KVb4PNLmdEwXm/Zsimtp49vFjHWzWsoRXoh8jlvoViW
	Ra79AdhTfxxX/InefxulcRwp9Gge41OrviEI9OnyOqH/JI2UlVf5ks7I0Mnq+5j7NGumJQssxea
	QZAOnfqAdLqaa01ZkWn424oZUN/eSYjYdhwh6b9HGZvyiItKhLhij54c2teXPLMPABs0EikuOhG
	QNTxdWvg+Lux2dW8E7fNsuf5QRVUQoSZxDyprXfm9Aq3mcu9lICmySRKVhb7fDd8Rdbk5FvcNUh
	4VgHqQGDEOVF8Yz
X-Received: by 2002:a17:902:d491:b0:2d9:3636:d01a with SMTP id d9443c01a7336-2daec74e5e3mr70183145ad.15.1788358968023;
        Wed, 02 Sep 2026 07:22:48 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd383b36sm13853485ad.25.2026.09.02.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:22:47 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 22:22:31 +0800
Message-ID: <20260902142254.5328-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902141001.86733-1-sj@kernel.org>
References: <20260902141001.86733-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > When setting goal_tuner to 'temporal', if the goal is achieved,
> > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > will always return true, even if no regions have been tried to apply at
> > all.  This causes qt_exceeds to increase unexpectedly.
> 
> To me, this looks logically correct.  Could this cause any user issue?

Yes, I think this might cause unnecessary confusion for users, at least
it did for me.

I set quota_ms to 0 and set the target_metric for the quota goal to
user_input (i.e., MemAvailable).  In my use case, this caused
esz_bp to be 0 most of the time.  Also, because the quota->ms clamp
was missing, esz wasn’t set to min_region_sz, it was actually set to
0.

As a result, nr_tried is 0 (because damos_quota_is_full() in
damon_do_apply_scheme() always returns true), but qt_exceeds
increments once per second (likely because reset_interval_ms defaults
to 1000ms / 1s).

Best regards,
Rui Yan
