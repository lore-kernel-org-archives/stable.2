Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417376;
	b=5LAqo72cCoKaT6HmIBmYTPmSVBHcItm1CkA9uch/ltiOf+3OmunVM8GO4XA/l2iIabbJ
	 oX43pwYl/4WPRyldmGJHBfhOGqyZGmNSiyG4kPb/Um7Z2rVG3XIrYEfYo3ya1H6yae7NJ
	 yB2OyzgtRpajpRFyW04EVO1prFGqSEbk/UilRqIesEuI5ctrfT6ItQVwT8JpAgk0zZFsf
	 Gg2kLpfkEfq2lgZrRuhItRqBCmolADXNjGiZ85V16f0LNXNa00J74eTBFej3KDUY0ypRV
	 gvX1CL4gxiggMw/0/l/CQmAFUVDpKvTaj+YnoKDUZiOZKG1+zAbGevF3ZbvQ2Pnnd/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=YgC2HShFwv4GH1APkoiVZasEgS8uyNqWAsAhqth8+OlCeVMdlVsrsj+9PaoWeEM22PpJ
	 a0UJoBgJs6+Sd9DQ4sChgmq7JL5XsOVDutrDqryqvKMZlYs5bVWBYn6TNIX1vTjUJBmw/
	 W+7qDKjee31K9AE+5IZFym0Hz58I7BPm2Wv+BvdjsY9wtVhsm9kvrdRHJCsedx6TTvqW7
	 b7YpNeM+aMCwQtmODoTKRsITYpviWew+fkU+YCwESbbXFOLLhO1Z+7XxlbERCxqX6iNGY
	 vkBUdeaW2kvbEyyddrslwZzZM0b0IZB7AnFAgoZe8xBMYpQfDGu3r2EeeyXg40S0mfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kv5hk9LK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA89606A31E;
	Mon, 23 Nov 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kv5hk9LK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEEE1F000CF;
	Mon, 23 Nov 2026 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795417375;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kv5hk9LKzBJNiMoqnIsxIgVY6MpMHRbmpkGBfXD6gEFr2UsnsVxEzgeUfjrxYXv8x
	 m2QG7fM1VyUNGjNnIRWGNVx2W+Rc6e/q+N+g5XsLmODUgXU2ALwX9c5N+moM24PzG+
	 gThR+vQo++yHx2DGaJyOC93jl2tAabvypUUymJHl5/guf2lWlR/P7uSKaUTrC+eOxp
	 OIF4HqsYrdQ7FCkAAHBENaXZELQQAJaPbf33aGPAwxX0WyAX51F0kk8KIZn8nik2/i
	 aOPiAE53r96NKdZM6BorAMhmWuHclEBjmyFBRUsIMj6byDF6WpsK0T6uPpTB8jII7y
	 yexaPa2UTXx9A==
From: netdev-bot+sinfo@kernel.org
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Hangbin Liu <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ipv4: ip_output: fix use-after-free in ip_mc_output()
Date: Mon, 23 Nov 2026 07:02:54 +0000
Message-ID: <179541737468.3294.17944229505466733444@kernel.org>
In-Reply-To: <20261123133000.3.n0ps1edzz@gmail.com>
References: <20261123133000.3.n0ps1edzz@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
