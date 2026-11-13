Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597012;
	b=mqFeZocIzaaaZfq/x+in28pVduz+TmbUy+YVYuu2d6PVLgdIbQ/UNFz4emw75ogGdtZ9
	 UgvroiZtNYPa/xgN7jwq3lWJLHWq4CBYAQhGGtn/Ae8AttdgawV4BIdCe0tXFJJAZoHNw
	 vAW0+sDvTNCLuqvtOb0FV1havXY2iMYy/cEgVjgxmhVQDzljBYugZSTy92aa/+47vuE2y
	 +c3qL51XxmMSq0R8vr7OafB/dlpIKyzZnao//CEFcu2hdY4+NUVT67QknIOYeAHQLESn9
	 NPoi3hKpOljC4ZK3axSSDEk2Ft9ySQAacXxrooM6JIpNg6xR7wassdMvg0+1Gi1n+Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iU1BPbr/khgFBD+mePW4FSh0xmwiXSk0eLgexYMeNuw=;
	b=yuda4hlFt+mED3OCr+b7V4RMFW5Eg98nbYPbwAKAWtsaHq2LaGaZBZ58/T8H/Akr3v3G
	 hm9fjFt/UwuwwQvMkKLvu86c8F1zHvHBevc4jhONQOJQYjffSYmZyHUJf7h82jGwN2DuY
	 mH/IDsCQUK8QgPIkvFwhM9nKAq3hGT8abnuW2xsSX6nu8qT/oqH0Gs8OyHBD9miWT3uG1
	 70PLGzgcWrxmSHhKHKdDC4ho8FSgnxPAhtsEd6YSCRze43odkBqnPz/v00ycPlxShnMi1
	 qRpVPhHRQSc0RAALc7dXQJSVfZoEBFSGPbhrPkX71yxuxGMQlYrG1sEvYbXXbcpltbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRB2sOBu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA534606F313;
	Fri, 13 Nov 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRB2sOBu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6322F1F000C9;
	Fri, 13 Nov 2026 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597012;
	bh=iU1BPbr/khgFBD+mePW4FSh0xmwiXSk0eLgexYMeNuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRB2sOBuVfNcU1pdRj7FoTWG/gDk0+UXRl+LYWij3StSJGeuXclE1OZ9+qd1rSVYb
	 BbJFNRqZQ+0o8t0Cigr0pHeQm14B8Nwo3LnngdQOV6iefQREIdk5GKDKxB2mXA0QCM
	 mDAvy8VziHiS6fPGEfe62dB2hMzyTfDkRQnsXezyVvI/c472Wzg6gsjjxUCzCSAP35
	 RcavUVitoHoVE3Qd9eE5z7Ht8aHWsfawppQBm900iqe4EImAkrgheFWvj91HT0kxry
	 uxDYxLHTJXYGksRiW+5O8zU1ffTps6HCKFcVc+O0iVTy1+9K39L5HRNoigQsWzLAWO
	 ADwGA2XFAHh0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	liwang@redhat.com,
	jackmanb@google.com,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>,
	Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH 6.12.y] selftests/mm: include kselftest.h in vm_util.h
Date: Fri, 13 Nov 2026 14:09:56 -0500
Message-ID: <draft-0006-revernonkselftest612@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113091000.382250-1-vernon2gm@gmail.com>
References: <20261113091000.382250-1-vernon2gm@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 13, 2026, Vernon Yang wrote:
> Subject: [PATCH 6.12.y] selftests/mm: include kselftest.h in vm_util.h

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
