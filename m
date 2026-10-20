Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482559;
	b=Xi4K0O8CxKSvGn3WyWUFBTHfiHVAnxGbLm9qRRuGVxw1jn7TI/oy6TJtIPQyAt/UGKJV
	 Z10Wjaw8s7TLtpMOQiHKvbrn8NvwSsPaE0eXFbQn+mE68eZicydIIVpupxMj+4qRaNh6U
	 TAr2QOjfo/Q7bHp3ANj34OqJuOgRdag5Dg+ANoIxGauIxd7lr/l7xxWFqWecMtREi7fYQ
	 un5nG44Lgz5Fo0N5WjtkklQf6W+gBP9AtJ98tu8FA0PvXgMnq/x4B3gvdPSNwzNQxaJTn
	 vuhovjsaamvbT+gpUNP5C7a4O2LkONE/W9aXEwZheyBUeu7JO2htRvSRDpKBnKAyP1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9L30+UnUca4cXFOJhOKpyYquJIxK9YX+zDZ/0S6HO/M=;
	b=fn9qzw1xDgwlGWPunZ+HBwpANcWMBMuRNZ2TB0Xp7F+gqtVxW0ckYCZnLCTE0LzLQ5Qk
	 Of5hNdkOoQphrAxCIsuqeqhR1z7D2zAa/hiywIzrm3bgLd1F43d/VYlUkJoz/L8k169Ok
	 MaTXr00USU2lSkT46Tvh/ahCaFIsKpywIKiv9J3Z/V3uXRggjdWnTlRnJwAvOcOtIfxr5
	 uSKFa6OEiyshOMEr2xhMxs9Ang9o2fIG38U/unBc5UUd7HaIVRPc96ms2XKDk9tAkePGH
	 z6787z6MxY//hEK59TT9aN5f8Q+T+hZaY9RMFr/Bbc0L2/GUwoiYrC79eHtGYxyaaGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VzpDaso2;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD9606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10DD9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VzpDaso2
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso13854435e9.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792482557; x=1793087357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9L30+UnUca4cXFOJhOKpyYquJIxK9YX+zDZ/0S6HO/M=;
        b=VzpDaso2/uouiP4bcr0O0J/4xg2f06wxRgcN4DrR7md+s+CxoIRXQHFnJtKl689CUa
         9iz4IvYASRHyAFAuysgHhpv0Gs3z5BQuDaNxebxrM+6sjntM/zrMHdIFMAq3s5wQgIjH
         Uim/QYpw9b+nVwd03aGFHSFQQUj9o4ri18GDnNrcWJne3FK6d3GRHq75a4nqzTsf9FyX
         DziOPAmSMF0qDQ3X+q3u5TowIAPVXdcyKD9UhmL0JJQc//k1nBxBqPHTol6wtHJqBW6c
         SzxJVXK6EomJpjQeG4M7F00oRB39ymHybRppbuVRO56gWjrxIaQDlROddBwWsTI4gzyy
         69Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792482557; x=1793087357;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9L30+UnUca4cXFOJhOKpyYquJIxK9YX+zDZ/0S6HO/M=;
        b=qiwdKk7ZpfakQq9bkZUoLsIK03wQ9E0byn9ZW+UNJQKFBpf4braaoAr3xuTukrdNsJ
         7gYpbi3vG7CZUQu2rh0MuG1S+vjklIP0oxNbPq3ujj+f9c/6CH9NCbzynVtzsNk0K4b7
         Wp2XedF6jBbjSDIuHW6FJ/MBR90XQdNSQAOK8VnqBvWJvSDVPC4bWsMqiqm6WftL7enj
         /WzDd/Q0RXsO3IJRRw9UgUXuckKTIc8UoH76O+86JBIepmWCV1Sov5henvorDBGXNq8q
         XYrLRlVJgPp9PZjhF0vAPmqX9XP0GlgBURYNEHsMNIdc6u+JuIQLGkUvTlXdaZ7jPmCS
         4UAw==
X-Forwarded-Encrypted: i=1; AKwUvBzhm1oJ4uWjIyki4cIvYgQW5cgeSv6pNFt11sSsxbWMRB+TKqgluSsnnGMVRDfOIlrgQEmnBwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuNfABHsdNQbnVuhMiZlUbA7pBaDnGlk2X2aAD8X4FY7bhSLUD
	48FXiwHpAbPdnEwmph089FP4p/A4ER3fHDjpAiaPO6NiX1cOkMCdA1E5U8AkEoS0GbrDU6uDr9R
	dlBeOWBg=
X-Gm-Gg: AYBFou2CUZ7AkF+DXDWADAh5et+L47btlMtIaX/O48LMQJWS7Wt414w9ozQzflnctak
	l452yT9GK90oQOZ57gVs1IYPGh45xZuQNzqG97v63pNrFOpEghSfP/hJjTDEG4KPyHRJhssHXKE
	GSW/hTyyySC+n+4HpfLcYpScTF30CXyo0UkcUerxUW/GfbJ6AftC7yO9HERJL6uehQr5jikG95l
	futGg1eyTuuO3UHMjx2USb+YvYlA5ZXfyewiRT5KwDPS9eJ8JVBlhRTC1s71rxaPFUiPmgaoKqL
	AcNgQAyAY8oLgrKoLCTgoVs1Nakxv19Erc6+Qb12yYM8d5OJ69T2tacQNiBmJteT/mrmmCRSTCt
	cp4EyAUwued2JfVnaXln5i4OT2zi2vcKWkeR6wSMPFQ76tetvOprZmTqZFdCR26CCY4FMG7N1Tu
	4/18A83xNJKP+2qOTFPnJf8JqOPIGWZHKO0IpDkrp4fthrVdCKkBmRVmkcZdA1ohWqwyUsvq6JA
	ZYYCG0o+2oP
X-Received: by 2002:a05:600c:a10c:b0:4a0:1a7f:2abb with SMTP id 5b1f17b1804b1-4a1d75fe221mr168268455e9.11.1792482557376;
        Tue, 20 Oct 2026 00:49:17 -0700 (PDT)
Received: from localhost (109-81-30-107.rct.o2.cz. [109.81.30.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c1e0e6sm61126865e9.0.2026.10.20.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:49:16 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:49:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, david@kernel.org,
	ljs@kernel.org, dave@stgolabs.net, roman.gushchin@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <atcc-91WerBlJ_Q5@tiehlicka>
References: <20261019185002.3428594-1-gourry@gourry.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>

On Mon 19-10-26 14:50:02, Gregory Price (Meta) wrote:
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

Would it make more sense to 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f11491ee9ed5..e07db9514e59 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7963,7 +7963,7 @@ int user_proactive_reclaim(char *buf,
 	int swappiness = -1;
 	char *old_buf, *start;
 	substring_t args[MAX_OPT_ARGS];
-	gfp_t gfp_mask = GFP_KERNEL;
+	gfp_t gfp_mask = GFP_HIGHUSER_MOVABLE;
 
 	if (!buf || (!memcg && !pgdat) || (memcg && pgdat))
 		return -EINVAL;

That would take care of try_to_free_mem_cgroup_pages too.
-- 
Michal Hocko
SUSE Labs
