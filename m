Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66F3F3284
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653224; cv=none; b=p2XquLchAiTjWTVkJ77YvaE1zzwFX8+NysmnGPGwJPmjKHh7VSVDUFKYfwg0XAWBGaEhJHuypRXZVFg9MSaB/3Evj5VNtg5PEv/yfnyv3sl0RRfp7lmH+BhkkXCpXeD9uew2Y7D9mqMZ93WUxgulC9eIshT4zp9X0tfn836m6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653224; c=relaxed/simple;
	bh=VwnCPhwqB5g/Gfq9pegelUvx5vJ+9qzrhPFnEoTLFj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aw9WUgfsMouZgTD7YTYFH6cpsQuvMROsRQLpuT9PgwMIWOuCGoo9Knwg2lwYfJRI2os9pKkXcyarmaFu0v8w8hFFlsLE7Si9CRUeuvy+DL1iVSKXwyfvQHyR+CUo4V0hRH6VRLgR8HpZz9KatAUumSuuXP7kmvWnKBNoPVZI+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVk1IN4v; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVk1IN4v"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84847482584so463540b3a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653222; x=1788258022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQ4oewLEkWKOXaZHzg/gCiDZkRqq6di8ok5MYz3oEVM=;
        b=KVk1IN4vGHMnMCG97XQpXbTHJf98y3+I4dqJVHQwU2E5X7AhUmL7O4b8y137+of94N
         RDg+PRMsqaj/jPBmTzrVs7GvenCuuQ2avfcGeHyah0FaZA6QH64zdb0jzM0MOk30QwTP
         xmhVtUzVsMMVgSgZC+iLWsxo15AQkeOBXeHiRsqbnqnMPfQfJhypOc4KV+655Rbxj+ix
         0u2IXLvOIXpdlukahiBQDdcP23v0ct65f8lseWWfnckCQzYon4oK7rb4FWQ1H1xiJ6ej
         51gJfsUYwDh2qxAhVGl37gCX2z7nOG7Gsk8Pw6YovXH+KlNxvKzC9zFqQnVHSsXKK2LL
         wm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653222; x=1788258022;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQ4oewLEkWKOXaZHzg/gCiDZkRqq6di8ok5MYz3oEVM=;
        b=H4joHj8SbfKiISs/S9C0uiKaS/row30M8VTS8YHF/d837AFTM97o/YpApgbYlJlqsN
         tSrV6/BIii5fXxcVftP6HjkvM3Z5IvAVlNuNnH1/g+yMyYXb1GANpGpLbWwmrRtMyEtl
         tMNkiQNt4mLAi7V6BRH5APfhiH4Hv0/irWtqefxTaDd2Fwz3xjzOXhKkzzUm2E/A5S1+
         vwwSNzHNYHoj2peWbMAiIShkuRhXNH6NAI88SKS9BcnVRK3YGGn7aUCWbaUmijSeo2yD
         UN9YE/54Z+/RE2QfY9guK08KMxNYPRZ+Lw+n9ZH0ej4PidGYT8cNOZ2ez4lIDvsgDPUm
         OhxA==
X-Forwarded-Encrypted: i=1; AHgh+RrIqWyIdPtwhUyC3xnjjNIGAlIvuyp6zGKxgFq6M6K94KhQuKqCGoPvZhyygO4gPucMQgnaHKA=@vger.kernel.org
X-Gm-Message-State: AFuF++kORfx+kSHWDqJg2phlXh107yqcfBicdakAxumc5P62enWzx6Vv
	VxxrpVwm4C2bgyZO/DrXDM6UOZCzEW25yq9e9L3Wj3Tn+hLzuTRdrEyY
X-Gm-Gg: AR+sD13cAiw3LWJssR8x+aOzMCfjUh9z67mV3Mdd1+PFH8aOdgQ7x6T2/nNw70xDaq2
	q+HFNOTreOZ7kvkVg9grM1L0XkVI9KTY+ihxhEu8+0ZTRc5Fynl31s6b6joPx0JsTzzlO5Lw5yY
	HBgnA8gJXZYhV1XhG/6odQhP+afI6a79nTAAV4xzFfQMHa6bD1RDSS1pOgL9qkIDQb1qfIyFSwy
	gu0YbuC7WhEruidbqC4KEQtF7nK5zv096L1GwQrkhN1rzEqPeErt8Xx6fNIhf5l8bxq0s0YnqG7
	8YhpuqxWQds4ATCtS/mRbgdpYLcwCVb+QAYfVQEYEfhKrqZKj7ouhZ+ArvrTTni0om0B2PmpLpB
	3V7dNJJB1ZqL6Lr7Ex2PJIlEd8qx0WpsJt8IdxGrA7eLe1SUvJg4B5xQ5oQ6Pcd9o32LmKOiXZR
	wbRohy7Oo8JymWeCn7liMd1d3z/zK1wtNrG4sOTF2ukeyPdnOTFbv6SmNiwCOdZiQ=
X-Received: by 2002:a05:6a00:238d:b0:84e:242:4bb2 with SMTP id d2e1a72fcca58-8523baf0f3bmr6228246b3a.4.1787653222346;
        Tue, 25 Aug 2026 03:20:22 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ed495c5sm2834862b3a.0.2026.08.25.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:20:21 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jun Yang <junvyyang@tencent.com>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown
Date: Tue, 25 Aug 2026 18:19:51 +0800
Message-ID: <20260825101954.3799675-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
References: <20260812113435.1854275-1-junvyyang@tencent.com>
 <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
 <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
X-Unsent: 1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/08/2026 15:21, Nikolay Aleksandrov wrote:=0D
>> +	/* use _rcu to preserve the next pointer because it might be in use */=
=0D
>> +	hlist_del_init_rcu(&pg->mglist);=0D
> Just to be clear - I'd expand the comment to include why it is safe to do=
=0D
> so and under what conditions (multicast_lock held)=0D
=0D
Thanks Nik, that is much nicer than the restart/checks dance.=0D
hlist_del_init_rcu() works - the UAF splat is gone (7.2 + KASAN).=0D
=0D
Before I spin anything: would you like me to send a v2 with your suggestion=
,=0D
or will you fold it into the open-coded-list cleanup you mentioned? It is a=
=0D
UAF with a Fixes/stable tag, so a minimal v2 now may be the easier backport=
,=0D
but I am happy to leave it to your series.=0D
=0D
If you do want the v2, here is the expanded comment I would use:=0D
=0D
	/* Keep ->next (held under multicast_lock, freed later by the GC work):=0D
	 * a port->mglist teardown walk may have latched this node as its next,=0D
	 * and deleting other groups of the same port must not truncate it.=0D
	 */=0D
=0D
Thanks,=0D
Jun=0D
