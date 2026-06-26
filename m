Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7739E190;
	Fri, 26 Jun 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496490; cv=none; b=rWRKu2lHkO11yvfL0W8D9wcFl8MkX36ZjeasYP7xjxUpX9CDw1ZSvC+e8s22esvqtLwDJQ52g/7tKvCaLE48lzDr2wUeeVb7kz3v7DrfEWnBKGeRJRKjCrYPJL6u5sSJU/AfGn/JYTm7yqq7IepRrMNvXiCHtwVdUm1hhjJcgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496490; c=relaxed/simple;
	bh=qVKvuBP1TWYXc/SxogQCsF86dqTWfiwoWIY9q3JTYbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0Lp9IyWL2xHNzquYefF67/4bS3wiBLsVjV/MZ4jFVnHcpIFnGII99z/XU4X0SnA4qerKZrVEvM7bkg5DsbJv3CTroWr5UmwnUcYXyg91IxcYh2w3lTQuQyE6ZsLHs2XCwWT1tlT32Dw7uzMGVTFru5CWEv4bBS6pUlGzAhvjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbQIe8Yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbQIe8Yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB3E1F00A3E;
	Fri, 26 Jun 2026 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496489;
	bh=9mJnoL382u94C0XCRSjAqTHRzxxPggY9HPyS+UwVsfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BbQIe8Ykb/UPiJeYeR92eVJdkAskbUfofnrIO4uOPYSmdglB8atDV4uBjFJM99dB8
	 kIxxpGkNnlaXSiFfGOlTHJA7qekaMweBheYAJO5QWJZm0HsFMOd78qiWXw5ooi4Pta
	 L06Cyb3CpJMrpzA7NsNg0RJRrgXzhEIHnJwksFGX7TE/l6VbRlaQPBIWyh2CtsuE+5
	 yIkB8fPf6MGxpfqsvka/7RwoLLo1GUkbSIhqVFq5pCtlYrq+up2NnmLLseanmGymbu
	 du/tVb/hc2F4+StB7h3YUcQBnShG9veqzAPybU57iDnqoastnJym8otho8vPGVgjoQ
	 oFqRjuUus2NIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7.0.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:20 -0400
Message-ID: <stable-reply-item006-role-70-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112250.1776969-1-pbonzini@redhat.com>
References: <20260626112250.1776969-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 7.0, thanks.

-- 
Thanks,
Sasha
