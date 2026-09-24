Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100A423783
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281855; cv=none; b=G1NakqQ0u+RdkcNQgTdPb4LQpsHS92Avvs+n8DV+gN+rx8xWwVzQ+FZa7GIjPws/gb1tkrCByl2KJp6vqcDd0ih3Lb6+rtmpanSddA/mW8nTv97ThCrVtkUDdVqZBJETrThQC8dYd+7QhxosLzP7LLyYOYypuUoUoH9oSvkHNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281855; c=relaxed/simple;
	bh=P5Ft9dr+LBOSEEDPSbCudgRMxke72Gt5Qr6Xn7/TvZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrJOrDb2Tk185klNFsPOXt4Qwh1BLXHGwntde9ml2JkCga4hacK/v4MJeeTt4KIb4ejvGSKmonGFc5ogXpjTdbX6y9t/pST4F+B2B2QEfquoL7Z6kM76ygBTu4cISas9nzseeSsT0fkYSUA8XnhBlmEKMYyOcta+/a5gccZ/dvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTSIFR2l; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTSIFR2l"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso2440325e9.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790281846; x=1790886646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3c90xok/6YjBzo9H+uGtCHNhEBukv6txB+RoRb7X78=;
        b=RTSIFR2lvUk3esGyEIqohsSLFAIJ0oyPvX/MvoTKst+zc/GxI6DmO6yxeiHiCpx6kO
         HiUFqFxo9SwNMEvw+4TNeQ0mTlXzEAIDT3LGSMBD//O7UCtWuazV+Z9fvirtePVnD1Zv
         fI1Mxq33mcwq5e5KjvNDuJkAUXHPUevXIpKLVmaMET4VoTWuenvoi872Z9Vl+h7dy96q
         VYeOhz6w1cIINBnCeAQq8SjedoI/oNApn73oTR/Yc7XD1Artk+VtomAH3dcwSUuGIxlY
         sF3zvAWRkwJ7GgtkZ844JjR0hl23A60zTuGfCHT6h1gbyDsEyfZzC9o2kGAWoAyayjyn
         AVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281846; x=1790886646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3c90xok/6YjBzo9H+uGtCHNhEBukv6txB+RoRb7X78=;
        b=uEwBZBFM43mLJtBt6XBxoqqde+4PrgoQimZU9beRBTpzulVLasnU3ywrFZkImuoaj+
         7g1WpJkXpW3AID6LxrbXdaCU0BrYKqQrKeUh1XzNXW38aQ8wMHNasChYk3BeQoQcWATA
         U7f+YLWS+Na7cac0edVJhq2DLOK0caZrAUJimRNt7sCZ472BoqMIc1ajJAqmCfGJ58p/
         P/8GNL2xhZwaWHHVdGmMva4nmcN5QhJsBbZf1KMDausW8O5vAuqHj3WcPUew/zwVabNp
         cCY91F5KL1OtPfZlNsLwdqF5QmDp6mtOeLDyjYAMPo+ZXn0yynlo4b/AFk1eSnZQvUpA
         n3fA==
X-Forwarded-Encrypted: i=1; AKwUvBzh7ncL215WZOdwSgfT1vRmzHDv8n63m5Yo89e41S5Rp9ybt7T3QniC2IZ0/E7TBHcvnaqAh7E=@vger.kernel.org
X-Gm-Message-State: AFuF++n2RmOPZwdAXlfR47dlLo2sGuNSynFphQmrbDzdOavPjpjixkB2
	N2VbdnW7LbUqvaSClSmVRhp3wUYCNVU8HW/ar1a+RfoM01jjjy7abwH6
X-Gm-Gg: AYBFou2ehEoQTzXnBINp1fxTWecUP4if8s67jE4j4QXAjw3PNXW4g1JFcttbK/mQQMB
	yled18dSp+hi3xX1Qgq+vHOYMBk20W+0+lcehsclwxavybToZCZkqx0SOM7MVlUGDKuxl4hsNaI
	MzbIuLkiV8wFEK07JHuTt7j6PD9wUqn2FbxZLS0HK3blNSbnQGbA/LZ5fEP7h0CqFX5oQtQiDEq
	LX21DkD+J/5PRB58asgNNJcNMX0pHjiiQYWucCLXMXyPNXke5ubx57LnENwM587dxyo0cwo/0we
	fNmmdvWdBmEPuxTGm6oCfxc2tPKp1nNoWFC6UjZIIIUp33vUlBlr2vEQ8c4Z7GSfb0IdEIm8pQS
	64Tzb5WFDmp25UJ/fn2qdL7AJ9oKrevsH4W3d4AyyxQwmgUhRZKsySky50qKs2OtgzMhrC60FYl
	XHvOJ7dP6P8+hooZZ/u/Q0Gem2Uxz5/OtvdpRG4fIf0TZ1P38c0mqp9JWk1ee5C/o+7GbL9wK/U
	ECJGt3X/fV4McYhEmP5yLcWIYx+ndc9nOFh132uPrvB
X-Received: by 2002:a05:600c:8718:b0:49c:fa21:1c84 with SMTP id 5b1f17b1804b1-49fe7bba7e7mr53535645e9.25.1790281846574;
        Thu, 24 Sep 2026 13:30:46 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30c43asm1720776f8f.3.2026.09.24.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:30:46 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iomap: don't lose a failed direct I/O bio's error when zeroing the tail
Date: Thu, 24 Sep 2026 22:30:08 +0200
Message-ID: <20260924203013.9967-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924185317.GK2705364@frogsfrogsfrogs>
References: <20260924091203.198225-1-parri.andrea@gmail.com> <20260924091203.198225-5-parri.andrea@gmail.com> <20260924185317.GK2705364@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 24, 2026 at 11:53:17AM -0700, Darrick J. Wong wrote:
> > Cc: stable@vger.kernel.org
> 
> Cc: <stable@vger.kernel.org> # v6.12

Fixed for v3.

> > @@ -582,8 +578,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> >  		/* zero out from the end of the write to the end of the block */
> >  		pad = pos & (fs_block_size - 1);
> >  		if (pad)
> > -			ret = iomap_dio_zero(iter, dio, pos,
> > -					     fs_block_size - pad);
> > +			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
> 
> I think this is the original cause of the bug, right?  We might have
> already had a nonzero ret, and the assignment here blows that away.
> Right?

Right.  When iomap_dio_bio_iter_one() fails we break out of the loop
with ret < 0 and fall through to the tail zeroing, and this assignment
replaced that error with iomap_dio_zero()'s 0.

> If the answer to that is yes, then
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks, picked up for v3.

> (I should probably whine about how changing the function signature of
> iomap_dio_zero should be a separate patch to make it more obvious what's
> the actual fix...)

Fair point.  FWIW, before 10553a91652d iomap_dio_zero() returned void
and neither call site touched ret; that commit made it return int and
added both "ret = iomap_dio_zero(...)" assignments.  So the signature
change here is really undoing the part of 10553a91652d that introduced
the bug, and keeping it in one patch makes the stable backport
self-contained.  If you'd still prefer a one-line fix followed by the
void conversion, I'm happy to split it.

Thanks!
  Andrea
