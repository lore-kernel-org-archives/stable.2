Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641316;
	b=iiVYl1F2axaqQobqBKf05PS0m81Mtlz9i9uRkjrDHrfTk/lkH1kitkxVHKcrUsNU35yi
	 lmpIft+ai3V4YKEzHmFbXLTtVjRPbHCEoNGwjq10NVHpnzpgIkhZG21NB1KFj9QjBcOVa
	 8M1gSvZbdx7Ozqhb8EIadID8lpTipfBx3jE4TSpq7CzSno8rEy4Bm3Oht+kPWbxoaU0Ve
	 R/faTbZw1C9iDghs1daIFDIVuD+o1ZI5MHPXBfN0bO/xTkYKo/PuOD5FVyn5eVVDkcNMj
	 IpvsX/9Z7xuEd0F/MeOtsqPtWoMciPHxYEflrRgrl961nlR0Q/JoJ+DiXG1aEdtvpHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZUmq/AHkNakT7HaOv5RMPiqqshA3T3BUppFdjgJH3H8=;
	b=W+aroKgIq51yu1f1X5+/disxhz/D6ICrQbxzwUaeDP92ea9dMdmZJJrILaCGCFql/fi0
	 SQX5S8jax63BUftl6KBJcRwYfBVcovghDolrZBtmgQGzKIox6yNl0GX5VloN7H+DS1Mq8
	 EDhdNh2HBmj1QUFFHtzQvVExznIo1eBX5wbq17JyFj9iq1VJkBY2TR5BF/Tvc1Ae1ft19
	 sbbP98Kr7JfM8rhMJMlhIvnT7Psi4v/eiTL/OxxZie51eGSnypJUBdyRQtLFoa/rSx2Q9
	 6YSLg64o/vSytToc9XKxymrlKHZF/MqTeJHpo6TQU9simzDV3U/L+3dE8D7GrnCo7Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JphWNBTa;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1A606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF1A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JphWNBTa
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0ac277beaso1490023a91.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794641315; x=1795246115; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZUmq/AHkNakT7HaOv5RMPiqqshA3T3BUppFdjgJH3H8=;
        b=JphWNBTa0MysOtfljwluIzxQpgBb4srmXPAiYuHn+LD9l6dGRPGc4Ir5+ckJVNh4v0
         Vj8vRMyPfD+lrJexHDsG9k11M2w+pz7t6ONU3FgC0Ry58L2Oen1OsVKDt0x0QSN43PQs
         i01ig1PN0a6kNaUNhXV6plrJumm5YXmwmXbkW/7Hx0b2bVEG5cgU50QF0m3KMJ4FMExd
         A8SVuSw/6TEDNm9OpLnyH4GRHbEv3p51UNqesePVDGs5wYWzPZxQjuLKB0wHj4kQ0NwH
         jRzb0HwYWNzM8e2aQzHBiAF4koJHzT7scHHKBYsP/5lWAdQOeJ+bFqKkx91yyyKzIyO0
         CBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641315; x=1795246115;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZUmq/AHkNakT7HaOv5RMPiqqshA3T3BUppFdjgJH3H8=;
        b=MAc8B1foxU9Jr9civ2fV7SzRPE3UZ5o4JunWPtZMKOc5vr34NF1cYsjFN0hRC5YBR6
         aLvj0qwkVDqaIafoJhO7+r7+V9MENbvTpQJ5YhSrmSdAdeBfSPYpXxVMhWYu/NKD4Ayn
         RAzn1WyDcxTfU1HtM8Pb7O3dNz1cIpDtgUrHs+QPkXbXldkMwrdnasVj8xsrQmPcAfKX
         G7RRO/GD9Lhhp4eoZ9QSLsB6oQhE3mRniMlRIWeT6H52bmn119yEevnPMiFsRsJvMUVZ
         TGMQqG2kDuCjV10L8yDE0xLgTq/Hvezefp188RFIl/R0So466Nj3CX5TbED+eEr6hlyS
         st5Q==
X-Forwarded-Encrypted: i=1; AL+hErHUJGGJeOyRfa9yWmSoMOv8nGnpGSWGOebFkIbMI7B/4XEVfHR+sSUEtdP1UOMzXosNRRnZqEU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8Gha+qiyTy0kzhD9oqshO8QcsPSXVZSMU0CzoURKKLN3NiSzD
	T8+w7clDfQD39h6tmiVtif4d9zb5p9pnI3SSfr+eAaG95LFlKOAmBR61vs7o24QxL7mPh25ZEsO
	FwUdFpg==
X-Received: from pjbbu21.prod.google.com ([2002:a17:90a:ee55:b0:3a7:d1df:7b34])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c6:b0:3b0:e2a9:345a
 with SMTP id 98e67ed59e1d1-3b1b0b9b782mr4266092a91.64.1794641314735; Fri, 13
 Nov 2026 23:28:34 -0800 (PST)
Date: Sat, 14 Nov 2026 07:28:34 +0000
In-Reply-To: <20261111174704.24312-2-juanagusnicco@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174704.24312-1-juanagusnicco@gmail.com> <20261111174704.24312-2-juanagusnicco@gmail.com>
Message-ID: <avgNl96dmc23KOrW@google.com>
Subject: Re: [PATCH net v2 1/2] tcp: Fix the SO_REUSEPORT bind cache admitting
 a conflicting socket
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Juan Agustin Niccolini <juanagusnicco@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	josef@toxicpanda.com, jbacik@fb.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 11 Nov 2026 12:47:03 -0500, Juan Agustin Niccolini wrote:
> When the port is in the FASTREUSEPORT_STRICT state, inet_csk_get_port()
> skips the bind conflict check if sk_reuseport_match() finds the new
> socket's address covered by the socket cached in tb->fast_*.
> 
> This is only safe if both sockets match on everything
> inet_bind_conflict() reads. The cache misses some of it:
> 
> - It does not record sk_bound_dev_if or sk_reuse.
> - It records the family and IPV6_V6ONLY but never compares them with
>   the new socket, so a cached v6only [::] (or 0.0.0.0) socket covers
>   a dual-stack [::] socket.
> 
> As a result, an unprivileged user can bind and listen on a port that
> another user is listening on, for example a dual-stack [::] socket on
> top of a 0.0.0.0 listener:
> 
>   victim:   bind(0.0.0.0:P), listen()
>   attacker: SO_REUSEPORT + IPV6_V6ONLY, bind([::]:P)   /* fills cache */
>   attacker: SO_REUSEPORT, bind([::]:P), listen()       /* should fail */
> 
> Only take the fast path when the new socket matches the cached one in
> family, IPV6_V6ONLY, bound device and SO_REUSEADDR. Identical
> SO_REUSEPORT listeners, the workload this cache was added for, still
> skip the scan (binding 16384 of them: 9.80 ms before, 9.86 ms after,
> 5874 ms with the full check every time).
> 
> Fixes: 637bc8bbe6c0 ("inet: reset tb->fastreuseport when adding a reuseport sk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
