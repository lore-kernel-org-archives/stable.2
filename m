Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6D35A93C;
	Tue, 15 Sep 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481230; cv=none; b=IwsS1mCHPS86dbrhX2VSSORXUfVQrJfpSvWT+5lsuSY9xwdy5vAcN1TL69fr1ydJpQe8a/70AMKWcd1a1508QhXiWaDQyQUpsbmV+40VMMxlxkWDt87mKHEnx1MxwZ6ky/bsM/tM7xDHaWbJNzehePZ4OYNUBv0kfQeqUXs6T/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481230; c=relaxed/simple;
	bh=I40wY3GFOz1DkySg9G045B+2Ds/eVZ5D5aNVa2uapnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThQidw8+RIkDq8/B5XHRgM9d0v+zu8gKSUmu12VGO0VOz5AcCggVELRS3Yj9ldkY/EiFzHtI0mRoWbMsGhB5FGeJtJ5HcUwf+/6/UYwgMzooP6XotS8CjMh0FgnqKoKR/A0wMYw3hTKguFGC6946VkFpCOOqoFu80kFY6VJom8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFbPpyUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFbPpyUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57941F000FF;
	Tue, 15 Sep 2026 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789481229;
	bh=kUIpQJBe/rvVMC0HTZygXoU+NTwMte1oixn3by3XUZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lFbPpyUdcQhmGTF0C6P0i5iY5PeU+ELUljyxDW14y0XQGql121J6r4k9Y5Jd20elU
	 J1Eg7aUyMKeh/m1Qw0V1OFLmDmiOWTJBP954cVF7bYZzrRaROf9TaY+wfwOS6fLMjt
	 o+VzobJfm4TYmQpOQuilz5SzjwpAnqtESvpBgAoLalDPjDAIKw5eFf9wGN+nymkRPw
	 PfylP/pga28zsFOdyjUeqz05ErMc6DGRST1cmM7D6YQzq0Li9ZqxsgtrpgMN9UhOPw
	 fX77MqAcagyGwmh+f8lTGJd6UU/7TczJtQ8sz1RDBBYyrHGtINZLMsXuKyCCVGmTgC
	 ygNUh/fw1rKzg==
Date: Tue, 15 Sep 2026 16:07:04 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: markdamirkan@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: bpf: reject oversized device events before copying
Message-ID: <aqlGkhF3ntBnhEM5@beelink>
References: <20260913-b4-send-hid-bpf-event-bounds-v1-1-614fb56a0635@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913-b4-send-hid-bpf-event-bounds-v1-1-614fb56a0635@gmail.com>

Hi Mark,

Couple of comments:

On Sep 13 2026, Mark Amirkan via B4 Relay wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> HID-BPF allocates its device-event buffer from the largest report in the
> device's parsed report descriptor.  dispatch_hid_bpf_device_event() then
> copies the transport-provided report into that buffer before checking its
> size.
> 
> An input report larger than the allocated event buffer therefore causes
> a heap out-of-bounds write when a device-event program is attached.  The
> later check of the BPF program's return value cannot prevent the initial
> copy.
> 
> Reject reports that exceed either the transport buffer or the persistent
> HID-BPF event buffer before clearing or copying the data.
> 
> With a 64-byte event allocation, a same-file KUnit test produced a
> one-byte KASAN out-of-bounds write for a 65-byte report in three runs.
> The 64-byte boundary remained clean.  After this change, both cases were
> clean in three runs and the oversized report returned -EINVAL.  The test
> exercised the production dispatch function but not the complete UHID and
> BPF attachment path.

As mentioned by the bpf bot: if you already have tests, why not upstream
them? And even better: there are already selftests at
tools/testing/selftests/hid/hid_bpf.c -> why not add some more here as
well?

> 
> Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Symbolic
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> index 536f6d01fd..06ba833eb9 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -50,6 +50,9 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
>  	if (!hdev->bpf.device_data)
>  		return data;
>  
> +	if (*size > *buf_size || *size > ctx_kern.ctx.allocated_size)

I had a hard time figuring out why `*size > *buf_size` wasn't there in
the first place. You can call it overlooked, but:
- when the call chain of dispatch_hid_bpf_device_event() contains
	hid_input_report() -> *size == *buf_size
- when the call chain contains hid_safe_input_report(), the bufsize and
	size are forwarded from the lower transport drivers.

We only have 3 callers of hid_safe_input_report():
- uhid.c -> min_t(size_t, ev->u.input.size, UHID_DATA_MAX) is present
- i2c-hid-core.c -> size can'be greater than bufsize because it either
	truncate the input report when I2C_HID_QUIRK_BAD_INPUT_SIZE is set or
	plainly reject too long size
- usbhid/hid-core.c -> we rely on usb to set the size and the transfer
	buffer, so it should be OK

Regarding `*size > ctx_kern.ctx.allocated_size`:
- usbhid/i2c-hid: both are allocating their transfert buffer through the
	exact same call to hid_report_len() and finding the biggest of all reports
	-> so they are not affected
- uhid: here we don't control really what's going on, because size is a
	user provided parameter.

All in all: the first test is IMO probably redundant. Maybe we can just
add a comment in hid_safe_input_report() that the caller must ensure
`size <= bufsize`.

The second one matters only for the uhid case, so technically yes, we
can demonstrate a malicious OOB with uhid (but you should already be
root to create/controll a uhid device).

> +		return ERR_PTR(-EINVAL);

The whole point of hid-bpf is to fix bogus devices. So plainly returning
-EINVAL means we don't even let the user the chance to fix the device.

Later, hid_report_raw_event() has a similar check and when size is too
big, it would also break the processing but at least give a warning in
the dmesg.

So, how about we conditionally memcpy the size to min(*size,
allocated_size), and let the bpf change the size later on by itself ?
This should allow a HID-BPF program to amend the provided size on a
given device. This works because hid_bpf_get_data() doesn't know about
.size, but only .allocated_size, so the kernel will prevent a BPF to
access beyond the allocated_size.


TL;DR: please,
- make a decision regarding "*size > *buf_size"
- change memcpy(size) into memcpy(min(size, allocated_size))
- add tests in selftests

Cheers,
Benjamin

> +
>  	memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
>  	memcpy(ctx_kern.data, data, *size);
>  
> 
> ---
> base-commit: 9cdc7e6dc7a99ad7311ad5e7c145f2b9ce4e24b0
> change-id: 20260913-b4-send-hid-bpf-event-bounds-4d0e8170ceb4
> 
> Best regards,
> --  
> Mark Amirkan <markdamirkan@gmail.com>
> 
> 
> 
