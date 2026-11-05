Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862386;
	b=F8WZQsRIZTSorsGodEmT1DKgLieMkIFrjDuCtcQ4RRAitlEqvBIyGd4KS+KvsVtPt/ZI
	 8AUNjmUixshzTfxGAq194l0jMBxMm4ID6sIGiRyuY5EsdoMInj0FzQv2nlVmUQXywFsPf
	 MRZU42npr5agk3ZwhvAWGIYyNRA2pHKFqa1ZwkrR4zArVmD7jDYUk/cJROae17AE8N8gH
	 9yAXkLxexJDf/TzbsZMSxVm0Fchg0NfMuurKBj5ByOih0SAB+wXt5m9Y5kCCmILqOsBxF
	 SYAaMqydpVVf0OnlTW2hWOJF0iJo2U533c2kMR9HIBK6t7QtxCJZskBmN2Ti8/6NH/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862386;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=XpFPKGXTmUXwSH2ovEh0PxqeB+ze/6Xt/p3R3W/ZdsonmvUwnuUUz7M0QbHy3kRwBIoE
	 DV6u4lXmH6oepCSpz+Q2bwBNhezwouba8kYQdrtd5FYYvCNkrxZ2FjZ9wbOQDe6AN/2be
	 Z5RSPrAi3xsW06SWFo0C9VvPVSSEpYje4XRnQQRpabRWLzpEBaRf1bzP5/O6wUBkOyqfm
	 2jbu6Od26FZ4lA/o0qjfhdmru/lKFJuIEq0WHZQvNSon1ujl15vGxh6WsykpykeT1v6IF
	 uSr8YtellqKNrTQH4MOsbeBDJpYVPWe66WXJyHBQjtdRcg1YJiKjFqOf7O9+wRmEXbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6zTV3Mr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB994606A328;
	Thu,  5 Nov 2026 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6zTV3Mr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00C81F000C1;
	Thu,  5 Nov 2026 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793862385;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J6zTV3Mr9FH2F5X28UpBb5j8YnlswoBc2K0NIUTiq0IBV6/+KNuUlb+t47aR04bOR
	 2+qpwIVNdrWKnw4tSw4efMy06vpqEhtrL652hz+3lREUSSxoa97hDZyrzfNR5uaCiK
	 e+/XBXQnxSgIfmA6y/90aQ9UCso/OOLJSqK5S9/924gEGIYmqmb73uy23/s11M5NRs
	 xGTN5D0QdD8D4v5GLfNKs8B0X7l4/bBg61bTdnLMhV1/FceL+H9nBoaYcXSbO5QkA2
	 aIs2pbE0r9w7rUceoM8YtAlAK3kh+REESLVSTdf1KyZCkAqMNotMp4+3FjWVqRaxaI
	 QREBnyxcXzuTg==
From: netdev-bot+sinfo@kernel.org
To: Sun Yiqi <sunyiqi2@huawei.com>
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 luoxiaoxing@huawei.com
Subject: Re: [PATCH net] can: j1939: transport: validate the DPO packet offset
Date: Thu, 05 Nov 2026 07:06:24 +0000
Message-ID: <179386238443.488859.15787411674340454987@kernel.org>
In-Reply-To: <20261105065931.1302-1-sunyiqi2@huawei.com>
References: <20261105065931.1302-1-sunyiqi2@huawei.com>
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
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
