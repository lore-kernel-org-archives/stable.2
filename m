Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27803BB69D;
	Sun, 27 Sep 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497858; cv=none; b=W8NW6V830G+BFs3DSAWRLqnFd71aaUIStQeiRUou/CP4PBkBWcLFqo4uDXqBcWxhfb6yN/osMdfG+eqUweUgT01jLEQx1e0jztGsZlU1MAiZj/cmyjP/CcgoHiky7bRCRyaP4q2wCHmGr8jv3fc4Qu9gCfFBnoj2g/lwFUkNCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497858; c=relaxed/simple;
	bh=ZIIWhWtXgK2vRTc9yqj9mZOd+EC5bbVuW130IRoAZok=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Ghf0xiK8ldcLs2cbM2RK7lAh3ZJD+iOLksiEOmSW+nDg6g1spYT59dcOUjLYVOb5AyxrYBxGe9G0zNXL3bqOi4pC1qlexnYBlcGvtfmMhKNHSX3GNH4J3LXmJo7Qq4GbgOdW2aZDygHMKnB0+fRxvN7419aFLXyCTNbOkWl+83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcS8IOx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcS8IOx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA361F000FF;
	Sun, 27 Sep 2026 08:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790497847;
	bh=MewKg+UfOgWhxI1k4meQ2yNRCVFKSIE/+JvCf/+QUmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TcS8IOx2FyBYMmrefAXyVv1l0tb6HWLOOx7BTWoXXkKNl/lfQfbPVNjEy1BhZVUGX
	 nkp/ZXnKkOUCJNBPR45kMqliXXMf4lWmxO82ZyTO0xHj1ZkZOgL46fElbCfDu0wLpl
	 pzzh3diGU5HopM22IpASnXyZbk5dBltSPVH5Q8Afl1vOILB1uQ9voF5DnMBplOrJ/C
	 1+kr7PfZCkHkqQ2YfwFlDou5oSgfcRD+Oo9pfaJCVZHOVnvOiwbdZvfzzQJTYHq8wR
	 oJjOyn+AU5i09byCsMi6gJHzq1Pv8JvmJrJTVhdBZ+Y+kuHZbAO57DbmwE2UXtLg4U
	 ZkDUoP2zqWoRA==
Date: Sat, 26 Sep 2026 22:30:46 -1000
Message-ID: <42a21c8fdeb903d8511a279b5cf2e242@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix NULL current_pwq deref in flush dependency
 check
In-Reply-To: <20260925-wq_flush_dep_fix-v1-1-fc5a9de31828@oss.qualcomm.com>
References: <20260925-wq_flush_dep_fix-v1-1-fc5a9de31828@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Applied to wq/for-7.3-fixes.

- is_chained_work() has the same problem. It dereferences
  worker->current_pwq after checking only worker. It is only reached when
  queueing on a draining or destroying workqueue, but a kworker outside a
  work item would crash there the same way. Can you send a fix for that
  one too?

Thanks.

--
tejun
