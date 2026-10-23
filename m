Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779477;
	b=uaocPxzB4JrzKpChqZNWAMs8G4NCiM+ByNm8D2YRAen8Yy2DT8+sf8yZJzxjrqd72+cx
	 whmQq+SIU9JW0fEcLtcV88u7XhVz9I+6KWGLRBoCnLPaOfg9Va2NNfcadJmNCTWTp7890
	 1dgVecdXxvZJtqzt3nl23HQ2k2O9PL9DSiMP11KdJc6QHsB+SWQvYnIOu6TgUUM3zWLUU
	 2FX8ZIS5RB4oHNJ05dQTmI7u5J4ZvRu5c56vDcssysouNSn5sOvU3Mwoz7zJmEu16TSUz
	 NA6efEywoOHufNwgDshZvDLFi2s/lubc1fM89OoPPrnzoovr8bYVjMudjeyTXfAcdzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779477;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
	b=Acvr85cBSW6pyN66MMaDCvAdugL7iZ0bz+8i+aKnE4JDwXsH8kFCP8IVMc5gWE1erEe4
	 u146dtkvxSKq2VuGcWNaJD/gdWulX+pEHalag/GGxLtGOJQO0djb1q4Xg4VjwfcuOAfzy
	 rcKE+52L3va66RvkDetZtz3ZeRiRlkcyyjnkZnXiUfM5g+xXzkMopl4jeQYyx341GSaqU
	 ugPNia9QQUhjViOH+E23RBI6pKsxhrl3nvK5kGsCLRSVqWwtGO7s+Y6C8eNd9TFv/o3Of
	 yzQF6JiWqH4mDTynw/rgTny6n0pAVeljzNjzzdkxD5k7je4BOB4gP7lZ+EsXfTKqGpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1kU2J4w;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HX4IGHDY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DF2606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DF2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1kU2J4w;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HX4IGHDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792779475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
	b=h1kU2J4wUYRE1cIJ01iH5k9cwcvhIrwa8UnOuNgKZFIvQz6EbMYnN6IrCjYXvyeJ77TdYA
	vMtot2ytaTCqCwetCPhZjMLhu2kfasUsVzjRO29I0QsLKwRljuvUdIuYg+SfduEe+vxgen
	6dIuGJ7ncyei4051R5OKpS0fVBktx0w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-fRdu-IqMNQmJFdvD-6T99Q-1; Fri, 23 Oct 2026 14:17:47 -0400
X-MC-Unique: fRdu-IqMNQmJFdvD-6T99Q-1
X-Mimecast-MFC-AGG-ID: fRdu-IqMNQmJFdvD-6T99Q_1792779467
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c415561aaso735781f8f.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792779466; x=1793384266; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
        b=HX4IGHDYdIrjok1aszOL8xIYdFvRe9IuFtViIn98rOpyfBSQMBPPmTTdL0coieXgsy
         y3ovUD9tVAAcV4irP49ao5VYh4y2RRJH1wAXK6Bm6mG1D22AZog9egOQu9Q5mD4IiTEy
         9WWSvaGluO4A9MvYqfw/I1VOTfFgYpTFsgL0LzxiSmIkuEcF0stncJUmV3Xjbu6cYJXj
         CwvUzOCk781ToU434BGnd63vIhthMoAYX8sCxWpKUlXulquSwxyJ428pUWymJLzbc0Rh
         j/NjtDY30rPe0t69ZgxovrFlrvjgfm62m++GBGc5FK3uuTpGgmVcj0jfp0iHbnh47Zeb
         hh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779466; x=1793384266;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
        b=wVcDM/sbmPV3VBRX57Egfwe865OhQGye9nd4f8zfg8JvDDJKj5Ovg0xrvrO9AXGU9L
         RQMZm3jUZb+hi7xRIBGoadLbbmuZuIDbUaYlqvqkPeeBi6spbR5Uj1syW00bQccXHmky
         V8qNd8PNCWyGueq8YgJVCGTQ4S8FV8coYsrU3e22UyRDQeBKvNZYPhyyAgtzeBAhX09Y
         il5HjmLKMdkOzZwIuSWHLzBRp5NtbPhnr1KXDaRTuV6wVVFc6X9JL4ZUU18k4V50oCGU
         QJZIYbalj0uuSm7wKZy4NnNeD1s64ddY9S9Q2MTlja0FHYSffOpGfI4WHy3rDXZn6o5k
         ZMCw==
