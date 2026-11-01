Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574796;
	b=GFVfBsLqqnbSCtVnE+A3VK7er5fNpRVZcs2oPKjhKGGCmX5T95AZoetldFCC5HpFZVCa
	 66U6WZD7MFJXXVPyDEAL0zt/kxtNQNSUZG1PnKk+xNqe5a3R3OpIT3tGrcCcNNJ5vygF8
	 JtQcYVi771a8aImq57Ao80H7Zy78lS44NggohtQMirWWt3/zT15WGMizxp6tErAZd05ET
	 t/7UWX4FG14n/DUB7oLrzIH4D7DsytryZifsC6seTpLsss9imQ+WU/8TZnqOKhaat/eOs
	 yfLAXfn5pOmzfDo32qREk9iGLoibAm3F0SKKtVhasMiWP/EclHJe9D58zNnk6wGB/9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=EcL5d7p7mrVTGncXK+sVuPmBiP1dIV35QFJDE59S5+hoSU7hDynXhOpzBitTtzys49i5
	 vkWaXFCjKkzRL7VvTF7Cu0fBMhFUt5dXc8BRz73CSamo3mh0QsQdt7ZHiXvyDPgLFJA4r
	 zQMtGK6g6MNlKe2lEZ3zdnmgj8P9qFIiKf2qBDQgf3jpLwmLdiCUoQwiQNpFruNDw/WHg
	 +35TiH0hx+65HcjI/7BqFS7JZZu5L769trWG5l9AlFtk6OjKESdsKHJMfFo/sm286kWDr
	 jH2VyAEmBHuha7P5kEIsjxiWMdBLvTcj/g10FeCbKnCKd6aaabwiaQ0tvcz1mEhQLPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcXRSv6o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19032606A326;
	Sun,  1 Nov 2026 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcXRSv6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4A71F000C1;
	Sun,  1 Nov 2026 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793574795;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RcXRSv6or0cg+d/a9azAtBA1u3q/oFcmbFkf3Vj30PXUUHriR9l+SEzGk7iqW9wSb
	 lTNhYeccFf+CzWpo+8O1OT8xcI+CqVsNdizniK3tObu0gBvUs1MSxsiIYJ84DHxMF6
	 7w8L+zg7nwFRiLPSFFi5mHPfs3L+rRu2/uPLfTh+XzyuV+jLP8LaVldeliSITfFJ3Y
	 T/esXOmSzk9WUGmQdTaA74RQQZVgKM37+9EyHD8WcV3/eDA+RqkMMA8UCZEbkJDEmV
	 3spJZ5mLqZuwgMLXu27UAFE2T8PG1Ec1xdbP4LMM7UBT1JslcyDOicHYZmhtcKSSSl
	 aKnkDoUce5rBA==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] xfrm: fix IPv6 first-fragment protocol decode
Date: Sun, 01 Nov 2026 23:13:14 +0000
Message-ID: <179357479474.3286.17356070785427096801@kernel.org>
In-Reply-To: <20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
