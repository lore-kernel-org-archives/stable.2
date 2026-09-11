Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB114252A0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125686; cv=none; b=cBPxV3nvjU950iDL0yoEE9yrx3TdWQKq8jKhTla+TvrAUd/2nu6c8OpYR618PtJaAEX7kbbVmJB5rTxkt4ur44NdJ0n+LN4uLlnLkXrrloliXNXae2aJgCRBCLt+1mGSuWwcWAqdW7mGua9cfU1M3XJ5j7PV9o+Cfu1EkjpX8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125686; c=relaxed/simple;
	bh=krdANmTn2oNKVOuf0IjWYGTpH0rRlh9AMr3yXVgGHko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnki3pgZqv5H2CZE/8NZks45K4JxYDsgMCrFJw27FEFX8zvHbi+EicRr84gvnfv13VFnvEoSgffaZlFeL0iMxJ0U4cAQ/GOvQxzadXyKC3jk7OeBOgPJmoY4W6l49lDD/xzNrddPtuOSLzURG+3IdBWFHjUFwY10/MHRHll+QGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npTxxln9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npTxxln9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985131F0089B;
	Fri, 11 Sep 2026 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125680;
	bh=1rj6lpU10nRs0c2WaUDz50Ypnlxq54R/oGMrTMPfnO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=npTxxln9cfGe3W2V/ZYf8MhyhMn7cBhg0nk0Yk8Qzo0/W8ZQca6f1xFV1IZArTXTz
	 AEK4SSmaDY3Lt0sE3SsdbelqVBum3Ne9qoV0VmUXPIASBQbrNAOnyUznB3N7SuV06c
	 8SdkQ2Pr8B5vZeNUsuNEL0MhcqKx5Qq071JvmsPJEfQBN/qG9bzNZrXltI9yVngD4R
	 6wQdKQycGrTb9oi32ESlOvvWLKWKsw76ohI//F3Y1X7sSghU2a1d+OiRbIobL/cdUc
	 Pom60i6NomrSq7dloy/Zo6/WaueXvMZdpnTN54ztcIKNfRAq6yA6gai1j50bYIK0QQ
	 HEnfj0YXLodyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Fri, 11 Sep 2026 07:20:39 -0400
Message-ID: <daily-reply-0020-re-batman-adv-bla-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909191138.1120682-1-sven@narfation.org>
References: <20260909191138.1120682-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 08645ab95768b88e2ff85a89211994651710465b upstream.
>
> batadv_bla_add_claim() is used to add claims and modify the backbone
> of claims for CLAIM frames from remote backbones and local packets.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
