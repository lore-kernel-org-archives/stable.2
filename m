Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2EF30D3F8;
	Mon,  3 Aug 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788053; cv=none; b=aSBGsCS5OXR9WPVmUNFhcV2grmXP/p5lLzsDhPTnCTYYgUFZN8CDp2fDlinNH27B8TEzTzMi3Jhmg0Xo1BqPxbyvS0i+rNR1OgRgdIHlM8atzlnWE+Y5WpkagP8v57CPgjRkBcmXDJJH4Fgm5drg64/kX0KFNMvoot7gTlpvtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788053; c=relaxed/simple;
	bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JOSGJNdzMnKYbFpxNrUAgNx5mYJLMQJCr855artn8Qeur7VLqQ0l6LWZ4BDE3SDlLckIq4VVYu5ed6AIVKzMw3m76S/67z9pH8Gp1dhY/1CDX7bmFMHBBKil00lEJ6q8aKZrCS2Ezbz0zz5tacJTyQ2zGFU5LYm5jws/UH/RK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxpOVwNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxpOVwNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212EA1F000E9;
	Mon,  3 Aug 2026 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788052;
	bh=w6luQyQlp43q7xRA222IbS8aYyAU4c2NFpr+h+0SaJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oxpOVwNdnbilZTXRhU41zkfeWnFRJLI2Z+UVayba7toPyCunjRFkOjkHF3XBcjMx2
	 c/C/fshCbS+cdf3/rcjfHxJC6nh+TU56w5slrdQmgtc3Nrg9GTn+CnaymypcPiElCp
	 IzGzQ4HBjroWsLHl7wKV00RyWBlONP75i/urrAGK0teL3CA25aS8/rkAyL3iV4RRPF
	 rDBDMJElbNyXmmr2ng6Su2mROcSELF0JvDMeJQ9PIEO0tRtJgibM8yPV5OKxavqQ2d
	 JDzRnU3nAVkNIiWtqC1SVCmBZErYpzjR1rk5F0aG5rzz6fpwkgklOR7KEfTCTDildh
	 GCou1wP/ULSeA==
Date: Mon, 3 Aug 2026 22:14:10 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: uclogic: fix use-after-free of inrange_timer on
 remove
In-Reply-To: <20260714173946.73773-1-security@auditcode.ai>
Message-ID: <7n3s832n-qs80-61s8-7854-ns14ro339860@xreary.bet>
References: <20260713121042.2321-1-security@auditcode.ai> <20260714173946.73773-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

