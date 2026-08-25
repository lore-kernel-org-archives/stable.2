Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209A3EC831
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658588; cv=none; b=usNAGU59KK8M1fisQhinQtw1is7+Bd0DAPP34z8kz7AcsUz2xknV8tvffcKrwFgBW4VHwVNgnSc8Fzv/90dP0s8lW0N2dgSn6j0kdVZiapqBhJwAKeUa+3up3K1DMIXAToCKC/5r9zkToWqHSkRyOrYyGsx1oSEZ2JxuE5twG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658588; c=relaxed/simple;
	bh=Gsw8CoTtGMSkDwfKmCqZ8VIgdyYGc9FyctcejeA/8H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq3R2n1kiTYHsz0yhj2zI8SwplGeo+rIW19AJbPRlZmcXIKsHHPhvPNKlPHbNj5cjRBNPsOxt2XJO16FXHrmrw54PvyQKd+c4Eh5AmV7oVAvj8KeBw5w7nwukBc8xJsFn1KuohMuaxIvuOCeBKYvcbd4J1XstiwghbLcsZCKDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLISU8FU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLISU8FU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A718B1F00A3D;
	Tue, 25 Aug 2026 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658586;
	bh=fRd21ZLD/jgKnaDIujckOI3U3MiRvPOhw62GsK+JRsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLISU8FUFhTN4y+0/lX5QxuOvlrZPcFTeUah5B1HMRKcE6PnKdZc4Jdz8L5rz6AAr
	 qM3x8uMtU/d/P6pan+kgPRwZvnSGnT4TZOHUADGyivNHBl9278caksz21CnrU+T+rd
	 Ns4fhX6rX7H9cQguEdc2WCQ1ROiZQWSIYNNPJB7fS/X+h1+aNWJO/SMnWdt5zCt/Rx
	 mJatSQZR70YHw5dGCj3wbjB4Glo7z81zoSDYn0npZWDNkfsJziiNlnB4HJEidM5hYj
	 lPaxxGrKGeLevovSFs7v6AEQzD4+09r3QIaLbZqtcGojY5p74MxTVD+EjubJ5nu4QF
	 vS9h/QCUc+MQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 6.6.y v2 0/4] s390/vfio-ccw stable fixes
Date: Tue, 25 Aug 2026 07:49:28 -0400
Message-ID: <202608250006.9e28a4bae2a86a35@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821174951.3467637-1-farman@linux.ibm.com>
References: <20260821174951.3467637-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 21, 2026 at 01:49:47PM -0400, Eric Farman wrote:
> Here are those all fixed together (I hope). Built on top of the current
> stable queue that includes the other fixes.

All four are already in the 6.6 queue, so there was nothing to re-apply
there.

While checking that, I noticed 74186c2968f8 ("s390/vfio_ccw: Free all
memory if cp_init() fails") is missing from 6.1, 5.15 and 5.10 too, so I
queued it there as well - spelled u32 instead of dma32_t, which does not
exist on those trees. Thanks.

-- 
Thanks,
Sasha
