Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CDD43FD06
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457963; cv=none; b=RW3wfVVP+ywQJpqenNiWpsxvT4HddUrKkoIlYpDyOPN+i0mTdhpnA6XXj83OiQrH4RLMn422rJwPN7kQf3ocAyDsNTD5xhaOW3Ug8Y4ltqmnCZNdH8r47YNBMU0wklYu8Oj8PEwUD0hY9tgWg5XK305E+QGm5XLoLMfJsEvLuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457963; c=relaxed/simple;
	bh=5zleF2k56Z9KgeiyNaWkJLGR9c2VRZkI+asDGcsuXU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCWsO8OXt2U7J/RjaFxOS+MMjeFT5CXom+y06elaXrvVH7WQxXuWrHYu4U2x5lcNe8lEns2HXg52h7lhbT4ECbaM2amZaT+0uyRh7CptwBU2t+iHmtQTywWikhlfliGN+IbXhUNKR8VPWv6xdFE+QEQ6tSxuFza+drriUOMxeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7b2l3zn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmMpEJgL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7b2l3zn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmMpEJgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786457960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/M14Rs49nz/MFkq4obEJEIRruM5aSBskxS6pKDN4fq4=;
	b=K7b2l3zn7m1qmUCqZ8TBtZ5Uv6iaZRh99DPLf7X0kdROEKxf0V+CdBzAsNkYtyYXopjQ4W
	tFrxmH4S96d7i/qYXpCyMcvMvq68SCTlGm7ZX+Ro6QHG2M3t/UOY00f88UgTXtInaMh7Sn
	h/Rgk76ZeW64BOqF6mrNP71dytM/XOI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-0zBPpQHJNByj2JKlpgn7Qg-1; Tue, 11 Aug 2026 10:19:18 -0400
X-MC-Unique: 0zBPpQHJNByj2JKlpgn7Qg-1
X-Mimecast-MFC-AGG-ID: 0zBPpQHJNByj2JKlpgn7Qg_1786457957
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954a93c565so17041295e9.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786457957; x=1787062757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/M14Rs49nz/MFkq4obEJEIRruM5aSBskxS6pKDN4fq4=;
        b=AmMpEJgLPQId35+omWfpaBxIs8dFZ8rQTFTC8SW2ldGFgpKBNo/lKfjhnRRm8eByTO
         gzSEXRwaCu2OpOX5ZpiAU7wFdXLyoIFGpNNDaBsd1iDM1jhr4FV9FtplSbFAXlm60vaP
         nZLG7rph1qjUdYyOe1p2Z3G9l9KhMfHMHsItktVVMznXdYPNU2tTa9aQujH00XKFQ1s0
         0Q8D6D//pNbAQBVeTqjaGbha3OqDWycIiiM2CRWWpDma7Htmapibdz+ETXBvT+Pidix1
         kFzNIVcJzFY6GRW1tEQeJojHA94Yyb3DFpl4i1+1hHV0IYSqdAunv5MoVrh56D6tUtfR
         ro9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457957; x=1787062757;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/M14Rs49nz/MFkq4obEJEIRruM5aSBskxS6pKDN4fq4=;
        b=ZQs1vB5y0hL5VnzTH0GwoTRaX46M8NeKswnY4Xx8J0Yh6MDmAKH5q5CbTFMQgS7m67
         72PSM+bUGTw5rg4Lvro2FOpQPecHouq/s4MqSFGO/ztQs4SCToAiRQjTEzNjcjt/ej6C
         n3AiQV9ZyIewDMFyyabGTkr8v0gMtkX5KcrfHk2dZRQN66YcmSeD/h6PUTEjsikBAtzH
         tP07Wk6wXuYNMyf4g6PvS3xZW65ssPzS0CypWs9TpPSmmKAZkYjBojO+2Fij2PZdpnX1
         MahY/7wsjy9H7HJmpeDP/xI+dW6mlMOhOJYyMrh5apkAEEfJS/6yI/MKpdQAgHaK1ek3
         PAwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPNM6mmkKwDgAjpSAJqPKi7y9eA+cqWY8FZ65LKujdY5s5TaKbUtGXr/50L0QR54ArYb9VR+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbybiKiBqFZVKfWFnhuZy37LTspQtjS9Ow6yPRu7IHuLFgFyk8
	ZiZanLlzZ3x5GnFqJOotWg/u3v2nMR4RfDz3pSGIhVQoEDUz7YGjTH2rdHT5ZgBeKEqP1tYqcO6
	crDI+dPI4nywG1nKZY60oo8nUEYbIKgISrb0N64pIoJSOh+s0LcfG1ztwGw==
