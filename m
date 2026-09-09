Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CD5111B9;
	Wed,  9 Sep 2026 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958083; cv=none; b=hqsuXP5g9waByv59loAyoSTg9CNPiufP3aA0+t2enMy7A9KwxmR9V9HkYKhXRi853ei2DX0ZL+kFHVTMHoruAOjafrh1yrLpAN3E3dQm0WgTi/u9W1sfqPMr8DgqgTJlQhzBhtApo/sW479WSmH/5yXIe48/7LHAauSWt58p57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958083; c=relaxed/simple;
	bh=UH6njIIyQR9OD67VxOrA7ozK5cAuBO8Er8TuNdULDmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec2/gKAaWTT8ZSzgi89GZVcZVdSI2nXoVvD13AnodoP6g+Hc7nByfqtcyLpVn4d6W639mMyLcS76LUmzHqJlXSxyAmOfppdF4JbTyySfGon8BpDPukp117JBmdU1CdqNwXf+Buf/g/rIvDDyD4p3RKI6qihmFtx0GXtw7RjfGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=ADDLMYnF; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="ADDLMYnF"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4C8ADA0202;
	Wed,  9 Sep 2026 12:47:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 2ED5B80015;
	Wed,  9 Sep 2026 12:47:50 +0000 (UTC)
Date: Wed, 9 Sep 2026 08:49:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ran Hongyun <ranhongyun1@huawei.com>
Cc: <florian.bezdeka@siemens.com>, <axboe@kernel.dk>,
 <bigeasy@linutronix.de>, <brauner@kernel.org>, <chengzhihao1@huawei.com>,
 <clrkwllms@kernel.org>, <frederic@kernel.org>, <jack@suse.cz>,
 <jdamato@fastly.com>, <john.ogness@linutronix.de>,
 <kprateek.nayak@amd.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <linux-rt-users@vger.kernel.org>, <mkarsten@uwaterloo.ca>,
 <namcao@linutronix.de>, <stable@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
 <vschneid@redhat.com>, <wozizhi@huawei.com>, <xry111@xry111.site>,
 <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: Re: [QUESTION] Are these issues PREEMPT_RT-specific?
Message-ID: <20260909084906.75ebe0ea@gandalf.local.home>
In-Reply-To: <20260909030506.344667-1-ranhongyun1@huawei.com>
References: <63d5cd58e9b85acccdaaac9aed4a8c550cc7b868.camel@siemens.com>
	<20260909030506.344667-1-ranhongyun1@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2ED5B80015
X-Stat-Signature: o3fwibtfheyjf6uxcieed6spah8gf4o6
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Xhy7OK4OBMc93k3sLXpaXbNrFBmTU+H4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2JZIG0evn7FRLH7buEDQNvcDz4SWp2iw0ronrwwEllg=; b=ADDLMYnF3uDGdfsjFF0AU4mcXm38KNdi8JQJqfv2s53fOhf4+RXiDVgvjxqa2qfF+eWgYXqLtvVi2r6E08M1MGNT+fqqwDF52gB0YKtOpd7t4QfDjaEHj1AhZqNh9XZiz5cv79QyyIa6+fo1PJChOsle7nl88pcyxnhjlfRkMhU=
X-HE-Tag: 1788958070-860100
X-HE-Meta: U2FsdGVkX197gq9AYxmfVVmX8SBppYiJWxnth8UqyGIuz6uN3lbwz0pQN7siOw3O4K0M7d4v3vNtgdpSjudf8Q3H833uzaqs1ZB9LiXp/7l6WMYMfifkrHrWiG3iE4YpahG4qYMB/z74IxWPawDwy+le3fYdPgQZIBe6+TktybcVJeTH3KS9TtSQJiWLN4Rf3I9iLhilR9Uhgnch0QOvP7kUktj5KHGRuGz+rEHhAL14UZZkhrroFB52+2Oo2d1S8Z/IMYhj1hfDgtrfuPTvugC5o0UhmQzs+HeDWnndpf6D8+/C80z7YhEhGTv8oy4mQQIn7yLB4nr8YGUvVuOZDrUBMKR44PXZ

On Wed, 9 Sep 2026 11:05:05 +0800
Ran Hongyun <ranhongyun1@huawei.com> wrote:

> Florian,
>=20
> Thank you for your reply.
>=20
> Now I understand that the issues are particularly critical on PREEMPT_RT.=
=20
> However, I=E2=80=99m still not entirely clear about the "performance or t=
hroughput
> drop" you mentioned for !RT systems. Since !RT kernels are
> non-preemptible, unbounded priority inversion and stalls should not occur.

That is incorrect. !RT kernels have been preemptible for decades. There are
different levels:

  SERVER - non preemptible (but no distributions use that)
  VOLUNTARY - Has preemptible points in the kernel (might_sleep()) - most d=
istros used this
  FULL - Preempts everywhere that doesn't turn off preemption
  RT - Turns spin locks into mutexes and preempts there too

Regardless of that, unbound priority inversion can happen even in SERVER
mode. All it takes is three tasks sharing a mutex. Only RT implements
priority inheritance (for all locks but reader locks) in the kernel which
would prevent unbounded priority inversion with normal locks.

> Are there any other factors that could still cause such a performance or
> throughput drop?
>=20
> In other words, if I am running a !RT system, what benefit can I actually
> expect from switching from rwlock to spinlock?

Lack of priority inheritance is true for both RT and !RT in rwlocks. Hence
that does affect both of them.

-- Steve
