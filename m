Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585688;
	b=oKnyi/yWc1N1YNkaDIP2CbZOvcArrRWfF3zZrUv65RUmpFAGSSZ3XHQlAt7NfHVtjgGy
	 w/8VMxc5MP0m74OWlg5f/dVpcRqHNTMSV+iwW+oX1yTxCYlNRwJ0w5KmOcirta25e7g9b
	 kdRlDrHcko9Q8Uc/SFNS/Xsyd77nJ9qJxFZEuOP1Qe68Hmo/iAwrs6acBH9NuEn9xkmmp
	 lxNyonF3GKG+aI3IveMwXxzRoqeBOtrISZmkNg1DiQPyharPlATJgmHieR0a/OHJ3vaNZ
	 z9dsc54+fw4/RIYdGRqnmUzVrV2FkD377xejPXH140AC6h2T5nFLHmeGwKuPfgTHBrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0eU6RtwaBGBVUdLrxzNH+pMOcJGbeX6TyDSST0DZFlQ=;
	b=YpgFPYkWM3QPks5//oy6uBFuKUkId5qaaE34Xcfe4EJo2wP7bi4yEtm2BNCVgP/cUqa6
	 w+B+NuIKoTLmew3/0VMQitDVEggHA/HZYh0LZYQ/Lbf1MlzEs1L5lfyMXG7Ps4/7I5eOM
	 tl7sbNupoJH3oEE1eOJ4Dlzim20hfiJ9koEyawQonx3EkfTgfhLnXbFTsbQ664ZaBytM+
	 ChRhf/u1wQ0VYFhn6VQgrnVRdoaMXQqeQ5EvWf9oCFfe8Szl0rta6X1obsMgEf3Z/5bIb
	 kKm8cOo65Qr1ICm+7w+4R5QEDPMBkbY6gG1wEl3siOM2od5QDEHYlUvFUJZHsIx1WuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CsmirpcJ;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C27606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C27606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CsmirpcJ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bb5afa736so76596eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585687; x=1793190487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0eU6RtwaBGBVUdLrxzNH+pMOcJGbeX6TyDSST0DZFlQ=;
        b=CsmirpcJlZUVZQAFipxefTs8JnRPOik/dZDs6oytiYK65ls7Ll4DnzOSuuYS4VeYAc
         xkktwKXQ8tQb79+dhpsdrYS9En+YayXrb1ppjHC8YCuZA8s0F5M8a9SRVkrrwAMJgYsj
         ARTwt21HZ3Ro043jDBtBXXzdPjb4PFoW3W4pA4X53fIUusgME6SDvRwW0Z+eQoa9X+Su
         9L1pxRq6pGJxY9Pt8ODVDhfG6WQ4WgJC6ncD1Kn4CTMNtZX/oJKgRl+jJGBiyoWn7lMV
         gJsryKeD/pMI+IuAAmjVkZpAayYlqEu39+q1gmjtG9opqPpv8TOGupGmZZyBM5+D4Lv7
         zJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585687; x=1793190487;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eU6RtwaBGBVUdLrxzNH+pMOcJGbeX6TyDSST0DZFlQ=;
        b=orljEfBTJuP64Ut4/NXrW793enu24OOkK80/+NtnFYhYuUJwo2DXWCXMwRCMpqam1A
         C7ckdL/4g78jeymEpWdk4/4Vg4eCnE9VHREMLheTNcZ9/p0rHW2ZaHFtmJmALlWtQPYx
         jLWoOzEtKkIZPI+uI30esV5fZ1mqShXIT3daWJZf7fUtHML8neIYZhVPDyZRmDv/V5UO
         6MI2ZoGZSjlvxfEtNWhJidR+2VTHiQvE79wpMv7G8dOFk8JzWCcr4XVuWrXnS5TeCjdd
         xFADU5/kUvsoWnXlKdtWWY75khgR5I1TFY4L9sz3hWIcgkMNxa5yPM6tKT8d07OfcdwN
         zBaA==
X-Forwarded-Encrypted: i=1; AKwUvBxmfsNnODch9UjedvWKFP9blxV7nqBrfk3WYWYJjRTMA0xB8rCWG51cO9AIk8ldvDJ7mmyy1TA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6o0whMj6/6Rveagf1Zy36bxT4+Fh5heDkP52e3PmVQnN3fpMw
	xo0RyM3EOzrTxyLcIc6kIlF5/FrH/RSuug34Cdz56ZBuerUZvGSGrQHJ
X-Gm-Gg: AYBFou1mLViBqC90WjiqJBe5nfEU2BcZRDQgUV0DMwJt08AOmxBO8uvgPDOKRwDWqkZ
	eRXem/Ww2k2n4akxt1lKs6LWxE2oGYvN3Wajm11ph7xNvI61L7xq4RX4J/FccH/3d5nsZ6/6Q4T
	mNxfrw0bAbeltYkqMqf4KsnXuThJT0rdYKoIbv4Id33lT8gYKqIgKxAK6SqzulV1zlLT8JlNSTv
	ExGthjzJH/+bkTeHdqEz7SfbJRtqEK0PDzSOeAQo6t0ex/nOcGzaSfCsEtp46JJIO6P5esijNpa
	MAGMnNb6LhT+nwe8Ly1t4NnxxE/kNeEti393PelBuZ4cKZBPpUooIJkHVNgjUVgtEGTkdsoOx9c
	Kxxn3IGVEPdrlotxGj7qWSOZgLfEpzDndn9LIBGslRE0GQZ8cPhYRirwDIYje74fQ/3hBrhA0xJ
	V/yaIoMRYacHpUcqmkAdquT8OKI7wv/cVbJJpduCv5CiRIOL4vIseWC1JPEprcpl3IzxZJ/6npk
	jCoa3x6JVlDnVTpgQZ3MuO8b+NgqDsR09eLzjy1jvCOlUinwwiM9l4Vf+3ZH3U+JF9pTc+m0kjx
	u7qxmkHeSeCQ7xDAMQ==
X-Received: by 2002:a05:7022:f519:b0:14b:edb2:c3bc with SMTP id a92af1059eb24-1909acc857bmr3334418c88.0.1792585686379;
        Wed, 21 Oct 2026 05:28:06 -0700 (PDT)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035926fe9sm4935059c88.2.2026.10.21.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:28:05 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: gourry@gourry.net
Cc: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	dave@stgolabs.net,
	david@kernel.org,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	stable@vger.kernel.org,
	weixugc@google.com,
	yuanchu@google.com
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive reclaim
Date: Wed, 21 Oct 2026 20:27:56 +0800
Message-ID: <179258562954.2.15216681747698947501.node-proactive-reclaim-review@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Including all zones makes sense here, since per-node proactive reclaim
is not serving an allocation. The existing GFP context restrictions
and folio isolation checks remain in place.

Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
