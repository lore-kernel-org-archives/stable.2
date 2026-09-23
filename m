Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04739A7FD;
	Wed, 23 Sep 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179400; cv=none; b=u9ZPhvInkMPPHK+GJYvDqXA5nlfi3lMhEKbM5Sl8IFMYqFYi8xC08xGa+Br/BISzADuxW9VLwjqSeE48pYervu/h4EchfGgd+EnP44NdrJi9G6yZlvCdcyZeGCfegb8DVpVACKMwJoaWPQnVmmj+muJD0mLwyl38nLFatTdY2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179400; c=relaxed/simple;
	bh=FJA3eK3OkY9/WQjNlgCBfG4zZp5EDPpH+stPBygR6rg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ovptcTGqVTsNGG8mqIgYTiI3IcgIS3amxOwLOd3L/yT5XmcPRp7bmIv0k/jcUWb6CZb+japANw+zMM6aGqE84nAbwimnn6i2QKnAEAMyZwR7T83N2thXtkxgJTxKHeMo1kVjP8H/XH53sAJ4uyThtwwS5R8lLzAMip85qVRVNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERVJwWt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERVJwWt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B8A1F000FF;
	Wed, 23 Sep 2026 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179399;
	bh=Az2LBN6HVlrTIkNjXAxXv771joWtuOlu+vrOSCIUTww=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ERVJwWt3KIOq/DLgUZltP63Vw2ZtaIujbs8YyHph1I5UsVSGU+DNtH9GajKFpDiZ4
	 Kk7UY3b/nv+c8zldUX8yDhhmHE7sNaZcD1JUtlTszPb4tmxVAEDVUznUTBJvE0avVo
	 /EwwelAr639dGI/dxhEitVwUeYaQ0YjzyFQ90J5+R9Sgzb6hwNwHelOgSZGsaYQVXG
	 malzOzO/0eO6Z8Vb1kQW+ABZv0x9zEvnVczn63dLiscK71EMxhNHa2pv113awi/l/y
	 Evn/ETlrBS1jVHQ8QWc64O14F8mQRU3w5xe7pIlbgf9oPF3KXTlJ9CSlHHJs6wiQvl
	 XfxHOnhEHuxFw==
Date: Wed, 23 Sep 2026 18:03:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: bpf: cast size to ssize_t when checking
 hid_bpf_hw_request
In-Reply-To: <20260915-wip-bpf-signed_size-v1-1-6bc8f3d09f5b@kernel.org>
Message-ID: <319r6712-1741-746s-s588-349446281qro@xreary.bet>
References: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org> <20260915-wip-bpf-signed_size-v1-1-6bc8f3d09f5b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 15 Sep 2026, Benjamin Tissoires wrote:

> As reported by Sashiko:
> If a transport driver encounters a hardware error and returns a negative
> error code such as -EPIPE, ret is implicitly promoted to size_t when
> compared against size. This causes the negative error code to evaluate
> as a large positive number, making the (ret > size) condition true.
> 
> This silently converts the hardware error into a success return value
> and copies the unmodified buffer back, which could leave BPF programs
> operating on uninitialized or stale data.
> 
> Fix this by casting size into ssize_t to return the actual negative
> error code.
> 
> Link: https://lore.kernel.org/all/20260904130354.A79471F00A3D@smtp.kernel.org/
> Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs

