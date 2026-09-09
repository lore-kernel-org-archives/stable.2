Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23156C62D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967948; cv=none; b=gkhokuZZndjEa2MSAJtGuuFMlCCvgZPv/fBc/VnAY9P6eU6qtgkdO+BgNXluUPx5abuyX0SmMOWhxspLWi/XZ6JXH19BfTdAn5szL8HSof9FHjSjs/zXI6s0I76YS2bIMKMAvyw5PJVxQYUYtW+oxdkWtuaZLsOh5w4Kh29tbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967948; c=relaxed/simple;
	bh=14M4ZYjhJX3O4zggMzrZLFQTOxB+Uxhxu4feVRw12CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuUOHBbQadXNpGCu37pkhfyENqDB1shwLT3fhrggdbWbLe4LYOJ0ybUot6E9lzbn2M1SbibD3A4TH7Chou5Rh4gi1rqDNF1Gu5hpSDA3tzSr/00xKw7RYz+I1FfEKCvs6Vad6mK7mtZbFodDoM6ed8NivOGianAaLXdX5h4M7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ew0xP6cZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=diKHtcR/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew0xP6cZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="diKHtcR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788967945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
	b=Ew0xP6cZLUqrbliDhTFDAhc7hnONzmwrkjvEOiiN7FgSgae+OenEB1oaZR0mSVbSIzgbpa
	ww6jFTX8hRlF/gPcjwW3dSWbHxq/zl/8CIABSNtPziECAWwkeEePJKwZguSlv5E80tZghe
	rkuOeFKOIbwfy9SfAz+QQU/ARPxFjbo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-BWl8v_Q5O72IFO752GohAQ-1; Wed, 09 Sep 2026 11:32:24 -0400
X-MC-Unique: BWl8v_Q5O72IFO752GohAQ-1
X-Mimecast-MFC-AGG-ID: BWl8v_Q5O72IFO752GohAQ_1788967943
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f4bff865cso3727359f8f.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788967943; x=1789572743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
        b=diKHtcR/NHiTms1Za6NNJsncNwGVUYzibjr/rDoZwvpG0UyhJSBQ2vfLgu3rZf2k7K
         kUmu4LttTzGBI+o4A6kjmh9WvW56cEAmU8QvBUx3TM6yWOGECM1hk833H90I9fiw+XyY
         PH4mW3mn7hXykmsLOrNqgtsdrvKeRPi+qy2sanlNG9Rcq5Owqp3LpOizDQW5t/1P+5ak
         fibZIlHvkKdo59pOZY84ZFloIABbzwFzMuiCyGwePbXyUJ+9fOeBU8vTrMLe4yWZ/UpS
         KbcOou5PmbXDcDsk5OyeG7V0k3+EdZE2hgpYPnTys2ydXQfvaT2fjyy2X1+Sssheejhe
         rX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967943; x=1789572743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
        b=hRBhWsU7JhVDsqfy1nSbPRtHjifn7dzwq2bPlEuCySBw6R6L+DB0VGkXZrovTpW7NT
         Y3RqY8RuNZolKbCdAplrQuo/Lfmk/OLoKK5aLc0YkSKW3yXxpmqwh8bv2S9DbWWBpdYM
         Ead0ZM6+nZOHr+AONL9ovAT9a0yItTNmrz723JCqW7egHmhoIXyFRFjm2Ag8kLkHo2wb
         W7bTTa2vYpKqKa0Yp5lj8mcYLKpMhlrvnnzVcLFZkQkpKXTVjSicdr6C+Eit2YrTrQff
         X99b8z3mUT2PnAF/ELGlm/srTEQaxUlMVX+DTg8drgm9nZWHUuHYhdIOCZHsUTfB/4OE
         U2+A==
