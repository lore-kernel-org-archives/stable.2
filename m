Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E063A2544
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045550; cv=pass; b=Im1fUFEZmgBFnVZvkBxHwrO7LXnRPujy/xELoi5wFRMfIjUzMqX2kxiNWdl45m5mXl4RqdDURCYzig8MzuGHHjvMmtX8dLtVyUh5FzQ0XGuQbCbCX6/RLqBZnKvWzoghFFFY7qBv3Y+iB8MQULAIN4HDBAfNu51YQYaewcEjkEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045550; c=relaxed/simple;
	bh=vZgcNyGoD2xypSKwXw/Ad5tVtETNlWG6kTClMXEsd4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdX8xODJ/9fkkkmrYrfiHMjcczgepaNXtshvGXrDWdqjkZiEMuzK2dbbiPSE0YSNHas+yGgJV9HlbeaHEnqjfT1FiHwCwLuEhzUKZECng7T+0s3VxJ4Dm/Wpb/0TUBfnruqgD0fah445MnZMh1tbyIXDYvNMV4wyrm7iaopjIJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfeXEc5U; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfeXEc5U"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8d881so3785999d50.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790045548; cv=none;
        d=google.com; s=arc-20260327;
        b=IdzjA0ytof5BLZ0RLD8vpODfgnkGZbnQ/klRcTGocbRtz/Y+w1iztVJZC5iHgtF359
         gdWJvriNeNHsbzJYGi5WJcunYHgU15cYF5EC5H4xAr8OrleX5wAuK8dxexBxCV7nLjVl
         D16T1udfpJOqcJ4pf9/abEnlqDI+u2cEE9LyzhDGSQNidq1QirbUhGeW7p6XwxlLJSiK
         qFebofWWljKEKcnN6O4k3dxv9fu6N/IONMhHOUcsFDM3Z6fdBlUMMfPb5jQtp7jKZ4cb
         7iDs6Y21wr3SjgFFnxppy+ZIe4O2VQpOIqG7BFYTU+c/m/nAwST1dYJ0OyBDVcSeczQD
         ZwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ghvfyjQSQHrPZknarysRzqoTzq1YP3d2PY2Mg+SWx4E=;
        fh=hISP3wu3L/aInTLLORGcC3G3eW7KsynzaEWNRG+kE3s=;
        b=ZvRl/hDX0ywQeXFQ0XSuwGluZm5N0XcaSuN30Um9IzTI48luNOnBpnwXn9dLMqAY20
         xhrcguZ4CIx/wR+AM60+XBM3AXiVJcQoH9D8Nivl/wdkOjepsMxU82t+8R1/DPVOi151
         UKfNmKlSy3ureVsT9QvI2fHP2xyWjQ7CiEC4cdTuy9ezhljHolGQBy/vQCWWzNYFq/2N
         CayrMvwJIU1apCvx4faYHfzuh6XzHBYVJVh7EdPdmCK/ZdCJA94znciID+Moc3Iq+I53
         P9tFW3VzxSaEswInhaLuqrYbMk8K7FgtlGYrR1aGKNIwh4R3rvxmKxpUsRKTMeCAHSd6
         OBtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045548; x=1790650348; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghvfyjQSQHrPZknarysRzqoTzq1YP3d2PY2Mg+SWx4E=;
        b=UfeXEc5UOrPqn+cOPfea66JiPCJSV0pIfXRJqG1p/DeqJW+6Yjr8Z29i4Ce4gX3YZa
         WRyb3O8R3jprr1nJXYMrQiK+RM0RNj7YVcKk6yU5no34XQ/rk/MFuqGQgFwTGt6M4VQM
         U7gDEqwAUUKFgUa3Vujp5trCzbSEfGpmGvWVGQDrQX+i3hXj0MFk9xqNIBBIZzAXHKMU
         lP9hFF1Up9lcRq4oTL2QWufe5XM1SK2tJHBntx7uNDQpF1eAnpuVC9uGQW5w0Gw95VYm
         1wPJhhq/OtrBHEsWwPVD/4bYA0RAxOBTLkFedhR5AtzARXk0JairK+PEOlO7KYT+hh/v
         dOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045548; x=1790650348;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ghvfyjQSQHrPZknarysRzqoTzq1YP3d2PY2Mg+SWx4E=;
        b=gzQL6Nu3vZqanDwrz2BMVMSIEkHNhuNtqzPSwzWYaRjYT98xQopUnbj9rURyYTjVHu
         u1upmJJKp1og3aB9oEsbk7FBWaSo4Y522bBRJRRZ28FXm1y/5wY7R1eI5S8t2jkeVS+C
         xDFxJWatqDJvd67TCG2CyPxm84BOo9rLweCxcpG05MxffsfnpPZomzISEuKZhdvR0BqX
         FUJNgCqbb/8c73JM7dLUkAbKedhuGMPvKVrFsbs63H01q0yP956MImJ7WwB5V9EQxsXe
         Y2Or70250/CSU1I/eL0YdaOElVy2obqVESi9FxIubsWpB0puirtMJs5yD05CuIjVghzx
         A+EQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoRMX9jHZa3NI+jqHA+essCq/bjpxfOC80e6iROxXuv9S99UujxmNj/QY8ptvJXDFxFROzSwg=@vger.kernel.org
