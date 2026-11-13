Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794607916;
	b=GKk9kLxr9uCaMOOypQQfcyHVGVe08PKYnS2jUmhk0Qpl38O3fJqYjKhVWJccSLzeLEs0
	 4lwDGnGHGkBOObzvTUwvUA7EcVL1ddXds+zEj1PRAq0K+5KwAEAN7G7GCfyBzJvqZFEDy
	 Pw25zjFN/hmj0ZKwwvSdko7Mc1qmLJscyf2nxA9AF4Hi9Hl9F/l7Svdp1msgQNZlUY5xh
	 /HQczVtwigSt0ZU/Ulk0rIy5U7ZSjcoxjSKLWQOHQecJNUp4BpX1aCaVMg/um1zhC8p63
	 HVu0xp2GkflQM9ea8ewv5gOGNC0NlX0kO9dCc7AzVfMMn0HD4C/vL+rPeP9c2OcVv7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ybt8M67biDsHhGooRRbdUNrCGrHYGM9IN8vEnin7R9I=;
	b=GL3CxKtu28iL6Sx2XHEbTYkAQfNWX3tA9a/AR/WLB4qbG1MP7C3BhIo6XDSDffW57vm2
	 9BjPHHylsv+8ZEYBr4w1OpJyf+4beqzDdQrklYtDj1wN2UM0S/Ef5PnmzhoD3DCkou8g4
	 GQY6dNGbqyAGtD2vCra6Vne2ZdikJp2fWYmVpqV2OenucaYxv1rmHPInrUq+4iTPmHzFT
	 R2zW3N2NVhvw/MMl1tHg30oJb2W1tBCYUvli/f3CQNjKr1W+1/cLutiRWdMVkFxBz9U8m
	 eqrEuKyUC621myXG0X76x9f/vkqyZagmzrazKCJwQOQyPJz19e+HSZh9S2sLUkpz1Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fkKGGul6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92887606A884
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92887606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fkKGGul6
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40e30c26a4so342401066b.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:11:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794607915; cv=none;
        d=google.com; s=arc-20260327;
        b=nMTzhVTQg/KFLqF+PZS1IdeSeZcePxl3zl8kJ1uuDvmiD5WrDj27442XTUla06/ODC
         GDHqCtxI9H5xiyvjehIjpJQV30WA6eoU4AogZGyC8x07kFL+cZnccoqpqbLWixefzbFs
         Y7Bkkag+WYRhcPEaEX7+3UWtPs6UwcEjZivJna7vKSPyfdv7F/Gir8bXiq9fz5TdfLrJ
         bYrnqBpdJ8j/7TRSlcv3PSu7HStiVPGMZv8OQjKr/z91a6kGG0QrdFm0q8d94CLUuEas
         2vf5eIfxiCT0XPY8AhxREelAgKWnnAxOY91r2qm3aCCOBBLHNFLJWcGC3HOUfLPi1ygN
         fPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ybt8M67biDsHhGooRRbdUNrCGrHYGM9IN8vEnin7R9I=;
        fh=5oa06vWD2Q+2z3fALoNYg2Y5/WF5mBvs94G6JnB/uRY=;
        b=AHEoU+4tdvzH6e829nHGvckO/+XLWUuUh8UotlrDWNvY/wWSm+8d0lHrxKlf5PLBW/
         H+MIJ+f7vFE0gK8QQXc10HXgBGND6gXVeUKbBeYc3p/jZ2l8vz+V25Ve/fS814ULw8Xm
         mYKobx56HAqykEwn3r91ubQ7U/3O4dU7YJAohPviX9QoWwGs76X8SNol54sSMwLQZgZZ
         MuDHLfabvm4v61hDK1ZT6LPOkjCj54v6Ekii0YfjVsYBadcaUe+1Hkeb2QL/5xhK1SKn
         8Mxz6SURrXUTJVVNs0as+WQsgr4wk3YpaNB1wmpp7xd462bj6kw9KEnLidAhh1DoFwjd
         2I3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794607915; x=1795212715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ybt8M67biDsHhGooRRbdUNrCGrHYGM9IN8vEnin7R9I=;
        b=fkKGGul6k5DfHm/ywwJyW7SQPx73tf0+mO8q7ouVZBy4v2lrAFxYP4r91QXtNUL1mU
         irdELIE0V2E5fWF1wUnwTWRviflVxu1d0ac1q+8gI6A1K/9zdHoBEMmjLPi6Jiiqqx6i
         NmtRAgzjGp978IRelMN3Wyj0kHipRDzJAhpAvG2r8jOpTUOyfxGLBls4G0k/XsAXLw2F
         U+qfBJCSwcOo/+4LecrpNDbXQFRrVT0Q5GxyNq/UYeU+4nnfe5kaapWHC145/30E+EC/
         TYHjPXslM+ZoS5zYRloqlvyQg/hPfqS2ZyhiJmMZCB7j9md1jhBttd/Ctb0bS1TBgEBj
         fphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607915; x=1795212715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ybt8M67biDsHhGooRRbdUNrCGrHYGM9IN8vEnin7R9I=;
        b=v6akMOLEBdMj9ddBHcGVq6/cKEBY+PuqzGl33XvXpRM0l4dpYGCr2f7Njv3eolvHPk
         QDvYMg1t5ppyg1nJR+w6uJOU8Xw1xc8kQEGUmaUvTx5YtIO4V1IgXajMrLF2qT0DYCfE
         QIUgYeFFYhpzecEFNDAErkSegWIbARx8tYFWpNSH2h9l8goJy759Dgi+E45dUHWUiBoX
         Jw0D2G0O5qQIb9xE8KeIXphe0C0Ox8XIBtCYyVn0vgd3XVMVrAP1KEcjnEeUIpfLuAzD
         NJr4l9KeUOd3YnyRhw5nr3J3xL6dB/0SiheBGH5S69bxWZv5nkFRO8+BuQGqsH8Sjcna
         qOrw==
