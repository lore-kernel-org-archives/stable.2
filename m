Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537219;
	b=TpFyy6rHpzuqowxryKCEeq1o6CrFYD4jOoUZl/lKwycyUn7epzG2enPrlkqLFxO19elg
	 j0XsUP/kAwp3bBk7ngX3TG+hESIfO0ydY9jstQ8xyLZO23631XfA9Nsfj1wTr9By8idTu
	 gbArVv0CyVMCT7EX6eYoMInCUjOE9Av7mI+PMMOcs52xcRJH3L3bZ/F2rk0VjGLWe22WS
	 TqizQPHvqfaYl8Z1jtahodmBw9LhNtr7QYgrvD0IaPwpep6oGvyuJgoOvlHpRw/W0KKvv
	 mooC9eFuoqiTJOwX5C1fq8S3swbfzmboHMPLl65PwMTs5m+zweP2iBkVtn5rJrZcPjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537219;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oYaI1wzl4Jn4ACZRi4Lr/BnCKRGqy7egSChZAAaO+v0=;
	b=VzQUghIFs3nvh9tNhrFaydLH2bI4KxR5zsW7+mA8/WddujQYCz9hNjPiuTXr+1A+pit2
	 OTBzyGrN2F5ZR8jKTo8pfx9czQTdAcTvavPchYSQBJFy5d9fS1UzLDoq5/c0rO4yfT5fQ
	 v2b9zcK8BI318KSQ3tfzINcjMLiznXzGYb9gQz3J4V4DL4pMUdc9p0zLJsKoj+f6zBqpB
	 s0Hy3yGaZCl+VMo48P1zUh2Jd2pEEDpUmZ3knLAAba59OFLVJNmBL018Hp0X41WR6jdJv
	 UIC3VhdFlD86A7Ap/qqWv+0EB7+N7UfvSvsj6xUrTG6FJmMVtOi/v49pERpYZWrIdAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlUjkAvT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776ED606A339
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlUjkAvT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA99C1F000C7;
	Fri, 13 Nov 2026 02:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537219;
	bh=oYaI1wzl4Jn4ACZRi4Lr/BnCKRGqy7egSChZAAaO+v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RlUjkAvTmoz4gyTkmzryN0UBL571bvFD34+h4jUEXUUp5/Df5ehX2BrXqcLpjUGNW
	 Pb/FI+XqrWWNYZZN0l6DEk/o/xxfQQdY8Eug0lCNWvdoOz41YAk2EJfcZvNhuY/mOw
	 cxbvMmfalTK5o0/8WQqT6tbePwZhRG5ilsoveRvrfL4F5dJWWLroMTz2GXOM1G+cr6
	 KdqJsV1KADcOYtkmXgiKQ8FCZPASGYk7z97A8hnXdr6yBY55pL66tEUg57bVUOV+B7
	 Cgw//Ew3LBG8okUZpLuEv/hP/mINs6rrZljpfqxm3S2X7ntbDQlslmiWWueudxU8Dy
	 8ghXfCyxcrecQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 6.1.y] alpha: load the MMU context when switch_mm() switches the current task
Date: Thu, 12 Nov 2026 21:33:19 -0500
Message-ID: <daily-reply-2026-11-12-5021143861@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111175851.1156045-1-linmag7@gmail.com>
References: <20261111175851.1156045-1-linmag7@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-11, Magnus Lindholm wrote:
> [PATCH 6.1.y] alpha: load the MMU context when switch_mm() switches the current task
> The 6.1.y header still contains ev4_switch_mm().  Retain it, and omit the
> unrelated do_page_fault() declaration move.  Of the direct callers
> described below, only kthread_use_mm() is present in this tree.

Queued for 6.1, thanks.


-- 
Thanks,
Sasha
