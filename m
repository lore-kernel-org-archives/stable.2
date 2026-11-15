Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773529;
	b=g6aEzqlceQUj25hEjOFhtmfNl0nknNqhGE0jy9RiYkALMxC7Xg7KdC+c0lGsTKbkirpE
	 tqJHb7DU8WuzHxz2qoJ7eER+jGmWFSHQZJvDqMBi0aw3cqwu5W4fxd1Hzi3TmvgRRQFp3
	 Pupw4tMLyXSJ7ue8uHIcqEDMJGQ11IScJquPkVhgku3HfCBi0v8zFkt1rWGOfKYlk0vwE
	 IOykEouCAaOuycTLpx5b4yTP3gvm02M9BnxBt7BGcXQ0k0L0e8/GpxOu3eGnlTYe+qkjn
	 hrbkCsl6sROlc2ourk6I/yJ9cQYZbetiyOaVdyZFzC4N77qiTdTjtIqruAE448OsgPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=2aEhO+zVKZHke9NxJV88UbVjK+gRrdxnplp++L9Xm02HhwQQb7TQaJA6LuI2nt/pFJP1
	 zF5kmHmtWF9AV79OkW79EHam+Ah5ugqaxbyzq9m1AwdcsxBM/cV9U2whl14CuAVkv49Jp
	 WkpqPTwCEV48hFzUvP8pEXUmMcJe2XLJlyEIskNtLopuT9EgkM7w2nt9CAoz3Ljh/+2ll
	 +gBxuOCFXfj4fFQfRXkK8JWY0EuiIYMyPjj4FqEdOI3ha9hw9Unvckqwlb2wxA1L9YAnO
	 f5lOVFwqGV07dQoK5+v6hGBM0ooMkQcXzOmIWeejjAPQmFKsNRLktKL75uON/vHjDNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIHH8p1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28BE606A329;
	Sun, 15 Nov 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIHH8p1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788CA1F000C4;
	Sun, 15 Nov 2026 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794773529;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AIHH8p1QogVxjHGJwTLRB21a8T5cqN8tsaCPYieCcMisJRen7pYjvqLOkUSBq75ee
	 rBzWzixjtJW45eccx0bmSuXIKx3YSwi7XQruv/1uZFIKI8jTKAr14/wxTV34bzbJGt
	 Yd1sYo566BGsHEmplkUh0u/bzKbupMMf5Dj3wlMRT7BgBObNiKdAQL86kSFHf8U/LL
	 NL5DoNMv6x+PoattKJT/vLpPrwvphJQlZgsFCBVmmBY58ZJvTKsOn3MfSMQBWNV2Hv
	 j8Qbz45deGnF0eIzkGHP5gvFxNosdoS9x0MWR3WR5dHGkqNn0MM6WXN2KIyzrJEoIK
	 t1xuagCIsXmpg==
From: netdev-bot+sinfo@kernel.org
To: Hang Nan <2122295973@qq.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] mptcp token hash ordering and token 0 lookups
Date: Sun, 15 Nov 2026 20:12:08 +0000
Message-ID: <179477352802.3291.1988416076108255044@kernel.org>
In-Reply-To: <tencent_CD9EB89144BF9CD313CA1A2F96EC49889B09@qq.com>
References: <tencent_CD9EB89144BF9CD313CA1A2F96EC49889B09@qq.com>
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
