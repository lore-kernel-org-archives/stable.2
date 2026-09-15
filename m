Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41D3CCFAF
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437825; cv=none; b=Wnv2ASz+c1ZMUnx3iYVX8J4fFyy2waaVGz7zuMPi4FzT3JQKgWRBaXYyE5Z9fMj9d3+AVCTe9ZIPxHn/Jfa/kZPEKdnvRSELpSpNHRP6COE4CVTQ+62xZlGyQ9GPnTH9oDI658Jayg2H6rVqw6AF85yjucM9GhkV8N+O56jxZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437825; c=relaxed/simple;
	bh=QYENcU15IoGy2Pztz/OWOhTlH0U5HKaG19XNehQpPgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tryh16IOH1sUfILKDwTfZhWwGHBcN45u9c4hM5KO01E2MD1GJo+Uv4z+kUx6QIupbogZdPR7MLAXr7WDwpS4dS/URX5P3M1TewRTj8arx1ZEba9AJb96Rp/cTiRJ054WqtloCUmXA1FHYgbuW8n69qQMJMtPM58lH41c2K+0Wgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIZaa6ON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIZaa6ON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E397B1F000FF;
	Tue, 15 Sep 2026 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437824;
	bh=ls5S5uzCCxEpZqmfX7qcpvQXG7BnUgseqFa6gIuPnpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UIZaa6ONrf/Mw4FcDAEIDpK3XNkZwsGSdXUgyDXlvXtqobR8RvAkAxtca/Upa2ANs
	 Szf1BbSo4/ipT2M3EH+hURkiksrhUJovdR6SR+8yGU7Ac0Onbdw5TdT6ecBOnWsuSK
	 mZmL53eLbEGCIN+27fGTyQfQjmMFxTuK2s/BjU6KB69woBFQkhGPQIiMqgm/53pyWB
	 i4ifXgUvu9fhUxCEQGCDDQeia7Dv/IzaSULkALfF2EI0Am2QA6X0Q1ldTxDZzbq9wv
	 Lu1UTwR42jGVX0D22OjwTjuTOBqTQfLZLz3XqVkwyyjMq0t+7yEKB7Nt1ZliX8yCZm
	 rTV7cfuKqemew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH 6.18.y 1/2] drm/ttm: Tidy usage of local variables a little bit
Date: Mon, 14 Sep 2026 22:03:21 -0400
Message-ID: <daily-reply-0005-re-ttm-bo-resource-uaf-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aqW40lwCEnQ8NuPH@quatroqueijos.cascardo.eti.br>
References: <aqW40lwCEnQ8NuPH@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You need to apply 91d7e9df4259 ("drm/ttm: Fix bo resource use-after-free")
> too, otherwise this introduces a UAF.

Agreed, and thanks for catching it. 91d7e9df4259 ("drm/ttm: Fix bo resource
use-after-free") fixes c06da4b3573a ("drm/ttm: Tidy usage of local variables a
little bit"), which is not in 6.18.y yet, so it has nothing to apply against
today. I will take it together with the series rather than on its own, so the
two land in the same release.

-- 
Thanks,
Sasha
