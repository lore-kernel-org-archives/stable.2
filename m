Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343010;
	b=GPxWHygE8paXktk46v533fC8daw8hpNWMmalVFuw75egGkmlpCeV+8n/RDCf7atLe7Fx
	 /9wWFJYnLqTxKb3rAtwZZyrkhXKlEoMQMTVlQmfBuS977mVvUN4QsqCUAm56cOcYLAKj/
	 WzYfnucGZmXjKkWrHDZscqf9s13pxUC7eC4zxweJGQ1gTW56usf6xPjlO3vurJ8QODxTU
	 0yLyF0gVvTfWOhCnsfC85kLfrQHu/l7rl/GfI+7xWJA+nPCRBqGMdCcJb+neSB6956KZE
	 7pdFO+Zp570b0AN9fZfxPONeGmnETdy2pDDOcQ11aHw7uFDBITFSJMV88EdwZpkrzyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DS50kc0yp+XKmRK7kU59nKs7lLs5n+2L5Ptw9GISEyg=;
	b=vBhPtUFfo4skMH6nkeQ9xIAU9Nk7YCqgyAfvVJkdkW5n2sp0sMzE+wd5PJSjcedG/ZYD
	 JqPErB8usZ1hQXcm7oGrf4pFt9HeRb9R36NoWC5Hj9O9hqwxNsCeKPyNBcKMGxB3dsIYq
	 mJKa507It5e9ZaUxJ6RWRs8Vc7NY1qH2DAO6A2o1PksDX1sKGrkLmH/rIz92j2h7HS3+f
	 8QlmjEZdZb7/lKb0syPiaOJ6I2gkMr/xNst0HwYMI5oXr75KIyLvNFzh2WBroVWWMthYS
	 0d/q1qQ5Vf9KvN6a7HOSi2zOYTwWl9HD6rS0zcnaHtnUSWsPBfwb0sdmA73WvpQhGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=GqgcbTlK;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0641606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0641606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=GqgcbTlK
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1188449f8f.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795343008; x=1795947808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DS50kc0yp+XKmRK7kU59nKs7lLs5n+2L5Ptw9GISEyg=;
        b=GqgcbTlKvhpVEdUHeAMatFpKIA/KSipQ62eUBmYCa1HlHWCsdzKAIuUzKhnNCrf8mE
         8fQdsYR7Y4gflNAIsEkkfCTjAWfuw03vPALHREgkd/qRQ6w/rRUIUJd91kGzAhdxFbyE
         Xw3/QtaT1HM/hVLb0j3DF3dU/o6V6EU95rRd8nd7z5snYesZ3kzyjsipCiBU3j9O9q/h
         osjwBD6tXgWtSlYL3hqYPweMQHu6+iZ4tQL6t7YaA5tckbAFc8RTe04D7n52RUAqH667
         WhTSE6omeCBCcK2kublsmKM1oc3EGzjtlraVXau6bMvagWU7belt6twZDqaZ5ef4gliE
         PJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343008; x=1795947808;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DS50kc0yp+XKmRK7kU59nKs7lLs5n+2L5Ptw9GISEyg=;
        b=oi+gumKmiUBqy/7zTf49hPHoSvGiQMfHjmFbKex2cTvYtMvdfO9AVhipIsxUTiaoW8
         hhrZUxSZXDdDLMJvX/e2lCudjZ3bZI5Jshvg9mX+7xRRkaFZpWKyaccxM0VMTlPYAGnA
         5YRi0aGBJwKKQGFmHgm+/jBSfyT11NHaBzp5Rqn6GiNYswhMahysHNOx2n++nEoDFv09
         iVW99WisL/IhfF9p4A3yTZEkJ1VJbaN4pMtQuJ1BS+mZ9WKxmvnbByr1WyjlEilPohYW
         EBHZwlCvyUW2PJZw7ZtwY9YZvhPR+/vq01k5UGyKlLvVGOpLLpgtO2AivD7huWQ5xlrl
         BAQw==
X-Forwarded-Encrypted: i=1; AL+hErEuTL1xRMG/blmKGf3nflOVcZTy98JkQ1OqBgRDutfqrJveGceF7B6xk1AJoUy19swy4hzCOSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YYHetzP1Uv6etgrqs5XG9E4N6Y3MAs2kPWhFhGzeWJZSIOGxj
	ikkHAZxZpZ/VcB14aZS3z2HikWoUsoyHdShXorGyK0/PS2qh0Um0bMq10Lh8VMjeS0M=
