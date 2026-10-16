Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AD374745;
	Fri, 16 Oct 2026 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139876; cv=none; b=aD/Mr43c6cGa9Cga+pqDd5tOfuGUPJTlC2t8gAECJyer2h0Hv9covi6iLE1OAYzz4C0AnMwWVKeCwVotrZsoslMxXA1eMsXE5Yl20be376NI9ucoA0zRtfu4ST+NeaL1F2OyCvXpLyGsJgC/YC1ca0h2aX31iLAwpNPcGJppXYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139876; c=relaxed/simple;
	bh=9aj48fI78Ni4q7PUJ+RKsGjXQ9V+S1dT2jVXL9NjBMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHOiNMf2wgz9v8LAFCK22HM3lqKV3blzPJ4arIzRTyleuB3GqghM0YEF25K4bfsq43kZDSltI83J+6O0kBjQLce857FskGanWP/o2UlICnQUIij7w83th74JNStHUFJhQYscHzwKWsik/XR467rX7T7o65EyZSOOMkEth+9EZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Mehmet Fide <mehmet.fide@gmail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev,
 mehmet.fide@screeningeagle.com, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] wifi: ath9k: reject short WMI command responses
In-Reply-To: <20261015184044.1321868-1-mehmet.fide@gmail.com>
References: <20261015184044.1321868-1-mehmet.fide@gmail.com>
Date: Fri, 16 Oct 2026 10:32:13 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ld7yxcz6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mehmet Fide <mehmet.fide@gmail.com> writes:

> Hi,
>
> this change breaks ath9k_htc with the AR9271 firmware from linux-firmware
> (ath9k_htc/htc_9271-1.4.0.fw, "FW Version: 1.4"). The firmware answers
> most commands with an empty payload, while the driver passes a response
> buffer for every command: cmd_rsp in WMI_CMD()/WMI_CMD_BUF(), the 4-byte
> value of WMI_REG_WRITE_CMDID, the 4- or 12-byte buffer of
> WMI_REG_RMW_CMDID. With the new check all of these calls return
> -EMSGSIZE, and bringing the interface up fails (hostapd: "Could not set
> interface wlan0 flags (UP): Message too long").

Thank you for the detailed report! And apologies for the regression;
seems I need to do better at pushing back on untested slop patches :(

Given the lateness of the RC, I'll send a revert directly to Linus,
hopefully he can merge that ahead of the 7.3 release.

-Toke
