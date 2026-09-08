Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170B24E016;
	Tue,  8 Sep 2026 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828859; cv=none; b=SrbOFUx3Oi+s1p0ODdhGs+ly1pt0Qrgw1lxSWjW24MdZyEq9roabT6KlbXt4A+wnVsQ9nqv8fFLejhmt1QFJTznTNTZOVRBZ7f6U9QEB/zg/cxN7yGq8Z9cHcBioZSvXpBAS4cw+LskYXiP9KKiSfspuBSZsrOHQ3LIyaY7nkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828859; c=relaxed/simple;
	bh=VUShDA11Nake07X5ReJtXjyUbieegnvAXADMld5KLvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIWLuoQtrBNy5MbkK21GNmd16HQebxEwPmjRqhqcUQwqWrR5GaKMRoQOGMTImM73PMtRj/VH7NosTmuNEHS9SWywxkZKIF0u8LXoL9gSWfQ9klA3MkxyTqIA3Tdbp+W54yylK2YHEXdLvth4Yf2548y+e8vsd46TgW8iqXIrJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjjwUfbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjjwUfbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C6C1F00A3A;
	Tue,  8 Sep 2026 00:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828858;
	bh=AwDmsTrdUw+Fx9DNwMcQPXux5h279n3YeANU6mgzsZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjjwUfbeS8fLm7w9JN2lgT+C2+EvDhYH7cawcYqPauoRA4Z3azuo1mbtx/dX9kDey
	 eT+flhBxZ01x2Gfk4R389kZ73+83TtbCd3wRuAxqSwP9nnl8/l7zxsV20xhPepWQxd
	 acVjfzejqKYJDp9aGrA+S+BJmQgdEvANqz0u3nqCq5u5bwNRpYOJtAamJmArUdqb0P
	 sy95/qIQ0q/mnnyqILHyJELWh7y/ZzAPMB+e8wTSG/NlVBDbUyNJV3fqLZLfUQNeF7
	 tORSlPOrCfVbw+U48q26W/DHsLCpidgQcSKAWAMocKHKE+/4YAHyXX1tS4a7YWIMC/
	 n30pag4iqQo7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	alexevgmart@gmail.com,
	karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de
Subject: Re: [PATCH v2 5.10 0/2] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Mon,  7 Sep 2026 20:53:52 -0400
Message-ID: <2026-09-07-daily-reply-0013-mmiotrace-v2-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907150726.168416-1-alexevgmart@gmail.com>
References: <20260907150726.168416-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Masami Hiramatsu (Google) (1):
>   tracing/mmiotrace: Add NULL check for mmio_trace_array in logging
>     functions
>
> Steven Rostedt (1):
>   tracing/mmiotrace: Remove reference to unused per CPU data pointer

Queued for 5.10, thanks. Good catch adding the prerequisite.

-- 
Thanks,
Sasha
