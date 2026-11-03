Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700557;
	b=JLhoCU52C0qLVFnffq1aBdvU1SNaWI17DuLc2R3a7lo3bUej4njvghwCFn+opexX5ocK
	 Vsky0ygg/5FK2T2VAzYpTwpmCnuyJpXyNyCJCwj8t5G0a8RYDTTnZmuSD7XjbEyq2448i
	 k29mv1u5+bL3Agr9cX4I3g3TDS7wdJovlrkdO5ovkgIKlVw940YuQKKTGsLsCf8E5aybx
	 Y4oJBb5ha0ThfSyTTv0KHTbLQ5CQpsJKcelCEEthEVQWsdL7t6vG26aB602vD7I0jWi4W
	 xxdgEHmMx97daXgbgIJx1GeZDYQJG4v5+3X6e3YQc4uaS90r6yUYdVicvPO8HxLDkig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=U/bvt9tHArsPjK/AMxnO8kJLy2L+ZZT5uXIMir2nYL6NC+q0a6Mr3Nzc0FJ3UqgRKLhJ
	 3CZe4iPAVbIWK0dZXkieMBYeVKXiuYrp9SMivovH3pc7GXQeO3rtMNposwAkbqDdDgCPB
	 NzmDvRuDQgPLjnU7Cm/J7JFVYmvaeFzgg7vCYoJTnBbSzNVeSMvmC/0VLLs2uFgrRKF9I
	 ton06nLuOVNRweascXbWvlECLQkwvKk88xVpNoYtP/5iafH4vAEuptU9W23QgzMtLm53l
	 dJOZ43GgSGZQefRrn/OOv9ygTgnQ0fbwslH7FhGM4O6UPu4pgznyo/4NrN7vA1TvWOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK5ysXRL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F96606A329;
	Tue,  3 Nov 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK5ysXRL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17B61F000C1;
	Tue,  3 Nov 2026 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700557;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dK5ysXRLSs2l9Al26B3OFhqdJnetNtDSqftUDxIfaUXc0aZo0p8F2CkOLVE/B2fEw
	 LCXVt17VdlFsYuP0f3T1Y8YRh2GPpkdgAairWHfkVrzzZQCuplcKk/NStnlkcoSbWt
	 KlBspdmOVRAZEHepqGL5CXHxXa/zROUxOHDB7vPohlVoS5QyOyI8fxKj6/rVRN+int
	 ZbGR8XWJOKBR4+sR9rS8q6pQY3FkHnfLzlQXpV6HriEjtJnf+A+eDnmxPu1eEYjAVb
	 lzMvuEcU+N6cXl5/tbMfO1ACNo++6zIs3t728vxLc8MEHhlGdpvxcNvw6Pow4A1UeO
	 AGUU+1+q3BOPg==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: dsa: loop: release netdev reference on registration failure
Date: Tue, 03 Nov 2026 10:09:16 +0000
Message-ID: <179370055636.488859.9185478445821067801@kernel.org>
In-Reply-To: <20261103100529.1309887-1-vulab@iscas.ac.cn>
References: <20261103100529.1309887-1-vulab@iscas.ac.cn>
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
