Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903965;
	b=Tf5sc0ruMQ0V/fxOoJciqaPjFZlOk3n9TBAcEQ6bJqxK1ahDSaawXiTiMh9FwEaWiHnw
	 t2c3zhoSz76vrUjAxkQtvi3mvaJz7AMHPxg6GYC6UK621+1AnhV0WZ2bRxc8XwCl2wNXa
	 3M6TQszbP7jN7gwxrqdMMrnT/VhCVxkh/XaCHgxgaaN4PtAUQYt7mmYXomaRdodNBgGYd
	 nE+ABPU92PCCVY4DhnNqb8jc4tejnXaD6VeHjHUxJtwcJIskkj9UxcF+Zf0hFzka+mFKV
	 eOwlS+HJxJcqpk9mqeLg2YxJbbo2LfQmbd22mnPyvrAy12dfXSGY1DoI7ntNTydAIWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903965;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wragGrwQxC+TQeOmbPLCA0Gtd+1RHeh0AwjP3byAHzc=;
	b=4jXKaB2EK95dQGY7HEZJD9Y7t6aG0cym6+IoG5CfrryV0zqpXBSZkcUv/e+8i08xmOZc
	 iVekMpCCXpiVuuCUY1qcUqVAaz3R0cN1q59lTYIxcOZfV9iKgJKenPuVNNyrcfkuJgkLr
	 0+CTub+tUfB+Cf5MXdDidNSVtfIMuB5eIQJDp6GgtXoEn2vRGCJoZBpP+ED4+WM9b0H/z
	 jGmMHYYhnwTxXEMWK69a8Pc6M1wEdFVmlDOIwUBU/AlW4et8XZXjYrcWeKrWyFR2tqHo5
	 fo83k4bpaEuVMhvucattDsp6cPBMR1eF2aO8UUfzgLIlivJkr0DAoR1+vFSayawoXZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvdLGrXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15675606A330
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvdLGrXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6F61F0093A;
	Thu,  5 Nov 2026 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903964;
	bh=wragGrwQxC+TQeOmbPLCA0Gtd+1RHeh0AwjP3byAHzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RvdLGrXa+NjiOPo6Vah1wFoUFpyhi2Mdbzw27rFy+YVF+aDqBOMQth+1EV/bLudlK
	 yhtApaXEtjHLPhGyM0+HKCPqElIyS19PcaoZZ/Vca13t9kiCr0xnd+DH+A/LGf1OV0
	 UEKZs19OYtumVjKiVlhFy3Qv1tNLBgMr1eb4PFa/YCUvfS3r/jmoYoIf4W+AuL06vA
	 MD3ESEUt5JGisU8FaSm7uknSyB2c/KHTYwlxO5a7xzzrHB/6zeQL2sbmF7UFukT6SB
	 43+AhzyuShxKmS1w90FspQByRAUwQ9rf+ZnZ3kBUXCOLryIW7psJSfbCgxx3kwmPT1
	 C1weBc0+2LzOw==
From: Sasha Levin <sashal@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 6.1.y] ovl: use the pinned upper dir in ovl_fix_origin()
Date: Thu,  5 Nov 2026 13:39:09 -0500
Message-ID: <2026-11-05-1-daily-reply-0004-ovl-fix-origin@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOQ4uxgX7BShwXD31adtqA=mwuah2vrZ2ut-YqWZLOFJb=wESg@mail.gmail.com>
References: <2026110427-yam-conjoined-4ce6@gregkh> <20261105034400.1253169-1-sashal@kernel.org> <CAOQ4uxgX7BShwXD31adtqA=mwuah2vrZ2ut-YqWZLOFJb=wESg@mail.gmail.com>
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

> Anyway, this version also strays from 6.6 version which I asked Greg
> to apply to 6.1

Agreed. I took your 6.6 pair for 6.1 instead of my versions.

-- 
Thanks,
Sasha
