Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293964;
	b=OWhFkRjLbMDrTetTCp6fxSAJaJT7UYKe1KKovFkTeqluBRnTZE62TXdK4U9vLUIxr1uh
	 jOuvzMOOUYDwQM86ZkjN46ARfre7kRuaaXZWQRymQmAG0Pd2DVzbr3KxL5LcbhsnmAsts
	 +97x380LiMEYLEsI3VGTDXQVvXb5Rr5DbYbr+0v1/xe6ssSsEtonedAvSeQGa6yhj+sQO
	 TUXmSo+/a3kIl3TZV0bEYn6Vatf5jI1f07xoCqRkdtAtQ5g8YOesYJkdYwFhVO9I+ilih
	 E4Uid2rEaYXM3wvaY5BsJxwUMp3EkwhA3Gyb1wJ/7YfyuaMF/uCONBj0JgV/LWbpZjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=dqlkwUV9tYAEbSb1BQ5TfPNY6DFBwHzpfk0RyIwAqNI=;
	b=mjXgC9+5Ve5sowgdTlh1L6just7tmrRa2QxqymH1ta6qutW+DOuj++RToojlXWS+HZ39
	 C9pjXuhqUSIN9CD1AoSkuQIlq574foYkyMUclasvQqsVZblMyBbg5zTqDx+avr4Uwu7FU
	 ouSBTLrN3O1b14cN09Kb6MQ0qvPJAHWu1C/mDSLVJvtRNxxdVWz8hCMcNI2RW9xI1fnIS
	 ZhE7BUZBW4OUTZMiw4PSYWeUpL+nPEQCEgyBP3jDfEJpcpkWco+d/ukmdlEe1Mb+NZVW+
	 pmPpcElU3dl4/QL8PA52UQVJHuO2p150ZuzTJ0kz7P6kgoFjv1kiGfle2Nh2L91kkwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531B606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A531B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d68de53053so1246229eaf.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793293961; x=1793898761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqlkwUV9tYAEbSb1BQ5TfPNY6DFBwHzpfk0RyIwAqNI=;
        b=jbB7m5xkSbMsVHA43BS/Wdw7yxNxRXuSxF9sZjwaxRsa+P9Adr+maDdfwjMVW0tt5z
         9xy96Ryetgo0KDwM83jlI3Qo/k8orojzOGXRu0ZmRbtx9rvEamnNQ0KR3vl9oElWqRvL
         AYaVN/0pXl3h5Hatlvx2he6KkzZ7uCNhnrEhE/2UFwIiYzli25MdkmJpnmm3BQS9c8Sr
         FM1+0Olm0viL1RsOGum9YEGxlmLxRhW/uYgQlvKZ8Sb0O3IZIQKgR4CuHeqkj6iv5dkO
         tu2hCzV+TdcC83N6D08b2nNAf8g+a+zQjqfkdjYRvCQ2rFNM4b/csRoyykbSApv5/jH0
         t+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293961; x=1793898761;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqlkwUV9tYAEbSb1BQ5TfPNY6DFBwHzpfk0RyIwAqNI=;
        b=dl+1RYyhGeySaf8/NWPaiNCTtTH7AHPFRuvWoLN2kNV0+jETPKGovJbWoeA2f2Cfqm
         1etEJVGNPBnSvau6YZWRWqRUh/L5+YENOcGEY32+81fwT+Ek+eaa7c32iUBZ9aQR9zt6
         ligjIDvBvucMcfZ6Lg7wmnPqHTgw7cZnjs1dNqos2AEQdapVPKzD1NiwRVjrsjS1LOYx
         22eml6xynyFPWg9YFQ41/yzwEk+s7TVlxDD4SZ6nmX9QajUm8rIjk4E6VYZatkUBdIl4
         zPdcRMf7B/5IsLQ10edEt/KW+4eiNL/uKqjLYwWkdqY+BqdQvCrfzTp7Gp+3CRQZVx+a
         Mrsg==
