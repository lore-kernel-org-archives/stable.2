Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79E25A2A2;
	Tue,  8 Sep 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828846; cv=none; b=Vq4GgcBfGLGB8895GUok2TUIT/42vpgQ1GzMq0rrGbdFWxOZ1Irj3kcJIRHa1QFWgvHKvs0mvCHOXFxfqSVul705f59JylYcy0Z6/z7OdxpI+xthnUaHu3jmXHepK9SsiE6ngNK2mahpGTcmTOtMtRxolXtQdk71apC2YDwaYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828846; c=relaxed/simple;
	bh=vPBPdY5ZVzbOFIiOWz7tFlWubmBnhlbiLGaAUAm2L80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuwvwOx6iP6uN7ADoAEki/8ll5ZmE8oNMp/CSXzS4fBfTXpAZ3c5DBT6z4mtapwIfmx5oEguO80MOFpkDP6E+jKsWVEypUwT/9aSXloNnmB2D07XGOeus1wEcUWoL6DJhLehqDUUgGI8nNU3fWntGjJNKrOgfAzUIvS517clVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAltkNjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAltkNjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC031F00A3E;
	Tue,  8 Sep 2026 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828845;
	bh=8g3NwxpV/H4Drded0VobBO1yE0qmKUmxXk/527MjbVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAltkNjWBxQf3/PSyL+8ZQHAfKa7gzgWTlyPvr5NUkm2uNZ8+p2oV99RcJ7OpfD+C
	 t3tt1+XmyniDghzQurMKqK8eYai5C8iTjoqizgvdXWLwL6HpNYsr+kMgFesalNL10n
	 nfb9b3iM2Rc8xmKhfU/+RlgqQY+/TfK4SV6gg9jDiPgxoCy6u72xq644xXmnkzZGpi
	 bIk80t5+rHXyRLnLB1N9rltkrMCtRcGjmtgTKm2tbvYpLD2qDh1A7/mdfF0ofYcM2v
	 a8cuXvu2mNzMV4l6p5q7JYPJ16AKSeytwBm5fFjutxkZeARbxrWk0nLEjM3luJ5m2w
	 E/XC2Jh8TcShQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10/5.15/6.1 0/2] selinux: reject an unclaimed class value in security_get_classes()
Date: Mon,  7 Sep 2026 20:53:41 -0400
Message-ID: <2026-09-07-daily-reply-0002-selinux-classes@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907144009.162239-1-alexevgmart@gmail.com>
References: <20260907144009.162239-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Backport fix for CVE-2026-80912.
>
> Bryam Vargas (1):
>   selinux: reject an unclaimed class value in security_get_classes()
>
> Christian Göttsche (1):
>   selinux: avoid implicit conversions in services code

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