X-Forwarded-Encrypted: i=1; AKwUvByhy6Rg5TDW1rtzm4Mg6PYmn8ie2sw5hoXc+pld1Zm7JyTSwvF5X0DdkJnAlM+0JlZ+2enyB8I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxiyXWv7wA9hnoWC/KV+EPyKv+IEv5hPMZ/Q3SbU414XbPnpB8
	bpctR6Udegu3g4ktvvqyxkrZ6IRfMIPzZhFkMNis17UeXX7o3VhaO7ka5hl6xvFl6uej8Vy2MuX
	8mJ9DSRblzrFQkeTgK9BJjQiZZVh8w7HNFaAbUUe9mchnkAy3ZtiS2kwrM+Jp5vJIoAUzv2rW3w
	uwt3cDi2C8mDVQQtSblWtjuEiRDIb8KmvoFfyZ7GwP
X-Gm-Gg: AYBFou3HGAuN5o6RaO3JaK3h0obu15Ht4bBVLaVnluRLiwDbDEgjiZIEvKsOP2pe8XH
	n/fJkPw2FhS+X46nizhNH9biJsiFKXjsG762jnbe35dN2wJ2+gZzmin6CWFbZC4xwJRcvEVJX7j
	FuIUgULpBmtwhuH/14JlR5AW1kN53fnMFzp68Gl/qzK4nEUv9aORDqIhnL5A3IujxeKGKNdllxM
	6f1hbJ0EeH+7voQozQ3t7/CTHNmShlncSWTwpevh0z1qawXrC3rd3EFoYm1MeMLbhYpHtJZJNt+
	fLIZu/PabX34XPP1JD5C3UbuEg+iiBMxYtsYDnq1lor9EIlB6GFbfw/dlNKPvrAyjmssY/M6ThA
	FVHtzWcZb1ii4ZneWDlUKX0DE1CcFbQ==
X-Received: by 2002:a05:600c:6099:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4a359c9a82cmr2965955e9.27.1792779466589;
        Fri, 23 Oct 2026 11:17:46 -0700 (PDT)
X-Received: by 2002:a05:600c:6099:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4a359c9a82cmr2965665e9.27.1792779466176;
        Fri, 23 Oct 2026 11:17:46 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a03654fsm27225e9.2.2026.10.23.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:17:45 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jiri
 Benc <jbenc@redhat.com>,  Pravin Shelar <pshelar@ovn.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Victor Nogueira <victor@mojatatu.com>,
  dev@openvswitch.org,  stable@vger.kernel.org
Subject: Re: [PATCH net v2 6/6] net: openvswitch: ensure a linear inner
 Ethernet header on NSH pop
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-6@mojatatu.com> (Jamal Hadi
	Salim's message of "Fri, 23 Oct 2026 07:59:21 -0400")
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-6@mojatatu.com>
Date: Fri, 23 Oct 2026 14:17:42 -0400
Message-ID: <f7tse1ws2m1.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
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
> pop_nsh() restores MAC_PROTO_ETHERNET when the popped NSH next-protocol
> is TUN_P_ETHERNET, but nsh_pop() only guarantees that the NSH header is
> in the linear area.  When the inner Ethernet header sits in a page
> fragment, the datapath then claims an Ethernet header it cannot access
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
> internal port up with MTU 9000.  Install a flow matching an Ethernet/NSH
> packet with a 24-byte MD1 header whose next-protocol is TUN_P_ETHERNET,
> and actions pop_eth, pop_nsh, output to the local port.  With
> CAP_NET_RAW, send a 4148-byte AF_PACKET/SOCK_RAW frame containing outer
> Ethernet, the NSH header, inner Ethernet and 4096 payload bytes.  The
> two pops consume the linear headers and expose the inner Ethernet header
> in page fragments.
>
> The fix:
> Pull the inner Ethernet header into the linear area before restoring
> MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
> producer fix in the previous patch.
>
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
> Cc: stable@vger.kernel.org
> Reviewed-by: Jiri Benc <jbenc@redhat.com>
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

Reviweed-by: Aaron Conole <aconole@redhat.com>

