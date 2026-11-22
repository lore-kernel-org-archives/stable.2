Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795391218;
	b=UdYsbt4wq2qXPf8gQCSijhcT/+fXHX6shCpzsrLJx61J7t0Txj0JITzqFawcFwagDPLp
	 /NBfHrYBwuoPL9HB7tW6oL1JWVPPHLRSENVSx+/9Yhsei/qJi43cgJC7GhX2J0p9b1yIJ
	 p/u1vF7ZCyZLxNqZO8pIFg+GB7Hng4X2yW2T4PkqRab89PsZ4+HWW7NqV5nIED4SjqcTz
	 8064H9qa6BWjO7sHyyO/759j1e8+5wV9ksl1p865TghmNInHIzOitTt8VV18cwAqylPIe
	 ut7skdiq6wRVbSIHZ9AQDlLU8xJa24n/1ctxRlGyVh9tf4R9yxU/CM9v5C3FXJycdsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795391218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5SMUhQZLvGIWMEWzTIwqLJCO1x/4SePRxnBTKofe0h8=;
	b=x/9KzcugQ0ap8DMt2zahdoNq7tbY/REtc1WV8d8YMg6abT9voezAC4An3MeSKRBDGzqb
	 NHStU+ciXqScJqvZiG/byB2IE2w6N7Z+M9GUGm8M2+haATvFbqoKi1V9bXk8DO5I6Uh64
	 iWWj3k0HL69eiWv5EXW++yAVVVOXiw/HtUuh2/pIqRL0gCsaxcCcu0IbEP4+j5nCEb9F5
	 AtPjrH6KyceqbauFPpU29lZ4H8sA0COCdSwm3zo5URa0tFa6f66V5Oj60xzWkXGexja5j
	 71Cn6bPMpK2DlHx61OyGJUnzlZt6JVah411WI2oV4JuXktew1OX0pA52zZUt3h47ajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FelwzqAP;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B66606A31E
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61B66606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FelwzqAP
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f046b0adc0so12175145ad.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795391218; x=1795996018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SMUhQZLvGIWMEWzTIwqLJCO1x/4SePRxnBTKofe0h8=;
        b=FelwzqAPtTFCbjVrrO+tp0DLyT+8WMkuEr+5+drt7XHK+6+huy4f9a7NNvcGXWndWf
         yOfE/ljy2SETkZATyB+6IExeU8K5LdpdmQvHIRrnBvWfQH3wd13V2oXfl/bHJ1P7Urcb
         zTS2TBP4GqJBS1JKAs/46GegA0+6qvMocvNHEIe1nXmUJdAE6Peh2nHYhqi1eulnMyFA
         MkOr5FeuCVqbD0OKTCikwHucX0GNQ0NHQsaCAR3kNwZFLiDez9an9hqcBKfbA9Gbnv05
         FDINlUM2Tq2MWDJYOgGqlxlVDnrBF68/icPcqWqBMH+E8n28H0ElWzaE4I/9Xq9w037V
         DcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795391218; x=1795996018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SMUhQZLvGIWMEWzTIwqLJCO1x/4SePRxnBTKofe0h8=;
        b=UKP5uWTkppaxcVj4EsRx0sQmGJOSBmOX9hGRCTZUoXkum6CNIYDTlVqlXxhf4Wzn2y
         HgsoumuXI7YWiHY/HfU4xsLmdvMAVrBGAl8vp+Jst0+V7Q7ckltQ/NtYVY98IRRirqRI
         zFfGRxkNTLztxh0XWK/UtfrkelNqXD047MPd8Oo96OwnhA+DW6n0NVTWIDi1G3SYF82c
         veX3S1t0LJWDqXCjyZFlpSf3CuHefrDSJkOdviMkvclvPzhjkKG9cKMMZWc5Pfju/zi2
         luffhXtvzkzii8Sle3WE74MKOjVaUq6iUDuuKK5h+sNGlx1Ikn94HzSAvwsBovdsUvBO
         Znqg==
