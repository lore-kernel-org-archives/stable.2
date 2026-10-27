Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129887;
	b=hDXsZxfjPfZUoi85Ja9PMdZV6B7VYTp/7mRXrGyQipJUeUb6C+2NTbdcPqu5uwxQx+EE
	 ch/rLpoYXUDPh3aF+4uZRQaR/CHAYSkpxKXGKD4FLW2UZnTMxwrveqNtYAy/phAyRv5yK
	 yOzNNIljLr5oIniCKYnU072QPxsE6DdWcfiz4NFJhfCGKzFGsFvhhnz0QHDmfeIuRShiw
	 E+enSECWoTxSj4GtUWgUpGx7u0CrWdca0toz7tBIM0RCLCFj7gA9e6bGdDVvK5CQKqH+r
	 1sdfxJmwINkoQa3VcQZFadHVcN7LwMb+9Mrm+O9oVTYKEKQAksRaF38PZ5xblFHUfdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=AoGn9VEZ3I8Ld7dNYqrh8Oigb3Q3zSaylzK9qrRu+PM=;
	b=iO71XQ2C7r0y3BcGEVnhODDz+08oJq4iZXpxGy8DRLV15g2Qlm07msTPjZUpsoxQtg/Z
	 ceZwGTnOKzMhY4cS2T924Bf43n73hodm8lj22yPNKQYTwhnQ/U1qPgXP1Se+Gu3ij710h
	 96GjflZSW5xwECtahSARfonXJFY4hmPEE7Rmkg9ezmCttgGzMKumEgZR26zI0r3fBc5T+
	 tRF5qDdIh4+xtKq6MQ+i2QUKGoF/Vevo5ev0ZlYX+oq4+X0tdQphm8D78xpuKonYlJnRK
	 pnI6uKxuSlZ4LocjqV1dBB1PRLeDWSEt/JgyWAsslyDMkEoX4v9XlIbUb4lpSqd0TZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q62RCPUn;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BD606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 251BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q62RCPUn
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c43373ae89aso26098166b.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793129885; x=1793734685; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AoGn9VEZ3I8Ld7dNYqrh8Oigb3Q3zSaylzK9qrRu+PM=;
        b=Q62RCPUnV4BTCTB/VEZDPth0/eDOGV+2DbB+rwnAq00Er9d0WiTUOmo52xTRwqLfBV
         8ybCdnY8085WTtUwWrWpufTibmSqT0JFTgolMCl912J1Zzj/GMVjMR960Pvlrj690xsz
         qB+dHNF0Abad0Ff+va4Zgh4Si4ZsBgnUfAwZz1fjhVj2YrL6Wq6YxdEMNUdhXhS6scKG
         GQiAhO21/G68Ca+/LjLdqqxa5Birf80FTPrjig/1R35308OJG8B25tVWURAo/130aM8z
         xl+tpCDpUmn9ss2ocgdoAgewATF9MyNbb834ULQLlUFbDoMciHANtGG9WpwrLj7kuc9G
         z7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129885; x=1793734685;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AoGn9VEZ3I8Ld7dNYqrh8Oigb3Q3zSaylzK9qrRu+PM=;
        b=MMt39yg8i94QNlphfNDincfvA7F1tf9E5ZoemdDs8DFijSSkdJYFi6EmZnEfpopcxn
         d/xV9nwGGRlvshWv/Msizy/rowcLQfImkzXf/RV6q9ypESKwwMemmQ50BG0cvdFjJnW9
         raqKpHyM7/At9zqDQgbfY+FthRkNMBpZy0mMQYlYx6zCZpZt7bbF+ocIMRig6RX2Hgrn
         Pynn5fpTHa7UCOau35ByCoIZXGn/OMV05j7SUFVMIETlrtDxMkhyF2K3wuk0BZ6ugJLv
         5WFaZ2wD5rZkG+pRY0ccIfiFoN8eMj78m0EYvTNl2xNCkWk8LugpLqapJyIjCkuReE80
         isjQ==
