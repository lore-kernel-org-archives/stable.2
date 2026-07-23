Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244821883E;
	Thu, 23 Jul 2026 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767002; cv=none; b=rkJAmvIm62G+1eAfW0r3BAsqipUzl3K2CTCxryNq4zTSSLoyV7S3soNg1XqULGWVwb2S3AP2BejiK11+FvRfkC5iwVjTLNcpN+K5NIp5jHjYuGV9YNrsrPRtj4S/vPWglFO0q18nUez7kPG8Aywp8qZQAdyO3OkM9yh+W7uyMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767002; c=relaxed/simple;
	bh=2Bv3svHGu6TJLhCiQRhXkMiJ3PT3WF51LHCru/WTxA4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OJNS26WzVE5aUfIoFcDHlw3WcVTvC4t35QJqP4J9ghyJ9UN+IXbkvlkSbx3+cuXcrRguBtlYs5/+4HlQ154a4RVCn3HRlvjZwttfJZBVuHXtHPR1hDJf4cJ5yk9UNd0SjL1zUWI9hupkWc+kyPI7PjADRd8IgHna2IZIziZOtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I1rExJ7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I1rExJ7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168AA1F000E9;
	Thu, 23 Jul 2026 00:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784767000;
	bh=8fHddoiy2ssGES1+pkTKa3f6U/9rZANITkdG9dYpmkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I1rExJ7HbucjG8Nn1+3y6cPgEqcv0oeMs54cOuvhn1mFD3lhLjY4JHzpWproZDE9g
	 3v/GM6QlOwfpWIyAPWR46bGgxgNP0+Q4Da3I2NVtdmcJPsSwfvX5SbyX0g6Y/bYVZO
	 g5ghIaYOOe3OhWBMxnJkY100QK2m+8yxOBG6LgE4=
Date: Wed, 22 Jul 2026 17:36:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Link Lin <linkl@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, David Hildenbrand <david@kernel.org>,
 virtualization@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com,
 duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, Ammar
 Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
 ahwilkins@google.com, Greg Thelen <gthelen@google.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, jthoughton@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix
 UAF during suspend
Message-Id: <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
In-Reply-To: <20260721005603.1710551-1-linkl@google.com>
References: <20260721005603.1710551-1-linkl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 00:55:33 +0000 Link Lin <linkl@google.com> wrote:

> During PM freeze (e.g. S3 suspend or S4 hibernation), device drivers like
> virtio_balloon reset their underlying virtio devices and delete their
> virtqueues via vdev->config->del_vqs().
> 
> ...
> 
> Fix this by switching page reporting work to system_freezable_wq.
>
> ...
>

Thanks.

> Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")

hm, now where did that come from.  I can find no such commit and that's
the second time this very unusual thing has happened in 30 minutes!  I
wonder what's going on.

I'll use

	36e66c554b5c ("mm: introduce Reported pages")

OK?

> Cc: stable@vger.kernel.org

The bug is very old so I won't fast-track this fix into 7.2-rcX.

AI review pointed at a possible pre-existing use-after-free issue,
related to virtio-balloon.  But I think this is a rephrasing of the
issue it flagged against your v2 patch.

	https://sashiko.dev/#/patchset/20260721005603.1710551-1-linkl@google.com


