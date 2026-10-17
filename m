Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46333F36D;
	Sat, 17 Oct 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206047; cv=none; b=Bu0vDKTcx4saWl4SJvn5L1BHILqPXR44I0YDUjlOiZoPB4YAwF2xvP9I6IHDgalY0rxPU5/ikXk8tXLCUnXtlllutXVk50UKxppGF1H29BMkvuMOHwSt95xPcoYiLsVNt05/K+pvni1oK/ol1F0EALy5saMaLYUS70uB+O1cy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206047; c=relaxed/simple;
	bh=9DgN8JSScJoKsXAkC7cE8YGy7xYbjpdwhIUrSOIstIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5GtH74r/Sedi0iQXiyeiPzx+znZSX9rw1Kd6bTmtc30lb5BvHaBkrobs2BtqC8Yzn7PsyIy4+ugDXTLWsQkICXumYEP1eJiMXL5qCFH71ezbW/8fapaZsXy2SpSGZAGQcQ0aiMecQ5jyfG/Mn4eS7RZigfJ7XXMuPfAe0t372A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHUEdf16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHUEdf16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DF21F000C4;
	Sat, 17 Oct 2026 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206041;
	bh=A1ZM7cy2IxVTAOmtE27CyXR2LkV0RVLLMmxN/Rzvr5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jHUEdf16HMvyrXcXsxhz4/eZwq9JldPSyLERGp2uc+wyxiHb86zKf/dCv3tIPQCq9
	 /juyQVjor8NkxuPQ5d1Ds9z7SQYnphuGpcX5cV5dHbZspKMpDjchxdlnO8RQmwnPEb
	 iwh5m/k/g0UkQnUCytCXIPnrgfjGJkfjO52B912zYJl8ELvenogj8q+CDBAgPjzZ9A
	 7mt6lln6Em305jl0de95WHsgydAyQGIJYrizWFPatnZCWm8iKGfw0HVFCn5nUvHbXi
	 Te/Y2V8dO5FiSd6aWLIQXa6ugm0kkmUUPXE2L4ZicRDEGDEihSq1cnphCNkLqil64r
	 XA7pOg3Jc1ApQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y 2/2] bpf: abort verification if env->cur_state->loop_entry != NULL
Date: Fri, 16 Oct 2026 23:00:18 -0400
Message-ID: <2026-10-16-1-daily-reply-0013-bpf-loop-entry-abort-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016022011.16938-3-artem@trailofbits.com>
References: <20261016022011.16938-3-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider this backport of the corrective follow-up for
> CVE-2025-38060 to 6.6.y.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
