Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B34483BF
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501471; cv=none; b=rQ1PtXZWSzE4q+TF7SHZqIUzbxPmoMkCfmfsO9gaHU6Xd2OVSTS5pNYV+GvzoUF4n4rekM7XE9acv5w2aVEHeD6DPW0Ha87EXvsLhQA3ptXJRR0bNBt9N3vMkzPo14yoVq3pv0JRxxv4fBPZF/mdAkCEsh6AANZu10qokeo2F/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501471; c=relaxed/simple;
	bh=urDHZl8WwDf2LHgRSrUhtMBRlsSjHVTZIirmLX8Q1zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYyZeBjikApQLIGyiK1cOKhwPbOeBPT3Tlswmmm9TCwJT9l0M4Sfo3ljXKvoumtwLzDnh8iFBST6LdtbBcuu/ic1a4Q0hKAqi0KB63sU3y2nvpPNFD/Fb1eRO9kfkRVn+UeTEdLLZAA6MoEkMUYfJBecI35Ff7mprChHmGJf9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+5ReGLS; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+5ReGLS"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-785686d2764so27791137.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789501468; x=1790106268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=urDHZl8WwDf2LHgRSrUhtMBRlsSjHVTZIirmLX8Q1zM=;
        b=N+5ReGLSd938RPHUWoSZViAsymxZQKNGC5K7+7+uVDKFPGgHQHBAAxNT8UxWUvFnfy
         sgCMXmhnB7eJ+pxTqDyF1wMjKDDCGwkbBsh60IqzJxBQezxXGHNw6tLAhsJPa3rc1Uqq
         EEUxPYopsQX+HI2B6IGC7wmk0j+bQ8UUYhO8KvIvgdz1A1W/HW0UDPBRtOrGG0K6Hm1D
         okGAV+8pOOTpOUqybj/5tRWqYv7TthnOVos+WV61Z//YDsDkfTINxwLeiSwCaW7YRfc1
         OiGcsG+UW2XCQ+2nwGzhOGUwzXDOpBKfYsnCKU8IJzgUS4FZdQEdCUuO9bOmEyySFc3q
         4HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501468; x=1790106268;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=urDHZl8WwDf2LHgRSrUhtMBRlsSjHVTZIirmLX8Q1zM=;
        b=HqUKbV5cpZLENFWiHNFNR9PRnmHy45ESqtlzfPzaqS/xRzgA9hywX5T9P2jRGVmu3C
         SlsjqK08cycYcv82Z0epxdJ6KRWOu/3IqMCSNmSBXFIvx+jNNgF1NVXUTeZEWzcDksua
         ul5IkHGyhGezPDZD6wiX3kf+cNeiD4IQg0SJpGnm1NZ11NUmK4IhOj7lnmDZZF7xdWcj
         WRTakS0LlPTOqspsNGP1nCWUHl7gIewW1jtH0ep9SAh8QsoUbceEx+5Krtf7D38xUpDC
         ZgvIJqjsCsSRaYJGo9eA4xUA/vffii+PXYqy50lCmQp5uuxnTlFVTYByR9qqAzWJwhZ+
         ErsA==
X-Forwarded-Encrypted: i=1; AKwUvBzg8eQTbU55rDcGD2YtBUTlyuZi627VPrX8EJ8FgG05nj/zaVE808VJAL9rktWC8u/SGxJ/IGw=@vger.kernel.org
X-Gm-Message-State: AFuF++l/f80nhu9L/3UdgJ1SdEa/YTICKtV/7c0vdsnl1g4sMTTWDnu9
	ulO6XtkxcnZkEgZu1Ud6FNIuuZ1O7+hEVhFZq3fDb3xrkdO93JmOWvCQ
X-Gm-Gg: AYBFou0vxFDjQf4b+ROStxq4Mhk/cKGmytGbtGDKnmmHgNtp2dHtGgJWPMD/JAMWwQN
	2q9ozYYTmMuGyWv+GfG5j+AgQIAQ2QuSWrqTagz9ayTSqhDRVS2+eLBCnxBcVlNyFhK6O57+Zr8
	CS5nFpVQ2324jYhwLGtAVLr9VTDCnxIvgfoI4d1k2WQhj5iXaCDExMVfFH7C2M88vfoN/CNWzxu
	P8rs4pfrvhW8FAL0jr25Fm8RuQje4vaXtadOeQPyUwh7KUfn8ABfCP/JPIr1JgVpew++PtojmHD
	I4cT4xhhL/Bst36jwjbIVvZgJH7oxsF3ncF7gXkw31V1epFN2QHGARKILKmm4iY8H+RFaA4XeW2
	FNtqGprBTzHmvCA0usxqIyH+fSt+ZgiHclTaM7+5U/xg034+UvAyHkKRC1E95cdeR+w1smpRw2D
	Aw3Tx0yJ8FoJz9Su9aMqbOu5O1JBJ8Ox21YEJ9SoXhhO3rgEVVpW9P+qb0S/ctKqVP
X-Received: by 2002:a05:6102:956:b0:79b:b696:d625 with SMTP id ada2fe7eead31-7a0250c0fe7mr1440137.2.1789501468421;
        Tue, 15 Sep 2026 12:44:28 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm498589241.1.2026.09.15.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:44:27 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH] nilfs2: fix checkpoint root lifetime on sysfs errors
Date: Tue, 15 Sep 2026 16:44:13 -0300
Message-ID: <20260915194413.3314842-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915041206.2430937-1-qwe.aldo@gmail.com>
References: <20260915041206.2430937-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

You're right, the extra mutex is unnecessary. I checked and all
callers of ns_cptree_lock are in process context, so converting it
to a mutex is safe. nilfs_put_root() can then use
refcount_dec_and_mutex_lock() instead of refcount_dec_and_lock().

I'll send a v2 that replaces the spinlock with a mutex rather than
adding a second lock.

Thanks for the review,
Aldo
