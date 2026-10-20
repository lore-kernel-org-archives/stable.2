Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526338;
	b=yg3t5b4gc0MsDnqVNX2mtJpcBZ0tpt8U5KcmF2ZS/ItYq4tqZqrP4Zm+yFcnNEhmiPNC
	 GsIIz6FaRKVv98d/fEKgzDZKU+HcpXttNTYc98dWm7sGvU3B5GpLyMlK+UQy/9b+smJC1
	 NYdBc2jgaUDmccgasaang4129rbHENbvwHMyTGJazxfWG7MSwIMjwq7SlHJMRm/BguLeW
	 w10t6G/cJE74Fxp7gmj/KU0lMg7QTMaw3KzEfupQMc4W5yhh298tOd0FSitI/C63suzVB
	 +tAtqhcDQ9XDslkNx89lrNDPvbXVLQ7lXG7v90kF0hJNUQSVTqn1f7MyAK50vWlq59Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=d4lLCzzpRL6P4ForBOyjOrBe3fXm0rVhcelSyIuV9yA=;
	b=YORpHE3MnfYaHr/6oZyHGRUeBNiBBJdjl7k/+Nbe60RXnS+yUQ0oYDa1aix+xbAMmPW1
	 PzpnPWiz9ZrTdfc1k9YLpVZ3AIXWGSN64pHvIEFI8j+03+vKG8qKeM6c9lf294Idfu8iB
	 PTDrtZT+XtTtdYNuGYRZfQCbbojaaUo1z7xCEF9gI/q0ku2I4Rt9kiTQn7p8UHLLK3gN3
	 G3RkKJFj0UpkAlBnggeofTQRe2zxHbO7TD27Qi3j4ua9AwZGV9ZSprZwoqSnpYsNZsV5W
	 T0AQ3Y+G+NbfVn3WZZ4nbTRFM56YmmxEKxdR2zO6iaADC4qwiWZ9/eYg9VwxbMizqaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LzCo8A4I;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E982606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E982606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LzCo8A4I
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365b48238dso540901cf.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792526337; x=1793131137; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d4lLCzzpRL6P4ForBOyjOrBe3fXm0rVhcelSyIuV9yA=;
        b=LzCo8A4IvZ8Z1W18X3GnCQ5XNacmwpBGDkf4X5K7kvbm+ig3VfG5k4rwKTVQgheeSp
         IBZ8spJO3jGGMeIixxTvpB3IEO0O0kcquIbfV/AzSmsLFHBr7mcBCONId4usExtE1Cgd
         3bQ940R/MZ1/Y3dUk53IlaOegRkUySxL7eNI0kIURK6XbVoG5OiBJZ0IYjkFNjGonXfz
         LVORTp47yxPQVlxa6W0QAVKV6nvgJSeiOD7BHxGQH1KSXtzhDAkKVG9bMPAkoZzIGVYh
         74365UTEj2OwivSFI5lkdvzEio1W3A+I1tlCXUjgSKMWG/W9L87KlgTzPIit/R7MJa/g
         +INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526337; x=1793131137;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4lLCzzpRL6P4ForBOyjOrBe3fXm0rVhcelSyIuV9yA=;
        b=2DUC8MvXCRdWjJn1tvi202KQUW/VpgNZk5FvAmIxmVinZyvAIfDt3rvck3ZQoyDzqN
         k8ZAEdYTfViFbbyBT4+wO5hiDN1srJMMtxKuaxxaRIXp6UD/0TXD9fUcu5thFDbIhTit
         XrsQzkRk4f7f17+ugsp8ZTv8D79sfgz5EM9lCc+/X+psLJwE7G4PWH8bHHfmcu9K0uLu
         v+rJSgrCKdoBnuRQVJhQVwrfCSjig4+mACi2pHcmTsk+epBp+TnW9odFRuAjt0LQT0vh
         8vUpBZ/5WtPGmCxnGQOGH47LkDvMKSzD4k59Cdq2El5HYwjnRhADpY5q8++jbnHAIYcz
         Ar7w==
