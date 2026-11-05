Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895487;
	b=dqhAmf3O8/IA5TErdSZu+nNDM+nwr+ShlshrmVGyXHOdzlXG5kQn2UglBA2oGm+df5GS
	 TYtP0vhA2DDrQB+wOkUm+Un2wFtLuJM4pZC6CoL4UMgvD/EV7WUiPVeb+GkacjHOhtnkv
	 gvuApVzkqXvTT688k/Hqv1uTtTPfayjTjbkGVnj2DxngMYVdr0Vqhh86te43CF0Xa1cA/
	 /98vCSbK8+tJX6wAPariM7AlDV4EVAXNamWBti1br8XtqhzeqlrO+tTOr2pgwJb8v+E+v
	 o3EH/5HhnPgzTYZAo+Jbl9C0z76314XKaMldFNQAMjTTuQJLiOFM3sTtwrAlz9WD4IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895487;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
	b=ZAdH6W40bQCPwOuxZx5hSxMP8qj/xxggMQXk/VK+h9HxfDDE6UDs5rTmJ6wPWm6GfUqi
	 wAXky8Zzw1OTj2gAF5fc/ojuTZ3tZjeTkxQ3p1Kg38xM1ejBJNrunpEE3m/7L1q7KB9Dl
	 fS4zz7eCddocPCrlUxwFORjuzG/QiySY7d6mdAmZbS4vivgr7hNE2Q4kIZH5AbC3sMw5S
	 N5pDuTiCqkos2KUjx8NhMjmyjw9OOHp0yFQ8+MkNooR8EBqtbeksd2MKbDlnQ5aBgSePw
	 rHw9QezG6OUsxjN1XvTU3tnSCvFLJTWAK1KeRXk/OvADSsmaUf6izSF9xiwVZFd2pfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5iL25OR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=icvQ0q2+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB5606D802
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDB5606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5iL25OR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=icvQ0q2+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793895485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
	b=S5iL25ORlwfJuyOEN20HyeCp3FYVI8Da+tnY98mDd6yHCFiZeCpRc4Gc9t1btRzuXhPXdr
	1vHHdOPborJtspGTx7Q/wd3GVSd3W4icgpgoKTU+MzMOV46tk90IJwsXyR8lqJu+8nivMO
	O/D9e2qBUAT1LpxCxUynfqW6uQ3Xkc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-iMcxLLNHOMWYVQoh8qOk2A-1; Thu, 05 Nov 2026 11:18:04 -0500
X-MC-Unique: iMcxLLNHOMWYVQoh8qOk2A-1
X-Mimecast-MFC-AGG-ID: iMcxLLNHOMWYVQoh8qOk2A_1793895483
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so19454835e9.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793895483; x=1794500283; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
        b=icvQ0q2+/7npzbgW8GUq9laWEqHVJNMxVd2QK4Wx6lFoO4gsSt+lmep30txehm6dLJ
         SDFHV9B2Fzzoa4DMvjCiXN8NvHAWJUoqnY1BTNtLQ12c+A5AFwpYtRwy6Xt5ItYYPVFJ
         CxUusrqa3wnbpdD8LhTemA21wRrKMsjRNW5rgrWImFtMVstDVRbEURaH7goNjNKpeoba
         x3y77F0yAse/oOOCKxhGUE2rkkQgq5rUr4ybrdyu9TF2HBm3ZU8atbodbkRXW+h8DkB1
         Li48htykwc7VjByZnpGIz/PT1ndhJjv9DHpbaMEPZV1Gy2itwLbro/xzhash9WTqPuNG
         A5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793895483; x=1794500283;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
        b=2QfVnhQxR03Ggz18J9HFcgU/jA0Fy56rhBBYHMGNBtXMZbyUK7NorK7p+fVaw197uR
         gkCGLFGJJG0odlR8gDA+He5jbDxsBKoKGx5h/7ISI/HLOXm6tI/YM/MEND79O1kOR0ch
         BfdP9Mg6Dh+f96lBaVoqWNKkmxIEYRyGvJkhjYfg3TnsxcAuN7p1/n9iP0CjAhkOoQhX
         hcrdMdaz0mjPJrU9uzkPSrGs5ZKhcbMAKj8glf3/6pXEKHkwkE1Gy9kHtZfprN3XOM7/
         XUNMwUiAkhI/2EyFsmXuuD1V7VAW26jjwtu7YDRMiqtlPddnrfkESLePNaHBhhDi4kxY
         wOSg==
