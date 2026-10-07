Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8837DEA8;
	Wed,  7 Oct 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407036; cv=none; b=RwsEp3TsjnP+1CHH+dEeqbrsvsYQyLQqDH2l0Y15LCIuGZmg1RkjxXwXeSib0RcKj6EhKfoBnIAEOwfPP8dJ/27RHSDAsHCRumAClhe/FGkdn6jH8jdnDUKn/lBpTS8DefGZPMXjkSdlxbb8WDAsFSu3YRtfHmmL2RZHGLzzdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407036; c=relaxed/simple;
	bh=hiG7JMcfsmrDQAufEZqWdVvBWMwi4D3oC5bAwWo2wqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmXh7sukQ9KwQJBvDUrHhmUwjdqVgQ1FHroFLSEJgpmQC1e0x7v5uLafMESKkvseZkEsn0wxmVkt6nBZwbBHhwWFIFF/Oh8txAfrQclXyya7smUmJf7VpnhLwiq+BQK8mWQXvX1Y8rGtMlQyrQ7c0NcivalO4g9KbHR7KPggpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9TNtKQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9TNtKQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0AB1F000FF;
	Wed,  7 Oct 2026 21:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407035;
	bh=/NBzTZle5cvDoG9QXTF7NtZzT36vzTXVxjfu3Tkt6JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n9TNtKQsmSMR4sPqxarJGtC/DHbQkPqLARd99pnuSETp4P7gzayQORY0A1fRvF2xF
	 1VomUXvUqo3SJwo30ttK7BIq1uEaP+1DgAlR7tuS4eBWKCoc76WLyHsj/gzL7diqId
	 vXZMmRh2gPwXf0KC9aUZMpIxQv74zOdNSfe1EhIXzV8j8yeZbOBYVzYZ/rYBrE+iGl
	 muojoJsT4JCgrNvH7R4ngPXOmbdtlKKIM6dti0P4JFxItcoBZ5yJmNJOBaOJSiJYXl
	 rxnLAvEF49fiH8DjNUpq7FgnK3g/y7y+Y/o3s0wVH7ZRv6JF2186u/fGVDAgV+ShwH
	 KTfLGzN/4/7VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6.12 0/2] Forbid truncate of fsverity files on btrfs
Date: Wed,  7 Oct 2026 17:03:23 -0400
Message-ID: <2026-10-07-1-daily-reply-0006-fsverity-truncate-btrfs-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006213725.47114-1-ebiggers@kernel.org>
References: <20261006213725.47114-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport the fix to forbid truncate(2) of fsverity files on btrfs (and
> also the fix for that fix).

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
