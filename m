Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAB4A3F0D;
	Fri,  4 Sep 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529665; cv=none; b=J4afCi4Z1BeU2sK8037On2lhKB+BRvZd/iNUILH9/JTPJGyxb2DWvkWH7c8hRVEa1lOAnWTtcCEKlvuYcrwM19C8AGJudBILtjEiYQAi9DgXmtLPf/7Q/FwlLRfrhvSHPgJCRYlMqf97O2xnPmDgVgZKuWqY5KP5om1izOesRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529665; c=relaxed/simple;
	bh=3QqozabmMHkHUpENbmDig1ETzOhnj3lQ3G3dAmT73V8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0le2GfdqsdjrnakmewarMFiiA2YZxgSY4expxcFOP5A+/7WFxfAluDavKgBM5RNBpI4EvCAxuHnHPGEIVDLb6vdeo+HvuPtUZ/M7dzpjfCJmnm5o1p53Xii5jYBpNCf8JPyu8lnJSS9+gHtPbmRpoMXIeKa5pSVLCRYzpYeXYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=qZd82czN; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="qZd82czN"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 9A11A81432;
	Fri,  4 Sep 2026 13:46:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id BAB8620019;
	Fri,  4 Sep 2026 13:46:28 +0000 (UTC)
Date: Fri, 4 Sep 2026 09:47:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ran Hongyun <ranhongyun1@huawei.com>
Cc: <namcao@linutronix.de>, <axboe@kernel.dk>, <bigeasy@linutronix.de>,
 <brauner@kernel.org>, <clrkwllms@kernel.org>, <frederic@kernel.org>,
 <jack@suse.cz>, <jdamato@fastly.com>, <john.ogness@linutronix.de>,
 <kprateek.nayak@amd.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <linux-rt-users@vger.kernel.org>, <mkarsten@uwaterloo.ca>,
 <stable@vger.kernel.org>, <torvalds@linux-foundation.org>,
 <viro@zeniv.linux.org.uk>, <vschneid@redhat.com>, <xry111@xry111.site>,
 <chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>,
 <wozizhi@huawei.com>
Subject: Re: [QUESTION] Are these issues PREEMPT_RT-specific?
Message-ID: <20260904094733.538d2af6@gandalf.local.home>
In-Reply-To: <20260904081149.3000727-1-ranhongyun1@huawei.com>
References: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
	<20260904081149.3000727-1-ranhongyun1@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: psh8ie81d61q8baqnffyuct988cftytm
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: BAB8620019
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19TT+Uqsvs68jLi/HGrQRy0ZkJtDf+Yw7A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=3QqozabmMHkHUpENbmDig1ETzOhnj3lQ3G3dAmT73V8=; b=qZd82czN5zoTGFHIggmhPCvwpL3n8aR7RjkZ9o1RXnRkWHkwxhx+raYkfoqpNaQ5uJxRob83n61gaHyGfzQhhsXqgkPCYdZJe6yniHpvfPimWBMWvVDRAw9erkORHDUJOPIB736vPU6E3JxroHiuIkq/SBXHKmc2YCqy/vRstxU=
X-HE-Tag: 1788529588-590148
X-HE-Meta: U2FsdGVkX1+vA/2/aWD7umZnnOVnwj+AOUZGPU6in8BExdihItVQ54rOyPf683PlAhickS/DeDAzLjWCsXjVa3msdvYh00OIuCmMUP1/dFmMHqG3mzuWwvV6Oi2gSXVyI8Sj3L9ixgLSx2LYvAFgiAMplhjtWnVEnpy6AP0lDmA4ZJjtG+KQq+FDl9XxMvPvpTz2MH7skVNTBlXX3rOPsMTmf6NIgGr80Gayq3I8hFqoXI8xoW+CSLBPB1b+pYf2t8DHZ7w0DwYQrmpMlm33/8HS5Ce8OAXbPuORtwp4ol9veT5wBM099i+S4zzUUZTRg/de4GFfKz2eJO+igNMbh1Gc+XEdsLZ8

On Fri, 4 Sep 2026 16:11:41 +0800
Ran Hongyun <ranhongyun1@huawei.com> wrote:

> 1.Priority inversion =E2=80=93 On PREEMPT_RT, rwlock_t readers lack prior=
ity
> inheritance (PI), so a low-priority reader holding the lock can be
> preempted by a medium-priority task, blocking a high-priority writer
> indefinitely.

Priority inheritance to boost readers from a writer is an exponentially
difficult problem to solve. PI is already hard enough, but multiple readers
is exponentially more difficult (we tried).

The solution is to make sure you do not have any RT critical tasks taking
rw writer locks. This is something that the Runtime Verifier (RV) can help
make sure you never hit this situation.

-- Steve
