Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04489390C89
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956504; cv=none; b=RolWFioANjIXG0els95N79oIgHGVuUNd9niJxXVkw53khIJ1d9tiedk6fJ7uby0MM5bSpL9IYlWYp7UaURYef3vuOw9qsqH7CXQAvsB/kUo8EljM5yOMpeANbYNnSDyoizjNslSaW4xuyVztxG2DDK/Q9OpaUAmM31X70fbbbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956504; c=relaxed/simple;
	bh=EaYi1um3X+IzXwyqK3BP2XZ5W2Wln6zJSk1+9nZnhnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufwlCnEpJ/2Jd8Tt6aIdmNBxExlgyFaEUORmW9OC91PiIiaAa0jGYTbacoKinfOdRX2pnwVCFpwg+h0RHg/OLeWXQ3hdO2BpANBZhQiyRMFWgkplbPryqEcV8CNNlqPcMImOhzSi6EQZbxwRxIFPe7HJXzkxgTYb/Rr//BPUEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Vxz9vf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Vxz9vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85BB1F000E9;
	Sat, 20 Jun 2026 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956503;
	bh=VtBAO3gZho7FYzOK7qMZXYfn8FMVRriFtcopUNr/VH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/Vxz9vfAgpTUjRf+uyMn6HZqdKsi5YxGFN0fWUFpo8WPD4bSGpmNRg8NhqDy9eqj
	 D95NLw3JGZqpkEemYILaVFvZWNhKC+Qt7ZshVnvze2uhDzzSn2+31X2x/FGT8tPscY
	 GfFqnBOqxRCCa6MAvP6gRRrtsOlI3nx0UJgw01QplRh8x6/n5EjlKp9oE0Z/6HGy9P
	 mtmg693F1kM/Jb8PE49BA1zSiHQpsSTiRtHfZNSbyVH1qUSOAs7hcG3ism1db00fKR
	 Zkd51dCHYMl7a4C0QsxMKt2lUCUP0h5z/2KJO5jHWN20+StqHQKmOHtGujM592qO0D
	 7vBV+kG16pFiA==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Please backport d289d5307762 ("ip6_vti: set netns_immutable on the fallback device.") to 6.6.y and older
Date: Sat, 20 Jun 2026 07:54:52 -0400
Message-ID: <20260619.0001.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ajODI0ViiySkNjK5@eldamar.lan>
References: <ajODI0ViiySkNjK5@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport d289d5307762 ("ip6_vti: set netns_immutable on the fallback device.") to 6.6.y and older

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
