Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685919;
	b=lAsAzAyLXcpzFcsJmcNrfrfkZK/EH7PGq7NSeCBISoM9h3SdG7ZUgToZ1qyjd8Tu6rOE
	 Id3xNxbgrpVFnaUI3i+DnokBFYEaf8kHRH0EXLelRM1Itt4U9HVOAXNbJHiEShR1U9gTz
	 QpiKPFJ1+LcqniiwDqUJsDeRuLhdMMrxgSZ7MqqxBDHZ4mMwFAOuujlxC3UfFwi6cHyBs
	 VXLe4q7zulSzT6E8A8hLWjw8D1lplKIXJ6EAKxd/U5DZGFeVOkui/WycsFguUMPy2h1oH
	 TFhDsj5RhkqHsRTkJkK9eTBYQG2PX2aybltGgJpARLrsWood0CNto/1IE0czMJeGSYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=a6a2SZX7GswnhhLphSREsqNRTicacM7scn6gNmsMPxQmPsnnJ19lFTKJDo7PaSZuItK2
	 UUKPzZeh386ao+iuBWB1iaSQVngfjjqahmtGPLjYlVTPAj4HGi3kA0vH74gEnTydACRlj
	 MRRW8GeQRb4g0pUYf8gMVtbqkafWuSRASi1sIRdx4TJ+K19Ktqx2whKTcAsUgQ/P4/ycd
	 K9G4eQ5OtpGg1eKBqrcmMgu5Ll0KGkmNO9/bUj41W6YfbS9Kynesxg54RhkURR7PS6pQg
	 bYIAW1OfYdFNhizJMxbodq2B6g9uOK3bKWwtR1yzyycnvviJ0eEK+l4WTwUPZXHcPYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFhl6CYz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668A606A32C;
	Thu, 26 Nov 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFhl6CYz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98621F0093C;
	Thu, 26 Nov 2026 09:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795685919;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iFhl6CYz6OiQENs16KAC0nDztl4EYOGUlvCqOMChSZr6qXJfUIr25cpQ0TE9wYuHu
	 cDbDLsLbkpLlX/9lRGCILr1e3jKZYVVmrvwutf9rv2mAfPCYp5LkkIGbv9IlrTF2U2
	 8nSKc0PfDwTCpDCz7sIBuOVsC+0VVFHYCmMGdMosN+0pF7Hxx5omv265gzDzN7gI0w
	 5/P1F5fIQIEvk6CQl1/lXTi9AVJg/sGRaEXOM6a/Lk0UPCuFxSiPKOwPWsGVSIENja
	 enL3GJZUGRjn/EpkysGsUsXYSMtMPsL5vFuQ0tvb8QI7tLEZ90gfWKGaQyaxBwBooQ
	 jK7NLsx8EQgtQ==
From: netdev-bot+sinfo@kernel.org
To: Hongyu Guo <guohongyu@cmss.chinamobile.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Subject: Re: [PATCH v2] idpf: fix vport_id used as array index in MAC filter
 async handler
Date: Thu, 26 Nov 2026 09:38:38 +0000
Message-ID: <179568591819.3294.7791318700708101918@kernel.org>
In-Reply-To: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
 <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
