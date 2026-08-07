Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0627451983;
	Fri,  7 Aug 2026 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085640; cv=none; b=MkxeYDHeLP4bo2m3uadC/Q5VYjYNLybTe2zLsbn1G/WMPzeW/3NxcKYD6ib0g+whLoixBmRI44Q6llPw6x3WJgoOtaWyxeUsuifKDP2ypUnZDj6BttsPHWeFdNtlY/gsJ5iuXFLViQ6ZTk+DTGA4jQ8Fw63QhO/II2VGoRGD7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085640; c=relaxed/simple;
	bh=g3jAJ4cV7vQyAY/5ajRVg2s9Xb6ek8wYoU4NkZBBlyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gg6tAoXZuuJuw2vQwz15AVdnsSY4nIA0GY0wJ8sWM+MJtlxlSsXTS2V2Z/7VQ7pqhLt9GLGpBPmlshBwBSyD9cQcjh5akXMKQ67zYwLGAIrdZU9YMSnVzzi2U3aLCNVHzn6PCXonY4wDpNs+FXs3EFyksS4utGl5h0p4pK5N1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: /3w6XIUhRMmC8WuO2Pwtcw==
X-CSE-MsgGUID: ggvO1g2JSU2ZEXXUbZBaXw==
X-IronPort-AV: E=Sophos;i="6.25,210,1779120000"; 
   d="scan'208";a="184867146"
From: sparkhuang <huangshaobo3@xiaomi.com>
To: <ljs@kernel.org>
CC: <akpm@linux-foundation.org>, <bsegall@google.com>, <david@kernel.org>,
	<dietmar.eggemann@arm.com>, <huangshaobo3@xiaomi.com>,
	<juri.lelli@redhat.com>, <kees@kernel.org>, <kprateek.nayak@amd.com>,
	<liam@infradead.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@suse.de>, <mhocko@suse.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<ryabinin.a.a@gmail.com>, <stable@vger.kernel.org>, <surenb@google.com>,
	<vbabka@kernel.org>, <vincent.guittot@linaro.org>, <vschneid@redhat.com>
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before vfree
Date: Fri, 7 Aug 2026 14:53:51 +0800
Message-ID: <20260807065351.93659-1-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <anSVlVpUXrA8ra_z@lucifer>
References: <anSVlVpUXrA8ra_z@lucifer>
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

Hi Lorenzo,=0D
=0D
Thanks for the review. You're right on the process points =E2=80=94 I'll fo=
ld=0D
those into a v2 (real name, Assisted-by: tag, drop Cc: stable, trim the=0D
comment, correct the Fixes: target). I won't re-spin it just yet though,=0D
for the reason below.=0D
=0D
I want to be upfront about where the analysis actually stands, because=0D
I'd rather not push a fix whose rationale I can't fully back up.=0D
=0D
The one-line change itself is sound and follows existing precedent:=0D
c08e6a1206e6 already resets tsk->stack to 0xFF, and 528a4ab45300 does=0D
the same in scs_free(). A 0xFF-tagged pointer bypasses the KASAN tag=0D
check, so vfree_atomic()'s llist_add write to the freed region stops=0D
faulting regardless of what the memory tag currently holds. That makes=0D
the reported false positive go away =E2=80=94 that part I'm confident in.=0D
=0D
What I have *not* nailed down is why "memory tag: [ff]" shows up in the=0D
report in the first place. On the 6.18 android-common tree:=0D
=0D
  - At allocation __kasan_unpoison_vmalloc() tags vm_area->addr with a=0D
    random tag (0xc2 here) and sets the backing memory tag to the same=0D
    0xc2, so they match at that point =E2=80=94 the report is not from the=
=0D
    alloc path.=0D
  - c08e6a1206e6 resets tsk->stack to 0xFF (SP can't be tagged); its=0D
    commit message explicitly notes the stack *memory* still gets tagged.=0D
  - The only caller of kasan_unpoison_task_stack() =E2=80=94 which would wr=
ite a=0D
    0xFF tag into the backing memory =E2=80=94 is the idle-task path in=0D
    kernel/cpu.c. It is not called for normal task stacks, so my earlier=0D
    commit-message attribution to that function was wrong.=0D
  - page_kasan_tag_reset() only touches page->flags metadata, not the=0D
    physical memory tag, so that's not the source either.=0D
=0D
So what flips the memory tag from 0xc2 to 0xFF between allocation and=0D
the RCU callback remains an open question. My suspicion is the async=0D
vfree_atomic / delayed_vfree + page-reuse interplay during the reboot=0D
SIGTERM storm (the trace also shows page flags kasantag=3D0x55, a third=0D
value inconsistent with both), but I haven't proven a specific path.=0D
=0D
Accordingly I don't have a deterministic reproducer. The report is=0D
reproducible only in the sense that it shows up during reboot with heavy=0D
thread churn; I haven't been able to trigger it on demand.=0D
=0D
Given that, I'd like to hold v2 until the 0xFF source is understood=0D
rather than ship a commit message that hand-waves the root cause. If you=0D
or the KASAN folks have a view on whether the reset_tag fix is acceptable=0D
as a "stops the false positive, mirrors existing precedent" change=0D
without a fully root-caused explanation =E2=80=94 versus waiting =E2=80=94 =
I'd=0D
appreciate the steer.=0D
=0D
Best,=0D
Shaobo=
