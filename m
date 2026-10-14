Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B3560ADF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996808; cv=none; b=rKiaViZ4XnVyu1GFzCyIHeG2zb4cydUeR0yUjl4ll2wqYW8kUTyaPbDYj+PUSEhSNG7ovjuLXIUJmQxnIju1H0maEEMLbCRdHuVtKVjwGs1++udLAL8cIpBSTeyOMJRYSJ/4RaCNGMdv9wCyiJz4K4z9N7Qfd+oVy6PrIaFWUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996808; c=relaxed/simple;
	bh=63oaWW9EHJpilP43zT98quXNdCeZp2jtw2EeHEzonSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVIJolbg+F1cSJbNR3mb9Y1FLoJs+csM734PlYiXuDrpdTheT/Y9Ry9Y59hHbRoCOmVlBQHk8pokbH1Xwp/84Eo7HgtKW1PmfyK9eH+r5qTXZbx059H4I/j6VaMKD9ziM6E78ddYNeXZp2A7ZOC+ZaV6fmssBU2DpbZRzymbnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2fB1c98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2fB1c98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124B91F000C7;
	Wed, 14 Oct 2026 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996806;
	bh=92QcDoWeu46u6o3zyZjVJHKNgIlO3w1mNiBZCAAVrFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2fB1c98oAkcRPnifd7IoLOXm5TstdL4DzoKGIkJfGat+8LrjHKgElCwqmvSS3HHz
	 iLgpOE+j+wxn5w08MLUewL9/2YxapUvUO77XAgAUONTa2wbjp4xXJ8rwuLYJaGyh3E
	 LOql0ZqcavGUnlRb0P8DNvXrxLHvnOcgdYfklVZdakpM00dPg3o4xZq6/vCd8MuOhY
	 w+ZAV6o+qR3rhbdxO0HtAhrkv+IarVnfeXENRRjAXjK9kk6DjkuQ+TfFTRceM4/gB5
	 tA6B/I9oOpC/sHchC91N51h8GD1BPpbZ9WOcE+e0k6mKMw5fezSVpAD19VjwcnUbcO
	 IkBM4hjN4bSVg==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [STABLE v5.15] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 14 Oct 2026 12:53:08 -0400
Message-ID: <2026-10-14-1-daily-reply-0005-tracing-hist-trigger-clock-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014075806.28597-1-lee@kernel.org>
References: <20261014075806.28597-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> hist_register_trigger() puts the trigger on the global named_triggers
> list in cmd_ops->init(), and only then sets the trace clock:

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
