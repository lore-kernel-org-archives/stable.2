Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD94432F2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067204; cv=none; b=eGmrTUM6gV+kgeFnKdKYIO8HVMxHxJ+Mk3706QHZY3hn6R7ioxYtUTuKMNKNYCc3/Pm42zj2NDwR+RqBU/muvnnY9U86n1ER1Pt1i8iWPcQRidpzAwQnF+4WdEwqGVB0cB3M5VVMp3TT3auTX0deG2fET8/6NuWVuZoKIF53HF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067204; c=relaxed/simple;
	bh=cwkQkF8AomV2dnbKJf7T2kOh90w6b9kYZ0Q3BS/MIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUu7LG2pZTeiYptQykSrwv+KoLhthQmnHcSFXVwk0aZiRbPj70JkxKW/hm3fV0a1oxr93wtvlcyajpD3RO74ZJpSWW7eQ3QzrAdMuyyJhi0gLrafdX5Uf9N3U+aun5OFOxn5mSDkwpLVbpRE/hFuypjDCgAWy2EHY0A7geD+UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3uYbXx/; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3uYbXx/"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so22111375e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790067201; x=1790672001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0GErKr9K3VAL0iFgFHZZrAHFzNuomMjoi+stMILpMQk=;
        b=U3uYbXx/8vyGkMOwkCoDp5bAjLPUR7AWh0B6hx3lKkSU4aa9YBNuFshTbmkMp/3Vay
         uDMRe9fj63AeYQ/xJSeekI73IN3cQCzJkwan4pcSVs8SFBX33iuytK7FRYf6RmmpS0lW
         pJsyz9k2hItYA0XOQGc8/jrN5SEs1Lz1yvAon15q+qciLMR42iylsMuQhcrudqxwVUy8
         PDotFqE3vGXKJwhE+I4Gzb0En3HBd7mk//jgm4yL796SbW7ISBClWBqRyFWVyU/Bw7RZ
         OdJcyepTOcOsEJuzIMJQ3Pa6VwB8qk2YW27vFLs0K3wUN2DkaT1NT7rt16BegZqDqYht
         VHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067201; x=1790672001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GErKr9K3VAL0iFgFHZZrAHFzNuomMjoi+stMILpMQk=;
        b=WHsqmjr6x7DTAgeDjQd08fRLtyMnxboLC/Nybwze8X9rFcJguohrMttBu4P7/2ZuRw
         52Kvb7MP+ebt5YoizQfWK/QU3Ci67eBrxEzK1bnrAjaq2Ndx88oaieSLt3WpFYb56k35
         ctBDShvaHYJLX2pHoR5PWKUQ2vD288Cum0cNRs+/MD+NZ57gaKddwRT7aIMb4faclu3W
         yfHcCRmR30bmDYChHxeluU9k/caPUxE8mvzAQ23SQ11BhFC96Jy0e2OMVM2RGjlTH0gi
         6O+sJZAeZJZAooG0VUIxsE745vxYVng1tqm1i+dd1eDnFifHCSzPab9rA2otLI954ctg
         lKMA==
X-Forwarded-Encrypted: i=1; AKwUvBwfrLWO/oQBs6XjAnKqJ6eso2EfKV0aXYoLPzIXXGcRwN8QK2AVUCPWDFceHG2sk3UciUIiBWA=@vger.kernel.org
X-Gm-Message-State: AFuF++lSt3tPxPVrcON7RbWnigGvAKpP5s8SkRukG6k9PdqkttswpP0r
	60IGtCijpRrwXm+DpSYbnYwChuO9a8xV81ppkZ3Lo+u94qSFazmuqUC9
X-Gm-Gg: AYBFou3v01Oe7TfBWyWJlH5AFRG20T8ZRgA6Z2b2fFZtFosX1rnPKqSjbyrXGxLk+eL
	GhdhSYnJ36kZpK947iYCO+io9+vnuyqbn6DFvuqsrVRdNnAh3cZoA0eAoCKfjrZAbKoV7pU0rUR
	VIMccmY3Au66eIdXwW4z10BSZ4RfD9LX3Yh78JUJsR94+s487KOMGkiC1aOgEjAFNI1C+gh6wB8
	xy8iCpxuGtLk6Z2dYqjvlnHWX212u192bwlMoQybUoNizron0vYvauy/Cup+4jk3m/aasau9KD/
	dX4TDCEfheqtMZaLiQ8jEuDtUuUiJ1P9RlQrWIFcAXxahTdP+4c12KJ58eFDJAUPy40UbHyNWyh
	pjlrWwXcacocIjJRICiyvWYPb1SDhfLdm0/gcv3Wz9ZKtl0+UMCTa7o9vHr/oiKsmGHr0M0yLwM
	EcOWvRTuqzr14MjugUlex9f5BSZU05qiAHBLllUwNwBqgIcVlc3kCZEHi+6ZtRFeXAvsjZ7shR6
	EZ5kdyfbySeA7a1yW3jkJ2ux+kBqpk5aIVhO9emDb07oc3cB21f/giSYtgWPbaC9Pm6zNVv/zKu
	k9Bp
X-Received: by 2002:a05:600c:8584:b0:49f:cbf1:e76d with SMTP id 5b1f17b1804b1-49fcbf1e9a5mr119933255e9.0.1790067200729;
        Tue, 22 Sep 2026 01:53:20 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad36439sm52688975e9.6.2026.09.22.01.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:53:20 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:53:14 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iomap: don't resubmit an ioend after
 ->writeback_submit() failed
Message-ID: <arJB-tAZTbcuPaZJ@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-2-parri.andrea@gmail.com>
 <20260921222953.GM6283@frogsfrogsfrogs>
 <arITXTsUhrA0N-qr@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arITXTsUhrA0N-qr@infradead.org>

> > Do you need to do the same thing for the ->writeback_submit call in
> > iomap_writepages?
> 
> No, after that the wpc is not reused.

Matches what I found too, thanks for confirming, Christoph.

Darrick, I'll pick up the v6.17 stable tag for v2.

Thanks!
  Andrea
