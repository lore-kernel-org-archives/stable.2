Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616034;
	b=TjkFjSZHR5DHDiqK//GTa+RasXj62HlJthOfhZQY3LU0qDhiCYMs/Z1fDmRDeJyGIRmJ
	 q0YV0dm1wVZfytRZtXcopEbzf72LUPqX4sNJ2X7aHEE5ymRqZLq3/qF0WBMFClazOundP
	 WcNsLiFR659MdVJlTADPih+qVukGr6sZABgYQSFGeuZ53BtndQJI8TNwsPGwwWSY2ya1c
	 Y5ihl0pnLj2h3mSoGwF2GbwMkv10qqUF7uoAOPVTnQija7zQU29n+HkFArP37GtNkeYrn
	 rWFPQaku6zSpe5ZGMnsWmuUYX5UTg1tP9KDkn6ul+MjSL84upyjbuNiqlKxrZ/Nwa9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616034;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
	b=bzHRxLRwtfaKbwsMtqhfNQrEyHHkft8J3L73yYxIsiyX3ViaDvJ74DTY4ResNtu1CfUQ
	 ARH2TEUv7uQZyHBasvy922I6VNW3kBNhCcglRkrJEL2MEatQtWxicitTBUbCsbihLLCLh
	 6sqMFm9DA546io5Phos43em6jyDuT9QqHRcL2DKupnPC3aXWQOAwlz6JNKX4aHYsZUrU5
	 yrwG5TdurVjt++kSoxxY/SwAV/4OktDTWx/a35Js8ZoegIsgqDLA/T4RoDV+/1o6FT4WP
	 EnIMJ9JtSYdWarsaE2i2ikn7p8RAQAmZSfup+YBvvK+21udbihkY6ZZkT5HamUfX7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="g4/1sJl0";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jfWxIkgm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F011606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F011606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g4/1sJl0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jfWxIkgm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793616028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
	b=g4/1sJl04mZi22zDxxa2ljWMdyrunRKN9xX4G2zShsqjlKCSmK8Gw136sCxEqm5dEeUvT0
	loFF6QpcHZASWwTxt4YEQB5nvXuufpmNiw7AvwSN+S59TnNjNbLE0H+wus+eF+P+cnsK/V
	jmr908306g0U7F9PWB+3ueT6r67BWic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Cw8o-3M8NGmeo-XJZ-qpyQ-1; Mon, 02 Nov 2026 05:40:26 -0500
X-MC-Unique: Cw8o-3M8NGmeo-XJZ-qpyQ-1
X-Mimecast-MFC-AGG-ID: Cw8o-3M8NGmeo-XJZ-qpyQ_1793616025
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c4445512dso2407584f8f.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793616025; x=1794220825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
        b=jfWxIkgmx+p0GWeBUL6kyI1wktmaQ20NM6B6cw2s9Mo2CmnM72HFmQL+HNFibfMfcW
         kAGsibMB9o7m34VfvLL6xBZn+jrQ134pr03AwOIIp+MApG3MewIqAEVJ85a7G/G83f9A
         EMTckJkMovjFcpnFomuYoi8h6QP1MgJjQ96EgLeV8sQeHzIuHxkOOSTNXbf1Ob1bQHuh
         oE4ixHa2uegFSDp8IWFM+Q22BubIMiF2L6i0yKTaLhK7dXWEE/8JAw10BLSeWKTL59db
         cmgpOb3e+RuaLmZjU8S0wY6gWPSOu8F7VpwaKfDjHSJg3tuNalFRAxmvNwQNCsizH8hn
         1xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616025; x=1794220825;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1te04bf//E5SpRzi7/p3EXRLBCHHr4nOp8CWHAZHHok=;
        b=cXeUb6mJPWAxk4vOUKFxvy1POqbm13YNbciNG50SIDUko6Lk/UkUYQYwFoxB5aARIl
         2oEMsYlHSzjsivn5YF0HF8UqiRTtAdU7vqoIwe095RhP3qEt36QosiBBRwXP4W9SuLpb
         VL6fZwWTjec90FuevKFajq0NdF7l/qKgZXYavy9AmeIqbkW2ivs0bIjI3WHgosiredBh
         PWyjak9FXHZpb38B25GOup60IvzpuVdE3hpz5g7GnDVO6QMIgChY3VtZ7bHxhxquJ2Jk
         aLVM9jxme0+5KfzT6cq+Hn7E/VoqsU4PZPnJeiOwHPEJss5YqNZqYdc29+wMorlmHn4p
         +mdA==
