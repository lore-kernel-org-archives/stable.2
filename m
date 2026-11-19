Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061860;
	b=rb0rllSqWJt1S9foo7NpAsygga7LwRGt8wm/9DU2fSTKcia4x4Xic7oK71n9OI5ZmHY4
	 5LBjBfglh95Es60eSCiqHNz/NG1x90+bXGFU1mwnvKQGfzxAo7c3ET/E1heqb2sBBjLLa
	 Z1U66SxDUJNnWVZqinE10gO5SP7RCuBhDxz8Boe0MyEQ97iedk6m6SU7fSofDBHv9NF6F
	 e1FpcL0CtRML8eDfz617LEXsvF7bh6N9q3BXXUGCIhgL60ZcMyhISq4ILk7ZQbhycV/PL
	 TaTKrapQbR8Z0HGnimxkdQm+lvjbZyjnkYCkww5OlK/1Py2c6kf/IKCDgzeU5IkQCwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061860;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=YnIs1WTGLn/zqP+lzPBx/qPQEVGx/mUbkzanTiDXB9QbEVDZJip2qs4HrF088tkXCr4Y
	 NuziQgq2IPjn26GGLlj3lWXjcmXH821t3Y/pySueGZGqqCQqyjD8JGR2vG1QYz/kSeo2K
	 KaGI4ujPvzC5YFWH5UKkxRNuXfTnwpQJZ5caItBCVG+1tuw+SoAeB8V+cgL1FxPByJPib
	 V1KwXumZpPElJUTZr3bLD4TYwWFa8cnWFwnd7vuyjgpg67c4sOxI4I3B+qSX2EqwEH1NJ
	 KZKIe9LcYgOX9npuGt56usHyanSpax+i7k+tpbQZQ0/kERNje1f84EAyE/gw9y697ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNgbNd0Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A9606A320;
	Thu, 19 Nov 2026 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNgbNd0Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432981F000C4;
	Thu, 19 Nov 2026 04:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795061860;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jNgbNd0YQPkspDTpsmKqjbtXP6WUKvcew6n//NzCI0Sn+/qhwvsjF5UOL4QSzqbRc
	 0EcSOewIZ93hjObsyG7SiUXGyFqQZci6jlPLLYSeJeDwP8vFmcgSCa+gTP3clXqd4w
	 QKplFFeHrFXXCwrvTR10QXIFa9NO1U3noia4rxTo/UnTEu5V4w8QUj/I/egkyUtlKF
	 8zOZgzL9ytdqSv8lBaeY5/0JiI0r6hKNp9VFJpdKmIzxDSzOc6RbNKKHVLKvBPxk99
	 LNl6ma0nGK1uB90F9Nl1cD29IZOJtE8EODIwbXki/rKjm3CLB4uMdzagli4nl9xYtx
	 iyqwFdYE6hgFw==
From: netdev-bot+sinfo@kernel.org
To: Wentao Guan <guanwentao@uniontech.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 imv4bel@gmail.com, martin.lau@linux.dev, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] inet: reject unhashed sockets during timewait purge
Date: Thu, 19 Nov 2026 04:17:39 +0000
Message-ID: <179506185983.3291.13664137983591286352@kernel.org>
In-Reply-To:
 <1595ACC3A3D11BB8+20261119041113.3514099-2-guanwentao@uniontech.com>
References:
 <1595ACC3A3D11BB8+20261119041113.3514099-2-guanwentao@uniontech.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
