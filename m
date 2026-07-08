Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F2403147;
	Wed,  8 Jul 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500406; cv=none; b=X0GkbfT1uqwKydHk2Zs5mByCR+qmpBv6FAuvNV2hxoW6aklJMjIpTQGJJ8cDChg9YMW16NpPxZV2ZAyhZpBU1qXjZUtNyZPKmVBmynbSHXqBaGq0qh2/pTPdCFs6W2QFGahKNkDtWDEnlLEWtYD6+Zy5hmTMXoYIZQIWQdTlP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500406; c=relaxed/simple;
	bh=Fbewg8IlSiLIPSnMqcAprLKYEH5XxW0tOK6f4frCueo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZck8/G/wMlWzVJcPKv6Zzdl+a/EtQO5/gt+SWjQ4nEWzAeX6Fq51yJHs7dxiqAsDz1CE24d205u13jm+YpMWFJk2AHbgopzI/UiXe+pGldh53ZMfjiAoht3ILaKOqShWfUCL21iz2LuzFCy96OqA+BqBwnDpB9xKz168ko00qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oME0wYFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oME0wYFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5971F00A3A;
	Wed,  8 Jul 2026 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783500404;
	bh=svAK2lZFsU7AsL2p9hQwuXCTvpXaJlVGm7SLfZO2KdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oME0wYFlgJIO62tUO5ZY2XrP6dzPI7TbVm0i1zuAgisnYJc16UYY0BSlrvWXoa6lt
	 MeHdUjOJCaA8oURFvdZZ5X6yfR92SptqpgFSe0rDYTIxpdbXRmGK8XgiPRE5ZlBYkP
	 Jl3wuGE+/VHEyPEf6Xsr1Hrb8NWTwFVGzygL0Pwg=
Date: Wed, 8 Jul 2026 10:46:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2 6.6.y] Bluetooth: ISO: Copy BASE if service data
 matches EIR_BAA_SERVICE_UUID
Message-ID: <2026070801-reconcile-matchbook-eef9@gregkh>
References: <20260702144207.320421-1-mendozayt13@gmail.com>
 <20260707220526.271712-1-mendozayt13@gmail.com>
 <20260707220526.271712-2-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707220526.271712-2-mendozayt13@gmail.com>

On Tue, Jul 07, 2026 at 10:05:25PM +0000, Jeremy Erazo (Devel Group) wrote:
> From: Jeremy Erazo <mendozayt13@gmail.com>
> 
> commit f4da3ee15de9944482382181329bb6d7335ca003 upstream.
> 
> Copy the content of a Periodic Advertisement Report to BASE only if
> the service UUID is Basic Audio Announcement Service UUID.
> 
> [Stable backport rationale]
> 
> This fix landed in mainline v6.7 without a Fixes: tag, so the stable
> autoselect bot never picked it up.  linux-6.6.y HEAD (v6.6.143) still
> carries the pre-fix code at net/bluetooth/iso.c:1935:
> 
> 	if (sk) {
> 		memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
> 		iso_pi(sk)->base_len = ev3->length;
> 	}
> 
> ev3->length is __u8 and iso_pi(sk)->base is __u8[BASE_MAX_LENGTH] where
> BASE_MAX_LENGTH is HCI_MAX_PER_AD_LENGTH(252) - EIR_SERVICE_DATA_LENGTH(4)
> = 248.  When an attacker within BLE radio range sends an HCI_EV_LE_PER_ADV_REPORT
> with ev3->length in [249, 255], the memcpy writes 1 to 7 bytes past the
> buffer into the trailing fields of struct iso_pinfo, including the low
> bytes of the iso_pi(sk)->conn pointer.  FORTIFY_SOURCE flags the write
> with "memcpy: detected field-spanning write" but does not block it.
> 
> The upstream refactor addresses this by:
>   1. Filtering via eir_get_service_data() so only the BASE portion of
>      the PA payload is copied.
>   2. Bounding the copy with base_len <= sizeof(iso_pi(sk)->base).
> 
> Backport notes for 6.6.y:
>   * eir_get_service_data() is already declared in net/bluetooth/eir.h.
>   * The header include for eir.h and the EIR_BAA_SERVICE_UUID define
>     are added here, matching the upstream commit.
>   * The put_user() addition in iso_sock_getsockopt() that was part of
>     the same upstream commit is not included; that hunk is a separate
>     getsockopt correctness fix and is not required for the OOB write
>     fix (getsockopt(BT_ISO_BASE) is a controlled path that already
>     validates optlen against sizeof(iso_pi(sk)->base)).  Applying the
>     getsockopt hunk here would risk a user-visible ABI change on a
>     stable branch.
> 
> Reachability: any host with an ISO listening socket bound as a
> broadcast sink (LE Audio / Auracast).  No pairing required.
> 
> Fixes: 9c0826310bfb ("Bluetooth: ISO: Add support for periodic adv reports processing")
> Cc: stable@vger.kernel.org # 6.6.y
> Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> [jerazo: backport to 6.6.y; add #include "eir.h" and EIR_BAA_SERVICE_UUID define; drop unrelated getsockopt hunk]

But eir.h was included in the original commit, you added it in a
different place from the original, why?  Please try to keep changes as
close to upstream as possible when backporting.

Please fix this up and resend.

thanks,

greg k-h
