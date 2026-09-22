Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCF52759A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067796; cv=none; b=KldHajs8/3uKoVSbQR5W2oJfmgce0Hai4syRmHhGxMHjd8XxXKMgHGa56fV9I7cAvzSTNa54cj2JaUyOsy2LPAJmGZrNY33FcE2pRSU3niJvjhfyxaxNHdzRSC7I+EgPyD6/rkhEHCi9HViiCojONS0KdY+6Mx4QKL7DGFYkzdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067796; c=relaxed/simple;
	bh=3T+/5+/qt9/zQc/iBOuhbw3f+5o3VdTK6NF4SEakQPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuSX7SLfVbE/ECAmEss0Lrw5NBg37LW75O/nVg9HnTFCsHrvFmapZUXvDRUf6c5he/v445LqrhGBQ9VB0rkZYHcUSTvt99tsF7+ygtDABNleY3CI50AJtztEIQQEuEWGZ1X1UtaOMo12JJEvHIJKGsnSF1TuPUFqt6YIIFdC6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcVYwDEl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcVYwDEl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so32849515e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790067793; x=1790672593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tXgGr2qFh/euRpkCia3YpYMa0+avEGxCjpNyfGxf7Ek=;
        b=kcVYwDElJJO0Bo4n0d8AYkFG33WJshJCLsbDGXkLKxMQhuBNiSG51dXQ7ZND3m6V42
         qQFhYG4CEfG7rkPsBUWynJc4jeS82xjWywOyjwpYwGoNCUudbluxf7DDPB7wdjjOjFUX
         FqHelefKELTePbP0z/hyJpYo701LO71NmEDxdjb2Pt3q7oMd1FGkDad9fVfL32HFlPCJ
         Y02YsPvg68CLxaFYMHT/8ZiP/mOJFvKhCkwr+B7j90ILpRmQUugG3ewo18sCzobxJlXC
         4Am8OC6JGfrQdJh8EnRBHatHAhUEAqE/de8NwdZM/TvvKgsZOc6BGe4BmC4R1mLQi/x3
         u4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067793; x=1790672593;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXgGr2qFh/euRpkCia3YpYMa0+avEGxCjpNyfGxf7Ek=;
        b=gA4JtcNDhBi+4AhZF8ORw7beEHzDp/ALz1qixSHxW4d5hglo+GsP+9QgBJrlQUDTFS
         LTg73KhfVblc7kvNCW63tTk1LHSTDtyrOorJiZIGDJE3+txA6xtEkC772/j+yOSlPnfe
         lCZH4va9RHV3sDDmIJRvBTgGXoGJyW2dY3Vwuy39leXR6WFDLduMu0pdu02hkTlafsqQ
         gGbb3mvC/9RgJ8tp7gcSsfKEETZX1oMen4vMm38DDUoWlJ39Aml1Hw+pTO65HqnfYAlx
         Yjr8Z41dCeMtsMFWZsFzdr+kzWyRR6+WpUXN39jZvu9Rveg+E6nzHbFbvhFFmG/FiXEs
         nnpw==
X-Forwarded-Encrypted: i=1; AKwUvBy9EdideyKdroCsDXpu0GEfJvPtn0ETSSo2TgmI/mWnyp78oRJJ+dMP5W2Mlvan5b9GKs5HXyw=@vger.kernel.org
X-Gm-Message-State: AFuF++nVRE3M+GPvo/LyStvmorPussvXHzY2CrilfxIyLRg/lYkCsGJR
	Gjkyk2ESb/DE/4a8S8TyqNhRllMeOZLhMFPUwEa6qBhqzpGzr+QgxTxm
X-Gm-Gg: AYBFou2lPnbQHaU151D3YA5i6Q8+aQV/gziCJh8x6iFXEZP6+ArSxZji5KL75OkLav1
	vM418enOpIIc9IrnMwjElpMfCNRVI7sURvQhJKYoKQdscWYptPcnuNqeNWNiUIeVWyWjHhVDcOR
	kVkWx40/imkxkPfPMnsQRiInjMbqJvcADc53J0zR9pbfxYrgr0DrWrobFNMeLuaLnfzbOHDO7IK
	MuAkFg6tld/mSdgwm0ewTlpmRssTcZ3g/PbWzSecnBRC3Lvc72LomwiSm7REaZ/Kxsg68tIuixr
	OTjDsJ70PwHvwbmtibtp/4UfJBk6trxQTaqFlQo1dh5eC8lbBPNSXpKPUbWR+wtOUQXv9wjouvV
	rrhTCAjIDHVt8dhcUre69nxzuwO/W6rnat8ETfihTUni4l/djXJpk8gjIOERv9X4UirfafzHaus
	STmGzY4u/Rax6tDDX/xCqaKFEbDRKGqYWpmiwC1c7QEp7Hr7U/9TdgpsF5lGALqyEP259zw/G4X
	ida29Aw5/UXSMMFYL/NNwjw4PEJSwnxJtfF/8PLRw0L5mLJX4yh3+TuvEvcvYUOekp5YNMELseR
	aDLP
X-Received: by 2002:a05:600c:1385:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49fc5673264mr182704015e9.6.1790067793380;
        Tue, 22 Sep 2026 02:03:13 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace7941sm42684265e9.2.2026.09.22.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:03:12 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:03:09 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
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
Message-ID: <arJETViXYZbX8ckp@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-2-parri.andrea@gmail.com>
 <arITIy2upsoN-DlW@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arITIy2upsoN-DlW@infradead.org>

> Do you have a reproducer for this using some kind of error injection?

Yes.  xfs_reflink_convert_cow() is the only in-tree way
xfs_writeback_submit() can fail, so I added a boot param that forces
it to return -EIO, reflinked a file, dirtied several widely
separated CoW regions so writeback has to submit more than one
ioend, and let background writeback run under the fault injector.

On the unfixed kernel this reliably hits "list_add double add" in
__list_add_valid_or_report(), from the stale ioend's second
bio_endio() landing in xfs_end_bio() and relinking it into
ip->i_ioend_list. With the fix applied, writeback just fails cleanly
and there's no corruption.  Happy to describe the harness in more
detail if useful, it's throwaway boot-param/script scaffolding, not
something I'd want to send as-is.


> Overly long line here.

Fixed, will rewrap that comment for v2.

Thanks!
  Andrea
