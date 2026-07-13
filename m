Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E23537CD
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968016; cv=none; b=AlPstt5wuRYJKQmY5AHnlzSCNF6Jlwq6QyGU78z7upCLMAmjZgim4t08lrARiaReK829ncOtf8+KTFeJChYN9a6SAAkz0jLX2/g2PyFcCngSK1+SOFrnW9JdxDv0rNeq4+YCtfODpcy2DU3IETZIrl1xNmicZAtz3emB8x3DQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968016; c=relaxed/simple;
	bh=ssmhTTGSn6sUgTUzUK5DbF/vtmOaVoMkx2aHs/ASP4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5fP4Tm7ZAQmp4VBVkC78gX/DZp118eeW1GRHsW+1dFWC+tbGGUJEdns5N3pFOipSQm1k504QAykaY1WyxIXmbjNOaO6IloTsEE80WbRqEbf5MJrAgyuBMNdhDBlr7wIoNUf9sW7tgS1Bbt1PWlkxtq6rlcg2ZQtQL5H8Onr+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKt9DEVl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Icy0qBoR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKt9DEVl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Icy0qBoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783968012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkgeR4qy1urHmGppXYgLTK5cuSjvtnicUYk6q0xDKVA=;
	b=ZKt9DEVlV1a6UTjGu8SEoqXw+5SakruoD3iIxzwpMe4yM1cuOrb5IxizhynuBlURs5Ob28
	ct3ju8Y4kyknU2xEFMaQFPFjEU3Uy0uQhixahQ956GGhNd1xHjhYk5PsCuI23VHD9xl10w
	X38TJwBjA0RjsmXuc6ZRL6Ra+6O8KZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-ZyZvDmEzOnO43DmC4SkmiA-1; Mon, 13 Jul 2026 14:40:11 -0400
X-MC-Unique: ZyZvDmEzOnO43DmC4SkmiA-1
X-Mimecast-MFC-AGG-ID: ZyZvDmEzOnO43DmC4SkmiA_1783968010
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so50476685e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783968010; x=1784572810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkgeR4qy1urHmGppXYgLTK5cuSjvtnicUYk6q0xDKVA=;
        b=Icy0qBoRXjuEO9IuJogPZC5JROb0KV3/8lcyTf8hoTdDTWGcBXA6W3Jfoj/mjqCoIe
         jBSSOjHdWhQIHeI8u6K8gk9cxAo9G1NfJVCFiE3VmsRKhnEkE5Z2m8l/9dGjecir/Z+M
         y0r1Lpj/lk0Y8JfFHRsmONOvORfDDFFy6O4OqDi6tFF9PDFE2JvrmoIcL8ruAjmcQBuW
         NGRBsmH422XbNaNayMb4uLinpM804tYHvSJGliHNNOXpmvYN0nn4I/kTUneJGXvIED+R
         nY8jBKnl3cHa+c3WQWE91a3xwEo8uVVdtl8+z+VxOTSsYDhV4TL/L9pB0R28b5ufVYD2
         mQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783968010; x=1784572810;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkgeR4qy1urHmGppXYgLTK5cuSjvtnicUYk6q0xDKVA=;
        b=mkFyPEVT6Ys9cOjxmMJfE2W+Optb2wwQYFRcq4q8TNBr7mpsK59NJ8o1MBHqZSTjKB
         uwTcby7G7XfeZSKhb7/MRQAFr/B0W1MDXN7Y2EKJQSqgSGG8yibKqSuWrk4W9YC8EgVp
         u10VfQJTgQwO/zfX18YZQml8lyIuB3E9K0OyJpSNhiW9SM2VnwQwIqSdaJLgxJTmMcW7
         ujtVJpDz3yXRLfM6kiAa+RPlzLreZ726aOBNTpxzf7dou/HYGysUIDUXo0Z/E+Lbfgj5
         /2l2VaBDoF3VISWOQ/51NVe04eG3ebxFc2+zEP5awl9pIHr3Hp3DLNWcm3y2r/XOTziL
         r0VA==
