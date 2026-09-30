Received: from mail-wr2-f17.google.com (mail-wr2-f17.google.com [74.125.225.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17695246783
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745214; cv=none; b=GeS+bi4S3NIM/guge/LlQ1papzghZyNyJgQD0tESAdP+wcjgaBiuvL0P/+BnuB2Yz8WPlYPVkr5dfxPDdw+SBkPOiIkR4Pap1HwilcnS/bsIq1cdUAw7NNWf7Ogit08nxbRiDzQYPD/2Idd527sMS0NMaKsXz8csxZMqHv9tagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745214; c=relaxed/simple;
	bh=MypcxZlDJd+r7SofOnuSEe+Q+SDR8+gy+W2gDGm+htI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWV4Um1pYpHQmi4IPn8qVfRyGJd6/YVOhf61Yhj2nzEhjHlWmq9xzfkX1fY6fhMwH2h9WUogx7Z7w8v2luwVERfz2kgBmoSycw9XSX8N1O5HTH4AU9YNQeP0i4DKGT5p/HzsPBYDElxMKgYJ2wuw0n2L2MQNWpaiV11SY7cGePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaF26YjB; arc=none smtp.client-ip=74.125.225.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaF26YjB"
Received: by mail-wr2-f17.google.com with SMTP id ffacd0b85a97d-48af51f6182so167138f8f.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790745211; x=1791350011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+c4qh3TxeW41f6Urn6eqBomxhi1RyxqZL+PP0oFbtfA=;
        b=ZaF26YjBt5Tf/Urlb2fYs5tk03xGtB3BHGKJFDGiWK/Ka5s/QlKBoY0KoPnJiDYOjl
         eGELlzxatMebJa68buj5kVv7/7tycHuzILBYZ2fZf0gjLH76W10IjH143CVhf7hku/Od
         QxxK4kvkO4thY+4LeyfMs09wCczdpZHXDA9JUVvhsR9lceYGf5A0y2+fgXHZCfnyDVEn
         gM6La1pqqJ2oRhK7jrBs+YRQE9M2B/dzh5JvV/OCbvp2STYr3mHCq7sKL3584XIiuJ1S
         abXtjqYzusLnHCnuo/d3V0Aaox8bJDuwlJpTms2UOS2VdOrsETQcX6PIqxAA/73UvvFP
         cOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790745211; x=1791350011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+c4qh3TxeW41f6Urn6eqBomxhi1RyxqZL+PP0oFbtfA=;
        b=abdtHh3ygqlSEJUNPu2Jqu0NvFidhX3ROXBHoZsbxXDJVddDcA9rJ1vfARNluTV1Wk
         6UkoDfoiuvMPSv2kqVhVPVgTEnx8gqUqd6na2HsJv6q5RlGr31ReN0cJUqbnUORpl3dp
         2WIysdN9Xo6tgL2YuZWF9mFxWI3MUUTcIQxZyDzJ8VUG2/QT0oYDjeii6aWyblgXsQpi
         b9ewJUCj4GfRlWlozCFRugkVXEN4uKh7TdXlAsqY7lvU2ClIqD1RjSrb9pj0it7Q137K
         blu6Vi0rZotfxz+qYdsggnJyNcWUO4uLGxpy5RWFLO3nZMyPxRAx4o1etNugM4OaoHbw
         dYaQ==
X-Forwarded-Encrypted: i=1; AKwUvByy8fuqf44QNgyg7FPoVB9aqDNwEXGA4cvvDQiRK5oeFqCV1V6Z14Qp4GYsvxwfZvaORYtSkwI=@vger.kernel.org
X-Gm-Message-State: AFuF++nArT6qHS6BD5l8GVs2IpSrxXVUfIXemKvyP8XIAiGlObXm6knJ
	Y+MszvSUBiHT0LZT4SqNY7ma5ubyHoyNGlnbtyIzD3iRXP7MMCBpU/0R
X-Gm-Gg: AYBFou3fsjHnmAudgX3mPq1R5QSCKqAuN513E558vXIx8jaO0kTLb6/ViGgoAnYiv+b
	kL5JIXVcS4vC+bYLVISP84aNflB7Oy0TY6uqL4FPCiU3WzGmbKgb4LKegt9apHPB6azzs7PBXaB
	96i0mgVbsGhObuGS+FJzBBTfYJndaNZeCq06yzUrxEyF8AyWF4LUSe56IK+Dzz3lmPHNdLUBqjZ
	w24sL1HkV0Nh6idqWZdGNJHKAReYDKHPJU+55QGVxEbs8Xae3mO5DgN7oocAmQA2SbF1XZ8jWee
	swyIIhHf7CSe9MORZnPbDtdt5u3xWIdvo9xMybpnDVJxnWFXIzjJckxmxRsRXA5H59zuT28UNBn
	QZW6USFYxcth/rszPPFDZCtpo0PX/vmh3vAfHgVXznPMmM2YY6Go8brDZUrv04Z24rF4rNFvgQA
	n59JaUWu3VAeaa9xU9oCydVdHCUtd6gfhvQEx1FD5mTgimL9uFadjoDxc+GrBgKK78gaWhoSAsN
	3zim9C+PVZDOugHidCY
X-Received: by 2002:a05:600d:82e5:b0:4a0:1a3:bf6 with SMTP id 5b1f17b1804b1-4a01ab4f1abmr2284165e9.0.1790745211216;
        Tue, 29 Sep 2026 22:13:31 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174d8738sm36542285e9.2.2026.09.29.22.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 22:13:30 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
Cc: KPrateek.Nayak@amd.com,
	Vishal.Badole@amd.com,
	justinstitt@google.com,
	kayracizmeci@gmail.com,
	klaus.kusche@computerix.info,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	mario.limonciello@amd.com,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	platform-driver-x86@vger.kernel.org,
	ricardo.neri@intel.com,
	stable@vger.kernel.org,
	x86@kernel.org,
	yu.c.chen@intel.com
Subject: Re: [PATCH] sched/cache: Honor asym packing over cache aware scheduling on hybrid system 
Date: Wed, 30 Sep 2026 08:13:27 +0300
Message-ID: <20260930051327.206529-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7790ab6c5da3aeac42f6878f0a167c6cddebb354.camel@linux.intel.com>
References: <7790ab6c5da3aeac42f6878f0a167c6cddebb354.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Are you saying that we should update the first chunk to add an env->idle check
> to match the asym_packing migration pre-requisite? Like below?

> @@ -10847,6 +10849,10 @@ static enum llc_mig can_migrate_llc_task(struct lb_env *env,
>  	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
>  		return mig_unrestricted;
 
> +	/* Prioritize asym packing over cache awareness */
> +	if (env->idle && sched_asym(env->sd, dst_cpu, src_cpu))
> +		return mig_unrestricted;
> +  

> I think this is a valid point.

Yeah. :>.

Thaks,
Kayra

> Tim

