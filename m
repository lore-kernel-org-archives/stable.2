Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3039E6CD;
	Wed, 30 Sep 2026 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755804; cv=none; b=PgzGENBudEdDxbWpQgXsCl6P0Qw/SHi2ykZX1X9KQd0AWixHlN7/CPtN6QoxzDH2vKmgs2SL/etQr0o84D2V+l3HowEpulgaZM+ppk82Q7vX++EmsN3H8uCzKjZqALDyrvDzJY488U7coJ0fIjWIX8Ht5tOkoghZq657NH6FHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755804; c=relaxed/simple;
	bh=5Bq7CwkwG2BbE5AbKxX+EDQD6C2iA+WQh+g+1xwTINY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAPExownUkUqMULhFWPWRPbr82/GDn5yndSNIQMOLKuDrjaNYjqY3SdHo9gIHZxdc830XlR8hb5D06eOzM6JuW3bqRLCHMRySpJC7hPlfpHAgv1CGOomUQ13pxmtAUKsiVPil2YgRKlFQWGOSMdu80O6FoQb2+nyFM7YDSQ/EA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRLZ2rKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRLZ2rKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118801F000FF;
	Wed, 30 Sep 2026 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755802;
	bh=8a+8qeyAxtgsnsiYexx9Bwy/G9Ju1QoC30zUIT78gOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRLZ2rKBLZs4dXWDFiEzdoX2I+Pqhb7rLYAg1J+2wJJS4lYqk7Dor9ffFEp9H+8CC
	 pwsDFMQCB/ZMVstTrl+Cf2OoFWMoS8iL1W5nFybeFqgJEM0RAd5YOFJOdpF9vunuJV
	 gv5gNI34YLlORAX+/npvpZ/b5bikc5r2te+O3ogaT8tSR4QmVPGiMtXmkScTWbzrcv
	 XlBj617e524mDLgPdP3OJUhQ064nuyh5f2X0BluzKRVLhRClYlSJXZVCY+6fsEBHop
	 vm28sfA0mMPdP91AxmAZ9zJ/f+vJk+6fFWai7ftF0lcDna3zTNV2zO07LAkJs1YBs/
	 /a74kw6pNYiFQ==
From: SJ Park <sj@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 1/2] mm/damon/core: allow esz to be set to zero
Date: Wed, 30 Sep 2026 01:09:58 -0700
Message-ID: <20260930080958.11031-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026093025-cadet-late-bf00@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 06:34:35 +0200 Greg KH <greg@kroah.com> wrote:

> On Tue, Sep 29, 2026 at 12:13:19PM -0700, SJ Park wrote:
> > Hello stable team,
> > 
> > 
> > Please don't apply this patch.
> > 
> > On Tue, 29 Sep 2026 10:44:55 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > From: Liew Rui Yan <aethernet65535@gmail.com>
> > > 
> > > When the temporal quota goal tuner determines that the goal has been
> > > achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
> > > zero.  However, damos_set_effective_quota() clamps the esz to
> > > min_region_sz when quota->ms is set.
> > > 
> > > This is a minor issue, the main problem is that it doesn't match the
> > > description in the documentation, which state that if the goal has already
> > > been [over-]achieved, the quota will be set to zero.
> > > 
> > > Fix this by set quota (esz) as minimum as possible.
> > > 
> > > Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
> > > Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
> > 
> > The problem happens only when there is temporal tuner.  Temporal tuner is a
> > feature that introduced in 7.1.  Hence <7.1 stable kernels don't have the
> > temporal tuner, and this patch shouldn't be applied.
> 
> SHould we skip patch 2/2 here too?

2/2 is good.  Sorry for not clarifying it.  Please let me know if there is
anything I can help.


Thanks,
SJ