X-Forwarded-Encrypted: i=1; AKwUvBzuVYLI7TjiJp5fC/NSC9nr1OLMGDHkAvKq6kG7iFg4qbxe38Xk2vdwBWOVLBDC3bjIid+VHf8=@vger.kernel.org
X-Gm-Message-State: AFuF++llrwBwoSNaYXgCUt5wWKhdylRducEuJDY/BfNKG0j8zIVc5RJP
	E2TqXfWQgcLoJRwAzCZAyylV8Vl5cWxmDPA9DLmaPiAyzDbMojzSdJ+ePM6Gbjse35YfJU6ZNbJ
	uceTDZ95TIEseYEakwpa2uJcQk3LsP/T31KpET4yAgp5FEqJR1Z6NyFk82Q==
X-Gm-Gg: AYBFou2MHmgo3Htb3jCmlax3y1cluWVWDZfsTGFE858E2X8jgN7bQKBzSzzxFRnNjtY
	NfBV2Ew4hq2n8SUiYCnMUXIi9JMOMg17zEKn8D9Buk21a3xtfx1Qe/rlSNHOekWQdhPClHtcAgW
	uCZ+XD+tEewdFXl28PPdUKNRj55pL8OD0d7N6tENpwFOAyKA6nRJDPfS4mIl7poRuqN4M8DwnSh
	GUsJy3YKYMC0Zg4ASx8yhjrjn7L/zMl2YwRkrtFzxZj39H9A36AJDsBIAlAucB8YcgWJNBcX52M
	k6t6Ljv/UwtJ2nyJlYbWQ+ERDRSYEq8cPsDn1UWKbsC8eBDSjR/5skOMlS4jjbEC2DI0SdqqBd+
	OWAw9pQ3DMPrY+Us0/lx50NTvQ+uT/sktrVaGqWGddq3h3FSY9dIniaPllcYat06W92ZWvVIBKQ
	==
X-Received: by 2002:a05:6000:40ce:b0:484:3310:710e with SMTP id ffacd0b85a97d-485aae0e2dbmr12699312f8f.26.1788967940508;
        Wed, 09 Sep 2026 08:32:20 -0700 (PDT)
X-Received: by 2002:a05:6000:40ce:b0:484:3310:710e with SMTP id ffacd0b85a97d-485aae0e2dbmr12698537f8f.26.1788967936909;
        Wed, 09 Sep 2026 08:32:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm44398592f8f.14.2026.09.09.08.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:32:14 -0700 (PDT)
Message-ID: <7cef8694-2abf-4ba1-9bda-2bb8594140f9@redhat.com>
Date: Wed, 9 Sep 2026 17:32:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 01/15] mptcp: do not reschedule the RTX timer for
 fallback sockets
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-1-df1de70348b6@kernel.org>
 <178896537258.219967.9085177988970978054@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537258.219967.9085177988970978054@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
>> @@ -4141,6 +4146,7 @@ static int mptcp_connect(struct sock *sk,
struct sockaddr_unsized *uaddr,
>>  	if (IS_ERR(ssk))
>>  		return PTR_ERR(ssk);
>>
>> +	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
>>  	mptcp_set_state(sk, TCP_SYN_SENT);
>>  	subflow = mptcp_subflow_ctx(ssk);
>
> [Severity: Medium]
> Can this set_bit() re-enable the RTX timer on a msk that is already in
> fallback?  It runs unconditionally, before any of the fallback checks
> below it, and the fallback state is sticky across a failed connect().

This is an unrelated/different issue: when (mptcp_)connect() fails early
it returns a TCP_CLOSE/SS_DISCONNECTED socket but the status is not
fully cleared. Should be handled with a follow-up/unrelated series

> Would gating the set_bit() on !__mptcp_check_fallback(msk), or moving
> it below the early-fallback checks, close this case and also make the
> new comment "Prevent rescheduling on close and in case of fallback"
> hold for a msk whose fallback predates the current connect()?

FTR, I can be low of coffee, but the above suggestion is crazy wrong.

/P

