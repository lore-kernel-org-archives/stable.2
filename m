Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B742C4ED;
	Mon,  3 Aug 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781759; cv=none; b=rticOjB9tzb7AXUjvKSnvRWLxue6jGsurOCQEqv+XUxTf086kv6k6FKmyDjDnefaJtP31Fw1+XrN6RW+Oe0Frrb+R5xPcMYJX+h8IB8GIZiDuUz+uWPR/4xsRpXJaZJ5RhZWIkBTzV3jE6bDQjn9LQOSWNCZWz9FWUIJ8UUOEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781759; c=relaxed/simple;
	bh=bHFxxFiRgw7oqdEQWiqDO4hDfcxA+zqWQoS5AA/r0Xg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sVjSZE1xtetMWebF6gScHFzREVVk+4VncVSPsf5l4fZ1oSM1H/BC41DgHC+3TqSzWr9f6NQ47IuXILWsgzHSdUPWQgzlRVUievKq37s4/0Ztec4JO7bxtXcrZUcTxb3YmwBZUC/ti0j5Zrxb3M1ZlPofyYR4c0G2cFHFlGB+Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQsSUVTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQsSUVTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24581F00A3A;
	Mon,  3 Aug 2026 18:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781753;
	bh=63aSZEWLdtDpxGWcR9RyTQJuWBDy9VOieOwbCJXeWbA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=fQsSUVTpql6sGxygaH+s94K5nMONoiPRn2aSPI3o8oQEEMPpgHWxbod5f6EmNPBHp
	 WN/HlD32j1znh94m0cinehVkqZQVyzHr1i3XNz8DR1Kl+C4WK8jtuI28kaT/LyPAUS
	 sg4kMp4YH3T8c+h6qCjiu5q9z8nEV14DMM7YZCeG7aEfOXM5SvSM/NiiAUUDLmQLm9
	 7oF6Aa1IjBNThvtazne/lOB7CPtvecpIzmGt9fB3LrOs1K3ep7MbhNgf7HDgnmG8Or
	 mvrfmMo9VXnVsThGV6QMYE5xBw0NQrruFavOnZ9ecx5LzVBe2kN8I4d3NUjx2GSGxr
	 2f54A1L8lMV3Q==
Date: Mon, 3 Aug 2026 20:29:10 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Baul Lee <baul.lee@xbow.com>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    bentiss@kernel.org, federico.kirschbaum@xbow.com, stable@vger.kernel.org
Subject: Re: [PATCH] HID: core: fix OOB read of field->usage in
 hid_set_field()
In-Reply-To: <20260726065024.46088-1-baul.lee@xbow.com>
Message-ID: <510on277-p2p2-11p2-p30o-5914n0r8n221@xreary.bet>
References: <20260726065024.46088-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 26 Jul 2026, Baul Lee wrote:

> hid_set_field() hands field->usage + offset to hid_dump_input() before
> the guard that bounds offset:
> 
> 	hid_dump_input(field->report->device, field->usage + offset, value);
> 
> 	if (offset >= field->report_count) {
> 		hid_err(...);
> 		return -1;
> 	}
> 
> Under CONFIG_DEBUG_FS hid_dump_input() dereferences that pointer, with
> buf = hid_resolv_usage(usage->hid, NULL).  The usage[] array is
> allocated inline with the hid_field in hid_register_field() and holds
> field->maxusage entries, so an offset past it reads off the end of the
> kvzalloc()ed allocation and into a neighbouring object.  Had the guard
> run first, offset < report_count <= maxusage would already have confined
> the pointer to the array.
> 
> A caller supplies such an offset today.  picolcd_fb_send_tile()
> validates only report->maxfield before issuing
> hid_set_field(report->field[0], 11 + i, ...) for i = 0..31, so its
> offsets are fixed at 11..42 and are never checked against the bound
> field.  When the device registers that field with fewer usages, the
> framebuffer deferred-io work drives the read on every tile.  KASAN
> reports a 4-byte slab-out-of-bounds read in hid_dump_input() below
> hid_set_field(), and the same boot logs "offset (1) exceeds
> report_count (1)" from the guard that runs only afterwards.
> 
> Move the hid_dump_input() call below the guard.  Because
> field->maxusage >= field->report_count, the guard then establishes that
> field->usage + offset lies inside the array before it is dereferenced,
> for every caller and without changing behaviour on the valid path.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Good catch. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

