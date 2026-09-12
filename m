Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EA479892
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226794; cv=none; b=Uos+t/5NfUEYw8bwS0nk3DFQ6mYW8g5buYENpf/dJcTvEQ5MVUOTaN69OybijEhhcSzXwjYc3lvX3X7cRrYArRjM1Sd+yVJRnvEsuDA6m1lC2G4UGw8MU5BINIAomx3AH2Y3VHJLjxnQWHyHeB+/fd2WmGBrn4K2Bh39z39GasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226794; c=relaxed/simple;
	bh=H6q/DuWlj4OlRx5Y1QxJg+Bkt4jNFbPu30+Egq3Zxtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/E5EhH1zwatM45x8k7n9qNeJYgIW42nZP8xLiyWT5qn0KQlwEbrCXrG5pgoDz1Gz866TLms+/EKCVaRm3CKMEjsGbNFoQNONnI/eA3pm48h0krkJqax/vxQKdQKiudboig949GMJVLUywXJLi0s4T0aoH2lU4bnHL5onNMy4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Etv3vxFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Etv3vxFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FA31F000FF;
	Sat, 12 Sep 2026 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226793;
	bh=JigTpzYsSDw3lc+JIkHyL4ph9twNe9lbkaGP8rXlvRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Etv3vxFLObWf//Iq3Xqh7OsoNcjfwa6OktFh6Zl+LmtlHfYrt2jhRLZXAoxRPW9Vj
	 xtZFU+orLdurshrvH3HKw+EZjFPPC4EP3pgcOYoEzOwA8Fjf1rgPMch0SDChp9hmq8
	 hwHgnPEoG52v4dT7FA2Z6KrgjQEzm3dbGSWobBqskp+OJc+itE4yNqMl7SV8EMJA/I
	 R4f75PkGL9lDiPWUNXVMXO0U2SQxUyvkIhwbPwsip3olDRK/LNjgpvmE1m3JEfWT1L
	 vCyvW4yJGZYFzRvo1M8aq5n876XkYZRJove6Lxsl7R+mwKPz8fQZRNmgr9+0w6ugHs
	 xqwGUDRSz5ttg==
From: Sasha Levin <sashal@kernel.org>
To: Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Sat, 12 Sep 2026 11:26:20 -0400
Message-ID: <daily-reply-0014-re-huge-memory-6-6-ask-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aqMDyxhGXZyhcm5H@cmpxchg.org>
References: <20260904022657.2656810-1-ziy@nvidia.com> <2026-09-05-daily-reply-0043-folio-split-memcg-6-6-bounce-v2@kernel.org> <DL8LKM3Q9LGZ.DENNSVG6XK1C@nvidia.com> <aqMDyxhGXZyhcm5H@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review, Johannes.

I'm holding the 6.6.y patch for now, because 6.12.y needs this first.
c299a2285d9d ("mm/huge_memory: use folio's memcg inside
__folio_split()") is absent from 6.12.y, and we don't queue a fix on an
older tree while a newer one still lacks it.

6.12.y also needs its own version rather than this one. I tried your 6.6.y
patch against it and it fails at mm/huge_memory.c:2646. The two trees have
different shapes here: 6.6.y has split_huge_page_to_list(page, list) using
XA_STATE, while 6.12.y has split_huge_page_to_list_to_order(page, list,
new_order) using XA_STATE_ORDER.

Zi Yan, could you send a 6.12.y backport? Once that one is in I'll take
both together.

-- 
Thanks,
Sasha
