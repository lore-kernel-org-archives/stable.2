Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700936;
	b=X878AaVc/Nzdd6mr5afcy/POIrqUXr1E8QkIGrfWQf0VC+IK4beepTJ2gZ6KbuaGSc2X
	 tsAitVHqq8jRwBcBEgFoyndi9emUcjGf3nnKCRkvFBoTPaifSbtAUbhJ0IYY6mB3KltWw
	 oIZf0k1dUD1uiSecITcv4fT3H7TaTPhZQDWP7/D+PHujXir1I6rwG11KNtY+U6aA+orFV
	 BvDxzXjgfSg8wsFXtVv35C5VE5Y+i5XmQlpvxSEWO7ndE7qP9pTgpL7uvFzUImAXw2jNz
	 IJ98GncZRLUsjqoeh6/f0wXTPj+5rmcT/5Yw4JLW9MecEalOSyQt2pb95x0iRfFwGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=HO0YM5aBM/ugqh225HVlNsW6sepO9ertvT9w0G6acJEVQBdShKc0cGeN2uvgAH33cQjX
	 Wf7dMAEmyMrw5r5L+8oakNZw2COvkbUkoc+oR6RoBQzKBbHJWfA+MTBEYCgrDfD/gY0DF
	 tWXMb7CvuuJItJLklgNhh9iy+TQfwYOAv7h+NnIg9bOK9Tp9VLz4SOkZFb+KuHRw7v+a1
	 zxmkXVzuEQM2BeUX8hWFw1PpjUNh+74pyoUayBejzFrXx9uSVYenfuCd2XP1UDq+YkKMK
	 L3UWi/mvNpGpBOVAxVYVEtl7l6mCpqB/5QOuKMJ0H/OKCt2hboQ8bx5CvGTl6K/kI/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6pZ1DGB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B515606A323;
	Thu, 26 Nov 2026 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6pZ1DGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413EB1F000C6;
	Thu, 26 Nov 2026 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700935;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k6pZ1DGBR3LMdhAs6V71dMpy4VrfnOs2raeYKqaPtQXLavZMci7zuRTk5fHtVSfXv
	 oGcqXLnMyKotq+hwvMjmutCD9KIBi3jLL4TgiapRp6IzTmMySJybz/I0U2/CgYPE5S
	 vrzkmyeDQ3BUR9xcxFuE/bBll9XOCwc3Ck0tjbGN/ti7Am+I5LGPHeIN7h6gOATf0+
	 ENTdf/VzSM8fmJKj1gqrvpqUakbMBx9fZMh6ge3CxmE+tU9avDzvNQ/rOpGapWr2Rq
	 TryhbrWb7tcvWHGi0S0ZgPvfM1xmMjSG8PJmejWkmWXEiT3E4ojtUH+9BvVOqDeeYT
	 c2NQB34n1o/wg==
From: netdev-bot+sinfo@kernel.org
To: Yige Jiang <yigejiang86@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] atm: Fix atm_dev reference leak on VCC close for
 built-in drivers
Date: Thu, 26 Nov 2026 13:48:54 +0000
Message-ID: <179570093476.3294.12428531344618482598@kernel.org>
In-Reply-To: <rc-b1-20261110-vc-164-2a437f3c5ecd@gmail.com>
References: <rc-b1-20261110-vc-164-2a437f3c5ecd@gmail.com>
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
