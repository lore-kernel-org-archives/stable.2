Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2481AA1D5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523558; cv=none; b=B5BblLc6fbrwSK/XMmo0gmIJ5hnRJVwkMQQbsahpE0WqFOuxr76JkNYRG5Kzuqwp/sb1nkYHONKUr/a7xfsQVAKifFV3mpPPo9fZdVJx2oTJIAdlxg+rmI9Kfe/BVV0pLa3EZIg2nu/SOjj4GO7j7HjJDqxDKf9FMEivxb8kniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523558; c=relaxed/simple;
	bh=z16pDzFFQ+7ZX+4kqdeH8dfpJRyCNl30UPmf76JhgKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgtGVp6mvZ+1fi8r5mRwv4DMoWqMxF5MiIpnfTvqmBnQejej+h8BCgsqGTI1wl7fY/bJUIqUnFoMJ+R3BBGcdhGww/XiaqAD7ysxVljnOI6IRKI9YqaMRkYhygjfeXCwld+1zIZSRUp6rYV597I17JchMqBNHVYwQV4Qf8fiOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyjlsGu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyjlsGu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30E51F00898;
	Wed, 16 Sep 2026 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523546;
	bh=Vop5iZGNWeXFJGlq9orr7nuOzfMmaXMOwjz9MtdlYK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyjlsGu23mgOLn8Y58TkXSQTHMONR5qnro+8M8IV5Ndq8Q4vWpRIezBJHrVPXPBOs
	 dmIeCLZKRFp+zPsqa0usMO0ekMqL4z9BWgIgeQkK5bVBwGpAFvgN2ysfEA9KjOfROI
	 1u0skgvUF7niysJ4b5AuekBeKCDO3l2S3+B3vyWCQcCQsenEz+Yc+42DJJy6azemEe
	 pZXULbHywrxeBxtWrAVTqjSBodFUT59chUiOQpF1SPcxYMJi0T0L07j+vMi4ev05wg
	 i2qe686/5LtTtfMm4kTzaWgaUDnmEQcfSDvnVYOnhQx97nDhM4/F4eSAELNh0VZtio
	 6kPeARRD9fYJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: Re: [PATCH 5.15.y] ksmbd: prevent out-of-bounds reads in share config responses
Date: Tue, 15 Sep 2026 21:52:09 -0400
Message-ID: <daily-reply-20260915-0004-re-ksmbd-share-config-oob@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915124808.6052-1-linkinjeon@kernel.org>
References: <20260915124808.6052-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Validate IPC share configuration payload sizes before consuming
> variable-length fields. Bound veto list parsing and account for
> the separator byte when deriving the path length.

Queued for 6.18, 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
