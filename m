Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496078;
	b=JubYLI1RCPZQQ0tNfMIXDU57D0r/yNa4kJPbgFV58SgKNJSPZ9hjMsoDVfX0mDsAV+lW
	 QuurUKcv1fiu5dcuaYijjpuQqgW5ZzSekqmmR/FHkWMMOijpTgs7vBpIjt5PqBTg2vtOM
	 FdrmbVKu7MEAWVqLmBqXnDCzxl9ke0GnK8eEiVOipfIqPE46fLiWlgkTZOcaEUrgx2lf4
	 SSwTl2Vz4c78XvGqF5K5BFvX+UgnM5EP8rRH9Rblv7Xu9oSIZuhI2mJkpnT7c9edgykXV
	 aNh1QL5HISXNZ//+pLB5M9voXXL8QjfBqfz7iz/9Ana5Kep1AThq52LHTVJX/nOQD0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0swBWFYpLWCv2uk3fIn9LxiScTlQdREOnp7Y0vqdXqw=;
	b=qz1CKT9M0xcJLGS1qXGxXksUtSsQFEAtY/xQM9bkGd2Eae5bWaTpl9BwzseDyjh+k2ts
	 /HJqThYBPVOslUiUNa0x7Pn2P34Gi7UQWpwElNTB9X03B0Utg8MuWDd04sKnq2FJ7d/6y
	 tMm7jlQJctoQ75tWBCnjAq84FkwzXdo91F7htmMUkHxxR7NRAMtkwqehTZ4Kg22OWEl7m
	 tapqkTb27eEt/hnNDSmD/uZ5JPdoxvSrXN9wQoedbUr0H056IcjGPI+UBBF2HK+xLv5j/
	 6nwwVjPNTb4/ZO9li396lIipHHWerdELZRtTl/SnajOSeoD38ZNz9exBUtfSLYG05TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=TOcm2Ed1;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9800606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9800606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=TOcm2Ed1
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53397554beaso41134811cf.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794496072; x=1795100872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0swBWFYpLWCv2uk3fIn9LxiScTlQdREOnp7Y0vqdXqw=;
        b=TOcm2Ed1M3LHQEU0niXvBE4+c3wTGmU7AdtpGS9H7bFvh6gX69rn3aXTdoHmGzgbUQ
         PyiPs9IoUUiEz0lzSBlRajf3Pgrancg7K7nQQBL1iX1iBguiXwUpxEtH0vGtIBZUR8KS
         SCK0yGKpHtvC4efFykqqHlTAiqZZUbc+j4PZ6roA11BSq363ZsVbhRCKZvN+RShcoT9A
         JnQqR8vlGhV0yBhdVEHmOKGVdM9xmxOBLvmRQIFm5HtFHDRT5/s8T9bI/iI5ZZulrAAg
         cnATcz9J8VQZJFVUhiEqXoy/Hd1Gldp83I+Na4H0lbIHMjTvu0nbcTqsPm0G34SYeLXX
         ei1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496072; x=1795100872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0swBWFYpLWCv2uk3fIn9LxiScTlQdREOnp7Y0vqdXqw=;
        b=GjQ5C0hKioXXXHd4pjS0O9scj86sUNHRmIPLTBlSkfkWdw9aY1N6nVbcFQ15nNYkQc
         Vvot2aNcSg+UnoenkjZ6aVr0EXw1k6qEapiXp94GHXA/6DqcNhesZZqLg0/uEnhR3/6W
         6k5uwL+6QNZlhgBb8nHhi9XN/XALAopN5ZojvwRiFx42JOXcBm6hkHxTC6egnHTovH+V
         rgJdGKJivwLw5YpenDTtY0kHsuyx0DAGAx1dDN7ga0AJQWXb2qSebjWpowmE/dREu6vB
         1540LPMMGIc5AGYVQ0hnqsg45sX8VHmmZuOIAFVlTeJ5xH8QO7aQDG28V2ykxmGlr6sh
         4A/w==
X-Forwarded-Encrypted: i=1; AL+hErFDvupU0HpMohdJzESSKwCzjO3+sOUTmE7+RNdW25SEeGO6VTDqcIIQ3lNVV545FJtzMfrQI5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OgOWs3wW0DfId7J5p26WkYwnFVT2C7cTe2cvOnGu4n3q5Ffdo
	DaejXnL7zF463XXXJ0yP908gacUK7fGGH6k0pObObRl0qrlK1wG9imVKhZGa0aPORA==
X-Gm-Gg: AYBFou1+O0DRH0bvydgYJPLeW92U4d+GjR6YbdCxCoND1CEQttwPfO73M5w/R34SpD6
	hprd3ygrLUGmLkx7vv5v4pClI/Z0O4wR9HxjLMdqxLGpMzdh4xQ78x8WG5fxcgVr6mFiPNSegPM
	I/vzJiobrtDg4P+2Eu4TeQ+wElN7nQOByN1Hfeqcccz8WgVwtTi7VSBhJYjc08dxy4/nCHPHTvl
	WmMjw3kWFy++I22ByKm9LJE5F7gJvRjKrEBtY2CR9GoZFpwRu22WBlO1Y3l89VnO8p6SJ+5nA6P
	hHAFZOJKhXE0B4e83NJjOOQnhiqMpovPUb2CQH8Xnv+34utXdCz1tR8BovNyaaoPQ7lFJF2OK5y
	DXRfO8i9f8HpgqLAnFBlqoF5N5Vi12k03kK51IkOkn/IRKPgIDNHaDUaZ4sg6QNmmAFgTJZhPtn
	FFqYa4xLZ4cnDMKWoRw5d3ePNZpHgpOKjmGfD2wFNqdmGx3PndaJrO9l1gWKBY+vZg1YgOVR7QB
	tsY9edflsDk0b/tK561BM25cuq2PNM+x2xGeyS5OW+uRbXaFFZRVyQcRYimdaR5ueA+INZZ1Ppo
	hiLSHp5dzRTQmmONdcRrd2xjyY3e3aB61BQom50PhaZx2YTfQ9KoaHLHxLJ4X+KtDE/ycg/j
X-Received: by 2002:ac8:5a05:0:b0:535:6cc1:5890 with SMTP id d75a77b69052e-556c119bff4mr98545471cf.51.1794496071835;
        Thu, 12 Nov 2026 07:07:51 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550c40ffecsm75896761cf.29.2026.11.12.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:07:51 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfs: fix f_bfree underflow in statfs()
Date: Thu, 12 Nov 2026 10:07:43 -0500
Message-ID: <20261112150743.241738-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112134434.GA23459@lst.de>
References: <20261112134434.GA23459@lst.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 02:44:34PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2026 at 05:20:18AM -0500, Hengyu Liang wrote:
> > The issue can be reproduced on a new 2 GiB filesystem mounted on /mnt:
> > 
> >     for i in $(seq 3000); do head -c 65536 /dev/zero > /mnt/s$i; done
> >     dd if=/dev/zero of=/mnt/big bs=1M
> >     xfs_io -x -c 'resblks 100000000' /mnt
> >     for i in $(seq 1 2 3000); do rm /mnt/s$i; done
> >     sync
> >     df -h /mnt
> 
> Can you add this to xfstests?

Sure, I will send a test case to fstests.

Thanks!
