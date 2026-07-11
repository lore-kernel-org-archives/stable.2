Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642392DCC1F
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783778419; cv=pass; b=LvmO5orjl9uYL9lhkHUgCclC+37gJhnj8YWMg/ZuJhtZn7j44NO1deHgCZqAw92UVmFxGMZKchQwjxNHiGCJ21mC6EIizXePys7LKrinLiPHMQFcbV/XsYKiTGJpl8xjw9EJdZb/QfIlUyxn8QejHmi9g6ePC/dzypg/n9hroIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783778419; c=relaxed/simple;
	bh=2x8s2hRIzfzcX6kMgVsDG2qEJDcy4Ak63lIwgjF35zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlzajNq0yBZL8K/dEpq25cynPY640hq5ATw8C0d5OGvCXZq4pmEDj6luZMc05ZGrrvGTXEgJKKR2NMz5G3LzGmt8HO6R23Zv1y/BvDOs8cR4V6H9cIH4G93A+WssnPnznApXpi+hQs3Y5yWHbDxJgDWEzwk1FDAZTsu63WKbx9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auJzsx57; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auJzsx57"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2a76536bso17563441cf.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783778416; cv=none;
        d=google.com; s=arc-20260327;
        b=kDhaRcNDxFkEII9Sq1iGLe3U0H9cxpvCk58Hb9HADZ/aSQr5b9Q7i53YZ5sO40QmNI
         eVhcBYB1ZmnIXa6asQb3YH6xlK8sY7r/lao2eK0rMKlGt4qlVzQtNdZHFP03SNwgn8bt
         e9QCMHVheiKyFZphkCpWPlQzfwfmebgbAjkcgXGwVyeZ0GAz5SJ8Jl/5QnQXsvwYlxWi
         6d+iwNPSTyN1vZQgac2KZzUYmVEr0KQ1lIzZkrxAv/zPMTupvxOQm5eZzEV4KSwKpJrn
         u/+vTFt2bC6DGHPKWJvU1ZRi+x1DBXT5iIRBD8E36ZG/U6PtNtKY8dq4/43Oj4OXvtQh
         YY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqDR0IptsjWrOWRZQ2Jyt0YxUIjEB4dj30T2XPWVZdY=;
        fh=BuLuYr00gL7hH+GEQMFTaLGQSRJshcQNEoGUtObXsjM=;
        b=L2mSEiVEJX2VQGNM60SPd0Vs+zWiaTuFdxz24Zc8AlOQ1mX35laPkgxsZclcKCi089
         GDlNWJ+aObxEhNP8ZDiFGkC1WHO0aDqi0W7XTy+fx3FlV9DqeA9iWJWtbLqaoc/ZqgvC
         3gL7uohOj5k4KLfVsJHxWDVIIjOOXFdhgOPX4Bli7BumuBr5trcE7m+sJzCxoMeUPDWN
         H4JI17UUxFk37EbZUNCVHP9suU4PK6FUwZEQgdLDccTGARBWduuOR/5g4H20q20iS5Mg
         AG93NGZBe7rbATxKZiJGjEEtg42jUkrq7D9sAzfHMwsB612g/kUQBgLvGasi20rX130X
         9ljg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783778416; x=1784383216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqDR0IptsjWrOWRZQ2Jyt0YxUIjEB4dj30T2XPWVZdY=;
        b=auJzsx57xi10LJGLIaOVxsXhfVM0fjiBx2oR6Y2FSzzlA3J5s/0CtG+K6p/ImEN6Pq
         Q4JDugXNtrSC30C3c8oD8QT18rckS8QA3Tnkh/DKmdo/imspPHiENW7SxRc7bGzjFftK
         KfqqJAj3hPCeO1oaE0ut7s+gLFJ4qfHRrVMfCopt85k4OXpJ7urYArr+JuNW6FyXxlv1
         HUXaA7nIwdLbik4Rh5zlZulLgDMAKQAlUam7CndKegMSvViKmwPFW1hquVvBcGP8/DuV
         5ggKoF3C3f7jDNeDGOCCZ+0vCCc8erQEAGbeuKfpwbCY/+4ZZTa1twjZDEf/NIbqV5vJ
         q0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783778416; x=1784383216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqDR0IptsjWrOWRZQ2Jyt0YxUIjEB4dj30T2XPWVZdY=;
        b=drpSdg1x6siGLpV4VX4rnchgrjsXQNYWusR/VbzJjG2f9fgNJp3Io9+n+4mAcE/mqs
         welHNFRKeY5seS1tzA5q1PKc5Iqzv/Uat5kBfra5EcROzUgfNHZCAC5SS1N4e2oxrozk
         7CW1nEu9yyNDe9ZNl13c1+/H4ASe61iPgI0m2OOlNWYMJSMTUPgstxGjjjR///zLPz8q
         vB1yvs2q/PgKLOJ3GhufB4iMZEZRJgHqmI7JbAyt1A69H4ImJuEiZkDy3VKCy8IK5Zto
         Z5ZSa34qlTAwUbpxJmCWCo/eU/CNXKejZRoA6n4KOqX9TPFzWDSPWuOJgCDWUfz+lrhD
         LU4g==
