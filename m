Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4937443C3F;
	Fri, 11 Sep 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125701; cv=none; b=Wczm+w1ki460ULAGfJPtAkqk4wi3F1dnWniJQ2wZqWsGCxDZ7UzC84zzTMGmMselqGd3gKYyUamXd2pPThHcsdJrUi2ZnDZQC9X67BJ0GG3y2+XO8duYeHOAqKj/dnDUToNIsrgVxY1J2gfJmZP+TgKQLtk/YTimI34ctUU1IgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125701; c=relaxed/simple;
	bh=kj8RdlMlF2QHxskocOmJVyXuzv15K0T74DX+MrK03OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eC/25LMLQAPoCeWjbvLlv5uYFNkOQYowHZGKF561jlKzCyblWys5JTZRuGA7ICuMCCnxMcyxK2wUhZvtp5cICjhmil8iQ1IPjHK6TItUJ0qINKhfr7fyhxtOauBOrPlHv7UIhCAd+BjPcBoyzkxWOP1I/JMAswYOwKIF/SFRZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksvpvG8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksvpvG8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051C21F0089C;
	Fri, 11 Sep 2026 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125697;
	bh=a23Ozbm4iPV/gRyAYrwLE7eiu9PMyoPvhK8VURhOCcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksvpvG8MbuaSQt6VAVXzzABIs/kpjG+Ptu/76EKgmFp2HXXjrbjyNtpNfj1uBOsNC
	 ODxeHzfHf9N82TXIuxz5992dNv84TT/xXocapFa9772kk8dFI9w8hovZofi608kVHS
	 /grh1yLQTNO1KjTCqq4Serkgpibeu8c/2A0Vmf1fJo9PDN0osvkO8282pSrJx4qbis
	 WU40nyc/UZFrJscyh53YYzEu4YsVDNn0UeEb5IyNSQmIPdZl2y+NqWbQB8wEaZIUCv
	 Uoi+C/9QAkCFEknXeos7MuPRgu6RXMXX/g2YQ7XqWgU5Hgjm5EBDjZQSgM9dUuqACw
	 2yjdRHMW/VBDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7.2.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Fri, 11 Sep 2026 07:20:57 -0400
Message-ID: <daily-reply-0038-re-damon-skip-aging-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910005213.126528-1-sj@kernel.org>
References: <20260910005213.126528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The number of DAMON regions could temporarily exceed the user-defined
> maximum number of regions limit for corner cases.  For example, users
> could lower the limit via runtime parameters update.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