X-Forwarded-Encrypted: i=1; AKwUvByFB0MKmpptEPgBgOYDS5r+HVbNGZD4LFIPqu58kEd/v6BFIlu3LdGWh5oNO9UcWekjqByUX2w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BbQDe19Kioy0Zhb87VLISdZTMnDgqbsCNSyr0JSVeW1tlcZav
	8oXDcRcBBzicCMxbez4nSQJAYKQxCCznx+VxGuJ9Raki4RqCu71KHDdrRz1WdccfR64pRVodZgI
	lITSYcHYy4iMF3gh8go77ZF/9FKc27Fu/tw1QjIfdVd6ygfD0CHD9uKeH21iuWB9ox620RvfCUY
	WM1SjvKhws44V8tCVgi1aLtVCet5BMXo0xVoGhztHO
X-Gm-Gg: AYBFou1mXbRtuGxoPW+fLTP336DoX6PkLgmqwL04F9cGflpC5wkf3+3FJSkQiG6UNAI
	al67DNtDJ7OBihwm64bxTYX6//0KE1HkrzMs4yn3+JU56LOKZMSzWdtOvre4q4QFtJ0fOnMg0BM
	1nQiNdKY5Fi3K60rl0TyIiAwzpSvHqmKS9CknTG6H8/aC1Qd/TkA9/3jyE5IMbTDFmXgbpld/54
	07rIZ/aBEETPFieoStvexVM7QVguMpAiEP1CS0oo8zSBeliovHWp6MIObVerRY3sVMo6WdArBSk
	+2/faWhbtVuP5XZLEHC4vP0q/VBjz07JzUH29tWyWA6VmVesFZfDIz1DSkpwCNpAANSF0ljfkni
	aUpgU3M8AMMw1Vh+ItHvkjBUxL9LCajI43vFVWGhzC07w29wvGhAyJYL9Pc1zAVUYKCNan5Lm5A
	K8Xg==
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ac150b28bamr440224765e9.4.1793895483140;
        Thu, 05 Nov 2026 08:18:03 -0800 (PST)
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ac150b28bamr440224145e9.4.1793895482697;
        Thu, 05 Nov 2026 08:18:02 -0800 (PST)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([213.157.19.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22f4sm124635795e9.13.2026.11.05.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:18:00 -0800 (PST)
From: Aaron Conole <aconole@redhat.com>
To: Joas Antonio dos Santos via B4 Relay
 <devnull+joasantonio108.gmail.com@kernel.org>
Cc: Eelco Chaudron <echaudro@redhat.com>,  Ilya Maximets
 <i.maximets@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  joasantonio108@gmail.com,  netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net v2] openvswitch: advance by the real header length
 in get_ipv6_ext_hdrs()
In-Reply-To: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com> (Joas Antonio
	dos Santos via's message of "Mon, 02 Nov 2026 01:45:35 +0000")
References: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
Date: Thu, 05 Nov 2026 11:17:59 -0500
Message-ID: <f7tqzgz8d6w.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Joas Antonio dos Santos via B4 Relay
<devnull+joasantonio108.gmail.com@kernel.org> writes:

> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
>
> get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
> key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
> whatever the current header is.  That is only right for Hop-by-Hop,
> Destination Options and Routing headers:
>
>  - an Authentication Header is ((hdrlen + 2) << 2) bytes long
>    (ipv6_authlen()), so with hdrlen = 4 the walk skips 40 bytes instead
>    of 24 and reads the next "header" from the ICV and payload;
>
>  - a Fragment header is always 8 bytes, and the byte read as hdrlen is
>    its Reserved field, which the sender controls and receivers ignore,
>    so a non-zero value makes the walk skip up to 2048 bytes and miss
>    the headers that follow;
>
>  - in a non-first fragment nothing after the Fragment header is a
>    header at all, it is the middle of the fragmentable part, yet the
>    walk keeps parsing it as an extension header chain.
>
> In all cases the OFPIEH12_* bits stored in key->ipv6.exthdrs depend on
> bytes chosen by the sender rather than on the headers that are actually
> present: payload bytes that look like another AH or a Hop-by-Hop header
> add OFPIEH12_UNREP/OFPIEH12_UNSEQ, and real headers after a Fragment
> header can go unreported.  Flows that match on OVS_KEY_ATTR_IPV6_EXTHDRS
> then classify such packets wrongly.  There is no memory safety issue,
> skb_header_pointer() bounds every read.
>
> Advance by sizeof(struct frag_hdr) for Fragment headers and by
> ipv6_authlen() for AH, and stop at the Fragment header if its offset is
> non-zero, as ipv6_find_hdr() does.
>
> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
> Link: https://lore.kernel.org/all/178905555085.219967.6617611783437228045@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

