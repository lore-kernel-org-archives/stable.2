Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB431B131;
	Mon,  3 Aug 2026 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782583; cv=none; b=JX1Xq1/HZeBH8gDmQLdTgLLTC9FxJNgNuRKEPc7OcM2yFo1rYPfmkStomPwuvm+FZ4SIKYP6AXWG/msGjoHVk6USQ4sl+d/osCVUmeMfPSOOR3MLdCYVwXMcUipFg6XUmo/9GiPtx5PbDGmmwlESupHhYNXhjP5v1Kf0MAVCS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782583; c=relaxed/simple;
	bh=fK4QMHdVbxaPNNBXI+a1b9TEw3jbCGwh0v76e9sejuc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PMEDPmN8Qp+yMNiV5nnbVv4KYv9UXE2BwjJCkhs9P4c9EHN6E2wj0RF0ArLVsDSfkB9maR04wKsXtwwvgjg8P5NPo0dNZ+hLFvnHm1HT6u3+bWZ6w02oye4CnnpEW+SWEG1yLEw31oFHYjZZeZileFkIILeQQHB6iC+cIz6UVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzQW4ucn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzQW4ucn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E061F000E9;
	Mon,  3 Aug 2026 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782582;
	bh=k3AVQiq01uPqHUN4j6E9Vnu+RDRUpPJHAqiHIYSTTpk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DzQW4ucnWyWEBoxub5Hk8i5fxNycw3jXu62CQKw6X7iD5eYdapvsjhML+Uc8tL9RA
	 JX+Sz5oC66AePICZG1t+iztKrFWefRPVXYMigJUdawtYfIfxMsz2MCknaXDueNhOMz
	 +3miYYa39k46qwWeYNNMfChXC61QTAfMwqFqlZ0AQd8Kv3esqb2fj2GBl4OAtPRETu
	 RPmWLXmGDh73GES0zasHGJwJtVMwyn1oRcg83vtvO6QKeyItmdr8LpHvlKAjVDsAPt
	 EQqSdVRvdjFmkQ7pZJxf50Gvg5r3Qib5+OjxHB7HhRq4y+0+zl3PRTwd9Mec7S8tkR
	 lMUYLOYbP3yFA==
Date: Mon, 3 Aug 2026 20:42:59 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jann Horn <jannh@google.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: core: fix number/pointer type confusion on long
 items
In-Reply-To: <20260703-hid-core-data-typeconfusion-v1-1-3c63c0d77ab1@google.com>
Message-ID: <0n7530pq-8781-124q-pn80-q735q8q8905r@xreary.bet>
References: <20260703-hid-core-data-typeconfusion-v1-1-3c63c0d77ab1@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Jul 2026, Jann Horn wrote:

> When fetch_item() is called by hid_scan_report() on an item with
> HID_ITEM_TAG_LONG, it stores a pointer to the item data in
> item->data.longdata instead of storing a value directly in
> item->data.{u8/u16/u32}.
> 
> When item_udata() or item_sdata() encounters such an item, it incorrectly
> assumes that the item is in short format, and therefore returns the lower
> part of a kernel pointer reinterpreted as a number.
> 
> When a HID device is connected whose descriptor contains a
> HID_GLOBAL_ITEM_TAG_REPORT_SIZE encoded in long format with size=4, this
> causes the lower half of a kernel pointer to be printed into dmesg as a
> number, like this:
> 
>     hid (null): invalid report_size 107953555
> 
> To fix it, let item_udata() and item_sdata() verify that the item is in
> short format.
> 
> Note that this bug only affects hid_scan_report(), while the main parsing
> pass hid_parse_collections() will always bail out when encountering a long
> item.
> 
> Sidenote: There are currently no users of data.longdata; maybe we should
> just remove any parsing of long-format descriptors as a follow-up.
> 
> Fixes: 3dc8fc083dbf ("HID: Use hid_parser for pre-scanning the report descriptors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Applied, thanks Jann.

-- 
Jiri Kosina
SUSE Labs

