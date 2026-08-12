Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CB35A3BF
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525819; cv=none; b=QS5gEaGDmTJo8l0gLs/vNpq5cJIhsCCbW+A2skBCQZ0MN1tnd0+CZuDh8tYsaaogUb+t3/jXG1GxkaMZNa1eDHFShvihNY5iYVAlKya9lHyWCbnNzeLNmeHtehZVbXnpd/EjEZeV6gQeHw3IFniNa16cjoZEJNBv5wKTHSZaRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525819; c=relaxed/simple;
	bh=n44If2VGgkicSXz24CfwY0BK5nNHU0rFHpHcfylBKlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLSpFNYZlteHoVsHj9IUr5BCuTJ9WkOVvnrPOuHYfOtjtzNZrdp/5fbOPdzRG0rTH1+hxBqRyX7VVS8CWqLO4CNg82wLp7Tq/voh4xVyfcSNdi06SzJvAIx6exEWF80JluShPnjFTuyQBBAsp6htPI6MOLChQypReRWtrZExwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfBZkSdQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=es5RH944; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfBZkSdQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="es5RH944"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786525814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
	b=CfBZkSdQyGVsJWLdg2/o/3K1ba972682MsDBT/sIQGCudhpB2Cevgb2oYST4v+joAkfOLG
	yMyDVbHvA9mwdsNR7X+0BGItikhykyER4teuzgzKp6gUHsEmzHb9yFItBXJRAKAC+i41iB
	o3NPPYT4JJc4dCJDcYnfNzMIof7KwzU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-hj1LgG2DOJyb_TJBAiuL1g-1; Wed, 12 Aug 2026 05:10:12 -0400
X-MC-Unique: hj1LgG2DOJyb_TJBAiuL1g-1
X-Mimecast-MFC-AGG-ID: hj1LgG2DOJyb_TJBAiuL1g_1786525811
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-481558a96e2so187429f8f.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786525811; x=1787130611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
        b=es5RH944ybkfNHi0/id8EDtD/em5k2UFRQtRvuDw+zDaHhaDg2AXW5DfUhTnuvyz7Y
         P71zObRqHmY3QV0wjUK+EH28lRoN3Vv/6U0PFPD6sjMVAFRipHnjtBNtgoWu0y73Z1Wj
         /Oy00YgYxyXh6dd0cCX4FSdC7Hyf9FhdHgcPXm2JhqLBbA1X4dLDoo2oahQytr04XppC
         pQEq+W3RlzgJtvYhbtQRNVUkH0cSnr7N3Wx1qVYSlUuNnWk6glxJHtmdkAkvrG+hR1kI
         RAo9b2PQxV8Rku1T1XOlfVIEoDJGlQbYUlpIdPANhutbnieQcaIekPbN2ezMtXbLvlAD
         SPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525811; x=1787130611;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
        b=Swo1RaTAjN8FFhHdREw4TyWzmsJ4JKC58bfUPVrYWYdVOo1smkHpRP9TD87EXXU/ws
         0gO7m+fzYU73L9d0PX+oyNoLbx45yOY6urtC79yR/KLfCWNzviPu+XSRH0WgvrBSwlTu
         LOXHQyokRf6jneaPk/UesfjVTViZ/nFIYZvJh7CMyJY1qVo64pACldX/y6zw/0f9+Edf
         gSoT4GaEZTD1hKtxwuIlMS8onZrxZ3V3vhK+K3Z+/hWZxE3kMiq0I7yO80rgTqtovCsl
         YGg+onHMF1WtJGlbFHmius/DKJc+GM6hz0FC4uqacADBMM7mjHgFceJcrKSk5tHuCL/5
         n02A==
X-Forwarded-Encrypted: i=1; AHgh+Rq4wopUdGa99WGexG+APA7Aiv9LNNC0apH1RIQ+wHqMw0tW1hR5RLII2JXqAYdqaYUIUiorICs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzG7LdvdXh8vcaaIwHgu0v8Vu6FvJnjezh+PdPK0eKlk2nF1j
	j+47ohPGwxCZAjW25fKoqjT+L7yTCHvLC2Zex98jjVTWPsD3xJ47KvSTmKqeU0l/svcGJh9OrO4
	S/vkYVO7dvG9Ex0MFRDdwj25CNQ5K2lxDvZaRHnBi+0/AT39sl9w5zW7rdg==
X-Gm-Gg: AR+sD10MaX0FnbVHLN7okTPrY429bf3D7Tb7dB59OjJJL4yzRmpDarhuOGNjqNFuBPR
	HBFNqySp0mI3WoqPVWtTep3x9u/R/+Fq3ypdHOrk4JJbLXXV8iNo6YL1GuQI6zyXXuvaYOETVR5
	cqcKeuwazCHJ0/S22dtOSzvce9WR5+sYP2z9MSZhV9GfkBq5zug3RDYc7QhEb0xz5SRxeU+6Svl
	6ERVMvbKTpm8usRu9VNvWEl9vLPVDmfmdGMI1Euz11VLSRD7dRO/ury/FI4F4j1zSll+kDMMxQE
	UT6hJ75dyCJ+loS6O/xhYmw7HS0qRDUyRLS48equM2wsEqqGqoNz71EnwtzbkRPoTxy+c0APqXX
	sVnvW1en4E93Gp3R50RKOeltDNxDspol4Lzs4r+V1v4ATUQZ1IKxqjoklHLM27Ngu0godh6KrU0
	k=
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4997c13420bmr47111515e9.10.1786525810724;
        Wed, 12 Aug 2026 02:10:10 -0700 (PDT)
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4997c13420bmr47110615e9.10.1786525810309;
        Wed, 12 Aug 2026 02:10:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b34afe3sm42548405e9.2.2026.08.12.02.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:10:09 -0700 (PDT)
Message-ID: <d98287c8-0925-4e70-8cb7-c5703d8145fa@redhat.com>
Date: Wed, 12 Aug 2026 11:10:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp v2] mptcp: restore full join state in syncookie
 MP_JOIN reconstruction
To: Harshit Varu <harshitvaru666@gmail.com>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 security@kernel.org, stable@vger.kernel.org
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
 <20260811222325.90426-1-harshitvaru666@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260811222325.90426-1-harshitvaru666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 12:23 AM, Harshit Varu wrote:
> mptcp_token_join_cookie_init_state() rebuilds the request socket for a
> MP_JOIN 4th-ACK that was handled under SYN cookies, but it only restores
> remote_nonce, local_nonce, backup, join_id, token and msk from the saved
> cookie entry. local_id, request_bkup and thmac are never restored, even
> though the SYN path saves local_id and computes the other two.
> 
> subflow_ulp_clone() then reads those three fields and copies them into the
> joined subflow context (local_id, request_bkup, thmac). Because the
> request-sock slab is SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the
> values are stale bytes of previously freed request sockets, which an
> off-path peer can influence by sending concurrent MP_JOIN SYNs. A corrupted
> local_id breaks id-based path-manager bookkeeping, and a corrupted
> request_bkup misclassifies the subflow in the packet scheduler's
> backup/active selection.
> 
> Save and restore request_bkup and thmac as well, completing the state
> restore.
> 
> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
> Cc: stable@vger.kernel.org
> Assisted-by: opencode:deepseek-v4-flash
> Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
> ---
>  net/mptcp/syncookies.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
> index 7f2252634..3c25ff627 100644
> --- a/net/mptcp/syncookies.c
> +++ b/net/mptcp/syncookies.c
> @@ -27,7 +27,9 @@ struct join_entry {
>  	u8 join_id;
>  	u8 local_id;
>  	u8 backup;
> +	u8 request_bkup;
>  	u8 valid;
> +	u64 thmac;

Is thmac used for passive flows after
mptcp_token_join_cookie_init_state()? I think it's not. If so just init
to 0 in mptcp_token_join_cookie_init_state (with a comment) and remove
remove the new field from here.

Same for request_bkup, AFAICS both are used in syn_ack only.

The bottom line is that we don't want to increase `struct join_entry`
size without good reasons.

/P

