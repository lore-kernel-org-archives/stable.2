Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779447;
	b=zec2UUMBgkwwPdxhho2ECgcQksnhQUkhKC8tzd1xyGeJ2VehOIzReMxPZJcXTWQ/QUQ0
	 8ialnSBbQgLwAEj21OtO1cMBOF7y5S8ixz+eFRcMpykdkL4YeJUykWdc00BswUQZa11rd
	 PlUOHc8KD0t1oCK8oYKjMOzxVcu+tT4Cyml1e1dqVAh7Tu8ByMBKlRBalUWwi+IYDdeXS
	 rVPLBz9EH+G+qX3NAuVyNIMqoylCrkhkuw4o9Byo3flVw0G2rSzO2a3N2dDaKPKo16WR+
	 rw00axZlzBxps83gj+6s+D6zs/VEAYE6H5bpqArRo5VxIn4jLK76n/KqrfbNPGvMXtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779447;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
	b=4N5KSHTtmLeJO+LvMk89sYay5NdJp8QnqkQcbnu31ukb40e+J+cT6+9IzaskzAgRSoGY
	 lKuRifUiGnAahZvGFWv5nj4/PyMn0VHzCRKKli5z1xlvKjViDidO3sTrLDazYyt/iBMSl
	 2wUVvBgNeJPuqOmmjjnR3Cfdv5q7jZGhwUEZc+iWwVoDH/aFgP6dc7oNs4u22i+zGQvSY
	 3k91sTnbEj7U4dxyZRaqmHrFlfXkTGRy4Atmx8/TMYll01zcyWIti48lwSSA5lgC/en9I
	 OCbz43YxxQvD2iqCDn7FZBU3DlEBrSLnt2CF/kFOTmEOW3IaZuUYKlXQOaRf66knPPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbs1CENI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qjC4BqGZ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA35606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA35606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbs1CENI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qjC4BqGZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792779445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
	b=gbs1CENICgA5PurJXbA8PEpER6sktnyNlLRLyqq7SVt3gBk/O2HP9YZH9woRUu6yb99ebX
	eBftWo0pvCNuc4zqjpZibjkdL/Aaf7RloHcgUgvH+6+l6v+3SVINWd13xGt2+hkU4eLJdD
	tXL2fReWvyL2t54UJB0SzxDlFxs3K2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-rrXl5-peNUSrE_uJ2Maf5g-1; Fri, 23 Oct 2026 14:17:18 -0400
X-MC-Unique: rrXl5-peNUSrE_uJ2Maf5g-1
X-Mimecast-MFC-AGG-ID: rrXl5-peNUSrE_uJ2Maf5g_1792779437
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1e295b702so11737495e9.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792779437; x=1793384237; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
        b=qjC4BqGZ19GiA5CbMkSA7HtE/unfd/YVz7YCgLXmBk0oiNwhfNF0Q/pJXKZh6niKIj
         CHIF5SgI4sBnrrUQOfLYGVLd7etjUkn6npZcEs/mlTF7mUoxBdq+r4vVe9WDQ6YZAcEy
         Z64cW4/rHmHWxMbFiIwgJJxAIb2oUg6nZK55A9nb1hqw3/6m/48caDP6bi+8iHxEFlxj
         Lx5ndbOFySjBVXf68OIWtXUIHKSxvEgzFBE53sLSF50KdeA2sJC7PZezLgZZ6/NQMhph
         juvZsMeAAN8DTucvBqU4Jirb/hLZ2D4PMWW4mAkD+cpZ8vFuhWmevCIwCkvDHyvdGChK
         bLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779437; x=1793384237;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
        b=yvZbHgHcWzpwcHfkKa9UcwuLd5JcUS+uuEpiwAneJ/4grXdz+fgKvi3/neNJc5EQN7
         W7Ldg1s1JfhcZHCd00ESxpSbMrWOQ/kLhMJM99H09ePfuVj8mCv3wEdf1vWh92cGPOAm
         oF4f7L/EusDfEJa+oeFRVOwKw4GuxGN0GYZqp4Zx/22IBv9sTyS3eghdOEfuNHIx/Qrx
         QOjjR7D/QUl8nqZWm+JUXTHXxX/MePqvhs13WIbk2BiJq5CXoZ29rFOVPylD73VOAOJ+
         bl/oR3VYKJax+/ZCB6/YZmB3ZeFbjy4DIABG3csG2N1729JMioYCtyV7azlv522cAnpY
         N7OQ==
