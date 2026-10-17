Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5EF3ADB92;
	Sat, 17 Oct 2026 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206039; cv=none; b=UJ2UGBa6epF8HJP85Hva7Y1MGnNf0vCNV4YoyOY4tJ4JXOsynhp8pW+rFcbGQFnW6cq0g8FHXXe2TzDjDjZ/ht4hAn4FcbeSgUJ1MqZ8nzkUhMXtkwNVBM0+d4hnA0uL6MGDLM8mqH7xHKu/uc+zxd1dOI6IYTpYu8KCNN6mwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206039; c=relaxed/simple;
	bh=op0ojVnXmnUWDIi0Ikh9dFdW0yEQVUsygI6qdhCoDX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlSK00M1QDTQLsp1S6yjFFSV0wYe/msgeVRj+30mhwURnGtwyNe3i8PZsDyekVKQoNCsQ6SWUfZ262h0WKU2//dqdf9aIGpqIWxAyMpBrKPZRLHGVtnsVG3V/f8Yslk3w9Q51g1NQ94FHAURr6TdwwxKn2zffq1M4PIN76Wy2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKIsTfTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKIsTfTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD3E1F000C7;
	Sat, 17 Oct 2026 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206034;
	bh=JnK5LPpnsYjRWrYxmyxQC3KNC40Zu55+eCp5upyQ07k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UKIsTfTTqXQg8OmyHMtnnAQh3VLp09ham3N5XXeQcfKwEmX3rai+6Ddi198yRpvVO
	 WfqSGJeG340Wd3gVlCc20HzskYprm+CKnQcDhoFt0wKzLf3XpNsANfl7v1MqpZNpAF
	 b3xohtqUKhCr4hPoA/2TOkmFeZ9rzLZIRxpGCKCmm0szXsA40L5iQ93xTBBeKiI5EH
	 8MexW/Qm5Twl/qHBs2AGnjG0+eaPrMrh1sS5+jvPnwGasZiogxKFKn1ksyxTv1cA6v
	 U0/X3oR+4QRMwXm3WThQoKApudqSj2zulsTr8yV5h7ddoqpyDQXMg0xiht3ldCp8S0
	 Ubn6cKSmuEz+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Juhyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: cs35l56: Add DAI for SDCA OT25 stream
Date: Fri, 16 Oct 2026 23:00:13 -0400
Message-ID: <2026-10-16-1-daily-reply-0008-cs35l56-ot25-dai-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e4cd86b2-6975-43e2-9812-daf8e4207583@gmail.com>
References: <e4cd86b2-6975-43e2-9812-daf8e4207583@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please apply this commit 86c8360c97f6 ("ASoC: cs35l56: Add DAI for SDCA
> OT25 stream") to stable too.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