X-Gm-Gg: AR+sD11sJJDvviEekdRgnuVEocshF3u0XtYFo3mnjIEODAtGRhAVyMr6GIm4Fgnvbd6
	s2UN/s2ktfOc0N4f+55AcUP6gsq23z2bel2g1+YuzqNwca7pOfIbSMteVNN5cepIf9jYgAhGGj0
	atG7gVNM+M/S0XvhYFO2JQn1sJRlUM2Kwwbks1rRjqgmv8id7pt3X2fG1hNkqztAD5Dh3siR+eD
	qNA7c19c00UtFRBw7coRNLQojZTsDRdWL8VPbQYZZmD8aSiV+9eFMdTU8clNuaXkn+NSShTo95u
	KSg3naRyqBJci+9DyBLYjwjrQ8y1Oh+mm1To28/vVr7zxmxtdHF5d8Aosc+DhINDmmzCmArA
X-Received: by 2002:a05:600c:3506:b0:499:737c:f24b with SMTP id 5b1f17b1804b1-49978433c06mr51353115e9.5.1786457954451;
        Tue, 11 Aug 2026 07:19:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3506:b0:499:737c:f24b with SMTP id 5b1f17b1804b1-49978433c06mr51351845e9.5.1786457953815;
        Tue, 11 Aug 2026 07:19:13 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977e57696sm36916575e9.2.2026.08.11.07.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:19:12 -0700 (PDT)
Message-ID: <da4963f3-1079-4223-8506-b6919c597da6@redhat.com>
Date: Tue, 11 Aug 2026 16:19:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] smb/server: fix memory leak in
 ksmbd_krb5_authenticate()
To: ZhangGuoDong <zhang.guodong@linux.dev>, smfrench@gmail.com,
 linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org
Cc: linux-cifs@vger.kernel.org, ZhangGuoDong <zhangguodong@kylinos.cn>,
 ChenXiaoSong <chenxiaosong@kylinos.cn>, stable@vger.kernel.org
References: <20260731024253.148107-1-zhang.guodong@linux.dev>
 <20260731024253.148107-2-zhang.guodong@linux.dev>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260731024253.148107-2-zhang.guodong@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 04.42, ZhangGuoDong wrote:
> From: ZhangGuoDong <zhangguodong@kylinos.cn>
> 
> ksmbd_ipc_login_request_ext() returns an independently allocated
> response. ksmbd_alloc_user() copies the supplementary group IDs from
> the response, but ksmbd_krb5_authenticate() does not release it.
> 
> Free the extended response after ksmbd_alloc_user() has finished with
> it.
> 
> Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>   fs/smb/server/auth.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
> index 4e7b6f0e6b8c..e886ea5681ca 100644
> --- a/fs/smb/server/auth.c
> +++ b/fs/smb/server/auth.c
> @@ -464,6 +464,7 @@ int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
>   	*out_len = resp->spnego_blob_len;
>   	retval = 0;
>   out:
> +	kvfree(resp_ext);
>   	kvfree(resp);
>   	return retval;
>   }

Fixes: a77e0e02af1c2 ("ksmbd: add support for supplementary groups")
Cc: stable@vger.kernel.org
Reviewed-by: Thomas Huth <thuth@redhat.com>

