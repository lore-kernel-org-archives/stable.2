Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967741DED1
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233082; cv=none; b=UeXssGFqu3/plVhsbML0kLAnZU+rbWAwBZi8fwj8GeQvCEhQlnyyuwgaTmxPD9PMaiWXvAc3+mQlZA5zhDNMmJ6jLUBWT3IX3SkHUWxMtodumpDq+wqHhiFRVv2oOmiPuFw4pGjLdu2HtQowOMuOGRLwQysI71w7p/lSNv294Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233082; c=relaxed/simple;
	bh=lNsH6KFl6jXz7cYKHk1mtd5Pe+VMGWPOl92WSI/TU+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYKd8K8ixNs8Cck+XdqSHL5l5ULz/F6E0h1J5OHrSRnsTJzbuV0/OFISGE3xjUbQ3jsnwUIRa4iIzZ3W4qksUXDqDshmE8ZIQvUNRZ1bGL7Iww8E94a4sKf7koXLsYG02G/oOgsiFx5IvjyMWHPazFTznoFCo/2gdaarU2Wuzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZKc9m68; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTURWzXa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZKc9m68";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTURWzXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785233080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jy51T/GGPD8X/iu+8/Zl6g1NCdPj8ghOQ9Vza8iPsx4=;
	b=BZKc9m68DEBcru8uHeQF3gdUPhT3/X7FFrks/k4ozl00br60zOurj7NjAHXEP2D9ItuwP3
	WzcTQT4P9I69RbVawqMBXlfZyTh0hU02qsccEqNBpZXp0UIoZD93C+chQ0gtoBhvAbfqM7
	dnlDNr5rRqRloyHvEGg3vDSpjdI/+5s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-2jkpBgLqO2aO4_cX6nYTKQ-1; Tue, 28 Jul 2026 06:04:36 -0400
X-MC-Unique: 2jkpBgLqO2aO4_cX6nYTKQ-1
X-Mimecast-MFC-AGG-ID: 2jkpBgLqO2aO4_cX6nYTKQ_1785233076
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso2786024f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785233075; x=1785837875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jy51T/GGPD8X/iu+8/Zl6g1NCdPj8ghOQ9Vza8iPsx4=;
        b=eTURWzXa1ShZBevWiSPHZurQ+dNl8gXow14lgw2Npnp5ghz58kbmqJIOmfrc/ZtA5d
         +WQD1bABMSkCA0/PgmWiCYh3+NbICNYz6m6WPjYVHAX9ipeo+DQJ5lShPbwItin5hX8m
         5MmOYyFm+fRCC5jtZyYnN+5oxNR7sm1HN0PdULXxS3Nipzk/Q0yUW+9lMfI0mckz6LFB
         UzVbrcH2hZV8dIRJhRX8rh7I0+52j+3rlmlpx3kurIQJ/EQU9YKp9A5Nx1pde/YhjbIG
         +meCFWatQBANl47S/NW3SxrpMnf032rqvMRZ5WblTgkDEwpl4fXvfSbC4xBDb8r6Vz/i
         sskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785233075; x=1785837875;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jy51T/GGPD8X/iu+8/Zl6g1NCdPj8ghOQ9Vza8iPsx4=;
        b=o3zwI8XvIIJyMYZ2GJkq746/XdNZL6mGcgQz73WFhYZGNWeQ5Q2qijZD9kcqFCt0+5
         fmB9HfOtCAl2Dq/jR7JRBnvd7+so11et7a8zdaSVP98ISclnMOAn6SJQ85HUiHHn/sSO
         bJ+H5XViOQkP5Nduqtr2L5GJnVDingLQ8E2Lm2jq5k9Bwr7DGd7btmgexlkzmWqQnskB
         ZijLxfQ3ZLVlKjDykwsIA2QRBwIaFiRiElaDBrcsdSC8ryiP7WLF+oohxVJIOCOmJtxg
         jT6lfyX6qNNnsgaolU/q7joiuZXM0WSKfEq+oK3JKwr4hMi43e6GMjM3VrR1jg38CJjk
         USyg==
X-Forwarded-Encrypted: i=1; AHgh+RoYkkCwYMiLrFwkMxMlnCwqfS8UDMXp5AruoQrmwllL5HZNQAr30PQX55k7Dc6RMhD0lMpIUJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqDQFiZvIHxqQK6EwuvxYSlZrSORiubH7GkjVAtF19XMV1EQd
	x/CDv+YDq2D7njjdQvFzHPcU/oGOCLGJs6njQhHOa2YDHwknWsWbL5HKKWSOmYSr36XyaVi2qs9
	Gy9h/Wnis1ngVYagMLo9N7QroBoAwxYu/hu+nE9jp4H+WhktUJCxd4SvHyA==
