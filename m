Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B01372663;
	Sat,  4 Jul 2026 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130732; cv=none; b=tSiHQXHzbNZwqUXT2h5PxNY6UWcEbvPvgz3yv7Vo0/+tzbOnmJyK7Y3fOCoP4tyzAxsQK+minqMvY44l8jCyOF7BTseFTKlF4Ek15fu6R0g3hwbDiKfRYVR6aAtu7XeQK9yIgEt1gA/RBd+tbdYDnqMYvUj/UHRtndYQwUaAWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130732; c=relaxed/simple;
	bh=8z31jpK/krIwo2XaXOn/meTzhoMhjebOaLqzNh0Y2PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOCe6yYFSa9iFpcSCsu3nzDKajsVmYWQoVj7935w60WG9stnTpA2BlwFE27uHRGrNXXfQWrjU0RtaAhOe33zgg4keDg8/YEP73JQchPCW726v32CLBOG7Ye+G3PK5Q2gzHl6UYqqYfHlM1GfmXIGD0ZBDKisH+pHYWF+JzcxLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UozoAkPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UozoAkPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360DF1F00A3A;
	Sat,  4 Jul 2026 02:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130731;
	bh=vvz2XQmi7UF13ZcTjBOaSj/YXjahl9ML2pGSdtMcXbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UozoAkPmzKruCDhFoXp7ZcHus18hX5qNjQHblgfkV1BmAx0rEm1hswY29tcIzN6Dd
	 OqqVtO23SyC/DQDxcRbya9EhODqQP+NbaCgi1ZZJCaIrkRgA6jSSm8ckr3yH7Wb5d+
	 7en4OIGUo2z0brpQF6x53WGPgwaYwRVUCmrIpBSeVCIaGHruSS4dZW6qgt7oA/knPt
	 THGfw5H0kxiZrAKo6QmNopYryxXwiUVdVq113g3UWD6XivkOepQTwXrPPgBZLVNjkN
	 FgOSGDVf6GMQ3+wfglJfi32Ldu4FJaVhaZrReFzMVVixS7wsqgso5XxYKdJmwTf9bQ
	 3PFUqgAUJDLOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Erazo <mendozayt13@gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: ISO: backport missed OOB write fix to 6.6.y and 6.1.y
Date: Fri,  3 Jul 2026 22:04:58 -0400
Message-ID: <2026070315-stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702144207.320421-1-mendozayt13@gmail.com>
References: <20260702144207.320421-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 02:42:05PM +0000, Jeremy Erazo wrote:
> Root cause: upstream commit f4da3ee15de99e ("Bluetooth: ISO: Copy BASE if
> service data matches EIR_BAA_SERVICE_UUID", 2023-09-28, mainline v6.7)
> addressed the OOB write in iso_connect_ind() but landed without a Fixes: tag,
> so the stable autoselect bot never picked it up.

The upstream SHA referenced here and in the "commit
f4da3ee15de99efa0a68eae1c4d09b4bcc6d9dcd upstream." line of both patches
does not exist...

-- 
Thanks,
Sasha
