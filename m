Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203944213B;
	Fri,  4 Sep 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515869; cv=none; b=nrbwtA2aWDeoOzFYJFJA2yAhYq3nVfy8ATeeMxv6ng0h5qxK1aFKBa6GGQEc+4PtZYnUqG4y7RDf97CmMz4q48791t6ZVTqL1JyfUUC3QDvraef+Z/n08mo8WpKshjy40vbYao1Dli4gh3e9e5Otx9Pu/6JncyUPFCqlnsS2kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515869; c=relaxed/simple;
	bh=/15UFxxirqrO6Bz4pIRkXUatQQguIa781LW8rPq7u7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ho1aZrAFriayRsSxU9+5A4i4n0JFBUTtadcFQQL/6US6fp4y2LzgVgTsJtdK+2jJfeP55gwEpv55g1Z+sg8l5LVNVwW/ZsqRMsRg1BrnHXbAuCYg6Lk868ziUVfyo4uEq/Dsl4gjRtBLWayIuLdzWxnHpRR66QPGWuySku6a55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrXcC9Rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrXcC9Rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D2F1F00A3D;
	Fri,  4 Sep 2026 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515867;
	bh=/15UFxxirqrO6Bz4pIRkXUatQQguIa781LW8rPq7u7k=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=BrXcC9RzxRJ6NySORcZpN3sm3JkaldhaXPz+gnhZPMY1EadAYOkbv4Nh5Rpok4xMz
	 jLBZqo3QXsnSPvLzrXQKY1lru15mUz64nWx8UpmzTZazPuNYvX6gj+3UchvxheCpgM
	 TN00/LFSCsjOOJhFKBbSg0v7k4F4RQCiRRudG8ZSFo6wwe+TI7Ke0ptJ89XOYElo9Z
	 MAsOxGQAco306BHkGjpdFKPw7xYp595gjA0o/3xytpx4/qOw2hgjndho2ZTTz9F0xM
	 K2QBq067hYHrOEbggHjG6zJ7whSRFEImLMpJ4UZr6/zZPljZNHbYhmB2GaFs1rPIg2
	 s9AyF43jcFZ1Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 11:57:44 +0200
Message-Id: <DL6FYL70FVCX.10MCZIPFSVJ5G@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Cc: <phasta@kernel.org>, <christian.koenig@amd.com>, <tursulin@ursulin.net>,
 <matthew.brost@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <mdaenzer@redhat.com>,
 <alessio.belle@imgtec.com>, <luigi.santivetti@imgtec.com>,
 <stable@vger.kernel.org>
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
In-Reply-To: <20260904080618.2098450-2-malhyuk97@gmail.com>

On Fri Sep 4, 2026 at 10:06 AM CEST, Jonghyuk Kim(MalHyuk) wrote:
> Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the=
 rules")
> Cc: stable@vger.kernel.org # we don't know since when

How is that? If there's a Fixes: tag it expresses that this commit introduc=
ed
the bug, so it should be known exactly since when it is present.

However, I don't think this is the correct Fixes: tag, the bug was present
before. I think it was present all the way back to commit f556cb0caeec
("drm/amd: add scheduler fence implementation (v2)").

It is also not the case that it wasn't a bug before we had per-context
schedulers, it's just that it became much more likely to trigger with
per-context schedulers; nothing prevents the kernel from having a reference
count of a DMA fence after the driver was unbound and hence the
per-device/per-ring scheduler was torn down.

More in general, putting "we don't know since when" for the stable folks is
rough. If neither the author of the patch nor the maintainers of the subsys=
tem
can figure it out, how are the stable folks supposed to?
