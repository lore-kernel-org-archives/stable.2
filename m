Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912583;
	b=MKidRZThNg7k7rnxnANaQXSKdZDqBkKr/zZaBOaLGIgM5LBz7ghBUEz8BAlmaTYIJJMm
	 KbB5MOdivCtBRZxg2AH1BXsWVnnVPKsUP+M6nJpwyV8g/deZXzrBcXuV1uKKqWh7Aqps1
	 BiTkaUMJdYtGpDgHKjSNHMLc09734HA6nLBSOdl0jDBh+AMmU+Mo4FZMuWC2r16yKIoqQ
	 QUC2mGpQlGJyxKr/1wrMiPCt/Lw4kxQ20h9QJa4XInCoAJ/HrTwH5hq9yl7/J6EHc7NpL
	 prupZWPwodRn46Zx0q+OBZcT/QGgTuP9m2vnXsGRyq+DX0/GvCb0yDgWhUt2fnNVKbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vIPsFgpeDDDerv0ETdjJMk/BOk+taB7WxA1rqOHL3fI=;
	b=mf0LA7gaAnFFLwKD24KIOmqcEHRlTUvwK1thyxpIQNl67CoPcP0go7U9EPW30MZnUgo2
	 /lh81MfInSsYR03TjMq5TWk6D3mKDbQtaKUUQ27pL7ETMbxDSQa9SkknzX1gj0GVV2Sdf
	 KSloh4LEaekQP+L1KSYwX612YwAjHOl8OsflZjoJ5VRqFpWGAYO3OyhTx3WY2R1qe0tkk
	 W27K5IE7hCZItzcLT53725EmupxxDRN1dpjct4X5H7xzHf9j7cYbPt8b/y5vAKtJlgz8o
	 iBgVaeF60aA/nNYcCb5Vct0kOGfq7KtEaamGo4kMItotDIJnvCtzog/XZnxDnJJkOdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Hlb7qb2j;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B59606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B59606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Hlb7qb2j
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so1012979a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793912580; x=1794517380; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vIPsFgpeDDDerv0ETdjJMk/BOk+taB7WxA1rqOHL3fI=;
        b=Hlb7qb2jlbDnD7w+YrqmTYEpCFK07r73zRxJ0MmPzqWcARWLRaQYzCX1erlio0Nuva
         WumHk61kfaPnQvT/quClGwyWPOu/1sj4V6AHXiozQh6+AfB3WkVy9DBgdwru4lXgCVMh
         5SzsU8ExDqctaJJOZX0WnvAdItUzTLvG/iCZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912580; x=1794517380;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vIPsFgpeDDDerv0ETdjJMk/BOk+taB7WxA1rqOHL3fI=;
        b=XIC4Cyqd9j0xT7WlFTPNggeCDkFmlibDruh3rmdUlaBLQT6bRikkdh+/VTJfLdhN7p
         uKj9qU2ITqGYlvTvBg+dksflN7TUxpXZ3+OKZnqjnEhNiV+8vU7tz4zECK6evDIEMKNy
         soeFNmqJHKydEWcwk61d/nLrS2qoMJyaGMD/Lg9ypawyvHpqdBBP3oBLvG0c5xm47g7S
         RUi2Dg54I7pFQlVCypUC3d6bD8qqEDoCDrhDeRDCqyovFh2NPc+0Hyviu37pa0QSc711
         Hy0fA4l1XDwHNNqBRsvX01C5LgwmDJuXHbeZ/SwYvbHBwqc5S3kagAPDN1jMdy0SzD8+
         8vHg==
X-Forwarded-Encrypted: i=1; AKwUvBxheR/ifperhXbQoB6VU9il4HfegiflYh4PE3lUQnlLtaE8Tw9FgPVRdMNaqCaxL5GeXfH+Fg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z83ilgz4MzlVKivUpAt7HY6tKcJvrSfVeZJZJ1GEXCmVPsmdUbY
	JtrnO8t5NiczISPeVos/jIko7LMINxSjDPRKeqak9RwrojSGaQ/Ev+I8TyXUccWIWkBGn7ENAXB
	20utSRXo=
