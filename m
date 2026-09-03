Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DC23ED6A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425158; cv=none; b=iXPPHyqQcKzkDo4oDv1AGNtpEK36BiZ37GBNFDyUM7dNWIJbXtqLKTfYHqQTUvCPa2ew8jRQ3u+idW1ZCTi7O33fxpyvX6cFc+n/A0s6XX0TgooTVos1hEiO/Ax3xNsDsNatMTKw1aKLZ35cnJ7ZQOTp/uik54jPLjqMn2Ct+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425158; c=relaxed/simple;
	bh=tpyUzXZw87JQOB2A0BtVRjrqgVQvcnGOu2KYNihB4wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSTKksj3D2DgEz+YkSkSY52ss3fLzXXBlK5f4ycN02Q8iEPrJlN2iufQaUgVkz20LOTYsGSwPHXspCc7D2v++hi2mKhHA4x0g+X/BsnohHrKZHdoyMbH+tB0nEXiJ+f/Adlmv+9gMx+1rSw8Eo+aiwmaH7q7duqTUQ3Kfu0TKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXbL89DH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXbL89DH"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8525efa7274so1653710b3a.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788425155; x=1789029955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIa1KcxtKlzePvmdnnhCHyjrKBpT+nlLmPKgX7ZVzsY=;
        b=EXbL89DH86K9Q/xBSWhqNdc1sWketkV4MZJaJRdqayK94TMtbc+VeZ5cez/Hvz1bX9
         3B1tdExzyreKdZDptsiEeOMsKAI+P/1QTuoWJmcK2eudKLOFjiB64fzwaeG/lr/8vjx1
         /CDuOvCOyJQj/XS0ZhgGPoB8RjD+yziG2puvTE9vd9Kay4OIhqIdMTqv9KuV9v3AtoMO
         rSChWBngw95V6y86vm36VyF9gkOAKRG3vbml/KDxQa8T0iOcByVnMZEa+CA7J2aCdpJ8
         42iyny+Cu4zubgyEpOmGwY0IkIs6V9jOEQEAHh9CI0319hlbbeoEwP1Om1SwOevpdi/h
         8NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425155; x=1789029955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIa1KcxtKlzePvmdnnhCHyjrKBpT+nlLmPKgX7ZVzsY=;
        b=slM+rIaZ11sCd0Jql4pp5HKN0QRSyHC4Y8K5jfwKu2c9nUc65S+KtpdchwjkMxlg17
         /tfgYguBPSsJYpCTGyLaR6Th5ViNvVWCfIHOUCnuU+KkXspx2ttT/JNw0dFfn3u6+sve
         +RJ0TkQpEY2MOm5jmyLktLIvwYMPDXhqjDSIj4SXYQnpvStB2wFKuFM7hwBdETTktcTX
         H+FIn8NbTQ+8muEKZ8goTRUcG67LPBniI3E1oUYHc6itCk9T5vsNhgl1zailiPaYycTL
         8AwGqH4YJj7wQZ4iYnZo56vTAFOz5ski+tNGlQ4YckXcLMWvLpn6dvkgEIstocT7aLtD
         ijOg==
X-Forwarded-Encrypted: i=1; AKwUvBw90Eim5yd5t0F9y05gKfKMj/o0uefYiD5u3JJx5hYMgrQ160EvVV13cM1PHAIAAE2A3c5+mdc=@vger.kernel.org
X-Gm-Message-State: AFuF++luiigwCf1ay8hlljuJbrJgjpf7mMRVepVOKLra6lzGJQwHm5NQ
	yeooQ80mm+t0oJrtRjY6uB289Ug9slaY94/aXQLd1f1BNlKb1oLQjUOw
X-Gm-Gg: AYBFou344SsC0Q2kyX8ScVd98HiFHaYVnNpDiXjMXZRo/XXbXrJjTExkqAPNop6miJa
	8FJdiaAsAK2bpHziAhJqCIzyapKXdeIRRg2QkuoMIaSunIyjdAbKsvJRYy/nDvFzg8SuZbGLOXq
	bIpqsSSODVHmrLwO4uY1eE17UhkLHM9OtmEcWaxr558A7vBhxOWyGm0vGV5+ztwMdq9NtLwpmI3
	CG5nV0trUqexfPEUNf4xCUIhDJZ+FeKqMMlq33t83/lenKuzGmijRy7wl2rQcKVdnWazkJPsMVo
	1q1+oGPzuzWFpmW03HsowEH2lRKcjfKuRJTNjsgrGIcaopy5LNFdqnwYyw8WvlNa2EVmYVL+fa3
	5+KC3SlUjIYmTMx9SOLASqeTSTYyDowiLLcex+hPijrNc6/PujPoKQGICJWw6S/3hc/efB0youc
	e/FJkfgu2tFkbm8Z2GaKD32Do3Acdn7eQda343Wcsg9AGWiG+amiyn9w9X/tM=
X-Received: by 2002:a05:6a00:3696:b0:845:e8b5:8c49 with SMTP id d2e1a72fcca58-85ed24e33ebmr16410228b3a.10.1788425154963;
        Thu, 03 Sep 2026 01:45:54 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2e82sm2494935b3a.3.2026.09.03.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:45:54 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Thu,  3 Sep 2026 16:45:45 +0800
Message-ID: <20260903084547.960584-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:22 -0700 SJ Park <sj@kernel.org> wrote:

> damos_commit_quota_goal_union() is not updating the ->nid union field
> when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a
> DAMOS quota goal of the type is online committed in a way that it will
> reuse other quota goal's memory space, the new goal will work with a
> garbage nid value.  As a result, the DAMOS scheme can show unexpected
> aggressiveness.  Do the update.
> 
> The user impact is not catastrophic.  No leak or crash happens.  Doing
> the quota goal online commit that can reproduce the issue is expected to
> be not common.  This issue was not found by real users but the AI
> review.  That said, the issue can reliably be reproduced.
> 
> This issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org

Hi SJ,

The fix is consistent with the other node-based quota metrics. I also 
checked that damos_get_node_eligible_mem_bp() directly uses goal->nid 
when calculating the current value.

One minor typo: the [1] has an extra k (kkernel should be kernel).

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

> 
> Fixes: 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
> Cc: <stable@vger.kernel.org> # 7.2.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 20748b0a71026..53c3f97e3f126 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1143,6 +1143,9 @@ static void damos_commit_quota_goal_union(
>  		dst->nid = src->nid;
>  		dst->memcg_id = src->memcg_id;
>  		break;
> +	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> +		dst->nid = src->nid;
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