X-Forwarded-Encrypted: i=1; AKwUvByGnWtHACtxegMd31fZAHxoMxsSU/9csS+LelOFfXqoZdHefneluWVhtyoDaYf0rqRgCIaWNZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKStQkV6nVnhTSOs9DAGjtJ0Y3uLUam54FTksa0lafQNemvBsQ
	EyL4nJxpy20PLBTw7Ws1EBDEHO96MdJrILQRNvr8h/fBuQ1g4IGrM325VMlbubu+4c4=
X-Gm-Gg: AYBFou3BNtwfLt8swKyIZH8gYEULOi6R5vvw0ggFy49ryXnLGRkF9bngVbwu58Owdr2
	5BBNx7GPV8Wjpg8WZBG2oQrHTyQc1BRLjB3Pd7WEa/sTcEfxjGoJNkZaYVxHlhtpa+lN1Bo6lSe
	8alQ5Nfa3Bz6Z8A351EDOg7bHuFFTHdzsxDEt6qaZWzLCwq1gw8dchCBkxWwYjAidNCDkoPb/mA
	+L3db6pwSpIbhWV+wBySi/BTS9Wj+xT8hIQIiDOGKxjnVencrlcL1Gfb323D60CSot6fOyBxmX4
	5v5VLNJplGjKvI8PvaIgv1SxpCuft3uFcQOPhTTlhd+hcxFmpJzgvCj+ymlzrOouGVWZAxsCn8X
	7+nx/ralwF2IQ+p+aXof7l0vmmXD9gIqOmX6aDsVjJ8YsizaCHDtSR8kn6jG5WvGcmgpucqOZoH
	dzT2Kn0KkwLgNDMzgFDJWNUVll7lXy0wYvm3ZW+9tiPlB3Dqw6Fr3ZhGC4yMAafecJ8X3fS5DWU
	dejXdTZjf94c2PpFWgfW3mdhmcfsiiwdwzfLniwu61ReaiHTacXzlh0u/+UJrROYrrfqQ1qqywQ
	2/foVGC3SLVF50RQqq+HqnKMCNUDYE0O+ogDUO11gcS6a8uDcNBxxumd2pSWLn05qqZBgNEW+JW
	6QzW8gI4MUA==
X-Received: by 2002:a05:6820:1505:b0:703:27e0:354 with SMTP id 006d021491bc7-713efb14bd8mr3282860eaf.66.1793293961512;
        Thu, 29 Oct 2026 10:12:41 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9049af7d1sm463fac.12.2026.10.29.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:12:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Baokun Li <libaokun@linux.alibaba.com>
Cc: ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, hch@lst.de, 
 dm-devel@lists.linux.dev, mpatocka@redhat.com, sweettea-kernel@dorminy.me, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261023081908.3505413-1-libaokun@linux.alibaba.com>
References: <20261023081908.3505413-1-libaokun@linux.alibaba.com>
Subject: Re: [PATCH v3] blk-crypto: fix NULL deref and UAF in
 __blk_crypto_evict_key()
Message-Id: <179329395926.1528866.6542405425751626681.b4-ty@b4>
Date: Thu, 29 Oct 2026 11:12:39 -0600
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 23 Oct 2026 16:19:08 +0800, Baokun Li wrote:
> Sashiko reported a possible NULL pointer dereference, triggered by the
> following flow:
> 
>   dm-inlinecrypt ctor            # first use of the fallback
>    ├─ blk_crypto_init_key()      # succeeds, ctx->key.size != 0
>    ├─ blk_crypto_start_using_key()
>    │   ├─ hw-wrapped key: -EOPNOTSUPP
>    │   │    # profile never allocated (NULL)
>    │   └─ raw key: fallback_start_using_mode()
>    │      └─ blk_crypto_fallback_init() fails
>    │         └─ kfree(profile)   # not NULLed
>    ├─ goto bad
>    └─ inlinecrypt_dtr()          # evicts whenever key.size is set
>       └─ blk_crypto_evict_key()
>          └─ blk_crypto_config_supported_natively() = false
>             └─ blk_crypto_fallback_evict_key()
>                └─ __blk_crypto_evict_key(blk_crypto_fallback_profile)
>                   └─ profile->num_slots # BOOM!!!
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()
      commit: c8c53d669d4e45b3a804013251a34387d7e11bfb

Best regards,
-- 
Jens Axboe



