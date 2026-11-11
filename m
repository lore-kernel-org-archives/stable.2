Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434119;
	b=fcKwpwlNUnPhIynOH8bTBoHY2P9gtrqig//d6Cli0ToU4WHCRuQAJI4ph8ie9rBu0wCe
	 tkHUVrzYzbfBA0QNRHw1Y7YwVtgNICyeVbYsowc4JzoXKTRNLDapJ9qL4/1pdhhWIjEo3
	 dGt1PKl/YySJuOkILYVu/NzbmOxA7wKC+3NuzHV6FVEqm1MOi/zlB0yfsmKoy1Om6BEqQ
	 UNdAkrSBf1Gv8wJeUiRObgz25C1yMuxlSeW9wKhE16aKN0FCTkKA5Klo3eqyMXZuMouo3
	 lpw1WWbK9jkJMecO3YC8pS9uog9+wBVd4ixsmzAz0d1ZvVKz/aPJv0fR4LYtOvfqKQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BToJBpDkiIvt57/BnvMAQxBBrSDbteHk3B2fWX+Ur6E=;
	b=cwcWKvM7SlAX8G3Wt/LWuO5Ctz2Vm57JXOsd3AZ1a6DjIHrYxY92C2XWDvJKK7gqG0fk
	 gGVe3VRXs5TKMKg6g4b2Kwfb1Vrs5wulZxeUNSxqG1mFbh8h7L5DdzeOAv2UQbFNmbGAv
	 Me0kqz+ldRFBVlGTUO+gcS9sCbAbJO3P/ZPtyn3pg5KWHVyGEDf4pezHJ1WnWaXX1oL01
	 dOqg6ZM4vaGFT4Zg6griXG56jdG4K3BwYsxYLQpCRHJd7gQmh08KpJq8XbwFRB3vrJWfv
	 JFoblfmYkPeBbCWEktkXfG8a5Z18mtigyFPmzZn3EVywMwELa5Bza3QFTC/jhfsXZ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPWz0E0W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416A606A8BA
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPWz0E0W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA24A1F00A05;
	Wed, 11 Nov 2026 21:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434119;
	bh=BToJBpDkiIvt57/BnvMAQxBBrSDbteHk3B2fWX+Ur6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DPWz0E0WH9VPyYmimwZwLny52BSRDGQC2VyWXyHEG7iJ1H+ttz1m/fe6/L7xbQqbH
	 fpdIoc1oABW0chiAYLj2Z/ADCvtP/6mnm8o7SmoaRUFkL0KELnelBAUuxJIHMX+3mH
	 afm1j9jyFf2/HiJCGi9CDfIfPbwu8N2QwRxkmO7KTGF95tvXXXYHGDbA43JAWZ5zXF
	 i/HeBWfHvnWvsdV44LQSLRLiwtr/IJHKH1G/sZk9fakBj0BBWFVgusv70tKUF29z+c
	 JmAJjecz5kKritkidqLzxJsgZ7N3A+qS/yyDNj8EwAbCSlDt95sq6bZJef57gDks+k
	 0iBx7v6IV4lJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.12.y v3] apparmor: check accept index + 1 is in bounds
Date: Wed, 11 Nov 2026 16:54:55 -0500
Message-ID: <2026-11-11-1-daily-reply-0022-8bed080b3d441daa9cfe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111063857.496598-1-zhugl3@xiaopeng.com>
References: <20261111063857.496598-1-zhugl3@xiaopeng.com>
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

> [PATCH 6.12.y v3] apparmor: check accept index + 1 is in bounds
This regresses profiles that have no separate file dfa. In that case
unpack_profile() aliases rules->file to rules->policy, and the policy pdb is
compat-mapped with size == state_count and accept[state] == state. The new
'index + 1 < size' check then fails for its last state and the profile is
rejected at load with -EPROTO. Such profiles load today. Upstream only bounds
entries with ACCEPT_FLAG_OWNER, so it does not hit this. Both 6.12 and 6.6 are
affected.

Could you send a v4 that passes 'rules->file != rules->policy' as the pair
argument for the file dfa call?

-- 
Thanks,
Sasha