X-Forwarded-Encrypted: i=1; AL+hErGPRr6keZTcVFw4I2X3+SDdjwhCf7a75nJX8udi1mrWgJFG5bOBTfX/dv7cEymUkgfVKjGidlw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FE2B0/7wRDvKGB8PMPTDdk+bJNTCOaNwgcX8zxs+tNPcoLNnN
	kHxPogPDTfWCKcxXhbxdo7inkqLQ86bBefdCwr/tuNI0tIs1Cv7nlGXDfvQ+65TZXbUAAXEsy8n
	XLEVfFyD8H9WdqAMRrcRVFGh9Psr7+cmE8pMMtt2C
X-Gm-Gg: AYBFou1m62muwmdchqHgE3qJpUdiU3H3Q/rqLY51QaUWtURh+Apgl8KHfjchT6tMP4J
	kpcfel4XnB9HuBI2HzSi8Xh+dbU003apceZpEfvI7ow/NRKMuJQPdHasPq9g+6sB9k8aqqC801p
	ZVHBVYORRuyyhrG6wXoUxW9D2WkyVsWEaatoVPQAx3ffd8psbNPaAmbvGT/WOYTErmPf4y7bBGf
	t4leg3lqk0UMCQJyq797jAtmo+VMkQ4J1NxdvJwXV3Gu2Qa/vdOC2kqhfe4zZYtPIsFoNJ0+ykv
	UOWwerG5rBaR/JLPO26WGy6YPCGpntAWuuJgILOnIoL59N7G1eB6/6IrHSd/+XyqhdSPW5gD4cJ
	00E/wiT3tByC3miYwncYBH7t3AS2eXh8tOt8uXYalM7Muqs6vlni7fzy/hqG9QWshtapr
X-Received: by 2002:a17:907:9285:b0:c49:8bf8:a7a7 with SMTP id
 a640c23a62f3a-c50963173bamr342209766b.7.1794607914514; Fri, 13 Nov 2026
 14:11:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260918025416.604297-1-dhavale@google.com> <2ednz67kpd2ikrnerrmnvol2mdfntgqhakuoiu7x4cnrlpiugm@ojqolvlfmpnj>
 <CAB=BE-Svy3yoG+nJ7Z6Us5GG2Rj-7dyCY+EMpR9Y+PtyXUKnCQ@mail.gmail.com>
In-Reply-To: <CAB=BE-Svy3yoG+nJ7Z6Us5GG2Rj-7dyCY+EMpR9Y+PtyXUKnCQ@mail.gmail.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Fri, 13 Nov 2026 14:11:43 -0800
X-Gm-Features: AclHuK-6Nfu6yXgfsqoXIuZdafpVDjnEAv-_a_h3e0B--jKTepPtMeiRqE-zaPU
Message-ID: <CAB=BE-QiSn5N=R4aAXSzqvvac7rUb95grTidv6DVfKnjha=drw@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix race between inline dir conversion and folio read
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: kernel-team@android.com, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baokun Li <libaokun@linux.alibaba.com>, 
	Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ted,
Can you please provide feedback? Looks like this was not picked up,
makes me think this slipped through the cracks.

Thanks,
Sandeep.
