Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C440D599
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842039; cv=none; b=ffFzQyBmkdv8hPthdaxe6gtcFFb83Q+7aNsEXOLqMpD6jnDlW7ber52MRxJmbToAifx0r3dZQlsWwRZ3Zhria7x0hK1q3ZqyCisrTazKpWlsVXVPtAVkrXeDZnf8OFoxUFEgFJnUCgfpMVNPH4OAnFbDSjiEvAChsBrHbfYQZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842039; c=relaxed/simple;
	bh=BXSPdudlS4WnLgOhjQnYcVJNZqaBiXUCW2s/4STNqkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/naLBPcQeYsil00ryHZ2H15dXWVz9a9mJq+9bf32l3waXk3n/ucCV4gBNw6yD2w8NsCKFgouv4FQgGcAHxNcXX+eMeGY02ELb5dHMMl8V0IS5FbklgzTK1iNx6F5dXWfdvlU3+Riz/fqoc4HkGpLq7NjGguN1e2bfIE9Er6aD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCu0oCEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCu0oCEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123581F00A3E;
	Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842038;
	bh=s7IBShgqv+XaBJCZtdJmc2bA/P74GFrk0RTJVAU6X2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MCu0oCEcEO3OBaAdNe8RmxG3ka404tSw0O9toNRvDRFIpG4L1eRqgCBcPGaSbaC7h
	 OnSQN7fpd9aV6s8qcyEJpXtTQktspk7D/3y2JUrV73AfPAw1lYp2Yjvs9DeRIXN54+
	 Te0fPG6x6wyZbAaUEqHpRZwtkf+h9ci1YdV20oI0FMVoURur7XehbxnsTrpHTUDvsf
	 TdcIZvjwfl2bsPIgiB88FjVu0vcugFzibS1aLz9PunyrJQ7jvKTEMYbvAuEtQfmO/r
	 udO2WaytaiuEgR0WbAq7kwdXJHLkHENX+6M1j0IMKwu3dI3uE9CyJNrCufm/uL6z3k
	 mmSMxuRyH93pg==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Han Guidong <2045gemini@gmail.com>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.6.y] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 19 Jun 2026 00:07:01 -0400
Message-ID: <20260618-reply-item022-pedit-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617141034.1441139-1-guanwentao@uniontech.com>
References: <20260617141034.1441139-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH 6.6.y] net/sched: fix pedit partial COW leading to page cache
>  corruption

Queued for 6.6, thanks.

--
Thanks,
Sasha