X-Gm-Gg: AZFdTZeRowrZYFmE7t4qMYlc+P2t01C6KYQ4tTWC0DCpAeyKBUYqkUcGg065ZpfQfIM
	7LX/jYiwQn7PZn1kTtz9Exs7MBSqC13J5RZYJX7Oy0IzUuc3YmW3kGvQFSDeqwKsATjFaY/jTN6
	9fvHfkuYakMQJB8iKAYXtt40vZnZ6Uik7OgKT2g7pF1yQftft5LGS+kPSeswL5kuJdEjpQzQ+k/
	Eof20Y0aWgcrz1H5HwPx+JS5DXu6mBX89WRU0R154keTmGyLZ0FMBt1zG1ysE4XXREZcWAc01Tu
	V5y5cwwZGax1oP7nXzKamHxAMf1jYhEbhY0oCUSKEHR1tKm5LQtxY4yA5k+jqseqT8gjzSL2KIp
	4LHEIQ+kocJBIOHoCDdHuqXqgca6f9D94wYVpWApRPzOH9qOX7jEu0OZzXQfccR1jj8HY4TaU9M
	W5LqlBh7PvFYjjP+FqNjLpsn9l9iR+NOIHMYenLfsp+OeTr4VibDH8PDytQZLTmkhMd50fPSDQg
	lb3q1jOBVRKSzCtPUs36eqyZbF2EbreBig4Z5hlwj6Uoy35Yo685DOMHBh9/0AWAmJ7BQNj3RzT
	HZWgpT/7njUJXrT7GpTaMvRcTqtH1loCN9VVq9WH+Uek7MdKij/EcVRq1bA=
X-Received: by 2002:a5d:5887:0:b0:4ac:84c:70df with SMTP id ffacd0b85a97d-4ac085bb48dmr15752832f8f.45.1795343007899;
        Sun, 22 Nov 2026 02:23:27 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f1b2sm14830205f8f.25.2026.11.22.02.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 02:23:26 -0800 (PST)
Message-ID: <44b34f5f-742f-42eb-be7f-0cd731ff565c@blackwall.org>
Date: Sun, 22 Nov 2026 12:23:25 +0200
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
Subject: Re: [PATCH net 1/2] bridge: mcast: Fix source list rollback on
 failure
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, willemb@google.com, horms@kernel.org,
 dsahern@kernel.org, shuah@kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kyuwoncho18@gmail.com,
 stable@vger.kernel.org
References: <20261122072504.2623702-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261122072504.2623702-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2026 09:25, Ido Schimmel wrote:
> When the bridge fails to add or replace an MDB entry with a source list,
> br_mdb_add_group_srcs() rolls back the operation by looking up and
> deleting the source entries of all the sources that were already
> processed. This is wrong for two reasons.
> 
> First, with NLM_F_REPLACE, a source can appear more than once in the
> source list. Its source entry is deleted when rolling back one
> occurrence and the lookup fails for the other, triggering a
> WARN_ON_ONCE() [1].
> 
> Second, when replacing an existing entry fails, sources from the new
> source list that already existed before the replace are deleted together
> with their (S, G) entries instead of being kept.
> 
> Fix by marking source entries that were created by the current operation
> and only deleting them on failure.
> 
> [1]
> WARNING: net/bridge/br_mdb.c:901 at br_mdb_add_group_srcs+0x310/0x440, CPU#10: repro/304
> [...]
> RIP: 0010:br_mdb_add_group_srcs (net/bridge/br_mdb.c:901 (discriminator 2) net/bridge/br_mdb.c:924 (discriminator 2))
> [...]
> Call Trace:
>   <TASK>
>   br_mdb_add_group_star_g (net/bridge/br_mdb.c:1021)
>   br_mdb_add_group (net/bridge/br_mdb.c:1082)
>   br_mdb_add (net/bridge/br_mdb.c:1097 net/bridge/br_mdb.c:1360)
>   rtnl_mdb_add (net/core/rtnetlink.c:6925)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:7178)
>   [...]
> 
> Fixes: 61f2183512a7 ("bridge: mcast: Support replacement of MDB port group entries")
> Cc: stable@vger.kernel.org
> Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
> Closes: https://lore.kernel.org/netdev/179489219555.3099318.10297266282803881244@gmail.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c     | 29 ++++++++++++++---------------
>   net/bridge/br_private.h |  1 +
>   2 files changed, 15 insertions(+), 15 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