X-Gm-Gg: AR+sD13qFaJ7tI+zsGwVigfi+H5jB/hYg1gsJdQRpbvh81Aftp4xopQYmYCKjT2GGro
	BZvBQGsNrUkUCCiDfZ8oUDHTJS19gxh45nsjVdiudrPqbQuq+nOru6ErCdDM8GJOgpQ90+JbOPI
	z3WlNOALHgh+1hy4ydzbLzaBo6xnnLZb5h3JJpPIKdLQ+BRPXb1KURyCxG7BoHlMtI8JRQhyG9A
	2qUWvFyiGaAITDjPRQmLKYeYgNea+8C+Tn2lgTV2fxkIt3HmIfj5a7FpuHyyXOwlBwqbnVNRoYb
	WIc7x7qMhO9B9gX1xn3+0zt4FtqW/rcVZv8TH0GDYUXw2tp7NaHlY9qgajLzDAa6f2vdwdnDCQA
	JJqyUr8aSKzALrsuirn5A/BPOdO5TO6RvDA4Flb/HSM1Yb/lAX8jH1ThRMAEM4zCEYrCGvHLXsk
	CMlw==
X-Received: by 2002:a05:600c:8214:b0:495:6a2a:951f with SMTP id 5b1f17b1804b1-496c6444f77mr17532775e9.17.1785233075552;
        Tue, 28 Jul 2026 03:04:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8214:b0:495:6a2a:951f with SMTP id 5b1f17b1804b1-496c6444f77mr17532375e9.17.1785233075126;
        Tue, 28 Jul 2026 03:04:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm57119355f8f.0.2026.07.28.03.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 03:04:34 -0700 (PDT)
Message-ID: <a0d58258-4042-41e9-ab32-8f7e5deba5e5@redhat.com>
Date: Tue, 28 Jul 2026 12:04:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: validate peer CDC cursor against RMBE
 size before accepting it
To: Ibrahim Hashimov <security@auditcode.ai>, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, wenjia@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260722101758.37817-1-security@auditcode.ai>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260722101758.37817-1-security@auditcode.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 12:17 PM, Ibrahim Hashimov wrote:
> smc_cdc_cursor_to_host() converts the wire-format producer/consumer
> cursor of an incoming CDC message into a host smc_host_cursor. It rejects
> a cursor that goes backwards, but never checks that the cursor stays
> inside the buffer it indexes. Per smc_host_cursor ("an offset in an
> RMBE") and the invariant smc_curs_add() enforces for every local advance
> (0 <= count < size), a valid cursor count must be < size and a single
> advance can be at most one bufferful; the wire cursor is peer-controlled
> and was never checked against either.
> 
> smcr_cdc_msg_to_host() accepts the producer and consumer cursors, and the
> unbounded value feeds smc_curs_diff() in smc_cdc_msg_recv_action(), which
> computes the advance without clamping against size. A peer can inflate it
> two ways: an out-of-range prod.count (e.g. 0x7fffffff), or -- since on a
> wrap increment smc_curs_diff() returns (size - old.count) + new.count --
> a cursor with a bumped wrap and new.count above old.count. Either drives
> bytes_to_rcv far past rmb_desc->len, the very invariant the comment above
> the atomic_add() claims but does not enforce.
> 
> smc_rx_recvmsg() then trusts bytes_to_rcv as the amount of valid RMB
> data. Its first copy chunk is safely bounded by rmb_desc->len -
> cons.count, but the second chunk copies (copylen - chunk_len) bytes from
> offset 0, and copylen came from the inflated readable -- an out-of-bounds
> read of the RMB's backing (v)malloc allocation, copied straight to the
> receiving process via _copy_to_iter(). This is a remote kernel-memory
> disclosure driven by a malicious SMC-R peer, needing no local privilege
> on the victim. The same unbounded count also reaches
> smc_cdc_handle_urg_data_arrival() (base + urg_curs.count - 1) -- a
> second, narrower OOB read.
> 
> Reject the bad cursor at ingress, mirroring the cursor-sanity idiom two
> lines above: drop any incoming cursor whose count is outside the buffer
> (>= size), and any whose advance from the last accepted cursor exceeds
> one bufferful (smc_curs_diff() > size), which catches the wrap case.
> smc_cdc_cursor_to_host() gains a size parameter; smcr_cdc_msg_to_host()
> passes conn->rmb_desc->len for the producer cursor and
> conn->peer_rmbe_size for the consumer cursor, bounding it at its single
> origin instead of patching every downstream consumer. SMC-D
> (smcd_cdc_msg_to_host()) does not use this helper and is a separate,
> out-of-scope gap.

@SMC crew: please review.

The above looks so correlated and quite simple to address that possibly
it makes sense to address it in the same series.

/P

