Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015522;
	b=MH76wnaKgeriU5FesrqoVHabZ7fHitA6E8U5lC86awhl9YfxnqsMW6GP/+lT1juopj0n
	 QJ3CNXNIxnZv849hbQY4R6p+YMH2W1auYlLo5lxwGvRIr3U2njKbxHpqiXT5/maUfI9yD
	 SK5Ad53uFAPQOy5dwQyxaSXu6/EINEgZSv6ja3UizAaf8wLMslbAAjegp8XKzUuaXUkwa
	 Vr0X2OYDPRPOaP7sb9sQYOnbgxt6jUHhVjIWt+7f29D/VPH5JoE+msBDGVXKfMkHcv1eH
	 w7d5eMVSw8+86JEIWKXLCtnw1ZwlcUMDb2J+5QYu6pxUwepzKVS5MW62sqPrqcGj1lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
	b=WNnuFwV2BmEzPz/Ak8jW5hk1dcZQu9ct1xzXpcaZKZEEupbxKNwKDK7UzAR/uhOk4hx2
	 bHSCpFjTir2Nu94H2+FOztUlzJ/+lt7WIR4X6LrdGoG6N7UnidWDkRzHHRdTF3T3Dpnil
	 Yr6ls2232LL8MJ4E0oNg9+r/efSP/DWsGHRsxJ/kvhA3xvF502SiUJ3+qpH6NDKj0z2/0
	 O/sEJ4YualXdNJ/dHBh5I/SEsmIZm6XdEU0uHJRsI7DpIH2VLAajHK8KZmOXuKjqDH+Ng
	 jRNpYRh1RFmUwu/1we5jndfkmNZ3GeC1NIa81VReajpLuBHgk48741awBZpV7bH1bOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="B41kM/TU";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eWGZbKAX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34727606A330
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34727606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B41kM/TU;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eWGZbKAX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793015520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
	b=B41kM/TUVn5dYi8/qPNRjW7bniAlyCRppbqCTwBMrsqwGHzcqO0tpCBv9wmvdFw/5QSLFB
	xM1Jlpz2cggrqn7pEbKyLeJKuUOqI/XXGLC3HvZLUPu4vV1tt7lHFc5uIl5IptzBG9pMd8
	jsnGIUCpG2JCSFPhzF+UWkv5iX1+ocI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-3PoJB86xMuS1j5RWQ9OSvw-1; Mon, 26 Oct 2026 07:51:59 -0400
X-MC-Unique: 3PoJB86xMuS1j5RWQ9OSvw-1
X-Mimecast-MFC-AGG-ID: 3PoJB86xMuS1j5RWQ9OSvw_1793015518
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0c896d05so2718015f8f.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793015518; x=1793620318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
        b=eWGZbKAXg6voSdVmFRNeRAVajxhVFt4Xje6r63u2FAH4GZOY5WZmkSaSxDO33Yik/9
         H5S2RrBbfLkpsjyZglrOmr/XBmEm0WK/7HpoLz6pIqhdvWTOQ8NoE7UZttwhgoPy1iJD
         W/ApLnfesP2NSz9ni8jsN5QUuexQTfnwduwbVIVClF6mTxs/lXow+zrQphJpg7KrbZt+
         yanZ2SDWfod3m05BGsnPn/p5CcgH7z9r9Lny4gy7IXMcG8RURTTkAtZsPcVIZuByRWWN
         0SfympnV6Dcd21ixn52mfJ2gL5Xgrr0cftJnA7V0pUKHaKKNQMjW8tSQC++9/LFCsZEM
         3gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015518; x=1793620318;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
        b=grvXEEMHfLNNUYTfPFOodLYj9qZblkTbUJYEzlsOfzpL5zTBpLKopDavcx5tEN2PRj
         tKFJjVrEs7NtVJWYkuWuMR5F5nca4MZz7QH2w0Z6/bwwnDC9wUDJyo2Ss9fuKc3ql1A2
         iLMNSntlLtlFqiSPMtg4pRo/JjqJ/NI9g9S3aWTZ/Sx7PCIHiyujEG4Qjw4IqK8hdeWx
         FYdl9cNj4QMHaJAcAuuqeohcyUHz15aJdVdH4qW9ACMS04IOr/FhgbrRWf15Zt9x3RvR
         Ym9x4ZjTAXqglXwvi4Tug+G3h5ld+/6nfaEzzv42aZP9ePFlODCIWywNwwRaKvQqNqJQ
         IpAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfR23o+TRxn3Lv061cDFcvfU/9lywlReCYxw+zGlg5w/gS168X0RgqJ8SlnquVjP3txv7m4c4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXSd25w+7k/ImEHWdRQO4g/vEKVys5DTfO6GuWCLd8MuJjx+Qq
	78IWyZtG3uWqq80AN4w21gO0iMfykVTxqy+tOvTZa0/CpZ361Xw5c4bLFpotuBIu+xEn3LLl5p7
	mc8vGyW85rnqUPy3LYWp3egwaNXZYKgQpK4R7X7dfw4zbljVhBbOSC3zQEA==
