Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7837C907;
	Wed, 15 Jul 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126878; cv=none; b=pynPXmbP+KVbOnvbB+s/wZFezd12/IRw0j6XYC4vNUQDMI976qed3dlF/mwM1KZvZGCkS3YCKIJ6z5P1sGZzLLSNGv+E/PwLF1K675WybZQnMiFYgQgAp/49qCrZXXonijXpdNJ3rQ8XqTRHwRJge/HL34vmJHlPygD1GRVBj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126878; c=relaxed/simple;
	bh=185bzfEB6j+AM6stTlIwtIJ/Xu1+XwSWz+ZbAC12Etw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bcndv1U+BbmDgLo+rQDYjXYhoFa7M/VAxRcfoBOC5JKLtAnOdKms9+g9RBixJ9aT4pX28EDiE1lAbfahZG9vfrhPagDiILwizDIic8fzHlvkkiczgthBJ5vIckYKvi9Jxx6Zujgh1bfWKjUXXBuYsrWXWyDlV9+RwCLmlvioSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tWb49m21; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tWb49m21"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 31C0F1FB1E;
	Wed, 15 Jul 2026 16:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784126874;
	bh=mxzc2sGl/d2O9yHWtjYmyMtlgVoT0LROxZa04f9Mxoc=; h=From:To:Subject;
	b=tWb49m21Y+Prj67sp424UriFLZpGBwu0xyuuK2XoFKE9kBMwFNY9MZgcTTaYRDlLU
	 fJn0QOPS1vaFBvUYSPmk4HtKRAkoi98hpEKFP6zzo6d+tAZRHawyNvrHRLSP2T4g8G
	 A69xIiq8ALrbS0ccTyoAW28bey1nySkIFjzRE6e0AO/cgjQCpFjqASpCgA3NLoqIcT
	 ZHEXAXqxpdkjbOcwvnseoU9BkMvG2DMEmSNe1DXLUsTBZDZTMFaK5fjreJ2VKfxUeP
	 XWjabrE14H9j+3xap+P3lw3zqdXOKmOI2qkZTBy/smGGa23vNtAzNWaV1YsG01NHF7
	 YpYQlXSpTN1eQ==
Date: Wed, 15 Jul 2026 16:47:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: bound the pairwise-cipher OUI walk to the
 IE length
Message-ID: <20260715144752.GF56330@francesco-nb>
References: <20260711071334.58307-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711071334.58307-1-doruk@0sec.ai>

On Sat, Jul 11, 2026 at 09:13:34AM +0200, Doruk Tan Ozturk wrote:
> mwifiex_search_oui_in_ie() reads the pairwise-cipher (PTK) count from a
> beacon/probe-response RSN or WPA information element:
> 
> 	count = iebody->ptk_cnt[0];
> 
> and then walks "count" 4-byte OUIs from the element, comparing each with
> memcmp(). The count byte comes straight from the (attacker-supplied) IE
> and is never checked against the element's own length. The callers admit
> the element on element_id alone (has_ieee_hdr() / has_vendor_hdr(), no
> length check), so a crafted RSN/WPA IE with a large pairwise count makes
> the walk read up to 255 * 4 bytes past the element -- an out-of-bounds
> read of the kmemdup()'d beacon buffer, reachable from any AP whose
> beacon/probe response is processed during scan result parsing.
> 
> Pass the number of available IE bytes to the walk and reject a count
> whose OUI list would not fit, keeping the loop within the element.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis; the
> unbounded count-driven walk is evident from source. Compile-tested.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  drivers/net/wireless/marvell/mwifiex/scan.c | 22 ++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index 97c0ec3b822e..3a55fc6f1b54 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -104,12 +104,21 @@ has_vendor_hdr(struct ieee_types_vendor_specific *ie, u8 key)
>   * a given oui in PTK.
>   */
>  static u8
> -mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui)
> +mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui, int ie_len)
>  {
>  	u8 count;
>  
> +	/* Need grp_key_oui[4] + ptk_cnt[2] before reading the OUI count. */
> +	if (ie_len < (int)offsetof(struct ie_body, ptk_body))

maybe define an intermediate variable to store `offsetof(struct ie_body, ptk_body)`
so that it is clear what this is, and you also can re-use it later?

Francesco

