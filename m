Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E632F765;
	Fri, 10 Jul 2026 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717414; cv=none; b=L2Kw8Z3rX0munePuq9XgA+hSjhWROoFobVvcAVPgNls4SW57/OLgsOqpcs4BuHwXIZ7ZC19iKYKb4pxxONPPjvUQCkDKaG5vuaIO2JErt7+ZWH35ZzOelVvLXiu94gSlZVIWVKDCunt5o3Jg4RYf94dDnm3CPm9/6Lr2onkz8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717414; c=relaxed/simple;
	bh=CkADtwdJpmG/vS/uZrLjC/j+8vbncjtmmFpejgqtU1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjIdlzOOHnxzFGF8PnWjBq5hrt9MXsTsXGum27LQMtTlbSEhVay0wpnkSOqK2C2m7a4rR+mkCSXPqKRf+NNReGWwYWkAWZZlxFNgoMDbWaCl9oE7HWpytkDHyY68m7pd5oHPeTtKflESRotcE4nFNHqLU4trF55j9flWamzH95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGuILRac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGuILRac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C201F00A3E;
	Fri, 10 Jul 2026 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717413;
	bh=cvDWPxsDpnJ/Xke/LJ565LR7Bobm8vcz5FQE0fe9EYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FGuILRac47Di2j1Q7cS2/q8Yag+hk2QHyJUqwMK+yeHLNFRd7QI6urFonDy+Fi9m2
	 fOJFJeJvq9Eg9TW7on9zR71hnV8oUjyso11wh8jBz8kqQ3Ta3Co8dpZy9kzJEXSSR1
	 F0QIv9lYalPT4YaibiGfmWVw10FvQX/8bSAHwPVGHMM0J/41KDyPPx90E12F+yn2sB
	 rkofHckKqOFwklpYBTgnMr/sWSIG4Tw6BX6e4fA8EuDAZFCbt/hDg3UVGNIPjsKsla
	 VDV9/ndTX1pyEZEojbnWBl5f7Qt1P8jYQm4Z5IShiVRkq2/hDW6OR9edLtcs9H81Iw
	 93dJEClFpFIQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6.18 0/4] Backport the one-arg k*alloc_obj() APIs
Date: Fri, 10 Jul 2026 17:03:06 -0400
Message-ID: <20260710163023.agent5-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709043301.142931-1-ebiggers@kernel.org>
References: <20260709043301.142931-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 12:32:57AM -0400, Eric Biggers wrote:
> After this is applied, dd015b566d50 and 696c030e1e34 will be clean
> cherry-picks, so please cherry-pick those afterwards.

Queued both fscrypt follow-ups for 6.18, thanks.

-- 
Thanks,
Sasha
