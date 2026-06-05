Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F26404BCE
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688263; cv=none; b=FVhEFVOBzBaBczRWmtxs7CaF2kwWxCy1OYQ9zUtCIMxlsfAMpQDCL43vSvBcyTKKn/G3tpg6TBPlUXMwFfMKNi9RB92EnpP/wXs44YC2+zEmUbTfHj+PJ1CZdK3dsanWQId1fTdH0KkwAbr8jDz67+PnHMyfOyq5UBUr6sO+fnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688263; c=relaxed/simple;
	bh=Bde7ot8rzYSUh8X/lDTON7mMb3S4WJ/8zewVrMJL4Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJMDIuexqxKUVNu44UkIkvEhgoU7J/d2yj7it6jfn5LnY3aYenywuYBhNbelPhcfpNCQf51JTmrtyC8zsyCFW7Xsap3EhTTwSmmUMAAm0gvIWDh7BsAFZdVUQ8a6oOJ+L4+CAjYYfXhc63BMhxn1Nn+Mm1xb9SWhJQEiXMJjwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efnUxADh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efnUxADh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DBE1F00893;
	Fri,  5 Jun 2026 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688262;
	bh=CAArwDjU28DAOvmztJxXveNkswPh9QF1LvwE7iptNXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efnUxADhWwH9pYaJRtfEedBLaAzLBk/6fmM41BG5G7xhchmvwzXjVLrkNyLt/AQeX
	 cz0oe0nFpvkqYDBDEQ26w2zfc3CSBUt/gS5zYDHgjVZUlKz+xl1zmLi46vfx564OpZ
	 od6F2NnEQYkWeSSAIIIC9GNoKfpcMpESaOkPVWRuuYrx+IyXxF9r71a0OX/zjiju6A
	 r6wuAm5ZNjZ0wbAndLg0W7L9hEUD1DGdighkIQhAZOe0GyBr6q/Ma83jy4BuAmZvzv
	 lSo31M0rFLsPhU+/RbgZMxbfPvA2/6e4FjDP4SS6fjGWFJ2KNj76KMbK0h41uLW3kG
	 sMzRobZFUeiTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	luiz.von.dentz@intel.com,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
Date: Fri,  5 Jun 2026 15:37:14 -0400
Message-ID: <20260605-stable-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604095229.69087-1-doruk@0sec.ai>
References: <2026060418-factsheet-oversold-deba@gregkh> <20260604095229.69087-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha
