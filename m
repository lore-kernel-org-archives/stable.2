Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601302;
	b=Zd6rZSsm+3fba74pD+6K/cbC6n/zucpk2XmYr4crFKkYZVamOEld4eEzzhI7BHplvYAS
	 Va6LyHu7smhPAGhUiwdhghW4qY8kyNDzLI0GzPuSPA5uxnf1AhbXZsSmY4b+IVicHph6I
	 q8mqUt9GSh4SFVUa7ZmSwmYMoSEMkP16q4qVQJvd5Js2TSKXkXzEV+xHUuWfaJEV9lxoQ
	 P/PQdx4yN+9LdN0rKySavVPp+d/+XHCsV9mGXEsgjY4TOVDxxf7l5DKb31uZF/oMI1f2E
	 p9OMOHxZ037geSJ6LWyo6hdrZ/RDOkwGW7lyw2s5Ewg0XcJ7VLYafwKR9HK4N9wHj8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601302;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aydJvltvgwAbxuxnxINjaSf/do57izbi73hyUbqtko0=;
	b=SHSYhYm/n3O90DhJjUqMHTRBGEZwzl/SgkxWb17vpPyQFMDOZXAvoaWBXinwqaFIU3BR
	 LFXcWiYmpFqMqsIM1SZ54AxHsUOvPVmTt2MIQjXJ2ggpdnehCwS5R8CvIHukQSqdluwDZ
	 uqWrKetQ/92ly4KfloSnKbRXcNoyeLSGEgrqb5nVfbks+4S/WoIlFCUS4TwKHpZtsvE4q
	 +U61JrkWtkdo5JpVVytN/yADrX/RhP77HKWiYgvcI8urCSD7j9L9izfQ2kXgFIU+m1IPr
	 hQMVFVjglpLrBHFgBocGb6B1acG7jhBOvhzbXSueQvUZlJi1FYqWXBI8UnJJB3nvDGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h0Q5GTw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDF606A324;
	Mon,  2 Nov 2026 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0Q5GTw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CB91F000C1;
	Mon,  2 Nov 2026 06:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793601301;
	bh=aydJvltvgwAbxuxnxINjaSf/do57izbi73hyUbqtko0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h0Q5GTw/HsWkR44XD9XHc2+Ku9Q+bKGfcfqvxW6VnnfueRA+ndZtHcX0gDMOEOmUU
	 oi6AmRmw/+2PqB674XNSO2AO8CHYeCTo+xTzZbLTK6Zex85K3RRGtbQbtfiTB9jI/J
	 HaQsebH14pqEpBz97PfRMp/JswB4JzR5k6xTDO4A1c2hCmY8W2kzTX+X1xqYRJpaBl
	 fmdJ6BBh+LwcmihUbTM/IF4+1weNnyFnG8R4f8xzS5xkFfWx4d7P/3kA0siDKiQ3/5
	 rldBcjhk8Me9X0S/EEusifvwRIUXqCJf8Wthj0UavMycWIYnaSBoMdI5pGt8BrSjJu
	 ZUlferJfzrv8g==
Date: Sun, 01 Nov 2026 20:35:00 -1000
Message-ID: <338926f2bb6eca65ef5b3508b000edb2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when the donor changes during dispatch
In-Reply-To: <20261031162803.541236-1-tj@kernel.org>
References: <20261031162803.541236-1-tj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes with the following tag added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Let's consider ops.cpu_acquire() and ops.cpu_release() fully deprecated.
They never worked completely and won't. Their usage should be removed
from the schedulers in the scx repo.

Thanks.

--
tejun
