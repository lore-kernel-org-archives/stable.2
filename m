Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C249EC68;
	Thu, 10 Sep 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048236; cv=none; b=ndwA938tsuV4XhD2ME1VLT5ZLfeZwA2Qw1QQCbOENUoSbd3MlLGpopXasQrpHylElObXsOJHpFGZxqze93wMgdYbXnbxecXbG2zYxY4owJ/+D88/0CHBsf+0mC7ROXdTTkeYUTs9NJgo5fm9lF+13XZ6UEGFlAnPxe4ckxz/JVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048236; c=relaxed/simple;
	bh=ObttSUPuJWtDREqVBevLWOSAjo0/o1kGgBLjBF1pRgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN+LcQrZj2vHOIsPJDbZ2FNt9kPiUMkrSK+sJEui0zd4GEt87P44jYfxyeqLdMLw7486AkSp3uXIM3GIhVQ7p1GgVdygsLR2S/iIeBIvIcaVcShxElUXZcyMgWl/jSqedJIjLfGKnIHN5AfiUmSixdDtqpefc8HuwORVShKIdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHYXqgrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHYXqgrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B891F000FF;
	Thu, 10 Sep 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789048234;
	bh=VwmO6JoyIp8oliMkCBTQzJRr3QLobohWKKLtGJcigbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RHYXqgrPDudf68ZIe71XivQwMdxIothA27PwDc+d1AeI10KiiYWat3axWAz+0zIxj
	 ppL00eQtpr0UHGsPc1le+P1MGVSi/burLZy6HM+AJkXUin+d1xrOAtvfVS/bei0otv
	 LQjqWHbCStdg7d7R04Tvy/Y9iDtk+qLgiMxsNMLFuV5Ne7mJhyR2zcXPYWubcx67Wy
	 DDq47p8TBwgfEWZ/dWSGiLYPJd8NlL7sukIiFrj8jp5Di+jScVaaybsKN5PpIITRy4
	 sWJT2vcprFMmEoOcI6gmKxdpY0RpVD1TvVAIrIlnac7xhFbyya86I5K/cuc3VhGb0U
	 Quf8gy7LciChA==
From: SJ Park <sj@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7.2.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Thu, 10 Sep 2026 06:50:26 -0700
Message-ID: <20260910135026.168722-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026091032-outright-varsity-64d9@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 08:15:05 +0200 Greg KH <greg@kroah.com> wrote:

> On Wed, Sep 09, 2026 at 06:02:09PM -0700, SJ Park wrote:
> > On Wed, 9 Sep 2026 14:19:27 +0200 Greg KH <greg@kroah.com> wrote:
> > [...]
> > > Does not apply to the latest 7.2.y queue :(
> > 
> > Thank you, just rebased the patch to 7.2.5-rc1 and posted as another reply [1].
> > 
> > As number of stable patches for DAMON is increasing, this kind of patch
> > applying-order based conflict might be even more common in future.  Maybe I
> > could reduce this kind of issues if I could post fixed patches as single patch
> > series, instead of replying to this kind of individual failure report.
> > 
> > I was initially worried if your workflow is dependent to the guided workflow
> > (replying ported patch as a reply to each failure report), and hence if this
> > could make your job more difficult.  But I know the stable patch submission
> > rules are quite flexible.  And you may already have good enough automation for
> > such small change.s  So as long as I keep the essential stable patches rule
> > (use 'cherry-pick -x' option and add target branch name as patch subject tag),
> > that might not really make your work worse?
> 
> A patch series is great, and much simpler for me to apply, otherwise I
> have to just guess and go by the email date/time stamp to order them.

Thank you, I will try this next time.


Thanks,
SJ

[...]
