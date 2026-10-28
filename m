Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190002;
	b=q5qEOGV26F8wyjHGjTEAncobLGYxY7rF4pBeJ3mqYwZjd/V+HDeFpPHiT1+xzLoBqXRc
	 wI3axrQeG/Ac1bW3QMj3FSSxkmv6HARrcKrN+QtkMiaMj+5oKGNrUVwiMM3dL23OjkYjq
	 0i8RXff71PdiMSqaM2flARqpjN+T3K8xmYP3gm4kLd3uvWD4gmkPYTRbB2OsjqJdR9dxN
	 GIoYgwg7iB6H4qqJLaAUwmZX1RtwpFHW+kZ46AtlVEPrvwq62luQMpkPZxTg7qUhEPQqD
	 QB8Os6R9tweUrTOOjiGaP+wj541myTn0G+OlQqGw+k8NxPLZ6+9mr2LP/01kIjdLZGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5kFTJIpUf1QkGirssQOcC5z5ijwGWiYcRSbJt3q3HL8=;
	b=faClXTY5I4LToJWTol4PAeVmg/awWNwGwtKyPtdDg8YbQG8KHeK9AVBFcWdpOgocGVq3
	 fQROTLS5XwPYsRmRejKFPuGfoOJcKoPLvQ/Yir+O02K6coYnx/nw2B5bWPCHmyQAZRELi
	 cGVLZJaMnsK9ihzD/XkvcufL1WdG4GNwEQOnfwFdzekf98o9Y5PwVtAPeqjikLAygfIKR
	 8cHgeIxTGNmmz3p+ucmuOO3YpfnuHTLl0nYM7sQauu9idwr//8yWQTAodBMQ+8j84TkgM
	 Rm6zueieiCRGWIOwY4yI9wBvHsC9WlGpvD8vf18bVyRSLA9fJ3schmYBLlSrhHeclxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxjgtRID;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC1606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 12:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxjgtRID
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8871ada1a26so6571627b3.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793190001; x=1793794801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5kFTJIpUf1QkGirssQOcC5z5ijwGWiYcRSbJt3q3HL8=;
        b=yxjgtRIDQCo9PH+S550/uh92/aLIYneEcVSaL9nGavFETMpzrtM/nsozyghZTKg5dJ
         s9dXy4lX58bNF5rPb+hYu2kUKc6EJ8XIkp6OLVuHpSdAyxs4PUTWFbuCXxQSZ2PUAJaj
         r3Q1x//CszCJUHffp8s2JiDjyRA81nZrxZp7IHO9P26IBVvpPDbIplH9IML4RloQ65gV
         WxiZuoxyyJw+hQ8A5/7M6j61IZe4CMSnM69YjljceYl0fsl6G0HUQ6XEIFzdHdNmChea
         c67f7ZsMdRrd0oUtDNXVI5Q6c5riGHZRuIdXoJfEBkG+/6rqGJunDyuiy0NB2oJF6N/P
         J5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793190001; x=1793794801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kFTJIpUf1QkGirssQOcC5z5ijwGWiYcRSbJt3q3HL8=;
        b=wLCNn6G2+WDNDMQZLPUy9eMdHmlcgTQnMmIOIyDaT/pEHPbE9D4wFlyka6p3SsbrRt
         83vU7ft7mzKwQutyvyDlbXuOp0892+EvC2f8kUWcke0hZI71Brm1Qr4XGwQulvT5cvuG
         dBiKu+zsayzEoHT5R5+mJQLGIytfPqhTKSzpO0OQdY/m5YqrLnPfVP1Hb2GVMXVOJb8Z
         z/7/tpUX0MSyXkRa/XyQpyPFGzz3zUdVNlc8G3ShTtv1zhT4qyAb5ew0VRDj9BixP0WH
         GqBSqUkhKzKp4N2rMpgzWiSJfTRrhFn63vaT5hWw1BasCVPlP7knuV0+aF5SZ+EpLv5Q
         sllA==