X-Forwarded-Encrypted: i=1; AKwUvByPJRPYNJfOkEH5x2PtDsiwzcUD19ZJODPCIc3z6XcH/4evE1ZBFxXU6vI1fp/oHdj8gom4G9U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaNVR7JuCP52Yjvn210baj4YGJT52F1sV+/loBj2tFjXnXWCA7
	Zsmm1n0aWw/+XEc1tRSdwuIzxenKQ5lsMrC52xlHSbtxiCi3CItAzRyJHTsh0Me7QBjaEgaPsyQ
	3vHoV
X-Gm-Gg: AYBFou3L93MqTEWf/eDW483BbCzr4V/0Sga071iqAeFK2Kitm4GewTc/4utxV8d0ZNl
	tJwy0+1oUXevbhCgv2P5JIjcxzo+XBIN1TJDSb/beUiOZUF7YlJZmhh2OnvNpbTT2cck/am0pUO
	JLXZJS0Jm79bAr3P1/FaNpZgTi5TVWp3Q18z0pv9sI2jrzqC5muFbePOTT2I/6LgkXzFgedaFZW
	G5mFMd2ltW6owzwMVE4lq4lxxa/XwbP08I4RufEf/jDz+CMjFkWyFXneZSlbl0n/5t+kl3ygz9B
	6zq/vlNsR/WhelLp7iSOylVcTWqeczuOJ1EPhERWFl7Ew7eaIrdAPELNQd+nSAzR5ByMYwY8Azz
	LPsp2rVaFEo9Xwe/geecrqAdke3GHyLoaQgwvlEpqwoF0ZuX/b5oKYoSFo2eswW6SVFrpm7UC6M
	afM8TuVDI0KZms1V4zTF4DCOvshoz9kRMLf0431zVQZinwtpXMJlZIvFLH2s0Ig/KNaerX7Prru
	SX3uOUA7sModqt1Pqzkh50DbuMeZx9Aw6krKBbBirmZCw==
X-Received: by 2002:a05:622a:148d:b0:530:d429:c70a with SMTP id d75a77b69052e-53645fa0b84mr188171321cf.26.1792526336944;
        Tue, 20 Oct 2026 12:58:56 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698b427f5sm3856891cf.15.2026.10.20.12.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:58:56 -0700 (PDT)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Michal Hocko <mhocko@suse.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
 baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, david@kernel.org, 
 ljs@kernel.org, dave@stgolabs.net, roman.gushchin@linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <atcc-91WerBlJ_Q5@tiehlicka>
References: <20261019185002.3428594-1-gourry@gourry.net>
 <atcc-91WerBlJ_Q5@tiehlicka>
Date: Tue, 20 Oct 2026 15:58:53 -0400
Message-Id: <179252633386.238494.13826191476140121288.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-20 09:49 +0200, Michal Hocko wrote:
> 
> Would it make more sense to 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f11491ee9ed5..e07db9514e59 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7963,7 +7963,7 @@ int user_proactive_reclaim(char *buf,
>  	int swappiness = -1;
>  	char *old_buf, *start;
>  	substring_t args[MAX_OPT_ARGS];
> -	gfp_t gfp_mask = GFP_KERNEL;
> +	gfp_t gfp_mask = GFP_HIGHUSER_MOVABLE;
>  
>  	if (!buf || (!memcg && !pgdat) || (memcg && pgdat))
>  		return -EINVAL;
> 
> That would take care of try_to_free_mem_cgroup_pages too.

funny enough, try_to_free_mem_cgroup_pages does what my patch does:

struct scan_control sc = {
	.reclaim_idx = MAX_NR_ZONES - 1,


now, whether the gfp_mask should be GFP_KERNEL, that's a different
question i think.

(tl;dr i think my patch is still correct)

~Gregory

-- 
Gregory Price (Meta) <gourry@gourry.net>
