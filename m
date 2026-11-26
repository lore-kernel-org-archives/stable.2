Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684465;
	b=NRnxHeGdI1WF5yi0cX+EpPS3/ObJDwnQYmGCCJaYHFDOxmyJkZm7A7smf/asDqLHV6OP
	 gTiViN5sKjyYTf9CewEadPGdBujQsV4HpA27RQjhscT8JsIGB7Y1dvflpZrNOeomHcYFD
	 NKA7shfyEmv/W9A1KKRhtCLRS1VZ13Pgb6hzbJPaVR2rmGriqisXiB2fNCB5WqzH/31kI
	 eGDeHTvjnb2vy4exIy9s8lUYmJmTDJpGocRJd3DiwUCvTEpso6dljMV3ovSYjeU2oL3LZ
	 EQ4bU/BZQ4jCywrttm5DrMEsAjp3+iaSLpnrw+mA/87Gbg0PUV01iRbShylrZmgFNIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684465;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Uv90ZkLhbhexSdeTuLHraZLQFBYDHiLicEO9C0xVaHE=;
	b=UuZUA19bJhNjhaB0HHt2d0YGIMAfoBcxy/eaMR0IAFotUTiJKgXsRdq029GwyU7GyWhD
	 3nOEMNE55UtvIJ6YyZWNoluHpSfjr6QKvtMLy8QE+4MxG0MAqwgoi44KGlaVlG+qVqeGF
	 MRNvaPirO0tlhxc5+E9xMKrs0A4KxqOjRHCxcTI2iO3/vEZ8b/KEN+MvVQRHRZiOUIJ9/
	 kZUNMB1jp7D53IkLqCtte5+u1DPbd+u3v9zqYDvCLEAb5CoM4vljhnVpQPadUaLx75oBv
	 Ult8abrJIaSeAFqrrgToGt6eHCn2U0tfmlyK2B/OitY0DotlK97FMrsleE6BbId5flQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WhQ/0Pd7";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0E606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD0E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WhQ/0Pd7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795684463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uv90ZkLhbhexSdeTuLHraZLQFBYDHiLicEO9C0xVaHE=;
	b=WhQ/0Pd7NMJbvfRLgo+X5hRfPY6fvgTGc7WEydMn9d411GsTl34vbDZBU5eEFDjeFBaygM
	hMOrZQzYZGV75WUOGVBvsYBQcogWlNZ+reIFZrlC+AHj7t+CLxCm693iLylU4yWlUuxmwr
	XmkGJ3mVhEOFV8h9KmolSRtFQL73fN0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-SRTgTkmRNCiECG4PoQZlmA-1; Thu,
 26 Nov 2026 09:14:19 +0000
X-MC-Unique: SRTgTkmRNCiECG4PoQZlmA-1
X-Mimecast-MFC-AGG-ID: SRTgTkmRNCiECG4PoQZlmA_1795684457
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBF831800549;
	Thu, 26 Nov 2026 09:14:16 +0000 (UTC)
Received: from jbenc-thinkpadp1gen4i.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80C843000229;
	Thu, 26 Nov 2026 09:14:12 +0000 (UTC)
Date: Thu, 26 Nov 2026 10:14:10 +0100
From: Jiri Benc <jbenc@redhat.com>
To: Lin Jiapeng <ljp1205831794@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, Lin Jiapeng <jiapenglin@tencent.com>,
 stable@vger.kernel.org, TencentOS Corvus AI <corvus@tencent.com>
Subject: Re: [PATCH net] openvswitch: reject negative L2 length in
 ovs_fragment()
Message-ID: <20261126101410.4a310394@jbenc-thinkpadp1gen4i.rmtcz.csb>
In-Reply-To: <20261126083218.55429-1-ljp1205831794@gmail.com>
References: <20261126083218.55429-1-ljp1205831794@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, 26 Nov 2026 16:31:41 +0800, Lin Jiapeng wrote:
> From: Lin Jiapeng <jiapenglin@tencent.com>
> 
> ovs_fragment() refragments MPLS packets from their inner network header
> and saves the L2 header in a MAX_L2_LEN-byte buffer before fragmenting.
> 
> POP_MPLS can leave inner_network_header behind skb->data. The signed
> offset is then negative and passes the "> MAX_L2_LEN" check, so
> prepare_frag() widens it to 0xfffffffc for memcpy() into l2_data. An
> unprivileged user can trigger this on both IPv4 and IPv6 paths. KASAN
> reports:
>      BUG: KASAN: slab-out-of-bounds in prepare_frag+0x3c2/0x4c0
>      Read of size 4294967292 at addr ff110001059cf044 by task
>      ovs_frag_trigge/132
>      __asan_memcpy+0x23/0x60
>      prepare_frag+0x3c2/0x4c0
>      ovs_fragment+0x578/0x860
> 
> Reject a negative offset together with an oversized one and drop the
> packet through OVS_DROP_FRAG_L2_TOO_LONG. Valid offsets are unchanged.

This was supposed to be fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78a86d75a70e1e227711c72865c59b1422d0a5ae

What kernel did you reproduce this on?

 Jiri

