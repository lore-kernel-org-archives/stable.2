Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46D2F25F3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622416; cv=none; b=deart65xG1gKrUnllTRShPjpwjPDKSTd77JX6fuqM7/aaQ892JnMpNynVAXGK8NSf9MpA9DcTLTEJki0kKi0ELVbtaky8tppT9HsWWlOXimCPFVI7Pqn7PWK48AVpCwTQgPZV4HOVo0na8pZbc7XmSjWP5jPOaEQqz65HkCUMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622416; c=relaxed/simple;
	bh=umyleUEIa0v1sjkcgI4TuD35xLJwZ55JoBRCgVQ3L9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KktmDmKprY8mD1M89VBqoCRnCDKBA9CHsTQkYdWz5u5fw/vOlivtzleuKbYizpDiPDslK2evGPJeSrmbsJfgLd+9hXGY1BLXT/bl+cK4gfzxvutTeFCZkEvJe7CsWc59dgvd/NaoePFfjSIF3mIVemZ2TZRX/xY1VJ5RH9tVges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgXYzErb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgXYzErb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246541F00ACA;
	Sat,  1 Aug 2026 22:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785622414;
	bh=R3WHQj6DY+cFKSTFBrEb0ERahrQXREu8OZ2YzjlWECk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cgXYzErbd/K3jsB/r0C81YMXEjAWEp8+FDREZYUY+m/+Xi4oPf50BmuUGVEzY9ift
	 cA7353tv2I2cVPSDC29tNY0BQQfCD2sKswDQVdq06Shx8n8h82nIbAMyAi4EWPbUam
	 sA8Ou9TWhduXbtWQjs9+PKz1s/m+lyEMHdUMjFGXCfXf/nGQmrDXkS9TKAQAHgEHTZ
	 IY3sKpxiH+o1bAPIFz8JXNFYtqNStyvL9IUrNF3UHgJMNshgo/NXujwcdj3l2Ni3Nr
	 6fOUZ/CSVaRen39RWIp7cbfeS5wWgjQELRz3MmyUxdgbYhgWX3ye6y3QDm7JQdL2zM
	 nM3g0A6MLDMdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eddie Phillips <eddiephillips@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] gve: fix Rx queue stall on alloc failure
Date: Sat,  1 Aug 2026 18:13:25 -0400
Message-ID: <20260801154223.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731054337.2437935-1-eddiephillips@google.com>
References: <20260731054337.2437935-1-eddiephillips@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 10:43:37PM -0700, Eddie Phillips wrote:
> When the system is under extreme memory pressure, page allocations can
> fail during the Rx buffer refill loop. If the number of buffers posted
> to hardware falls below a critical low threshold and the refill loop
> exits due to allocation failures, the queue can stall

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
