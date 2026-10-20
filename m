Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509585;
	b=ko5Tl3cxJR8wMrDMivyVm/+g7G9ZmsPPD4GTnRoN7Rj2ULdREWl+Y+8dUB0/YcgnQVse
	 7Nr9aCIwTGRu6qLilpoxCZfCulksRcZk0vT8dVAjBzS3mh2RCFzrVqd3rGnoWb0u5btVh
	 eikVQmtN1KS6cjSbOXZXantGL1SLQ7Ir2gbIyfpsrA/sQiKOegAupTg0EQzFzHz5FiTS3
	 vlDvGo35RuSAIF/rA8VUCLh/9rv7wA2fFjXSU8C24epTML+/wBrPRmlXhKWugwHJdiViF
	 TEMZ24FhBbIb3iaIPW3rncGmDz0QenCwvxmb3xi2lh8MoYr/XSQihC4aj++ez46jZUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EQYvwkMnfu+WDRyfOhAk5xxSPl+eH8WAQuJdlRRhiZE=;
	b=Y4GseFrS+j5O3vK50MaM8FrGrl+debg+WFv8uqyRt9RsDqBXZiK6VPBqnEGA/WhmkxbG
	 9yx9ZuLIW1wTaLKMF4WdmZv6UN02bL8cl3S3lkSUu+AbW3Q/Lz2tQRRKQflGsIoc9d8tu
	 OSKIg+eb016ap80e63hjAO9tNsCsmHX48QH0xEjphkbbyI0PNly+MeDyS3ei5cwjMtTQp
	 7xJNgYbWTyUQB1lPzoZUG+mWTOQOwnN3G3UVDcll08wp/tKbMZblNijHQCQfGrrLbDxEb
	 BQLS554SOhY3OSSPXmBTdnLr2lrqCCf2YQ2JLiVFdL0fyWwTSE8zjNT83W/oJCZWsQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elOylE67;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E2606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 891E2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elOylE67
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-881269371acso385034b3a.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509585; x=1793114385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EQYvwkMnfu+WDRyfOhAk5xxSPl+eH8WAQuJdlRRhiZE=;
        b=elOylE671FpYPFqd/y8nLw9VsadwwT47Kg+iRfXDgMFTCtriwXTRp1fTkSkCjiKmGV
         oZypjRWDYk0PzitNTdZ5pPRRkiNH/TK+jr1C8Ifm4akGuMsehZCTYV8IImHaajn74l7A
         PDQTEt7PPz2CM+vb1q/KmC1rSkK44cmvjN6E7qHTnmJGpCIEWPAKr2SHt+rQlLCCBkLy
         +OBdmK4BIJ/93KFrWzonjE0+wIe3q7rYAf/AhNr5dfzdqC/PS/5WmiEoRflfaNoaDz1v
         QKswNAkg1kOIfdvHW8z4BSaN5hrIlA4W5sH06uZNeUTI0M4rUs3lM1ZZqgrbWZFwgFhV
         0JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509585; x=1793114385;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQYvwkMnfu+WDRyfOhAk5xxSPl+eH8WAQuJdlRRhiZE=;
        b=nhFgPGvAPMfk0ffclL8iuT+AhSTynmVhY8zxSUz+cK6XmA9xZNjJYu7hX8MzD5tcJ/
         lPNtdkA52Z+9TKLZx/RswFR3oGE06AwWm/vOIKLLG1k26Gmb8lOPoT9uOGEqW1aeEluQ
         Zu+beW+gPCTB0WOP4m4lMKMm0W4d3i/wci67QaHJTmwaRcQK71eTXdiEViOIfioFSSRQ
         zfzKODo6A1ayY45reJ/r51Dw8nI9PNArpZU1eyququ3c8WBlGCu7qGCIhSM/gEgXMqNT
         Juq76S8NSspkfy6Us9yiEKhg9POhxdIoGnuiWoT7BspniUAiUaMmKhF2hahcvO5/s9g+
         dlhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjnIiD9hxKng6QNKQWVQJokV0bOaLGkNUOSBePq5sy5rBkLUL32G/YyGWcI2zPGK5LcFCSj/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCfAeeguFXYK95c07efnN9hHE7VDI7a7OGqgqmWNIPUZzHIWFB
	WtVwSOtkhppRZ7wlh5fMOxRPElQwWIwF1BPRzVk84VyCjKHhOUY4Bn+grr4b8MEv9IwGWx0n