X-Gm-Gg: AYBFou1EiFlnFpPC6YStf3FIAGBEI2x3YVqKOwyyf/Iv8Vpf2X84Wq5HyBfF3R8a6hp
	XRGm50jqPkNVUP49DDGuqIBTJsdTUcR+WBQfHfOce4xSTPusP6vCWy5xDwkpt+jJvy5LbeV6fvD
	Xv2AyUKgeG9dc2ybB9lt5s7Tgpk3W9as5qnLIBPRf/Nzj54orJEU1zqJhtSc12aV5EQmji2K/4Y
	4yyXFfuNN2nBy1grgwv7BZchOnLO9KwvTeBGiwK/StknureYXAwMvzFKUix6FtTc4CqlUAZSzgH
	PahTHCO9oQV7T0fC5UP42XwGwdo6QVvbJJvRBd+UU+rWBF+AIh8WRNe179+sFpywnrKLzVLeLr7
	mvurrnLv6446aA3j6SxczOlugdsJH+WwrhwjuvHHVEYdPJM6vj4O8KQ==
X-Received: by 2002:a05:6000:430d:b0:48d:ffcb:28e1 with SMTP id ffacd0b85a97d-48e3eb780b0mr11518125f8f.11.1793015517846;
        Mon, 26 Oct 2026 04:51:57 -0700 (PDT)
X-Received: by 2002:a05:6000:430d:b0:48d:ffcb:28e1 with SMTP id ffacd0b85a97d-48e3eb780b0mr11518084f8f.11.1793015517438;
        Mon, 26 Oct 2026 04:51:57 -0700 (PDT)
Received: from debian (2a01cb0580324c0086a938fffe1eee25.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:86a9:38ff:fe1e:ee25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48eesm16004691f8f.30.2026.10.26.04.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:51:56 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:51:54 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	jchapman@katalix.com, tparkin@katalix.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
Message-ID: <at8-2mFyrmPxfu29@debian>
References: <20261025145831.2133617-1-hengyul@cs.unc.edu>
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
In-Reply-To: <20261025145831.2133617-1-hengyul@cs.unc.edu>

On Sun, Oct 25, 2026 at 10:58:31AM -0400, Hengyu Liang wrote:
> @@ -315,10 +315,19 @@ EXPORT_SYMBOL_GPL(l2tp_v2_session_get);
>  struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
>  				      u32 tunnel_id, u32 session_id)
>  {
> +	struct l2tp_session *session;
> +
>  	if (pver == L2TP_HDR_VER_2)
>  		return l2tp_v2_session_get(net, tunnel_id, session_id);
> -	else
> -		return l2tp_v3_session_get(net, sk, session_id);
> +
> +	/* An L2TPv3 session ID that has not collided may be in any tunnel */
> +	session = l2tp_v3_session_get(net, sk, session_id);
> +	if (session && session->tunnel->tunnel_id != tunnel_id) {
> +		l2tp_session_put(session);
> +		return NULL;
> +	}
> +
> +	return session;
>  }

The original code looks correct to me. L2TPv3 sessions, unlike L2TPv2
ones, are global to all tunnels sharing the same socket.

