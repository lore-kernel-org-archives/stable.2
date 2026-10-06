Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF33C8C52;
	Tue,  6 Oct 2026 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322573; cv=none; b=bq/bowb2M0Q9KxFuOCK65mPpN7/O2hd6NAEOi7BbcbjXauM3rwbebuxpp6RZbn68sbC2BhCU5ae/2wyBPBrOGqi8mR3Lp9IJHPw1kVL7yguXVaMfzhlD/oB/aMoMZ2k1RQ0O9aCYr0l6zG2lJt3tnl4VYN1iXsGxfZZa5WkWfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322573; c=relaxed/simple;
	bh=yV8LcO40XqvfmQo78vpd9FXsWIBswBPSM4SW+g+3jgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAKHXGNQAGmhAl667iJzX6gWWlHqFaU6DXIH0Uc2mjoRsoJeMNPpGbBa+H9u58YH4PVgeKTO6mDllYVSS8uIeFctF8xpJlDdNC7jojpx9C81vvWb4BiOIGXuGsppR6bjOPyHIXaf6eRennIlwrRTP9vPdailX07gkagQ/IML1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm2AcUQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm2AcUQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00D01F0089C;
	Tue,  6 Oct 2026 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322571;
	bh=55tZ3ZAWruuprhfDSxhlW+wz2rwLoFL4hmHyesvWHzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vm2AcUQajf3LQHP7ciR3mIdWOrrhc+uLBYjpdU2Pu7tAaf8mA751dBx8jk38rtlWX
	 Gw47T4Y8h127GkxR1yCoOzH7qwvXh6mjqzWnEelN0zaDPXgsT/TGVPmdhJHgrbgJ/q
	 um7d81xAI5eYlcFUix648haSDeu2WVT9DC8D3NHPB0WQg3NPeGPzIz/xSQWl0OFxVE
	 hwcDJ4s34P7NXzPxN6wjfl6euT/9mfCOPJ0vFWF7JfTNbZfow7IihjZOPcOP4D0/OL
	 q+rYgM1b0K6vFG6v2Ws5tSXTazrlF+sGkagAjgv8ACKE4CJktZ3pzKb2ot0M99gVh4
	 mqrC5R/YJE1ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	John Fastabend <john.r.fastabend@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
Date: Tue,  6 Oct 2026 17:35:36 -0400
Message-ID: <2026-10-06-1-daily-reply-0004-cls-u32-bind-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
References: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 9cb36faedeafb9720ac236aeae2ea57091d90a09 ]
>
> When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
> operation done at u32_set_parms.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
