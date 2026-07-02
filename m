Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36323EA84;
	Thu,  2 Jul 2026 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952738; cv=none; b=ffHJfhjFCSqzcxtqaCjq0vXS/t1Qr5DK8syPO75/UvI39lTfC/oEGIVL8/uRIpkLpK0IkkGvONOr4II3ZXafzZ82pueFKFpHJqYpFyB3Nr+DZM9CnUdvtlZplX+L3saHcXIwFuz8R9RPJbYVat/cUJ1+AmUw6R8EpLeSwmKf3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952738; c=relaxed/simple;
	bh=XpVtySHffmliPkbplhdQWuR3F1r9v/PsDoCVuVnx8Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGnXI2dDeHbnGufLtxtCNr7rC/ALZsinAiLSZr/Dl7akICqhWB5smhF2XOkv+Ri9lS/h7qWnYbNXl9K3Q6D58YruOZpVQBx6LY1vBGWg5mtHPOplL3m9MppmL7O6+g+9Yret2sslcwDbxQeWLrcbg8GTBWsfH8Yxeux4cHahQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlZcp5LD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlZcp5LD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEEC1F000E9;
	Thu,  2 Jul 2026 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952735;
	bh=Ik70JGL/KUEmdnFaSVDz6rNF8Zghre5it8AqKqb1vHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mlZcp5LDIRve2h0cfG3rsftjVutaViINODAu22z/KAUbNW6PKGKksgLnxWCxaKjZf
	 9rfZWVPTSjLzM5KbQZ+kDOpdZkrzafVzPm/bxjRqeLHMsmlCEFVCX0NHMNPW18mCX2
	 ba8mCERN7errdz/vIuOi3wz9Q4henh1+s3flR9Z2nsZ2txX+bGkT2sdcCNilUxKJuo
	 0k1kT6zOTmSzwHHUpQfTKcQJu7MfbZAh4IrFIArEV4eQBV2fEWlk3byjuUji25UFY+
	 2Vh/W53KhfyKaB6Om7uhDHRIHkEojicpbhC6qpZeLLAiXWl5ME1sLRxrSEeRHAfNNh
	 0v+vnUUfKnv3w==
From: Sasha Levin <sashal@kernel.org>
To: dominique.martinet@atmark-techno.com,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Han Guidong <2045gemini@gmail.com>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH 5.10.y] net/sched: fix pedit partial COW leading to page cache corruption
Date: Wed,  1 Jul 2026 20:38:34 -0400
Message-ID: <stable-reply-pedit-cow-510-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630-cve-2026-46331-v1-2-c1986f356f26@atmark-techno.com>
References: <20260630-cve-2026-46331-v1-2-c1986f356f26@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Dominique: plenty of context conflict but the code itself could still
> mostly be used]

Thanks! However, the same upstream fix (899ee91156e5) is already queued for
5.10.y via Wentao Guan's backport, which brings in the act_pedit
RCU/percpu-stats prerequisites first and then applies the fix nearly
verbatim.

-- 
Thanks,
Sasha
