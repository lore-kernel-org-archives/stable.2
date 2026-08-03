Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DA3AAF40;
	Mon,  3 Aug 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787352; cv=none; b=rOqPaihgWUDtmBuMwrHMX8nLx+LX/theBUq/sTnr0hlYcez9NIhJZHfxUD4aoavk7s0TFTMIeJthvNDSW0vhoOFPTvhZxbse/KEGOjP9MB/Oyrmq2so0ync7MUsj2mzVYqdJfk7+QZgFcmevel3pycWAfrIiajJxi7eW1UVeZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787352; c=relaxed/simple;
	bh=EDjff6Ztme8eG/0bHsVTOIAXbXQa9tAO+yI4dl5yFDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=muWGodeo3sZs+fw8Fxy9QGf3qsBFs4bzekECbZcm2c5BxyIYihILiQenMGAQjZhzj/RIYNFvc1oCA8MCpLYb1HW5wH8h7M+ug14O+NSaSaxJg06VPfu0qBO8ipyhDCIf5G2IUhQtp8VrRaoQWBh0197lY5He1Bk8cVdLbi2ObIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neOa7p7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neOa7p7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8631F000E9;
	Mon,  3 Aug 2026 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785787349;
	bh=sK1V9SAhtghqJ6GKOBNcuOGDV3q27FgHMkXXTCzFDm4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=neOa7p7cfJUnKURyRqkvGZVWFiTBhfGeH60HG0XJrMzFcEoxABIQYU5hckGWtgulT
	 nvm0SVFWzzjJz2RJKmAGFs+76mOfW85+VApAdVZgDcUtFRTJCBn3tab0qyvRPih28c
	 Hvnq/hqS08uZxpbtmiqyCLTRvu6jjVEj8Tu/XawSKDIa7I+vGCfC/oHvf/R4lpnf6V
	 Fx/7osJdeBZvFePu2tPTJXRAGOCXy0+CYVrEO/6TkDJ3pxmnsyFGmCI629N3mdmfJE
	 VZDzuYT2VC3HLM7w3U4Qw9WYJfs+BvZNfrDkcNcGy/LrsGG02zZq07FA6sBqUHpRh7
	 TOeikzBRsac5g==
Date: Mon, 3 Aug 2026 22:02:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: picolcd: clamp eeprom debugfs read to bytes actually
 received
In-Reply-To: <20260715115301.91063-1-security@auditcode.ai>
Message-ID: <8qpqrr29-12qp-q827-or00-q07o639582n9@xreary.bet>
References: <20260715115301.91063-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Jul 2026, Ibrahim Hashimov wrote:

> picolcd_debug_eeprom_read() trusts resp->raw_data[2] -- a length byte
> supplied by the device in its REPORT_EE_DATA reply -- clamped only to
> the caller's read() count:
> 
> 	ret = resp->raw_data[2];
> 	if (ret > s)
> 		ret = s;
> 	if (copy_to_user(u, resp->raw_data+3, ret))
> 
> It never checks resp->raw_size, the number of bytes picolcd_raw_event()
> actually copied into the 64-byte raw_data[] of the kmalloc'd struct
> picolcd_pending. A device (or a spoofed picoLCD) returning a length byte
> of 0xff, read with a count >= 255, makes copy_to_user() read past
> raw_data[] into adjacent slab memory and return it to userspace through
> the debugfs "eeprom" file:
> 
> 	BUG: KASAN: slab-out-of-bounds in _copy_to_user
> 	Read of size 255 ... picolcd_debug_eeprom_read+0x214/0x2f0 [hid_picolcd]
> 
> The debug-dump path in the same file already validates the device length
> byte against the received size before trusting it; this read does not.
> The file is created S_IRUSR (root-only) and a crafted device is needed,
> so it is neither unprivileged- nor remotely-triggerable.
> 
> Clamp the copy length to resp->raw_size - 3 (the payload actually
> received, minus the 3-byte header), floored at 0 for short replies.
> 
> Fixes: 9bbf2b98ba11 ("HID: add experimental access to PicoLCD device's EEPROM and FLASH")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