X-Forwarded-Encrypted: i=1; AKwUvBxC1t+TImUhlm7dHyhwtYgyAOW07jyAao+GzHU7ZkyfFqElYGSJeDhLxgr/QNNpsE8BCMtlqKw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJs059V/pYf4o+TZWBD1R7KE8lKj9sx9AnACaML6JMhX60QMscj
	wi+gCsOOTDQy84XaLwMKG+18n+hTKI4TiB5yJFpnHLfvl2YtpCVk5TAe
X-Gm-Gg: AYBFou3wmz+jGn1SHTcgC5kH/lKqb6g+0WhPWM2ss/sQ4grPvU0kmSDYDNkiM4bC/x7
	tLkDX+1iDbXTWaRFu+WCxRFonVoiv4fCXmGVZ48FFPxAJQD6DCh5YYODhJ1aVEuAFacXJPccjsk
	bcKfd9dLnRAGlf9H6g86Qk0qbsAtHGn9kG0RLbf8hFb4EchGE3o6smdOpTcO8iaW5I5eNhLllq0
	huJyoEAOrQMq23ETmXK7xK+RdWD3EILkp9cuTVSaBUsN0TWuHr/oBPy/uaAiUCc1wKbEMpwmP1c
	MW1bK2+Q8ADa9h9JGwgqE391KB7jDofl+sx8hDBj1pbU1Y+AfX1HYXYbmMUuDQ4VduEnaXZcAME
	+4VvziQN6HrQ1adh3JfGmMGuZMUg7e8yOsG64kd4Dkp5iT9Bu1PTUWiFugs2mogZkoF3+JpYyTi
	dV34ygZyBiogZgzUFklD3f4MZv9sTdtOu1mR9IX8XIMZ1Ktxi6Qz0AhWSkRi4Wvs4hDC+W5jkAo
	IUTWpoe3u8IhF3bREgyMg3du1BJgePgaKYSlNe1dMGQ5azn/b+Fhh3XrveDeTvmE4XEpNKC46+R
	itf3jLInN5jbPUZgGlweiPjX9dloMQrltcE=
X-Received: by 2002:a05:690c:dd4:b0:87f:cfa:3db1 with SMTP id 00721157ae682-8b1b5bf286emr12448807b3.39.1793190000802;
        Wed, 28 Oct 2026 05:20:00 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e6198e2sm25691377b3.38.2026.10.28.05.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:20:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:19:53 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kuen-Han Tsai <khtsai@google.com>, Sonali Pradhan <sonalipradhan@google.com>, 
	Kees Cook <kees@kernel.org>, Felipe Balbi <balbi@ti.com>, Jim Baxter <jim_baxter@mentor.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_ncm: restart the TX timer if the TX
 freelist is empty
Message-ID: <75snoennvklw3l7zuwighfx5f2crthf3l2zyaufhalbcu2uyot@kw5gnvof257p>
References: <20260817192638.437798-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817192638.437798-1-cosmin-gabriel.tanislav.xa@renesas.com>

On Mon, Aug 17, 2026 at 10:26:38PM +0300, Cosmin Tanislav wrote:
> ncm_wrap_ntb() aggregates datagrams into a pending NTB, which is sent
> either when it becomes full, or after 300us since the NTB was started,
> using ndo_start_xmit() (eth_start_xmit()).
> 
> ndo_start_xmit() returns NETDEV_TX_BUSY when the TX freelist is empty.
> 
> For regular packets this is fine since the networking core will requeue
> them, but for timer-flushed packets there is no logic to handle this
> situation, and HRTIMER_NORESTART is returned from ncm_tx_timeout()
> without checking eth_start_xmit()'s return value.
> 
> Under sustained TX saturation the request freelist is empty most of the
> time. Since the timer is never restarted, small packets keep getting
> accumulated into the NTB, until either TX_MAX_NUM_DPE packets are stored
> or NTB_DEFAULT_IN_SIZE is reached, which is an unknown amount of time.
> 
> Check the return value of ndo_start_xmit() and restart the timer after
> another 300us.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6d3865f9d41f ("usb: gadget: NCM: Add transmit multi-frame.")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---

Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Reported-by: Hiago De Franco <hiago.franco@toradex.com>
Closes: https://lore.kernel.org/all/20231204183751.64202-1-hiagofranco@gmail.com/
