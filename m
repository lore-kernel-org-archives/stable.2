Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245341D4F1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281850; cv=none; b=k2/Rv1Gksn1YaYw+gk0PZ9Hd/vdstZgP4BmRHfKkc08dBP3PwHJ4lm9ed/Y7VrDL4iFqP1Vvn1rro//yBqy5wAjbA/TKAdls8UPucYX+hWJnCYO+w20f8czc7UL+2MaWspUIRYBLk2zPdKL1vev7Ec0Yjf+jU6jIZmUcOBzVLIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281850; c=relaxed/simple;
	bh=rTGplCyBJkh2bkDYBIKlMH3wsr0SrqCVCW+QaZVCErw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAh5k9gNAWIUmWWdqJ4haNcqHlRVQu0Jyav3Uxa9n9VSGc/s3t4SEmHdIc8ndPvs3CNk66UZRD/+BimCZIPQrxDnFiq43rF5AbLo8ewUNiOawKq+3rk6qELdI6f4gxjpLqBgSAeAZJdPDr0kaGN/G5IzAPtNX4iQA9MaVDTxv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar0o9bA2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar0o9bA2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1ca5b0d6so1725945e9.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790281845; x=1790886645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=saylt10Fw/9Bgvahm51d7jrIP+G+sTRm7c4tdEvSznw=;
        b=Ar0o9bA2Tq67VKmBBkFaq3Ej4GkY5WNjBE0qb2kKxlPkRJQmj/bwsAltrM8Wx96dcB
         rLkUbYLKQrfMxO7F/N8y498FXssd1UrRoWtU42OqRGt1WNjSM3ng8XOlGscFVs89DTOO
         UzwbTt6N6FDWAFPVR39b98ELI9XTpRhX984J/Myils8DLl3V89ZV6iBgk+IxaBaM+kcW
         8sut7p7WWB6otxH8UcbAHJQrHUVvQIJqjMUKAOe5noURgvW9yvUZ6jL8AL3SPuTzA7IL
         ryHjVI6jGxobexyCAgtirIzWHgp5cq0iIViybJJ9SHpKmJL8LN2JwmxaeHT6uUyoLneL
         F1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281845; x=1790886645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=saylt10Fw/9Bgvahm51d7jrIP+G+sTRm7c4tdEvSznw=;
        b=NUsr5zz7iDxEk4WhQnN4mtyFWR2U3dECnma7jkrTRyGp+kLG76Wn2YcgPlfweKlEfk
         ykm/UtEy1W/aspKWuWoBh+7Fny39Nd420LYfCMCvYXFndmiJXtyoz33a9rhgXDbkKfe9
         n11qyd3cQLsLaB4ng3XdG5dYIkqCeLJMYN/iZxODGWhVdoFwFQyJjGnEnXK2SUU2l9rp
         MAhZMr6pAAZWNf112yDgkuyCJXiGql6mcBd3nVa4SOGwxk7XeOKt5Mwkv5jFblaAldRX
         6QxH0Ebg+eu4CK46M2lLDy1q5w3IkDIVXKRYwSwMlNDW2p52kHYkD6N3YbDdTC0pUR9Y
         IuzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+eodTZPcgeo3rYYnn6hC1h0A27QX2wwLpLQAbPwJ3F9IYyDfRGW00CdZeZ8eofw4+bMad5f8=@vger.kernel.org
X-Gm-Message-State: AFuF++nhoSzzwpwGQuzNkSWVqH/UbmR/e7bHWqPNvdOP08cloY6hzjci
	izeMx9jF8gsjZ2RJ1NiqK2fmyHnU69/ia4/Td5ab086ayaBq2uCleJn4
X-Gm-Gg: AYBFou07AsEt9GiLXoua4bKdQtsNq8IG0vUMay5pUHG0yhcQ8KLssF420SEdPmkZF86
	mmdwiFEqzW8hoqXWASrvbzmwwkBcJLqWXS90DO9KkLyFon7aS55rS60Ci6hx1Q820BJv6TmL0l8
	twvE2U2WkB0e5cGf4N9nQBCre11rL+G7GRfRHdwB4YHn4V1eS1Qmrp5z7DRsuQtwscPvGijB8pQ
	m6fQ/h1sQsuCRGqxRsoeZ4eR5/fMBjPx1fyZ/Du3fAOCVHxXc4LQdJQDM5wdbURgxsmOtY+QMJc
	aLPqVqnnqlyvp3NMqZ+JgQ8URU63FtN6WL2IjyCm0wS8LGt40YNApaBvj2RuJJ3fFyKYa6UOM2K
	Ji8lKqmqremS6V//pZm6OejMZ0Ev0Fy3cNOSqmNL1AMnHXP0MIgtOE/q8BSUGqJA4oPy0+PUJqv
	id3ZfQi7X3NCDCrksfzFNtExUh2N+SN9VEuYlbLzBDbZKnrKa6d69DulZSYy/B9YkVPV3V7cp19
	YM/sotBU0Nt69s8mL1ceJgR9Newej9I4Fp6zTygD1ve6JDWonF9krs=
X-Received: by 2002:a05:600c:1d28:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49fe66fc677mr69380595e9.33.1790281844999;
        Thu, 24 Sep 2026 13:30:44 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30c43asm1720776f8f.3.2026.09.24.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:30:44 -0700 (PDT)
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
Subject: Re: [PATCH v2 1/4] iomap: don't resubmit an ioend after ->writeback_submit() failed
Date: Thu, 24 Sep 2026 22:30:07 +0200
Message-ID: <20260924203013.9967-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184910.GI2705364@frogsfrogsfrogs>
References: <20260924091203.198225-1-parri.andrea@gmail.com> <20260924091203.198225-2-parri.andrea@gmail.com> <20260924184910.GI2705364@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 24, 2026 at 11:49:10AM -0700, Darrick J. Wong wrote:
> I looked around the codebase and saw that iomap_writepages also calls
> ->writeback_submit.  Does that need to null out wb_ctx?
> 
> My guess is that none of the callers do anything with wpc after
> iomap_writepages returns so it's not harming anyone, but we should drop
> the stale context too, right?

Your guess is right: that ->writeback_submit() call is the last thing
iomap_writepages() does, and all of its callers (xfs, gfs2, zonefs,
exfat, fuse, ntfs, ntfs3) have the wpc on the stack for that single
call, so wb_ctx is never looked at again.  Christoph made the same
point on v1 [1], and the last paragraph of the commit message now
spells it out.

Clearing it there as well would be harmless but dead code, so I'd
rather leave it out; happy to add it if you feel strongly about it.

[1] https://lore.kernel.org/all/arITXTsUhrA0N-qr@infradead.org/

Thanks!
  Andrea
