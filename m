Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CB175A76
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786245924; cv=none; b=dfIONXbtS0MLljrKvVjuWE6GhV+cmbk1iVHKWy3zzRgHTpZj/CPpdqXSw19EuhNUPjAhcipp5Cz0/suO7Mw9SN7FLXAz81oq+roVtU4yinzwdV4C+Ynd4l4zE+xuPQkQCy/aDBOLw+l8aP049hYks2aAYN3bsFDTOKQwTHCp8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786245924; c=relaxed/simple;
	bh=MhQFpc2Y3JigvuuPXWKnpvLt3yRLdM9KIFHAC4C+ak4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alc+axNO83iFcXlSzJAH8EqNYuM+raNe1QbOO3FO41FqEkHI/G7HkEu0GnIUt6dSABO9HQJR5EFAPI5lPCSf9rOkI77ynJlqMKMgipi/kTYHd6TZJZFyZaWj2p1x+nEFp7X5F/ks4BGMkegsNPRscQz86kQvB9o6yMy0tOvesJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1mw3HKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1mw3HKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C5C1F00A3A;
	Sun,  9 Aug 2026 03:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786245923;
	bh=UoIxmzVP97V0nOJqFHeOvHNHDBzN3xJHIKW5UtgVcsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f1mw3HKpwUW4XsKQ2D1P2fZuXia4sQkuH0vswqDHS4LkQPhPi84s/fFrjNOjxABbo
	 d8jdeJSLt2cFvJKKuYeDZdS/+pgd6JMCaW5DZE+70X9gT+/ErlyDNfjQ+r+EEYbTj/
	 i/R03sJPpEuUN7yvfdMwEDN6s4yjz8mBuX64l0fqhqX3LiowMMSUBVDImPntmR4w2b
	 JLkEr/SgJibImfH5Yl9IGa55p3dMIizBZhRak9azIhQ3nJVw/PyHBzlc307xm412l8
	 3V2sKIXfkwseatPB/c3hwMfkaM8U+tZrztI4FgMwjj5ahuiK/oQLSKb0hcL2SaSJTn
	 OQzQ6MMIrGmnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH 6.18.y] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Sat,  8 Aug 2026 23:25:16 -0400
Message-ID: <20260808221923.stable-0002-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807192218.3563-1-alifm@linux.ibm.com>
References: <20260807192218.3563-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 07, 2026 at 12:22:18PM -0700, Farhan Ali wrote:
>Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
>the error code but doesn't do any resource cleanup thus leaking resources.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
