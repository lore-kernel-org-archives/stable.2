Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2313C5DD4
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701622; cv=none; b=qju1FrtFfPMkh8H8I1IVHAhWMOtdjeoM7ZGz7WySi6Xsk2XCJoJsFUl/+Cl2nuStHexOA9x9kqP4TccYSS5UYt9nrGZgDlDUCFt3NxkYoZ8qJLBzgIdNjz5Y1fm+5/ffQu7QaBmOHpff4+ItOwxemsx67fIrrsDwRJY8cCX5TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701622; c=relaxed/simple;
	bh=l5VL/an155U69EwQkNOwijAfoKOg8mGm4JcNP1bcRMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/ZUwRQqhUVDib/9Ltf9VrlZpAHZdTn/lQ2ovZixBENy3tFyKBSEeKYG7Eh7PyULELZVCz6p+Q//kyZLghDWAscTUh4sjAO5XMOeasexfx7hJoqDUiwSafKHMYLdF5xoxsaHgQh5k0efOZbFDESFyJJo1eMI1B5lbcA8qn5yPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlXxtRbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlXxtRbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C368A1F00A3E;
	Sun,  6 Sep 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701618;
	bh=F/P+wVESqsZ11M7gsPh6RBTs/Q6ayrA4EO4Zl57MBHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlXxtRbvxzQg14KT48Y/FuJiTAdZd1juhtzFLYLRAf3mSbJ0T0lsxACRXPU0i9uNr
	 6SkEBJBPrKpRlGWJvrWASLwPeCICxQa4bXtaKnPdrOzZzvfThU9o06/J2R7AaheZYD
	 i2vnaNsSgTJmxn2jMQEWISnomRJuRAqxeFsMaTjS5IR7nSPeAmzBZsMWaEJR0ZImyI
	 yzMV0HiBiTG1NBAa8/Ni48KSoWeHfHIgAJru8CeFNWNp+939ReeEs9nNyqpVX3Xf57
	 lvxGqsLMvZBtRIDVRItbaJ86QQ/cSU+641iOUSaGqyvifH1X2Ai9MEpxEZcP89xAPO
	 7wt+hS7tCnsCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH 6.1.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Sun,  6 Sep 2026 09:32:44 -0400
Message-ID: <2026-09-05-daily-reply-0014-ovs-ct-limit-uaf-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904094111.1816002-1-i.maximets@ovn.org>
References: <20260904094111.1816002-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
