Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470149F123;
	Fri, 11 Sep 2026 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141916; cv=none; b=Tuqzx2xksQM5ChoDhCdfEY4dFC+CBs4pAU/aaHnzxl8SrRDQefhlUIT20cp0XOOn1OkRm2uJ1b0/YICDj1OHYb5tzlTbi/iB7utq1riOTZ6Rfc/Ac9nE7hVT7/07Cn/2a553b8FUsa6gfjgB+gPTyppf7Oe4iiOadO09zRlEIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141916; c=relaxed/simple;
	bh=AlEU66htQ9m20FtnUfEm+oOJRbf4BvUjW97ipsqjWIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jt0Y1KiTSpjSd3NRHYYwN6V1Z71ljo67QQ8WAVNO/n2KkawZFkzNx7nOEU1P7jOa7jwUMagpA3KS33lvgHXjwjn7y0c96y9gtJNXSg/chC0jgR6VSAFvA29Rb53UeoCgmWFXTRYzVoxgYqVK+heRkJ5C0ceoXD4G+853EPZGNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH+rCc89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH+rCc89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989D01F0089C;
	Fri, 11 Sep 2026 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789141913;
	bh=gi84yIc+2ctG0ooWqfeILX8NkbuR2E9JM1mV5F0R51k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=lH+rCc89veFbaKjm/pCeFTZ9waOVsWLQ80p2CnZAuIZ4JesCyIRWULmnHeugJ5MvO
	 oqtEULEtftxCzWp+pyIylxAsrC6HouxjYrGeyzg6Bn08BjW67SlcPoO3+vhwXBfDBh
	 +1TawV5L1qDCZE1379v3cZU2v7SZArTlfl0L0RSWjAAXNXo2+oNL6SdqpJ2W/ypfkO
	 Zt4CKT+zwGxnn/dtUGY8OPmMK1zAh8cPX/RZG6xWwHyjAc31QOvnalByel02evo3Ww
	 48BZrDRDecPqaaJnMswTRXA64LjXOQ52BE12clzmD309KNGFWz+G8d+OpA8MRcyAtd
	 mOtaUs3zsxTAw==
Date: Fri, 11 Sep 2026 17:51:50 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
In-Reply-To: <20260904105800.3923987-1-tristmd@gmail.com>
Message-ID: <0qs68srn-2s7o-5q57-66nr-9s2033r08877@xreary.bet>
References: <20260904105800.3923987-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Sep 2026, Tristan Madani wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> oxp_hid_remove() uses cancel_delayed_work() for all three delayed work
> items.  cancel_delayed_work() only dequeues a pending work item without
> waiting for a currently executing callback to finish.  If any of the
> work callbacks (oxp_rgb_queue_fn, oxp_btn_queue_fn, oxp_mcu_init_fn) is
> running at the time of removal, the callback continues executing
> concurrently with hid_hw_close() and hid_hw_stop(), accessing the HID
> device after it has been closed and stopped.
> 
> Use cancel_delayed_work_sync() instead to ensure that any in-progress
> work callback completes before device teardown proceeds.
> 
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

