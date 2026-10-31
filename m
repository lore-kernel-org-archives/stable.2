Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793421663;
	b=CB70WOlztyWq7hdKWjx6F2ZV0qj6TNtULM5zu72tuMfr57pmnKGVWSYZjP9enoOGYb6M
	 Hjtn2pQf2NVmjXujCwOuuf2lId3j4E9AH0ihKcLNq4KqeJCC6tads5oTJvxW+2B1bR8Wy
	 +xl8RDg5zZ2KzAojrsTfUIl6HQ2qw1aUDwPCrgfA0LCskkjmnyZVogKC/pVTi1Hp8N5Uv
	 oT+lvNPpJ6c1SoFNFX2vVzkpwyEGtii0fTx1gbZMBz0g0wCACjTkVAw8ZOgWynsDLllpA
	 utIFclRhSVFYle+clSPa/AAucftetIb7ENMrRPUxZClaORJDRZHT0JDJnuUy9AnARSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793421663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=mYAG5OYgNALKbmlFXyHbo1nyH/Yr5PiBp4YedVqYig0=;
	b=fggIqofbaTzKwx08XI4m2q1zqzvHqLwE+Ua8pRTwxP3X98tu8SgHpnCh/ihp38mV+4lU
	 cqnwumqXfCu4QWZgflLm/EnuCpLH+++CbIO6KF5+qLG9koy7LqrLvjtjSkc6yuoISQxds
	 OmisJrzVmjF9LouBG49TH4eRbcSezOHYjkdhLRQiNlZmWTZbQPQ0y5F/LHBj4P5tbvK7n
	 RKR5BMeVmSpRRfoyko+1Ohtcto0al/R8z3KOv2STp1SETarbZ11vQlDyJyL3eOpz9TqIU
	 tjaZe+Wx0L9OFvTyRCGHFrrafhvOmHxF80y4eaNGLCIt2zkNn0VrD0eJ1k/VYkpVvbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D12606A320
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 04:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D12606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e93d9c7973so12488035ad.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793421654; x=1794026454; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYAG5OYgNALKbmlFXyHbo1nyH/Yr5PiBp4YedVqYig0=;
        b=0MuqU8msUuMjk6Fy0H6HY+5EGDhuvjm02aDxiDND72+Qypl4R8QnYelvuub7syhyh2
         asbeLd3dxjqdhkNUSJCYbwtbaw8vocshNkIQKyWCUjWAVTPP3di0gT4c4byR+RqBBJYA
         Jxcv3zPfuBcV27JDiclpuu1Per/oqw3zpat7SLV+6gCrfSkgldx7u+NdOQMBj+M/xQGs
         dQqDotJ6YqGl8D0TSEJGO1fGRX+NMvxrBQON3pYDDuRGIWvukbWnf4CKtmjBr7Ohg7De
         d74OZDQbc0Ij+AWY4CxQJJo+VJ9RoImBJraOGGtO7VWpsQUC24ESVZgRB50Uzyt85P0e
         QDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793421654; x=1794026454;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYAG5OYgNALKbmlFXyHbo1nyH/Yr5PiBp4YedVqYig0=;
        b=A38VVoldGlMOtlDRcRLPxgaCPfPLARUWaOOsn3a3kLxvS1soIunq2fCwqHRcLzy7fm
         V9EMadtXFcagM5WLHlCBj7XnPx7mh8DitEJvs9W/bEZ+rqalebJmUjJSTndPWUGL+Soa
         xngfZ+AaXBDtlMiZZ1NBR4jklpRJH2TSAMhZw/2tN6hUWEm2cQkGG6inOR1QDcHlvTXH
         z2DnzELcEVNLAIfvHV3NMTVoSvvpBjKpS8tU6zMYGQ9F11bxXXmZE8qCeLA1TcGu7IDN
         W9JoapU8ONsVqZ275fCsd4uQAKiv/CUJYCrrPMkjQiZt8sUb6472dK3stsuM4grcE54S
         7Iaw==
X-Forwarded-Encrypted: i=1; AKwUvBxTKSrFufyYsNLjkjbbQTvFjdoKYhOriBJq2crKEsC7ElsMlPbhFvH1RYS8cuZitzJW1+gEb58=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpnM1X8Is2cogM8yUf5oY8VVhMp/RRPYAqv1jsbnZxUH05WlRq
	0dIwpTvrvHvjIdYKpwq45qvM+TE+hRjFdk0y/WsSXYJY4DHD8OlfrZg1
X-Gm-Gg: AYBFou16y+lGbZDdGtZzEOo0PRs2Q9XikQ1vHVdxBabG12BDOynze6z/hItJQXgKLUn
	GVA/w+x4oY5/7JTdICldcddKzCYWboyvlBG3WQ4iAw6U3LImBcVu4wW2u/r/GQ+pFiDFTKa9z7H
	JeEfPoAePIYmRUe7B4zGm+LdxwiG2UDMmGRPm0IJS/nbyyTVJoj3TDit/jRFSjZ/cPhAAfGl2kN
	qI17wSJbmdue77pFA6kZdOpleuI6cTKWy/Z6bdobsWyk7hW0e6Sd13IDrkAWSGXjFNzMxTjQFpb
	cMx7OyGprOASjmznBAyz1YXDH4SoQGQg9ZJfW5N/MZjK5Jl0ln7zWwa9zzmNxRYIN9HvbinO/q0
	Ld+uhfj/lNYyPlqEw9EIdGBOV/nm5uVzQMbRRbPXqvut/gYfOMvfu0rjpD5QHiayY+83j+gL5YW
	q/3HO2yXs5dKuh+Lkbmv4Mi7zYBzTA9gvNwTCSEh3ZM0D4AlmeSHES5GQGOXopGD38XkZEPdr9H
	16oesDtbPFYTuadBjE30sd97yBTnANN3SxOc21Ak+YnSy7Rom+RSR4QE1rTuJMPHUWsGaFKTFv+
	XpfMlKRoNHBUU07KNrNxl7BG52uDWKeTiZojkYDzsI6/7vKf/Yeo9ruqSOxd9QUcYSfD25Oc4aZ
	2EljzXh8h7UzUY0ir8dAvRm+JuB/hlWNwyzRDQlxOlQ+0p9Q=
X-Received: by 2002:a17:90a:c88c:b0:3ac:d79f:8229 with SMTP id 98e67ed59e1d1-3ae8984cf7amr3599348a91.61.1793421654153;
        Fri, 30 Oct 2026 21:40:54 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8454327esm6093012a91.4.2026.10.30.21.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 21:40:53 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Date: Sat, 31 Oct 2026 15:36:00 +1100
Message-ID: <179342136087.2.16978105493403840270@gmail.com>
Subject:
 Re: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
In-Reply-To: <20261030044643.157105-1-sj@kernel.org>
References: <20261030044643.157105-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi SJ,

On Thu, 29 Oct 2026 21:46:42 -0700 SJ Park wrote:

> Define the value at the beginning of the test.

Makes sense to me.

Thanks,
Aveline Noir
