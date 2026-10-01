Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57C51AECE;
	Thu,  1 Oct 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862771; cv=none; b=afRo8npEFCKMYORdwBkKrYUOstmDPX94OMI70ytL4tAda9QHgmt0W/FEeiDds/ivQydrDs37slOAwx8ezky/HvujwE2Yd876MpFPNcRxglz42jsXG21ToizjzgK1DIMVNg+ZOFL2j1753tEKeWp9dlhZgqFeAZ9SjPgTiQcUiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862771; c=relaxed/simple;
	bh=hEEd0VxVv5xk5MqRNXiNa+trgjRtyJo9iXby+XQIAG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEFTTyNrCCCtEwIXvOZQrGZs19k5FvvoIKx64de8jUBClWgytEfnc6ct/d2XXB0Ky/eou4ysrtwDOugO+qNPm/RQMxParPD2r863BCOHsOQ6ikB0txCF93bLRqPQDE9GkYP/0H8LKsR30trfo+6VZg4EVdaLMJdc6QaymX4rc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npe0leKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npe0leKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351DF1F000FF;
	Thu,  1 Oct 2026 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862765;
	bh=OY8QNWEspqyHTZbia5mPkxZcUj41A0z8C/+7E6VoCFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=npe0leKchLx1x4b5RTpfTbnmlDOXVPk60nq9d5L1yc1DHHW/0xFK4Zlx2GsmFWxmX
	 i4Jm5ZizEX5vlMqfDRnMI7hosvxQCErPuwGkMkVmOIrXlr+RNAGoOYBtg6GUMDfO15
	 iVELQ1VYuDHCrom/e4b5hvyKJxOxmg3RhMH1zLuSZSEpg+xN6Y6gaphiTFQlqDRXpR
	 /ZvAnqWWvVztgCSprscf0IrC+PSQqXD1GWVR2gjstUj0fsVtZ5xLA1M0w7fb+DrOgk
	 jfQs3Y3jRD0TWeszSGMlPW4MSrcCtLuBtu6h5zae1+JvKD5vrRLfUrqGA24TBwhqmP
	 lyFMLA2c1/ecQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 6.6.y] ethtool: fail closed if we can't get max channel used in indirection tables
Date: Thu,  1 Oct 2026 09:52:17 -0400
Message-ID: <2026-09-30-1-daily-reply-0013-ethtool-rss-max-channel-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930012003.95556-1-artem@trailofbits.com>
References: <20260930012003.95556-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-46834. It aborts a channel reduction when the
> core cannot prove RSS table entries remain valid.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
