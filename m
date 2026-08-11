Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E2429CDC
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458331; cv=none; b=N3kmyj3+gT/CGZB3N8k5+WRyjYEnK8wGlXWcfe9Px6lby+z3ayoXIVZOv7ib0MzBSnjW8886STWukyOwCwM+bztj8ydJx/2yn2Qbs2WdnrpI9vRyPFlJj7e+A69yBrfH8UnU+ytpjpN6H/UtEOwVWDp3v2x3X1+2EmuH0gX9t3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458331; c=relaxed/simple;
	bh=vjUgIOzxtLUEqRGd12Zao0T1Qj0iZfGeHnedhIqz3MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7peB7/UbP51MD3tP6CB5T/B3qmgZqfogRiobQ3JlDnbkbqg12pPttpy9ILQu03/rzJEjndQd/AU7cfIgeNlteU45QlX7InN79ULv5MYmOHwCJ23TEqzB4HFyMcBoEuPiWWpgE+3DhfT0COaEJxk2ykUvPosMrA2rvQOuB976Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaUTjjyQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvqK7W/l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaUTjjyQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvqK7W/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786458328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mk55lgP+KqMZ/4ByZFmMGZVtOJZLa760GMLOIBHMErM=;
	b=FaUTjjyQZ8xV0UDef643yhDHeZjE8eNCIUXB0uCiHW2SaMczCyhuojLDYAmOZNCIOFrQod
	os4eyItSl7uvAvsEaJW2k196/Pl9hRDdy5q5nr89knDCKAwPHqcmMiAiQjbfuDpDp1wTUY
	g/o6oNEnDWkHNdVIqrNUOGAT9LP/w6c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-BPti-pTkPEyMr46IoSV9pA-1; Tue, 11 Aug 2026 10:25:22 -0400
X-MC-Unique: BPti-pTkPEyMr46IoSV9pA-1
X-Mimecast-MFC-AGG-ID: BPti-pTkPEyMr46IoSV9pA_1786458321
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so29607335e9.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786458321; x=1787063121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mk55lgP+KqMZ/4ByZFmMGZVtOJZLa760GMLOIBHMErM=;
        b=JvqK7W/l/6SUx6l9RmDCSeI9hgU4jVBF6NAa40J3NGhNvIV8hJGPmzey+T39mClvZa
         ihMa40ZjqfmMPwlFanQmjmbbvXxTVbrHNGm3aqMplNHMedR30MY2aIVWr+vIAwe8c/a0
         KuIbKv3MQ+9mSRHHBSeq0sL+QG9ZKJosaycbHPZ3eTEU0LmBSwDy+StUHSz7tyQ7ZSIv
         9JvUUCgh1N0WuoQPc7b1k1tCKZ3ltfOFNOuTgdgof96cvyJLj1gMCEkFn/vp1D1bhJvJ
         JnPwgMCqmj0qKlK1zzexCq9KjY17pNthui6ePf29sKuUhs1H3Wj5pA9zWs/gu2mFDqie
         Esnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458321; x=1787063121;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mk55lgP+KqMZ/4ByZFmMGZVtOJZLa760GMLOIBHMErM=;
        b=pjSnE7itDLLWxFWVYlb4/MdcQ/QYBysFZaK+0SwYegyHyrlrfLDmVL+mEz1OEjnp++
         yg9po8+IuaXCVL6zR4D3HndMvly+CX5vvW2FuFl7eY74HYwO7BLzRxZP2wYxWyOOhVr+
         eawHGzseYTkT1OaFr2b60MmkIKsUefbYbhtvVGo/ft9fCPmyfkstgNXmJ+ClMhQb/6jW
         dHY56alh2Cip+hJPYu0/f3Detr26tRHGdvlho/1MUZz+lT8T/IgnRqn6AUEtCCPpejo9
         VTjKs7z2b3BV6YcOR0MoAjrEK4NWe4RjY/a9dn12m8QHResc35giQYgLGGpWdqNZcdTO
         E8yA==
