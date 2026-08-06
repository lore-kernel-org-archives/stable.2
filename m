Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DF346E44;
	Thu,  6 Aug 2026 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785981290; cv=none; b=LMm5Vp5wqiTOwCDlg5EevKQ1gc2nU7Gfdlt/eRCnQi9Pz++C2GiMBmYTtfi+9/e1IK8S+TO+vn6C4U6GcL5J/gibQ90fWOP+6ywwNKoHyHM31Bb7lHztQhMoEQu8NXTDgZk7Gb6CUW1VJlUhf96gXyeCBzcWoeEobursiZ7V7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785981290; c=relaxed/simple;
	bh=o6YgzGCGVSFhKhuacX2i2QbH4BP7nIA205Zs9JwET1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8rYnLjxMAF7vot0IrD4kP5ICz8P6oQkku+nGleKM+x0GBeVfn6m4P2/FPvbd7KtrbZIIDG4EiVqfVu/Hy6QDuw45L7t4mvsC5Zg4TYSrGknyzi8f6kOPGlmnS8oLg1EH9REIV72jOOnX3ltZVWTnqyUrhJDqMrW1T9orpYRuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8E375A2154;
	Thu,  6 Aug 2026 01:54:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id A7B8C17;
	Thu,  6 Aug 2026 01:54:37 +0000 (UTC)
Date: Wed, 5 Aug 2026 21:54:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <mbenes@suse.cz>, <corbet@lwn.net>,
 <jpoimboe@kernel.org>, <shuah@kernel.org>, <jolsa@kernel.org>,
 <mhiramat@kernel.org>, <stable@vger.kernel.org>,
 <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
Message-ID: <20260805215436.2a526204@robin>
In-Reply-To: <20260731175358.3542156-2-andrey.grodzovsky@crowdstrike.com>
References: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
	<20260731175358.3542156-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k45dmnrakf9jctfeqokdbanqdofzwaju
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: A7B8C17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tow9zoAh1q8dj0YrZv4cTa47h6Y5EUC4=
X-HE-Tag: 1785981277-275787
X-HE-Meta: U2FsdGVkX1+yOSemSSbCiSPVOeY5rPw/VDg4KgmkOq5PLv5lYKB1NG02wXDKjLB4lSErp47AJzbnNS1/dTnAQVNSysfZ/aK77U4z6LNFI4o5399sgw6r5ejlN8K+0z1VRXVAaT2qUxlF1xZg/jES3tjuXn8GohMjBcdEu2A/SS/+KYMBQyaoErUM9TYMWNXLjMWJK2wZee6PHuub5duQAVF2bjSdUUIsacM6zg+27C6gn9sOKIj+KVxOBktKxFrq0aPvANHFRKex4bAyyQCmQX3c2e1GVYpdTTDUiXvpN0uFdPIiY+RGjm7kDl+xYb1XrX7sRQSpi5BmphltHsF6qOWKKaoUEZQ494/sdRmIvv3pkV7G9Eez0dCbfstwjTk8tzxtrMMpjHMq0LA8pM25+A==

On Fri, 31 Jul 2026 13:53:57 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

>  
> -static void ftrace_shutdown_sysctl(void)
> +static void __maybe_unused ftrace_shutdown_sysctl(void)
>  {
>  	int command;
>  
> @@ -9377,7 +9377,7 @@ static void ftrace_shutdown_sysctl(void)
>  # define ftrace_shutdown_sysctl()      do { } while (0)
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  
> -static bool is_permanent_ops_registered(void)
> +static bool __maybe_unused is_permanent_ops_registered(void)
>  {
>  	struct ftrace_ops *op;

I agree with Sashiko: https://sashiko.dev/#/patchset/20260731175358.3542156-3-andrey.grodzovsky%40crowdstrike.com

Instead of marking with "__maybe_unused", just delete them. If we need
to revent, the revert will add them back.

-- Steve
