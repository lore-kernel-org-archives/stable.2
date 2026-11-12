Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475326;
	b=bO94qebhRp1QB6BvRlXfmT2sqyx6RDyFYoCSjyYoeC4RkKuH+AzmH7ZgxzQhacQqWIOZ
	 8Z4+A+RPkH6o6WlZfosNxsanC6TAkiw1dh8XayQ8ZoN1+FcVZhS/cNzVnY3xoExOb0/UA
	 9/S98cm0zGxpGc0CjY3/lf+XyB+A2F0XX51IQMlhMCFd2Zvv2ZYKd6rtPCY3Glz89eZcP
	 4iApkKXMBG2wY3xkuLnXzn7BY26d5IfcOSeHUoCx05cKKcZYmy4YZSoEhF9FFcX7vJGwP
	 bcgDD5QR/s2Pl22tdZ+tWP/NAcazPAmKrg4v1sNC6ePpHyGy0mWKDZUsdQfufHyRVQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475326;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	b=Ih42CrRUzqmt/4I6vQ/FdKqT+R6MPUxFe6wb0bwWImPO/yUxo+BhKULyO9xoHzl5j2ez
	 nxy4frhf05Tt0fII96U0Q0T060U0frN4t8AKgfpbZCzRwY9z5rV4jSVOKXEcRYGY5g7X8
	 yOijJMG0eODjLH2cuLue5eWL4zrhnL7hik01p7N85SHzAxy6jQuWhwDD+WZblIhpc2IhV
	 ZUSIvtU0Xy32HjgOgFxhVOVaU2ygDvb2wOXNl+iSxkG+4RCOMN8IL2q4LW9Sfa84VD7TJ
	 n1fjIbejxyGEdijmdZjs6kDmQGoP91X3S5U+UmhPh0w+IHtygARMOEwWE77Mj4iou5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAOJwhZu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729B606A31C;
	Thu, 12 Nov 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAOJwhZu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6271F00A05;
	Thu, 12 Nov 2026 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794475326;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nAOJwhZuPhiifB1pHM4GAjXo0IsTEIy+1AHFfyPCUFvL1ZpMCNwBs0bbAbdnC74Fa
	 yO/sVppxWLenFnxjtzXfzarxZEgA6ZEGXWTQhfo/IwANEBRpj7+Z9drQDWp+3aRNQa
	 Ee72GH6Sdet/XOXTEkFX1p9RnjNSacbnI7AJmQIpjPpmmiLMfwl7BZNsPz0FpCsme0
	 M+elIZ5zR0tS45NiH2JBIVLbwyz2ua0ndLK4vwXXeEWg+mPaF37aZJXIaJtcp5MMv5
	 ho0qwytX4zefuxynu3VDax+fdf6QQc+ndtU0SxJPjdCAg2C1Smr0WvUwC0q9ibZtdc
	 /iW2gD44t8cgw==
From: netdev-bot+sinfo@kernel.org
To: Amaan Cheval <amaan.cheval@gmail.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com,
 przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com,
 pkaligineedi@google.com, maolson@google.com, csully@google.com,
 willemb@google.com, yangchun@google.com, npl@google.com,
 awogbemila@google.com, shailend@google.com, nktgrg@google.com,
 maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com,
 hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6 0/2] gve: fix RX page refcount overflow with the
 pagecnt bias
Date: Thu, 12 Nov 2026 09:22:03 +0000
Message-ID: <179447532371.2168702.1261444176228225499@kernel.org>
In-Reply-To: <20261112091451.22969-1-amaan.cheval@gmail.com>
References: <20261112091451.22969-1-amaan.cheval@gmail.com>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
