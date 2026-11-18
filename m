Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005607;
	b=zOmGXyhCnoWuPmQwduy2XU51lyqHlbR9LxQ2HgcQc1GCWflmOmzCMTBBfS1OfpcEzYdw
	 zoxQktQQskqg6TKJ0ai2NY8iP2dioQbqcC25X+Fs0i87F04Q7m4d/MA9EfBspb9nIGczL
	 HOALvshO/g+yV9arH2YQxYplAOzc3VYR9CFp+8hIt3KDB0JnBgIh3Efcv/1ueRhoK12Io
	 LM8gJriGc6HpjQCYmdJWC9BltKGh8Xgouhsoo1mciWbtfDOoZJH2og6fN6DSBnRauyRCQ
	 DMdBVFS5L6FRcma3SKGwHmlbC+acQH/8ro48PLjFL+t+nzbHETprzgplkGP3xWS8kVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kiDY1LO+2YdIYaYcy88VIyG0onz+JFeWUPe2nf+uQto=;
	b=v1RYalhIoU0Na6FgS/SIrMAXdO7vyA7c+npTAvJvizWy7ioxA/LwYT6UyWarFEtHZsPr
	 /ngFhFie4ZUYOrmRnSjyv20vN/02T8jdsI15LBLrrXfxClNJ4xA9lD5sLXwnVSt26YKZe
	 sfu0Y/BPddrIpxDnCi2COA9gQtl/IcNLzYCSpGexcX99XR7s2LFcfQl/zoQh3wVUJWxMh
	 JW2ImeJsgVPVcxkAqqA8BxEx/nYC80fK1bJFwCaqygjOgo6zPd5Qfp8HZZcjpWCPPOj/C
	 SJTVing0SAgh3NJXMP3QsP1l86kxrPapAFbbGEfYX/QM+epQu/IqwSwtQnI7vi+BHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSu0ntlL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F954606A31C;
	Wed, 18 Nov 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSu0ntlL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E521F000C5;
	Wed, 18 Nov 2026 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005607;
	bh=kiDY1LO+2YdIYaYcy88VIyG0onz+JFeWUPe2nf+uQto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSu0ntlL7afYh2LlriWMUypVAs5tpCDuWFUlLnnVshPf2/Ue2kCNAUPnDGdKf7tHK
	 FdIfqombSBlyNm2AUthGKcPNp+CizcuPOub7dhUabZ/AojTVFOYR00VvFn2uVeUOmV
	 +m6NEmEGqWcutZBMiNVc2uW0ETIhzE9uUdyG71AscKNeUz7FG4zqmEdmqU09RaTdvh
	 0MdipRV5155rF85dmYTm0Ez/6Kfl625nEdNVarLtKM2fjK6zHyv4Ad8hzPRUBMSk9l
	 clJeTY+9Lwbijrr+/PORJ00JeBngOfWu0g7MFUAdH7vs9ov0LUN6XhphvZeNW05/V9
	 IxL1FGxGPCw+w==
From: Sasha Levin <sashal@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>,
	stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Subject: Re: Patch "arm_mpam: let low level MSC accessors return an error" has been added to the 7.3-stable tree
Date: Wed, 18 Nov 2026 07:39:59 -0500
Message-ID: <20261118124002.3727477-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8b078536-4101-42d4-bbad-d251cedba4f0@arm.com>
References: <ab81e90a-fdc4-426b-8da7-45b1a80e88f0@arm.com> <2026-11-17-1-daily-reply-0009@kernel.org> <8b078536-4101-42d4-bbad-d251cedba4f0@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 11:03:40AM +0100, Andre Przywara wrote:
> I will send the stable backport patch ASAP.

Dropped 84e8795c271a ("arm_mpam: let low level MSC accessors return an error"),
a3a94c13c442 ("arm_mpam: propagate MSC access errors for state saving
function") and 197a7a41e6e0 ("arm_mpam: On saving mbwu state read the monitors
before clearing CFG_MBWU_CTL") from the 7.3 queue. I'll pick up your adapted
7.3 backport of 197a7a41e6e0 once it's posted.

Also dropped 643b64025650 ("arm_mpam: Release the mon_sel lock on
mpam_save_mbwu_state() errors"), which needs the mon_sel_lock guard class that
7.3 does not have.

-- 
Thanks,
Sasha