X-Forwarded-Encrypted: i=1; AHgh+RqhcFV04OyrsEIIyyDJocOYW01szaqe9zbwoCLd5Crx9mcj8UxCFXDAXzVBE25VAnkH4rGdu9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLY2AcHZnfk/UlPJBYcckMk5r4oUqW9BOA8XduJWxltFGD0JoO
	2xLcIAFy12/KRPoW4dya2s5Yw5CSwvwXSPm68kZvlD03xT1Z3heBb5znOxoaobwsn7uFmpQzGqe
	SmGaWfqfTtoZ2+uWAKJQbI8y6s6Wo6G7pjVYQYqu5L/hYmkoZA7068ExCQQ==
X-Gm-Gg: AR+sD124xIcPISc39A6AbKfeJwcPNhKQVfYpDtKTVLlbKlovIobjGLn1zClY+ZLp20f
	35oW3H+PQOAtzJioFzJGRA6mm/GYhr7QFXD86VqWEArrTM36Y8/C3vlXHjaggfES9OV0Iy2ZBwL
	cSAtpiZgbfw/2+PFrPoB0hvzXvsd6sBng4WxfiweX1+duO6mj1hVakiQvHofsvsYar3mc/pxP7H
	CmotqZICXHQAJIp83kob1MNSGBGiAUUi1bqIw+sUmqhpBFxKiu/TTOuvRvb9pF4lVUn71AgeiZy
	TUS1FoDM9mdVUm3O5oLEAu397H1OUHiExgyKe+zsQYjMnFZOXcYm5BbdMySD++F2bL3L+vAO
X-Received: by 2002:a05:600c:3b26:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-49978463aa0mr57108235e9.14.1786458320665;
        Tue, 11 Aug 2026 07:25:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3b26:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-49978463aa0mr57107045e9.14.1786458320084;
        Tue, 11 Aug 2026 07:25:20 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c3adsm37937915e9.2.2026.08.11.07.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:25:19 -0700 (PDT)
Message-ID: <72e016b0-d7bd-41f7-b17e-dbcd911c5a80@redhat.com>
Date: Tue, 11 Aug 2026 16:25:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] smb/server: fix memory leak in ksmbd_login_user()
To: ZhangGuoDong <zhang.guodong@linux.dev>, smfrench@gmail.com,
 linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org
Cc: linux-cifs@vger.kernel.org, ZhangGuoDong <zhangguodong@kylinos.cn>,
 ChenXiaoSong <chenxiaosong@kylinos.cn>, stable@vger.kernel.org
References: <20260731024253.148107-1-zhang.guodong@linux.dev>
 <20260731024253.148107-3-zhang.guodong@linux.dev>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260731024253.148107-3-zhang.guodong@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 04.42, ZhangGuoDong wrote:
> From: ZhangGuoDong <zhangguodong@kylinos.cn>
> 
> ksmbd_ipc_login_request_ext() returns an independently allocated
> response. ksmbd_alloc_user() copies the supplementary group IDs from
> the response, but ksmbd_login_user() does not release it.
> 
> Free the extended response after ksmbd_alloc_user() has finished with
> it.
> 
> Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>   fs/smb/server/mgmt/user_config.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/smb/server/mgmt/user_config.c b/fs/smb/server/mgmt/user_config.c
> index cf45841d9d1b..21b1d51d918b 100644
> --- a/fs/smb/server/mgmt/user_config.c
> +++ b/fs/smb/server/mgmt/user_config.c
> @@ -27,6 +27,7 @@ struct ksmbd_user *ksmbd_login_user(const char *account)
>   
>   	user = ksmbd_alloc_user(resp, resp_ext);
>   out:
> +	kvfree(resp_ext);
>   	kvfree(resp);
>   	return user;
>   }

Fixes: a77e0e02af1c2 ("ksmbd: add support for supplementary groups")
Cc: stable@vger.kernel.org
Reviewed-by: Thomas Huth <thuth@redhat.com>

