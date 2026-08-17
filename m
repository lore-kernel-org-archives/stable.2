Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DF5733E
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937122; cv=none; b=kiO7Kab0jUdfzV55+1hxOhUnxDIwJydDWcSSEiRFknzLpqm3306vKNqI2tIZiP4nqtg3wB4ZdQgA+agZzej58/P+BFC4AsI2guYS5UHZX7B+Z0eKV6LgB0W0Dx2UbwfmjJjiliDSmN5Wz/d7u9rBwJsORgIl+n/xI/15Zek71Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937122; c=relaxed/simple;
	bh=4mbJkSoHfNF5sQbkLdPtvfyBc4JY3QMfclAsMkuuXy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4LHr7Rv11Ku+a0fX7PgIDiRNzl9akBqC2iL68z8EDiEZprDJR+YAVRxw2TASJi4HSjwolKBMM+na7B4fLrlCgZg8P9g14BVN3oxdY2mrcn5PQWtk3fcaxDgijrS1Mk45KEbyWwxvZ3TFxuj15xbp0a3HDXw4Yg6S9lv7gx4WdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aePlFqBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aePlFqBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B581C1F00A3A;
	Mon, 17 Aug 2026 03:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786937121;
	bh=+kxP5XSKdRPT7jdwQ7gMK545J0LsT19UJaqe7qIzzE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aePlFqBsmVEu5DBiD1/uEZp+mD9CAk82VHG+bOPlTpZOR6gllijKAcJWcoZ6v7ev1
	 jOKxNCH1FCNYrrPD8o08bwRoao4vMGprCIxDrxOev8iyNOxyolSOWI1GVppkbSCVtf
	 jmk1cGLmFuzwlyJQPgoUSXzepFdUvNIvw32lOHTAoqOFnthCZxSoWQEkLg2QpLTGuv
	 EIlACBuTOJQcrjb021DGKw71JvDwytY1KIrOi5o7jk9LTGXhmNap6D9hHDz1i5+G48
	 HU4U5NqqTs0i433jfEfCsPWaqbeFzXIRzT0yM8v/IckAtI9ZOxwfNjOI0IoEteF4KV
	 i/nUmSeZFo7qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tsbogend@alpha.franken.de,
	gregkh@linuxfoundation.org,
	atomlin@atomlin.com
Subject: Re: [PATCH 5.10.y v2] mips: sched: Fix CPUMASK_OFFSTACK memory corruption
Date: Sun, 16 Aug 2026 23:25:08 -0400
Message-ID: <20260816211000.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816003633.530523-1-atomlin@atomlin.com>
References: <20260816003633.530523-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Changes since v1:
>
>  - Fixed the !p error path to set retval = -ESRCH and jump to
>    out_free_new_mask so new_mask is properly freed on failure (Sasha Levin)

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
