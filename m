Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46234233D9E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713228; cv=none; b=ObPQXcQj4NaNDx0Jqgr3KJai0JAbd0+YPLLIsRbq5QWFMbO+eAXkyNzigGyiBk3x7LsthmDHgZVN2IjlSsqn3SFAFzXknbE4+GdLd2gCceZJUBfo96N9URCkAxUzbwxaj3P5Lxk1CRRpscwnkGQ6phU5o8PQKATaID0Gq+n+JFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713228; c=relaxed/simple;
	bh=vhci1phfR/gQYv5BdXq+QvipfB5TklR24VhI4iF7TW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNSjy+CQuHp1W6IIobYrs4E7WFbahw6RbhsFjiRMQLy7GT54XrpoV7E1fnFGChnZALIm1LnIYMfogeI/DHUhVjerWOXND1Wr1HOC2mgihxUYNDSclKC1ni4HX5NHGn+Xr5+VdeOODXH1mukgIPGfaNmI9v7Kez76rER6wm3+7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LwGqQnEB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LwGqQnEB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49558ce01afso28572485e9.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784713224; x=1785318024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/L6NTVNwGfeSnnznXMeM0W98zdRXLB4Fnd/478hPd70=;
        b=LwGqQnEBs2pgLmXt1p1o9MEjLxTVeGg5quuIiyE9OmVMnjmzu6O4PR51QAUacVLMhv
         zt2jfYqyq3iEB7+7CbiUuPVlSeKNabMGufcoq/phrB/ZoGtlCUUSq8EuGyLtYupXfoRM
         Vis2QS3oCYpQB9N4WdqqMoRIzftVLYdj+UYs4JWaosliJrIWlWfjWckgulaxB3pmHdeO
         msiwAMfJ/c7xWo6KFhiEoRJ8oWDOe2ao3CndNKI7sSMO6E5WJcNGRAtR6stE6zzU6lKB
         PYwB9NwZBCBJo6lBsr6/pKN5dKWIjFSwyrTZIqA65QLhGDoj83q8JbjEOdJoy4i/IuFT
         gGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713224; x=1785318024;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/L6NTVNwGfeSnnznXMeM0W98zdRXLB4Fnd/478hPd70=;
        b=k4cfuxvep/vpaZHMpzGqxJL8hA0+kzw6xn+uMX3cbkYSBfFRQrKrmoTWX803xpzTPM
         aZjVWKQb9JPIA2X3yBUlqNxwKHH/FjnJtuwV+VDaC9aTehALhavCtQ7t0R3T5mtGpfPr
         HjguottYd7ZbcKD3v9s+tsL5apy7AGHKlmHAHc6mmCQjCTxyLf9k7GgnZ+VqLLPs6vzl
         Pvlqyr5q5stiZtS+1UMRcq/r8hKB/IuddmTZnHYJNdrPeR10aMKS/lv6Q2T0J9KZUSym
         o60rWExEYq68T+MXr178hs41BUTCoScSVJmfeOc+oX3PDoaAIs2tgN2KFj8099xmn6pj
         h0yA==
X-Gm-Message-State: AOJu0YzUhB9adSFiJ3cQ+gx+l5A0MRbvS9/eBiJa1aKTf1p0S6KCXJ7e
	HNfs63slKIMU4QoN1v8IhXtXr849nBl0hhBz0kZHfO/0t1kCz2L47bfq4SGlYl4fy4w=
X-Gm-Gg: AR+sD10MmiVyN5CDtxNRmr1IeA1RPBx9MHa5u5kn5szZqpmvHnH9AZQ70czvtyJBiA6
	Nx8MDZs4DI0ptz8Yyg92QZr/YK6v1xApJiIuXzkMz+MiI7ot8R3V6V8WkrEbNwqmN0ZWrxOOoWK
	+nyv0HRVKgbrgYwqPSBJeguHVvpjWANTETinRKj/EnHKh5SkjOK5uAbNPlImixWhHQeFxcKEm5A
	VV/JhGmnhok8GKRq+fRZtl7kuTpw+LFr0b2uJkVRl0HkkUGUNFYgbNgYWHDrnyK8XHMarzd24iN
	LzzczEtO61nwcXFzuCh33Ol+I6Yj5ufeGhlfJ88uK/EXPsGhWqUgYw/ldm3S6FnMTiI0dhLROqP
	N9h+LyaBN7l3T3jZKwg4x7Yxa1KARd5tYr4do50lUx1E4a5ATcs7OLXqQiOB+SaPe1h3C8PabNH
	I2snQY2/1YHyVSAUyuYvVAxdM7blKuySdP
X-Received: by 2002:a05:600c:5489:b0:495:6f6b:2520 with SMTP id 5b1f17b1804b1-4956f6b2525mr4900225e9.18.1784713223876;
        Wed, 22 Jul 2026 02:40:23 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b03a93csm37801065e9.4.2026.07.22.02.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 02:40:23 -0700 (PDT)
Message-ID: <4c48f12f-abca-4917-a711-7975ea9df235@blackwall.org>
Date: Wed, 22 Jul 2026 12:40:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: mdb: Fix source list corruption on a failed
 replace
Content-Language: en-US, bg
To: James Raphael Tiovalen <jamestiotio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Kees Cook <kees@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
References: <20260720160428.249356-1-jamestiotio@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260720160428.249356-1-jamestiotio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2026 19:04, James Raphael Tiovalen wrote:
> When replacing the source list of an MDB remote entry, all existing
> sources are first marked for deletion and vxlan_mdb_remote_srcs_add()
> is then called to add the new source list. Sources present in the new
> list have their deletion mark cleared, and any sources left marked
> afterwards are removed.
> 
> If vxlan_mdb_remote_srcs_add() fails partway through, its error path
> deletes all entries on the remote's source list. That rollback is only
> correct for its other caller, vxlan_mdb_remote_add(), where the remote
> was just allocated and the list contains solely entries added during
> the call. On the replace path the list also holds pre-existing sources,
> so a failed replace tears them down together with their (S, G)
> forwarding entries instead of leaving the entry unchanged.
> 
> This is reachable from an existing (*, G) remote. An EXCLUDE filter
> that loses sources starts forwarding traffic that should be blocked,
> while an INCLUDE filter that loses sources drops traffic that should be
> forwarded.
> 
> Mark entries created during the current pass with a new
> VXLAN_SGRP_F_NEW flag. On failure, delete only those entries and clear
> the deletion mark on the pre-existing ones, so a failed replace leaves
> the source list untouched. Retain the flag until the whole operation
> succeeds and then clear it. Also stop vxlan_mdb_remote_src_add() from
> deleting a pre-existing entry it only looked up when adding that
> entry's forwarding entry fails.
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c | 30 ++++++++++++++++++------------
>   1 file changed, 18 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
