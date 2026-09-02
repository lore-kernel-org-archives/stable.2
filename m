Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F74AE8AB
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387287; cv=none; b=NczLXaHYdzdEgIyM3v4cLQF2dulFqi9Y8OAVVLcN83LRoKh2bsw8NrR95zLyvvVKInQHf6MReyI0vNeGnICpdpPkzlk1IFcev5kDzDh/6wVgP0cxGyfibdW/aEzCtCRlxP7ky8KU4voMZYw+UGnb8BjUU1w4ZvrqtcglMXJCmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387287; c=relaxed/simple;
	bh=OUaVwm7StMaeiK2Up/QV8xgjsWwJhX2iwJHKP9CZv0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+hAFMEVng1N2UtwClHWHxT9F5WClWiA+uSDzjZt2VmBIIPcY44TyhYAg++9rmPU237STbiw7zrIKlhShOfFAS1RV5iwLVEbVOt4B/OwuJuj+vjhceqNzqsMSBKqBEijRFMSiJN958xswwOWN4p8DXv8aVj1HgixQrG/MWIw7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7TXo0xW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7TXo0xW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34141F00AC4;
	Wed,  2 Sep 2026 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387282;
	bh=LEB7Vi/oghFB7X/KT0zj7EG2cwPwJrQm/B6deZx3WIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7TXo0xWQga6ZJNU8TDqmtR70OYTyBuNQLvxCvDAW0ElWo0gZL44vP33wmS96EZCY
	 sA8RBdRa50X46WpQRdaRp2NyGrYBxRJ2yBZEPqGaQebvnAqQ6purRPR7CfGovBPudV
	 PM94z34Ef323O8wvV4WYae1QX2GViJHpRxFuK2DZhTicZIx2PsLGy3+M3ziUkLa9Ro
	 x6Wf42sGOm79ifjtPuj/wztX1m5DUSn/EBsZp94fyS0gmj8PxYFXgGc+LLTmUpjxGN
	 wCtUs1gD5Q18igaTqxcdBd+bP3h4U8UKXTj0OYEDheMWRtgEmbQCjT/IFxnxgRjSh/
	 FhDYdfPsi1wWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	raushan.jhon@gmail.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: Re: [PATCH 6.6.y] trace/probes: Fix memory leak in traceprobe_expand_meta_args() on $arg0 error path
Date: Wed,  2 Sep 2026 18:14:17 -0400
Message-ID: <20260902-daily-reply-0018-traceprobe-arg0-leak-6-6-ack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902094215.1515011-1-wutengda@huaweicloud.com>
References: <20260902094215.1515011-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The backport of upstream commit 00a8ce2a2a9f introduced a memory leak
> for new_argv.
>
> The upstream kernel uses __free(kfree) to automatically release new_argv
> on function exit. However, this stable backport does not include that
> mechanism, so the $arg0 error path incorrectly returns ERR_PTR(-EINVAL)
> without manually freeing new_argv, leading to a memory leak.

This is a stable only fix for 00a8ce2a2a9f ("tracing/probes: Reject $arg0 in
meta argument expansion"), right?

However, it predates the __free(kfree) conversion in this tree, so it needs the
goto-error idiom instead), so it needs a tracing maintainer Ack before landing.
Masami, could you take a look? Matches every other error path in the function.

Note 6.12.y's backport of the same upstream commit has the identical
leak; no patch was submitted for it yet.

-- 
Thanks,
Sasha
