Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8903FD14F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658597; cv=none; b=QTz5v+9tCgiOJUGmCc0gPBoP99nwWScTgFAGc7wKC3vnglaLxR4KStfajFzEho2u8S0rVdL5FIRY+MYfaJ1dMNdpE0qKMR3ayVA+3onp1mAwa3aRa+mZGhFBWRMsSSh0EyQbd5UA+33aDuTN3spO+69nedFgf5fjmKn2/vKt2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658597; c=relaxed/simple;
	bh=+mJwEnR4BCIzHSXf+u101fB1qdH3RkfBL+cnUKnmWOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx2XCwhjv10x3QZ2ZD/eaI+KB74XS+y846EaLnsn/2H0dLxdhtAZEGdUcbHHWld30+N6Q8JBvwqe6VBx6hqbS5Sev9gXTD+evciGd8/RghViTZyHjs7Vw15yg0xU+5fkuB1KYS/glwmCxXcMJKN/uRMHXy885oJ5oyYMQEsr9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnVeXLPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnVeXLPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032861F00A3F;
	Tue, 25 Aug 2026 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658593;
	bh=u6vWbr9DaIkosFaM+c+DnZHLjWyckCsmbFnQAPvAnl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnVeXLPNMjyDgwallRN6sMvSuWINqQsaqRFYJ7YYWoUTYTffZflLK2L5wCl7xbD0i
	 WcJMq1nZU98JVVd6lakelpsvKNB0m/+7CXTmTR7C4nYJfJ8PT0g+qf1T4XbWh/MlGL
	 igGPtqyzDiuTHT3kP2UceN9Lscha0hGdAJoVdMzy4oszuWIl8V4/jreKNNUZTy9nj3
	 OB4ImlJisvVZFah/NQz8eZRdac9cy52OLhUp9coQv9sdOhLiyG/SY8aVZg/b7lB6HR
	 UO4CaCEJngb8RzIC9wutgRYGAa6k82sQ5tQGmlvrNuTe/I+BU3g8z5d7/PbHtWi7F0
	 BFxdZF6QFGGRg==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Donglin Lyu <DongLin_Lyu@outlook.com>,
	Ruslan Shevchenko <adefka@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6.18.y 2/2] Input: atkbd - skip deactivate for HONOR ZQC-P
Date: Tue, 25 Aug 2026 07:49:34 -0400
Message-ID: <202608250014.ba830edb041ce9ea@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082459-tweezers-freedom-b725@gregkh>
References: <2026082459-tweezers-freedom-b725@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 24, 2026 at 05:15:41PM +0200, Greg KH wrote:
> And this patch differs a lot from the original, why not just backport
> the id table changes that were done in the meantime instead?

It doesn't differ - 2/2 is a identical cherry-pick of 410c44b10967 ("Input:
atkbd - skip deactivate for HONOR ZQC-P"). The only differences from the
upstream patch are the index lines and the hunk offsets. The 13/5 diffstat is
upstream's own doing: that is the "[dtor: keep all HONOR entries together]"
reorder Dmitry did in the same commit.

And the id table change done in the meantime is patch 1/2 - 2aaf33c6e1e8
("Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard").
Of the quirk-table commits between v6.18 and 410c44b10967, 6.18.y already
has all of them except FMB-P, which is precisely why the plain cherry-pick
of 2/2 failed. With 1/2 in, the table matches upstream's pre-410c44b10967
state and 2/2 applies verbatim.

So both as sent should be fine.

-- 
Thanks,
Sasha
