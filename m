Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441010;
	b=SlzCtx5ou/G7hosS9+OMlBTjNW21+wnwOeV7JXeSWd40YxEZ05y28b4a7R/Kp6NfbLCz
	 6WhoY5tntnpgA1PvQeri2CjpHe5kMTsRnbHn6T5E7t74CCatQ8pVlY9HIZhFOmEhN+bBu
	 obQd9IrusIFDmFdQdzQa5NPfOCPx8X/sQO0ZF20GqF12JJWuIg+ivURjH6Vbdgwz8qOzg
	 rzLUFLTAdl3F8rNXcHS2U1VQDH0IgW+ey1Qn+2l/ZGHfP/LlNJyun3fpxcrc7/R3mRgBf
	 rlQXVAnS+icx5Bz7IW/FbWjmJSdyjUm6ndOInWAdsWtufNQRJI42rmBegArMyfrsLRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cRFDv/zqlCdXHbrIMKFJTczyEyv3i5WFE2Tuk2/B3PI=;
	b=o0QzEVjz08GBXNyEOek/4QfM6l+Wl+nFKOctSLnYmZF5i5o13tiRYfkkODeh3IEF3SeJ
	 SQmb7xWM59WVXibgPOl/IsNNpmdFrDyRS+deU54zEafL7asejsFUquEqt1MLKYuntT/QF
	 9fMeGqjrTWzSYak4EGkHkna23Fs09SxIGnQ4U8mnwywt4v3o+xgxzIjVSeU7pka/ry7X3
	 zuIw2q+0bwKPiB/+Ky6kS3cN4qcQPNWtC5cxHInkGmK2jobCzyy2Ltanu7TDQXb6T/K4j
	 64DaB55DGuCwjaoHzdmH5/bIgpjZXP3WBVY8NRiU3qmqwNlQaF4+mbEpRApDnR8HZpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=Ev5bcVVK;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B8606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE4B8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=Ev5bcVVK
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6798eb0d13fso1926902d50.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1792441008; x=1793045808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cRFDv/zqlCdXHbrIMKFJTczyEyv3i5WFE2Tuk2/B3PI=;
        b=Ev5bcVVKrf1S47seLR0CL8au2df/RJpNHkTdS+2x6MOFdjl905Be7j+4zV9L6cBn52
         J1eSPwkkC70EPkeJdQqcsn6vNCooV7/yXAtf6IplqMopCr6LAQ8hVF0JLE2a5pg/wANu
         o1zcZWetZcygLxqUqiNCwVePNhSfrfFSH5NneFwSMagy42gr/pHL+VJ9fSrXmem+TcuW
         MTRX+0AWh8gTXWUCb27wyb2ygRzSU/cGehzfLikXMyNdHNJ2FmqF/325mnRHGC6MQVM7
         NO0w8xO32wKpSOtIbvq6Hw47QZ3uxskN2GnwiI1wYsJoOX5tCd+jetc3MgpeAQj8pf1A
         7RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441008; x=1793045808;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRFDv/zqlCdXHbrIMKFJTczyEyv3i5WFE2Tuk2/B3PI=;
        b=fmpQKVb9Q/FiAZFu0yoO/1jmZed7tIdMUHn1u/7e0+pOCyjOxul4Ab/xI7lq7rTu2z
         Vvjilw969panr/oe2CEapUXa+b51YQdLZk0OG1nj6NWjo7yj3yHx83mMwm5B3M0Uflox
         yrtiA3U+WAjMPX4rrc9UnFHf3LNYGm8ztjyFanJKvkNbxu71iPZR02aI5vDo9pH2pp/N
         pnsuWHZoeESlGlf0KsEeKWpZs9KdtUao6H+sLCyNeVWS5UMlhPrHPvNaQtoY9nSeIb1o
         CgeQlIZxUNQr5ozxipvEcuOZ/+38BCUotsRnYYiQVaMwWGIUcEQ+f0dAB7rruQFslRiP
         sHNw==
X-Forwarded-Encrypted: i=1; AKwUvBzhSu++API+FfvELoL2GL4xwi/xSLglT16obyhn89mGkXiJTPO9u38lAMW6IFC9mr2ta9KE1Ns=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtV7yHZjwdgvkDkwyLJv7EuabWaG2inL8ADgyCXTyQCP+9BlCM
	QE8VSy4UPvxK7UJftqBeUO7Ao/GOhcMwd5mocUmTbuFfrPYWoxm3Zt9q2xzps+YCl4g=
X-Gm-Gg: AYBFou0nHUsPcjvEe2re+iJo914hxEIlSo4R+WffmMHkf1tpCYRSdJNzWrU3kMu3n8t
	ej6ZKuoYyZvFj8AJWirBSSfxz+NSKTzdOBO8BueCiXcvM+re2PcAtxH6BNKJNgf4KRvYtdf+WWX
	289L3YL86qcYSg3l1FWMNnmPCevaV211NxxLAykPEnYltpU0fgut/kKjFGgak338QzsgoQdyzMn
	Fbu2unaX5p1QE0JpY/RjC3vajISpvxrSU/MMacCBSAimiojTpjRv8ng5kv8MKnCXBDwI/PUw8S+
	JzzYQUod1+1vjbPcfdEZepfnhDYuDoQ6hoMShYUg9Lxi+veTnOVR4q38uXSZQTTaTHm+t/79YUi
	LoXnEyQMoKz1duzx4V8jPSMnr59kyyCEVJm7faYmgIKRfyFKFe6yqHLem4PRkp3NXVn8ymazvQ4
	r0zgWOeEHBe8FPa/G0jRYRCUmUeILCUyKQF5f1ovZ5RRAbGmfEHzl3AM+DUC1pAir9eGgx3Q==
X-Received: by 2002:a05:690e:1381:b0:679:9b34:a2d0 with SMTP id 956f58d0204a3-679ca54fef6mr2000528d50.18.1792441008370;
        Mon, 19 Oct 2026 13:16:48 -0700 (PDT)
Received: from localhost ([2605:8600:200:1d58:2ffc:79a5:7374:fa95])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b19c3933sm4507704d50.0.2026.10.19.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:16:47 -0700 (PDT)
Date: Mon, 19 Oct 2026 22:16:45 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com, david@kernel.org, mhocko@kernel.org,
	ljs@kernel.org, dave@stgolabs.net, roman.gushchin@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <20261019201645.GK371161@cmpxchg.org>
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

On Mon, Oct 19, 2026 at 02:50:02PM -0400, Gregory Price (Meta) wrote:
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

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
