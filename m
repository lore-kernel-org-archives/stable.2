Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4F38734A;
	Sun,  7 Jun 2026 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826074; cv=none; b=lctMABqML2yHNZlG95dxm91pTfz8YlCShR1m2QSZFohyDBv1VxVOq4WfUQ5w5ym4kdgDLtRnP1jZypp3KVy3juxlSMIiG/LrorIbeEjB2CoXx6c1Xx91JPOet1r7TCwcho5LjgtANC3LYjQuASolIonIus4nBoKTcBJspGtfkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826074; c=relaxed/simple;
	bh=rLzS8kVZIaLrxE7golOIyuypqsEka7TpVmWikthKQlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFvA5rxDLpBEHCdE8JDBYehYSnm/AfRTN7qx/pBnjopGiS3COAfMGhA/RvHOURKUUI6A0ptFqsDX4MsY/YQJb6HfFvAQO8cBerIdDesadFHsYfVGkEMJjAxQQuJ1vvhjAOzxOBs0Wd4nl3L27YPWetFQWi5yR2J1pyyDrS9s0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJp1uk0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJp1uk0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED021F00893;
	Sun,  7 Jun 2026 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826073;
	bh=z13/UNc27kjJOIZUWZbt7bi5IAGJ1TZgFynQ0tyy04I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YJp1uk0VkfN4UnvjgEac9t3OrHpM5RBCSrkWIy/xf5j0n4E4BZeNs/SsuTEJmBD9o
	 CLRKYBo//Qk7u4IxLlNgE2V0/Svj84B1YAvzNwFvdTaYALNAnQfzN9Oe8CnJYhH0Kd
	 jcacCC7kIT2E2DQUBvp7q9ANevZQKJJ5UwNV6otU=
Date: Sun, 7 Jun 2026 11:53:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: David Heidelberg <david+nfc@ixit.cz>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nci: add data_len bound checks to activation
 parameter extractors
Message-ID: <2026060725-husked-latter-8231@gregkh>
References: <20260607094822.322125-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607094822.322125-1-hexlabsecurity@proton.me>

On Sun, Jun 07, 2026 at 09:48:26AM +0000, Bryam Vargas wrote:
> nci_extract_activation_params_iso_dep() and
> nci_extract_activation_params_nfc_dep() read an inner length byte from
> the NCI RF_INTF_ACTIVATED_NTF payload and use it to memcpy() into fixed
> kernel buffers, but neither function receives the caller-validated
> activation_params_len.  A crafted NCI notification with
> activation_params_len=1 and an inner length byte of up to 20 (NFC-A) or
> 50 (NFC-B) causes memcpy() to read that many bytes past the one valid
> byte in the activation params region -- a slab out-of-bounds read of
> kernel memory adjacent to the NCI skb.
> 
> The sibling nci_extract_rf_params_*() family was given equivalent
> protection by commit 571dcbeb8e63 ("net: nfc: nci: Fix parameter
> validation for packet data"), but the two activation parameter
> extractors were not updated at that time.
> 
> Add a data_len parameter to both functions, guard against an empty
> region before consuming the inner length byte, decrement the remaining
> count after consuming it, and clamp the copy length to what is actually
> available.  Update both call sites to pass ntf.activation_params_len,
> which is already validated against the skb at ntf.c:801.
> 
> Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Verification (NFC-A ISO-DEP, NFC_ATS_MAXSIZE = 20):
> 
>   data_len  inner_len  without patch              with patch
>   --------  ---------  -------------------------  --------------------
>   1         0          rats_res_len=0, clean       same
>   1         1          memcpy +1B OOB              clamped to 0, clean
>   1         20         memcpy +20B OOB  <-- PoC   clamped to 0, clean
>   2         2          memcpy +1B OOB              clamped to 1, clean
>   21        20         memcpy 20B clean            same
> 
> NFC-B (attrib_res, max 50) and NFC-DEP poll/listen (atr_res/atr_req,
> max 62) have the same shape and receive the same fix.
> 
>  net/nfc/nci/ntf.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
