Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFA2E2EEE
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209273; cv=none; b=YjNsvhZvM+9grv9f38Jd1IpKwPPHg4rkL0C6jPQkrW8Ps2jQNloj4lan2woqh1PtVdZG3zZfkGgu/7yr0dq4YDUCRhLC/+oArtw+Go0p0sA8fpw6T5QxSvKNeVviJxXy/Q4ED1AYb+tIL8zydRYktbuW+wbyg9esrm3rVqHq+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209273; c=relaxed/simple;
	bh=QoOEcB7U1nX7E/IGV5XZZ/a6RXc4ycbMDNS+8NnSCUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrgJAGgs3SuxxvQLdHydY8Zqa0aKfHqaJuw7m2q1aYuY3X3qzZXN6nAQCx4m13+bA2LfNLJMSPt3ixph1lqoKbD7HKv/8Joec/J4YrNi1g9qbE33FQJPuAhjrE5rGk2H8vT9LzX7BMuGOiXQnfT0Fx4/kWWYxmdWCr6Ut0WQZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F66fhcGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F66fhcGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9F21F0089A;
	Thu, 24 Sep 2026 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209270;
	bh=DDNPDuXfIkAJFC7bxge7n1c8guhCNUh/bky02XmDud8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F66fhcGdw7j3InoSN6leoscVk2Abr+NJNJ8RkqhWHRKbLbcj1SClwMqRdbJ3Ds+53
	 29GNaTMr0qxSBx6WB/voeO5L5kWxLIJOZXQ83y7dxZ666dI9dVXBFQ/VsSXrLS6+Tr
	 dnUiRa2bUo/D4gG+Rx4CJFcv/S+NWLxerlhgwZ+uDWvI847vIWsxd0p133s2v30u/f
	 MfOCvr7E8dPkOyAEtRJrMRAysSRxubz1xn/2uQj10rgLZ8YySjDuiNGHJYMHaI/00w
	 xOlgnXmZ4nL4sxpf5VSpYyaUc3M0InXZgwqdR86+4XScJX213jn5XINLv5ooCwuYlQ
	 +nGIKFI4fVCDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.6.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Wed, 23 Sep 2026 20:20:54 -0400
Message-ID: <2026-09-23-daily-reply-0005-re-spi-zynqmp-gqspi-shutdown-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922140215.668385-1-itai.handler@gmail.com>
References: <20260922140215.668385-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ itai: context only - the platform_driver callback is still spelled
>   .remove_new in this tree, renamed back to .remove upstream by commit
>   494c3dc46776 ("spi: Switch back to struct platform_driver::remove()") ]

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