X-Forwarded-Encrypted: i=1; AHgh+RqzEa5BE+FCU0IEXTB7FSa5mTt5mornoZiA56EnWYcnyEYmBYm5ckpPYhgpRRGQw0zjug8BlT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRG4MQsv6QTQhmmDZOXlIRJcZoGI5EXUgBvukd3S/VwErUpQrA
	xC+pCuHij9RPPQIv5MsSuLjkB3G1cTNHJl175Wt+YSUOv1PecR2iKZivuGVHjzNaeobTpVVHtKA
	/FTTrnHCiZxwoJHsjprGzWdsXG/v4+frXH2rkEEe6
X-Gm-Gg: AfdE7ckv5uxzgEYkYoq69ChKOwSpYW36QJ2ciTSIil47sjAUF6tzGHsmI8PnaE9csp9
	VEhBRlnIweH9VMisyPsYlY3CGe/W+UkFOkx2t20xBWlbBJWCBSG0vGsReB2I6bgDz8MBMTZ7jG6
	EP6AqQBbc2qcwyg/ZlNkka/KNykQahbO8AaI3Eg5sKo32I3IKutWgzVJ04FlxHfrpO1VPD4BUqw
	/ee7fGa3wF/tTqePzzJu8nryvCEqXVfmY67Frzt19Br0MDFSQnQlgoVcddIx7b1LJuWi4hwyh6p
	FuriHGMxROeiCqT8HZsS04sdeec8lfmtBw07J+HOsj73NfqszR1pW6Rbe7zrOZi94jrQcKi4CkP
	UbtumNC5D
X-Received: by 2002:a05:622a:4885:b0:51b:f0ab:2b1b with SMTP id
 d75a77b69052e-51cbf26daddmr29126701cf.49.1783778415594; Sat, 11 Jul 2026
 07:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711134732.1385563-1-tristmd@gmail.com>
In-Reply-To: <20260711134732.1385563-1-tristmd@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 11 Jul 2026 16:00:03 +0200
X-Gm-Features: AVVi8CcY5CaPIMoOd8xuDL4_gMxfAA225TDZjOSaO1YM-5oHGXW8erun50xkGWY
Message-ID: <CANn89iJo1HFtp6EoUmwo7KJ9LRsq_iQqhGV4Eco-7Szw5oN92Q@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: add xmit recursion protection
To: Tristan Madani <tristmd@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mahesh Bandewar <maheshb@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 3:47=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> ipvlan devices can enter infinite transmit recursion when combined with
> packet forwarding configurations (such as IPVS) that route traffic back
> through the same ipvlan interface.
>
> The recursion path is:
>
>   ipvlan_start_xmit -> ipvlan_queue_xmit -> ipvlan_xmit_mode_l3
>   -> ipvlan_process_outbound -> ip_local_out -> netfilter hooks
>   -> dev_queue_xmit -> ipvlan_start_xmit (recurse)
>
> The existing per-CPU xmit recursion counter in __dev_queue_xmit()
> (XMIT_RECURSION_LIMIT =3D 8) does detect the loop, but fires too late:
> each recursion level consumes roughly 2KB of stack space through
> ip_local_out and netfilter, and at 8 levels the cumulative usage
> exceeds the 16KB kernel stack on x86_64. The resulting stack overflow
> hits the VMAP_STACK guard page and causes a kernel panic.
>

Please fix the existing mechanism. 2KB of stack space seems excessive.

If this is caused by some DEBUG option, it will be just fine to limit
XMIT_RECURSION_LIMIT to 3 for such debug kernels.

Adding a workaround in every virtual driver is not an option.
