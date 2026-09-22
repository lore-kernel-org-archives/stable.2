Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB264D7D22
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058709; cv=none; b=QPbwpfjExq7U/siTWFzAjUhaoso97gjJqE0Amde0hldR7DBnJ00b45TM1R3c7iKL+QmrPFLdqo85nI9M+WKj1R30d06Ni340ncvcvZQDaVLBYMcaZR8fGqBLdVMuEPsB8zkc5WTBIy9nP+CqRzMNW7c6P0KWcT8VVBKacYUZzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058709; c=relaxed/simple;
	bh=WT7L+yjgB0IaOTyJkUQuzdzCWldIgXpJyxmwqVKairA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SXSQ1FPEO/4N8wEjamoH/h+Kj0CK9vQT+soUleMY40JmpfPIwePkS0NgIZDc+3fO1Vx3FOKw3bBvwZtMlKrG/Qc1kNOTpPmDDfJkQ7S23fJtYSB+tD+HgTia7vrnZvJlC/KgKVT75u4E/MFX3b96Dwk/QbO4epCVc5pwVTfFOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LpB/CUYj; arc=none smtp.client-ip=91.218.175.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LpB/CUYj"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WT7L+yjgB0IaOTyJkUQuzdzCWldIgXpJyxmwqVKairA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790058701; v=1; x=1790663501;
 b=LpB/CUYjTjm967AXQGqhKG2Um7zaWi+Ev0UShWn+xxYgieaEB1dHfQwywqAuf/GWO1fvcovB
 bYPmRErc5exgVzHm+oK/rj0skdXWsiXsdW4mrtRsSujt2X+AXORvyttRSLuuJ+Urd4yRTQZDpPA
 0UuuVzJCYhU568sDzvnJdgOU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3d5eaa6d3b009fbe;
	Tue, 22 Sep 2026 06:31:31 +0000
X-Mizu-Trace-ID: 3d5eaa6d3b009fbe
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 2/2] mm/memcg: migrate per-node hugetlb lruvec stat
 together with hugetlb folio
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <arIEfJXYpspgX4-G@localhost.localdomain>
Date: Tue, 22 Sep 2026 14:31:14 +0800
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
 Hongfu Li <hongfu.li@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Nhat Pham <nphamcs@gmail.com>,
 Chris Down <chris@chrisdown.name>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Hongfu Li <lihongfu@kylinos.cn>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D086B92E-13A8-48A7-97B6-CD671EE22033@linux.dev>
References: <arIAyyjYcCKHFmyD@localhost.localdomain>
 <20260922042054.3264663-1-joshua.hahnjy@gmail.com>
 <arIEfJXYpspgX4-G@localhost.localdomain>
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 22, 2026, at 12:30, Oscar Salvador (SUSE) =
<osalvador@kernel.org> wrote:
>=20
> On Mon, Sep 21, 2026 at 09:20:53PM -0700, Joshua Hahn wrote:
>> On Tue, 22 Sep 2026 06:15:07 +0200 "Oscar Salvador (SUSE)" =
<osalvador@kernel.org> wrote:
>=20
>>> Why do we need the whole thing to be embraced by rcu?
>>=20
>> Hi Oscar,
>=20
> Hi Joshua,
>=20
>>=20
>> I believe it's because now getting the memcg from the objcg requires
>> an RCU lock to make sure it doesn't get removed while we work on the
>> memcg. I think this is since Qi Zheng's "Eliminate Dying Memory
>> Cgroup" series.
>=20
> Yes, I understood that obj_cgroup_memcg might need the rcu-dance, but =
I was
> unsure about the mod_memcg_lruvec_state() calls.

The caller needs to make sure the liveness of lruvec, in which case,
lruvec is from memcg, so rcu lock is needed here.

Thanks,
Muchun

>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs

