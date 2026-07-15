Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09693C584A;
	Wed, 15 Jul 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122002; cv=none; b=mCa878/SmC9n7lCjNzeXCq4lgqiJFf4tRgrXmuphX62swi2c2U+yDTdUC/7JXIFwxPKRt3VBS4xNelnJrgIZAWhIyh/ehaFoFDrBGslax5swytQgKIU1pIfW8ukh8SwzcAEIRztPcMZJDW2MrUYFGSDVpTlJrxoGeiwY1rdDO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122002; c=relaxed/simple;
	bh=553leeckiutKczcmPf0IbB7xPYgBFvVEfa1gh+zkrlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpScv+8sb6TbDgLKCRl+tvYTzRcAO+JxkUb6S/JmXKT6AUuDIysxkdaDbm7tG7XqB/4cxay1l1036O5u7vy2Y1xcz6Rkcfd3bTsAKogYFfpKRALdA0KhYLp+AJWUF8i+O14BM34SnB/LAvz6G+Pthvqhu4oozjPvDUY9tDANN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL1oh0Eq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL1oh0Eq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A5C1F000E9;
	Wed, 15 Jul 2026 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784122001;
	bh=tmYHqq0/128SCrxfsjngrNQmfX+jHP8UqCkkUU5HEDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UL1oh0EqJ+8kpvTbuQ0OyYXKDMTRlMW2BhHcEKRAqhLn/A30MdpJca7awDnQtdJKm
	 eH7liGconcDiy6RyMcLyDvW9uoU86VTA2lZOsh1yEasDWDPpD7N8s3qYskStzdwLqD
	 4SWXiIBW0RMjK2EnIHBV364zBTEvVSSvVDp12vH/56QywovkyRBj0wc9xzFjOn4bsn
	 gLxSQajgj+bG9/w2IHFK9L63NrNB0KOl6gyVsI/tlg8KrgubxQRQYSv+TjSJ0d12si
	 Zfay2rGl7MbF5EDY1jWwOX/+VV1iqTzk48M7rplC8Y1hyZKJNar+jpd8OqULiM6ZY5
	 qpRpobpRFnoCA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1.1 0/6] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Wed, 15 Jul 2026 06:26:32 -0700
Message-ID: <20260715132633.32217-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714214604.10fc4c786277eaed523d0724@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 21:46:04 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 14 Jul 2026 20:09:55 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> > dereference and monitoring results degradation.  The first two sounds
> > scary but the infinite loop happens only under unreasonable user setup.
> > The NULL dereference is only in a unit test.  Monitoring results
> > degradation is trivial since it is only best-effort, and those happens
> > from only unlikely races.  Still those are bugs that better to fix if
> > possible. Fix those.
> 
> > Subject: [PATCH v1.1 0/6] ...
> 
> So... what is the significance of "1.1" here?

As the changelog says, one more unurgent fix (patch 5 of this sereis) has added
on top of the v1.

Maybe my versioning scheme is confusing you.  I increase minor version when it
is purely for findings from Sashiko and if the change seems not really big.  I
do so because I realized it is easy to get version number large in short term
when I respect Sashiko, and it may look confusing for some people.  Maybe a
better approach is running Sashiko in my local, but I don't have AI setup in my
development environment...  Let me know if this only confuses and bothers you
and you have a suggestion.


Thanks,
SJ
