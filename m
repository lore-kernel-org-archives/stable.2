Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A023DBD7A;
	Wed, 10 Jun 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106441; cv=none; b=d6r+J0MaqBXH5zQwQ0rsXfbE1yRYTbxuIgMWzBRV1/VDt0kNnH3KAJzhrEgJPGxa3t03eDgr9BKRV64MBLDqCR1PnHtN7k8ju3dSY1DgJsHJMcLJepn04XtCc8tZcCPpxiiqY7DuYcacPoBlV4TKpkpjHtj3vT/S8HAZykf+0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106441; c=relaxed/simple;
	bh=lPagUjN5wyxfSqvytAIAj0NOyzMlBLE4JYZ+/pTWm9I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hisV+iyvT9KQCee4gAGpNxTBgPHzfyr9iGuHjLi/oee85C2LbRzZ6LO3Dg4S2Ydq2dj4j7Q/QQpNzdbxfmjqtFs1XgGeaLVTjgSfP+i1cgB0TMHVMFKkRktFPVGHTrdMBWfqXVdSE/YzkV2V4v1G+Fw2tyTiGjQO/+Tla9P5fGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkN1jwhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkN1jwhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279001F00893;
	Wed, 10 Jun 2026 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106439;
	bh=94laT4DhQ8CjN3VZcNNgN9Mk+ciT8XIRfv1gtFlc3dM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NkN1jwhKxYf98CSixPxGg2LooDQ8/+4u0EwPF+e/AQkrVQW5NrV46OxWaFYSRUWtM
	 FXS/bQ5gBwcuss3sgrttEEmW9qpP1uL/q54ZANJLLhNHGQUyv7B3ugoW/dnj1ECPDZ
	 8iRgLehshnzRsIfx9lSQa4vgmCybVPHdE2qYo1KYJWop2asNf6HgGWLsJ6pbFx4EKF
	 yQqFR/LatQtkq0XOcTPacQfuF0QWTDQ3Wt6WQIj/b1N87UzGN/vhvr4mX2vYZleNb9
	 ysrWy9keqAIIK736OAefay19W5YBW06fmk8dInxITK4NKCzSEzFb6yDAv6zyXdTyGi
	 q0f8QUzaGTxnA==
Date: Wed, 10 Jun 2026 17:47:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH 0/4] HID: wacom: add report length validation in irq
 handlers
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Message-ID: <9o1psn77-q665-0rp6-pnnq-9179802p2nsp@xreary.bet>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 17 May 2026, Jinmo Yang wrote:

> Several wacom IRQ handler sub-functions access fixed offsets in the raw
> HID report buffer without validating the buffer length. wacom_wac_irq()
> receives the length from wacom_raw_event() but does not validate it
> before dispatching to the sub-functions, which do not receive the length
> parameter.
> 
> A malicious USB device can declare a small HID report in its descriptor
> and send a matching short report that passes the HID core size check
> (csize >= rsize), but the driver assumes a full-size hardware report
> layout, leading to slab-out-of-bounds reads.
> 
> Note: this is not mitigated by the recent HID core bounds checking
> series which validates actual_size >= declared_size. An attacker
> controls both the descriptor (declared size) and the sent data (actual
> size), so the core check passes. Driver-level validation against the
> expected hardware report layout is still necessary.
> 
> Tested with KASAN on Linux 7.1-rc3 (slab-out-of-bounds confirmed) and
> verified kernel panic on a production device via uhid.
> 
> Jinmo Yang (4):
>   HID: wacom: validate report length for PL and PTU handlers
>   HID: wacom: validate report length for DTU handler
>   HID: wacom: validate report length for DTUS handler
>   HID: wacom: validate report length for 24HDT and 27QHDT handlers
> 
>  drivers/hid/wacom_wac.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

CCing Ping and Jason for their review. Thanks in advance,

-- 
Jiri Kosina
SUSE Labs

