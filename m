Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763034;
	b=IPm96eUUE78MQFZbWR5nXZwH8q4hEyU8hloW4fifakwF48cdURUmQhKVftPVvWZd+cox
	 DmweuqlMk/WyK0vUFpArhwtAo+1JfUAqREg2i0GG4kDyhfpns6d8Y17JqUvp+36zVGuz6
	 aOhb32JQDX039MhY0G4GB+s2vSNIwVNdrqNyflNulizdbd46LRfO7UT9FNiZTrZt1pSFk
	 8ORtBgr6+pwdVJOlpqrls9ZWy8mPX4T3/d3RtFhp/JetoMmbELYjaN9aBJe3lIGCCsnAa
	 brlbXGVoqkNkBZrxWDElylhUMaUyHrzn3J/Aj1udSuDAXhFhkjj+0Oa6tPpst0npYhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763034;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=aaHoj1hlpKietYGmqatUiw2pQOW+dXhOGSFtRXdzk7PhqlPYepUA5M8R18MVrpg+gcfT
	 mR9/XcD4gB6ZrPumHJ2ILQbz0VoFw8x9lRLGywG8t/scSlSEBeg6FKkErQwoclxtblYw8
	 /J01ofVJH4tb8XKzpvYuV16sE6IfEiLkyh7B8I0bz7yAg7noQAjVQMH4dQsP8RPo7PCb5
	 OpA2urd3ZEZS3yaT1plQwbx7oJffisbRnL/UhNOjwA2epAfp8kr/p6PHSY0BrEAeV43y/
	 dww3d5ZWxrj8+WQWvxDKh0bUsjzsSqqsJ3hKcpmlw74xLi2737C7v4+8d0Ate0+3tQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJeALirI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E9606A31C;
	Fri, 27 Nov 2026 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJeALirI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C4F1F00899;
	Fri, 27 Nov 2026 07:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795763033;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJeALirIAAb0GJh/tps++8IEnQzgkC2mDNyi42z09TUL3I8JgAOObIuA6cfbd81nq
	 dQ6v1C+p5T2gWWxl8BF5uONzgfcrYmkvqv48FnVGEj8Sl3RQN412eDCPWgWMFi/qrb
	 sVkzROK34eWD6oxOzV3HFFzLFj9VGqJOEOblqpZikmD+72zEveeTZzOTPrE1BaH8CT
	 ppztykJvqUex062807DJBb0/IQE5VBMnoW9+eNAJAXHAt1b+MBKbpyJQexKMjAeOMJ
	 vJEFekOKqxYUg3uEouX3ZysanKT70mlqAhZmXP1SCeeZO6U2vQDgNihly/auQ1aKh/
	 /w8k/O9ujS/hA==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] net_sched: hfsc: clear el_node linkage in hfsc_reset_class()
Date: Fri, 27 Nov 2026 07:03:52 +0000
Message-ID: <179576303272.3294.12849174231443781529@kernel.org>
In-Reply-To: <20261127065756.2927925-1-bsdhenrymartin@gmail.com>
References: <20261127065756.2927925-1-bsdhenrymartin@gmail.com>
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
