Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716295;
	b=NJz1ABlf188359yIus8BcjAkrGUrjXy9lF/GpYlHrPCtCJ5OgGFFG+a+QvSc/X0uSzFW
	 gixV40decAzXTnV84OimgQou4w5SkPRUyEeFO5pIjUI7MoJI9HbhFj5EhzfVVscRQcxzP
	 gS40qo0bGdhH7dgR/gCWMRQCKk+1IxOFhSIzIDZWHUpsY4Njhn8EhNGD3tGRzh2ZH26MU
	 /bWQRwljnrDsI+HryjORKKMo+Yfzq8MLoAs4czT17vqOyQ6mrBVv61w6EtoGabEjWDJoL
	 r/6ah3FnKWn2XRhRZGBunHiDQaLkKL6knbd+Hr0YF0llGY8GMLnGrTuP9P4lGwjEJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=KXzabl41ZeEnGrVAYqexhOU2oRggUUYi90hmQPge7Yw=;
	b=ie/8k2SWf3yRanr5NtkNxuaeBcWcLLJ/w/qEH/NPBs44CuCYgu2NsUO6+99MV8aaEL24
	 d+mbFlnPn/trDQoQTncn1C3TQoAmT/dQJdJEHE5OkW678P+KSOB6icX0ChKGkZ9qi3h+8
	 IEl51HhLTUITtR9JPArj6JKKaHoIymk0qFB4dwn3T+K/zVyROmrBf14FH2yFUhc1GyefW
	 R4fD4PKDaYUh8m0msEaUHRyupqmJxc0PtmjMFv0cB3yldnLzQimfEmSF0qyCn8Erfr5eV
	 0Z6rh7elQScgYczdcGgSU37dZzIUS3Du9KPyCvPkRnN4xOUgqMi0wNuvG3jsQX3txQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gCUl3iG4;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5360850A7
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22B5360850A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gCUl3iG4
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so4326729c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716294; x=1794321094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXzabl41ZeEnGrVAYqexhOU2oRggUUYi90hmQPge7Yw=;
        b=gCUl3iG4R2jpywA1QQ9kJt+qOfE9h0zR8pM3mDaJcggKmtXx55bVra4P/CXDOGGj+/
         imZ08kKIS3RRKi4i1kr6kpejvmVS50Y3yR7/XTpaS5JuhBBEOCyp9/9i1kYWs6MdYrQl
         yLtTf3MHm9JQIo5zKXozqctrL9NL0pQ0pByG+gszIzL96BPuMiiHKfpG4l1yVo3qHknC
         ivAQ90QDSnWP+Xtrq1eQL0PFOdlXaogQ4drK57lZtwum7/hFDE05T7pd4xyEf/U46DKW
         LFl6oY2hd54Rfff9+G6Poc53Z5yB7GGzRMUmBl8axg/ufh8NqvuvLVva++p1tJA/A3o0
         obPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716294; x=1794321094;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KXzabl41ZeEnGrVAYqexhOU2oRggUUYi90hmQPge7Yw=;
        b=2T1kRRCFtTSlO6mScT4F54mrqaxYF7nRNE8FYOdAI+KbwUXx9/AgAx43/0c8yr6iKy
         PYR34gO5ZFs+SVdxSEZzpp/0F5pUiTIhqlZo3A5wraFoy4q+JbCNZ8K6WNuxKMwoSSwJ
         6mBEr8WUP8jY4kLa4u8A49sOFnMV7zg9aS0rTM9mdZ0r/EmttkGczEc7vQiL/EhGJ18l
         m4b6kz6IaJUKazR5eKATwX0XoRWTgojkWm4SbVTtN6ON7U9ikmRT4FHs/+XpV4GPjeDF
         vfLGC6cEqkmbSexYCUA2M8SiewFzWtJIBZKYm/XKcLeKxPyEKHRZZy15oekslQY1+Qfh
         9TTg==
X-Forwarded-Encrypted: i=1; AKwUvBwvqNdgHBW2EfkBQxO00NyJei5yQYXMffDmHjxJQPh2XvMCwrldAlSdlIS0cxHTdXptUjhE+Zw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ogik160Q3DEY9yPEUKqbLj7DK/tzxOqfgQencKCk3MGPG6wkd
	NWk29yNwiaTXL23wBGRTsAJhqA33XaBJMNKxT0RcqKabvGgYxQwGbIWfJiGnpuOxlK0=
X-Gm-Gg: AYBFou0+4dYg9VVxA1phP4ip97dQ8EbqI0/YT+e24xdaXiH64Hjpuo4en5rMND7WmAv
	fkgsaCEO0id07QZvb/EpMNALaj8BW4PjfjMsB6JqAQ5wepix18MjoxBUagRjxOXF1z39m8rJdHq
	X0TaM8SUgUK6cYzRo7wQepOqDRC+34C4FZuFw/hf1uk/mphKYb4le9MrAIedbbZWW4nhqDW3wMQ
	LR8cJG/D1ydCQ9ABlY9Xw/kqmsIKQKYRCedzhL++IBNSOwfLhrR+FHDjdMPFwjR/bTg2zSfdYuT
	kFh3XkzZaXDOGFuA/U0cGxUZ1bhHgpN7Kemq38PQ9mKuyPwH8gLPFwDqKbncCLa+jOh/wqJQR8Z
	Fp7/82uNndNgX0K10XCU7jSL5Ar9O5IzObpidoatNPBeskq0fTs11SUeYOOeQyRm5xiEdm22h4j
	KlYfmeMidg/bqFQGqVJOFc+prep9l80HQ+SGmspLhwiq4vvEreju+uulU/UVrHe0JuBJO5a/RkB
	AnfGeyTciRGjSSwEDPPrhwfK8tbDRHhF8jCt3LtfOM0ecVlgoEdFq5skFopz/ER+Hhpx5are9Q5
	lubZoyHZhqFbBom18n731ICsyYsFJKEaSPOfG0VPw588pJf5n/x/IChPMRDwo0E7U7/3ZlTOVIN
	clSW536cTdG1t
X-Received: by 2002:a05:7022:eb44:10b0:186:5b49:90d8 with SMTP id a92af1059eb24-1ac5782fd31mr21082249c88.4.1793716294128;
        Tue, 03 Nov 2026 06:31:34 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, Zhe Liu <liuzhe1@kylinos.cn>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261102061802.408173-1-liuzhe1@kylinos.cn>
References: <20261102061802.408173-1-liuzhe1@kylinos.cn>
Subject: Re: [PATCH v2] blk-iocost: account flush sequence latency only
 once
Message-Id: <179371629271.3691261.11171025306527479565.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:32 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 02 Nov 2026 14:18:02 +0800, Zhe Liu wrote:
> A flush sequence with a DATA phase can complete its original request
> twice. Both completions invoke ioc_rqos_done(), causing the request to
> contribute two latency samples and adding the same queue wait time
> twice. This gives such requests disproportionate weight compared to
> ordinary writes, distorting the device-wide latency and queue wait
> feedback used to adjust iocost's virtual time rate.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: account flush sequence latency only once
      commit: e9804489e27dd6e33aec5511fe3780ff3009f57f

Best regards,
-- 
Jens Axboe