X-Forwarded-Encrypted: i=1; AHgh+RpIuEAjgmxuxcS0jhTVumuNEl0GrGV6rqOlvb4b6F2eAGnCyLj8SpVS+LpnwQGyzi7eGXh7I0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSthHYRFxvJJHlZGbPMhWPQGO8IL8lKafl4VwuBYqkeK8kShO8
	PAuZGlrBCyj2z/KDjEeLv0TnugXGsQIdgKcWvi2d0KFPdv2pgHw4tdrLolVZ0pNsncHbmJHPuUe
	x0hWEKXqLHK6Xt+ky0BIp65cjA+tKOocL0wKEnMthcu84SKTRSdQ4bw8URw==
X-Gm-Gg: AfdE7cnMk6p4mi4G1Nlk6hQvBWkNmPNwp3fNtxLltGr53y8qcGpcyOafJ8xhuDkxEpZ
	hfJBcF7leT1bHO1cB5JI8cGzdhDYAXf4KDsr9GtCKbcL87K+KWzC8aKCUY9jdgHvtKvFh0/sY7s
	pRR1CC2I2ZmxUM9I5cMFYYDU9CcmUljZq+t14EUC5jD1K+E+r5VCQ5cko9LpuxPvJmZWCtf5myf
	/3fp6hjw1XrmmSgLo+oa4pf1S/bch8yEWtjZCJ09fv8VlE1aXQ7Yl4vdGGQH/mqjwvgIG2fILzZ
	lMO58pbPeDFDdhlgs9zRwBfjeI6wInypczA0QEqPuhppoYy+Hb7Ed2ZcsP/sKkEBSTYrH72TJVt
	T/FS6dLZ2zzBUSeUIeH5vUC93aXIiNw7QV5/SlufdDp0ukXTsxDkynbWesRMzD6MUBAgNgPU=
X-Received: by 2002:a05:600c:1992:b0:493:f261:d295 with SMTP id 5b1f17b1804b1-493f87d9886mr102184525e9.4.1783968010225;
        Mon, 13 Jul 2026 11:40:10 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:493:f261:d295 with SMTP id 5b1f17b1804b1-493f87d9886mr102184345e9.4.1783968009832;
        Mon, 13 Jul 2026 11:40:09 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a38b19sm215839955e9.0.2026.07.13.11.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 11:40:09 -0700 (PDT)
Message-ID: <a9bdedcd-cb49-4b6a-bf78-ba6f03b3d511@redhat.com>
Date: Mon, 13 Jul 2026 19:40:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: reject an over-long name in get_name_filldir
Content-Language: en-US
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
References: <20260711150808.2919076-1-michael.bommarito@gmail.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20260711150808.2919076-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2026 16:08, Michael Bommarito wrote:
> get_name_filldir() copies a directory entry name into the caller's fixed
> GFS2_FNAMESIZE-byte buffer with memcpy(gnfd->name, name, length) without

I don't see a GFS2_FNAMESIZE-byte buffer but it looks like gnfd->name is pointing to the `char nbuf[NAME_MAX+1]` in exportfs_decode_fh_raw(), but that's just a 1-byte difference so it doesn't change the conversation much.

> checking length against GFS2_FNAMESIZE. A gfs2 directory entry whose name
> length exceeds GFS2_FNAMESIZE, as produced by a corrupted or crafted
> on-disk directory, overflows the buffer.

I think the on-disk dirents should have been checked closer to the dirent read path before we get to the get_name() path.

> Impact: an out-of-bounds write past the GFS2_FNAMESIZE name buffer (KASAN)

Do you have a KASAN backtrace?

> in the NFS-export get_name path, reachable when a gfs2 filesystem carrying
> a crafted directory entry is re-exported over NFS.
> 
> Reject entries whose name length exceeds GFS2_FNAMESIZE before the copy.
> 

gfs2_check_dirent() is likely a better place to add the validation.

Andy

> Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/gfs2/export.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
> index 3334c394ce9cb..7b28f1eb9ad0d 100644
> --- a/fs/gfs2/export.c
> +++ b/fs/gfs2/export.c
> @@ -76,6 +76,9 @@ static bool get_name_filldir(struct dir_context *ctx, const char *name,
>  	if (inum != gnfd->inum.no_addr)
>  		return true;
>  
> +	if (length > GFS2_FNAMESIZE)
> +		return false;
> +
>  	memcpy(gnfd->name, name, length);
>  	gnfd->name[length] = 0;
>  

