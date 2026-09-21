Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4A2E266C;
	Mon, 21 Sep 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031513; cv=none; b=kaQGuegz5q4GTGxHWbk+1wOJX46B1u/WYldXnIR73zrfla1c6ISSAlbgiorWofr9COfrWS2eDf9eW8KpnGdebA8jVBfrngxOjHlotcfhhPAZO6t/Smhv+5aJkWtU75AgHsh2NOX9APLnKF6M5LgKJzYNms7A9BYwH31YWgckwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031513; c=relaxed/simple;
	bh=/bPqeO941UzjWLNyd+osMPXLYzn8HlDkDU90t38n8Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnJV6nuhV5LUb9BcLt9ty8mVZh4s16WKNb3mQBil0QDtlV4GLbAhKB7vrJlyomX/LPJ9aYDIksJwErSZRzSmQUy+yjbEMqo343vhFsIIEN0+462CXM7xtoJtpd/YpydgYCEwFzuByFYikNW5VIpGR2dWf4w7iEL8rWqjgVDXvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMtlZeR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMtlZeR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E71F00893;
	Mon, 21 Sep 2026 22:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790031511;
	bh=6l1JasplCdyEy4TieVw7aqMxFC/HDXSgNqywuoFEnJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jMtlZeR28oBxNpATlieej0XQmXt/JFYDdyW+d/4jPPbzkTiR+/0SVdUO+OBQdkSfw
	 Ae7VT1IBYdHpIHJSBEvlxzKhGKhsyc3OlpEUMqJAxzwGrEMu9b+3PTlVBwyYfR4O8v
	 Q7KZtvqxqwrPKV5prQTVONJFezrRtunUM/VFqclimfCOyjOgAxJ4Hrj2YH4SWFgAqf
	 k7qlM8kFMkMgThmFaAJHFULAqTGHX2baserkP7P3vnWUG5A9g6qNGEgiEu0Yanhkyl
	 UsZoH/N56GOZeBlKfhTBh0VVVYi/yObUwT23Ja0cpI3LkRyT5Td1rrmBmjzljM2L5R
	 CN5QtjsnZYBLw==
Date: Mon, 21 Sep 2026 15:58:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel
 resize
Message-ID: <20260921155826.5970f028@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260921154147.4e1e092d@kernel.org>
References: <20260917153923.904124-3-bestswngs@gmail.com>
	<20260921154147.4e1e092d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 15:41:47 -0700 Jakub Kicinski wrote:
> This is pure slop, cramming loops into functions which have none.
> Shameful, really.
> 
> Please test this and submit it if it passes the tests:

You know what, I'll just post it myself.
