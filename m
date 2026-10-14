Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B655D86C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996809; cv=none; b=LLkqAuWs3Fu3QRTlSEsdjboDrOE9DpbUS42w9kAQUGHB/ce8BDelYRzrDctUT+XhJnIzAp0lN8TWFBQKMur+qRnjjqNGTWV8p9RhSfg/2cgm+/PIXTMESQ0vg8MQLYuqarc/Mfu3wBTx3sw4fpsl6wTCK0wjybbw5Y43U6rkkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996809; c=relaxed/simple;
	bh=EJA3TJ+9mR/yWRT2YliOXU9QFSLVDXo2xZ6USsd1Zwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATGGisJlVtJPaFRTXOxsCtBYHefzR7IVWi/GYOdQ8Zjt5G6dTaz2Rw66M1O2l5/l2vblOVOB8FvN7MndWi1i0Lg0uW59O3wxJQb7j/PBG6b4wusZ0g2Tvm3MMapmEEOv3waPFVg0mAsmoQi1hync1/mPdYI8KhZGRBwdSMPBeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyrf4nVW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyrf4nVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA831F000C8;
	Wed, 14 Oct 2026 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996808;
	bh=n5uQtNGNE/Ll7H6KDdi1El6FPVTaFyQOgevtgA7Yv78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jyrf4nVWENBULcqZioWPP4Ge43rsnDJejTzWZHkAHLIdVByZMguZhqVSpDh1M7BPT
	 3QJpN367Hl0G5UYmdDTPGupcO6gJKDFkMc3BtflKV8RsTBUDYJDERsUSQQrxQXWdI4
	 VuNZT7FaercXKptaICEnmnbd0AM4JSbrP5cei7LkTPpq6Kg035kjnonURPalYkDvFq
	 gtXy/kTdFVwZpK1SKdMWjW+oITtPzeqXhRK6IVAiYqrxE4e/li8HhXLbLXVP2A/nrN
	 HRJN5Efo2xBC3SbgVmNSpvPRKiyWMt6sApaYxclkkfL4kT53CjOoFz3qNjRDuEX2JQ
	 h0wDkGHU8uW1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Franz Schnyder <fra.schnyder@gmail.com>
Subject: Re: Request backport of 1bcf245c837b and 01d16b8afb7a to 6.18.y
Date: Wed, 14 Oct 2026 12:53:10 -0400
Message-ID: <2026-10-14-1-daily-reply-0007-pci-dwc-wait-for-link-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2qz7vt2ycstbsqcvy52sgeuhbfceipsugbthq6yqenoxs4sxs3@qtzxcw74cc62>
References: <2qz7vt2ycstbsqcvy52sgeuhbfceipsugbthq6yqenoxs4sxs3@qtzxcw74cc62>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I also checked 6.12.y, there the same problem exists, but the commits
> don't apply due to a context conflict.

Queued both for 6.18, thanks.

6.12 is not queued. 01d16b8afb7a ("PCI: dwc: Return -EIO from
dw_pcie_wait_for_link() if device is not active") uses
DW_PCIE_LTSSM_POLL_ACTIVE and DW_PCIE_LTSSM_POLL_COMPLIANCE, which come from
f0f3044d2246 ("PCI: dwc: Add debugfs property to provide LTSSM status of the
PCIe link") and do not exist in 6.12, so it fails to build there. 1bcf245c837b
("PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not
found") also conflicts on 6.12, where the macro is still named
LINK_WAIT_MAX_RETRIES.

Could you or Mani send a [PATCH 6.12.y] backport of the pair?

-- 
Thanks,
Sasha
