Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870E3EEACB;
	Fri,  7 Aug 2026 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099391; cv=none; b=AxQD7pYbk7easrnost4SDBDPYbTtkHFHJa7ffHZypljU0cHPbYuNbJyJyZdbYjkGWRX5sibwNQ6AEcmG23Lrm2aa/27/FwhGMHuZSxeK4fhMAm6b11llU2bhZZkuxBok9EzEl052Wg4ju9igu7PrBSzpkbAlTQiDOjUEIqIxFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099391; c=relaxed/simple;
	bh=NfDWl1UYSrsqSZkLmblBc7+ZgUq098pDaO73X0mK52s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCbIha/4mFgD0RBkiIsRFv8L64iTxpZLYSSm/kjq+2xitYGE51sivE0p/9mRpBTjFEclt2Q1+952REkS1ApN4mO98hxL3xpEZexm3xAjmScvP1Qk14z7CO/iGQ7oOIrMVIs+dInld83qgTcjsC9PgWGVf3DJS+ybrjzPoyL+xqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: YjO2XvMlSoCTXOLeMbuwUg==
X-CSE-MsgGUID: Zvr1NyS0SHae6w3tESf8Ag==
X-IronPort-AV: E=Sophos;i="6.25,210,1779120000"; 
   d="scan'208";a="158567415"
From: sparkhuang <huangshaobo3@xiaomi.com>
To: <david@kernel.org>
CC: <akpm@linux-foundation.org>, <bsegall@google.com>,
	<dietmar.eggemann@arm.com>, <huangshaobo3@xiaomi.com>,
	<juri.lelli@redhat.com>, <kees@kernel.org>, <kprateek.nayak@amd.com>,
	<liam@infradead.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<ljs@kernel.org>, <mgorman@suse.de>, <mhocko@suse.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<ryabinin.a.a@gmail.com>, <stable@vger.kernel.org>, <surenb@google.com>,
	<vbabka@kernel.org>, <vincent.guittot@linaro.org>, <vschneid@redhat.com>
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before vfree
Date: Fri, 7 Aug 2026 18:41:53 +0800
Message-ID: <20260807104153.94261-1-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f5af86ba-e724-4b9f-acdb-2445e2ec4b1e@kernel.org>
References: <f5af86ba-e724-4b9f-acdb-2445e2ec4b1e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX03.mioffice.cn (10.237.8.123) To BJ-MBX01.mioffice.cn
 (10.237.8.121)

On 2026-08-07  9:27 UTC, David wrote:=0D
> Were you able to reproduce this more than once?=0D
=0D
Still trying to reproduce it. So far it has only occurred this once.=0D
=0D
> Does this relate to CONFIG_KASAN_STACK?=0D
=0D
I'm not entirely sure if it's related.=0D
The configs relevant to this path are:=0D
	CONFIG_KASAN_SHADOW_OFFSET=3D0xefffffc000000000=0D
	CONFIG_HAVE_ARCH_KASAN=3Dy=0D
	CONFIG_HAVE_ARCH_KASAN_SW_TAGS=3Dy=0D
	CONFIG_HAVE_ARCH_KASAN_HW_TAGS=3Dy=0D
	CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy=0D
	CONFIG_CC_HAS_KASAN_GENERIC=3Dy=0D
	CONFIG_CC_HAS_KASAN_SW_TAGS=3Dy=0D
	CONFIG_KASAN=3Dy=0D
	CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=3Dy=0D
	# CONFIG_KASAN_GENERIC is not set=0D
	CONFIG_KASAN_SW_TAGS=3Dy=0D
	# CONFIG_KASAN_HW_TAGS is not set=0D
	CONFIG_KASAN_OUTLINE=3Dy=0D
	# CONFIG_KASAN_INLINE is not set=0D
	CONFIG_KASAN_STACK=3Dy=0D
	CONFIG_KASAN_VMALLOC=3Dy=0D
	# CONFIG_KASAN_KUNIT_TEST is not set=0D
	# CONFIG_KASAN_EXTRA_INFO is not set=0D
=0D
> Can you share the kernel config?=0D
=0D
I'll send it to you separately later.=0D
=0D
Thanks,=0D
Shaobo=