X-Gm-Gg: AYBFou0CBMjJMG1W28/EQEWEjkzD7Gtg/ko30AaNtqKSC6aiFA60aondY6zzeUS/v+S
	axCBw/OfQVWQJGI2mSvvZ5P1QWv0F29mQ+pBre3aejPfAMxWtXkBuFB+kWObgYcpbT0ZFdYqRgG
	6mmsxSStTSwjZpFbcBGNwNvaFgJBBJYjpyBY+uSJwUxnifiixBhq5iFwiS5o6LHvvbWNdk+nTCO
	Rmt4nZPXuH9OcwHUCbMIIDHNy/00tGiC8K1sDqb90u0zRhywwX2Y1UwBDmxXtOLo6oZscYecez6
	1Jh0V9UeW/IGWgjzabKxUlqNWSqZ0D/NOuJmlEvc5nHhfANdrJt6oXpIlYXpokfN4alh5eNAeiT
	hdV625dwzMe0epcxTPX4ZplcJr9O9Py5sgGNEuVH5Q9UanSiJajcIHJp/PX9/smZvkKHSNZQcj6
	LUv0FDkR8QSnyeWW8YhV2tHGnxQmdZVD/lrp6f87viVjjPevPb1KV44DjnseoBhY059HbgC6mYN
	O/GhM3OAqEfj7eQqGrNxW9WuWyIXNO1hV+Yf7uMASJVntxdOdjbqkkZsm8/arP4bCplRoBd5Daj
	5JutWdPH2NOnNeB6WSQYXymwOF8MkGn1ryFDUNkC1xm+sCxqs8kGtZT7vj/1654xZsyPbVYcZKS
	5Xw==
X-Received: by 2002:a05:6402:210f:b0:6b5:969c:316d with SMTP id 4fb4d7f45d1cf-6b5977df4d2mr323917a12.15.1793912580226;
        Thu, 05 Nov 2026 13:03:00 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55abd3da7sm2208153a12.1.2026.11.05.13.02.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:02:56 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c315869241fso364299966b.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:02:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxJszYhfy3ARqvS/G5IpdaPPVaR694BP68qabUiY6Dcmahy4JTxBUP0kDTI/O9b9TY+NscChSU=@vger.kernel.org
X-Received: by 2002:a17:906:c150:b0:c46:9ca9:f524 with SMTP id
 a640c23a62f3a-c4d354b9d04mr48470966b.32.1793912574580; Thu, 05 Nov 2026
 13:02:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <urkgmijyytg3rrislm5fdzmfggqavzpiry23f6lpkqonvy2tqx@d56stj3eixfa>
 <auaFhOa5EBz4gJwK@gondor.apana.org.au> <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au> <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au> <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au> <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au> <auzOjphJ8DWpXwUy@milan>
In-Reply-To: <auzOjphJ8DWpXwUy@milan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Nov 2026 13:02:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcKOC7O30L8_8PMniT71aqy_3ZEYK2xyoR8zW9ZCvO7g@mail.gmail.com>
X-Gm-Features: AclHuK-6zo-9KtIYF9n0Bopl194z1pM7LoK-Wva3VmRK1J9HSt04b5Zu07i1Nu8
Message-ID: <CAHk-=wjcKOC7O30L8_8PMniT71aqy_3ZEYK2xyoR8zW9ZCvO7g@mail.gmail.com>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	"Liam R. Howlett (Google)" <liam@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>, 
	Baoquan He <bhe@redhat.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Marco Elver <elver@google.com>, 
	Michal Hocko <mhocko@kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Chris Mason <mason@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 10:44, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> @@ -1025,7 +1025,13 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>                         }
>                 }
>         } else {
> -               spin_lock(&br->hash_lock);
> +               if (in_serving_softirq()) {
> +                       if (!spin_trylock(&br->hash_lock))

I don't think that in_serving_softirq() makes any sense.

If I read this code correctly - and it's possible I didn't - this is
always called under local_bh_disable().

And local_bh_disable() will have increased the preempt-count exactly
so that it looks like it's in_serving_softirq().

Maybe I got lost somewhere, but it basically looks like that test will
always be true and is pointless (and misleading).

         Linus