X-Gm-Message-State: AFq9FYK6PeRyXQknn3csZbIYP4nZLnt3JHDeHth6TIQEKKkJGnAurlv0
	7keb7ZGf+Od86lfkQ6nW1RGc3ikBBeB8qNDZJQciuhstBiimW8QcLH6fuVZsSF87n7Qc55MsAtX
	2a9xWJssjHlIRauilY/eINJ/P43gwj7hPkvIwU3FSEmLBiDmVrs1Lu3k4qw==
X-Gm-Gg: AYBFou0U+cZEXMv1LhJGjOMrVIlrVzfFtsLd2UwVeabg8EJ7QJf7T+bSd5dXaLdJQBy
	yKdWE8u9nl7XO+n80Zq13RyafEgR4ntbsHoHQnAg43nV5+nhptDVke8rdrUJdF10UwmvpRWWOUm
	2nSyN8xHwhTyQ1OFuJYbS26JrK0feXi7yMCp044GYkUhqYyrW1cXlwK+COx61O8yDuss25JYN+6
	EZzZTeEPK9MwpQSLNlywy2WrKAwe2oVrWjeMsZpf7s88+ddQnjfhUtR+zzykctFKOc1XIQDRmdR
	5rbSy3g5MKzbdGVFbUi0comGTF/fzTE0fQQaewyXI4tz2DHwWBB2fLJcqnermBKpv6/PZA8JC7o
	2ENLRtEpOj2iujEFJ4/FOI0X80saOal1rbefeTdSkAyqc625paV/DH615xZ5QxLGiAg9rXQQX67
	AWWLMAMGRp4nlnzUv3FUEM+PAyxeuTf4smq9a/ptskzbk=
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4ac18a8911amr223282115e9.34.1793616025375;
        Mon, 02 Nov 2026 02:40:25 -0800 (PST)
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4ac18a8911amr223281775e9.34.1793616024956;
        Mon, 02 Nov 2026 02:40:24 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf7146621sm267462905e9.13.2026.11.02.02.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:40:24 -0800 (PST)
Message-ID: <924ed39e-5298-4ac9-a5a9-12c6427ab281@redhat.com>
Date: Mon, 2 Nov 2026 11:40:23 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] hdlc_cisco/hdlc_fr: shut down protocol timers on
 ->detach
To: Chengyu Liu <19290937@qq.com>, khc@pm.waw.pl, netdev@vger.kernel.org
Cc: stable@vger.kernel.org
References: <tencent_83B7D10D4DBCC6118AB6F6B83A509FFA5C06@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_83B7D10D4DBCC6118AB6F6B83A509FFA5C06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 04:23, Chengyu Liu wrote:
> This is the same defect class as CVE-2026-63803 ("hdlc_ppp: sync
> per-proto timers before freeing hdlc state").  That fix added
> ppp_timer_release() as ppp's ->detach; cisco and fr have the same hole:
> 
>   * hdlc_cisco: cisco_start() arms st->timer unconditionally and
>     cisco_timer() re-arms itself.  The proto has no ->detach at all.
> 
>   * hdlc_fr: ->detach = fr_destroy() tears down the PVC list but never
>     touches the LMI timer armed by fr_start() when LMI is enabled.
As per Linus's guidance, this is net-next material and should not
include CC: stable. (note: the reference change landed before such
guidance).

The above usually does not require a repost, but for some reasons
this series has not been processed by the nipa sashiko instance.

Please repost for net-next (retaining the fixes tag). The new
revision should land in a new thread.

/P

