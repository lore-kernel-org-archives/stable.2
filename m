Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A319CC0C;
	Fri, 19 Jun 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829069; cv=none; b=u1ttx0capbgXDA1Y6zluLlfO7JUWRKCFDEo20pvknfCTrLyHUQTLGnIuhasplyKb+OkRTvPidPzMY2OYQHkNjcT97Pd/mUxF6Ys5DpFHIC13yazPjsAXQxyswbg31xd3IuoCmwvNzBxt/cBDlOnHQfCPUApDJcASwZQcyCWaiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829069; c=relaxed/simple;
	bh=c8cySrTxQXTlU6I4M4atQIMWwqZGZI3eqI5uHorHSQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzodq3LnwHiMQyidF7BnLWiMBDuOgoaq2guEy9VYfQCepRN9mvVE1mI9M/h5cJk03uwCJqZz2TiBEVQ2zxUZD6KIdwOOValpwROtAgcQ1ZxUWniWSFDYoLzCQjaBc7Mt8SjEHOHyG8VRx5hpdCTX2zyPVAbYHydX7SwXmWmTOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwDu/gQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwDu/gQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0971F000E9;
	Fri, 19 Jun 2026 00:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781829068;
	bh=utvfSl21aCDRZRwyVcgp4w+0VdsKPaEHtWbnJKfr1i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwDu/gQFRInZmm6OJPBU8nh54p18ZN3ioLtEZGDM4y2ytDQn3DWa8gVZTMlip/oAy
	 NwcgaI9Pa1QgH+6cZzqjeqtXqAaeR6pBC3q3zBNjw4tM/Akd4eWdQn/jpTqP2qvz1l
	 bunT1YVMuUvOtloFUgbgjaCkaTXiV1tINTKMDdrxeawgURjHfirnxJDj8ZrI8cF09r
	 ppeTJb1TbGVMtjg7LAvogO/rqZLPF9LuPq0mqblkz+5qPgNh2LyI4dfGoFp8Vgu+DR
	 yhHtkmqa39TGkeR08YVQMyf5+B3Yt056jKnMkd1KsaJk3CimY3J7znMFmBXU9Nj7CQ
	 ECJnKySwaU7hg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1.2 00/11] mm/damon/sysfs: kobject_del() directories that users can create/remove
Date: Thu, 18 Jun 2026 17:30:57 -0700
Message-ID: <20260619003058.8801-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jun 2026 08:15:04 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> 
> This doesn't cause catastrophic issues like kernel panics or memory
> corruptions.  Users can work around by removing all directories first
> (write 0 to the nr_* files) and then create new directories after
> confirming the old directories are gone.  But, this is definitely a bug
> that causes a bad user experience.
> 
> Fix the issues by calling kobject_del() before creating new directories.

Sashiko found no real issue from this patch, or pre-existing ones that better
to be fixed together with this series.  I will drop RFC tag in the next
revision.

I consider this series as hotfixes, and therefore Cc-ed stable@.  But, because
the impact is minor, I will post the next revision after I believe all MM pull
requests for this merge windoow are completed.


Thanks,
SJ