X-Gm-Gg: AYBFou1ism9ZvHv/req+lBvgX+J8MzDUM7MgnAlrPQDho0aD12brPkih3DK2Chw/LeA
	v+u2UBBjxvypNKAYsZ3xqJfKubXKL8VXOcJymnObbi0NA+jw8wlEpqhlJuhdTxofz8kCw/NvtPr
	z8+ES5suBOkpvpv3j9kfRDu8auNYlzTRM73ZvlyOEyZUHrsbhz0wnQxOtPtGMmhXEILuV3kI1ow
	5RjtBbWGV4ck/Qdw3vu3ZBeo68wn9cRBHl0Lk6qr+oHwD2nqK9Ej4pVpwqm5CA1736vBHqCuOdd
	4dprGSXAf5FYYufu0a+7dLDhiOtjB5poYO/vYLUQ9r9TKL2pPKDirfk+M42V7M70tDweuYzHY1R
	FsiR1BnjKt9eioi66zQPH5JGLJhFftNROB3C/XGjVg4h1l8uVeBg3AT+i3mm/ASXTs2UdFOjLWF
	0uH01b4yhN6f6SDHg4D35ijl4qNsnpbTXYVq4wTjKXqT+PHi+4SWBmg0QN2UF0J5fWHEIAHL7IU
	SgNxBpCP+89MMnjEAN/AAWq0bWzs0M4z2tP0pix/K8RdZ6z4hARyA==
X-Received: by 2002:a05:6a21:4584:b0:3e1:3734:63e0 with SMTP id adf61e73a8af0-3e26fb99eeamr1595875637.41.1792509584766;
        Tue, 20 Oct 2026 08:19:44 -0700 (PDT)
Received: from gmail.com ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f56c89b97sm4994338b3a.12.2026.10.20.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:19:44 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	ljs@kernel.org,
	dave@stgolabs.net,
	roman.gushchin@linux.dev,
	stable@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive reclaim
Date: Tue, 20 Oct 2026 23:19:29 +0800
Message-ID: <20261020151931.885951-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 19 Oct 2026 14:50:02 -0400 "Gregory Price (Meta)" <gourry@gourry.net> wrote:

> user_proactive_reclaim() limits per-node reclaim to
> gfp_zone(GFP_KERNEL), which is ZONE_NORMAL. Proactive reclaim serves no
> allocation, but that limit makes shrink_node() skip every ZONE_MOVABLE
> folio, so writing to /sys/devices/system/node/nodeN/reclaim never
> reclaims a node's movable memory. A movable-only node, such as dax/kmem
> or hotplugged memory onlined movable, reclaims nothing and fails with
> -EAGAIN.
> 
> To reproduce, fill a movable-only node with clean page cache and write
> 200M to its nodeN/reclaim: the write fails with -EAGAIN and the page
> cache stays. The same write to a ZONE_NORMAL node frees 200MB.
> 
> Scan every zone, as memory.reclaim does.
> 
> Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e82ba737c028d..90f7a7bf4e426 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -8180,7 +8180,7 @@ int user_proactive_reclaim(char *buf,
>  		} else {
>  			struct scan_control sc = {
>  				.gfp_mask = current_gfp_context(gfp_mask),
> -				.reclaim_idx = gfp_zone(gfp_mask),
> +				.reclaim_idx = MAX_NR_ZONES - 1,
>  				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
>  				.priority = DEF_PRIORITY,
>  				.may_writepage = 1,
> -- 
> 2.53.0-Meta
> 
> 

reclaim_idx = MAX_NR_ZONES - 1 is the right fix — proactive reclaim
isn't serving an allocation, so gfp_zone(GFP_KERNEL) needlessly caps
the scan.  GFP_HIGHUSER_MOVABLE would also work for the node path
via gfp_zone(), but that's indirect.

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>


