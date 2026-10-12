Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06837A831;
	Mon, 12 Oct 2026 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830906; cv=none; b=NBxIMKl4qNvpFuMhM3hmmcwnzpypxzFmQykXnEvYZhESSCPpI32OA0Zn8P5vq9cTG9qXSt0DDwBSc4LYLb5NWFjsoOOJDB+7EKs1TNqJXq6Ns+eBlmmKIKottzQ5lXDKM+cWec1EkAplmEwE73+Vb6Zlf8Ax9Yk62+jor962Zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830906; c=relaxed/simple;
	bh=ODqSbBmwpflLPufAW07M5IGv83a8BM9oMbBA55UTjko=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fm58AjsFYIDv58WAhg+TyoovgEBrlj0huRkUQNI+JIbjwszdZS3ZG+XGLjeRMHHuXi+mOIk5H7vccUGQDx1QIbKQKkQaOV4+OAXaDK2Jl4wxp+EPIxZlgpdzNDXNL/6PwdwqwgOhfpFXtoXTrGIAYiCwK49ExibrdL/+2u+ilQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6UKQwg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6UKQwg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE3F1F008A1;
	Mon, 12 Oct 2026 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830905;
	bh=NlXNCgfjp00Wqm33N2mGBM2JARc89OfWL98Zhs/TWsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e6UKQwg7Hm3KU0PPnErQXNUDZQz/9hC7uGq9TcgZ6V+ub1Vc8rQJMR5HB3QVMobJn
	 72eUsGvHUEKXtCs9p13QoxBG2TQ676uTCYFBVsY+p+Vfzl2zDv9vmGZ+9bQ0Dc9380
	 MIIbKYF04aVppGQjq5SPsP1+Wi0GJAxWUEwWiFcPF6M57yUyv15x3vKFezmdjlRFns
	 ZduiksBd3D3GBwnklZah3raT1RjMJPprQ6fx761v3VHrBmY+9YKqoK71DwFILlB6Ph
	 x1U43OaYXDVELlmJu0z7i3eDO2JjSFNUOueQpLFBV+tf6xIxXkvbrz4RLW5VwJSnwG
	 2nHWWEAKt7sOA==
Date: Mon, 12 Oct 2026 08:48:24 -1000
Message-ID: <d1b3d305ae23badca6eea5d7497db31c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: idle: Respect task affinity in restricted CPU selection
In-Reply-To: <20261011173100.2090211-1-sh_def@163.com>
References: <20261011173100.2090211-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.3-fixes with the following tag added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
