Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400702D46CE
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761211; cv=none; b=RIZ92WC9GFUpeqJv3lFtrxVHf6EbZfdFvV+yHjcmJo53T188XH8iMVtMzjZkt0quFlRzsmp1u50sojEQoffyxong+5l+Px9XAs4mwwIJblwjMGCsL7Ic82SCLMUS1LyO288o5Qa3iAOQoA/VByKFwMp4CiS7BiNQNsbbKN8S+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761211; c=relaxed/simple;
	bh=4aMPmZTXIe8qsVYIqO2/XPHQ2owtK9dl61xvPa8DqoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgT52244spW8rIKt3HgdCsmUIYg4NPQ0b1K5IvJMjBpCWNWoL9jtnnZideodVCWKBITms8bqUIHtrFadkkGSAafpRkCkEopgbZrYTWv+i2nyPh6bMs3YEv8Uzp3F+FZ2l9hc1NBpjMUKwASgqWZyGZ3cooGkIkXVcgUfq8MnTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgK8Bs6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgK8Bs6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E201F000E9;
	Sat, 15 Aug 2026 02:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761209;
	bh=XmqkWrZvug/weF9WTEPuMIAulXioKGc/DVoDdlNMm90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VgK8Bs6OExdNAXoSzfitBdlk6wllzVQ7TXwfzyTlj20IjmdVrNyjqQrkdr+BXUX1k
	 Z53+k2HbOP9+7I6ldVgSYJ02AKc8A9VAHjhyBCSQDlDJyBs67vRni4p2xOniMEJHip
	 TIXfKQyps+o24ABFzi6mxNtOuVSkkGDIdBJi0GZD6DywlV/N4ZgRT5j0oXbfdi3ncW
	 DMNSvma6qpFgR4JFCK6zwQuUZIGjlwuGp1fux/QVjqKvq0WSxdEgYxbw6uJ0dyvB/T
	 zEW6lp160N+5JO071llVkWoEKhQxudkmZlg7ic2tleWVoOEB/GCxei1G1HmH6nLsOH
	 mCeiiSrSok1jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	alifm@linux.ibm.com,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 6.18.y] KVM: s390: pci: Fix aisb calculation
Date: Fri, 14 Aug 2026 22:33:04 -0400
Message-ID: <20260814193000.4@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812203729.2422-1-alifm@linux.ibm.com>
References: <20260812203729.2422-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The current implementation of aisb calculation will erroneously index
> via an unsigned long * as well as multiply by 8B for every 64-bits in
> the offset; only one or the other is required.  This throws off aisb
> calculations once the number of devices exceeds 64, and can result
> in out-of-bounds access as well as failure to indicate summary bits
> associated with those devices in guests.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
