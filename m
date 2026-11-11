Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391365;
	b=dtx0FGILOukjZx+bpJWTQdQIErkcFdf2Xelsfzt22pF4/SOEeQpwkkvhDTMdz7t+4b9u
	 Ky5Jl339aKyBJ9I69NTueK/VGIarMesz6aYs9mPCnP1e0n6MOXvbpG0HQbD5SJClplmU4
	 /tu/IyNWkikejsNEuNPk7OWxPn1mjWRRxhqGrAj6gwrUQAiaR3V6uhWEsrrBR+caTU1pb
	 wDjFs7+g0EDn+nSwOsj9u3nsROjEQJNtjiGQOgO7DRtYlnSUpdyjIadiH3almSZFVhDyV
	 J6qqqfTdqXbnEHxqnXnCQEblx5IZpDs9e9lxDh6VImGHpKrY/hmqAHuOEY0K8ArQyTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391365;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	b=rxqpj4nzKbV3SI1aY93yA4OdcnqbsW103QQG/UXL0zdxg9qq/XH2p/MLTrTJePG/465j
	 lo6u/aJQpxd0V0HIa4siztZ6ysWYV/HbD9K5NPT0xp6/N8LnPCaCzph/sSTjUS7rL0kna
	 jCQjybYe3RJdqMXakt+7b/sjniJHv21dtMGBctDoYOJoB/kN6C9bD8BEAHzK4gB0nJv6t
	 N+iYrzKO1ik9zdQhgOqtJLHRtXBdpyt//z5GGZ7a8tMp4hD9qoebyDshgReCHIWoPgp6J
	 WBo7AwH8AcImEZXE2QwARQnmijIENdbqzJB1Vn0ZNcfmrbPMqRqAgcm8zJtrPetY6ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=huVJ9N7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A60606A338;
	Wed, 11 Nov 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=huVJ9N7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9911F00A06;
	Wed, 11 Nov 2026 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391365;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huVJ9N7H5iWvigb/qM5S1AO680kikhWwoq1LGpG22H7wZ+JtoLEQrqzIFDMz4SZuO
	 v06z7R1BZ1Qbyev/Zyeq/AxyfdZK1a3eTW6B5Zv+ZGL/Vz+8UEG71ZA6zTkAv2wulx
	 qqaRkn+6jpiPbdk4urp1rf820Qus8qVdBkG5ji7gI/XOXOgyZItqBsahr7PZsOz9Cy
	 kjG80wvvauAIURDXyIhYpslWhpKh15XJiyGFqQDMuptGRA7cW5j/n3o5m7+B2nFB7y
	 ZT0aAMkLsg7Om7LnUWPxJM6mUNq6tCge0mODItOFvpwm8UZyp4efdgeT1XkCILDNtv
	 HsBzdvIiYYa2Q==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, Guikun Yang <yangguikun19@qq.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: fix SNL PDU size truncation in
 nfc_llcp_allocate_snl()
Date: Wed, 11 Nov 2026 10:02:43 +0000
Message-ID: <179439136381.2168702.3784011162899965365@kernel.org>
In-Reply-To: <20261111095907.3366028-1-xiaolinkui@126.com>
References: <20261111095907.3366028-1-xiaolinkui@126.com>
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
