Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF4E516177
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996806; cv=none; b=WjBvxbx53ABRRpEfkL7vvZKZLgDICbm6hIAv2U1OhdZTtNmiMVxIjSXAcjUzniah6wBYTVGdrGCsH1XmzeEIZ2eMK3wxRZJ6GkRcqB67f+Mjn9by+qS4cWsCeO3RRj2pKtFTkDK0QfIebpdxRaRtTa/3lBVp3Qbk0doc5zQVHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996806; c=relaxed/simple;
	bh=s+AenkYNPapWHsoYvsWQnyLLOmfZeTYk8JfKRBToTk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdOsh7qIYvSyyON4NnmRZFX/xeAIFNtHox1ze71VWcskH4/sWbF/RfbM5ERMdS3hEo5iVNrPE5h4r15bQRwt2snPmFnL9x6lABsZC8d2WAtFUYkdavzxOY7RZ+Mdox3gCcBWhVYvqK0Jm/1RE4MvFgIo4AhNXqTplehCzF5Sjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK1T5h8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK1T5h8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D4A1F000C6;
	Wed, 14 Oct 2026 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996805;
	bh=Nom38KEmoKjlr/+ziXltVJz2b1L1L2NS/lR18v+OoDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jK1T5h8lLI58dWRoVjQT9kE+QXXQzespLEJAqdBpjPRC5rHR5Wt/RrJOvaBkP5UeE
	 7EWpTAKD2EXTcFeXdSEs6TmiPeVRZILRo0armRh9NbOx6v8WtNIVPDkchQroYqOd3Q
	 i4Lt099XdqEYWU2GoyA+JzvN9crUHTk5fCB1K4qkbZEmRkc6zmv+hB2a7QIlok3rND
	 uHKY9DuuRH0VPB/t1vD/jP7RcqiyDQVkRCKS8tlcfxb77uPVMYZfFGB4IZDYLRbT15
	 nLZfExWiS87Hc4sjFKuz+JLlnDHsUoxu29GjEPi2ZNENaZmK4niHO7O7MkM8Wbyz+o
	 oap5FBAC5Vwvw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [STABLE v6.6-v6.1] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 14 Oct 2026 12:53:07 -0400
Message-ID: <2026-10-14-1-daily-reply-0004-tracing-hist-trigger-clock-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014075735.27678-1-lee@kernel.org>
References: <20261014075735.27678-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> hist_register_trigger() puts the trigger on the global named_triggers
> list in cmd_ops->init(), and only then sets the trace clock:

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
