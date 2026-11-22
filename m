Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317167;
	b=NYYJY5CNl7DIVoHpVqyl3z+OYN2p+hmmF4O26QS+YyX0FEsqgpTvVv+jJlm9/sBLGdn/
	 POFaBb7HFSvCL3/HPYAWs8tglfoImv4H8T3AnRYGUVYR0ALYFev4u/FoXwhl8WhZ/1TDK
	 vRQBeoL41FHsxMedaVcUungoRCqdggICF6ga1AvA2hya+dt8fxUQmQE7JTIBVecgBybNz
	 Wf19+4iDxJlTYlckIzJ9vC1LgEFOUaP/KdYz+aeqy4oMNw0myo+XE50mPBlmz1M/hbZxZ
	 PaPhjOer4+qvYOSdDvEWLUuxvt71xFlPZbvFJyYR40zJcKaTgRZPFAOcqt4y5uioQ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317167;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=qWbjTcR3HaGSNIc9+8FK7LoXidspRfPiYaBy5iknZzAJVkG8fRJZGcMk9/RuTEK1zAT7
	 jWjnUgVgFYDzR+srHdcpuzUxTdokI1OeNDKfIM2Q0XCVeRzqfkQgxZ5X5ENIES5ZpgksB
	 WVIEdjBpIvGqJC/SHejLJJxJ0uf1YW2RBciyDErnIphU015B4NH+6khdvoY7cX7yahO/T
	 eOU//44TOkm4HlB8vBfESWwGqLEflhEq5RlLZRFvEmh0PBSJXjSpm0hEoiul4HPI2GNW5
	 qARLPX0/ooLibU6hSErdviNmHjgHoY+q019uQi0y54hLdlu7bcvta+sQ3nrzYm1PsUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1Dj8N6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5A606A320;
	Sun, 22 Nov 2026 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1Dj8N6+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB981F000C0;
	Sun, 22 Nov 2026 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795317166;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1Dj8N6+9GAAKTmZO0k0loFB4zVmLU3ep+YI/xKWuYwI9IlZMJ71SCzgnJ9QbJO6Z
	 7kqmIcdWHPQ3ehGqjGuD0oXdnGoYzfv8u7u9yfEWBtHKQVuYpO8d2SljwbabISKHPb
	 Pa18ZC2GgHsW9UQJOe1WLV1xFfepo/RJtQaGFMIMeL0lHW5EOjIUGI3K3/4EQfFgWM
	 XafKVsWbaGnQ+W7HnvKJGUkQpFyqyUUEBPQb2nA7KOC86gZLzOxpGY5nMwzDv5kWDp
	 BlE2m0Kl2U7lQ0y8i2BMWV6yBjwyYUsTEfohxALF3VCARBiY00CAvw0h+FlmJ7RBP6
	 GmmDy4z53QKKA==
From: netdev-bot+sinfo@kernel.org
To: YanXin Li <fadouse@pm.me>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_ife: return -EAGAIN after dropping
 rtnl_lock in load_metaops_and_vet()
Date: Sun, 22 Nov 2026 03:12:45 +0000
Message-ID: <179531716568.3294.6444529448687411104@kernel.org>
In-Reply-To: <20261122030728.9368-1-fadouse@pm.me>
References: <20261122030728.9368-1-fadouse@pm.me>
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