X-Forwarded-Encrypted: i=1; AKwUvByfIBlewHwlCmkJR00CF5N2T0B0OIkLGYuSwM/HLi1N3lmeRv/IKprtBlzgbPpY/RngbhNkOsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9QmYN1GfLzMim8kCJUfJl5SGzc9RaHl80Q1nx3vBacHynyugu
	WUruo1eg5p4NIbcFiDiP50UZHNrllsGXoXoQ6a+SfXto0FPGZKtDdfmHzGaPDYRJNJs=
X-Gm-Gg: AYBFou1KexZ9OvKJiJjMXkLYI04IjnsEuLIFpAKu9pvuBMv8geJPynQatRSafBfSFTt
	9FtuA2uvyCn8VuiB0HPRs9zLEOyLgTznj5N6TndW171OTFcgADTPE4njMNrqJ5CauKietsXUoat
	gvlilTcbu+BBUJ9xAvAsue3CzUjcqLPzcW78isjVsOztMZM/50g84LxfF9l8KBImxmgtQ8gB2o7
	hyOh+nd3Oye7S2kUS/N6+WmykcK+kt1hNZEfI7FtJVtwx7JrowLTCoeHI/ar+DiEGqQXCDxBhjh
	7EjYpRpuaOMsbtCvh4bQ3tPQZKXwSIvhDpZlSLpRZlDvNGdBSAh0tANloCaCU/5MsH9B6KXoakX
	TqNXNjN6BIfOzuKUyFohN0CC+PfkzjmfInlcKF73uKonph9aLbiotRuaznp4M+lp8yJEcxRAbYs
	I6ln8xhUdogCZV4Ke/6M0umPtCJVxMV7cwpzmgqg5V/bf0ia0RCABzSD7j9e796tpV64cBaXJMm
	17F5eKnWKafbEWrPgtNQKi1d3T6BDNU9lTOTzZOBhd4ZQ==
X-Received: by 2002:a17:907:7f9e:b0:c46:645f:cedc with SMTP id a640c23a62f3a-c49be054a4cmr17194666b.46.1793129885192;
        Tue, 27 Oct 2026 12:38:05 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm455107a12.37.2026.10.27.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:38:03 -0700 (PDT)
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
Subject: Re: [PATCH 4/6] mm/page_alloc: don't undo another isolation in
 alloc_contig_range
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, "Gregory Price (Meta)" <gourry@gourry.net>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org, 
 surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
 hannes@cmpxchg.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, osalvador@suse.de, 
 muchun.song@linux.dev, iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com, 
 stable@vger.kernel.org
In-Reply-To: <8a841fb1-8e71-40c6-91d4-3252a0a1a368@kernel.org>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-5-gourry@gourry.net>
 <a4fc92b5-7d99-49f4-94ac-89fdee699042@kernel.org>
 <179310997463.2232644.3260379218896917308.b4-reply@b4>
 <6f5aaf2b-894c-4306-a0b2-e56f815d0a89@kernel.org>
 <A4D82AB8-F33A-465C-AE69-933B746E4885@nvidia.com>
 <8a841fb1-8e71-40c6-91d4-3252a0a1a368@kernel.org>
Date: Tue, 27 Oct 2026 12:38:02 -0700
Message-Id: <179312988283.676746.1330276872732304961.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 19:58 +0100, David Hildenbrand (Arm) wrote:
> On 10/27/26 19:53, Zi Yan wrote:
> > On 27 Oct 2026, at 10:13, David Hildenbrand (Arm) wrote:
> > 
> >> Maybe. But if it's just us core people we can just talk on IRC etc (like Zi did
> >> two days ago when he was about to post something that I already had on my queue).
> > 
> > One idea is that maybe Sashiko is able to identify patches fixing
> > the same issue and does some grouping or tagging on the website.
> > Or send an email about it with a lore link.
> 
> I think that's too late. For us core devs we just need to sync on "has someone
> already a fix for that or is it worth cleaning the AI shite up and sending it out".
> 

It might be worth just having a maintainer Fixes:-only review branch
that automates pulling these things in and responding to conflicts.

I've been working on some b4 workbench automation to make triaging the
list a little more sustainable. It's getting there, but it needs time.

~Gregory

-- 
Gregory Price <gourry@gourry.net>
