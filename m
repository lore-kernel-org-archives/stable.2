Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5752268B;
	Fri, 18 Sep 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760765; cv=none; b=G141XV3eKcI+T/HbeT4GAGudIfoacVqaDgXtlCTR7bCbAGxpnXS7PZyNoJzBE4XcFXldHCChJtmOMU5S/fNtw9PK7+arsWF2faRkWeLlI+qxapm5w4EOHPDnU/PnxS0zrCfPULg1rLmpGz59060YZpF/6C8ghTbA/hEnBpLVOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760765; c=relaxed/simple;
	bh=/bD0Uow6so+oX6k2ENX4c65mEUUXEMsNJp0sLKteHT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXtRsElxEbCFfNfKFm9qnHhRORv/+s9LFB/meKqXQfOOdeaGW7+Dfe4mwINXa4NfDzO3Ho4RX7FpZz5cYI5W3ZMke+m985G+WW8A6R654NesvVXXDYu44PXf2Xy5d0Kw1lmLpRRfAoooV8KXeJPLA6P12VCf5B7fKyBbKxA00kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFTzgnSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFTzgnSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD691F00899;
	Fri, 18 Sep 2026 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760763;
	bh=/phLdOBpmLzAzvZ+7BP2DEYeMuD5Zc8KKAaWORy5oA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFTzgnSDc/TnnTmWHCJJbE4VP4cnSv9X5KkaA84PmMeU8pR5U8BcWjZpzkOyscQ9q
	 B6r5+JVH1dF/Lqoro7F3BCxMpJU0KKPkN52mOj/Zt2kD1wGufWEwTew9DgPVjpajvR
	 Zd0vXqWzezD6jym4cW0hWhctiuRBVltS9QmhqruoKnb0Mcy9lCVE1N6+mCnwMTN5ml
	 Uosb12LJKsOGk/d/v9j5+qPbPd+1tqTf/iErn39h+3md2mTIDI8YiMSw7IpLoVMQqC
	 b2opzS5DJGoo4hXQG5ixLijAJXdUg/b0ZDDnJYc3fIpjC2QoCBHQrYS+SDRBrevGC4
	 SL8YeBJTv3c4Q==
From: Sasha Levin <sashal@kernel.org>
To: "rafael@kernel.org" <rafael@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Philippe Schenker <philippe.schenker@impulsing.ch>
Subject: Re: [PATCH v2] rtc: cmos: Use platform_get_irq_optional() in cmos_platform_probe()
Date: Fri, 18 Sep 2026 15:45:42 -0400
Message-ID: <2026-09-18-daily-reply-0015-re-rtc-cmos-irq-optional@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d35e7730006ac5a2ccaa08092201994afea668cb.camel@impulsing.ch>
References: <d35e7730006ac5a2ccaa08092201994afea668cb.camel@impulsing.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Stable team, could you please queue it for 6.18.y? Any other stable
> series that received the rtc-cmos platform device binding backport
> would need it as well.

It is queued for 6.18.

6.18 is the only tree that needs it. 7.2 carries both commits in its base
already, and no tree from 6.12 down ever took 1ae2f435350e ("ACPI: x86:
cmos_rtc: Create a CMOS RTC platform device"), so none of them can hit this.

-- 
Thanks,
Sasha
