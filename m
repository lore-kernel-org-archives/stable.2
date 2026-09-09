Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99B3939C1;
	Wed,  9 Sep 2026 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985613; cv=none; b=vAuJc8TeytWqscv5lKr41LATvWxVzTAEPnEz03Oa1j75R3Tm4cyJOMwpCgPFWQHIfCXvb6aLwPKRcHpN79Wfbw8q8FikTTH/JIUy8FOHzBblPF1xV67XMUFlUXog/ZqqjESNT1X7ZycuVL3y5AmqukkQIehiMYbbQ5z6lEfIkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985613; c=relaxed/simple;
	bh=9F4R3e7CMoo+sJuGl+BAH4DGltcewq8tMP1YSXlFAcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJOqgEZ6caznwrumbOXs/Wms9OoFpDxzkSlusootKl5sLwQTubThLklCa6grCJb5VBLA1q84zIr6s1/StbeDEoZlCcdXomKW+ofm+bS47Be16piGz1xLlg+2abUBpQI1s4NoG2T1S06FWrXWpSkwQVbUmuMKJiR9XLu+FSpwaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayH0WlFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayH0WlFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F24E1F0089B;
	Wed,  9 Sep 2026 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985606;
	bh=+ME/5WYHkNEe4ngaZhm9EbDiFgPIRhsdbxEAqz+wL8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayH0WlFJrjItDqdj/SPYvpPojOc4Rm6ucFMMQi8bz1ZPtWUgkiBj+27ytBqp6Nw5S
	 sxnwL5ghkE2zxRm++1miH6LBVGrGvm8i/cUhjPKfQD5CMIYp1egsp4bVHeBcw4yRy0
	 zqPfYyxOA4roJzmuyCjbtnsU29zqKBpnrbeXlYBFp3qnHqoM1m17qSIqEeKJTHPeL2
	 RN4f4+KjzK0u0FNHUWeSSttufLuVHbDhMtY3xoNrn4HWY8Wi31WHJRYSfzBlNg8rnP
	 H5AW8jSIiNarhYfI3aeqlxPB65CuWJLouY685y7HXpoulwA+z5S6OO7W2SsfO1tUzu
	 sAnGUyK3XHxqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Wed,  9 Sep 2026 16:26:09 -0400
Message-ID: <2026-09-09-daily-reply-0011-damon-vaddr-drop-optim-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909060130.269798-1-sj@kernel.org>
References: <20260909060130.269798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The optimization can race when multiple kdamonds are running.  Meanwhile,
> the impact of the optimization is quite doubtful.  Just remove it.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