X-Forwarded-Encrypted: i=1; AKwUvByVsAvqdOOhiuYxv3bJqni0UbMkw29V/WsIlHZgdPMwlk+0eBLBKYDLt/SE289/i7xUIvrmDMw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL49e9ukvpZ/4w5ZrYxZtgPSgR3+R2yvHdP8Z0+R/Pr8cTj9kbr
	pQT8r6WRI1RqU9NykjJnKUWGGhMor4Xkmp/4qWgeueJkEkjztWZF5ePuxrhqf1SIyLGhIRsS0RY
	Dn1iInZRtF2obNi+djOoyUD35P5QNt2KA9hCUxYd2RHvI/wu/Iyr7XuBr6wpYEIJkrGMVaEZgRK
	gcLuQ6pOlT3lp0RJJRfRYMxC6+1mHKdy1GHCfm1w2c
X-Gm-Gg: AYBFou0iRn2+3YX+JVXD3m52SkZ6fttNfC/mFUp6Ky7YH+S3kFJFFaO9cZ6b3nK/GLP
	Dy8aIVEbntoT9SgWP4Wcx3BYNY7k7zr04IKaXaZ4i2W7wZywYcGThtRCZ6xX+fsnGtHqnEAHkGE
	pEtEXbb9c+LW53aB6WbKXKqhj9SwIKNummcNSgJgvDnlSUxxwwN51fTJBZ3iPmR2/cEjVaBVmRB
	CmmVHE0WkFP7qwmlSYw4fPVEX08FLQvFOotOF3d0JFwVaF7CJ8yhNT0MYXglAEoluV76afMoF7h
	5h6uKdyWJ8knRi5rqVADXWluLjtleFZPUXGS3i4zOoasKo19K8nMF3zrCpnjiLiDLHO0555KVcg
	i7Abcgfrb8FLu9Y9ADQrFHdbJQgwdZg==
X-Received: by 2002:a05:600c:3b18:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a211ed8fb3mr45467205e9.33.1792779437340;
        Fri, 23 Oct 2026 11:17:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a211ed8fb3mr45466695e9.33.1792779436892;
        Fri, 23 Oct 2026 11:17:16 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a046fefsm305055e9.5.2026.10.23.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:17:16 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  Pravin B Shelar <pshelar@ovn.org>,  Martin Varghese
 <martin.varghese@nokia.com>,  Jiri Pirko <jiri@resnulli.us>,  Victor
 Nogueira <victor@mojatatu.com>,  dev@openvswitch.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net v2 5/6] net: openvswitch: ensure a linear inner
 Ethernet header on TEB pop
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com> (Jamal Hadi
	Salim's message of "Fri, 23 Oct 2026 07:59:20 -0400")
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
Date: Fri, 23 Oct 2026 14:17:13 -0400
Message-ID: <f7twlr8s2mu.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
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

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> The issue:
> pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
> ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
> the linear area.  When the inner Ethernet header sits in a page
> fragment, the datapath now claims an Ethernet header it cannot access
> linearly.
>
> Output to an OVS internal vport then calls eth_type_trans(), which
> pulls ETH_HLEN from an empty linear area and triggers the BUG in
> __skb_pull():
>
>   kernel BUG at ./include/linux/skbuff.h:2830!
>   RIP: 0010:eth_type_trans+0x335/0x500
>   internal_dev_recv
>   ovs_vport_send
>   do_output
>   do_execute_actions
>   ovs_execute_actions
>   ovs_dp_process_packet
>   ovs_vport_receive
>   internal_dev_xmit
>
> Conditions to recreate the bug:
> On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
> enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
> internal port up with MTU 9000.  Install a flow matching an Ethernet/MPLS
> packet with one bottom-of-stack label and actions pop_eth,
> pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
> 4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
> label, inner Ethernet and 4096 payload bytes.  The two pops consume the
> linear headers and expose the inner Ethernet header in page fragments.
>
> The Fix:
> Pull the inner Ethernet header into the linear area before restoring
> MAC_PROTO_ETHERNET.
>
> Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
> Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

