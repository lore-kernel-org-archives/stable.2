Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB7375F88;
	Fri,  9 Oct 2026 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588638; cv=none; b=H1Bnwbhtk/t4ydbY9RI32VSAmMYeGOo3dcNEZhHWL/7bvkPsW1gQGGfTMtl3JCCdOOru4AEB+y2OqpgCYyagfAIFCo4OgY4gP9mtDgi53e2jMnxVxhu4xgTH09zaQjIuq7m5aD57VUDN77t2dgIegMaIZJ2QxtdkVgTpg2dZoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588638; c=relaxed/simple;
	bh=Ui+pJiIf6ODUpwnOUJCAfkOOuZNXRdd+cdULx5GvP3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ajKuz7Ob/xAdQeA497F4tmE5vqp1Y93fhjrIfedY8XSGofrR1JpWWQVSDFX3/QgfJV/ZDQg+VrFMooYaIdV7DuYNzYt5eOgR5C6GN2ruu5ybVvSLPvxGFZjEESXYetSljrE48P7oVQKtw9FadaBUqC9NZU304GDQbHjMIE+L4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsYy+t4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsYy+t4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439A11F000FF;
	Fri,  9 Oct 2026 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791588637;
	bh=eVBpGjj/Jlkd2yrNXwwpugFB3j4a+yN2/7IAtizgYmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FsYy+t4fJofhgiKBJmTYeXAKkqeNEtwZ14KKBAF7ZpaKYS3bMdHEm0WeRoA3sVx6c
	 y/jFA36p7dT978pALW0su9wBGGqNIVQ59zBKkKVd7ddSnAujV4e7vVh4l3LvFE0Z6u
	 1FwP7avgNoP0huMKLsuqG90LcIFbDM1e4k+JwntKLS6GOt8hXlig3UMQsDwgOYbbvW
	 xp4/G9LjSZqs/m1l/fWn9kq7Gj50uIAlhwR2TNm3rAqV0ZWECdi5D8gghTVf+QVd53
	 czzaMACRSPtujhFyLZogqqq/oqqgDrWCF944+a+C+O6V+jKvvWj6xEg9jWlw3TEeY+
	 5xHJypv7zBERg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5E639263A7;
	Fri,  9 Oct 2026 23:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] perf/core: Replace perf_event_header__init_id with
 full
 header init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179158863578.1046271.12901337121214907544.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 23:30:35 +0000
References: <20260929222332.973435-1-irogers@google.com>
In-Reply-To: <20260929222332.973435-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, ast@kernel.org, bpf@vger.kernel.org,
 james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org, peterz@infradead.org, song@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Peter Zijlstra <peterz@infradead.org>:

On Tue, 29 Sep 2026 15:23:32 -0700 you wrote:
> perf_iterate_sb() invokes its callback for each matching perf_event on
> the CPU and task context, passing a shared caller-allocated event
> structure.
> 
> perf_event_header__init_id() mutated header->size in place by adding
> event->id_header_size, requiring sideband output callbacks to save and
> restore header fields across iterations. Three sideband callbacks failed
> to save and restore header.size around perf_event_header__init_id():
> - perf_event_ksymbol_output()
> - perf_event_bpf_output()
> - perf_event_text_poke_output()
> 
> [...]

Here is the summary with links:
  - [v1] perf/core: Replace perf_event_header__init_id with full header init
    https://git.kernel.org/netdev/net/c/b9d1fdc6f4ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