X-Forwarded-Encrypted: i=1; AL+hErHovGEmNYPZiF5t21lQ3qmRonry9etJaloK37WiPmhQOxMFu7hEY5NCehICY/ypUaK2UW1wKf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pCHFNMV613iz4eJFFsfHKVwBqO1xKTvckFw2Ye34xYrsqIuhJ
	YxU1aaxnsZqpB8Jfhx4UfZ9T36nIrGRFSj7BPFy9CHlAXd77yFHT/DN0
X-Gm-Gg: AZFdTZfsx0gaJYsG66i6CQSfKiGvJk5HIcU7FdFkbvaaL9DeWnkzaDiV57IzrNuC210
	9RZR7D71xs05jsAFamF1t8fh/W5+8xdXTmEf6JL0DhCrLIAfAE79Y5y47gcEaOFOn1HNS+IPK3J
	pzHtha48ftB8Ty6fDDpYf9h2aYhUnY7aUTt4x2gW7t+TMwMVG44FxAeV/rtUcw0xCN35Cd6kb2f
	ekZ84jptDY3NM2Z2jcAh4pWz+mCZ2FYOnJwhxQCSPLyi2aDCpRqiTKCvEfC3dWJF6zkiy4q/+md
	d6j7oiiStGb+NXqxgrH4u+3HMkHL2HU/5n4zBePyFjTMG5A9mkHdI4im165rUG6Up3DWPZa7asY
	fZh4RlouigDS/O9pKGCitvD1Gq1jGSQebAiIfHH8pV7PXbzn42Mt3aU+SUPf2s86JmycFPFGIgy
	WlZtyuo1quLNy2s1+O7L8q1SnWoUtPhR8kXwUQTcwEVeojwy6i1AabvUSi59oK85wOIGCNWz+fI
	/3tDcPgsZIR+tJFBRuR7+ukLUY4eEc1pJ+SYGdCn0g25wmwjOCML7a+6dr1PWKnHt6jcm+Pl1SB
	6BRutINV8l1ADw+sEpxutg3+0mLPlwmSrAFqUVt3Tc7jKXseC2QisZBtkdeFV6443rGiR3IcXGX
	N5y5IZyL6AZpGyV6Sn3P0fAif253mtRqwlPZ9G3x1UpIoWe035jdgjz76nk6zrivXEYCAmQf/FL
	J3
X-Received: by 2002:a17:90b:4b05:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3b41c911c9emr8676680a91.26.1795391217624;
        Sun, 22 Nov 2026 15:46:57 -0800 (PST)
Received: from localhost.localdomain (180.36.101.34.bc.googleusercontent.com. [34.101.36.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad47091sm15052556a91.10.2026.11.22.15.46.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 15:46:57 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Sun, 22 Nov 2026 15:46:32 -0800
Message-Id: <20261122234633.89529-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261122012222.148520-1-sj@kernel.org>
References: <20261122012222.148520-1-sj@kernel.org>
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

On Sat, 21 Nov 2026 17:22:22 -0800 SJ Park <sj@kernel.org> wrote:

[...]
> > Do not restore
> > it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
> > the scheme would stay off.
>
> Is this really necessary?  If not, I'd prefer restoring it always for
> simplicity.

Thanks for the quick review.

I think it is needed.  With DAMOS_WMARK_NONE, damos_wmark_wait_us()
returns 0 before it touches 'activated'.  So if the scheme is
deactivated when the metric is changed to none, nothing activates it
again.

I tried restoring it always.  I deactivated a scheme by the watermarks
(free memory rate above high), then set the metric to none and
committed.  After that update_schemes_tried_regions never returned on
my test kernel (it does not have the damos_walk() fix yet).  With the
check, the scheme is applied again after the commit.

Thanks,
Yifan
