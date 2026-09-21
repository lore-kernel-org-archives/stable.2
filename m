Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3412F691D;
	Mon, 21 Sep 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003667; cv=none; b=ZvZ0qhAf2ADOMtWkNiPz1OrWdYwpx8ghe6gALnq86g84CURPs/z+HvvxBafKg5q1wY2UkBwDeP8sggELnCZb2+m/YMLQGke+OIXd+uzqGBXmvTQJrLkuAsf07fO+E8i1E2YhMrg8qaGP21S5jjh1Q6mREscwM9BDtz9WZaXJvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003667; c=relaxed/simple;
	bh=IhIlpoErO6zQPf/LHi+a0obCzyy2h1v1zl7z4bCoLf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrbbrPLPiktY5b7lKDXULAtkN3qN0/yOzt1Nqu5ZtRmrWPRC1vx8ulzgZ6ZRu5TOe+elzYw1WqWFF30ZLZtP9z4BY+LJRH0BTt4Vqz7epe+51mh7sEIuuZD4zI+y9fkU7Qiuk2l/VEtNXOk+rrE28Y7mZDDEXhjhQv15s7b0xC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfhoR/R/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfhoR/R/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DE91F000FF;
	Mon, 21 Sep 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003666;
	bh=tpIxZoFZLYvOpLCQ29sIhaJI+A6RdgDAKvdZa2DVaz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MfhoR/R/hLOP+JdkTPUvUbHpVbLShFnzEFRgffUkmroOdU31tNw8XSxqxD+cAPp2C
	 bfzOXyOrnzLD7/Q4+I451qqTrJghuWBmXD4dVeo7Xu8U7KeFZLPfFkUYElqI2ee+YM
	 otYDb6Mr6J7GkPleY9BrNmMfvxExfc4Xl7jgA6n/pAoVSBih+Jd5exuAPMcY/N8gZn
	 8X470xxASVjXT7wu+hp1/R4ZkPOYglNKSEyH15m48gEb/mm0esqQW/pzMPRNkWKUaR
	 tA3a78wkHcVsSmM4pStBoFHKS1d0MiEDMDZ67cz7AYCIf6K3LLNzuWXFGxjaP7Z+8l
	 L2VFm9WeQ/Xzg==
Date: Mon, 21 Sep 2026 17:14:21 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Sivaprakash Murugesan <sivaprak@codeaurora.org>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Govind Singh <govinds@codeaurora.org>
Subject: Re: [PATCH] remoteproc: qcom: q6v5-wcss: remove all subdevices on
 unbind
Message-ID: <arFJzYqY_mdeXr4C@quoll>
References: <20260918041321.3532355-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918041321.3532355-1-lgs201920130244@gmail.com>


On Fri, 18 Sep 2026 12:13:21 +0800, Guangshuo Li wrote:
> q6v5_wcss_probe() registers GLINK, PDM and SSR remoteproc subdevices,
> and may also register a sysmon subdevice. The probe failure path
> removes all of these subdevices, but q6v5_wcss_remove() only removes
> the PDM subdevice.
> 
> As a result, GLINK, SSR and sysmon resources and registrations can
> remain after the WCSS driver is removed.
> 
> Call rproc_del() before tearing down the Qualcomm-specific resources,
> matching the teardown order used by the other Qualcomm Q6 remoteproc
> drivers, and remove the GLINK, sysmon and SSR subdevices together with
> the existing PDM cleanup.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 8a226e2c71bb ("remoteproc: wcss: add support for rpmsg communication")
> Fixes: 0af65b9b915e ("remoteproc: qcom: wcss: Add non pas wcss Q6 support for QCS404")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/remoteproc/qcom_q6v5_wcss.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