X-Gm-Message-State: AFuF++lDKCjBaJCtnlOivxYyVEnDp3309PDQu2v46kCtVtOYecyLtl2M
	Mt0NXEWxCnrY/jCTb8EcyxTjUOvYQVINCqQMWv9mmJfopJPzNpJey2K8rJbBJvKoauv/COBOEgK
	T8Wc1xLq027KcMEDSJVh6GRnqV0rCNBrKVOl3D73eyiKO
X-Gm-Gg: AYBFou3knKKK/sgh9WGNNaT0gzjHGM7OOmhPxvu/BUUlfOb5rgMjj6Hk1X6mE5kmWlr
	+X7PcyaY1bVJyhnlwB8Oy00xGV3j8AePmILlP7ZYcf9HyH5g7WYTFBzN/8a5oGRA6NSM3UCUsLB
	3PwCYyQ8si21NoqGm/qW6tEXre9zlHzqOMGZKARQb+8vrnki33rfCvVJumnrQaOBSM+fzncnU4y
	xfzik8vNJ8Uc41hTxvg2ICNW8DUfThjr17sLDyDmb3UjhMvA7agrs71uMwlFycltBv8j8Vi1r8Q
	tqJnjyYPtKkomz9gRoxh/W21gTD97AKaqEdG+UZh+u9Gmn2+XuhPyDU5Cw==
X-Received: by 2002:a05:690e:138b:b0:66f:c1bc:4034 with SMTP id
 956f58d0204a3-6717fe5cb92mr4558256d50.97.1790045548157; Mon, 21 Sep 2026
 19:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918041321.3532355-1-lgs201920130244@gmail.com> <arFJzYqY_mdeXr4C@quoll>
In-Reply-To: <arFJzYqY_mdeXr4C@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:52:15 +0800
X-Gm-Features: AcwNN1WF2Sc4tKp3txE3ezqyAtiFFXx1O5SoObsCwLYSaLQtB5TSAaZylyQ3I6U
Message-ID: <CANUHTR8c+kVfVWttETsVZtWSaBS6LAEGuipWYNUiHw7==LLfzQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom: q6v5-wcss: remove all subdevices on unbind
To: krzk@kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Sivaprakash Murugesan <sivaprak@codeaurora.org>, 
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Govind Singh <govinds@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:14, <krzk@kernel.org> wrote:
>
>
> On Fri, 18 Sep 2026 12:13:21 +0800, Guangshuo Li wrote:
> > q6v5_wcss_probe() registers GLINK, PDM and SSR remoteproc subdevices,
> > and may also register a sysmon subdevice. The probe failure path
> > removes all of these subdevices, but q6v5_wcss_remove() only removes
> > the PDM subdevice.
> >
> > As a result, GLINK, SSR and sysmon resources and registrations can
> > remain after the WCSS driver is removed.
> >
> > Call rproc_del() before tearing down the Qualcomm-specific resources,
> > matching the teardown order used by the other Qualcomm Q6 remoteproc
> > drivers, and remove the GLINK, sysmon and SSR subdevices together with
> > the existing PDM cleanup.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 8a226e2c71bb ("remoteproc: wcss: add support for rpmsg communication")
> > Fixes: 0af65b9b915e ("remoteproc: qcom: wcss: Add non pas wcss Q6 support for QCS404")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_wcss.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
