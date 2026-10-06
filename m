Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AFA46AA96
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295224; cv=none; b=fA/aWMuZgMB0bKvXw1igX2B65l6FZqUYKzSW/eSQTtU+T9vvlhCKotlLPvsfupkm2MQrqnaehoACrogxJsIPKAIAdHK4XPkk/gtD4PcQkBpLJJTqYk0PMzLrqsuxxAyhcQJp30H4OHNxwjpR0P85NXLWqZdAtDPkIhAO0yb/eZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295224; c=relaxed/simple;
	bh=j1khJXtS10EkM2zMqjkvq8yhxUHcp+XWHw+FRAgq6qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjdgIPj3jkQw03HwE1JSjX3G1WJrTP+wHiSoF9kOgl2TV4OwKQGrReO6UaqaQtyHn6LagvHTetPB35ZBxyJvJt8LIuqiNQ0vDm4WffK4sHUj3/3HX07sS64SXq2VACo38f3iQjw1mZjgpIX7X8oIgpoVjFzyNRzes4Wm4xwvk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOaR03sr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOaR03sr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so1363865e9.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791295222; x=1791900022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxIH7tVcaH4/LHoTc1gJIz3XjhP3nLsv7ZMM8u1zMVY=;
        b=WOaR03srM4VEPcf13yoWgn9l/JyTlhaHTBgph08IiB92UYpn5AhXWEnPgzEN5g+pSP
         DJCwc7jPbheVCsUjWhH1kah4QVN2cfbgwH6MSlMWh1UON2f7XLeuch4x+6XfEXuJ1tVj
         8DTBE8ZGU4S/PC1WFobsGFwrYjTEXs3CvUOGBSFAJncIXbdd8Za2XNn/Kwm/7CLZqgy2
         Eqcm6Va0EudfsDIV3mjfHJsn9XqUshl05zL9Lgxkpyq6NemFrp78W1UP8cDSY/fKXY8G
         vgRSfCoXuSLpBRHegLrLk+k3uVqAi5GKD3/kgybLFNnSOy3/FrO/Z9mRZ5k8PfKz/B3a
         b0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791295222; x=1791900022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxIH7tVcaH4/LHoTc1gJIz3XjhP3nLsv7ZMM8u1zMVY=;
        b=G2NJsSQiGU/6JuJDSk6F2DBt86pNYKKbB2j7ycio0xmQGsnLO1/RnaQxcimbOCu+nN
         QrzjJmgdmzs+L7a8zvf0S5YNpvSf+/QZfrzzc49cVRv/hHi41AQst7ZXRg0DIHzBNZn5
         Mg1OReeGfXWlcRF5G+5t/vdL/SyvfR9055dHnDZNeWGPAuHeDvR3lTbLSHr6VeyX7b6B
         EQsG4+NpGpsXPKcyZCq+wfC4y2pazluZufZ3nbGsN79MC6Ej7PFrLfyqChZP/XI6Uoek
         0r4ifnVywu5SxnNzqDnE2R4USCV2sJXs+ucKSKenA1ePuzYCGmNBkFwcktxBIfz4sHHd
         N1lQ==
X-Forwarded-Encrypted: i=1; AKwUvByIFLiqJojnmerrdoEVb8CXx1LLTiDYT449cho2DaEPheWRbLTP9qDrEraIwbl7XCV32oHphx4=@vger.kernel.org
X-Gm-Message-State: AFuF++krjU9HdXRvbP+KNTS35qPzvweTruCP+ONsur/OonFWxIu4oo5p
	bB7owxT1ta7xVCW074bUfikVq1Ldw9agv+RPWwLBPCW3EH9sWG8Unxsq
X-Gm-Gg: AYBFou12mvBP395ZhqyHafB8rQshAtFI+xk7BBDT3AmUAuyKLoZvO+wkVPvhaDLHsUM
	vJMfNX6CBo95JnnLFnMc+Cg/FhUAm9WnS0mds07sg/qYffqwC0pgWwjnEKAkTNdJ3AXNs0T7nAY
	AdKSWh15EXXMhA//p9sGk67pLYk3oMpqp2ZA8y2lQYGLMGPAapsrsf4WwSwe8f8DxLWFah7yswI
	Mj5Ja27x2pzBVuDdylff0iOOjFOR4H24Zp3lt3HyxF3WRrb2BA22nX/ZNMHlPvliibpxcIxwT2A
	uu9s3eStvbPk8MUESIiQCzSXp4UHvHGeN3hMfka5Ek4spMRExMeUSCbYQxwgJ2QCnzQElMz9VCM
	UEPjXDY7coElB7csrLXEKvBcgl4LQuL2gzFDr5ChcGqpqmja2bcjMP94p/OWh8Z/QBZNFChwAHm
	3H0NmGbdnyjD7tL3DVmjqSV0SLWEzMruZfkeI+njs5iUPARsB1VpqfYVo34iaHEGkKNRgR1C6zV
	oYxEfDqFRk/UgCR5AZQpw==
X-Received: by 2002:a05:600c:6217:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4a027454f31mr206690415e9.0.1791295221292;
        Tue, 06 Oct 2026 07:00:21 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178ca8127sm80577255e9.2.2026.10.06.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:00:20 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
Cc: KPrateek.Nayak@amd.com,
	Vishal.Badole@amd.com,
	juri.lelli@redhat.com,
	kayracizmeci@gmail.com,
	klaus.kusche@computerix.info,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	mingo@redhat.com,
	peterz@infradead.org,
	platform-driver-x86@vger.kernel.org,
	ricardo.neri@intel.com,
	stable@vger.kernel.org,
	vincent.guittot@linaro.org,
	x86@kernel.org,
	yu.c.chen@intel.com
Subject: Re: [PATCH v2] sched/cache: Honor asym packing over cache aware scheduling on hybrid systems
Date: Tue,  6 Oct 2026 16:59:58 +0300
Message-ID: <20261006135959.5709-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com>
References: <77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tim,

> +	/*
> +	 * On asym packing domains, if the destination CPU
> +	 * has higher priority than all CPUs in the source group,
> +	 * prioritize asym packing.
> +	 */
> +	if ((env->sd->flags & SD_ASYM_PACKING) &&
> +	    sgs->group_asym_packing)
> +		return false;
> +

I think that check is redundant. group_asym_packing is set by sched_group_asym() and bunch of other stuff,
but sched_group_asym() calls sched_asym() and sched_asym() calls sched_use_asym_prio() that has SD_ASYM_PACKING check
inside of it.

Ah.. Hope I'm not missing something...

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>

Now, I'm going to grab a cup of tea. And sleep.


