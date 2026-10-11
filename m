Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61935AC31;
	Sun, 11 Oct 2026 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737315; cv=none; b=hvxCdePJu6Dle+WwF9ia+Kewlig1/Za3eBT9ckQ7t3aLIaiyQzIC6VV9ibrsV4yIK2NnpAznfUUrbuZvSGRMSqNZC36ZUP6mgwTNka1gf4Ai+fLv2trDWs8duU7pq4EVResEBwruhDKeqHlNb4ooTKQAy3UvcpAczpV9PDVIgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737315; c=relaxed/simple;
	bh=xIxl2ipfYbjGP9L68hP0lbJdJgGd3KEBosg3MuEa2lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC6rjs+8tflOs5bpx4q4JuLnaw+hANtBtbDTs9CzDqyoRn71TOHicDithZvQoD+1W0ytkfQK/gZM21NcfavdFfi9yXu4o68h1uoAy8sAWoK66joIJEHn/Wt6Lz00V7TdiYdpAFujrFOQ2XH2V1IJfYWYXN8mym07RNQRLTbH1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPvTX9Pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPvTX9Pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7B11F0089C;
	Sun, 11 Oct 2026 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737314;
	bh=kWL+cF37anyqGVMJ5CfLLjHnWkZtkGc8OHzHlGc+F28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPvTX9Pnj9CBSvYEmU79+aRCE+UFuiueLFBN4I7WLMhi1Y2fPLxEcOnNp2oZ3+Kna
	 6QcslMwJGWv0X7C2Sr+KQ+98VEc5i4+vcXbUuMvPbZQMA6nf1KF+CgR3SFUNuarUML
	 uGFvZ0HO9KE3Wjq1g+xcTjstjnFXByUo9SixXGMXexizq83gFARAKEiOYoZss29d14
	 vUfkpHG7EQklnJieAq6qiqr0hLpll/3Rdv5FsqGRVHX13EdbX7N1/A31TCPidsPDvc
	 4ByFfLaSMGfr4RnAuVtRbAhBIgEHBYnTkALh9XF5H3CHOBN/yE4UwzgP0lQ1euQk97
	 NuRV8ClTPN34w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	netdev@vger.kernel.org,
	Anton Danilov <littlesmilingcloud@gmail.com>
Subject: Re: [PATCH 6.12.y 0/4] tools: ynl: fix spec validation in 6.12.y
Date: Sun, 11 Oct 2026 12:48:11 -0400
Message-ID: <2026-10-11-1-daily-reply-0004-ynl-spec-validation-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010035116.578385-1-littlesmilingcloud@gmail.com>
References: <20261010035116.578385-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Two 6.12.y backports added YNL spec features that the 6.12.y YNL tools
> do not support:

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
