Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C93115AE;
	Sat, 27 Jun 2026 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578141; cv=none; b=iAfYFo1lCB3LHLFRycZunrsIu3yeG7KJxovD1DTgZ9ptb7zjc0LOM+1nZxBupgqbnfFk+PWZa/oQN9x1BUqq6RxhOty0czjLrl5NkjhDZK7nVF+AxMvBEWwtmF4sOeRQTWrnUdD1XY4sWzNLwoSCXLujp6IA40x9v7C9fs5qLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578141; c=relaxed/simple;
	bh=uyY5ORe+mcGUeC1MlEHK9/Pnw6N0DhHebw2daP+L3i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/q1kEju1NGmSS9pM4hcRwLih+8XqNI3Jeu79kNR47Ib6OPanNbmjm4vsib5zowwoBwZuH1fuLXLSS7Kq/BAasZyYV6X7ml664E9FvqmykDQqbN50syUUnFmFqZOoKETJqFX/SRTWPAd0xb7sTr1qJW5mH2f0tCs4mfBZW9fynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACfVTM0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACfVTM0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5051F00A3A;
	Sat, 27 Jun 2026 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578140;
	bh=BNLx/O08lLRTN8+CHTofGUqyf96b051Nkcpaq8VIpv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACfVTM0x+volUFr3vn+guv3j47i7CbVlemcG+ZyHIKpujHOnK2B8Cb2UEI9ClqgEd
	 wA/DLb9PHBRCDu+QF37mg/1EFN57ljfAjuEQ6t6/RLRSepJVxCki1rDqXf5kOnSOW+
	 L0MINwP4n00lDVUWiKF2GuKmUMBLDJmdbbWq3AlezVFzWfdufd5JR6nGZu9DSQ9pB4
	 XlYINBjC3Y9PBUFGlTXfiM7i3ARBtC6CDHs3XOzYXK+ylwgQIh42WC54vxXswZYaa/
	 9iASwlliWuIYxK9Tiw9i1dowb/cO4k1kY/i1ttzdj1hp1QUyI2CNydkLcuRXXNhZBH
	 4CZaRIAxHLIGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mani@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Paul Guder <paul.guder@example.com>
Subject: Re: [PATCH 6.18.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Sat, 27 Jun 2026 12:35:27 -0400
Message-ID: <stable-reply-item011-pci-qcom-618-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 13:37 +0530, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> [PATCH 6.18.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"

Queued for 6.18.

-- 
Thanks,
Sasha
