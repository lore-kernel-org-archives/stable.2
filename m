Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234087;
	b=bJ4OBGwOz44juvPuB+2xN38gKdsI+cTCairjyG140Fe6oqfqzBmF/ShzdNgTdKcU81tR
	 kNq07HuyQA7NwQQiMTHNqaztsYwdh7hkOgtnIiZNREQaJr87+zx2HUHhHqKNrCKzFhSkE
	 uPkcpvkekhdPrAlmW4udbsaPjYGahgWwiKjk3CwQx1kE60RuEuGlyoPt/YDvUtETA2Clq
	 q1a5qCLfeN8MqOC9oq0OlISGncc+51Mjm7oN5aP6fMskbu2iA6Z7DPmDCOP27xEDiNsEe
	 w4b2XKiAZ5DbCHzSC7t2YRGgnQfDaEe/9It9JpqljLtoJ+6GkWx3zQ/q5YhwEFHf67Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZlIxQgQkpoK4++KHMJP1Vagvvtw9FxQaLlSgPvqh+i0=;
	b=KNyJePxhTQMzod8rVcz2q69/3B6qbj6K+ZUCIwHok15WLMwAXZGOAk/RjYN54Q44RoA/
	 Xc6LFZRcdHnWGRsmqPbg+2h6HVKx5K0LIg5e7Lb17P2eUNEdfvKSnPomP0y8BZLF/nchF
	 Sxq2OPYm4QTz3tgOQqc95IDUvshSJ8KQi4wp3uEjwq4bRixfYE+JBBRHkS9Xj72pR6Kv1
	 OoqrceK2HZ0MUSpKmLwTUW1QXi6ldm+6TvwLvYG+9JaD89vkZKsWP3vPDGcVJZNtV5kzk
	 AB2A/6hHO3Iqa5FtkgQ1c7MqvJUj9wJq5XcFPrBYR30GLxAG/XWhErLmwJ7SZEbvSzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=CNUA5jcb;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AD606D82D
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 14:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 943AD606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=CNUA5jcb
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-717080a2d50so580380eaf.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 06:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1794234085; x=1794838885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZlIxQgQkpoK4++KHMJP1Vagvvtw9FxQaLlSgPvqh+i0=;
        b=CNUA5jcb8Uzf+l87oHL2Nr9lco8nIkwCHFzB+yWIA83CIChwjoDuaRgiWPaNm+D+gZ
         iy6Jye8EvljXyUjHhUnEQpQxXkQE/rw5j5HbWvRXj2X8G6QrnJsYoC/iEZLER0CvHS0O
         tgqtkmSqhcn8y6/IvGyM5Y03CJSV44b3Mpf7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234085; x=1794838885;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlIxQgQkpoK4++KHMJP1Vagvvtw9FxQaLlSgPvqh+i0=;
        b=ROqttCiF6KyLeT5zQjTjuH559bxJBVchFjyfAxFBfv2MeVwTAjOwont9/LkCtyPCM+
         Iw5jK1Dt2OT+DgH2m2eFvBbsbWRrmcF2As3865tOIewQvXrRlfZRIdYOx6RNqf948A1H
         /dNpFYp1Z/iVG1+M4hD5PPDpHKsVdS94x4rBvKlkaf3+DrIxJnfMz2qh/tmb64g/J3u7
         tz1kk4flEnOeagb9dlCciqAzudLSEVbkouzLhTjF3YMdajEo7wtkKm2hfiFSnIJNhgMB
         hW8TtkgGNxuFv7JooEq7pxHEV2VHcJqodjWIaMrKtGTPyhJT1A39iU1hvvEUHebtKsLw
         CQlw==
X-Forwarded-Encrypted: i=1; AL+hErEEwhWw/BCQ5wHiNy+WPWMI1P0vuC95YlzI5x7Lhl1RDHnH2PZtnF1/RLRdxMgZmI6/SVkPxeU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LH56QNqAuTTrp37ogwbDSV3lLnZhcpTu3j+xkAQOVAbgeEOkC
	fwtys0eK8ml9oFtLFqRtcd+D6V291A+fCeJdsbHdr2o4BMARVMxZFNeiNyCdBG0IVA==
X-Gm-Gg: AYBFou1e9yBB+5LnM7E8QgedXmS9hCBVmJ7aUXVXA1u6DfDjSjSZQir7GsIobqK2Czs
	OBScEWn+/W+7073/uD8fOkAdLdAGyOpa3LsQn71AuL/i0lo7R1aQBV4jQyF7ucuS3cbNNdZMqIU
	FH0sJj+WYwOWCnpFM1c2jPgRZcLL/ila81YqW2iyUz7rynBFurE78psyzklwCH8ZtAjm3T4OTCV
	GJtqFGIfmU442f3AH0ASI1dpe5MOv/DA+/Ug9oFqgiAXUwWKSin+vzUceQW3djI2tCp6HD3Jcp8
	zBsRpJzm6kKdhhobsLcPE3fyd96WQGH0Hr3nYmxK+tU1T6pMp4EPTyBTROBWU2v/vyb3mYs+7fl
	Rtx4ual85+DrO+QxCEd4H8F40V4lgYTiewCwelSq8dQ9+ss2GCnNPIvmUEhR08A1C4Ozt8CRxa7
	vI47/kGSjrPtCf3Azrx5WoJJv2CeP8IoVk+NtXky9uHpZTIxZSE82tyI7t/r9X7O4iifKn7C70p
	Klg8DJTj04Ey0vBjtDNBSyKuw2DcGf7Pn7d0kLQ6zFu1kmlYnlw/xMiMx2HtDSRlvcK/oG9sI+N
	cEdQMRGWXs7i00CQmdlrV6g=
X-Received: by 2002:a05:6820:708c:20b0:713:e423:cb6d with SMTP id 006d021491bc7-7170f25b316mr1333819eaf.30.1794234082937;
        Mon, 09 Nov 2026 06:21:22 -0800 (PST)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-7170f8cbfbdsm3339213eaf.7.2026.11.09.06.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:21:21 -0800 (PST)
Message-ID: <aa84e372-932b-4385-9504-f3d457dc3e2c@ieee.org>
Date: Mon, 9 Nov 2026 08:21:20 -0600
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
Subject: Re: [PATCH] greybus: reject messages with claimed size smaller than
 header
From: Alex Elder <elder@ieee.org>
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>, greybus-dev@lists.linaro.org
Cc: johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 syzbot+693652ded53d3eb9cb91@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261109013336.1122-1-zhaofeng2@cmss.chinamobile.com>
 <f27cb885-76bb-4d2b-b863-437c78029f8b@ieee.org>
Content-Language: en-US
In-Reply-To: <f27cb885-76bb-4d2b-b863-437c78029f8b@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/26 8:20 AM, Alex Elder wrote:
>>
> 
> So the problem occurs when a message arrives that has a bogus
> header.  We know we received enough bytes to hold a

Sorry, some combination of clicks caused this to send early.  I'm
working on a "real" response.

					-Alex
